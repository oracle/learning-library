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


public class NewOrderProcess extends OrderEntryProcess {
    private static final Logger logger = Logger.getLogger(NewOrderProcess.class.getName());

    public NewOrderProcess() {
    }

    public void init(Map params) throws SwingBenchException {
        Connection connection = (Connection) params.get(SwingBenchTask.JDBC_CONNECTION);
        String param = (String) params.get("SOE_IS_STATIC");
        boolean isStatic = (param != null) ? Boolean.valueOf(param) : false;
        Boolean commitClientSide = Boolean.parseBoolean((String) params.get(SwingBenchTask.COMMIT_CLIENT_SIDE));
        try {
            this.setCommitClientSide(connection, commitClientSide);
            this.setIsStatic(isStatic, connection);
        } catch (SQLException se) {
            logger.log(Level.SEVERE, "Unable to get max and min customer id", se);
        }
    }

    public void execute(Map params) throws SwingBenchException {
        Connection connection = (Connection) params.get(SwingBenchTask.JDBC_CONNECTION);
        int queryTimeOut = 60;

        if (params.get(SwingBenchTask.QUERY_TIMEOUT) != null) {
            queryTimeOut = ((Integer) (params.get(SwingBenchTask.QUERY_TIMEOUT))).intValue();
        }

        long executeStart = System.nanoTime();
        long recordedTime = 0;
        int[] infoArray = null;
        boolean sucessfulTransaction = true;

        try {
            CallableStatement cs = null;
            try {
                cs = connection.prepareCall("{? = call orderentry.neworder(?,?,?)}");
                cs.registerOutParameter(1, OracleTypes.VARCHAR);
                cs.setLong(2, RandomGenerator.randomLong(MIN_CUSTID, MAX_CUSTID));
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
                try {
                    cs.close();
                } catch (Exception e) {
                }
                throw new SwingBenchException(se);
                //throw new SwingBenchException(se.getMessage());
            } catch (Exception e) {
                throw new SwingBenchException(e.getMessage());
            }

            recordedTime = System.nanoTime() - executeStart;
            processTransactionEvent(new JdbcTaskEvent(this, getId(), recordedTime, sucessfulTransaction, infoArray));
        } catch (SwingBenchException ex) {
            recordedTime = System.nanoTime() - executeStart;
            processTransactionEvent(new JdbcTaskEvent(this, getId(), recordedTime, sucessfulTransaction, infoArray));
            throw new SwingBenchException(ex);
        }
    }

    public void close() {
    }
}
