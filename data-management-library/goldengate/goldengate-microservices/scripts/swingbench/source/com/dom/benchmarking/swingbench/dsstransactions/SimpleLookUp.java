package com.dom.benchmarking.swingbench.dsstransactions;


import com.dom.benchmarking.swingbench.event.JdbcTaskEvent;
import com.dom.benchmarking.swingbench.kernel.DatabaseTransaction;
import com.dom.benchmarking.swingbench.kernel.SwingBenchException;
import com.dom.benchmarking.swingbench.kernel.SwingBenchTask;
import com.dom.benchmarking.swingbench.utilities.RandomGenerator;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.Map;


public class SimpleLookUp extends DatabaseTransaction {

    private PreparedStatement ps = null;

    public SimpleLookUp() {
    }

    public void init(Map params) {
    }

    public void execute(Map params) throws SwingBenchException {
        Connection connection = (Connection) params.get(SwingBenchTask.JDBC_CONNECTION);
        initJdbcTask();
        long executeStart = System.nanoTime();
        try {
            if (ps == null) {
                ps = connection.prepareStatement("select count(quantity_sold) from sales where cust_id = ?");
            }

            int ci = RandomGenerator.randomInteger(1, 1549999992);
            ps.setInt(1, ci);

            ResultSet rs = ps.executeQuery();
            rs.next();
            rs.close();
            addSelectStatements(1);
            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), true, getInfoArray()));
        } catch (SQLException ex) {
            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), false, getInfoArray()));
            throw new SwingBenchException(ex);
        }
    }

    public void close() {
    }

}
