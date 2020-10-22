package com.dom.benchmarking.swingbench.plsqltransactions;


import com.dom.benchmarking.swingbench.constants.Constants;
import com.dom.benchmarking.swingbench.kernel.DatabaseTransaction;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.Map;
import java.util.StringTokenizer;
import java.util.logging.Logger;


public abstract class OrderEntryProcess extends DatabaseTransaction {

    private static final Logger logger = Logger.getLogger(OrderEntryProcess.class.getName());
    static final String NEW_CUSTOMER = "New Customer";
    static final String CUTOMER_ORDER = "Customer Order";
    static final String CUSTOMER_BROWSE = "Customer Browse";
    static final String GET_CUSTOMER_SEQ_TX = "Get Customer Sequence";
    static final String GET_ORDER_SEQ_TX = "Get Order Sequence";
    static final String INSERT_CUSTOMER_TX = "Insert New Customer";
    static final String INSERT_ITEM_TX = "Insert Order Item";
    static final String INSERT_ORDER_TX = "Insert Order";
    static final String UPDATE_ORDER_TX = "Update Order";
    static final String UPDATE_WAREHOUSE_TX = "Update Warehouse";
    static final String GET_CUSTOMER_DETAILS_TX = "Get Customer Details";
    static final String BROWSE_PENDING_ORDERS = "Browse Pending Orders";
    static final String BROWSE_BY_PROD_ID = "Browse Product by ID";
    static final String BROWSE_BY_CATEGORY_TX = "Browse Products by Category";
    static final String BROWSE_BY_CAT_QUAN_TX = "Browse Products by Quantity";
    static final String BROWSE_BY_ORDER_ID = "Browse Orders by ID";
    static final String BROWSE_ORDER_DETAILS = "Browse Order Details";
    static final String UPDATE_PENDING_ORDERS = "Update Pending Orders";
    static final String GET_ORDER_BY_CUSTOMER_TX = "Browse Order by Customer";
    static final int MIN_CATEGORY = 11;
    static final int MAX_CATEGORY = 39;
    static final int MAX_BROWSE_CATEGORY = 6;
    static final int MAX_CREDITLIMIT = 5000;
    static final int MIN_CREDITLIMIT = 100;
    static final int MIN_SALESID = 145;
    static final int MAX_SALESID = 171;
    static final int MIN_PRODS_TO_BUY = 2;
    static final int MAX_PRODS_TO_BUY = 6;
    static final int MIN_PROD_ID = 1726;
    static final int MAX_PROD_ID = 3515;
    static final int MIN_WAREHOUSE_ID = 1;
    static final int MAX_WAREHOUSE_ID = 1000;
    static final int AWAITING_PROCESSING = 4;
    static final int ORDER_PROCESSED = 10;
    static long MIN_CUSTID = 0;
    static long MAX_CUSTID = 0;
    static long MIN_ORDERID = 0;
    static long MAX_ORDERID = 0;
    static final int SELECT_STATEMENTS = 0;
    static final int INSERT_STATEMENTS = 1;
    static final int UPDATE_STATEMENTS = 2;
    static final int DELETE_STATEMENTS = 3;
    static final int COMMIT_STATEMENTS = 4;
    static final int ROLLBACK_STATEMENTS = 5;
    static final int SLEEP_TIME_LOC = 6;
    private static boolean isInitCompleted = false;
    private static boolean commitClientSide = false;
    private static Object lock = new Object();

    public void commit(Connection connection) throws SQLException {
        if (commitClientSide) {
            connection.commit();
        }
    }

    public void setCommitClientSide(Connection connection, boolean commitClientSide) throws SQLException {
        this.commitClientSide = commitClientSide;
        CallableStatement cs = connection.prepareCall("{call orderentry.setPLSQLCOMMIT(?)}");
        //logger.fine("Setting plsql commit to : " + Boolean.toString(!commitClientSide));
        cs.setString(1, Boolean.toString(!commitClientSide));
        cs.executeUpdate();
        cs.close();
    }

