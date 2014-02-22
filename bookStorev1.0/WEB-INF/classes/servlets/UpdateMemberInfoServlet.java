package servlets;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Locale;

import javabeans.ErrorPrinter;
import javabeans.Member;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 
 * @author 3tomr
 *
 */
public class UpdateMemberInfoServlet extends HttpServlet{
	
	private ErrorPrinter errorPrinter;
	private String firstName, lastName, address, city, zip, state, phone, 
	password, passwordHint, creditCardExpDate, creditCardNum, creditCardMonth,SQLUpdate,
	membersCreditCardExpDate;
	private int creditCardYear;
	private int creditCardDay =0;
	Member member;
	public void doPost (HttpServletRequest req, HttpServletResponse res)
	throws ServletException, IOException
{
		HttpSession session = req.getSession();
		member = (Member)session.getAttribute("member");
		errorPrinter = (ErrorPrinter)session.getAttribute("errorPrinter");
		errorPrinter = (ErrorPrinter)session.getAttribute("errorPrinter");
				
		synchronized(session){
			try
			{
				Class.forName("org.postgresql.Driver");
				String URL = "jdbc:postgresql:postgres";
				Connection con = DriverManager.getConnection(URL, "postgres", "user");
				Statement st = con.createStatement();
				
				firstName = req.getParameter("fname");
			 	lastName = req.getParameter("lname");
			 	address = req.getParameter("address");
			 	city = req.getParameter("city");
			 	state = req.getParameter("state");
			 	zip = req.getParameter("zip");
			 	phone = req.getParameter("phone");
				password = req.getParameter("password");
			 	passwordHint = req.getParameter("passwordHint");
			 	creditCardNum = req.getParameter("creditCard");
			 	creditCardMonth = req.getParameter("month").toUpperCase(Locale.US);
			 	creditCardYear = Integer.parseInt(req.getParameter("year"));
			 	creditCardExpDate = "TO_DATE('" + creditCardDay + "-" + creditCardMonth + "-" + creditCardYear + "', 'DD-MON-YYYY')";
			 	membersCreditCardExpDate = "" + creditCardDay + "-" + creditCardMonth + "-" + creditCardYear + "";
			 	
			 	//set the news member values into the session
			 	member.setFname(firstName);
			 	member.setLname(lastName);
			 	member.setAddress(address);
			 	member.setCity(city);
			 	member.setState(state);
			 	member.setZip(zip);
			 	member.setPhone(phone);
			 	member.setPassword(password);
			 	member.setPasswordHint(passwordHint);
			 	member.setCreditCardExpDate(membersCreditCardExpDate);
			 	
			 	
			 	SQLUpdate = "UPDATE CUSTOMERS SET fname ='"+firstName+"', lname ='"+lastName+"', address='"+address+"', city='"+city+"', state='"+state+"', zip_code ='"+zip+"', phone_number='"+phone+"', "+
			 				"password='"+password+"', password_hint='"+passwordHint+"', credit_card='"+creditCardNum+"', credit_card_exp_date="+creditCardExpDate+" "+
			 				"WHERE email ='"+member.getEmail()+"'";
			 	
				//execute update for member
				st.executeUpdate(SQLUpdate);
				con.close();
				session.setAttribute("member", member);
				res.sendRedirect(res.encodeRedirectURL("../memberInformation.jsp"));
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
