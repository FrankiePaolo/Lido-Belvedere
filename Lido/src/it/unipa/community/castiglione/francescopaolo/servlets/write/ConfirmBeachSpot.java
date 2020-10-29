package it.unipa.community.castiglione.francescopaolo.servlets.write;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import it.unipa.community.castiglione.francescopaolo.utils.DBMSHandler;


/**
 * Servlet implementation class ConfirmBeachSpot
 */
@WebServlet("/ConfirmBeachSpot")
public class ConfirmBeachSpot extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ConfirmBeachSpot() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user  = request.getParameter("user");
        String date  = request.getParameter("date");
        String time  = request.getParameter("time");
        String chair = request.getParameter("chair");
        int chairNum;                   
        PrintWriter out = response.getWriter();
        response.setContentType("text");
        chairNum = Integer.parseInt(chair);
        
        if(request.isUserInRole("Customer")) {
        	user= request.getRemoteUser();
        };

        // Adds the reservation
        try {
        	if (!DBMSHandler.isRegistered(user)) {
				out.println("USER_NOT_REGISTERED");
				return;
        	} else if (!DBMSHandler.isCustomer(user)) {
				out.println("USER_NOT_CUSTOMER");
				return;  	       	
			} else if(DBMSHandler.addBooking(user, date, time, chairNum)) {
			    out.println("OK");
			    return;       
			} else {
			    out.println("ERROR");
			    return;
			}
		} catch (ClassNotFoundException e) {
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
