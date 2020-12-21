package com.dom.benchmarking.swingbench.transactions;


import com.dom.benchmarking.swingbench.constants.Constants;
import com.dom.benchmarking.swingbench.kernel.DatabaseTransaction;
import com.dom.util.RandomUtilities;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;


public abstract class OrderEntryProcess extends DatabaseTransaction {

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
    static final int MIN_CATEGORY = 1;
    static final int MAX_CATEGORY = 199;
    static final int MAX_BROWSE_CATEGORY = 6;
    static final int MAX_CREDITLIMIT = 5000;
    static final int MIN_CREDITLIMIT = 100;
    static final int MIN_SALESID = 145;
    static final int MAX_SALESID = 171;
    static final int MIN_PRODS_TO_BUY = 2;
    static final int MAX_PRODS_TO_BUY = 6;
    static final int MIN_PROD_ID = 1;
    static final int HOUSE_NO_RANGE = 200;
    static final int MAX_PROD_ID = 1000;
    static final int MIN_COST_DELIVERY = 1;
    static final int MAX_COST_DELIVERY = 5;
    static int MIN_WAREHOUSE_ID = 1;
    static int MAX_WAREHOUSE_ID = 1000;
    static long MIN_ORDERID = 1;
    static long MAX_ORDERID = 146610;
    static final int AWAITING_PROCESSING = 4;
    static final int ORDER_PROCESSED = 10;
    static long MIN_CUSTID = 0;
    static long MAX_CUSTID = 0;
    private PreparedStatement catPs = null;
    private PreparedStatement cardPs = null;
    private PreparedStatement catqPs = null;
    private PreparedStatement custPs = null;
    private PreparedStatement addPs = null;
    private PreparedStatement insLogon = null;
    private PreparedStatement orderPs = null;
    private PreparedStatement orderPs2 = null;
    private PreparedStatement orderPs3 = null;
    private PreparedStatement prodPs = null;
    private PreparedStatement prodqPs = null;
    private static final Logger logger = Logger.getLogger(OrderEntryProcess.class.getName());
    private static Object lock = new Object();


