package com.playzone.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.playzone.util.DBConnection;

public class AdminDAO {

    public int[] getDashboardStats() throws SQLException {

        int[] stats = new int[3];

        String sql =
            "SELECT "
            + "(SELECT COUNT(*) FROM users) AS total_users, "
            + "(SELECT COUNT(*) FROM arenas WHERE is_active = TRUE) AS total_arenas, "
            + "(SELECT COUNT(*) FROM bookings) AS total_bookings";

        Connection con = DBConnection.getConnection();

        if (con == null) {
            throw new SQLException("Database connection failed.");
        }

        try (con;
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                stats[0] = rs.getInt("total_users");
                stats[1] = rs.getInt("total_arenas");
                stats[2] = rs.getInt("total_bookings");
            }
        }

        return stats;
    }
}