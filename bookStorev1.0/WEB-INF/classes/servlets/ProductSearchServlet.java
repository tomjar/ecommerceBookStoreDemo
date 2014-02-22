package servlets;
import java.io.IOException;
import javabeans.Book;
import javabeans.ErrorPrinter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javabeans.BookShelf;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Random;

/**
 * 
 * @author 3tomr
 *
 */
public class ProductSearchServlet extends HttpServlet{

	private String search_string;
	private BookShelf bookShelf;
	private ErrorPrinter errorPrinter;
	Random rand = new Random();
	public void doPost (HttpServletRequest req, HttpServletResponse res)
	throws ServletException, IOException
{
		HttpSession session = req.getSession();
		
		
		synchronized(session){
			try
			{
				bookShelf = (BookShelf)session.getAttribute("bookShelfSearch");
				errorPrinter = (ErrorPrinter)session.getAttribute("errorPrinter");
				if(errorPrinter == null)
				{
					errorPrinter = new ErrorPrinter();
				}
				
				//maintain one bookshelf search for session
				if(bookShelf == null)
				{ bookShelf = new BookShelf(); }
				
				search_string = "%" +req.getParameter("search_string").toLowerCase() + "%";
			
				//NOT EMPTY, good!
				if(!search_string.equals("%%"))
				{
				bookShelf.setBookSearch(search_string);
				session.setAttribute("bookShelfSearch", bookShelf);
				res.sendRedirect(res.encodeRedirectURL("../bookSearch.jsp?nav=default"));
				}
				else
				{
					session.setAttribute("bookShelfSearch", bookShelf);
					res.sendRedirect(res.encodeRedirectURL("../bookSearch.jsp?searchEmpty=true"));
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
