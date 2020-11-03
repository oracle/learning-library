package com.dom.benchmarking.swingbench.dsstransactions;


import com.dom.benchmarking.swingbench.event.JdbcTaskEvent;
import com.dom.benchmarking.swingbench.kernel.SwingBenchException;
import com.dom.benchmarking.swingbench.kernel.SwingBenchTask;
import com.dom.benchmarking.swingbench.utilities.RandomGenerator;
import com.dom.util.OracleUtilities;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;


public class PeriodToPeriodComparison extends SalesHistory {
    private static final Logger logger = Logger.getLogger(PeriodToPeriodComparison.class.getName());

    public PeriodToPeriodComparison() {
    }

    public void init(Map param) throws SwingBenchException {
        try {
            if (!isDataCached()) {
                synchronized (lock) {
                    if (!isDataCached()) {
                        Connection connection = (Connection) param.get(SwingBenchTask.JDBC_CONNECTION);
                        cacheData(connection);
                    }
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Failed to cache data with the following exception : ", e);
            throw new SwingBenchException(e);
        }
    }

    public void execute(Map param) throws SwingBenchException {
        Connection connection = (Connection) param.get(SwingBenchTask.JDBC_CONNECTION);
        initJdbcTask();
        long executeStart = System.nanoTime();
        try {
            OracleUtilities.setModuleInfo(connection, "PeriodToPeriodComparison");
            Statement st = connection.createStatement();
            String yearRange = getRandomStringData(2, 3, getYears(), null);
            String lastYear = yearRange.substring(yearRange.indexOf(",") + 1, yearRange.length());
            int minWeek = RandomGenerator.randomInteger(1, 48);
            int maxWeek = minWeek + 4;
            String selectedProduct = getRandomStringData(1, 2, getProducts(), "'");

            String sql =
                    "WITH v AS\n" +
                            "  (SELECT p.Prod_Name Product_Name,\n" +
                            "    t.Calendar_Year YEAR,\n" +
                            "    t.Calendar_Week_Number Week,\n" +
                            "    SUM(Amount_Sold) Sales\n" +
                            "  FROM Sales s,\n" +
                            "    Times t,\n" +
                            "    Products p\n" +
                            "  WHERE s.Time_id      = t.Time_id\n" +
                            "  AND s.Prod_id        = p.Prod_id\n" +
                            "  AND p.Prod_name     IN (" + selectedProduct + ")\n" +
                            "  and T.CALENDAR_YEAR IN (" + yearRange + ")\n" +
                            "  AND t.Calendar_Week_Number BETWEEN " + minWeek + " AND  " + maxWeek + "\n" +
                            "  GROUP BY p.Prod_Name,\n" +
                            "    t.Calendar_Year,\n" +
                            "    t.Calendar_Week_Number\n" +
                            "  )\n" +
                            "SELECT Product_Name Prod,\n" +
                            "  YEAR,\n" +
                            "  Week,\n" +
                            "  Sales,\n" +
                            "  Weekly_ytd_sales,\n" +
                            "  Weekly_ytd_sales_prior_year\n" +
                            "FROM\n" +
                            "  (SELECT --Start of year_over_year sales\n" +
                            "    Product_Name,\n" +
                            "    YEAR,\n" +
                            "    Week,\n" +
                            "    Sales,\n" +
                            "    Weekly_ytd_sales,\n" +
                            "    LAG(Weekly_ytd_sales, 1) OVER (PARTITION BY Product_Name, Week ORDER BY YEAR) Weekly_ytd_sales_prior_year\n" +
                            "  FROM\n" +
                            "    (SELECT -- Start of dense_sales\n" +
                            "      v.Product_Name Product_Name,\n" +
                            "      t.Year YEAR,\n" +
                            "      t.Week Week,\n" +
                            "      NVL(v.Sales,0) Sales,\n" +
                            "      SUM(NVL(v.Sales,0)) OVER (PARTITION BY v.Product_Name, t.Year ORDER BY t.week) weekly_ytd_sales\n" +
                            "    FROM v PARTITION BY (v.Product_Name)\n" +
                            "    RIGHT OUTER JOIN\n" +
                            "      (SELECT DISTINCT Calendar_Week_Number Week,\n" +
                            "        Calendar_Year YEAR\n" +
                            "      FROM Times\n" +
                            "      WHERE Calendar_Year IN (" + yearRange + ")\n" +
                            "      ) t\n" +
                            "    ON (v.week = t.week\n" +
                            "    AND v.Year = t.Year)\n" +
                            "    ) dense_sales\n" +
                            "  ) year_over_year_sales\n" +
                            "where year = " + lastYear + "\n" +
                            "AND WEEK BETWEEN " + minWeek + " AND  " + maxWeek + "\n" +
                            "ORDER BY 1,2,3";
            logger.finest(sql);
            ResultSet rs = st.executeQuery(sql);
            rs.next();
            rs.close();
            st.close();
            addSelectStatements(1);
            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), true, getInfoArray()));
        } catch (SQLException ex) {
            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), false, getInfoArray()));
            throw new SwingBenchException(ex);
        }
    }

    public void close() {
    }
}
