package com.tartaruga.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.ServletContext;

public class DatabaseUtil {
    private static String jdbcURL;
    private static String jdbcUsername;
    private static String jdbcPassword;

    public static void initialize(ServletContext context) {
        jdbcURL = context.getInitParameter("dbURL");
        jdbcUsername = context.getInitParameter("dbUser");
        jdbcPassword = context.getInitParameter("dbPassword");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }
}