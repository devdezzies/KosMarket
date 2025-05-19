package com.kosmarket.models;

import java.sql.ResultSet;
import java.util.Date;
import com.kosmarket.utils.JDBC;

public class Guest extends JDBC {
    public Member registerAccount(String firstName, String lastName, String email, String password) throws Exception {
        try {
            // check if email already exists
            String checkQuery = "SELECT COUNT(*) as count FROM member WHERE email = '" + email.replace("'", "''") + "'";
            ResultSet rs = getData(checkQuery);

            if (rs.next() && rs.getInt("count") > 0) {
                disconnect();
                throw new Exception("Email already exists");
            }

            disconnect(); // close the first connection

            // create new member
            Member newMember = new Member();
            newMember.setFirstName(firstName);
            newMember.setLastName(lastName);
            newMember.setEmail(email);
            newMember.setHashedPassword(password); // TODO implement hash algorithm
            newMember.setUsername(email);
            newMember.setCreatedAt(new Date());

            // insert into database
            String timestamp = new java.sql.Timestamp(newMember.getCreatedAt().getTime()).toString();
            String insertQuery = "INSERT INTO member (firstName, lastName, email, hashedPassword, username, createdAt) VALUES ('" 
                + firstName.replace("'", "''") + "', '" 
                + lastName.replace("'", "''") + "', '" 
                + email.replace("'", "''") + "', '" 
                + password.replace("'", "''") + "', '" 
                + email.replace("'", "''") + "', '" 
                + timestamp + "')";

            runQuery(insertQuery);

            String getIdQuery = "SELECT id FROM member WHERE email = '" + email.replace("'", "''") + "' ORDER BY id DESC LIMIT 1";
            ResultSet idRs = getData(getIdQuery);

            if (idRs.next()) {
                newMember.setId(idRs.getInt("id"));
                disconnect();
                return newMember;
            } else {
                disconnect();
                throw new Exception("Creating member failed, no ID obtained.");
            }
            // this will only throws email exception
        } finally {
            disconnect();
        }
    }
}
