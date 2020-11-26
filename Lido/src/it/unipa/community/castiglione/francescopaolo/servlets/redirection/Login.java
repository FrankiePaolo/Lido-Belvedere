package it.unipa.community.castiglione.francescopaolo.servlets.redirection;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
        HttpSession session = request.getSession();
        //It checks if the user has logged in after making an order from the menu , NOTE: only a Customer can access the Order page
		if(session.getAttribute("logged")=="false" && request.isUserInRole("Customer")){
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/User_centered/confirmOrder.jsp");
			requestDispatcher.forward(request, response);
		}else {
			session.setAttribute("firstLogin", "true");
			response.sendRedirect(request.getContextPath()+"/");
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
