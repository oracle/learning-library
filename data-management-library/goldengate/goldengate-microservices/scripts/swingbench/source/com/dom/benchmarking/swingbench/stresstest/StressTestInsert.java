package com.dom.benchmarking.swingbench.stresstest;


import com.dom.benchmarking.swingbench.event.JdbcTaskEvent;
import com.dom.benchmarking.swingbench.kernel.SwingBenchException;
import com.dom.benchmarking.swingbench.kernel.SwingBenchTask;
import com.dom.util.RandomUtilities;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import java.util.Map;


public final class StressTestInsert extends StressTest {
    public StressTestInsert() {
    }

    public void execute(Map parameters) throws SwingBenchException {
        Connection connection = (Connection) parameters.get(SwingBenchTask.JDBC_CONNECTION);
        PreparedStatement insPs = null;
        boolean success = true;

        initJdbcTask();

        long executeStart = System.nanoTime();
        try {
            insPs = connection.prepareStatement("insert into stressTestTable(id, aint, afloat, asmallvarchar, abigvarchar, adate) values (?,?,?,?,?,?)");

            insPs.setInt(1, getSequence());
            insPs.setInt(2, RandomUtilities.randomInteger(1, 9999999));
            insPs.setDouble(3, RandomUtilities.randomDouble(1, 1000));
            insPs.setString(4, RandomUtilities.randomAlpha(1, 10));
            insPs.setString(5, RandomUtilities.randomAlpha(1, 999));
            insPs.setDate(6, new Date(RandomUtilities.randomLong(System.currentTimeMillis(), System.currentTimeMillis() + 10000000)));
            insPs.execute();
            connection.commit();
            addInsertStatements(1);
            addCommitStatements(1);
        } catch (SQLException ex) {
            success = false;
            System.out.println(ex);
        } finally {
            try {
                insPs.close();
            } catch (SQLException e) {
            }
            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() -
                    executeStart), success, getSelectStatements(), getInsertStatements(), getUpdateStatements(), getDeleteStatements(), getCommitStatements(), getRollbackStatements()));
        }
    }

    public void close() {

    }
}
