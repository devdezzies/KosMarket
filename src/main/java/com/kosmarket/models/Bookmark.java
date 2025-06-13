package com.kosmarket.models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Bookmark extends Model<Bookmark> {

    private int bookmarkId;
    private int memberId;
    private int productId;
    private java.util.Date createdAt;

    public Bookmark() {
        this.table = "bookmark";
        this.primaryKey = "bookmarkId";
    }

    public Bookmark(int memberId, int productId) {
        this();
        this.memberId = memberId;
        this.productId = productId;
        this.createdAt = new java.util.Date();
    }

    @Override
    public Bookmark toModel(ResultSet rs) {
        Bookmark bookmark = new Bookmark();
        try {
            bookmark.setBookmarkId(rs.getInt("bookmarkId"));
            bookmark.setMemberId(rs.getInt("memberId"));
            bookmark.setProductId(rs.getInt("productId"));
            bookmark.setCreatedAt(rs.getTimestamp("createdAt"));
        } catch (SQLException e) {
            setMessage("Error mapping ResultSet to Bookmark: " + e.getMessage());
        }
        return bookmark;
    }

    // Check if product is bookmarked by user
    public boolean isBookmarked(int memberId, int productId) {
        where("memberId = " + memberId + " AND productId = " + productId);
        ArrayList<Bookmark> bookmarks = get();
        return !bookmarks.isEmpty();
    }

    // Add bookmark
    public void addBookmark(int memberId, int productId) {
        this.memberId = memberId;
        this.productId = productId;
        this.createdAt = new java.util.Date();
        insert();
    }

    // Remove bookmark
    public void removeBookmark(int memberId, int productId) {
        where("memberId = " + memberId + " AND productId = " + productId);
        ArrayList<Bookmark> bookmarks = get();

        if (!bookmarks.isEmpty()) {
            Bookmark bookmark = bookmarks.get(0);
            this.bookmarkId = bookmark.getBookmarkId();
            delete();
        }
    }

    // Getters and Setters
    public int getBookmarkId() {
        return bookmarkId;
    }

    public void setBookmarkId(int bookmarkId) {
        this.bookmarkId = bookmarkId;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public java.util.Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(java.util.Date createdAt) {
        this.createdAt = createdAt;
    }
}