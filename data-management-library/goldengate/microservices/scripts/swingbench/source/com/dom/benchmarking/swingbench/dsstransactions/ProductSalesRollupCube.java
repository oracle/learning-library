package com.dom.benchmarking.swingbench.dsstransactions;


import com.dom.benchmarking.swingbench.event.JdbcTaskEvent;
import com.dom.benchmarking.swingbench.kernel.SwingBenchException;
import com.dom.benchmarking.swingbench.kernel.SwingBenchTask;
import com.dom.util.OracleUtilities;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;


public class ProductSalesRollupCube extends SalesHistory {
    private static final Logger logger = Logger.getLogger(ProductSalesRollupCube.class.getName());

    public ProductSalesRollupCube() {
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
            OracleUtilities.setModuleInfo(connection, "ProductSalesRollupCube");
            Statement st = connection.createStatement();
            String sql =
                    "SELECT calendar_year, calendar_quarter_number,\n" +
                            "    calendar_month_number, SUM(amount_sold)\n" +
                            "FROM sales, times, products, customers, countries\n" +
                            "WHERE sales.time_id=times.time_id \n" +
                            "  AND sales.prod_id=products.prod_id \n" +
                            "  AND customers.country_id = countries.country_id \n" +
                            "  AND sales.cust_id=customers.cust_id \n" +
                            "  AND prod_name IN (" + getRandomStringData(1, 3, getProducts(), "'") + ") \n" +
                            "  AND country_iso_code = " + getRandomStringData(1, 2, getCountries(), "'") + " AND calendar_year=" + getRandomStringData(1, 2, getYears(), null) + " \n" +
                            "GROUP BY ROLLUP(calendar_year, calendar_quarter_number, calendar_month_number)";
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
