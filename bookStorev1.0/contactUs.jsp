<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  
   <%@page import ="javabeans.*"%>
   <%@page import ="javax.servlet.http.HttpServletRequest"%>
    <%@page import ="java.net.*"%>
    <%@page import ="java.sql.*"%>
    <%@page import ="java.util.*"%>
  <jsp:useBean id ="header" scope ="session" class="javabeans.BookStoreHeader"></jsp:useBean>
   <jsp:useBean id ="errorPrinter" scope ="session" class="javabeans.ErrorPrinter"></jsp:useBean>
   <jsp:useBean id ="member" scope ="session" class="javabeans.Member"></jsp:useBean>
  <%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
  <link rel = 'stylesheet' type = 'text/css' href = 'theme/style.css' />
  <title>Contact Us</title>
  <div class ="wrapper">
  <%=header.getHeader(member.getIsLoggedIn())%>
</head>
<body>

  <div class ='contactInfo'>
  <p><i>A Book Store Headquarters<br>
  1112 Road Ave.<br>
  City PA, 15110</i></p><br></div>
  <form name ="comment" method ="post" action ="servlet/comment">
  <table class ="commenttable">
  <tr><td align ="left">Submit a suggestion or comment.<br>
  <strong>Name:</strong><br>
  <input name="name" type="text" size="20" maxlength="15"><br>
  <strong>Comment:</strong><br>
  <textarea rows="10" cols="30" name="commentArea"></textarea><br>
  <input type ="submit" value ="Send"></td></tr>
  </table>
  </form>
<%
		try{
			String fieldsEmpty = request.getParameter("empty");
			String URL = "jdbc:postgresql:postgres";
			Class.forName("org.postgresql.Driver");
			Connection con = DriverManager.getConnection(URL, "postgres", "user");
			Statement st = con.createStatement();
			ResultSet rs = null;
			String comments ="";
			String SQLSelect = "SELECT * FROM COMMENTS;";
			rs = st.executeQuery(SQLSelect);
			out.println("<div class =\"comments\">");
				while(rs.next())
				{
					comments = "<div class ='comment'><strong>"+rs.getString("name")+"</strong> said,<br>" +
								""+rs.getString("messageBody")+"</div>";
					response.setContentType("text/html");
					out.println(comments);
				}
				out.println("</div>");
				con.close();
				
			if(fieldsEmpty != null){
				response.setContentType("text/html");
				out.println("<div class =\"importantMessage\">Please enter something before submitting.</div>");
			}
			}catch(Exception e){
				errorPrinter.setCurrentError(e);
				session.setAttribute("errorPrinter", errorPrinter);
				response.sendRedirect(response.encodeRedirectURL("errorOccurred.jsp"));
			}
%>
<div class = "clearFooter"></div>
	<%=header.getFooter()%>
</div>
</body>
</html>
