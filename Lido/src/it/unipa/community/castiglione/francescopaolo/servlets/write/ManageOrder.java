package it.unipa.community.castiglione.francescopaolo.servlets.write;

import it.unipa.community.castiglione.francescopaolo.utils.DBMSHandler;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ManageOrder
 */
@WebServlet("/ManageOrder")
public class ManageOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManageOrder() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
        response.setContentType("text");

        String state = request.getParameter("state");
        String id_parameter = request.getParameter("id");
        int id;
        try {
            id = Integer.parseInt(id_parameter);
        } catch (NumberFormatException e){
            out.println("WRONG_ID");
            return;
        }
        //If we successfully parsed the id_parameter we wish to set the corresponding order state
        if(DBMSHandler.setOrderState(id,state)){
            out.println("OK");
        } else {
            out.println("UNEXPECTED_ERROR");
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
