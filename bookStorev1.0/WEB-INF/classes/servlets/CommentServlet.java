package servlets;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Random;

import javabeans.*;
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
public class CommentServlet extends HttpServlet{
	
	private ErrorPrinter errorPrinter;
	private Random rand = new Random();
	
	public void doPost (HttpServletRequest req, HttpServletResponse res) 
		throws ServletException, IOException
		{
		HttpSession session = req.getSession();
		String name = req.getParameter("name");
		String messageBody = req.getParameter("commentArea");
		int commentID = rand.nextInt(1000) + rand.nextInt(1000);
		String SQLInsert = "INSERT INTO COMMENTS(commentID, name, messageBody)VALUES('"+commentID+"','"+name+"', '"+messageBody+"');";
		
		synchronized(session){
			try
			{
				String URL = "jdbc:postgresql:postgres";
				Class.forName("org.postgresql.Driver");
				Connection con = DriverManager.getConnection(URL, "postgres", "user");
				Statement st = con.createStatement();
				if(name != null && !name.equals("") || messageBody != null && !messageBody.equals(""))
				{
					//execute update
					st.executeUpdate(SQLInsert);
					res.sendRedirect(res.encodeRedirectURL("../contactUs.jsp"));
					
				}else{
					res.sendRedirect(res.encodeRedirectURL("../contactUs.jsp?empty=true"));
				}
			}
			catch(Exception e)
			{
				//set the error
				errorPrinter.setCurrentError(e);
				session.setAttribute("errorPrinter", errorPrinter);
				res.sendRedirect(res.encodeRedirectURL("../errorOccurred.jsp"));
			}
		}
	}
}
