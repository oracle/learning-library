package com.dom.benchmarking.swingbench.stresstest;


import com.dom.benchmarking.swingbench.kernel.DatabaseTransaction;
import com.dom.benchmarking.swingbench.kernel.SwingBenchException;
import com.dom.benchmarking.swingbench.kernel.SwingBenchTask;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;


public abstract class StressTest extends DatabaseTransaction {

    private static boolean initRunning = false;
    private static boolean initCompleted = false;
    private static Lock lock = new ReentrantLock();
    private static Condition initFinished = lock.newCondition();
    private static AtomicInteger sequence = new AtomicInteger(1);


    public StressTest() {
    }

    public void init(Map parameters) throws SwingBenchException {
        try {
            lock.lock(); //No real need to use explicit locking, I simply prefer it
            while (initRunning) {
                initFinished.await();
            }
            if (!initRunning && !initCompleted) {
                initRunning = true;
                Connection connection = (Connection) parameters.get(SwingBenchTask.JDBC_CONNECTION);
                Statement st = connection.createStatement();
                try {
                    st.execute("drop table stressTestTable");
                } catch (SQLException ex) { // ignore the exception
                }
                st.execute(
                        "create table stressTestTable(\n" +
                                "id integer not null primary key,\n" +
                                "aint integer,\n" +
                                "afloat float,\n" +
                                "asmallvarchar varchar(10),\n" +
                                "abigvarchar varchar(1000),\n" +
                                "adate date)");
                st.execute("create index stbtidx on stressTestTable(asmallvarchar)");
                initRunning = false;
                initCompleted = true;
                initFinished.signalAll();
            }
            lock.unlock();

        } catch (InterruptedException e) {

        } catch (SQLException se) {
            SwingBenchException sbe = new SwingBenchException("Couldn't initialise the benchmark : " + se.getMessage());
            sbe.setSeverity(SwingBenchException.UNRECOVERABLEERROR);
            throw sbe;
        }
    }

    protected int getSequence() {
        return sequence.getAndIncrement();
    }

    protected int getCurrentSequence() {
        return sequence.get();
    }
}
