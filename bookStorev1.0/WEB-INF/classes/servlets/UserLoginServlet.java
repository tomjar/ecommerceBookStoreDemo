package servlets;
import java.io.*;
import java.sql.*;
import java.util.Locale;

import javax.servlet.*;
import javax.servlet.http.*;
import javabeans.*;

/**
 * 
 * @author 3tomr
 *
 */
public class UserLoginServlet extends HttpServlet{
	
	private String firstName, lastName, email, address, city, zip, state, phone, 
					password, passwordHint, creditCardNum, membersRegisteredDate, membersCreditCardExpDate, SQLSelect;
	
	private ErrorPrinter errorPrinter;
	
	public void doPost (HttpServletRequest req, HttpServletResponse res)
	throws ServletException, IOException
{
		HttpSession session = req.getSession();
		
		email = req.getParameter("user_email");
		password = req.getParameter("password");
		
		errorPrinter = (ErrorPrinter)session.getAttribute("errorPrinter");
		Member member = (Member)session.getAttribute("member");
		
		SQLSelect = "SELECT * FROM CUSTOMERS WHERE email = '" + email + "' AND password ='" + password + "';";
		
		synchronized(session){
			try{
				
				Class.forName("org.postgresql.Driver");
				String URL = "jdbc:postgresql:postgres";
				Connection con = DriverManager.getConnection(URL, "postgres", "user");
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery(SQLSelect);
					
				if(errorPrinter == null){
					
						errorPrinter = new ErrorPrinter();
				}

				if(rs.next())
				{
					//found a matching username and password, GOOD! : )
					email = rs.getString("email");
					firstName = rs.getString("fname");
					lastName = rs.getString("lname");
					address = rs.getString("address");
				 	city = rs.getString("city");
				 	state = rs.getString("state");
				 	zip = rs.getString("zip_code");
				 	phone = rs.getString("phone_number");
				 	password = rs.getString("password");
				 	passwordHint = rs.getString("password_hint");
				 	membersRegisteredDate = rs.getString("registered_date");
				 	creditCardNum = rs.getString("credit_card");
				 	membersCreditCardExpDate = rs.getString("credit_card_exp_date");
				 	
					con.close();
					//add the member info into the session
					member = new Member(email, firstName, lastName, address, city, state, zip, phone, 
										password, passwordHint, membersRegisteredDate, creditCardNum, membersCreditCardExpDate );
					
					member.setIsLoggedIn(true);
					session.setAttribute("member", member);
					res.sendRedirect(res.encodeRedirectURL("../index.jsp?found=true"));
				}
				else
				{
					//nothing found
					member.setIsLoggedIn(false);
					con.close();
					res.sendRedirect(res.encodeRedirectURL("../index.jsp?found=false"));
				}
			}
			catch (Exception e)
			{
				//set the error
				errorPrinter.setCurrentError(e);
				session.setAttribute("errorPrinter", errorPrinter);
				res.sendRedirect(res.encodeRedirectURL("../errorOccurred.jsp"));
			}
		}
		
}


}
