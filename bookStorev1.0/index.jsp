<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
  <%@page import ="javabeans.*"%>
  <jsp:useBean id ="header" scope ="session" class="javabeans.BookStoreHeader"></jsp:useBean>
  <jsp:useBean id ="member" scope ="session" class="javabeans.Member"></jsp:useBean>
  <%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
  <link rel = 'stylesheet' type = 'text/css' href = 'theme/style.css' />
  <title>Home</title>
  <div class ="wrapper">
		 		 <%=header.getHeader(member.getIsLoggedIn())%>
</head>
<body>

  <%					  
	String found = request.getParameter("found");
	String triedToBuy = request.getParameter("triedToBuy");
	String isLoggedOut = request.getParameter("loggedOut");
	String loginMessage = "<form name ='userLogin' method='post' action ='servlet/login'><table class ='logintable'>" +
						  "<tr align ='center'><td align ='right'><b>Email:</b></td><td align ='left'><input name = 'user_email' type = 'text' size ='10'></td></tr>" +
						  "<tr><td align ='right'><b>Password:</b></td><td = 'left'><input name = 'password' type = 'password' size ='10'>"+
						  "<br><input type=\"submit\" value =\"Login\"></td></tr>"+
						  "<tr><td colspan ='2'>Don't have a account?<a href = 'newMemberRegistration.jsp'>Create one!</a></td></tr></table></form>";
		
		if(isLoggedOut != null && isLoggedOut.equals("true"))
		{
			session.invalidate();
			response.sendRedirect(response.encodeRedirectURL("index.jsp"));
		}
		//Not Logged In
		else if(!member.getIsLoggedIn() && found == null && triedToBuy == null){
			//Print default login screen
			response.setContentType("text/html");
			out.println(loginMessage);
		}
		//Logged In
		else if(member.getIsLoggedIn()){
			//print logged in screen
			response.setContentType("text/html");
			out.println("<div class ='importantMessage'> "+
					     "<strong>Welcome,</strong><a href = 'memberInformation.jsp'>"+ member.getFirstName() +"</a></div>");
		}
		//Login Failed
		else if(found != null && found.equals("false"))
		{
				response.setContentType("text/html");
				out.println(loginMessage + "<div class ='importantMessage'>Email or password was not found!</div>");
		}
		//Login Failed and found is false and triedtobuy equals true
		else if(!member.getIsLoggedIn() && triedToBuy != null && triedToBuy.equals("true"))
		{
			response.setContentType("text/html");
			out.println(loginMessage + "<div class ='importantMessage'>Please login before buying items.</div>");
		}
	%>
	<%=header.getFooter()%>
	</div>
</body>
</html>