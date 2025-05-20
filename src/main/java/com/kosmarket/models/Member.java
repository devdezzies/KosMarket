package com.kosmarket.models;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

public class Member extends Account {
    private String firstName;
    private String lastName;
    private String email;
    private String profilePicture;
    private Address address;
    private Date createdAt;
    private Bookmark bookmark;
    private ArrayList<Product> postedProducts;

    // registration
    public Member() {
        super(null, null);
        this.postedProducts = new ArrayList<>();
        this.bookmark = new Bookmark();
        this.address = new Address();
        this.createdAt = new Date();
    }

    // Constructor with all fields
    public Member(String username, String hashedPassword, String firstName, String lastName, String email, 
                 String profilePicture, Address address, Date createdAt, Bookmark bookmark) {
        super(username, hashedPassword);
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.profilePicture = profilePicture;
        this.address = address;
        this.createdAt = createdAt;
        this.bookmark = bookmark;
        this.postedProducts = new ArrayList<>();
    }

    // login
    public Member(String email) {
        super(null, null);
        this.email = email;
        this.postedProducts = new ArrayList<>();
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

    public void setAddress(Address address) {
        this.address = address;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public void addProduct(Product product) {
        if (postedProducts == null) {
            postedProducts = new ArrayList<>();
        }
        postedProducts.add(product);
    }

    @Override
    public boolean login(String password) {
        try {
            String sanitizedEmail = this.email.replace("'", "''");
            String sanitizedPassword = password.replace("'", "''");
            String query = "SELECT * FROM member WHERE email = '" + sanitizedEmail + "' AND hashedPassword = '" + sanitizedPassword + "'";
            ResultSet rs = getData(query);

            if (rs.next()) {
                this.setId(rs.getInt("id"));
                this.setUsername(rs.getString("username"));
                this.setHashedPassword(rs.getString("hashedPassword"));
                this.setFirstName(rs.getString("firstName"));
                this.setLastName(rs.getString("lastName"));
                this.setEmail(rs.getString("email"));

                if (rs.getString("profilePicture") != null) {
                    this.setProfilePicture(rs.getString("profilePicture"));
                }

                if (rs.getTimestamp("createdAt") != null) {
                    this.setCreatedAt(new Date(rs.getTimestamp("createdAt").getTime()));
                } else {
                    this.setCreatedAt(new Date());
                }

                if (this.address == null) {
                    this.address = new Address();
                }

                if (this.bookmark == null) {
                    this.bookmark = new Bookmark();
                }

                if (this.postedProducts == null) {
                    this.postedProducts = new ArrayList<>();
                }

                // TODO Load user's bookmarks and posted products

                disconnect();
                return true;
            }

            disconnect();
            return false;
        } catch (Exception e) {
            System.out.println("Error during login: " + e.getMessage());
            return false;
        }
    }
}