    public void getMaxandMinCustID(Connection connection, Map<String, Object> params) throws SQLException {

        if (MAX_CUSTID == 0) { // load any data you might need (in this case only once)

            synchronized (lock) {
                if (MAX_CUSTID == 0) {
                    String minCI = (String) params.get(Constants.SOEMINCUSTOMERID);
                    String maxCI = (String) params.get(Constants.SOEMAXCUSTOMERID);
                    if ((minCI != null) && (maxCI != null)) {
                        logger.fine("Acquiring customer counts from environment variables");
                        MIN_CUSTID = Long.parseLong(minCI);
                        MAX_CUSTID = Long.parseLong(maxCI);
                    } else {
                        PreparedStatement ps = connection.prepareStatement("select 1 from user_tables where table_name =  'ORDERENTRY_METADATA'");
                        ResultSet trs = ps.executeQuery();
                        if (trs.next()) {
                            logger.fine("Acquiring customer counts from metadata table");
                            PreparedStatement vps = connection.prepareStatement("select metadata_key, metadata_value from ORDERENTRY_METADATA");
                            ResultSet vrs = vps.executeQuery();
                            while (vrs.next()) {
                                if (vrs.getString(1).equals("SOE_MIN_ORDER_ID")) {
                                    MIN_ORDERID = Long.parseLong(vrs.getString(2));
                                } else if (vrs.getString(1).equals("SOE_MAX_ORDER_ID")) {
                                    MAX_ORDERID = Long.parseLong(vrs.getString(2));
                                } else if (vrs.getString(1).equals("SOE_MIN_CUSTOMER_ID")) {
                                    MIN_CUSTID = Long.parseLong(vrs.getString(2));
                                } else if (vrs.getString(1).equals("SOE_MAX_CUSTOMER_ID")) {
                                    MAX_CUSTID = Long.parseLong(vrs.getString(2));
                                }
                            }
                            vrs.close();
                            vps.close();
                        } else {
                            logger.fine("Acquiring customer counts from database");

                            PreparedStatement mmPs = connection.prepareStatement("select min(customer_id), max(customer_id) from customers");
                            ResultSet rs = mmPs.executeQuery();

                            if (rs.next()) {
                                MIN_CUSTID = rs.getInt(1);
                                MAX_CUSTID = rs.getInt(2);
                            }
                            logger.fine("Min CustomerID = " + MIN_CUSTID + ", Max CustomerID = " + MAX_CUSTID);
                            rs.close();
                            mmPs.close(); //should be called only once;

                            mmPs = connection.prepareStatement("select min(order_id), max(order_id) from orders");
                            rs = mmPs.executeQuery();

                            if (rs.next()) {
                                MIN_ORDERID = rs.getInt(1);
                                MAX_ORDERID = rs.getInt(2);
                            }
                            logger.fine("Min CustomerID = " + MIN_CUSTID + ", Max CustomerID = " + MAX_CUSTID);
                            rs.close();
                            mmPs.close(); //should be called only once;
                        }

                        trs.close();
                        ps.close();
                    }
                }
            }

        }
    }

    public int[] parseInfoArray(String data) throws Exception {
        int[] result = new int[7];
        try {
            StringTokenizer st = new StringTokenizer(data, ",");
            result[SELECT_STATEMENTS] = Integer.parseInt(st.nextToken());
            result[INSERT_STATEMENTS] = Integer.parseInt(st.nextToken());
            result[UPDATE_STATEMENTS] = Integer.parseInt(st.nextToken());
            result[DELETE_STATEMENTS] = Integer.parseInt(st.nextToken());
            result[COMMIT_STATEMENTS] = Integer.parseInt(st.nextToken());
            result[ROLLBACK_STATEMENTS] = Integer.parseInt(st.nextToken());
            result[SLEEP_TIME_LOC] = Integer.parseInt(st.nextToken());
            return result;
        } catch (Exception e) {
            throw new Exception("Unable to parse string returned from OrderEntry Package. String = " + data, e);
        }
    }

    public void setIsStatic(boolean isStatic, Connection connection) throws SQLException {
        if (isStatic) {
            synchronized (lock) {
                if (!isInitCompleted) {
                    logger.fine("Runing OrderEntry benchmark in constant mode" + isInitCompleted);
                    CallableStatement cs = connection.prepareCall("{call orderentry.setIsStatic(?)}");
                    cs.setString(1, Boolean.toString(isStatic));
                    cs.execute();
                    cs.close();
                    isInitCompleted = true;
                }
            }
        }
    }

    public void setDMLstatements(int[] dmlArray) {
        addSelectStatements(dmlArray[SELECT_STATEMENTS]);
        addInsertStatements(dmlArray[INSERT_STATEMENTS]);
        addUpdateStatements(dmlArray[UPDATE_STATEMENTS]);
        addDeleteStatements(dmlArray[DELETE_STATEMENTS]);
        addCommitStatements(dmlArray[COMMIT_STATEMENTS]);
        addRollbackStatements(dmlArray[ROLLBACK_STATEMENTS]);
    }

}
