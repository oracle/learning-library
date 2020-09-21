package com.mike.CallingCircle;

import com.dom.benchmarking.swingbench.kernel.DatabaseTransaction;
import com.dom.benchmarking.swingbench.kernel.SwingBenchException;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

import java.util.logging.*;


public abstract class CallingCircleProcess extends DatabaseTransaction {
    private static final Logger logger = Logger.getLogger(CallingCircleProcess.class.getName());
    public static final String NEW_CC_PROCESS = "New Customer";
    public static final String UPDATE_CC_PROCESS = "Update Customer Details";
    public static final String RETRIEVE_HISTORY = "Retrieve Customer Details";
    public static final String NEW_CUSTOMER_TX = "Register New Account";
    public static final String GET_CUSTOMER_TX = "Account Login";
    public static final String NEW_CUSTOMER_CLI_TX = "Register Line";
    public static final String GET_CUSTOMER_CLI_TX = "Choose Line";
    public static final String SET_CIRCLE_CLI_TX = "Update Calling Circle";
    public static final String GET_CIRCLE_CLIS_TX = "Query Calling Circle";
    public static final String QRY_CLIS_CURRENT_TX = "Report Current Calling Circle";
    public static final String QRY_CLIS_HISTORY_TX = "Report Calling Circle History";
    public static final String DEFAULT_PROP_FILE = "callingcircle.prop";
    protected CallableStatement getCallingCircleLineIdentifiersCs = null;
    protected CallableStatement getCustomerAccountCs = null;
    protected CallableStatement getCustomerCallingLineIdentifierCs = null;
    protected CallableStatement newCustomerAccountCs = null;
    protected CallableStatement newCustomerCallingLineIdentifierCs = null;
    protected CallableStatement qryCallingCircleCurrentCs = null;
    protected CallableStatement qryCallingCircleHistoryCs = null;
    protected CallableStatement setCallingCircleLineIdentifierCs = null;
    protected CallingCircleLineIdentifier callingCircleLineIdentifier;
    protected CustomerAccount customerAccount;
    protected CustomerCallingLineIdentifier customerCallingLineIdentifier;

    public void newCustomerAccount(Connection connection) throws SwingBenchException {
        try {
            //      if (newCustomerAccountCs == null) {
            newCustomerAccountCs = connection.prepareCall("{call ccAppPkg.newCustAccount(?,?)}");
            //      }

            newCustomerAccountCs.setString(1, customerAccount.getName());
            newCustomerAccountCs.setString(2, customerAccount.getPin());
            newCustomerAccountCs.execute();

            newCustomerAccountCs.close();
        } catch (SQLException se) {
            throw new SwingBenchException(se);
        }
    }

    public void getCustomerAccount(Connection connection) throws SwingBenchException {
        try {
            //      if (getCustomerAccountCs == null) {
            getCustomerAccountCs = connection.prepareCall("{call ccAppPkg.getCustAccount(?,?,?,?,?,?)}");
            //      }

            getCustomerAccountCs.setString(1, customerAccount.getName());
            getCustomerAccountCs.setString(2, customerAccount.getPin());
            getCustomerAccountCs.registerOutParameter(3, Types.INTEGER);
            getCustomerAccountCs.registerOutParameter(4, Types.DATE);
            getCustomerAccountCs.registerOutParameter(5, Types.INTEGER);
            getCustomerAccountCs.registerOutParameter(6, Types.DATE);
            getCustomerAccountCs.execute();
            customerAccount.setId(getCustomerAccountCs.getLong(3));
            customerAccount.setLastLogin(getCustomerAccountCs.getDate(4));
            customerAccount.setFailedLogins(getCustomerAccountCs.getLong(5));
            customerAccount.setLastFailedLogin(getCustomerAccountCs.getDate(6));
            getCustomerAccountCs.close();
        } catch (SQLException se) {
            throw new SwingBenchException(se);
        }
    }

