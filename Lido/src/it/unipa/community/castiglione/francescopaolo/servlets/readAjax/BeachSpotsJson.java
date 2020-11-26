package it.unipa.community.castiglione.francescopaolo.servlets.readAjax;

import it.unipa.community.castiglione.francescopaolo.utils.DBMSHandler;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class beachJson
 */
@WebServlet("/beachSpots.json")
public class BeachSpotsJson extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BeachSpotsJson() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		PrintWriter out=response.getWriter();
        String op = request.getParameter("op");

        //Gets the total number of chairs
        if(op.equals("numberOfChairs")){
        	try {
				out.println(DBMSHandler.getNumberOfChairs());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}      	
        }else if(op.equals("map")){
    		response.setContentType("application/json");
        	String date = request.getParameter("Date");
            String time = request.getParameter("Time");
			try {
				//Gets the free chairs in JSON format
				out.println(DBMSHandler.getFreeChairs(date,time));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }else if(op.equals("beachStatus")){
    		response.setContentType("application/json");
        	String date = request.getParameter("Date");
            String time = request.getParameter("Time");
			try {
				//Gets the booked spots in JSON format
				out.println(DBMSHandler.getBookedChairs(date,time));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }else if(op.equals("getEmails")){
    		response.setContentType("application/json");			
    		try {
    			//Gets all the emails for all the Customers
				out.println(DBMSHandler.getEmails());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
