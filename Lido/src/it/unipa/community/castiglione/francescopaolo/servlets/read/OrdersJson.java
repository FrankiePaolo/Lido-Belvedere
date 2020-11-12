package it.unipa.community.castiglione.francescopaolo.servlets.read;

import it.unipa.community.castiglione.francescopaolo.utils.DBMSHandler;
import java.io.PrintWriter;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class OrdersJson
 */
@WebServlet("/OrdersJson")
public class OrdersJson extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrdersJson() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user = (request.isUserInRole("Cook")?null:request.getRemoteUser());
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        String op = request.getParameter("op");
        if(op!=null && op.equals("list")) {
            if (user == null) {
                out.println(DBMSHandler.getOrders());
            } else {
                out.println(DBMSHandler.getOrders(user));
            }
        } else if (op != null && op.equals("info")){
            String id_s = request.getParameter("id");
            int id;
            try {
                id = Integer.parseInt(id_s);
            } catch (NumberFormatException e){
                out.println("");
                return;
            }
            if (user == null) {
                out.println(DBMSHandler.getOrderInfo(id));
            } else {
                out.println(DBMSHandler.getOrderInfo(user, id));
            }
        } else {
            out.println("");
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
