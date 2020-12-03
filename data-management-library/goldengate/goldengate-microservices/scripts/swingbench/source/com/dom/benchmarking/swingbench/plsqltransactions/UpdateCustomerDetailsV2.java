package com.dom.benchmarking.swingbench.plsqltransactions;


import com.dom.benchmarking.swingbench.event.JdbcTaskEvent;
import com.dom.benchmarking.swingbench.kernel.SwingBenchException;
import com.dom.benchmarking.swingbench.kernel.SwingBenchTask;
import com.dom.benchmarking.swingbench.utilities.RandomGenerator;
import com.dom.util.Utilities;

import java.io.File;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import oracle.jdbc.OracleTypes;


public class UpdateCustomerDetailsV2 extends OrderEntryProcess {

    private static final Logger logger = Logger.getLogger(UpdateCustomerDetailsV2.class.getName());
    private static final String COUNTIES_FILE = "data/counties.txt";
    private static final String COUNTRIES_FILE = "data/countries.txt";
    private static final String FIRST_NAMES_FILE = "data/lowerfirstnames.txt";
    private static final String LAST_NAMES_FILE = "data/lowerlastnames.txt";
    private static final String TOWNS_FILE = "data/towns.txt";
    private static List<String> counties = null;
    private static List<String> countries = null;
    private static List<String> firstNames = null;
    private static List<String> lastNames = null;
    private static List<String> towns = null;
    private static Object lock = new Object();

    public UpdateCustomerDetailsV2() {
    }

    public void close() {
    }

    @Override
    public void init(Map params) throws SwingBenchException {
        boolean initCompleted = false;
        Connection connection = (Connection) params.get(SwingBenchTask.JDBC_CONNECTION);
        Boolean commitClientSide = Boolean.parseBoolean((String) params.get(SwingBenchTask.COMMIT_CLIENT_SIDE));
        try {
            this.setCommitClientSide(connection, commitClientSide);
        } catch (SQLException se) {
            throw new SwingBenchException("Unable to set commit location");
        }

        if ((firstNames == null) || !initCompleted) { // load any data you might need (in this case only once)

            synchronized (lock) {
                if (firstNames == null) {

                    String value = (String) params.get("SOE_FIRST_NAMES_LOC");
                    File firstNamesFile = new File((value == null) ? FIRST_NAMES_FILE : value);
                    value = (String) params.get("SOE_LAST_NAMES_LOC");
                    File lastNamesFile = new File((value == null) ? LAST_NAMES_FILE : value);

                    value = (String) params.get("SOE_TOWNS_LOC");
                    File townsFile = new File((value == null) ? TOWNS_FILE : value);
                    value = (String) params.get("SOE_COUNTIES_LOC");
                    File countiesFile = new File((value == null) ? COUNTIES_FILE : value);
                    value = (String) params.get("SOE_COUNTRIES_LOC");
                    File countriesFile = new File((value == null) ? COUNTRIES_FILE : value);

                    try {
                        firstNames = Utilities.cacheFile(firstNamesFile);
                        lastNames = Utilities.cacheFile(lastNamesFile);
                        counties = Utilities.cacheFile(countiesFile);
                        towns = Utilities.cacheFile(townsFile);
                        countries = Utilities.cacheFile(countriesFile);


                        logger.fine("Completed reading files needed for initialisation of NewCustomerProcess()");

                    } catch (java.io.FileNotFoundException fne) {
                        logger.log(Level.SEVERE, "Unable to open data seed files : ", fne);
                        throw new SwingBenchException(fne);
                    } catch (java.io.IOException ioe) {
                        logger.log(Level.SEVERE, "IO problem opening seed files : ", ioe);
                        throw new SwingBenchException(ioe);
                    }
                }

                initCompleted = true;
            }
        }
    }

    @Override
    public void execute(Map params) throws SwingBenchException {
        //        FUNCTION updateCustomerDetails(
        //            p_fname customers.cust_first_name%type,
        //            p_lname customers.cust_last_name%type,
        //            p_town addresses.town%type,
        //            p_county addresses.county%type,
        //            p_country addresses.country%type,
        //            min_sleep INTEGER,
        //            max_sleep INTEGER)
        //          RETURN VARCHAR;

        Connection connection = (Connection) params.get(SwingBenchTask.JDBC_CONNECTION);
        int queryTimeOut = 60;

        if (params.get(SwingBenchTask.QUERY_TIMEOUT) != null) {
            queryTimeOut = ((Integer) (params.get(SwingBenchTask.QUERY_TIMEOUT))).intValue();
        }

        String firstName = firstNames.get(RandomGenerator.randomInteger(0, firstNames.size()));
        String lastName = lastNames.get(RandomGenerator.randomInteger(0, lastNames.size()));
        String town = towns.get(RandomGenerator.randomInteger(0, towns.size()));
        String county = counties.get(RandomGenerator.randomInteger(0, counties.size()));
        String country = countries.get(RandomGenerator.randomInteger(0, countries.size()));
        long executeStart = System.nanoTime();
        int[] infoArray = null;
        boolean sucessfulTransaction = true;

        try {
            CallableStatement cs = null;
            try {
                cs = connection.prepareCall("{? = call orderentry.updateCustomerDetails(?,?,?,?,?,?,?)}");
                cs.registerOutParameter(1, OracleTypes.VARCHAR);
                cs.setString(2, firstName);
                cs.setString(3, lastName);
                cs.setString(4, town);
                cs.setString(5, county);
                cs.setString(6, country);
                cs.setInt(7, (int) this.getMinSleepTime());
                cs.setInt(8, (int) this.getMaxSleepTime());
                cs.setQueryTimeout(queryTimeOut);
                cs.executeUpdate();
                infoArray = parseInfoArray(cs.getString(1));
                if (infoArray[ROLLBACK_STATEMENTS] != 0)
                    sucessfulTransaction = false;
                cs.close();
                this.commit(connection);
            } catch (SQLException se) {
                //logger.log(Level.SEVERE, "SQL Exception : ", se);
                try {
                    cs.close();
                } catch (Exception e) {
                }
                throw new SwingBenchException(se);
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Exception : ", e);
                throw new SwingBenchException(e.getMessage());
            }
            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), sucessfulTransaction, infoArray));
        } catch (SwingBenchException sbe) {
            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), sucessfulTransaction, infoArray));

            try {
                connection.rollback();
            } catch (SQLException er) {
            }

            throw new SwingBenchException(sbe);
        }
    }

    private class NLSSupport {

        String language = null;
        String territory = null;

    }

}
