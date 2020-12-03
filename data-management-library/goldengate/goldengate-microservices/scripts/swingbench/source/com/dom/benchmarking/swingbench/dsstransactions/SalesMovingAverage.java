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


public class SalesMovingAverage extends SalesHistory {
    private static final Logger logger = Logger.getLogger(SalesMovingAverage.class.getName());

    public SalesMovingAverage() {
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
            OracleUtilities.setModuleInfo(connection, "SalesMovingAverage");
            Statement st = connection.createStatement();
            String sql =
                    "SELECT t.time_id,\n" +
                            "  to_char(SUM(amount_sold),   '9,999,999,999') AS sales,\n" +
                            "  to_char(AVG(SUM(amount_sold)) over(ORDER BY t.time_id range BETWEEN INTERVAL '2' DAY preceding AND INTERVAL '2' DAY following),   '9,999,999,999') AS\n" +
                            "centered_5_day_avg\n" +
                            "FROM sales s,\n" +
                            "  times t\n" +
                            "WHERE t.calendar_month_desc IN(" + getRandomStringData(2, 5, getMonths(), "'") + ")\n" +
                            " AND s.time_id = t.time_id\n" +
                            "GROUP BY t.time_id\n" +
                            "ORDER BY t.time_id";
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