    public void newCustomerCallingLineIdentifier(Connection connection) throws SwingBenchException {
        try {
            //      if (newCustomerCallingLineIdentifierCs == null) {
            newCustomerCallingLineIdentifierCs = connection.prepareCall("{call ccAppPkg.newCustCLI(?,?,?,?,?)}");
            //      }

            newCustomerCallingLineIdentifierCs.setString(1, customerCallingLineIdentifier.getCallingLineIdentifier().getRegionValue());
            newCustomerCallingLineIdentifierCs.setString(2, customerCallingLineIdentifier.getCallingLineIdentifier().getCountryValue());
            newCustomerCallingLineIdentifierCs.setString(3, customerCallingLineIdentifier.getCallingLineIdentifier().getCallingLineIdentifier());
            newCustomerCallingLineIdentifierCs.setLong(4, customerCallingLineIdentifier.getCallingCircleId());
            newCustomerCallingLineIdentifierCs.setLong(5, customerAccount.getId());
            newCustomerCallingLineIdentifierCs.execute();
            newCustomerCallingLineIdentifierCs.close();
        } catch (SQLException se) {
            throw new SwingBenchException(se);
        }
    }

    public void getCustomerCallingLineIdentifier(Connection connection) throws SwingBenchException {
        try {
            //      if (getCustomerCallingLineIdentifierCs == null) {
            getCustomerCallingLineIdentifierCs = connection.prepareCall("{call ccAppPkg.getCustCLI(?,?,?,?,?,?,?,?,?,?,?,?)}");
            //      }

            getCustomerCallingLineIdentifierCs.setLong(1, customerAccount.getId());
            getCustomerCallingLineIdentifierCs.setString(2, customerCallingLineIdentifier.getCallingLineIdentifier().getCountryValue());
            getCustomerCallingLineIdentifierCs.setString(3, customerCallingLineIdentifier.getCallingLineIdentifier().getRegionValue());
            getCustomerCallingLineIdentifierCs.setString(4, customerCallingLineIdentifier.getCallingLineIdentifier().getCallingLineIdentifier());
            getCustomerCallingLineIdentifierCs.registerOutParameter(5, Types.INTEGER);
            getCustomerCallingLineIdentifierCs.registerOutParameter(6, Types.VARCHAR);
            getCustomerCallingLineIdentifierCs.registerOutParameter(7, Types.VARCHAR);
            getCustomerCallingLineIdentifierCs.registerOutParameter(8, Types.VARCHAR);
            getCustomerCallingLineIdentifierCs.registerOutParameter(9, Types.VARCHAR);
            getCustomerCallingLineIdentifierCs.registerOutParameter(10, Types.INTEGER);
            getCustomerCallingLineIdentifierCs.registerOutParameter(11, Types.INTEGER);
            getCustomerCallingLineIdentifierCs.registerOutParameter(12, Types.VARCHAR);
            getCustomerCallingLineIdentifierCs.execute();
            customerCallingLineIdentifier.setId(getCustomerCallingLineIdentifierCs.getLong(5));

            {
                CallingLineIdentifier myCallingLineIdentifier = new CallingLineIdentifier();
                myCallingLineIdentifier.setRegionType(getCustomerCallingLineIdentifierCs.getString(6));
                myCallingLineIdentifier.setRegionText(getCustomerCallingLineIdentifierCs.getString(7));
                myCallingLineIdentifier.setCountryType(getCustomerCallingLineIdentifierCs.getString(8));
                myCallingLineIdentifier.setCountryText(getCustomerCallingLineIdentifierCs.getString(9));
                customerCallingLineIdentifier.setCallingLineIdentifier(myCallingLineIdentifier);
            }

            customerCallingLineIdentifier.setUpdates(getCustomerCallingLineIdentifierCs.getLong(10));
            customerCallingLineIdentifier.setUpdatesAllowed(getCustomerCallingLineIdentifierCs.getLong(11));
            customerCallingLineIdentifier.setCallingCircleName(getCustomerCallingLineIdentifierCs.getString(12));
            getCustomerCallingLineIdentifierCs.close();
        } catch (SQLException se) {
            throw new SwingBenchException(se);
        }
    }

