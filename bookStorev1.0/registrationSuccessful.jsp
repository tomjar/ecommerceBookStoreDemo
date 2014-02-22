<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
  <%@page import ="javabeans.*"%>
  <jsp:useBean id="member" scope="session" class="javabeans.Member" ></jsp:useBean>
  <jsp:useBean id ="header" scope ="session" class="javabeans.BookStoreHeader"></jsp:useBean>
  <%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
  <link rel = 'stylesheet' type = 'text/css' href = 'theme/style.css' />
  <title>Browse</title>
  <div class ="wrapper">
  <%=header.getHeader(member.getIsLoggedIn())%>
</head>

<body>
	
	<div class = 'importantMessage'>
	<%=member.getFirstName()%>, you are now registered, congratulations!<br>
	<a href="memberInformation.jsp">Click here to view your account info.</a><br>
	<a href="bookSearch.jsp">Click here to start browsing books.</a><br>
	<a href="index.jsp">Click here to return home.</a>
	</div>
	</table>
	</div>
	<div class = "clearFooter">
	</div>
	<%=header.getFooter()%>
</body>
</html>