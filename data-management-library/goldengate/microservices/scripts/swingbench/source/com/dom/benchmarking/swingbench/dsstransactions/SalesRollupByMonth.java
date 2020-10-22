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


public class SalesRollupByMonth extends SalesHistory {

    private static final Logger logger = Logger.getLogger(SalesRollupByMonth.class.getName());

    public SalesRollupByMonth() {
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
            OracleUtilities.setModuleInfo(connection, "SalesRollupByMonth");
            Statement st = connection.createStatement();
            String sql =
                    "SELECT channels.channel_desc, calendar_month_desc, \n" +
                            "       countries.country_iso_code,\n" +
                            "       TO_CHAR(SUM(amount_sold), '9,999,999,999') SALES$\n" +
                            "FROM sales, customers, times, channels, countries\n" +
                            "WHERE sales.time_id=times.time_id \n" +
                            "  AND sales.cust_id=customers.cust_id \n" +
                            "  AND customers.country_id = countries.country_id\n" +
                            "  AND sales.channel_id = channels.channel_id \n" +
                            "  AND channels.channel_desc IN (" + getRandomStringData(1, 3, getChannels(), "'") + ") \n" +
                            "  AND times.calendar_month_desc IN (" + getRandomStringData(2, 6, getMonths(), "'") + ") \n" +
                            "  AND countries.country_iso_code IN (" + getRandomStringData(1, 4, getCountries(), "'") + ")\n" +
                            "GROUP BY \n" +
                            "  ROLLUP(channels.channel_desc, calendar_month_desc, countries.country_iso_code)";
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
