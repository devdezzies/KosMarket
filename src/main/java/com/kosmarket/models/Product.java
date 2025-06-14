package com.kosmarket.models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

public class Product extends Model<Product> {
    private int id;
    private String name;
    private Member member;
    private int memberId;
    private String description;
    private double price;
    private int itemCount;
    private Timestamp createdAt;
    private ProductCategory category;
    private String location;
    private String imageUrl;
    private int categoryId;
    
    public Product() {
        super();
        this.table = "product";
        this.primaryKey = "id";
    }

    public Product(String name, Member member, String description, double price, int itemCount, ProductCategory category, String location, String imageUrl) {
        this();
        this.name = name;
        this.member = member;
        this.memberId = member.getId();
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
            product.setCreatedAt(rs.getTimestamp("createdAt"));
            ProductCategory categoryModel = new ProductCategory();
            int categoryId = rs.getInt("categoryId");
            ProductCategory category = categoryModel.find(String.valueOf(categoryId));
            product.setCategory(category);

            int memberId = rs.getInt("memberId");
            product.setMemberId(memberId);

            Member memberModel = new Member();
            Member member = memberModel.find(String.valueOf(memberId));
            product.setMember(member);

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

    public Member getMember() { return member; }

    public int getMemberId() { return memberId; }

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

    public String getLocation() {
        return location;
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

    public void setName(String name) {
        this.name = name;
    }

    public void setMember(Member member) { this.member = member; }

    public void setMemberId(int memberId) { this.memberId = memberId; }

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

    public void setCategoryId(int category) {
        this.categoryId = category;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public ArrayList<Product> findProductByName(String name) {
        String sql = "SELECT * FROM " + this.table + " WHERE name LIKE ?";
        ArrayList<Object> params = new ArrayList<>();
        params.add("%" + name + "%");
        return this.queryWithParams(sql, params);
    }

    public ArrayList<Product> findProductById(int id) {
        String sql = "SELECT * FROM " + this.table + " WHERE id = ?";
        ArrayList<Object> params = new ArrayList<>();
        params.add(id);
        return this.queryWithParams(sql, params);
    }
}