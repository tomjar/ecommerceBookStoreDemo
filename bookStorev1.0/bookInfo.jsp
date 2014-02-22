<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
 
    <%@page import ="javabeans.*"%>
    <%@page import ="javax.servlet.http.HttpServletRequest"%>
    <%@page import ="java.net.*"%>
    <%@page import ="java.sql.*"%>
	<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
    <jsp:useBean id ="errorPrinter" scope ="session" class="javabeans.ErrorPrinter"></jsp:useBean>
	<jsp:useBean id ="header" scope ="session" class="javabeans.BookStoreHeader"></jsp:useBean>
	<jsp:useBean id ="member" scope ="session" class="javabeans.Member"></jsp:useBean>
	<link rel = 'stylesheet' type = 'text/css' href = 'theme/style.css' />
	<title>Book Information Page</title>
	<div class ="wrapper">
	 <%=header.getHeader(member.getIsLoggedIn())%>
</head>
<body>
<table class ="bookinfotable">
 
  <%
  try{
	String URL = "jdbc:postgresql:postgres";
	Class.forName("org.postgresql.Driver");
	Connection con = DriverManager.getConnection(URL, "postgres", "user");
	Statement st = con.createStatement();
				
	String bookView = "";
	String sqlSelect = "";
	bookView = request.getParameter("id");
	
	sqlSelect = "SELECT DISTINCT * " +
				"FROM BOOKS, PUBLISHERS WHERE BOOKS.ISBN = '" + bookView +"' AND BOOKS.publisher_id = PUBLISHERS.publisher_id;";
		  	ResultSet rs = st.executeQuery(sqlSelect);
		  	if(rs.next()){
			response.setContentType("text/html");
			out.println("<tr><td><img class ='bigPictureBook'src = '"+rs.getString("ISBN")+".jpg' width = '400' height = '500' title ='"+rs.getString("titleName")+"'></td>" +
						"<form name ='addToCart' method='post' action='servlet/addToBasket?id="+rs.getString("isbn")+"'>" +
						"<td valign='top'>"+
						"<strong>Title Name:		</strong>" + rs.getString("titleName") + "<br>"+
						"<strong>Title Author:		</strong>" + rs.getString("author") +  "<br>"+
						"<strong>Title Price:    	</strong>" + rs.getDouble("price") + "<br>"+
						"<strong>Title Edition:  	</strong>" + rs.getString("edition") + "<br>"+
						"<strong>Title Published:	</strong>" + rs.getString("date_of_publication") + "<br>"+
						"<strong>Title Category: 	</strong>" + rs.getString("category") + "<br>"+
						"<strong>Publisher Name: 	</strong>" + rs.getString("publisher_name") + "<br>"+
						"<strong>Publisher Address:	</strong>" + rs.getString("publisher_address") +"<br>"+
						"<strong>Quantity:</strong><input name ='quantity' type ='text' value ='1' size ='1'><br>"+
						"<a href='javascript:document.addToCart.submit();' title='Add To Cart' >Add To Cart</a>" +
						"</td></tr>");
				}
		}
		catch(Exception e){
		errorPrinter.setCurrentError(e);
		session.setAttribute("errorPrinter", errorPrinter);
		response.sendRedirect(response.encodeRedirectURL("errorOccurred.jsp"));
		}

	%>
  </table>
  </form>
  <div class = "clearFooter">
	</div>
	<%=header.getFooter()%>
  </div>
</body>
</html>