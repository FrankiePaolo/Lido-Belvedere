package it.unipa.community.castiglione.francescopaolo.servlets.read;

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
@WebServlet("/beachJson")
public class beachJson extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public beachJson() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String op=request.getParameter("op");
		response.setContentType("application/json");
		PrintWriter out=response.getWriter();
		if(op!=null) {
			if(op.equals("list")) {
				try {
					out.println(DBMSHandler.getChairs());
				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}else if(op.equals("status")) {
                String date = request.getParameter("Date");
                String time = request.getParameter("Time");
                if(date!=null && time!=null){
                    try {
						out.println(DBMSHandler.getFreeChairs(date,time));
					} catch (ClassNotFoundException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
                }
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
