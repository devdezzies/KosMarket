package com.kosmarket.utils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JDBC {
    private Connection connection;
    private Statement stmt;
    private boolean isConnected;
    private String message;

    public void connect() {
        String dbName = "kosmarket";
        String username = "root";
        String password = "";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + dbName, username, password);
            stmt = connection.createStatement();
            isConnected = true;
            message = "Connected to database";
        } catch (Exception e) {
            isConnected = false;
            message = "Error: " + e.getMessage();
        }
    }

    public void disconnect() {
        try {
            stmt.close();
            connection.close();
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }
    }

    public void runQuery(String query) {
        try {
            connect();
            int result = stmt.executeUpdate(query);
            message = "info: " + result + " rows affected";
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
            System.out.println(e.getMessage());
        } finally {
            disconnect();
        }
    }

    public String getMessage() {
        return message;
    }

    public ResultSet getData(String query) {
        ResultSet rs = null;
        try {
            connect();
            rs = stmt.executeQuery(query);
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }
        return rs;
    }
}
