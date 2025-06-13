package com.kosmarket.models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class Admin extends Model<Admin> {
    private int id;
    private String username;
    private String hashedPassword;
    private String email;
    private Date createdAt;

    public Admin() {
       this.table = "admin";
       this.primaryKey = "id";
    }

   public Admin(int id, String username, String hashedPassword, String email, Date createdAt) {
       this.table = "admin";
       this.primaryKey = "id";
       this.id = id;
       this.username = username;
       this.hashedPassword = hashedPassword;
       this.email = email;
       this.createdAt = createdAt;
    }

    @Override
    public Admin toModel(ResultSet rs) {
        try {
            Admin chunkAdmin = new Admin();
            chunkAdmin.setId(rs.getInt("id"));
            chunkAdmin.setUsername(rs.getString("username"));
            chunkAdmin.setHashedPassword(rs.getString("hashedPassword"));
            chunkAdmin.setEmail(rs.getString("email"));
            chunkAdmin.setCreatedAt(rs.getDate("createdAt"));
            return chunkAdmin;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return null;
        }    
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getHashedPassword() {
        return hashedPassword;
    }

    public void setHashedPassword(String hashedPassword) {
         this.hashedPassword = hashedPassword;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public boolean deleteMember(int memberId) {
        try {
            Member member = new Member();
            member.setId(memberId);
            member.delete();
            return member.getMessage().contains("rows affected");
        } catch (Exception e) {
            System.err.println("Error deleting member: " + e.getMessage());
            return false;
        }
    }

    public boolean addProductCategory(String chunkName, String chunkDescription) {
        ProductCategory newCategory = new ProductCategory(0, chunkName, chunkDescription);
        newCategory.save();
        return newCategory.getMessage().contains("rows affected");
    }

    public boolean modifyProductCategory(int categoryId, String newName, String newDescription) {
        ProductCategory category = new ProductCategory();
        ProductCategory existingCategory = category.find(String.valueOf(categoryId));
        if (existingCategory != null) {
            existingCategory.setName(newName);
            existingCategory.setDescription(newDescription);
            existingCategory.update(); 
            return existingCategory.getMessage().contains("rows affected");
        }
        return false;
    }

    public boolean deleteProductById(int productId) {
        Member deleteProduct = new Member();
        deleteProduct.setId(productId);
        deleteProduct.delete();
        return deleteProduct.getMessage().contains("rows affected");
    }

    public Admin findByEmail(String email) {
        this.where("email = '" + email + "'");
        java.util.ArrayList<Admin> result = this.get();
        if (!result.isEmpty()) {
            return result.get(0);
        }
        return null;
    }
}