package it.unipa.community.castiglione.francescopaolo.utils;

import it.unipa.community.castiglione.francescopaolo.beans.*;
import it.unipa.community.castiglione.francescopaolo.utils.JSONConverter;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBMSHandler {
    private static DataSource dataSource = null;
	
	static {
        try {
            Context context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/lido_castiglione");
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }
	
	private static Connection connect() throws SQLException {
        return dataSource.getConnection();
    }

	//Gets the emails of all Customers
    public static String getEmails() {
    	String JSON = "";
        String sql_query;
        sql_query ="SELECT Email FROM User WHERE User.Role='Customer';";
        try (Connection connection = connect(); PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {       	
        		ResultSet resultSet = preparedStatement.executeQuery();
                JSON = JSONConverter.resultSetToArray(resultSet).toString();
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        return JSON;
    }
	

	//This method registers the user into the database
    public static int registerCustomer(String firstName,String lastName,String email,String password) {
    	// This is the SQL query, we will use the preparedStatement for increased security
        String sql_query = "INSERT INTO User (Firstname,Lastname,Email,Password) SELECT ?, ?, ?, sha2(?,256)";
        int result = 0;
    	// Tries to connect to the mysql database
        try (Connection connection = connect(); PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {
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
    
    //We check if the chair id provided exists
    public static boolean isChair(int id) {
    	boolean isChair = false;
    	String sql_query="SELECT * FROM lido_castiglione.Chair WHERE ID=?;";
    	// Tries to connect to the mysql database
        try (Connection connection = connect(); PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {
             preparedStatement.setInt(1, id);
             ResultSet resultSet=preparedStatement.executeQuery();
             if(resultSet.next()) {
            	 isChair= true;
            }else {
            	 isChair= false;
             }
             resultSet.close();
         } catch (SQLException e) {
             e.printStackTrace();
         }
         return isChair;
    }
    
    //We check if the user with provided email is a Customer
    public static boolean isCustomer(String email) {
    	boolean isCustomer = false;
    	String sql_query="SELECT Role FROM User WHERE Email=? ";
    	// Tries to connect to the mysql database
        try (Connection connection = connect(); PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {
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
    	boolean registered=true;
    	String sql_query="SELECT * FROM User WHERE Email=? ;";
    	// Tries to connect to the mysql database
        try (Connection connection = connect(); PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {
             preparedStatement.setString(1, email);
             ResultSet resultSet=preparedStatement.executeQuery();
             if(!resultSet.next()) {
            	 registered=false;
             }
             resultSet.close();
         } catch (SQLException e) {
             e.printStackTrace();
         }
         return registered;
    }
    
    //Gets a String of the JSON from the desired SQL query
	private static String getJsonFromQuery(String JSON, String sql_query) {
        try (Connection connection = connect(); PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {
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
        try (Connection connection = connect(); PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {
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
        		        "WHERE Booking.Date = ? );";
        } else {
        	 sql_query =
         	        "SELECT Chair.ID as id " +
         	        "FROM Chair " +
         	        "WHERE Chair.ID NOT IN ( " +
         		        "SELECT Chair_ID " +
         		        "FROM Booking " +
         		        "WHERE Booking.Date = ? AND ( Booking.Time = 'Entire day' OR Booking.Time = ? ) );";
        }
        try (Connection connection = connect(); PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {       	
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
    
    //Gets the booked chairs at the desired time
    public static String getBookedChairs(String date,String time) {
    	String JSON = "";
        String sql_query;
        sql_query ="SELECT Date,Time,Chair_ID,FirstName,LastName,Email FROM lido_castiglione.Booking,lido_castiglione.User WHERE Booking.User_ID=User.ID AND Date=? AND (Time=? OR Time='Entire day');";
        try (Connection connection = connect(); PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {       	
        		preparedStatement.setDate(1, Date.valueOf(date));
            	preparedStatement.setString(2, time);
        		ResultSet resultSet = preparedStatement.executeQuery();
                JSON = JSONConverter.resultSetToArray(resultSet).toString();
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        return JSON;
    }
    
    //Removes the desired booking
    public static boolean removeBooking(String date, String time, int chairNum) {
        boolean success = false;
        String sql_query;
        sql_query="DELETE FROM lido_castiglione.Booking WHERE Booking.Date = ? AND Booking.Time = ? AND Booking.Chair_ID = ? ;"; 
        try (Connection connection = connect(); PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {
            	preparedStatement.setString(1, date);
            	preparedStatement.setString(2, time);
            	preparedStatement.setInt(3, chairNum);
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
        try (Connection connection = connect(); PreparedStatement preparedStatement = connection.prepareStatement(sql_query)){
                // Creates a statement using connection object  
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
    public static String filterBookings(int chair,String date,String time,String user) {
    	String JSON = "";
        String sql_query;
        if(time.equals("Entire day")) {
            sql_query="SELECT Booking.Date as date, Booking.Time as time, Booking.Chair_ID as id, User.Email as user FROM Booking,User WHERE Booking.User_ID=User.ID AND User.Email=? AND Booking.Chair_ID=? AND Booking.Date=? "; 
        }else {
        	sql_query="SELECT Booking.Date as date, Booking.Time as time, Booking.Chair_ID as id, User.Email as user FROM Booking,User WHERE Booking.User_ID=User.ID AND User.Email=? AND Booking.Chair_ID=? AND Booking.Date=? AND (Booking.Time=? OR Booking.TIme='Entire day') "; 
        }
        sql_query+="ORDER BY Booking.Date;";
        try (Connection connection = connect(); PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {       	
        		preparedStatement.setString(1,user);
        		preparedStatement.setInt(2,chair);
        		preparedStatement.setString(3,date);
        		//In this case we don't need to specify the time in the SQL query
        		if(!time.equals("Entire day")) {       		
	        		preparedStatement.setString(4,time);
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
        try (Connection connection = connect(); PreparedStatement preparedStatement = connection.prepareStatement(sql_query)) {
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
    
    //Item is the menu item id, returns the specified item's price
    public static Float getItemPrice(Integer item) {
        float price = -1;
        String sql_query = "SELECT Food_Item.Price FROM Food_Item WHERE ID = ? ;";
        try(Connection connection = connect(); PreparedStatement statement = connection.prepareStatement(sql_query)){
            statement.setInt(1, item);
            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next()){
                price = resultSet.getFloat(1);
            }
            resultSet.close();
        } catch (SQLException e){
            e.printStackTrace();
        }
        return price;
    }
    
    //Item is a menu item , returns a string containing the item's name
    public static String getItemName(Integer item) {
        String name = "";
        String sql_query = "SELECT Food_Item.Name FROM Food_Item WHERE ID = ? ;";
        try(Connection connection = connect(); PreparedStatement statement = connection.prepareStatement(sql_query)){
            statement.setInt(1, item);
            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next()){
                name = resultSet.getString(1);
            }
            resultSet.close();
        } catch (SQLException e){
            e.printStackTrace();
        }
        return name;
    }
    
    //Returns a JSON document with the entire menu  
    public static String getItems() {
        String JSON = "";
        String sql_query = "SELECT  ID as id, Name as name, Price as price, Description as description, Category as category FROM Food_Item ORDER BY category, name ;";
        return getJsonFromQuery(JSON, sql_query);
    }
    
    //Adds an order
    public static boolean addOrder(String user, Cart cart) {
        boolean success = false;
        int orderID;
        String sql_query1 = "INSERT INTO `Order` (`User_ID`) SELECT ID FROM User where User.Email = ? ;";
        //Return the AUTO_INCREMENT id of the last row that has been inserted or updated in a table:
        String sql_query2 = "SELECT LAST_INSERT_ID() ";
        String sql_query3 = "INSERT INTO Order_has_Food_Item(Order_ID, Food_Item_ID, Amount) VALUES(?,?,?) ;";
        try(Connection connection = connect();
            PreparedStatement statement1 = connection.prepareStatement(sql_query1);
            PreparedStatement statement2 = connection.prepareStatement(sql_query2);
            PreparedStatement statement3 = connection.prepareStatement(sql_query3);
        ){
        	/* By default a Connection object is in auto-commit mode, which means that it automatically 
        	 * commits changes after executing each statement. If auto-commit mode has been disabled, 
        	 * the method commit must be called explicitly in order to commit changes; otherwise, database 
        	 * changes will not be saved.
        	 */       	
            connection.setAutoCommit(false);
            statement1.setString(1, user);
            statement1.executeUpdate();

            ResultSet resultSet = statement2.executeQuery();

            if(resultSet.next()){
                orderID = resultSet.getInt(1);
            } else {
                connection.rollback();
                return false;
            }
            resultSet.close();

            for(int itemID : cart.getItems_quantity().keySet()){
                statement3.setInt(1, orderID);
                statement3.setInt(2, itemID);
                statement3.setInt(3, cart.getItem_quantity(itemID));
                if(statement3.executeUpdate()==0){
                    connection.rollback();
                    throw new SQLException("No data inserted");
                }
            }
            connection.commit();
            success = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }
    
    //Returns a JSON String with the orders 
    public static String getOrders() {
        String JSON = "";
        String sql_query = "SELECT ID as id, State as status, `Date` as 'date' FROM `Order` WHERE NOT `Order`.State = 'delivered' order by `status` DESC,`date` DESC ";
        return getJsonFromQuery(JSON, sql_query);
    }
    
     //Returns a JSON String with the orders for the specified user
    public static String getOrders(String mail){
        String JSON = "";
        String sql_query = "SELECT Order.ID as id, State as status, `Date` as 'date' FROM `Order`, User WHERE User.Email = ? AND User.ID = `Order`.User_ID order by `date` DESC ;";
        try(Connection connection = connect(); PreparedStatement statement = connection.prepareStatement(sql_query)){
            statement.setString(1, mail);
            ResultSet resultSet = statement.executeQuery();
            JSON = String.valueOf(JSONConverter.resultSetToArray(resultSet));
            resultSet.close();
        } catch (SQLException e){
            e.printStackTrace();
        }
        return JSON;
    }
    
    //Returns the information related to the specified id order
    public static String getOrderInfo(int id) {
        String JSON = "";
        String sql_query = "SELECT Food_Item.Name as name, Order_has_Food_Item.Amount as quantity, Food_Item.Price as price " +
                "FROM `Order_has_Food_Item`, Food_Item " +
                "WHERE Order_has_Food_Item.Order_ID = ? AND Food_Item.ID = Order_has_Food_Item.Food_Item_ID";
        try(Connection connection = connect(); PreparedStatement statement = connection.prepareStatement(sql_query)){
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();
            JSON = String.valueOf(JSONConverter.resultSetToArray(resultSet));
            resultSet.close();
        } catch (SQLException e){
            e.printStackTrace();
        }
        return JSON;
    }
    
    //Returns the information related to the specified id order and user
    public static String getOrderInfo(String user, int id) {
        String JSON = "";
        String sql_query = "SELECT Food_Item.ID as id, Food_Item.Name as name, Order_has_Food_Item.Amount as quantity, Food_Item.Price as price " +
                "FROM `Order_has_Food_Item`, Food_Item, User, `Order` " +
                "WHERE Order_has_Food_Item.Order_ID = ? AND Order_has_Food_Item.Order_ID = `Order`.ID " +
                    "AND User.Email = ? AND `User`.ID = `Order`.User_ID "+
                    "AND Food_Item.ID = Order_has_Food_Item.Food_Item_ID ;";
        try(Connection connection = connect(); PreparedStatement statement = connection.prepareStatement(sql_query)){
            statement.setInt(1, id);
            statement.setString(2, user);
            ResultSet resultSet = statement.executeQuery();
            JSON = String.valueOf(JSONConverter.resultSetToArray(resultSet));
            resultSet.close();
        } catch (SQLException e){
            e.printStackTrace();
        }
        return JSON;
    }
    
    //Sets the order state, returns a boolean value
    public static boolean setOrderState(int id, String state) {
        boolean success = false;
        String query = "UPDATE `Order` SET `State` = ? WHERE `ID` = ?";
        try(Connection connection = connect(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, state);
            statement.setInt(2,id);
            success = statement.executeUpdate()!=0;
        } catch (SQLException e){
            e.printStackTrace();
        }
        return success;
    }
    
}
