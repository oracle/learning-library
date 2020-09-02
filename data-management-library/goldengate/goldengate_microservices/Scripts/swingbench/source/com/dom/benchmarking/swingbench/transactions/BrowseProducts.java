package com.dom.benchmarking.swingbench.transactions;


import com.dom.benchmarking.swingbench.event.JdbcTaskEvent;
import com.dom.benchmarking.swingbench.kernel.SwingBenchException;
import com.dom.benchmarking.swingbench.kernel.SwingBenchTask;
import com.dom.benchmarking.swingbench.utilities.RandomGenerator;

import java.sql.Connection;
import java.sql.SQLException;

import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;


public class BrowseProducts extends OrderEntryProcess {
    private static final Logger logger = Logger.getLogger(com.dom.benchmarking.swingbench.plsqltransactions.BrowseProducts.class.getName());
    private long custID = 0;

    public BrowseProducts() {
    }

    public void init(Map params) {
        Connection connection = (Connection) params.get(SwingBenchTask.JDBC_CONNECTION);
        try {
            this.getMaxandMinCustID(connection, params);
        } catch (SQLException se) {
            logger.log(Level.SEVERE, "Unable to get max and min customer id", se);
        }
    }

    public void execute(Map params) throws SwingBenchException {

        Connection connection = (Connection) params.get(SwingBenchTask.JDBC_CONNECTION);
        initJdbcTask();

        long executeStart = System.nanoTime();

        try {
            try {
                custID = RandomGenerator.randomLong(MIN_CUSTID, MAX_CUSTID);
                logon(connection, custID);
                addInsertStatements(1);
                addCommitStatements(1);
                getCustomerDetails(connection, custID);
                addSelectStatements(1);
                thinkSleep();

                int numOfBrowseCategorys = RandomGenerator.randomInteger(1, MAX_BROWSE_CATEGORY);

                for (int i = 0; i < numOfBrowseCategorys; i++) {
                    getProductDetailsByID(connection, RandomGenerator.randomInteger(MIN_PROD_ID, MAX_PROD_ID));
                    addSelectStatements(1);
                    thinkSleep();
                }


            } catch (SQLException se) {
                se.printStackTrace();
                throw new SwingBenchException(se.getMessage());
            }

            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), true, getInfoArray()));
        } catch (SwingBenchException sbe) {
            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), false, getInfoArray()));
            throw new SwingBenchException(sbe.getMessage());
        }
    }

    public void close() {
    }
}
