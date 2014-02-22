package servlets;
import javabeans.ErrorPrinter;
import javabeans.Member;
import javabeans.ShoppingBasket;
import javabeans.TomsUtility;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
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
public class CheckOutServlet extends HttpServlet{
	
	private ShoppingBasket basket;
	private TomsUtility t;
	private Member member;
	private String insert_ordered_item, insert_order, orderID, method_shipping, todayMonth;
	private int index = 0;
	private ErrorPrinter errorPrinter;
	
	public void doPost (HttpServletRequest req, HttpServletResponse res)
	throws ServletException, IOException{
		
		HttpSession session = req.getSession();
		Calendar today = Calendar.getInstance();
		Date now = today.getTime();
		Timestamp currentTimestamp = new Timestamp(now.getTime());
		basket = (ShoppingBasket)session.getAttribute("basket");
		member = (Member)session.getAttribute("member");
		errorPrinter = (ErrorPrinter)session.getAttribute("errorPrinter");
		method_shipping = req.getParameter("method_shipping");
		if(errorPrinter == null)
		{
			errorPrinter = new ErrorPrinter();
		}
		else if(basket == null){
			basket = new ShoppingBasket();
		}
		t = new TomsUtility();
		
		synchronized(session){
			try{
				Class.forName("org.postgresql.Driver");
				String URL = "jdbc:postgresql:postgres";
				Connection con = DriverManager.getConnection(URL, "postgres", "user");
				Statement st = con.createStatement();
				ResultSet rs = null;
				if(member.getIsLoggedIn())
				{
					//member is logged in
					t.addAlphabet();
					orderID = t.getOrderID();
					//insert all ordered items with a unique orderID
					insert_order = "INSERT INTO ORDERS(orderID, customerEmail, credit_card, method_shipping, shipping_date, order_date_time, order_total) "+
					               "VALUES('" + orderID + "', '" + member.getEmail() + "', '" + member.getCreditCard() + "', '" + method_shipping + "', " +
					               "TO_DATE('"+today.get(Calendar.DAY_OF_MONTH)+"-"+t.getMonth(today.get(Calendar.MONTH))+"-"+today.get(Calendar.YEAR)+"', 'DD-MON-YYYY'), "+
					               "TIMESTAMP '"+currentTimestamp+"', '"+basket.getTotalCost()+"');";
					
					st.executeUpdate(insert_order);
					
					while(index < basket.getListSize()){
						insert_ordered_item = "INSERT INTO ORDERED_ITEM(orderedItemID, orderID, bookID)VALUES('"+t.getOrderedItemID()+"','"+orderID+"', '"+basket.getBookISBN(index)+"');";
						st.executeUpdate(insert_ordered_item);
						index++;
					}
					//clear the basket contents, because you checked out
					basket.clearListBooks();
					basket.setOrderInformation("<div class ='importantMessage'>" +
								"Thanks for your business, " + member.getFirstName() + "!" +
								"Your order confirmation number is:<b>"+orderID+".</b><br>" +
							    "Your shipping date is: "+today.get(Calendar.DAY_OF_MONTH)+"-"+t.getMonth(today.get(Calendar.MONTH))+"-"+today.get(Calendar.YEAR)+"."+
								"<a href=index.jsp>Click here to return home.</a>" +
								"</div>");
					
					con.close();
					member.setIsLoggedIn(true);
					session.setAttribute("basket", basket);
					session.setAttribute("member", member);
					res.sendRedirect(res.encodeRedirectURL("../orderConfirmation.jsp?orderID="+orderID+""));
					
				}
				else
				{
					con.close();
					member.setIsLoggedIn(false);
					session.setAttribute("basket", basket);
					session.setAttribute("member", member);
					res.sendRedirect(res.encodeRedirectURL("../index.jsp?login=false&triedToBuy=true"));
				}
			}
			catch (Exception e){
				//set the error
				errorPrinter.setCurrentError(e);
				session.setAttribute("errorPrinter", errorPrinter);
				res.sendRedirect(res.encodeRedirectURL("../errorOccurred.jsp"));
			}
		}
	}
}
