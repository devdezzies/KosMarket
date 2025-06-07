package com.kosmarket.models;

import java.sql.ResultSet;
import java.sql.SQLException;

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
}
