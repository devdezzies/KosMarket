package com.kosmarket.utils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JDBC implements AutoCloseable {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/kosmarket";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
    private static final String DB_DRIVER = "com.mysql.jdbc.Driver";

    private Connection connection;

    public JDBC() {
        connect();
    }

    private void connect() {
        try {
            Class.forName(DB_DRIVER);
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (Exception e) {
            throw new RuntimeException("Failed to connnect to database: " + e.getMessage(), e);
        }
    }

    // FOR INSERT, UPDATE, DELETE METHOD
    public int executeUpdate(String sql, Object... params) {
        try (PreparedStatement stmt = prepare(sql, params)) {
            return stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("DB update failed: " + e.getMessage(), e);
        }
    }

    // FOR "GET" METHOD
    public List<Object[]> executeQuery(String sql, Object... params) {
        try (PreparedStatement stmt = prepare(sql, params);
             ResultSet rs = stmt.executeQuery()) {
            List<Object[]> rows = new ArrayList<>();
            int cols = rs.getMetaData().getColumnCount();
            while (rs.next()) {
                Object[] row = new Object[cols];
                for (int i = 0; i < cols; i++) {
                    row[i] = rs.getObject(i + 1);
                }
                rows.add(row);
            }
            return rows;
        } catch (SQLException e) {
            throw new RuntimeException("DB query failed: " + e.getMessage(), e);
        }
    }

    private PreparedStatement prepare(String sql, Object... params) throws SQLException {
        PreparedStatement stmt = connection.prepareStatement(sql);
        for (int i = 0; i < params.length; i++) {
            stmt.setObject(i + 1, params[i]);
        }
        return stmt;
    }

    @Override
    public void close() throws Exception {
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to close database connection: " + e.getMessage(), e);
        }
    }
}
