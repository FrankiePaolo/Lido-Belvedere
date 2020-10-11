package it.unipa.community.castiglione.francescopaolo.utils;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import it.unipa.community.castiglione.francescopaolo.beans.Customer;

public class DBMSHandler {

    public static int registerCustomer(String firstName,String lastName,String password,String email) throws ClassNotFoundException {
    	// This is the SQL query, we will use the preparedStatement for increased security
        String sql_query = "INSERT INTO User (Firstname,Lastname,Email,Password) SELECT ?, ?, ?, sha2(?,256)";
        int result = 0;
        //Class.forName("com.mysql.jdbc.Driver");
    	// Tries to connect to the mysql database
        Class.forName("com.mysql.jdbc.Driver");
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/lido?serverTimezone=Europe/Rome", "root", "password");
            // Creates a statement using connection object
            PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {
            preparedStatement.setString(1, firstName);
            preparedStatement.setString(2, lastName);
            preparedStatement.setString(3, email);
            preparedStatement.setString(4, password);
            // Executes the query or update query
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
        	result=2;
            e.printStackTrace();
        }
        return result;
    }
    
    public static boolean isRegistered(String email) {
    	boolean registered=false;
    	String sql_query="SELECT * FROM User WHERE Email=?";
    	// Tries to connect to the mysql database
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/lido?serverTimezone=Europe/Rome", "root", "password");
             // Creates a statement using connection object
             PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {
             preparedStatement.setString(1, email);
             ResultSet resultSet=preparedStatement.executeQuery();
             if(resultSet.next()) {
            	 registered=true;
             }
             resultSet.close();
         } catch (SQLException e) {
             e.printStackTrace();
         }
         return registered;
    }
    
    


}
