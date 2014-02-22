<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

  <title>Past Order Information</title>
  <%@page import ="javabeans.*"%>
   <%@page import ="javax.servlet.http.HttpServletRequest"%>
    <%@page import ="java.net.*"%>
    <%@page import ="java.sql.*"%>
	<jsp:useBean id ="header" scope ="session" class="javabeans.BookStoreHeader"></jsp:useBean>
	 <jsp:useBean id ="errorPrinter" scope ="session" class="javabeans.ErrorPrinter"></jsp:useBean>
	 <jsp:useBean id ="member" scope ="session" class="javabeans.Member"></jsp:useBean>
	 <link rel = 'stylesheet' type = 'text/css' href = 'theme/style.css' />
	 <div class ="wrapper">
	<%=header.getHeader(member.getIsLoggedIn())%>
</head>

<body>
  
		<%
			String orderID = request.getParameter("order_id");
			String outPut = "";
			String sqlSelect ="";
			try{
				String URL = "jdbc:postgresql:postgres";
				Class.forName("org.postgresql.Driver");
				Connection con = DriverManager.getConnection(URL, "postgres", "user");
				Statement st = con.createStatement();
				sqlSelect = "SELECT * FROM ORDERS WHERE orderID = '" + orderID +"';";
				ResultSet rs = st.executeQuery(sqlSelect);
				out.println("<table class = \"widetable\">"+
							"<tr><td><a href=\"javascript:history.go(-1)\" title=\"Back\" >Go Back</td></tr>");
					if(rs.next()){
						outPut = "<tr><td><b>Order Number:</b>"+rs.getString("orderID")+",<br>" +
									"<b>Customer Email:</b>"+rs.getString("customerEmail")+",<br>"+
									"<b>Credit Card Number:</b>"+rs.getString("credit_card")+",<br>"+
									"<b>Shipping Method:</b>"+rs.getString("method_shipping")+",<br>"+
									"<b>Order Shipped On:</b>"+rs.getString("order_date_time")+",<br>"+
									"<b>Order Placed On:</b>"+rs.getString("order_date_time")+",<br>"+
									"<b>Order Total:</b>"+rs.getDouble("order_total")+"</td></tr>";
						response.setContentType("text/html");
						out.println(outPut);
					}
					
					sqlSelect = "SELECT * FROM ORDERED_ITEM, BOOKS WHERE ORDERED_ITEM.orderID ='"+orderID+"' "+
								"AND BOOKS.isbn = ORDERED_ITEM.bookisbn;";
					rs = st.executeQuery(sqlSelect);
					while(rs.next()){
						   outPut = "<tr>"+
									"<td><b>Book ISBN:</b>"+rs.getString("ISBN")+",<br>" +
									"<b>Book Title:</b>"+rs.getString("titleName")+",<br>"+
									"<b>Book Price:</b>"+rs.getDouble("price")+"</td></tr>";
									
									response.setContentType("text/html");
									out.println(outPut);

					}
					con.close();
				
			}
			catch(Exception e)
			{
				errorPrinter.setCurrentError(e);
				session.setAttribute("errorPrinter", errorPrinter);
				response.sendRedirect(response.encodeRedirectURL("errorOccurred.jsp"));
			}
				
		%>
  </table>

	<%=header.getFooter()%>
	  </div>
</body>
</html>