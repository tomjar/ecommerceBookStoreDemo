<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
  <%@page import ="javabeans.*"%>
  <jsp:useBean id="member" scope="session" class="javabeans.Member" ></jsp:useBean>
  <jsp:useBean id ="header" scope ="session" class="javabeans.BookStoreHeader"></jsp:useBean>
  <jsp:useBean id ="errorPrinter" scope ="session" class="javabeans.ErrorPrinter"></jsp:useBean>
  <%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
  <link rel = 'stylesheet' type = 'text/css' href = 'theme/style.css' />
  <title>Browse</title>
	<div class ="wrapper">
  <%=header.getHeader(member.getIsLoggedIn())%>
</head>

<body>
	<table>
	<tr><td>
	<span class ="bigerror">Oh my, lets see what happen.</span>
	</td></tr>
	<tr><td>
	<%=errorPrinter.getCurrentError()%>,
	</td></tr>
	</table>
	<div class = "clearFooter">
	</div>
	<%=header.getFooter()%>
	</div>
</body>
</html>