package com.kosmarket.models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class Member extends Model<Member> {
    private int id;
    private String firstName;
    private String lastName;
    private String email;
    private String username;
    private String hashedPassword;
    private String profilePicture;
    private int addressId;
    private Address address;
    private Date createdAt;
    private Bookmark bookmark;
    private ArrayList<Product> postedProducts;

    // registration
    public Member() {
        this.table = "member";
        this.primaryKey = "id";
    }

    // constructor with all fields
    public Member(int id, String username, String hashedPassword, String firstName, String lastName, String email,
                 String profilePicture, int addressId, Address address, Date createdAt, Bookmark bookmark) {
        this.table = "member";
        this.primaryKey = "id";
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.username = username;
        this.hashedPassword = hashedPassword;
        this.profilePicture = profilePicture;
        this.addressId = addressId;
        this.address = address;
        this.createdAt = createdAt;
        this.bookmark = bookmark;
        this.postedProducts = new ArrayList<>();
    }

    @Override
    public Member toModel(ResultSet rs) {
        try {
            Member member = new Member();
            member.setId(rs.getInt("id"));
            member.setFirstName(rs.getString("firstName"));
            member.setLastName(rs.getString("lastName"));
            member.setEmail(rs.getString("email"));
            member.setUsername(rs.getString("username"));
            member.setHashedPassword(rs.getString("hashedPassword"));
            member.setAddressId(rs.getInt("addressId"));
            member.setCreatedAt(rs.getDate("createdAt"));
            member.setProfilePicture(rs.getString("profilePicture"));
            return member;
        } catch (SQLException E) {
            System.out.println(E.getMessage());
            return null;
        }
    }

    public int getId() {
        return id;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getEmail() {
        return email;
    }

    public String getUsername() {
        return username;
    }

    public String getHashedPassword() {
        return hashedPassword;
    }

    public int getAddressId() {
        return addressId;
    }

    public Address getAddress() {
        return address;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public Bookmark getBookmark() {
        return bookmark;
    }

    public String getProfilePicture() {
        return profilePicture;
    }

    public ArrayList<Product> getPostedProducts() {
        return postedProducts;
    }

    public void addItemToBookmark(Product product) {
        if (bookmark == null) {
            bookmark = new Bookmark();
        }
        bookmark.addItem(product);
    }

    public void removeItemFromBookmark(Product product) {
        if (bookmark != null) {
            bookmark.removeItem(product);
        }
    }

    public void setBookmark(Bookmark bookmark) {
        this.bookmark = bookmark;
    }

    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setHashedPassword(String hashedPassword) {
        this.hashedPassword = hashedPassword;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void addProduct(Product product) {
        if (postedProducts == null) {
            postedProducts = new ArrayList<>();
        }
        postedProducts.add(product);
    }

    public ArrayList<Member> findByEmail(String email) {
        String sql = "SELECT * FROM " + this.table + " WHERE email = ?";
        ArrayList<Object> params = new ArrayList<>();
        params.add(email);
        return this.queryWithParams(sql, params);
    }

    public ArrayList<Member> findByUsername(String username) {
        String sql = "SELECT * FROM " + this.table + " WHERE username = ?";
        ArrayList<Object> params = new ArrayList<>();
        params.add(username);
        return this.queryWithParams(sql, params);
    }
}
