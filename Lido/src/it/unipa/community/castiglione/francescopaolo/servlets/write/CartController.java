package it.unipa.community.castiglione.francescopaolo.servlets.write;

import it.unipa.community.castiglione.francescopaolo.beans.Cart;
import it.unipa.community.castiglione.francescopaolo.utils.JSONConverter;
import java.io.PrintWriter;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CartController
 */
@WebServlet("/CartController")
public class CartController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String op = request.getParameter("op");
	        if(op==null ){
	            return;
	        }

	        PrintWriter out = response.getWriter();
	        HttpSession session = request.getSession();
	        Cart cart = (Cart) session.getAttribute("cart");
	        // Creates a new cart bean if there aready isn't one
	        if (cart == null){
	            cart = new Cart();
	            session.setAttribute("cart",cart);
	        }

	        switch (op) {	
		        // Returns a JSON document with the cart bean data
	            case "get": {
	                response.setContentType("application/json");
	                out.write(JSONConverter.cartToArray(cart).toString());
	                break;
	            }
	            // Tries to add an item to the cart
	            case "set": {
	                response.setContentType("text/plain;charset=UTF-8");

	                String id_set = request.getParameter("id");
	                String amount_set = request.getParameter("amount");
	                int id, quantity;

	                try {
	                    id = Integer.parseInt(id_set);
	                    quantity = Integer.parseInt(amount_set);
	                } catch (NumberFormatException e) {
	                    out.println("UNEXPECTED_DATA");
	                    return;
	                }

	                cart.setItem_quantity(id, quantity);
	                out.println("OK");
	                break;
	            }
	            //Clears the data from the cart
	            case "clear": {
	                cart.emptyCart();
	                break;
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
