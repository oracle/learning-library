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

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.logging.Level;
import java.util.logging.Logger;

import oracle.jdbc.OracleTypes;


public class NewCustomerProcessV2 extends OrderEntryProcess {

    private static final Logger logger = Logger.getLogger(NewCustomerProcessV2.class.getName());
    private static final String COUNTIES_FILE = "data/counties.txt";
    private static final String COUNTRIES_FILE = "data/countries.txt";
    private static final String FIRST_NAMES_FILE = "data/lowerfirstnames.txt";
    private static final String LAST_NAMES_FILE = "data/lowerlastnames.txt";
    private static final String NLS_FILE = "data/nls.txt";
    private static final String TOWNS_FILE = "data/towns.txt";
    private static List<NLSSupport> nlsInfo = new ArrayList<NLSSupport>();
    private static List<String> counties = null;
    private static List<String> countries = null;
    private static List<String> firstNames = null;
    private static List<String> lastNames = null;
    private static List<String> nlsInfoRaw = null;
    private static List<String> towns = null;
    private static Object lock = new Object();

    public NewCustomerProcessV2() {
    }

    public void init(Map params) throws SwingBenchException {
        boolean initCompleted = false;

        if ((firstNames == null) || !initCompleted) { // load any data you might need (in this case only once)

            synchronized (lock) {
                if (firstNames == null) {

                    String value = (String) params.get("SOE_FIRST_NAMES_LOC");
                    File firstNamesFile = new File((value == null) ? FIRST_NAMES_FILE : value);
                    value = (String) params.get("SOE_LAST_NAMES_LOC");
                    File lastNamesFile = new File((value == null) ? LAST_NAMES_FILE : value);
                    value = (String) params.get("SOE_NLSDATA_LOC");
                    File nlsFile = new File((value == null) ? NLS_FILE : value);
                    value = (String) params.get("SOE_TOWNS_LOC");
                    File townsFile = new File((value == null) ? TOWNS_FILE : value);
                    value = (String) params.get("SOE_COUNTIES_LOC");
                    File countiesFile = new File((value == null) ? COUNTIES_FILE : value);
                    value = (String) params.get("SOE_COUNTRIES_LOC");
                    File countriesFile = new File((value == null) ? COUNTRIES_FILE : value);

                    try {
                        firstNames = Utilities.cacheFile(firstNamesFile);
                        lastNames = Utilities.cacheFile(lastNamesFile);
                        nlsInfoRaw = Utilities.cacheFile(nlsFile);
                        counties = Utilities.cacheFile(countiesFile);
                        towns = Utilities.cacheFile(townsFile);
                        countries = Utilities.cacheFile(countriesFile);

                        for (String rawData : nlsInfoRaw) {
                            NLSSupport nls = new NLSSupport();
                            StringTokenizer st = new StringTokenizer(rawData, ",");
                            nls.language = st.nextToken();
                            nls.territory = st.nextToken();
                            nlsInfo.add(nls);
                        }
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

    public void execute(Map params) throws SwingBenchException {
        //        FUNCTION newCustomer(
        //            p_fname customers.cust_first_name%type,
        //            p_lname customers.cust_last_name%type,
        //            p_nls_lang customers.nls_language%type,
        //            p_nls_terr customers.nls_territory%type,
        //            p_town addresses.town%type,
        //            p_county addresses.county%type,
        //            p_country addresses.country%type,
        //            p_min_sleep INTEGER,
        //            p_max_sleep INTEGER)
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
        NLSSupport nls = nlsInfo.get(RandomGenerator.randomInteger(0, nlsInfo.size()));
        long executeStart = System.nanoTime();
        int[] infoArray = null;
        boolean sucessfulTransaction = true;

        try {
            CallableStatement cs = null;
            try {
                cs = connection.prepareCall("{? = call orderentry.newcustomer(?,?,?,?,?,?,?,?,?)}");
                cs.registerOutParameter(1, OracleTypes.VARCHAR);
                cs.setString(2, firstName);
                cs.setString(3, lastName);
                cs.setString(4, nls.language);
                cs.setString(5, nls.territory);
                cs.setString(6, town);
                cs.setString(7, county);
                cs.setString(8, country);
                cs.setInt(9, (int) this.getMinSleepTime());
                cs.setInt(10, (int) this.getMaxSleepTime());
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
                //logger.log(Level.SEVERE, "Exception : ", e);
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

    public void close() {
    }

    private class NLSSupport {

        String language = null;
        String territory = null;

    }

}
