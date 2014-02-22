package servlets;
import java.util.*;
import java.io.*;
import java.sql.*;
import javabeans.ErrorPrinter;
import javabeans.Member;
import javabeans.TomsUtility;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * 
 * @author 3tomr
 *
 */
public class NewMemberServlet extends HttpServlet
{
	private String firstName, lastName, email, address, city, zip, state, phone, 
					password, passwordHint, memberSearch, creditCardExpDate, creditCardNum, creditCardMonth, todayDate, confirmPassword, 
					membersTodayDate, membersCreditCardExpDate;
	
	boolean formPartialEmpty, formEmpty, passwordMatch;
	private static String todayMonth;
	static int todayYear, todayDay;
	private int creditCardYear, creditCardDay;
	private Member member;
	private TomsUtility t;
	private ErrorPrinter errorPrinter;
	
	public void doPost (HttpServletRequest req, HttpServletResponse res)
    	throws ServletException, IOException
	{
		Calendar today = Calendar.getInstance();
		HttpSession session = req.getSession();
		synchronized(session){
			try{
				
				t = new TomsUtility();
				formEmpty = false;
				creditCardDay = 0;
				//Enumeration pageNames = 
				member = (Member)session.getAttribute("member");
				errorPrinter = (ErrorPrinter)session.getAttribute("errorPrinter");
				
				Class.forName("org.postgresql.Driver");
				String URL = "jdbc:postgresql:postgres";
				Connection con = DriverManager.getConnection(URL, "postgres", "user");
				Statement st = con.createStatement();
				ResultSet rs = null;
				if(errorPrinter == null){
					errorPrinter = new ErrorPrinter();
				}
				email = req.getParameter("email");
				firstName = req.getParameter("firstName");
			 	lastName = req.getParameter("lastName");
			 	address = req.getParameter("address");
			 	city = req.getParameter("city");
			 	state = req.getParameter("state");
			 	zip = req.getParameter("zipCode");
			 	phone = req.getParameter("phoneNumber");
			 	creditCardNum = req.getParameter("creditCardNumber");
			 	creditCardMonth = req.getParameter("month").toUpperCase(Locale.US);
			 	creditCardYear = Integer.parseInt(req.getParameter("year"));
			 	password = req.getParameter("password");
			 	confirmPassword = req.getParameter("passwordConfirm");
			 	passwordHint = req.getParameter("passwordHint");
			 	todayDay = today.get(Calendar.DAY_OF_MONTH);
			 	todayMonth = t.getMonth(today.get(Calendar.MONTH)).toUpperCase(Locale.US);
			 	todayYear = today.get(Calendar.YEAR);
			 	todayDate = "TO_DATE('"+ todayDay + "-" + todayMonth + "-" + todayYear + "', 'DD-MON-YYYY')";
			 	membersTodayDate = ""+ todayDay + "-" + todayMonth + "-" + todayYear + "";
			 	membersCreditCardExpDate = "" + creditCardDay + "-" + creditCardMonth + "-" + creditCardYear + "";
			 	creditCardExpDate = "TO_DATE('" + creditCardDay + "-" + creditCardMonth + "-" + creditCardYear + "', 'DD-MON-YYYY')";
			 	
			 	String sqlInsert = "INSERT INTO CUSTOMERS (email, fname, lname, address, city, state, zip_code, phone_number, password, password_hint, registered_date, credit_card, credit_card_exp_date)"+
			 						"VALUES('" + email + "','" + firstName + "','" + lastName+"',"+
			 						"'" + address + "','" + city + "','" + state + "', "+
			 						"'" + zip + "','" + phone + "','" + password + "', "+
			 						"'" + passwordHint + "', " +todayDate+ ", '"+ creditCardNum +"',"+
			 						"" +creditCardExpDate+ ");";
			 	
			 	memberSearch = "SELECT email FROM CUSTOMERS WHERE email = '" + email + "';";
			 	
				if(!formEmpty && password.equals(confirmPassword)){
					
				 	
					if(member == null){
						member = new Member(email, firstName, lastName, address, city, state, zip, phone, 
											password, passwordHint, membersTodayDate, creditCardNum, membersCreditCardExpDate );
					}
						
						 	rs = st.executeQuery(memberSearch);
						 	if(rs.next()){
						 		//Member with that email exists, sorry try again
						 		con.close();
						 		member.setIsLoggedIn(false);
						 		session.setAttribute("member", member);
								res.sendRedirect(res.encodeRedirectURL("../newMemberRegistration.jsp?login=exists"));
							}else{
								
								//You Are good be registered!
								member.setIsLoggedIn(true);
								session.setAttribute("member", member);
								st.executeUpdate(sqlInsert);
								con.close();
								res.sendRedirect(res.encodeRedirectURL("../registrationSuccessful.jsp"));
							}
				}else{
					//Password does not equal the confirm password or form is empty
					con.close();
					member.setIsLoggedIn(false);
					session.setAttribute("member", member);
					res.sendRedirect(res.encodeRedirectURL("../newMemberRegistration.jsp?formIncomplete=true"));
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


