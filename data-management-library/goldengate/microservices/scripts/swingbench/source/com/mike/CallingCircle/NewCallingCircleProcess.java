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
import java.util.logging.*;
import java.util.Map;
import java.util.StringTokenizer;


public class NewCallingCircleProcess extends CallingCircleProcess {

    private static final Logger logger = Logger.getLogger(NewCallingCircleProcess.class.getName());
    private static String dataFile = "newccprocess.txt";
    private static ArrayList transactionParams = null;
    private static int tpPointer = 0;
    private static Object lock = new Object();

    public NewCallingCircleProcess() {
    }

    public void init(Map params) throws SwingBenchException {
        String fileName = null;
        setId(NEW_CC_PROCESS);
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
                            fileName = (String)params.get(Constants.CCNEWPROCESSFILELOC);

                            if (fileName == null) {
                                fileName = "data/" + dataFile;
                            }
                        } else {
                            fileName += dataFile;
                        }

                        logger.log(Level.SEVERE, "Attempting to read : " + fileName);

                        BufferedReader br = new BufferedReader(new FileReader(fileName));
                        String data = null;

                        List<String> paramList = null;
                        while ((data = br.readLine()) != null) {
                            StringTokenizer st = new StringTokenizer(data, ",");
                            paramList = new ArrayList<String>(10);

                            while (st.hasMoreTokens()) {
                                paramList.add(st.nextToken());
                            }

                            transactionParams.add(paramList);
                        }