    public void setCallingCircleLineIdentifier(Connection connection) throws SwingBenchException {
        try {
            //      if (setCallingCircleLineIdentifierCs == null) {
            setCallingCircleLineIdentifierCs = connection.prepareCall("{call ccAppPkg.setPackageCLI(?,?,?,?,?,?)}");
            //      }

            setCallingCircleLineIdentifierCs.setLong(1, callingCircleLineIdentifier.getIndexId());
            setCallingCircleLineIdentifierCs.setString(2, callingCircleLineIdentifier.getCallingLineIdentifier().getRegionValue());
            setCallingCircleLineIdentifierCs.setString(3, callingCircleLineIdentifier.getCallingLineIdentifier().getCountryValue());
            setCallingCircleLineIdentifierCs.setString(4, callingCircleLineIdentifier.getCallingLineIdentifier().getCallingLineIdentifier());
            setCallingCircleLineIdentifierCs.registerOutParameter(5, Types.INTEGER);
            setCallingCircleLineIdentifierCs.registerOutParameter(6, Types.VARCHAR);
            setCallingCircleLineIdentifierCs.execute();

            setCallingCircleLineIdentifierCs.close();
        } catch (SQLException se) {
            logger.fine("Failed in setCallingCircleLineIdentifier() : with the following parameters");
            logger.fine("IndexId = " + callingCircleLineIdentifier.getIndexId());
            logger.fine("RegionValue = " + callingCircleLineIdentifier.getCallingLineIdentifier().getRegionValue());
            logger.fine("CountryValue = " + callingCircleLineIdentifier.getCallingLineIdentifier().getCountryValue());
            logger.fine("CallingLineIdentifier = " + callingCircleLineIdentifier.getCallingLineIdentifier().getCallingLineIdentifier());
            throw new SwingBenchException(se);
        }
    }

    public void getCallingCircleLineIdentifiers(Connection connection) throws SwingBenchException {
        try {
            //      if (getCallingCircleLineIdentifiersCs == null) {
            getCallingCircleLineIdentifiersCs = connection.prepareCall("{call ccAppPkg.getPackageCLIs(?)}");
            //      }

            getCallingCircleLineIdentifiersCs.setLong(1, customerCallingLineIdentifier.getId());
            getCallingCircleLineIdentifiersCs.execute();

            getCallingCircleLineIdentifiersCs.close();
        } catch (SQLException se) {
            throw new SwingBenchException(se);
        }
    }

    public void qryCallingCircleCurrent(Connection connection) throws SwingBenchException {
        try {
            //      if (qryCallingCircleCurrentCs == null) {
            qryCallingCircleCurrentCs = connection.prepareCall("{call ccAppPkg.qryPackageCLIsCurrent(?)}");
            //      }

            qryCallingCircleCurrentCs.setLong(1, customerCallingLineIdentifier.getId());
            qryCallingCircleCurrentCs.execute();
            qryCallingCircleCurrentCs.close();
        } catch (SQLException se) {
            throw new SwingBenchException(se);
        }
    }

    public void qryCallingCircleHistory(Connection connection) throws SwingBenchException {
        try {
            //      if (qryCallingCircleHistoryCs == null) {
            qryCallingCircleHistoryCs = connection.prepareCall("{call ccAppPkg.qryPackageCLIsHistory(?)}");
            //      }

            qryCallingCircleHistoryCs.setLong(1, customerCallingLineIdentifier.getId());
            qryCallingCircleHistoryCs.execute();
            qryCallingCircleHistoryCs.close();
        } catch (SQLException se) {
            throw new SwingBenchException(se);
        }
    }

}
