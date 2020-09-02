package com.dom.benchmarking.swingbench.plsqltransactions;


import com.dom.benchmarking.swingbench.event.JdbcTaskEvent;
import com.dom.benchmarking.swingbench.kernel.SwingBenchException;
import com.dom.benchmarking.swingbench.kernel.SwingBenchTask;
import com.dom.benchmarking.swingbench.utilities.RandomGenerator;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import oracle.jdbc.OracleTypes;


public class ProcessOrders extends OrderEntryProcess {

    private static final Logger logger = Logger.getLogger(ProcessOrders.class.getName());

    public ProcessOrders() {
    }

    public void close() {
    }

    public void init(Map params) {
        Connection connection = (Connection) params.get(SwingBenchTask.JDBC_CONNECTION);
        Boolean commitClientSide = Boolean.parseBoolean((String) params.get(SwingBenchTask.COMMIT_CLIENT_SIDE));
        try {
            this.setCommitClientSide(connection, commitClientSide);
        } catch (SQLException se) {
            logger.log(Level.SEVERE, "Unable to set commit location", se);
        }
    }

    public void execute(Map params) throws SwingBenchException {
        Connection connection = (Connection) params.get(SwingBenchTask.JDBC_CONNECTION);
        int queryTimeOut = 60;

        if (params.get(SwingBenchTask.QUERY_TIMEOUT) != null) {
            queryTimeOut = ((Integer) (params.get(SwingBenchTask.QUERY_TIMEOUT))).intValue();
        }

        long executeStart = System.nanoTime();
        int[] infoArray = null;
        boolean sucessfulTransaction = true;

        try {
            CallableStatement cs = null;
            try {
                cs = connection.prepareCall("{? = call orderentry.processorders(?,?,?)}");
                cs.registerOutParameter(1, OracleTypes.VARCHAR);
                cs.setInt(2, (int) RandomGenerator.randomInteger(MIN_WAREHOUSE_ID, MAX_WAREHOUSE_ID));
                cs.setInt(3, (int) this.getMinSleepTime());
                cs.setInt(4, (int) this.getMaxSleepTime());

                cs.setQueryTimeout(queryTimeOut);
                cs.executeUpdate();
                infoArray = parseInfoArray(cs.getString(1));
                if (infoArray[ROLLBACK_STATEMENTS] != 0)
                    sucessfulTransaction = false;
                cs.close();
                this.commit(connection);
            } catch (SQLException se) {
                //throw new SwingBenchException(se.getMessage());
                try {
                    cs.close();
                } catch (Exception e) {
                }
                throw new SwingBenchException(se);
            } catch (Exception e) {
                throw new SwingBenchException(e.getMessage());
            }

            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), sucessfulTransaction, infoArray));
        } catch (SwingBenchException ex) {
            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), sucessfulTransaction, infoArray));
            throw new SwingBenchException(ex);
        }
    }

}
