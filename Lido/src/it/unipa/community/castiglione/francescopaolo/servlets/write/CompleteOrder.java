package it.unipa.community.castiglione.francescopaolo.servlets.write;
import it.unipa.community.castiglione.francescopaolo.beans.Cart;
import it.unipa.community.castiglione.francescopaolo.utils.DBMSHandler;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;

/**
 * Servlet implementation class CompleteOrder
 */
@WebServlet("/CompleteOrder")
public class CompleteOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CompleteOrder() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 	PrintWriter out = response.getWriter();
	        response.setContentType("text/plain;charset=UTF-8");
	        String user=request.getRemoteUser();
	        HttpSession session = request.getSession();
	        Cart cart = (Cart) session.getAttribute("cart");
	        if (cart == null){
	            out.println("UNEXPECTED_ACCESS");
	            return;
	        }
	        if(DBMSHandler.addOrder(user, cart) && request.isUserInRole("Customer")){
	            out.println("OK");
	            cart.emptyCart();
	        } else if(!request.isUserInRole("Customer")) {
	        	session.setAttribute("logged", "false");
		        out.println("USER_NOT_LOGGED");		 
	        } else {
	            out.println("ERROR");
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
