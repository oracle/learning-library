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


public class BrowseProducts extends OrderEntryProcess {
    private static final Logger logger = Logger.getLogger(BrowseProducts.class.getName());

    public BrowseProducts() {
    }

    public void init(Map<String, Object> params) throws SwingBenchException {

        Connection connection = (Connection) params.get(SwingBenchTask.JDBC_CONNECTION);
        Boolean commitClientSide = Boolean.parseBoolean((String) params.get(SwingBenchTask.COMMIT_CLIENT_SIDE));
        try {
            this.setCommitClientSide(connection, commitClientSide);
            this.getMaxandMinCustID(connection, params);
        } catch (SQLException se) {
            logger.log(Level.SEVERE, "Unable to get max and min customer id", se);
        }
    }

    public void execute(Map<String, Object> params) throws SwingBenchException {
        Connection connection = (Connection) params.get(SwingBenchTask.JDBC_CONNECTION);

        int queryTimeOut = 60;

        if (params.get(SwingBenchTask.QUERY_TIMEOUT) != null) {
            queryTimeOut = ((Integer) (params.get(SwingBenchTask.QUERY_TIMEOUT))).intValue();
        }

        long executeStart = System.nanoTime();
        int[] dmlArray = null;
        boolean sucessfulTransaction = true;

        try {

            long start = System.nanoTime();
            CallableStatement cs = null;
            try {

                cs = connection.prepareCall("{? = call orderentry.browseproducts(?,?,?)}");
                cs.registerOutParameter(1, OracleTypes.VARCHAR);
                cs.setLong(2, RandomGenerator.randomLong(MIN_CUSTID, MAX_CUSTID));
                cs.setInt(3, (int) this.getMinSleepTime());
                cs.setInt(4, (int) this.getMaxSleepTime());
                cs.setQueryTimeout(queryTimeOut);
                cs.executeUpdate();
                dmlArray = parseInfoArray(cs.getString(1));
                if (dmlArray[ROLLBACK_STATEMENTS] != 0)
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

            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), sucessfulTransaction, dmlArray));
        } catch (SwingBenchException ex) {
            sucessfulTransaction = false;
            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), sucessfulTransaction, dmlArray));
            throw new SwingBenchException(ex);
        }
    }

    public void close() {
    }
}
