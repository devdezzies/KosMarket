package com.kosmarket.models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;


public class Product extends Model<Product> {
    private int id;
    private String name;
    private String description;
    private double price;
    private int itemCount;
    private Timestamp createdAt;
    private ProductCategory category;
    private String imageUrl;
    private int categoryId;
    private int memberId;



    public Product() {
        super();
        this.table = "product";
        this.primaryKey = "id";
    }

    public Product(String name, String description, double price, int itemCount, ProductCategory category, String imageUrl, int categoryId, int memberId) {
        this();
        this.name = name;
        this.description = description;
        this.price = price;
        this.itemCount = itemCount;
        this.category = category;
        this.imageUrl = imageUrl;
        this.categoryId = categoryId;
        this.memberId = memberId;
    }


    @Override
    Product toModel(ResultSet rs) {
        try {
            Product product = new Product();
            product.setId(rs.getInt("id"));
            product.setMemberId(rs.getInt("memberId"));
            product.setName(rs.getString("name"));
            product.setDescription(rs.getString("description"));
            product.setPrice(rs.getDouble("price"));
            product.setItemCount(rs.getInt("itemCount"));
            product.setImageUrl(rs.getString("imageUrl"));
            product.setCreatedAt(rs.getTimestamp("createdAt"));

            int categoryId = rs.getInt("categoryId");
            product.setCategoryId(categoryId);

            ProductCategory category = new ProductCategory().find(String.valueOf(categoryId));
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

    public int getMemberId() {
        return memberId;
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

    public int getCategoryId() {
        return categoryId;
    }

    public ProductCategory getCategory() {
        return category;
    }


    public String getImageUrl() {
        return imageUrl;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
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

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }


    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
