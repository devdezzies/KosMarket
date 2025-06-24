package com.kosmarket.models;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductReport {
    private int id;
    private int productId;
    private int reporterId;
    private String reason;
    private java.sql.Timestamp createdAt;
    private String productName;
    private String reporterName;

    private Product product;
    private Member reporter;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getProductId() {
        return productId;
    }
    public void setProductId(int productId) {
        this.productId = productId;
    }
    public int getReporterId() {
        return reporterId;
    }
    public void setReporterId(int reporterId) {
        this.reporterId = reporterId;
    }
    public String getReason() {
        return reason;
    }
    public void setReason(String reason) {
        this.reason = reason;
    }
    public java.sql.Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(java.sql.Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    public String getProductName() {
        return productName;
    }

    public String getReporterName() {
        return reporterName;
    }
    public void setReporterName(String reporterName) {
        this.reporterName = reporterName;
    }

    public Product getProduct() {
        return new Product().find(String.valueOf(this.productId));
    }

    public Member getReporter() {
        return new Member().find(String.valueOf(this.reporterId));
    }

    public static void addReport(int productId, int reporterId, String reason) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kosmarket", "root", "");
             PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO productreport (product_id, reporter_id, reason) VALUES (?, ?, ?)")) {
            stmt.setInt(1, productId);
            stmt.setInt(2, reporterId);
            stmt.setString(3, reason);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static List<ProductReport> getAll() {
        List<ProductReport> reports = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kosmarket", "root", "");
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM productreport ORDER BY created_at DESC");
            ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                ProductReport report = new ProductReport();
                report.setId(rs.getInt("id"));
                report.setProductId(rs.getInt("product_id"));
                report.setReporterId(rs.getInt("reporter_id"));
                report.setReason(rs.getString("reason"));
                report.setCreatedAt(rs.getTimestamp("created_at"));
                reports.add(report);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reports;
    }

    public static void deleteReport(int reportId) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kosmarket", "root", "");
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM productreport WHERE id = ?")) {
            stmt.setInt(1, reportId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

