package org.example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.MessageFormat;

public class Main {
    private static String DB_HOST = "DB_HOST";
    public static void main(String[] args) {
        System.out.println("========= begin database connection test =========");
        try {
            String host = (System.getenv(DB_HOST) != null) ? System.getenv(DB_HOST) : "localhost";
            Connection conn = DriverManager.getConnection(
                    MessageFormat.format("jdbc:mariadb://{0}:3306/demo?usessl=true", host),
                    "mariadb_user", "password");

            System.out.println("valid connection = " + conn.isValid(360));
            System.out.println("========= database connection test completed =========");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}