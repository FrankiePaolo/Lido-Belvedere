package it.unipa.community.castiglione.francescopaolo.utils;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

import it.unipa.community.castiglione.francescopaolo.beans.Customer;

public class DBMSHandler {

	//This method registers the user into the database
    public static int registerCustomer(String firstName,String lastName,String email,String password) throws ClassNotFoundException {
    	// This is the SQL query, we will use the preparedStatement for increased security
        String sql_query = "INSERT INTO User (Firstname,Lastname,Email,Password) SELECT ?, ?, ?, sha2(?,256)";
        int result = 0;
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
    
    //We check if the user with provided email is a Customer
    public static boolean isCustomer(String email) {
    	boolean isCustomer = false;
    	String sql_query="SELECT Role FROM User WHERE Email=? ";
    	// Tries to connect to the mysql database
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/lido?serverTimezone=Europe/Rome", "root", "password");
             // Creates a statement using connection object
             PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {
             preparedStatement.setString(1, email);
             ResultSet resultSet=preparedStatement.executeQuery();
             if(resultSet.next()) {
            	 if(resultSet.getString("Role").equals("Customer")) {
            		 isCustomer= true;
            	 }else {
            		 isCustomer= false;
            	 }
             }
             resultSet.close();
         } catch (SQLException e) {
             e.printStackTrace();
         }
         return isCustomer;
    }
    
    //This method checks if the given email was already used by another user
    public static boolean isRegistered(String email) {
    	boolean registered=false;
    	String sql_query="SELECT * FROM User WHERE Email=? ";
    	// Tries to connect to the mysql database
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/lido?serverTimezone=Europe/Rome", "root", "password");
             // Creates a statement using connection object
             PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {
             preparedStatement.setString(1, email);
             //We only allow registration of Customers
             preparedStatement.setString(2, "Customer");
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
    
    private static String getJsonFromQuery(String JSON, String sql_query) throws ClassNotFoundException{
        Class.forName("com.mysql.jdbc.Driver");
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/lido?serverTimezone=Europe/Rome", "root", "password");
                // Creates a statement using connection object
                PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {
        		ResultSet resultSet = preparedStatement.executeQuery();
                JSON = JSONConverter.resultSetToArray(resultSet).toString();
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        return JSON;
    }
    
    public static Integer  getNumberOfChairs() throws ClassNotFoundException {
    	int numberOfChairs = 0;
    	String sql_query;
        sql_query = "SELECT COUNT(*) as count FROM Chair";        
        Class.forName("com.mysql.jdbc.Driver");
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/lido?serverTimezone=Europe/Rome", "root", "password");
                // Creates a statement using connection object  
                PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {
        		ResultSet resultSet = preparedStatement.executeQuery();           
        		 if(resultSet.next()){
        			 numberOfChairs = resultSet.getInt(1);
                 }           
            } catch (SQLException e) {
                e.printStackTrace();
            }
        return numberOfChairs;
    	
    }

    public static String getFreeChairs(String date, String time) throws ClassNotFoundException{
        String JSON = "";
        String sql_query;
        boolean flag=false;
        if(time.equals("Entire day")) {
        	flag=true;
            sql_query =
        	        "SELECT Chair.ID as id " +
        	        "FROM Chair " +
        	        "WHERE Chair.ID NOT IN ( " +
        		        "SELECT Chair_ID " +
        		        "FROM Booking " +
        		        "WHERE Booking.Date = ? )";
        } else {
        	 sql_query =
         	        "SELECT Chair.ID as id " +
         	        "FROM Chair " +
         	        "WHERE Chair.ID NOT IN ( " +
         		        "SELECT Chair_ID " +
         		        "FROM Booking " +
         		        "WHERE Booking.Date = ? AND Booking.Time = ? )";
        }

        Class.forName("com.mysql.jdbc.Driver");
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/lido?serverTimezone=Europe/Rome", "root", "password");
                // Creates a statement using connection object  
                PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {       	
        		preparedStatement.setDate(1, Date.valueOf(date));
        		if(flag == false) {
            		preparedStatement.setString(2, time);
        		}
        		ResultSet resultSet = preparedStatement.executeQuery();
                JSON = JSONConverter.resultSetToArray(resultSet).toString();
                resultSet.close();
                
            } catch (SQLException e) {
                e.printStackTrace();
            }
        return JSON;

    }
    
    public static boolean addBooking(String user, String date, String time, int chair) throws ClassNotFoundException {
        boolean success = false;
        String sql_query =  "INSERT INTO Booking (Date, Time, Chair_ID, User_ID)" +
                        "SELECT ?, ?, ?, ID from User where Email = ?";
        Class.forName("com.mysql.jdbc.Driver");
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/lido?serverTimezone=Europe/Rome", "root", "password");
            // Creates a statement using connection object        	
        	PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {
        	preparedStatement.setString(1, date);
        	preparedStatement.setString(2, time);
        	preparedStatement.setInt(3, chair);
        	preparedStatement.setString(4, user);

        	preparedStatement.executeUpdate();
            success = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }
}
