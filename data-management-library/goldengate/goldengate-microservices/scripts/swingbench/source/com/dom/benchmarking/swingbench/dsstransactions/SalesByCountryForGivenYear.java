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


public class SalesByCountryForGivenYear extends SalesHistory {

    private static final Logger logger = Logger.getLogger(SalesByCountryForGivenYear.class.getName());

    public SalesByCountryForGivenYear() {
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
            OracleUtilities.setModuleInfo(connection, "SalesByCountryForGivenYear");
            Statement st = connection.createStatement();
            String sql =
                    "SELECT SUM(s.quantity_sold* p.prod_list_price),\n" +
                            "  co.country_name,\n" +
                            "  t.calendar_year\n" +
                            "FROM sales s,\n" +
                            "  customers cu,\n" +
                            "  countries co,\n" +
                            "  products p,\n" +
                            "  times t\n" +
                            "WHERE s.cust_id   = cu.cust_id\n" +
                            "and s.prod_id = p.prod_id\n" +
                            "AND cu.country_id = co.country_id\n" +
                            "AND s.time_id     = t.time_id\n" +
                            "and t.calendar_year = " + getRandomStringData(1, 2, getYears(), null) + "\n" +
                            " GROUP BY co.country_name,\n" +
                            "  t.calendar_year\n" +
                            "ORDER BY t.calendar_year";
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
