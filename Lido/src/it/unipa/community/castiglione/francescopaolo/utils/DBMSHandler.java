package it.unipa.community.castiglione.francescopaolo.utils;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBMSHandler {

	//This method registers the user into the database
    public static int registerCustomer(String firstName,String lastName,String email,String password) {
    	// This is the SQL query, we will use the preparedStatement for increased security
        String sql_query = "INSERT INTO User (Firstname,Lastname,Email,Password) SELECT ?, ?, ?, sha2(?,256)";
        int result = 0;
    	// Tries to connect to the mysql database
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
    
    //Gets a Sstring of the JSON from the desired SQL query
    @SuppressWarnings("unused")
	private static String getJsonFromQuery(String JSON, String sql_query) {
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
    
    //Gets the total number of chairs
    public static Integer  getNumberOfChairs() {
    	int numberOfChairs = 0;
    	String sql_query;
        sql_query = "SELECT COUNT(*) as count FROM Chair";        
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

    //Gets the free chairs as String of JSON
    public static String getFreeChairs(String date, String time) {
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
    
    //Removes the desired booking
    public static boolean removeBooking(String date, String time, int chair) {
        boolean success = false;
        String sql_query;
        sql_query="DELETE FROM lido.Booking WHERE Booking.Date = ? AND Booking.Time = ? AND Booking.Chair_ID = ? ;"; 
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/lido?serverTimezone=Europe/Rome", "root", "password");
                // Creates a statement using connection object        	
            	PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {
            	preparedStatement.setString(1, date);
            	preparedStatement.setString(2, time);
            	preparedStatement.setInt(3, chair);
            	preparedStatement.executeUpdate();
            	success=true;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        return success;
    }
    

    
    //Gets all the bookings for the Customer
    public static String getBookings(String user,String future) {
    	Date currentDate=new Date(System.currentTimeMillis());
    	String JSON = "";
        String sql_query;
        sql_query="SELECT Booking.Date as date, Booking.Time as time, Booking.Chair_ID as id, User.Email as user FROM Booking,User WHERE Booking.User_ID=User.ID AND User.Email=? "; 
        if(future.equals("true")) {
        	sql_query+="AND Booking.Date > ? ";
        }
        sql_query+="ORDER BY Booking.Date";            
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/lido?serverTimezone=Europe/Rome", "root", "password");
                // Creates a statement using connection object  
                PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {       	
        		preparedStatement.setString(1,user);
        		if(!future.equals("false")) {
        			preparedStatement.setString(2,currentDate.toString());
        		}
        		ResultSet resultSet = preparedStatement.executeQuery();
                JSON = JSONConverter.resultSetToArray(resultSet).toString();
                resultSet.close();                
            } catch (SQLException e) {
                e.printStackTrace();
            }
        return JSON;
    }
    
    //Returns only the desired bookings
    public static String filterBookings(int chair,String date,String time,String user,String past) {
    	Date currentDate=new Date(System.currentTimeMillis());
    	String JSON = "";
        String sql_query;
        sql_query="SELECT Booking.Date as date, Booking.Time as time, Booking.Chair_ID as id, User.Email as user FROM Booking,User WHERE Booking.User_ID=User.ID AND User.Email=? AND Booking.Chair_ID=? AND Booking.Time=? AND Booking.Date=? "; 
        if(past.equals("false")) {
            sql_query+="AND Booking.Date > ? ";
        }
        sql_query+="ORDER BY Booking.Date";
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/lido?serverTimezone=Europe/Rome", "root", "password");
                // Creates a statement using connection object  
                PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {       	
        		preparedStatement.setString(1,user);
        		preparedStatement.setInt(2,chair);
        		preparedStatement.setString(3,time);
        		preparedStatement.setString(4,date);
        		if(past.equals("false")) {
        			preparedStatement.setString(5,currentDate.toString());
        		}
        		ResultSet resultSet = preparedStatement.executeQuery();
                JSON = JSONConverter.resultSetToArray(resultSet).toString();
                resultSet.close();                
            } catch (SQLException e) {
                e.printStackTrace();
            }
        return JSON;
    }
    
    //Adds the booking to the DB
    public static boolean addBooking(String user, String date, String time, int chair) {
        boolean success = false;
        String sql_query =  "INSERT INTO Booking (Date, Time, Chair_ID, User_ID)" +
                        "SELECT ?, ?, ?, ID from User where Email = ?";
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
