package it.unipa.community.castiglione.francescopaolo.servlets.read;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unipa.community.castiglione.francescopaolo.utils.DBMSHandler;

/**
 * Servlet implementation class FilterBookingsJson
 */
@WebServlet("/FilterBookingsJson.json")
public class FilterBookingsJson extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FilterBookingsJson() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
        String user=request.getRemoteUser();
        boolean isCustomer=request.isUserInRole("Customer");
       
        //If the user is not a Customer then we need to get the user email from the Request parameter (i.e. user is a Cashier)
        if(!isCustomer) {
        	user=request.getParameter("user");
        }
		int chair=Integer.parseInt(request.getParameter("chair"));
		String date=request.getParameter("date");
		String time=request.getParameter("time");
		String past=request.getParameter("past");
		PrintWriter out = response.getWriter();
		try {
			out.println(DBMSHandler.filterBookings(chair, date, time, user, past));
			return;    
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return;
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
