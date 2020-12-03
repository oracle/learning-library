package com.dom.benchmarking.swingbench.stresstest;


import com.dom.benchmarking.swingbench.event.JdbcTaskEvent;
import com.dom.benchmarking.swingbench.kernel.SwingBenchException;
import com.dom.benchmarking.swingbench.kernel.SwingBenchTask;
import com.dom.util.RandomUtilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.Map;


public final class StressTestSelect extends StressTest {
    public StressTestSelect() {
    }

    public void execute(Map parameters) throws SwingBenchException {
        Connection connection = (Connection) parameters.get(SwingBenchTask.JDBC_CONNECTION);
        PreparedStatement selPs = null;
        ResultSet rs = null;
        boolean success = true;

        initJdbcTask();

        long executeStart = System.nanoTime();
        try {
            int selectId = RandomUtilities.randomInteger(1, getCurrentSequence());
            selPs = connection.prepareStatement("select * from stressTestTable where id = ?");
            selPs.setInt(1, selectId);
            rs = selPs.executeQuery();
            addSelectStatements(1);
        } catch (SQLException ex) {
            success = false;
            System.out.println(ex);
        } finally {
            try {
                rs.close();
                selPs.close();
            } catch (SQLException e) {
            }
            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() -
                    executeStart), success, getSelectStatements(), getInsertStatements(), getUpdateStatements(), getDeleteStatements(), getCommitStatements(), getRollbackStatements()));
        }
    }

    public void close() {

    }
}
