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


public class SalesCubeByMonth extends SalesHistory {
    private static final Logger logger = Logger.getLogger(SalesCubeByMonth.class.getName());

    public SalesCubeByMonth() {
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
            OracleUtilities.setModuleInfo(connection, "SalesCubeByMonth");
            Statement st = connection.createStatement();
            String sql =
                    "SELECT channel_desc, calendar_month_desc, countries.country_iso_code,\n" +
                            "      TO_CHAR(SUM(amount_sold), '9,999,999,999') SALES$\n" +
                            "FROM sales, customers, times, channels, countries\n" +
                            "WHERE sales.time_id=times.time_id AND sales.cust_id=customers.cust_id AND\n" +
                            "  sales.channel_id= channels.channel_id\n" +
                            " AND customers.country_id = countries.country_id\n" +
                            " AND channels.channel_desc IN\n" +
                            "  (" + getRandomStringData(1, 3, getChannels(), "'") + ") AND times.calendar_month_desc IN\n" +
                            "  (" + getRandomStringData(2, 6, getMonths(), "'") + ") AND countries.country_iso_code IN (" + getRandomStringData(1, 4, getCountries(), "'") + ")\n" +
                            "GROUP BY CUBE(channel_desc, calendar_month_desc, countries.country_iso_code)";
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
