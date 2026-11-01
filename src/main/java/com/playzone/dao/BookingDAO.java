
package com.playzone.dao;

import java.util.List;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;

import com.playzone.model.Booking;
import com.playzone.util.DBConnection;

public class BookingDAO {

    // CREATE NEW BOOKING
    public boolean createBooking(int userId, int arenaId,
                                 Date bookingDate, String timeSlot)
                                 throws SQLException {

        Connection con = DBConnection.getConnection();

        if (con == null) {
            throw new SQLException("Database connection failed.");
        }

        try (con) {

            // Start transaction
            con.setAutoCommit(false);

            try {

                // STEP 1: Check whether arena exists and is active
                String priceSql =
                    "SELECT price_per_hour FROM arenas "
                    + "WHERE arena_id = ? AND is_active = 1";

                BigDecimal price;

                try (PreparedStatement ps = con.prepareStatement(priceSql)) {

                    ps.setInt(1, arenaId);

                    try (ResultSet rs = ps.executeQuery()) {

                        if (!rs.next()) {
                            throw new SQLException(
                                "Arena is inactive or does not exist. "
                                + "Arena ID: " + arenaId
                            );
                        }

                        price = rs.getBigDecimal("price_per_hour");
                    }
                }

                // STEP 2: Insert booking
                String insertSql =
                    "INSERT INTO bookings "
                    + "(user_id, arena_id, booking_date, time_slot, total_price) "
                    + "VALUES (?, ?, ?, ?, ?)";

                try (PreparedStatement ps = con.prepareStatement(insertSql)) {

                    ps.setInt(1, userId);
                    ps.setInt(2, arenaId);
                    ps.setDate(3, bookingDate);
                    ps.setString(4, timeSlot);
                    ps.setBigDecimal(5, price);

                    int rows = ps.executeUpdate();

                    if (rows > 0) {
                        con.commit();
                        return true;
                    }

                    con.rollback();
                    return false;
                }

            } catch (SQLException e) {

                con.rollback();

                // Duplicate confirmed slot
                if ("23000".equals(e.getSQLState())) {
                    throw new SQLException(
                        "This time slot is already booked. "
                        + "Please select another slot.", e
                    );
                }

                throw e;
            }

        } catch (SQLException e) {
            throw e;
        }
    }


    // GET BOOKINGS BY USER
    public List<Booking> getBookingsByUser(int userId)
            throws SQLException {

        List<Booking> bookings = new ArrayList<>();

        String sql = "SELECT b.booking_id, a.arena_name, a.sport_type, "
                   + "a.location, b.booking_date, b.time_slot, "
                   + "b.total_price, b.status "
                   + "FROM bookings b "
                   + "JOIN arenas a ON b.arena_id = a.arena_id "
                   + "WHERE b.user_id = ? "
                   + "ORDER BY b.booking_time DESC";

        Connection con = DBConnection.getConnection();

        if (con == null) {
            throw new SQLException("Database connection failed.");
        }

        try (con; PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Booking booking = new Booking();

                    booking.setBookingId(rs.getInt("booking_id"));
                    booking.setArenaName(rs.getString("arena_name"));
                    booking.setSportType(rs.getString("sport_type"));
                    booking.setLocation(rs.getString("location"));
                    booking.setBookingDate(rs.getDate("booking_date"));
                    booking.setTimeSlot(rs.getString("time_slot"));
                    booking.setTotalPrice(rs.getDouble("total_price"));
                    booking.setStatus(rs.getString("status"));

                    bookings.add(booking);
                }
            }
        }

        return bookings;
    }


    // CANCEL BOOKING
    public boolean cancelBooking(int bookingId, int userId)
            throws SQLException {

        String sql = "UPDATE bookings SET status = 'CANCELLED' "
                   + "WHERE booking_id = ? AND user_id = ? "
                   + "AND status = 'CONFIRMED'";

        Connection con = DBConnection.getConnection();

        if (con == null) {
            throw new SQLException("Database connection failed.");
        }

        try (con; PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;
        }
    }
}
