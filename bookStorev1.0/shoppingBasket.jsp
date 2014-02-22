<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
   <%@page import ="javabeans.*"%>
	<jsp:useBean id ="header" scope ="session" class="javabeans.BookStoreHeader"></jsp:useBean>
	<jsp:useBean id ="basket" scope ="session" class="javabeans.ShoppingBasket"></jsp:useBean>
	<jsp:useBean id ="member" scope ="session" class="javabeans.Member"></jsp:useBean>
	<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
	<link rel = 'stylesheet' type = 'text/css' href = 'theme/style.css' />
	<title>Shopping Basket</title>
	<div class ="wrapper">
	<%=header.getHeader(member.getIsLoggedIn())%>
</head>

 <body>
  <%
  String allBooks ="";
  if(basket.getTotalCost() <= 0.0)
  {
	response.setContentType("text/html");
	out.println("<div class ='importantMessage'>No items in cart.</div>");
  }
  else if(basket.getTotalCost() > 0.0)
  {
	  for(int i = 0; i < basket.getListSize(); i++)
	  {
		  allBooks += "<tr><td><b>Title Name:</b><a href =\"bookInfo.jsp?id="+basket.getBookISBN(i)+"\">"+basket.getTitleName(i) +"</a><br>"+
					"<b>Book Quantity:</b>" +basket.getItemQuantity(i) + "<br>"+
					"<b>Book Price:</b>" +basket.getPrice(i) +"<br></td><td><form name =\"removeItem\" method =\"post\" action =\"servlet/removeItem?isbn="+basket.getBookISBN(i)+"\">" +
					"<input type =\"submit\" value = \"Remove\"></input></form></td></tr>";
	  }
					response.setContentType("text/html");
					out.println("<table class =\"bookinfotable\"><tr><td colspan =\"2\"><a href='bookBrowsing.jsp?nav=default&count=10' title='Back to Browsing'>Back To Browsing</a></td></tr>"+
								""+allBooks+"" +
						        "<tr><td colspan =\"2\"><strong>Total:</strong> " + basket.getTotalCost() +"<br></td></tr>" +
						        "<tr><td colspan =\"2\"><strong>Shipping Method:</strong><br>"+
						        "<input type='radio' name=\"method_shipping\" value=\"usps_ground\" CHECKED > USPS Ground <br>"+
						        "<input type='radio' name=\"method_shipping\" value=\"usps_priority\" > USPS Priority <br>"+
						        "<input type='radio' name=\"method_shipping\" value=\"usps_express\" > USPS Express <br>"+
						        "<input type='radio' name=\"method_shipping\" value=\"ups_ground\" > UPS Ground <br>"+
						        "<input type='radio' name=\"method_shipping\" value=\"ups_third_day\" > UPS Third Day Air <br>"+
						        "<input type='radio' name=\"method_shipping\" value=\"ups_second_day\" > UPS Second Day Air <br>"+
						        "<input type='radio' name=\"method_shipping\" value=\"ups_next_day\" > UPS Next Day Air <br></td></tr>" +
					            "<tr><td colspan =\"2\"></form><form name ='buyItems' method ='post' action ='servlet/buy'><input type =\"submit\" value =\"Purchase\">"+
					            "</td></tr></form></table>");
  }
  %>

  <div class = "clearFooter"></div>
	<%=header.getFooter()%>
	</div>
  </body>
</html>