package it.unipa.community.castiglione.francescopaolo.servlets.writeAjax;

import it.unipa.community.castiglione.francescopaolo.beans.Customer;
import it.unipa.community.castiglione.francescopaolo.utils.DBMSHandler;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

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
		Customer customer_form=(Customer) session.getAttribute("form_results");
		
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		String password_repeat=request.getParameter("password_repeat");
		String firstName=request.getParameter("firstName");
		String lastName=request.getParameter("lastName");

		//If there is some issue during the registration process, the user does not need to type the first name and last name again
		customer_form.setFirstName(firstName);
		customer_form.setLastName(lastName);
		
		//We need to make sure the user does not give us unwanted characters
		String regex="[a-zA-Z]+";
		Pattern pattern = Pattern.compile(regex);
		
		//We need to check for missing fields
		if(email != null && password != null && password_repeat !=null && firstName != null && lastName != null ) {
			Matcher matcher=pattern.matcher(firstName);
			Matcher matcher2=pattern.matcher(lastName);
			if(!password.equals(password_repeat)) {
				//We check if the two passwords match
				response.sendRedirect(request.getContextPath()+"/RegisterCustomer?error=noMatch");
			}else if(password.length()<4) {
				//We check the password length
				response.sendRedirect(request.getContextPath()+"/RegisterCustomer?error=shortPassword");
			}else if((!matcher.matches()) | (!matcher2.matches())) {
				//We need to make sure the user does not give us unwanted characters
				response.sendRedirect(request.getContextPath()+"/RegisterCustomer?error=unexpectedCharacters");
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
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}else {
			//If there are any missing fields
			response.sendRedirect(request.getContextPath()+"RegisterCustomer?error=fields_missing");
		}	
	}

}
