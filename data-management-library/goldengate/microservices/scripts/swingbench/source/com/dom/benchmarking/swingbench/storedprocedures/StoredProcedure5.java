package com.dom.benchmarking.swingbench.storedprocedures;


import com.dom.benchmarking.swingbench.event.JdbcTaskEvent;
import com.dom.benchmarking.swingbench.kernel.DatabaseTransaction;
import com.dom.benchmarking.swingbench.kernel.SwingBenchException;
import com.dom.benchmarking.swingbench.kernel.SwingBenchTask;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import java.util.Arrays;
import java.util.Map;

import oracle.jdbc.OracleTypes;


public class StoredProcedure5 extends DatabaseTransaction {
    public StoredProcedure5() {
    }

    public void close() {
    }

    public void init(Map params) {
    }

    public void execute(Map params) throws SwingBenchException {
        Connection connection = (Connection) params.get(SwingBenchTask.JDBC_CONNECTION);
        int queryTimeOut = 60;

        if (params.get(SwingBenchTask.QUERY_TIMEOUT) != null) {
            queryTimeOut = ((Integer) (params.get(SwingBenchTask.QUERY_TIMEOUT))).intValue();
        }

        long executeStart = System.nanoTime();
        int[] dmlArray = null;

        try {
            long start = System.nanoTime();

            try {
                CallableStatement cs = connection.prepareCall("{? = call swingbench.storedprocedure5(?,?)}");
                cs.registerOutParameter(1, OracleTypes.ARRAY, "INTEGER_RETURN_ARRAY");
                cs.setInt(2, (int) this.getMinSleepTime());
                cs.setInt(3, (int) this.getMaxSleepTime());
                cs.setQueryTimeout(queryTimeOut);
                cs.executeUpdate();
                BigDecimal[] dmlArrayResult = (BigDecimal[]) cs.getArray(1).getArray();
                // Oddly the array is an array of BigDecimals. Expected int[].
                dmlArray = Arrays.stream(dmlArrayResult).map(d -> d.intValueExact()).mapToInt(i -> i).toArray();
                cs.close();
            } catch (SQLException se) {
                throw new SwingBenchException(se.getMessage());
            }

            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), true, dmlArray));
        } catch (SwingBenchException ex) {
            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), false, dmlArray));
            throw new SwingBenchException(ex);
        } finally {
        }
    }
}
