package com.dom.benchmarking.swingbench.transactions;


import com.dom.benchmarking.swingbench.event.JdbcTaskEvent;
import com.dom.benchmarking.swingbench.kernel.SwingBenchException;
import com.dom.benchmarking.swingbench.kernel.SwingBenchTask;
import com.dom.benchmarking.swingbench.utilities.RandomGenerator;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;


public class NewOrderProcess extends OrderEntryProcess {
    private static final Logger logger = Logger.getLogger(NewOrderProcess.class.getName());
    private static final String PRODUCTS_FILE = "data/productids.txt";
    private static final int STATICLINEITEMSIZE = 3;
    private static Object lock = new Object();
    private PreparedStatement insIPs = null;
    private PreparedStatement insOPs = null;
    private PreparedStatement seqPs = null;
    private PreparedStatement updIns = null;
    private PreparedStatement updOPs = null;
    private long custID;
    private long orderID;

    public NewOrderProcess() {
    }

    public void init(Map<String, Object> params) throws SwingBenchException {
        Connection connection = (Connection) params.get(SwingBenchTask.JDBC_CONNECTION);
        boolean initCompleted = false;

        if (!initCompleted) { // load any data you might need (in this case only once)

            synchronized (lock) {
                try {
                    this.getMaxandMinCustID(connection, params);
                    this.getMaxandMinWarehouseID(connection);
                } catch (SQLException se) {
                    logger.log(Level.SEVERE, "Failed to get max and min customer id", se);
                }
            }
            initCompleted = true;
        }
    }


