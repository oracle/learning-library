package com.mike.CallingCircle;


import com.dom.benchmarking.swingbench.constants.Constants;
import com.dom.benchmarking.swingbench.event.JdbcTaskEvent;
import com.dom.benchmarking.swingbench.kernel.SwingBenchException;
import com.dom.benchmarking.swingbench.kernel.SwingBenchTask;

import java.io.BufferedReader;
import java.io.FileReader;

import java.sql.Connection;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.logging.Logger;


public class RetrieveHistoryProcess extends CallingCircleProcess {
    private static final Logger logger = Logger.getLogger(RetrieveHistoryProcess.class.getName());
    private static String dataFile = "qryccprocess.txt";
    private static ArrayList transactionParams = null;
    private static int tpPointer = 0;
    private static Object lock = new Object();

    public RetrieveHistoryProcess() {
    }

    public void init(Map params) throws SwingBenchException {
        String fileName = null;
        setId(RETRIEVE_HISTORY);
        customerAccount = new CustomerAccount();
        customerCallingLineIdentifier = new CustomerCallingLineIdentifier();
        callingCircleLineIdentifier = new CallingCircleLineIdentifier();

        boolean initCompleted = false;

        if ((transactionParams == null) || !initCompleted) { // load any data you might need (in this case only once)

            synchronized (lock) {
                if (transactionParams == null) {
                    transactionParams = new ArrayList();

                    try {
                        fileName = (String)params.get(Constants.CCDATADIRLOC);

                        if (fileName == null) {
                            fileName = (String)params.get(Constants.CCQUERYPROCESSFILELOC);

                            if (fileName == null) {
                                fileName = "data/" + dataFile;
                            }
                        } else {
                            fileName += dataFile;
                        }

                        logger.fine("Attempting to read : " + fileName);

                        BufferedReader br = new BufferedReader(new FileReader(fileName));
                        String data = null;
                        List<String> paramList = null;
                        while ((data = br.readLine()) != null) {
                            StringTokenizer st = new StringTokenizer(data, ",");
                            paramList = new ArrayList<String>(6);
                            while (st.hasMoreTokens()) {
                                paramList.add(st.nextToken());
                            }

                            transactionParams.add(paramList);
                        }

                        br.close();
                        logger.fine("Loaded RetrieveHistoryProcess() data into memory, transactionParams[] count =" + transactionParams.size());
                    } catch (java.io.FileNotFoundException fne) {
                        SwingBenchException sbe = new SwingBenchException("Swingbench can't find the datafile specified in the environement variables : " + fileName);
                        sbe.setSeverity(SwingBenchException.UNRECOVERABLEERROR);
                        throw sbe;
                    } catch (java.io.IOException ioe) {
                        SwingBenchException sbe = new SwingBenchException("An I/O error occured, see the following message : " + ioe.getMessage());
                        sbe.setSeverity(SwingBenchException.UNRECOVERABLEERROR);
                        throw sbe;
                    } catch (Exception e) {
                        SwingBenchException sbe = new SwingBenchException("An Unexpected error occured in init() of RetrieveHistoryProcess, see the following message : " + e.getMessage());
                        sbe.setSeverity(SwingBenchException.UNRECOVERABLEERROR);
                        throw sbe;
                    }
                }

                initCompleted = true;
            }
        }
    }

    public ArrayList getParameterSet() throws SwingBenchException {
        ArrayList parameterSet = new ArrayList();

        try {
            synchronized (lock) { // don't let all the threads access transactionParams at same time

                boolean notEndOfSet = true;
                boolean firstRecord = true;

                while (notEndOfSet) {
                    ArrayList paramList = (ArrayList)transactionParams.get(tpPointer);
                    String param = (String)paramList.get(0);

                    if (param.equals("Qry")) {
                        if (firstRecord) {
                            firstRecord = false;
                            parameterSet.add(paramList);
                            tpPointer++;
                        } else {
                            notEndOfSet = false;
                        }
                    } else {
                        parameterSet.add(paramList);
                        tpPointer++;
                    }
                }
            }
        } catch (Exception e) {
            SwingBenchException sbe = new SwingBenchException("Probably run out of transactions to process. Generate a new transaction load");
            sbe.setSeverity(SwingBenchException.UNRECOVERABLEERROR);
            throw sbe;
        }

        return parameterSet;
    }

    public void execute(Map params) throws SwingBenchException {
        Connection connection = (Connection)params.get(SwingBenchTask.JDBC_CONNECTION);
        initJdbcTask();

        long executeStart = System.nanoTime();

        try {
            ArrayList paramSet = getParameterSet(); // get a chunk of parameters
            ArrayList parameters = (ArrayList)paramSet.get(0); // get the first set

            if (!((String)parameters.get(0)).equals("Qry")) {
                throw new SwingBenchException("Parameters out of sequence");
            }

            customerAccount.setName((String)parameters.get(1));
            customerAccount.setPin((String)parameters.get(2));

            CallingLineIdentifier myCallingLineIdentifier = new CallingLineIdentifier();
            myCallingLineIdentifier.setCountryValue((String)parameters.get(3));
            myCallingLineIdentifier.setRegionValue((String)parameters.get(4));
            myCallingLineIdentifier.setCallingLineIdentifier((String)parameters.get(5));
            customerCallingLineIdentifier.setCallingLineIdentifier(myCallingLineIdentifier);

            long start = System.nanoTime();

            try {
                getCustomerAccount(connection);
                processTransactionEvent(true, (System.nanoTime() - start), GET_CUSTOMER_TX);
            } catch (SwingBenchException sbe) {
                processTransactionEvent(false, (System.nanoTime() - start), GET_CUSTOMER_TX);
                throw new SwingBenchException(sbe);
            }

            addDML(1, 0, 1, 0, 1, 0);
            start = System.nanoTime();

            try {
                getCustomerCallingLineIdentifier(connection);
                processTransactionEvent(true, (System.nanoTime() - start), GET_CUSTOMER_CLI_TX);
            } catch (SwingBenchException sbe) {
                processTransactionEvent(false, (System.nanoTime() - start), GET_CUSTOMER_CLI_TX);
                throw new SwingBenchException(sbe);
            }

            addDML(2, 0, 0, 0, 0, 0);
            start = System.nanoTime();

            try {
                qryCallingCircleHistory(connection);
                processTransactionEvent(true, (System.nanoTime() - start), QRY_CLIS_CURRENT_TX);
            } catch (SwingBenchException sbe) {
                processTransactionEvent(false, (System.nanoTime() - start), QRY_CLIS_CURRENT_TX);
                throw new SwingBenchException(sbe);
            }

            addDML(11, 0, 0, 0, 0, 0);
            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), true, getInfoArray()));
        } catch (SwingBenchException sbe) {
            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), false, getInfoArray()));

            try {
                connection.rollback();
            } catch (SQLException se) {
            }

            throw new SwingBenchException(sbe);
        }
    }

    public void close() {
    }
}
