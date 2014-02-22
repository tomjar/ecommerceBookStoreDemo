<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
  <%@page import ="javabeans.*"%>
  <%@page import ="java.net.*"%>
  <%@page import ="java.sql.*"%>
  <%@page import ="java.util.*"%>
  <jsp:useBean id ="header" scope ="session" class="javabeans.BookStoreHeader"></jsp:useBean>
  <jsp:useBean id ="bookShelf" scope ="session" class="javabeans.BookShelf"></jsp:useBean>
  <jsp:useBean id ="basket" scope ="session" class="javabeans.ShoppingBasket"></jsp:useBean>
  <jsp:useBean id ="member" scope ="session" class="javabeans.Member"></jsp:useBean>
  <%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
  <link rel = 'stylesheet' type = 'text/css' href = 'theme/style.css' />
  <title>Browse</title>
  <div class ="wrapper">
  <%=header.getHeader(member.getIsLoggedIn())%>
</head>

<body>
	<%=basket.getOrderInformation()%>
	<div class = "clearFooter">
	</div>
	<%=header.getFooter()%>
	</div>
</body>
</html>