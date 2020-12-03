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


public class SalesByWeekCountry extends SalesHistory {

    private static final Logger logger = Logger.getLogger(SalesByWeekCountry.class.getName());

    public SalesByWeekCountry() {
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
            OracleUtilities.setModuleInfo(connection, "SalesByWeekCountry");
            String week = getRandomStringData(1, 2, getWeeks(), null);
            String country = getRandomStringData(1, 2, getCountries(), null);
            Statement st = connection.createStatement();
            String sql =
                    "SELECT SUM(amount_sold),\n" +
                            "  t.calendar_year, \n" +
                            "  t.calendar_week_number,\n" +
                            "  c.country_name\n" +
                            "FROM sales s,\n" +
                            "  times t,\n" +
                            "  countries c,\n" +
                            "  customers cu\n" +
                            "WHERE s.time_id        = t.time_id\n" +
                            "AND t.calendar_week_number = '" + week + "'\n" +
                            "AND t.calendar_year = " + getRandomStringData(1, 2, getYears(), "'") + " \n" +
                            "AND cu.country_id      = c.country_id\n" +
                            "AND s.cust_id          = cu.cust_id\n" +
                            "AND c.country_iso_code = '" + country + "'\n" +
                            "group by t.calendar_year, t.calendar_week_number,\n" +
                            "c.country_name";
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
