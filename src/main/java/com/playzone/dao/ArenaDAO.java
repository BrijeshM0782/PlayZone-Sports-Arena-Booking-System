
package com.playzone.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.playzone.model.Arena;
import com.playzone.util.DBConnection;

public class ArenaDAO {

    // Convert a database row into an Arena object
    private Arena mapArena(ResultSet rs) throws SQLException {

        Arena arena = new Arena(
            rs.getInt("arena_id"),
            rs.getString("arena_name"),
            rs.getString("sport_type"),
            rs.getString("location"),
            rs.getDouble("price_per_hour"),
            rs.getString("description")
        );

        arena.setActive(rs.getBoolean("is_active"));

        return arena;
    }


    // Get only active arenas
    public List<Arena> getActiveArenas() throws SQLException {

        List<Arena> arenas = new ArrayList<>();

        String sql = "SELECT arena_id, arena_name, sport_type, location, "
                   + "price_per_hour, description, is_active "
                   + "FROM arenas WHERE is_active = TRUE "
                   + "ORDER BY arena_id";

        Connection con = DBConnection.getConnection();

        if (con == null) {
            throw new SQLException("Database connection failed.");
        }

        try (con; PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                arenas.add(mapArena(rs));
            }
        }

        return arenas;
    }


    // Get all arenas for users, including inactive ones
    public List<Arena> getArenasForBooking() throws SQLException {

        List<Arena> arenas = new ArrayList<>();

        String sql = "SELECT arena_id, arena_name, sport_type, location, "
                   + "price_per_hour, description, is_active "
                   + "FROM arenas ORDER BY arena_id";

        Connection con = DBConnection.getConnection();

        if (con == null) {
            throw new SQLException("Database connection failed.");
        }

        try (con; PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                arenas.add(mapArena(rs));
            }
        }

        return arenas;
    }


    // Get all arenas for admin
    public List<Arena> getArenasForAdmin() throws SQLException {

        return getArenasForBooking();
    }


    // Add a new arena
    public boolean addArena(Arena arena) throws SQLException {

        String sql = "INSERT INTO arenas "
                   + "(arena_name, sport_type, location, "
                   + "price_per_hour, description, is_active) "
                   + "VALUES (?, ?, ?, ?, ?, TRUE)";

        Connection con = DBConnection.getConnection();

        if (con == null) {
            throw new SQLException("Database connection failed.");
        }

        try (con; PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, arena.getArenaName());
            ps.setString(2, arena.getSportType());
            ps.setString(3, arena.getLocation());
            ps.setDouble(4, arena.getPricePerHour());
            ps.setString(5, arena.getDescription());

            return ps.executeUpdate() > 0;
        }
    }


    // Update arena details
    public boolean updateArena(Arena arena) throws SQLException {

        String sql = "UPDATE arenas SET arena_name = ?, sport_type = ?, "
                   + "location = ?, price_per_hour = ?, description = ? "
                   + "WHERE arena_id = ?";

        Connection con = DBConnection.getConnection();

        if (con == null) {
            throw new SQLException("Database connection failed.");
        }

        try (con; PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, arena.getArenaName());
            ps.setString(2, arena.getSportType());
            ps.setString(3, arena.getLocation());
            ps.setDouble(4, arena.getPricePerHour());
            ps.setString(5, arena.getDescription());
            ps.setInt(6, arena.getArenaId());

            return ps.executeUpdate() > 0;
        }
    }


    // Activate or deactivate an arena
    public boolean changeArenaStatus(int arenaId, boolean active)
            throws SQLException {

        String sql = "UPDATE arenas SET is_active = ? WHERE arena_id = ?";

        Connection con = DBConnection.getConnection();

        if (con == null) {
            throw new SQLException("Database connection failed.");
        }

        try (con; PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setBoolean(1, active);
            ps.setInt(2, arenaId);

            int rowsUpdated = ps.executeUpdate();

            System.out.println("Arena ID: " + arenaId);
            System.out.println("New active status: " + active);
            System.out.println("Rows updated: " + rowsUpdated);

            return rowsUpdated > 0;
        }
    }
}