                        br.close();
                        logger.log(Level.SEVERE, "Loaded NewCallingCircleProcess() data into memory, transactionParams[] count =" + transactionParams.size());
                    } catch (java.io.FileNotFoundException fne) {
                        SwingBenchException sbe = new SwingBenchException("Swingbench can't find the datafile specified in the environement variables : " + fileName);
                        sbe.setSeverity(SwingBenchException.UNRECOVERABLEERROR);
                        throw sbe;
                    } catch (java.io.IOException ioe) {
                        SwingBenchException sbe = new SwingBenchException("An I/O error occured, see the following message : " + ioe.getMessage());
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

                    if (param.equals("New")) {
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

            if (!((String)parameters.get(0)).equals("New")) {
                throw new SwingBenchException("Parameters out of sequence");
            }

            customerAccount.setName((String)parameters.get(1));
            customerAccount.setPin((String)parameters.get(2));

            CallingLineIdentifier myCallingLineIdentifier = new CallingLineIdentifier();
            myCallingLineIdentifier.setCountryValue((String)parameters.get(3));
            myCallingLineIdentifier.setRegionValue((String)parameters.get(4));
            myCallingLineIdentifier.setCallingLineIdentifier((String)parameters.get(5));
            customerCallingLineIdentifier.setCallingLineIdentifier(myCallingLineIdentifier);
            customerCallingLineIdentifier.setCallingCircleId(Integer.parseInt((String)parameters.get(6)));

            long start = System.nanoTime();

            try {
                newCustomerAccount(connection);
                processTransactionEvent(true, (System.nanoTime() - start), NEW_CUSTOMER_TX);
            } catch (SwingBenchException sbe) {
                processTransactionEvent(false, (System.nanoTime() - start), NEW_CUSTOMER_TX);
                throw new SwingBenchException(sbe);
            }

            addDML(1, 1, 0, 0, 1, 0);
            start = System.nanoTime();

            try {
                getCustomerAccount(connection);
                processTransactionEvent(true, (System.nanoTime() - start), GET_CUSTOMER_TX);
            } catch (SwingBenchException sbe) {
                processTransactionEvent(false, (System.nanoTime() - start), GET_CUSTOMER_TX);
                throw new SwingBenchException(sbe);
            }

            addDML(1, 0, 1, 0, 1, 0);

            try {
                newCustomerCallingLineIdentifier(connection);
                processTransactionEvent(true, (System.nanoTime() - start), NEW_CUSTOMER_CLI_TX);
            } catch (SwingBenchException sbe) {
                processTransactionEvent(false, (System.nanoTime() - start), NEW_CUSTOMER_CLI_TX);
                throw new SwingBenchException(sbe);
            }

            addDML(2, 2, 0, 0, 1, 0);

            try {
                getCustomerCallingLineIdentifier(connection);
                processTransactionEvent(true, (System.nanoTime() - start), GET_CUSTOMER_CLI_TX);
            } catch (SwingBenchException sbe) {
                processTransactionEvent(false, (System.nanoTime() - start), GET_CUSTOMER_CLI_TX);
                throw new SwingBenchException(sbe);
            }

            addDML(2, 0, 0, 0, 0, 0);

            try {
                qryCallingCircleCurrent(connection);
                processTransactionEvent(true, (System.nanoTime() - start), GET_CIRCLE_CLIS_TX);
            } catch (SwingBenchException sbe) {
                processTransactionEvent(false, (System.nanoTime() - start), GET_CIRCLE_CLIS_TX);
                throw new SwingBenchException(sbe);
            }

            addDML(11, 0, 0, 0, 0, 0);

            for (int i = 1; i < paramSet.size(); i++) { //there should be 10, but lets make it dynamic
                parameters = (ArrayList)paramSet.get(i); // get the first set

                if (!((String)parameters.get(0)).equals("Upd")) {
                    throw new SwingBenchException("Parameters out of sequence");
                }

                customerAccount.setName((String)parameters.get(1)); //set the parameters again, we're stateless
                customerAccount.setPin((String)parameters.get(2));
                myCallingLineIdentifier = new CallingLineIdentifier();
                myCallingLineIdentifier.setCountryValue((String)parameters.get(3));
                myCallingLineIdentifier.setRegionValue((String)parameters.get(4));
                myCallingLineIdentifier.setCallingLineIdentifier((String)parameters.get(5));
                customerCallingLineIdentifier.setCallingLineIdentifier(myCallingLineIdentifier);
                callingCircleLineIdentifier.setIndexId(Integer.parseInt((String)parameters.get(6)));
                myCallingLineIdentifier = new CallingLineIdentifier();
                myCallingLineIdentifier.setCountryValue((String)parameters.get(7));
                myCallingLineIdentifier.setRegionValue((String)parameters.get(8));
                myCallingLineIdentifier.setCallingLineIdentifier((String)parameters.get(9));
                callingCircleLineIdentifier.setCallingLineIdentifier(myCallingLineIdentifier);
                thinkSleep();

                try {
                    getCustomerAccount(connection);
                    processTransactionEvent(true, (System.nanoTime() - start), GET_CUSTOMER_TX);
                } catch (SwingBenchException sbe) {
                    processTransactionEvent(false, (System.nanoTime() - start), GET_CUSTOMER_TX);
                    throw new SwingBenchException(sbe);
                }

                addDML(1, 0, 1, 0, 1, 0);

                try {
                    getCustomerCallingLineIdentifier(connection);
                    processTransactionEvent(true, (System.nanoTime() - start), GET_CUSTOMER_CLI_TX);
                } catch (SwingBenchException sbe) {
                    processTransactionEvent(false, (System.nanoTime() - start), GET_CUSTOMER_CLI_TX);
                    throw new SwingBenchException(sbe);
                }

                addDML(2, 0, 0, 0, 0, 0);

                try {
                    getCallingCircleLineIdentifiers(connection);
                    processTransactionEvent(true, (System.nanoTime() - start), GET_CIRCLE_CLIS_TX);
                } catch (SwingBenchException sbe) {
                    processTransactionEvent(false, (System.nanoTime() - start), GET_CIRCLE_CLIS_TX);
                    throw new SwingBenchException(sbe);
                }

                addDML(11, 0, 0, 0, 0, 0);

                try {
                    setCallingCircleLineIdentifier(connection);
                    processTransactionEvent(true, (System.nanoTime() - start), SET_CIRCLE_CLI_TX);
                } catch (SwingBenchException sbe) {
                    processTransactionEvent(false, (System.nanoTime() - start), SET_CIRCLE_CLI_TX);
                    throw new SwingBenchException(sbe);
                }

                addDML(2, 2, 2, 0, 1, 0);

                try {
                    qryCallingCircleCurrent(connection);
                    processTransactionEvent(true, (System.nanoTime() - start), QRY_CLIS_CURRENT_TX);
                } catch (SwingBenchException sbe) {
                    processTransactionEvent(false, (System.nanoTime() - start), QRY_CLIS_CURRENT_TX);
                    throw new SwingBenchException(sbe);
                }
            }

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
