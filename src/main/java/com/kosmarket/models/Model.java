package com.kosmarket.models;

import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


public abstract class Model<E> {

    private Connection con;
    private Statement stmt;
    private boolean isConnected;
    private String message;
    protected String table;
    protected String primaryKey;
    protected String select = "*";
    private String where = "";
    private String join = "";
    private String otherQuery = "";

    public void connect() {
        String dbName = "kosmarket";
        String username = "root";
        String password = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection( "jdbc:mysql://localhost:3306/" + dbName, username, password);
            stmt = con.createStatement();
            isConnected = true;
            message = "Database Terkoneksi";
        } catch (ClassNotFoundException | SQLException e) {
            isConnected = false;
            message = e.getMessage();
        }
    }

    public void disconnect() {
        try {
            stmt.close();
            con.close();
        } catch (SQLException e) {
            message = e.getMessage();
        }
    }

    public void insert() {
        try {
            connect();
            String cols = "";
            String values = "";
            for (Field field : this.getClass().getDeclaredFields()) {
                field.setAccessible(true);
                String fieldName = field.getName();

                if (java.lang.reflect.Modifier.isStatic(field.getModifiers()) ||
                        fieldName.equals("address") || fieldName.equals("bookmark") || fieldName.equals("postedProducts")) {
                    continue;
                }

                Object value = field.get(this);

                if (value != null) {
                    cols += fieldName + ", ";

                    if (value instanceof java.util.Date) {
                        values += "'" + new java.sql.Timestamp(((java.util.Date) value).getTime()) + "', ";
                    } else {
                        values += "'" + value.toString().replace("'", "''") + "', ";
                    }
                }
            }

            if (!cols.isEmpty()) {
                cols = cols.substring(0, cols.length() - 2);
                values = values.substring(0, values.length() - 2);
                String query = "INSERT INTO " + table + " (" + cols + ") VALUES (" + values + ")";

                int result = stmt.executeUpdate(query);
                System.out.println(result);
                message = "info insert: " + result + " rows affected";


            }
        } catch (Exception e) {
            message = e.getMessage();
            System.out.println(e.getMessage());
        } finally {
            disconnect();
        }
    }

    public void update() {
        try {
            connect();
            String values = "";
            Object pkValue = null;
            for (Field field : this.getClass().getDeclaredFields()) {
                field.setAccessible(true);
                String fieldName = field.getName();

                if (fieldName.equals(primaryKey)) {
                    pkValue = field.get(this);
                    continue;
                }

                if (java.lang.reflect.Modifier.isStatic(field.getModifiers()) ||
                    fieldName.equals("address") ||
                    fieldName.equals("bookmark") ||
                    fieldName.equals("postedProducts") ||
                    fieldName.equals("category") ||
                    fieldName.equals("member")) {
                    continue;
                }

                Object value = field.get(this);
                if (value != null) {
                    values += fieldName + " = ";
                    if (value instanceof java.util.Date) {
                        values += "'" + new java.sql.Timestamp(((java.util.Date) value).getTime()) + "', ";
                    } else {
                        values += "'" + value.toString().replace("'", "''") + "', ";
                    }
                }
            }
            if (!values.isEmpty() && pkValue != null) {
                values = values.substring(0, values.length() - 2);
                String query = "UPDATE " + table + " SET " + values + " WHERE " + primaryKey + " = '" + pkValue +"'";
                int result = stmt.executeUpdate(query);
                message = "info update: " + result + " rows affected";
            }
        } catch (IllegalAccessException | IllegalArgumentException | SecurityException | SQLException e) {
            message = e.getMessage();
        } finally {
            disconnect();
        }
    }

    public void delete() {
        try {
            connect();
            Object pkValue = 0;
            for (Field field : this.getClass().getDeclaredFields()) {
                field.setAccessible(true);
                if (field.getName().equals(primaryKey)) {
                    pkValue = field.get(this);
                    break;
                }
            }
            int result = stmt.executeUpdate("DELETE FROM " + table + " WHERE " + primaryKey + " = '" + pkValue +"'");
            message = "info delete: " + result + " rows affected";
        } catch (IllegalAccessException | IllegalArgumentException | SecurityException | SQLException e) {
            message = e.getMessage();
        } finally {
            disconnect();
        }
    }

    ArrayList<Object> toRow(ResultSet rs) {
        ArrayList<Object> res = new ArrayList<>();
        int i = 1;
        try {
            while (true) {
                res.add(rs.getObject(i));
                i++;
            }
        } catch(SQLException e) {

        }
        return res;
    }

    public ArrayList<ArrayList<Object>> query(String query) {
        ArrayList<ArrayList<Object>> res = new ArrayList<>();
        try {
            connect();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                res.add(toRow(rs));
            }
        } catch (SQLException e) {
            message = e.getMessage();
        } finally {
            disconnect();
        }
        return res;
    }

    public ArrayList<E> queryWithParams(String query, ArrayList<Object> params) {
        ArrayList<E> res = new ArrayList<>();
        try {
            connect();
            java.sql.PreparedStatement pstmt = con.prepareStatement(query);
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                res.add(toModel(rs));
            }
        } catch (SQLException e) {
            message = e.getMessage();
        } finally {
            disconnect();
        }
        return res;
    }

    abstract E toModel(ResultSet rs);

    public ArrayList<E> get() {
        ArrayList<E> res = new ArrayList<>();
        try {
            this.connect();
            String query = "SELECT " +  select + " FROM " + table;
            if (!join.equals("")) query += join;
            if (!where.equals("")) query += " WHERE " + where;
            if (!otherQuery.equals("")) query += " " + otherQuery;
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                res.add(toModel(rs));
            }
        } catch (SQLException e) {
            message = e.getMessage();
        } finally {
            disconnect();
            select = "*";
            where = "";
            join = "";
            otherQuery = "";
        }
        return res;
    }

    public E find(String pkValue) {
        try {
            connect();
            String query = "SELECT " +  select + " FROM " + table + " WHERE " + primaryKey + " = '" + pkValue +"'";
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                return toModel(rs);
            }
        } catch (SQLException e) {
            message = e.getMessage();
        } finally {
            disconnect();
            select = "*";
        }
        return null;
    }

    public int executeUpdate(String sql) {
        int result = 0;
        try {
            connect();
            result = stmt.executeUpdate(sql);
            message = result + " rows affected";
        } catch (SQLException e) {
            message = "Error executing update: " + e.getMessage();
            System.err.println("SQL Error: " + e.getMessage());
        } finally {
            disconnect();
        }
        return result;
    }
    public void select(String cols) {
        select = cols;
    }

    public void join(String table, String on) {
        join += " JOIN " + table + " ON " + on;
    }

    public void where(String cond) {
        where = cond;
    }

    public void addQuery(String query) {
        otherQuery = query;
    }

    public boolean isConnected() {
        return isConnected;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}