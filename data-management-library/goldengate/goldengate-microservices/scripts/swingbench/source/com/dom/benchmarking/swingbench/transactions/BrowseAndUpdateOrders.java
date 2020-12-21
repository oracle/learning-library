package com.dom.benchmarking.swingbench.transactions;


import com.dom.benchmarking.swingbench.event.JdbcTaskEvent;
import com.dom.benchmarking.swingbench.kernel.SwingBenchException;
import com.dom.benchmarking.swingbench.kernel.SwingBenchTask;
import com.dom.benchmarking.swingbench.utilities.RandomGenerator;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;


public class BrowseAndUpdateOrders extends OrderEntryProcess {
    private static final Logger logger = Logger.getLogger(BrowseAndUpdateOrders.class.getName());
    private PreparedStatement liPs = null;
    private PreparedStatement upPs = null;
    private PreparedStatement upPs2 = null;

    public BrowseAndUpdateOrders() {
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
        long custID = RandomGenerator.randomLong(MIN_CUSTID, MAX_CUSTID);
        ResultSet rs = null;
        initJdbcTask();

        long executeStart = System.nanoTime();

        try {
            try {
                logon(connection, custID);
                addInsertStatements(1);
                addCommitStatements(1);
                getCustomerDetails(connection, custID);
                getAddressDetails(connection, custID);
                List<Long> orders = getOrdersByCustomer(connection, custID);
                addSelectStatements(3);
                if (orders.size() > 0) {
                    Long selectedOrder = orders.get(RandomGenerator.randomInteger(0, orders.size()));
                    liPs = connection.prepareStatement(
                            "select   ORDER_ID,           \n" +
                                    "        LINE_ITEM_ID,           \n" +
                                    "        PRODUCT_ID,           \n" +
                                    "        UNIT_PRICE,           \n" +
                                    "        QUANTITY,DISPATCH_DATE,     \n" +
                                    "        RETURN_DATE,     \n" +
                                    "        GIFT_WRAP,     \n" +
                                    "        CONDITION,     \n" +
                                    "        SUPPLIER_ID,     \n" +
                                    "        ESTIMATED_DELIVERY           \n" +
                                    "      from order_items           \n" +
                                    "      where order_id = ?           \n" +
                                    "      and rownum < 5");
                    liPs.setLong(1, selectedOrder);
                    rs = liPs.executeQuery();
                    addSelectStatements(1);
                    if (rs.next()) {
                        Long lit = rs.getLong(2);
                        Float up = rs.getFloat(4);
                        upPs = connection.prepareStatement(
                                "update order_items           \n" +
                                        "        set quantity = quantity + 1           \n" +
                                        "        where order_items.ORDER_Id = ?           \n" +
                                        "        and order_items.LINE_ITEM_ID = ?");
                        upPs.setLong(1, selectedOrder);
                        upPs.setLong(2, lit);
                        upPs.executeUpdate();
                        upPs2 = connection.prepareStatement(
                                "update orders           \n" +
                                        "        set order_total = order_total + ?           \n" +
                                        "        where order_Id = ?");
                        upPs2.setFloat(1, up);
                        upPs2.setLong(2, selectedOrder);
                        addUpdateStatements(2);
                        connection.commit();
                        addCommitStatements(1);
                    }
                }
                addSelectStatements(1);
            } catch (SQLException se) {
                throw new SwingBenchException(se.getMessage());
            } finally {
                hardClose(rs);
                hardClose(liPs);
                hardClose(upPs);
                hardClose(upPs2);
            }

            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), true, getInfoArray()));
        } catch (SwingBenchException sbe) {
            try {
                addRollbackStatements(1);
                connection.rollback();
            } catch (SQLException er) {
                logger.log(Level.INFO, "Unable to rollback transaction");
            }
            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), false, getInfoArray()));
            throw new SwingBenchException(sbe.getMessage());
        }
    }

    public void close() {
    }
}
