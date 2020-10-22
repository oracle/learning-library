package com.dom.benchmarking.swingbench.plsqltransactions;


import com.dom.benchmarking.swingbench.event.JdbcTaskEvent;
import com.dom.benchmarking.swingbench.kernel.SwingBenchException;
import com.dom.benchmarking.swingbench.kernel.SwingBenchTask;
import com.dom.benchmarking.swingbench.utilities.RandomGenerator;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import java.util.Map;
import java.util.logging.Logger;

import oracle.jdbc.OracleTypes;


public class WarehouseActivityQuery extends OrderEntryProcess {
    private static final Logger logger = Logger.getLogger(WarehouseActivityQuery.class.getName());

    public WarehouseActivityQuery() {
        super();
    }

    public void init(Map params) {
    }

    public void execute(Map params) throws SwingBenchException {

        Connection connection = (Connection) params.get(SwingBenchTask.JDBC_CONNECTION);
        initJdbcTask();

        int warehouseID = RandomGenerator.randomInteger(1, 1000);

        long executeStart = System.nanoTime();
        int[] dmlArray = null;
        boolean sucessfulTransaction = true;

        try {
            try (CallableStatement cs = connection.prepareCall("{? = call orderentry.WarehouseActivityQuery(?,?,?)}")) {
                cs.registerOutParameter(1, OracleTypes.VARCHAR);
                cs.setInt(2, warehouseID);
                cs.setInt(3, (int) this.getMinSleepTime());
                cs.setInt(4, (int) this.getMaxSleepTime());
                cs.executeUpdate();
                dmlArray = parseInfoArray(cs.getString(1));
                if (dmlArray[ROLLBACK_STATEMENTS] != 0)
                    sucessfulTransaction = false;
                cs.close();
            } catch (SQLException se) {
                logger.fine(String.format("Exception when calling store procedure orderentry.WarehouseActivityQuery in database : %s", se));
                throw new SwingBenchException(se);
            } catch (Exception e) {
                throw new SwingBenchException(e.getMessage());
            }

            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), sucessfulTransaction, getInfoArray()));
        } catch (SwingBenchException sbe) {
            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), sucessfulTransaction, getInfoArray()));
            throw new SwingBenchException(sbe.getMessage());
        }
    }

    public void close() {
    }
}
