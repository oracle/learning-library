package com.dom.benchmarking.swingbench.transactions;


import com.dom.benchmarking.swingbench.event.JdbcTaskEvent;
import com.dom.benchmarking.swingbench.kernel.SwingBenchException;
import com.dom.benchmarking.swingbench.kernel.SwingBenchTask;
import com.dom.benchmarking.swingbench.utilities.RandomGenerator;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.Map;
import java.util.logging.Logger;


public class WarehouseOrdersQuery extends OrderEntryProcess {
    private static final Logger logger = Logger.getLogger(WarehouseOrdersQuery.class.getName());
    private PreparedStatement ps = null;

    public WarehouseOrdersQuery() {
        super();
    }

    public void init(Map params) {
    }

    public void execute(Map params) throws SwingBenchException {

        Connection connection = (Connection) params.get(SwingBenchTask.JDBC_CONNECTION);
        initJdbcTask();

        int warehouseID = RandomGenerator.randomInteger(1, 1000);

        long executeStart = System.nanoTime();

        try {
            try {

                ResultSet rs = null;
                try {
                    ps = connection.prepareStatement(
                            "SELECT order_mode,\n" +
                                    "  orders.warehouse_id,\n" +
                                    "  SUM(order_total),\n" +
                                    "  COUNT(1)\n" +
                                    "FROM orders,\n" +
                                    "  warehouses\n" +
                                    "WHERE orders.warehouse_id   = warehouses.warehouse_id\n" +
                                    "AND warehouses.warehouse_id = ?\n" +
                                    "GROUP BY cube(orders.order_mode, orders.warehouse_id)");
                    ps.setInt(1, warehouseID);
                    rs = ps.executeQuery();
                    rs.next();
                } finally {
                    hardClose(rs);
                    hardClose(ps);
                }
            } catch (SQLException se) {
                se.printStackTrace();
                throw new SwingBenchException(se.getMessage());
            }

            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), true, getInfoArray()));
        } catch (SwingBenchException sbe) {
            processTransactionEvent(new JdbcTaskEvent(this, getId(), (System.nanoTime() - executeStart), false, getInfoArray()));
            throw new SwingBenchException(sbe.getMessage());
        }
    }

    public void close() {
    }
}
