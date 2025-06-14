package com.kosmarket.models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Address extends Model<Address> {
    private int id;
    private String street;
    private String number;
    private String zipCode;
    private String city;
    private String phone;

    public Address() {
        super();
        this.table = "address";
        this.primaryKey = "id";
    }

    public Address(int id, String street, String number, String zipCode, String city, String phone) {
        this();
        this.id = id;
        this.street = street;
        this.number = number;
        this.zipCode = zipCode;
        this.city = city;
        this.phone = phone;
    }

    @Override
    public Address toModel(ResultSet rs) {
        try {
            Address address = new Address();
            address.setId(rs.getInt("id"));
            address.setStreet(rs.getString("street"));
            address.setNumber(rs.getString("number"));
            address.setZipCode(rs.getString("zipCode"));
            address.setCity(rs.getString("city"));
            address.setPhone(rs.getString("phone"));
            return address;
        } catch (SQLException e) {
            System.out.println("Error parsing Address: " + e.getMessage());
            return null;
        }
    }

    public Address findAddressById(int addressId) {
        return this.find(String.valueOf(addressId)); }

    public Address findByMemberId(int memberId) {
        String sql = "SELECT * FROM " + this.table + " WHERE member_id = ?";
        ArrayList<Object> params = new ArrayList<>();
        params.add(memberId);
        ArrayList<Address> addresses = this.queryWithParams(sql, params);
        return addresses.isEmpty() ? null : addresses.get(0);
    }

    public int getId() {
        return id;
    }

    public String getStreet() {
        return street;
    }

    public String getNumber() {
        return number;
    }

    public String getZipCode() {
        return zipCode;
    }

    public String getCity() {
        return city;
    }

    public String getPhone() {
        return phone;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getFullAddress() {
        StringBuilder sb = new StringBuilder();
        if (street != null && !street.isEmpty()) {
            sb.append(street);
        }
        if (number != null && !number.isEmpty()) {
            if (sb.length() > 0) sb.append(" ");
            sb.append(number);
        }
        if (city != null && !city.isEmpty()) {
            if (sb.length() > 0) sb.append(", ");
            sb.append(city);
        }
        if (zipCode != null && !zipCode.isEmpty()) {
            if (sb.length() > 0) sb.append(" ");
            sb.append(zipCode);
        }
        return sb.toString().isEmpty() ? "Alamat tidak lengkap" : sb.toString();
    }
}