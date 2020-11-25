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
 * Servlet implementation class RemoveBooking
 */
@WebServlet("/RemoveBooking")
public class RemoveBooking extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemoveBooking() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String date  = request.getParameter("date");
        String time  = request.getParameter("time");
        String id = request.getParameter("id");
        int chairNum;    
        PrintWriter out = response.getWriter();
        response.setContentType("text/plain;charset=UTF-8");
        
        try {
        	chairNum = Integer.parseInt(id);
        } catch (NumberFormatException e){
            out.println("WRONG_ID");
            return;
        }        

        // If the id is successfully parsed, tries to remove the booking
        try {
        	if(DBMSHandler.removeBooking(date,  time,  chairNum)) {
			    out.println("OK");
			    return;       
			} else {
			    out.println("ERROR");
			    return;
			}
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
