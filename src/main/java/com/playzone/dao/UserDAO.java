
package com.playzone.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.playzone.model.User;
import com.playzone.util.DBConnection;

public class UserDAO {

    public boolean registerUser(User user) throws SQLException {

        String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";

        Connection con = DBConnection.getConnection();

        if (con == null) {
            throw new SQLException("Database connection failed.");
        }

        try (con; PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());

            return ps.executeUpdate() > 0;
        }
    }

public User getUserByEmail(String email) throws SQLException {

    String sql = "SELECT user_id, name, email, password, role "
               + "FROM users WHERE email = ?";

    Connection con = DBConnection.getConnection();

    if (con == null) {
        throw new SQLException("Database connection failed.");
    }

    try (con; PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, email);

        try (ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {

                User user = new User(
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("password")
                );

                user.setUserId(rs.getInt("user_id"));
                user.setRole(rs.getString("role"));

                return user;
            }
        }
    }

    return null;
}

}