    public void logon(Connection connection, long custid) throws SQLException {
        Date currentTime = new Date(System.currentTimeMillis());
        try {
            PreparedStatement insLogon = connection.prepareStatement("insert into logon (logon_id, customer_id, logon_date) values(logon_seq.nextval,?,?)");
            insLogon.setLong(1, custid);
            insLogon.setDate(2, currentTime);
            insLogon.executeUpdate();
            connection.commit();
            insLogon.close();
        } finally {
            hardClose(insLogon);
        }
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
                            logger.fine("Min CustomerID = " + MIN_CUSTID + ", Max CustomerID = " + MAX_CUSTID);
                            vrs.close();
                            vps.close();
                        } else {
                            logger.fine("Acquiring customer counts from database");

                            PreparedStatement mmPs = connection.prepareStatement("select min(customer_id), max(customer_id) from customers");
                            ResultSet rs = mmPs.executeQuery();

                            if (rs.next()) {
                                MIN_CUSTID = rs.getLong(1);
                                MAX_CUSTID = rs.getLong(2);
                            }
                            logger.fine("Min CustomerID = " + MIN_CUSTID + ", Max CustomerID = " + MAX_CUSTID);
                            rs.close();
                            mmPs.close(); //should be called only once;

                            mmPs = connection.prepareStatement("select min(order_id), max(order_id) from orders");
                            rs = mmPs.executeQuery();

                            if (rs.next()) {
                                MIN_ORDERID = rs.getLong(1);
                                MAX_ORDERID = rs.getLong(2);
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

    //    public void getMaxandMinCustID(Connection connection) throws SQLException {
    //        PreparedStatement mmPs = null;
    //        ResultSet rs = null;
    //        try {
    //            mmPs = connection.prepareStatement("select min(customer_id), max(customer_id) from customers");
    //            rs = mmPs.executeQuery();
    //            if (rs.next()) {
    //                MIN_CUSTID = rs.getInt(1);
    //                MAX_CUSTID = rs.getInt(2);
    //            }
    //        } finally {
    //            rs.close();
    //            mmPs.close();
    //        }
    //
    //        //should be called only once;
    //    }

    public void getMaxandMinWarehouseID(Connection connection) throws SQLException {
        PreparedStatement mmPs = null;
        ResultSet rs = null;
        try {
            mmPs = connection.prepareStatement("select min(warehouse_id), max(warehouse_id) from warehouses");
            rs = mmPs.executeQuery();
            if (rs.next()) {
                MIN_WAREHOUSE_ID = rs.getInt(1);
                MAX_WAREHOUSE_ID = rs.getInt(2);
            }
        } finally {
            rs.close();
            mmPs.close();
        }

    }

    public void insertAdditionalWarehouses(Connection connection, int numWarehouses) throws SQLException {
        PreparedStatement iaw = null;
        try {
            iaw = connection.prepareStatement("insert into warehouses(warehouse_id, warehouse_name, location_id) values (?,?,?)");

            for (int i = 0; i < numWarehouses; i++) {
                int whid = (MAX_WAREHOUSE_ID + i) + 1;
                iaw.setInt(1, whid);
                iaw.setString(2, "Warehouse Number " + whid);
                iaw.setInt(3, RandomUtilities.randomInteger(1, 9999));
                iaw.executeUpdate();
            }
            connection.commit();

        } finally {
            iaw.close();
        }
    }

    public List<Long> getCustomerDetailsByName(Connection connection, String firstname, String lastName) throws SQLException {
        List<Long> result = new ArrayList<Long>();
        ResultSet rs = null;
        try {
            custPs = connection.prepareStatement(
                    "SELECT   CUSTOMER_ID,      \n" +
                            "          CUST_FIRST_NAME,      \n" +
                            "          CUST_LAST_NAME,      \n" +
                            "          NLS_LANGUAGE,      \n" +
                            "          NLS_TERRITORY,      \n" +
                            "          CREDIT_LIMIT,      \n" +
                            "          CUST_EMAIL,      \n" +
                            "          ACCOUNT_MGR_ID,      \n" +
                            "          CUSTOMER_SINCE,      \n" +
                            "          CUSTOMER_CLASS,      \n" +
                            "          SUGGESTIONS,      \n" +
                            "          DOB,      \n" +
                            "          MAILSHOT,      \n" +
                            "          PARTNER_MAILSHOT,      \n" +
                            "          PREFERRED_ADDRESS,\n" +
                            "          PREFERRED_CARD\n" +
                            "        FROM CUSTOMERS      \n" +
                            "        WHERE lower(cust_last_name) = lower(?) \n" +
                            "        AND lower(cust_first_name) = lower(?)      \n" +
                            "        AND rownum        < 5");
            custPs.setString(2, firstname);
            custPs.setString(1, lastName);
            rs = custPs.executeQuery();
            while (rs.next()) {
                result.add(rs.getLong(1));
            }
        } finally {
            hardClose(rs);
            hardClose(custPs);
        }
        return result;
    }

    public void getCustomerDetails(Connection connection, long custId) throws SQLException {
        ResultSet rs = null;
        try {
            custPs = connection.prepareStatement(
                    "SELECT CUSTOMER_ID, CUST_FIRST_NAME, CUST_LAST_NAME, NLS_LANGUAGE, \n" +
                            "  NLS_TERRITORY, CREDIT_LIMIT, CUST_EMAIL, ACCOUNT_MGR_ID, CUSTOMER_SINCE, \n" +
                            "  CUSTOMER_CLASS, SUGGESTIONS, DOB, MAILSHOT, PARTNER_MAILSHOT, \n" +
                            "  PREFERRED_ADDRESS, PREFERRED_CARD \n" +
                            "FROM\n" +
                            " CUSTOMERS WHERE CUSTOMER_ID = ? AND ROWNUM < 5");
            custPs.setLong(1, custId);

            rs = custPs.executeQuery();
            rs.next();
        } finally {
            hardClose(rs);
            hardClose(custPs);
        }

    }

    public void getAddressDetails(Connection connection, long custId) throws SQLException {
        ResultSet rs = null;
        try {
            addPs = connection.prepareStatement(
                    "SELECT   ADDRESS_ID,      \n" +
                            "          CUSTOMER_ID,      \n" +
                            "          DATE_CREATED,      \n" +
                            "          HOUSE_NO_OR_NAME,      \n" +
                            "          STREET_NAME,      \n" +
                            "          TOWN,      \n" +
                            "          COUNTY,      \n" +
                            "          COUNTRY,      \n" +
                            "          POST_CODE,      \n" +
                            "          ZIP_CODE      \n" +
                            "        FROM ADDRESSES       \n" +
                            "        WHERE customer_id = ? \n" +
                            "        AND rownum        < 5");
            addPs.setLong(1, custId);
            rs = addPs.executeQuery();
            rs.next();
        } finally {
            hardClose(rs);
            hardClose(addPs);
        }
    }

    public void getCardDetails(Connection connection, long custId) throws SQLException {
        ResultSet rs = null;
        try {
            cardPs = connection.prepareStatement(
                    "SELECT CARD_ID,\n" +
                            "          CUSTOMER_ID,\n" +
                            "          CARD_TYPE,\n" +
                            "          CARD_NUMBER,\n" +
                            "          EXPIRY_DATE,\n" +
                            "          IS_VALID,\n" +
                            "          SECURITY_CODE\n" +
                            "        FROM card_details       \n" +
                            "        WHERE CUSTOMER_ID = ?      \n" +
                            "        AND rownum        < 5");
            cardPs.setLong(1, custId);
            rs = cardPs.executeQuery();
            rs.next();
        } finally {
            hardClose(rs);
            hardClose(cardPs);
        }
    }

    public List<Long> getOrdersByCustomer(Connection connection, long custId) throws SQLException {
        List<Long> orders = new ArrayList<Long>();
        ResultSet rs = null;
        try {
            orderPs3 = connection.prepareStatement(
                    "SELECT ORDER_ID,     \n" +
                            "        ORDER_DATE,     \n" +
                            "        ORDER_MODE,     \n" +
                            "        CUSTOMER_ID,     \n" +
                            "        ORDER_STATUS,     \n" +
                            "        ORDER_TOTAL,     \n" +
                            "        SALES_REP_ID,     \n" +
                            "        PROMOTION_ID,     \n" +
                            "        WAREHOUSE_ID,     \n" +
                            "        DELIVERY_TYPE,     \n" +
                            "        COST_OF_DELIVERY,     \n" +
                            "        WAIT_TILL_ALL_AVAILABLE,     \n" +
                            "        DELIVERY_ADDRESS_ID,     \n" +
                            "        CUSTOMER_CLASS,     \n" +
                            "        CARD_ID,     \n" +
                            "        INVOICE_ADDRESS_ID           \n" +
                            "      from orders           \n" +
                            "      where customer_id = ?           \n" +
                            "      and rownum < 5");
            orderPs3.setLong(1, custId);
            rs = orderPs3.executeQuery();
            while (rs.next()) { // Will only ever be a maximum of 5
                orders.add(rs.getLong(1));
            }
        } finally {
            hardClose(rs);
            hardClose(orderPs3);
        }
        return orders;
    }


    public double getProductDetailsByID(Connection connection, int prodID) throws SQLException {
        ResultSet rs = null;
        double price = 0;

        try {
            prodPs =
                    connection.prepareStatement(" select product_id, product_name, product_description, category_id, weight_class, supplier_id, product_status, list_price, min_price, catalog_url from  product_information where product_id = ?");
            prodPs.setInt(1, prodID);
            rs = prodPs.executeQuery();
            while (rs.next()) {
                price = rs.getDouble(8);
            }
        } catch (SQLException se) {
            throw se;
        } finally {
            hardClose(rs);
            hardClose(prodPs);
        }

        return price;
    }

    public List<ProductDetails> getProductDetailsByCategory(Connection connection, int catID) throws SQLException {
        List<ProductDetails> result = new ArrayList<ProductDetails>();
        ResultSet rs = null;
        int warehouseId = RandomUtilities.randomInteger(MIN_WAREHOUSE_ID, MAX_WAREHOUSE_ID);
        try {
            catPs = connection.prepareStatement(
                    "select   products.PRODUCT_ID,           \n" +
                            "              PRODUCT_NAME,           \n" +
                            "              PRODUCT_DESCRIPTION,           \n" +
                            "              CATEGORY_ID,           \n" +
                            "              WEIGHT_CLASS,           \n" +
                            "              WARRANTY_PERIOD,           \n" +
                            "              SUPPLIER_ID,           \n" +
                            "              PRODUCT_STATUS,           \n" +
                            "              LIST_PRICE,           \n" +
                            "              MIN_PRICE,           \n" +
                            "              CATALOG_URL,           \n" +
                            "              QUANTITY_ON_HAND \n" +
                            "      from products,           \n" +
                            "      inventories           \n" +
                            "      where products.category_id = ?           \n" +
                            "      and inventories.product_id = products.product_id           \n" +
                            "      and inventories.warehouse_id = ?           \n" +
                            "      and rownum < 5");
            catPs.setInt(1, catID);
            catPs.setInt(2, warehouseId);

            rs = catPs.executeQuery();
            while (rs.next()) {
                result.add(new ProductDetails(rs.getInt(1), warehouseId, rs.getInt(12)));
            }
        } finally {
            hardClose(rs);
            hardClose(catPs);
        }
        return result;
    }

    public int getProductQuantityByID(Connection connection, int ID) throws SQLException {
        int quantity = 0;
        ResultSet rs = null;
        try {
            prodqPs =
                    connection.prepareStatement(" select  p.product_id, product_name, product_description, category_id, weight_class, supplier_id,  product_status,  list_price, min_price, catalog_url, quantity_on_hand, warehouse_id from  product_information p, inventories i where   i.product_id = ?  and   i.product_id = p.product_id");
            prodqPs.setInt(1, ID);

            rs = prodqPs.executeQuery();
            if (rs.next()) {
                quantity = rs.getInt(11);
            }
        } finally {
            hardClose(rs);
            hardClose(prodqPs);
        }
        return quantity;
    }

    public void getProductQuantityByCategory(Connection connection, int catID) throws SQLException {
        ResultSet rs = null;
        try {
            catqPs =
                    connection.prepareStatement(" select  p.product_id, product_name, product_description, category_id, weight_class, supplier_id, product_status, list_price, min_price, catalog_url,  quantity_on_hand, warehouse_id from   product_information p,  inventories i where  category_id = ? and i.product_id = p.product_id");
            catqPs.setInt(1, catID);

            rs = catqPs.executeQuery();
            rs.next();
        } finally {
            hardClose(rs);
            hardClose(catqPs);
        }

    }

    public void getOrderByID(Connection connection, int orderID) throws SQLException {
        ResultSet rs = null;
        try {
            orderPs =
                    connection.prepareStatement(" select  order_id,   order_date,   order_mode,   customer_id,   order_status,   order_total,   sales_rep_id,   promotion_id from    orders where    order_id = ?");
            orderPs.setInt(1, orderID);

            rs = orderPs.executeQuery();
            rs.next();
        } finally {
            hardClose(rs);
            hardClose(orderPs);
        }

    }

    public void getOrderDetailsByOrderID(Connection connection, long orderID) throws SQLException {
        ResultSet rs = null;
        try {
            orderPs2 =
                    connection.prepareStatement(" SELECT  o.order_id,   line_item_id,   product_id,   unit_price,   quantity,   order_mode,   order_status,   order_total,   sales_rep_id,   promotion_id,   c.customer_id,   cust_first_name,   cust_last_name,   credit_limit,   cust_email  FROM    orders o ,   order_items oi,   customers c WHERE    o.order_id = oi.order_id  and   o.customer_id = c.customer_id  and   o.order_id = ?");
            orderPs2.setLong(1, orderID);

            rs = orderPs2.executeQuery();
            rs.next();
        } finally {
            hardClose(rs);
            hardClose(orderPs2);
        }

    }

    /*public void setMaxSleepTime(long newMaxSleepTime) {
    maxSleepTime = newMaxSleepTime;
  }

  public void setMinSleepTime(long newMinSleepTime) {
    minSleepTime = newMinSleepTime;
  }*/

}
