package com.kosmarket.models;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Product extends Model<Product> {
    private int id;
    private String name;
    private String description;
    private double price;
    private int itemCount;
    private ProductCategory category;
    private String location;
    private String imageUrl;

    public Product() {
        super();
        this.table = "product";
        this.primaryKey = "id";
    }

    public Product(String name, String description, double price, int itemCount, ProductCategory category, String location, String imageUrl) {
        this();
        this.name = name;
        this.description = description;
        this.price = price;
        this.itemCount = itemCount;
        this.category = category;
        this.location = location;
        this.imageUrl = imageUrl;
    }

    @Override
    Product toModel(ResultSet rs) {
        try {
            Product product = new Product();
            product.setId(rs.getInt("id"));
            product.setName(rs.getString("name"));
            product.setDescription(rs.getString("description"));
            product.setPrice(rs.getDouble("price"));
            product.setItemCount(rs.getInt("itemCount"));
            product.setImageUrl(rs.getString("imageUrl"));

            ProductCategory categoryModel = new ProductCategory();
            int categoryId = rs.getInt("categoryId");
            ProductCategory category = categoryModel.find(String.valueOf(categoryId));
            product.setCategory(category);

            return product;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
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

    public double getPrice() {
        return price;
    }

    public int getItemCount() {
        return itemCount;
    }

    public ProductCategory getCategory() {
        return category;
    }

    public String getLocation() {
        return location;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setItemCount(int itemCount) {
        this.itemCount = itemCount;
    }

    public void setCategory(ProductCategory category) {
        this.category = category;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
