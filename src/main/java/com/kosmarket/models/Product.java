package com.kosmarket.models;

import com.kosmarket.utils.JDBC;

public class Product extends JDBC {
    private int id;
    private String name;
    private String description;
    private double price;
    private int itemCount;
    private ProductCategory category;

    public Product(String name, String description, double price, int itemCount, ProductCategory category) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.itemCount = itemCount;
        this.category = category;
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
}
