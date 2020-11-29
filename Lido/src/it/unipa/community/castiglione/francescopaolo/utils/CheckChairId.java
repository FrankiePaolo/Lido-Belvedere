package it.unipa.community.castiglione.francescopaolo.utils;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

/**
 * Servlet implementation class CheckChairId
 */
@WebServlet("/CheckChairId")
public class CheckChairId extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckChairId() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 	PrintWriter out = response.getWriter();
		//We need to make sure the user provides an allowed chair ID
		String regex="[0-9]+";
		Pattern pattern = Pattern.compile(regex);
		
        response.setContentType("text/plain;charset=UTF-8");
		String chairId=request.getParameter("chairId");
		
		//We make sure the string is not empty
		if(chairId.equals("")) {
			 out.println("WRONG_ID");
		     return;
		}
		int chairNum;
		Matcher matcher=pattern.matcher(chairId);
		
		//We try to parse the chair Id
		try {
	        chairNum = Integer.parseInt(chairId);
	    } catch (NumberFormatException e){
	        out.println("WRONG_ID");
	        return;
	    }        
		
		//We check if the pattern matches the regex
		if(matcher.matches()) {
			if(DBMSHandler.isChair(chairNum)) {
				//We check if the chair is in the database
		        out.println("OK");
			}else {
		        out.println("WRONG_ID");
			}		
		}else {
            out.println("WRONG_ID");
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
