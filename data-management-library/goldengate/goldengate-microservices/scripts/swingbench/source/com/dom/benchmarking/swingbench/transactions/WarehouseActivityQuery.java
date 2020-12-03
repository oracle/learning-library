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


public class WarehouseActivityQuery extends OrderEntryProcess {
    private static final Logger logger = Logger.getLogger(WarehouseActivityQuery.class.getName());
    private PreparedStatement ps = null;

    public WarehouseActivityQuery() {
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
                            "WITH stage1 AS -- get 12 rows of 5mins\n" +
                                    "  (SELECT\n" +
                                    "    /*+ materialize CARDINALITY(12) */\n" +
                                    "    (rownum*(1/288)) offset\n" +
                                    "  FROM dual\n" +
                                    "    CONNECT BY rownum <= 12\n" +
                                    "  ),\n" +
                                    "  stage2 AS -- get 12 rows with 2 columns, 1 col lagged behind the other\n" +
                                    "  (SELECT\n" +
                                    "    /*+ materialize CARDINALITY(12) */\n" +
                                    "    lag(offset, 1, 0) over (order by rownum) ostart,\n" +
                                    "    offset oend\n" +
                                    "  FROM stage1\n" +
                                    "  ),\n" +
                                    "  stage3 AS -- transform them to timestamps\n" +
                                    "  (SELECT\n" +
                                    "    /*+ materialize CARDINALITY(12) */\n" +
                                    "    (systimestamp - ostart) date1,\n" +
                                    "    (systimestamp - oend) date2\n" +
                                    "  FROM stage2\n" +
                                    "  )\n" +
                                    "SELECT warehouse_id, date1,\n" +
                                    "  date2,\n" +
                                    "  SUM(orders.order_total) \"Value of Orders\",\n" +
                                    "  Count(1) \"Number of Orders\"\n" +
                                    "FROM stage3,\n" +
                                    "  orders\n" +
                                    "WHERE order_date BETWEEN date2 AND date1\n" +
                                    "and warehouse_id = ?\n" +
                                    "GROUP BY warehouse_id, date1,\n" +
                                    "  date2\n" +
                                    "ORDER BY date1,\n" +
                                    "  date2 DESC");
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
