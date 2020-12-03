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


public class TopSalesWithinWeek extends SalesHistory {
    private static final Logger logger = Logger.getLogger(TopSalesWithinWeek.class.getName());

    public TopSalesWithinWeek() {
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
            OracleUtilities.setModuleInfo(connection, "TopSalesWithinWeek");
            String quarter = getRandomStringData(1, 2, getWeeks(), "'");
            Statement st = connection.createStatement();
            String sql =
                    "SELECT *\n" +
                            "FROM\n" +
                            "  (SELECT times.Calendar_Week_Number,\n" +
                            "     customers.cust_first_name,\n" +
                            "     customers.cust_last_name,\n" +
                            "     customers.cust_id,\n" +
                            "     SUM(sales.amount_sold),\n" +
                            "     rank() over(PARTITION BY times.Calendar_Week_Number\n" +
                            "   ORDER BY SUM(amount_sold) DESC) AS\n" +
                            "  rank_within_week\n" +
                            "   FROM sales,\n" +
                            "     customers,\n" +
                            "     times\n" +
                            "   WHERE sales.cust_id = customers.cust_id\n" +
                            "   AND times.calendar_week_number = " + getRandomStringData(1, 2, getWeeks(), "'") + " \n" +
                            "   AND times.calendar_year = " + getRandomStringData(1, 2, getYears(), "'") + " \n" +
                            "   AND times.time_id = sales.time_id\n" +
                            "   GROUP BY customers.cust_id,\n" +
                            "     customers.cust_first_name,\n" +
                            "     customers.cust_last_name,\n" +
                            "     customers.cust_id,\n" +
                            "     times.Calendar_Week_Number)\n" +
                            "WHERE rank_within_week < 16";
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
