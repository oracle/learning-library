package com.dom.benchmarking.swingbench.transactions;

import com.dom.benchmarking.swingbench.event.JdbcTaskEvent;
import com.dom.benchmarking.swingbench.kernel.SwingBenchException;
import com.dom.benchmarking.swingbench.kernel.SwingBenchTask;
import com.dom.benchmarking.swingbench.utilities.RandomGenerator;
import com.dom.util.Utilities;

import java.io.File;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UpdateCustomerDetails extends OrderEntryProcess {

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
    private PreparedStatement addSeqPs = null;
    private PreparedStatement insAddPs = null;
    private PreparedStatement updAddPs = null;
    private static final Logger logger = Logger.getLogger(UpdateCustomerDetails.class.getName());

    public UpdateCustomerDetails() {
        super();
    }

    @Override
    public void init(Map<String, Object> params) throws SwingBenchException {
        boolean initCompleted = false;
        Connection connection = (Connection) params.get(SwingBenchTask.JDBC_CONNECTION);

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
    public void execute(Map<String, Object> params) throws SwingBenchException {
        Connection connection = (Connection) params.get(SwingBenchTask.JDBC_CONNECTION);
        initJdbcTask();
        ResultSet rs = null;

        String firstName = firstNames.get(RandomGenerator.randomInteger(0, firstNames.size()));
        String lastName = lastNames.get(RandomGenerator.randomInteger(0, lastNames.size()));
        String town = towns.get(RandomGenerator.randomInteger(0, towns.size()));
        String county = counties.get(RandomGenerator.randomInteger(0, counties.size()));
        String country = countries.get(RandomGenerator.randomInteger(0, countries.size()));
        long executeStart = System.nanoTime();


        try {
            try {
                List<Long> custIDLists = getCustomerDetailsByName(connection, firstName, lastName);
                addSelectStatements(1);
                thinkSleep();
                if (custIDLists.size() > 0) {
                    addSeqPs = connection.prepareStatement("select address_seq.nextval from dual");
                    rs = addSeqPs.executeQuery();

                    rs.next();
                    Long addId = rs.getLong(1);
                    insAddPs = connection.prepareStatement(
                            "INSERT INTO ADDRESSES    \n" +
                                    "        ( address_id,    \n" +
                                    "          customer_id,    \n" +
                                    "          date_created,    \n" +
                                    "          house_no_or_name,    \n" +
                                    "          street_name,    \n" +
                                    "          town,    \n" +
                                    "          county,    \n" +
                                    "          country,    \n" +
                                    "          post_code,    \n" +
                                    "          zip_code    \n" +
                                    "        )    \n" +
                                    "        VALUES    \n" +
                                    "        ( ?, ?, TRUNC(SYSDATE,'MI'), ?, 'Street Name', ?, ?, ?, 'Postcode', NULL)");
                    insAddPs.setLong(1, addId);
                    insAddPs.setLong(2, custIDLists.get(0));
                    insAddPs.setInt(3, RandomGenerator.randomInteger(1, HOUSE_NO_RANGE));
                    insAddPs.setString(4, town);
                    insAddPs.setString(5, county);
                    insAddPs.setString(6, country);
                    insAddPs.execute();
                    addInsertStatements(1);

                    updAddPs = connection.prepareStatement(" UPDATE CUSTOMERS SET PREFERRED_ADDRESS = ? WHERE customer_id = ?");
                    updAddPs.setLong(1, addId);
                    updAddPs.setLong(2, custIDLists.get(0));
                    updAddPs.execute();
                    addUpdateStatements(1);
                    connection.commit();
                    addCommitStatements(1);
                }

            } catch (SQLException se) {
                logger.log(Level.SEVERE, "Exception : ", se);
                throw new SwingBenchException(se.getMessage());
            } finally {
                hardClose(rs);
                hardClose(addSeqPs);
                hardClose(insAddPs);
                hardClose(updAddPs);
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

    @Override
    public void close() {
        // TODO Implement this method
    }
}
