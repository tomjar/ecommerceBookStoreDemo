package servlets;
import java.io.IOException;
import javabeans.Book;
import javabeans.ErrorPrinter;
import javabeans.ShoppingBasket;
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
public class RemoveFromBasketServlet extends HttpServlet
{
	private ShoppingBasket basket;
	private ErrorPrinter errorPrinter;
	public void doPost (HttpServletRequest req, HttpServletResponse res) 
	throws ServletException, IOException
	{
		
		HttpSession session = req.getSession();
		synchronized(session){
			try
			{
				String bookISBN = req.getParameter("isbn");
				
				basket = (ShoppingBasket)session.getAttribute("basket");
				errorPrinter = (ErrorPrinter)session.getAttribute("errorPrinter");
				if(errorPrinter == null)
				{
					errorPrinter = new ErrorPrinter();
				}
				
				//remove item
				basket.removeBook(bookISBN);
				
				session.setAttribute("basket", basket);
				res.sendRedirect(res.encodeRedirectURL("../shoppingBasket.jsp"));
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