    public void execute(Map<String, Object> params) throws SwingBenchException {
        List<ProductDetails> productOrders = new ArrayList<ProductDetails>();
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
                getAddressDetails(connection, custID);
                getCardDetails(connection, custID);
                addSelectStatements(3);
                thinkSleep();

                int numOfBrowseCategorys = RandomGenerator.randomInteger(1, MAX_BROWSE_CATEGORY);

                for (int i = 0; i < numOfBrowseCategorys; i++) { // Look at a randomn number of products
                    productOrders = getProductDetailsByCategory(connection, RandomGenerator.randomInteger(MIN_CATEGORY, MAX_CATEGORY));
                    addSelectStatements(1);
                    thinkSleep();
                }
                if (productOrders.size() > 0) {
                    ResultSet rs = null;
                    try {
                        seqPs = connection.prepareStatement("select orders_seq.nextval from dual");
                        rs = seqPs.executeQuery();
                        rs.next();
                        orderID = rs.getLong(1);
                    } catch (Exception se) {
                        logger.log(Level.SEVERE, "Getting Sequence : orders_seq.nextval", se);
                        throw new SwingBenchException(se);
                    } finally {
                        hardClose(rs);
                        hardClose(seqPs);
                    }
                    addSelectStatements(1);
                    thinkSleep();
                    int wareHouseId = RandomGenerator.randomInteger(MIN_WAREHOUSE_ID, MAX_WAREHOUSE_ID);
                    Date orderDate = new Date(System.currentTimeMillis());
                    // TODO: Add insert columns to provide equililence to PL/SQL version
                    try {
                        insOPs =
                                connection.prepareStatement("insert into orders(ORDER_ID, ORDER_DATE, CUSTOMER_ID, WAREHOUSE_ID, DELIVERY_TYPE, COST_OF_DELIVERY, WAIT_TILL_ALL_AVAILABLE) " +
                                        "values (?, ?, ?, ?, ?, ?, ?)");
                        insOPs.setLong(1, orderID);
                        insOPs.setDate(2, orderDate);
                        insOPs.setLong(3, custID);
                        insOPs.setInt(4, wareHouseId);
                        insOPs.setString(5, "Standard");
                        insOPs.setInt(6, RandomGenerator.randomInteger(MIN_COST_DELIVERY, MAX_COST_DELIVERY));
                        insOPs.setString(7, "ship_asap");
                        insOPs.execute();
                    } catch (Exception se) {
                        logger.log(Level.SEVERE, "Unable to insert order : " + se.getMessage(), se);
                        logger.fine("Inserting order : ORDER_ID = " + orderID + ", ORDER_DATE = " + orderDate.toString() + ", CUSTOMER_ID = " + custID);
                        throw new SwingBenchException(se);
                    } finally {
                        hardClose(insOPs);
                    }

                    addInsertStatements(1);
                    thinkSleep();

                    int numOfProductsToBuy = RandomGenerator.randomInteger(MIN_PRODS_TO_BUY, productOrders.size());
                    double totalOrderCost = 0;
                    List<ProductDetails> itemsOrdered = new ArrayList<ProductDetails>();

                    for (int lineItemID = 0; lineItemID < numOfProductsToBuy; lineItemID++) {
                        //int prodID = ((Integer)products.get(RandomGenerator.randomInteger(0, products.size()))).intValue();
                        int prodID = productOrders.get(lineItemID).getProductID();
                        int quantity;
                        double price =
                                productOrders.get(lineItemID).getProductID();
                        quantity = productOrders.get(lineItemID).getQuantityAvailable(); // check to see if its in stock

                        if (quantity > 0) {
                            try {
                                insIPs =
                                        connection.prepareStatement("insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY, GIFT_WRAP, CONDITION, ESTIMATED_DELIVERY) " +
                                                "values (?, ?, ?, ?, ?, ?, ?, (SYSDATE+ 3))");
                                insIPs.setLong(1, orderID);
                                insIPs.setInt(2, lineItemID);
                                insIPs.setInt(3, prodID);
                                insIPs.setDouble(4, price);
                                insIPs.setInt(5, 1);
                                insIPs.setString(6, "None");
                                insIPs.setString(7, "New");
                                insIPs.execute();
                            } catch (Exception se) {
                                logger.log(Level.SEVERE, "Inserting Order Item : ", se);
                                logger.fine("Exception inserting lineitem (order_id, lineItem_id) : (" + orderID + ", " + lineItemID);
                                throw new SwingBenchException(se);
                            } finally {
                                hardClose(insIPs);
                            }

                            addInsertStatements(1);
                        }

                        thinkSleep();

                        ProductDetails inventoryUpdate = new ProductDetails(prodID, wareHouseId, 1);
                        itemsOrdered.add(inventoryUpdate);
                        totalOrderCost = totalOrderCost + price;
                    }

                    try { //update the order
                        updOPs = connection.prepareStatement("update orders " + "set order_mode = ?, " + "order_status = ?, " + "order_total = ? " + "where order_id = ?");
                        updOPs.setString(1, "online");
                        updOPs.setInt(2, RandomGenerator.randomInteger(0, AWAITING_PROCESSING));
                        updOPs.setDouble(3, totalOrderCost);
                        updOPs.setLong(4, orderID);
                        updOPs.execute();
                    } catch (SQLException se) {
                        logger.log(Level.SEVERE, "Updating Order : ", se);
                        throw new SwingBenchException(se);
                    } finally {
                        hardClose(updOPs);
                    }

                    addUpdateStatements(1);
                    thinkSleep();
                    //getOrderDetailsByOrderID(connection, orderID);
                    //addSelectStatements(1);
                    thinkSleep();

                    for (int i = 0; i < itemsOrdered.size(); i++) {
                        ProductDetails inventoryUpdate = itemsOrdered.get(i);

                        try { //update the stock levels
                            updIns = connection.prepareStatement("update inventories " + "set quantity_on_hand = quantity_on_hand - ? " + "where product_id = ? " + "and warehouse_id = ?");
                            updIns.setInt(1, inventoryUpdate.quantityAvailable);
                            updIns.setInt(2, inventoryUpdate.productID);
                            updIns.setInt(3, inventoryUpdate.warehouseID);
                            updIns.execute();
                            updIns.close();
                            addUpdateStatements(1);
                        } catch (SQLException se) {
                            logger.log(Level.SEVERE, "Updating inventory : ", se);
                            throw new SwingBenchException(se);
                        } finally {
                            hardClose(updIns);
                        }
                    }


                    connection.commit();
                    addCommitStatements(1);
                }
            } catch (SQLException e) {
                logger.log(Level.SEVERE, "Unexpected Exception in NewOrderProcess() : ", e);
                throw new SwingBenchException(e); // shouldn't happen
            }

            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), true, getInfoArray()));
        } catch (SwingBenchException sbe) {
            logger.info("We should catch exception here...");

            try {
                addRollbackStatements(1);
                connection.rollback();
            } catch (SQLException er) {
                logger.log(Level.INFO, "Unable to rollback transaction");
            }
            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), false, getInfoArray()));

            throw new SwingBenchException(sbe);
        }
    }

    /*public void populate(int numToPopulate, boolean isRandomSizes, Connection connection) throws SQLException { // used for initial population

        ((OracleConnection)connection).setDefaultExecuteBatch(100);
        seqPs = connection.prepareStatement("select orders_seq.nextval from dual"); //insert a order
        insOPs = connection.prepareStatement("insert into orders(ORDER_ID, ORDER_DATE, ORDER_TOTAL, CUSTOMER_ID) " + "values (?, SYSTIMESTAMP, ?, ?)");
        insIPs = connection.prepareStatement("insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY) " + "values (?, ?, ?, ?, ?)");
        ResultSet rs = seqPs.executeQuery();
        rs.next();
        orderID = rs.getInt(1);
        rs.close();

        Map<Integer, Integer> selectedProducts = null;

        for (int x = 0; x < numToPopulate; x++) {
            int numOfProductsToBuy = (isRandomSizes) ? RandomGenerator.randomInteger(MIN_PRODS_TO_BUY, MAX_PRODS_TO_BUY) + 1 : STATICLINEITEMSIZE;
            double totalOrderCost = 0;
            selectedProducts = new HashMap<Integer, Integer>(numOfProductsToBuy);
            for (int i = 1; i < numOfProductsToBuy; i++) {
                Integer randProdID = null;
                while (true) {
                    randProdID = RandomGenerator.randomInteger(MIN_PROD_ID, MAX_PROD_ID);
                    if (selectedProducts.get(randProdID) == null) {
                        selectedProducts.put(randProdID, randProdID);
                        break;
                    }
                }

                //        int prodID = ((Integer)products.get(randProdID.intValue())).intValue();
                //        int prodID = RandomGenerator.randomInteger(MIN_PROD_ID, MAX_PROD_ID);
                int quantity = 1;

                double price = RandomGenerator.randomInteger(2, 15);
                totalOrderCost += price;
                insIPs.setLong(1, orderID);
                insIPs.setInt(2, i);
                insIPs.setInt(3, randProdID);
                insIPs.setDouble(4, price);
                insIPs.setInt(5, quantity);
                insIPs.executeUpdate();
            }

            custID = RandomGenerator.randomLong(MIN_CUSTID, MAX_CUSTID);
            insOPs.setLong(1, orderID);
            //insOPs.setDate(2, new Date(System.nanoTime()));
            insOPs.setDouble(2, totalOrderCost);
            insOPs.setLong(3, custID);
            insOPs.execute();

            if ((orderID % 10000) == 0) {
                connection.commit();
            }

            orderID++;
        }

        Statement st = connection.createStatement();
        st.execute("alter sequence orders_seq increment by " + numToPopulate);
        rs = seqPs.executeQuery();
        st.execute("alter sequence orders_seq increment by 1");
        st.close();
        seqPs.close();
        insOPs.close();
        insIPs.close();
        ((OracleConnection)connection).setDefaultExecuteBatch(1);
    }*/

    public void close() {
    }


}
