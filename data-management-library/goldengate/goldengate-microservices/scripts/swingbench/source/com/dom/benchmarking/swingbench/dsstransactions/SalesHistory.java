package com.dom.benchmarking.swingbench.dsstransactions;


import com.dom.benchmarking.swingbench.kernel.DatabaseTransaction;
import com.dom.benchmarking.swingbench.utilities.RandomGenerator;
import com.dom.util.OracleUtilities;

import java.sql.Connection;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


public abstract class SalesHistory extends DatabaseTransaction {
    private static final Logger logger = Logger.getLogger(SalesHistory.class.getName());
    private static List<String> weeks = new ArrayList<String>();
    private static List<String> months = new ArrayList<String>();
    private static List<String> countries = new ArrayList<String>();
    private static List<String> channels = new ArrayList<String>();
    private static List<String> years = new ArrayList<String>();
    private static List<String> products = new ArrayList<String>();
    private static List<String> quarters = new ArrayList<String>();
    private static boolean dataCached = false;
    protected static Object lock = new Object();

    public SalesHistory() {
    }

    protected void cacheData(Connection connection) throws SQLException {
        years = OracleUtilities.cacheColumnDistinctValues(connection, "TIMES", "CALENDAR_YEAR");
        //        years.add("2013");
        //        years.add("2013");
        //        years.add("2013");
        //        years.add("2013");
        //        years.add("2013");
        //        years.add("2013");
        //        years.add("2013");
        //        years.add("2013");
        //        years.add("2012");
        //        years.add("2012");
        //        years.add("2012");
        //        years.add("2012");
        //        years.add("2012");
        //        years.add("2012");
        //        years.add("2011");
        //        years.add("2011");
        //        years.add("2011");
        //        years.add("2010");
        //        years.add("2010");
        //        years.add("2010");
        //        years.add("2010");
        //        years.add("2012"); // Skew data to current year
        //        years.add("2012");
        //        years.add("2011");
        //        years.add("2009");
        //        years.add("2009");
        //        years.add("2009");
        //        years.add("2008");
        //        years.add("2008");
        weeks = OracleUtilities.cacheColumnDistinctValues(connection, "TIMES", "CALENDAR_WEEK_NUMBER");
        months = OracleUtilities.cacheColumnDistinctValues(connection, "TIMES", "CALENDAR_MONTH_DESC");
        quarters = OracleUtilities.cacheColumnDistinctValues(connection, "TIMES", "CALENDAR_QUARTER_DESC");
        countries = OracleUtilities.cacheColumnDistinctValues(connection, "COUNTRIES", "COUNTRY_ISO_CODE");
        channels = OracleUtilities.cacheColumnDistinctValues(connection, "CHANNELS", "CHANNEL_DESC");
        products = OracleUtilities.cacheColumnDistinctValues(connection, "PRODUCTS", "PROD_NAME");
        logger.fine("Cached sales history reference data");
        dataCached = true;
    }

    protected String getRandomStringData(int minNom, int maxNom, List<String> data, String surroundWith) {
        String result = "";
        try {
            int nofMon = RandomGenerator.randomInteger(minNom, maxNom);
            int start = RandomGenerator.randomInteger(0, (data.size() - nofMon));
            for (int i = start; i < (start + nofMon); i++) {
                if (surroundWith != null)
                    result = surroundWith + data.get(i).replaceAll("'", "''") + surroundWith + "," + result;
                else
                    result = data.get(i).replaceAll("'", "''") + "," + result;
            }
            result = result.substring(0, result.length() - 1);
        } catch (StringIndexOutOfBoundsException e) {
            logger.log(Level.SEVERE, "Unexpected Exception in getRandomString. String is [ " + result + " ]");
            throw e;
        }
        return result;
    }

    public List<String> getMonths() {
        return months;
    }

    public List<String> getCountries() {
        return countries;
    }

    public List<String> getChannels() {
        return channels;
    }

    public boolean isDataCached() {
        return dataCached;
    }

    public List<String> getYears() {
        return years;
    }

    public List<String> getProducts() {
        return products;
    }

    public List<String> getQuarters() {
        return quarters;
    }

    public List<String> getWeeks() {
        return weeks;
    }
}
