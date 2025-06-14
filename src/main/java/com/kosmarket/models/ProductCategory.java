package com.kosmarket.models;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ProductCategory extends Model<ProductCategory> {
    private int id;
    private String name;
    private String description;

    public ProductCategory(int id, String name, String description) {
        this();
        this.id = id;
        this.name = name;
        this.description = description;
    }

    public ProductCategory() {
        super();
        this.table = "productcategory";
        this.primaryKey = "id";
    }

    @Override
    ProductCategory toModel(ResultSet rs) {
        try {
            ProductCategory category = new ProductCategory();
            category.setId(rs.getInt("id"));
            category.setName(rs.getString("name"));
            category.setDescription(rs.getString("description"));
            return category;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    @Override
    public String toString() {
        return this.name;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String desc) {
        this.description = desc;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public void save() {
        if (this.id == 0) {
            this.insert();
        } else {
            this.update();
        }
    }

    public static boolean addCategory(String name, String description) {
        ProductCategory cat = new ProductCategory();
        cat.setName(name);
        cat.setDescription(description);
        cat.save();
        return cat.getMessage() != null && cat.getMessage().contains("rows affected");
    }
    
    public boolean deleteById(int id) {
        this.setId(id);
        this.delete();
        return getMessage() != null && getMessage().contains("rows affected");
    }

    public ArrayList<ProductCategory> findById(int id) {
        String sql = "SELECT * FROM " + this.table + " WHERE id = ?";
        ArrayList<Object> params = new ArrayList<>();
        params.add(id);
        return this.queryWithParams(sql, params);
    }

    public ArrayList<ProductCategory> findByName(String name) {
        String sql = "SELECT * FROM " + this.table + " WHERE name LIKE ?";
        ArrayList<Object> params = new ArrayList<>();
        params.add("%" + name + "%");
        return this.queryWithParams(sql, params);
    }
    
    public ProductCategory findById(int id) {
        return this.find(String.valueOf(id));
    }

    public static List<ProductCategory> getAll() {
        List<ProductCategory> categories = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kosmarket", "root", "");

             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM productCategory")) {

            while (rs.next()) {
                ProductCategory category = new ProductCategory();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                categories.add(category);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }
}
