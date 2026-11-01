
package com.playzone.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
        "jdbc:mysql://localhost:3306/playzone_db";

    private static final String USERNAME = "root";

    private static final String PASSWORD = "tiger";

    public static Connection getConnection() {

        Connection con = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                URL, USERNAME, PASSWORD
            );

            System.out.println("Database Connected Successfully!");

        } catch (ClassNotFoundException | SQLException e) {

            System.out.println("Database Connection Failed!");
            e.printStackTrace();

        }

        return con;
    }
}
