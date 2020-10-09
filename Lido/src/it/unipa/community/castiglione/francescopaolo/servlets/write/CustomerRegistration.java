package it.unipa.community.castiglione.francescopaolo.servlets.write;

import it.unipa.community.castiglione.francescopaolo.beans.Customer;
import it.unipa.community.castiglione.francescopaolo.utils.DBMSHandler;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CustomerRegistration
 */
@WebServlet("/CustomerRegistration")
public class CustomerRegistration extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CustomerRegistration() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session= request.getSession();
		Customer customer_form=(Customer) session.getAttribute("form_customer");
		
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		String password2=request.getParameter("password2");
		String firstName=request.getParameter("firstName");
		String lastName=request.getParameter("lastName");

		//If there is some issue during the registration process, the user does not need to type the info again
		customer_form.setEmail(email);
		customer_form.setFirstName(firstName);
		customer_form.setLastName(lastName);
		
		//We need to check for missing fields
		if(email != null && password != null && password2 !=null && firstName != null && lastName != null ) {
			//We check if the two passwords match
			if(!password.equals(password2)) {
				response.sendRedirect(request.getContextPath()+"/RegisterCustomer?error=noMatch");
			}else if(DBMSHandler.isRegistered(email)) {
				//There already is a customer with given email
				response.sendRedirect(request.getContextPath()+"/RegisterCustomer?error=mailExists");
			}else {
				try {
					int result=DBMSHandler.registerCustomer(firstName,lastName,email,password);
					if(result !=0) {
						response.sendRedirect(request.getContextPath()+"/RegisterCustomer?success=false");
					}else {
						response.sendRedirect(request.getContextPath()+"/RegisterCustomer?success=true");

					}
				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}else {
			response.sendRedirect(request.getContextPath()+"RegisterCustomer?error=fields_missing");
		}	
	}

}
