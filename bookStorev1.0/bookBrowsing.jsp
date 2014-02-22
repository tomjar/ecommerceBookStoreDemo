<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
  <%@page import ="javabeans.*"%>
  <%@page import ="java.net.*"%>
  <%@page import ="java.sql.*"%>
  <%@page import ="java.util.*"%>
  <jsp:useBean id ="header" scope ="session" class="javabeans.BookStoreHeader"></jsp:useBean>
  <jsp:useBean id ="bookShelf" scope ="session" class="javabeans.BookShelf"></jsp:useBean>
  <jsp:useBean id ="errorPrinter" scope ="session" class="javabeans.ErrorPrinter"></jsp:useBean>
  <jsp:useBean id ="member" scope ="session" class="javabeans.Member"></jsp:useBean>
  <%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
  <link rel = 'stylesheet' type = 'text/css' href = 'theme/style.css' />
  <title>Browse</title>
<div class ="wrapper">
  <%=header.getHeader(member.getIsLoggedIn())%>
</head>

<body>

	<table class ="widetable">
	<tr>
		<td align ="right">
		<a href="bookBrowsing.jsp?nav=backward&count=10" title="Previous">Previous 10</a>
		</td>
		<td align ="left">
		<a href="bookBrowsing.jsp?nav=forward&count=10" title="Next">Next 10</a>
		</td>
	</tr>
	<%
	try{
		String select = "SELECT * FROM BOOKS ORDER BY titlename;";
		String nav = request.getParameter("nav");
		int count = Integer.parseInt(request.getParameter("count"));
		int quantity = 0;
		int index = 0;
		int maxRows = 0;
		
		Class.forName("org.postgresql.Driver");
		String URL = "jdbc:postgresql:postgres";
		Connection con = DriverManager.getConnection(URL, "postgres", "user");
		Statement st = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ResultSet rs = null;
		rs = st.executeQuery(select);
		rs.last();
		maxRows = rs.getRow();
		if(nav.equals("default")){
			bookShelf.setCursorPos(0);
		}
			else if(nav.equals("forward") && bookShelf.getCursorPos() + (maxRows / 2)<  maxRows){
				bookShelf.setCursorPos(bookShelf.getCursorPos() + 10);
			}
				else if(nav.equals("backward") && bookShelf.getCursorPos() != 0){
					bookShelf.setCursorPos(bookShelf.getCursorPos() - 10);
				}
		
		rs.absolute(bookShelf.getCursorPos());
		while(rs.next() && index < count){
		response.setContentType("text/html");
		out.println("<tr><td valign='top' align ='right'>" +
					"<a href = \"bookInfo.jsp?id="+rs.getString("ISBN")+"\"><img src =\""+rs.getString("ISBN")+ ".jpg\" width = '100' height = '150' title ='"+rs.getString("titleName")+"'></a></td>"+ 
					"<td><b>Book Title:</b><a href = 'bookInfo.jsp?id="+rs.getString("ISBN")+"' title ='"+rs.getString("titleName")+"'>" +rs.getString("titleName") +"</a><br>"+
					"<b>Book Author:</b>" +rs.getString("author") +"<br>"+
					"<b>Book Price:</b>" +rs.getDouble("price") +"<br></td></tr>");
					index++;
					
		}
	}
	catch(Exception e){
	errorPrinter.setCurrentError(e);
	session.setAttribute("errorPrinter", errorPrinter);
	response.sendRedirect(response.encodeRedirectURL("errorOccurred.jsp"));
	}
	%>
	<tr>
		<td align ="right">
		<a href="bookBrowsing.jsp?nav=backward&count=10" title="Previous">Previous 10</a>
		</td>
		<td align ="left">
		<a href="bookBrowsing.jsp?nav=forward&count=10" title="Next">Next 10</a>
		</td>
	</tr>
	</table>
	<%=header.getFooter()%>
</div>
</body>
</html>