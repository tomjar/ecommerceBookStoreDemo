package servlets;
import java.io.*;
import java.sql.*;
import java.util.Random;
import javax.servlet.*;
import javax.servlet.http.*;
import javabeans.*;

/**
 * 
 * @author 3tomr
 *
 */
public class AddToBasketServlet extends HttpServlet
{
	private int quantity;
	private String selectedBook;
	private ShoppingBasket basket;
	private ErrorPrinter errorPrinter;
	private Book book;

	public void doPost (HttpServletRequest req, HttpServletResponse res) 
	throws ServletException, IOException
	{
		PrintWriter out = res.getWriter();
		quantity = Integer.parseInt(req.getParameter("quantity"));
		selectedBook = req.getParameter("id");
		
		String sqlSearch = "SELECT * FROM BOOKS WHERE BOOKS.ISBN ='" + selectedBook +"';";
		
		HttpSession session = req.getSession(true);
		
		basket = (ShoppingBasket)session.getAttribute("basket");
		
		
		//we only want one new basket for this session
		if(basket == null) 
		{
			basket = new ShoppingBasket();
		}
		errorPrinter = (ErrorPrinter)session.getAttribute("errorPrinter");
		if(errorPrinter == null)
		{
			errorPrinter = new ErrorPrinter();
		}
			
		synchronized(session){
		try
		{
			String URL = "jdbc:postgresql:postgres";
			Class.forName("org.postgresql.Driver");
			Connection con = DriverManager.getConnection(URL, "postgres", "user");
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sqlSearch);
			if(rs.next())
			{
				book = new Book(rs.getString("ISBN"), rs.getString("publisher_id"), rs.getString("author"), rs.getString("titleName"),
						rs.getString("edition"), rs.getDouble("price"), rs.getDate("date_of_publication"), 
						rs.getString("category"), quantity);
				
				basket.addToBasket(book);
			}
			con.close();
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