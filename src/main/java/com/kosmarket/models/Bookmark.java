package com.kosmarket.models;

import com.kosmarket.utils.JDBC;

import java.util.ArrayList;

public class Bookmark extends JDBC {
    private ArrayList<Product> items;

    public Bookmark() {
        items = new ArrayList<>();
    }

    public ArrayList<Product> getItems() {
        return items;
    }

    public void addItem(Product p) {
        items.add(p);
    }

    public void removeItem(Product p) {
        items.remove(p);
    }

    public Product getItem(int index) {
        return items.get(index);
    }
}
