<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<%@page import ="javabeans.*"%>
	<jsp:useBean id="member" scope="session" class="javabeans.Member" ></jsp:useBean>
	<jsp:useBean id ="header" scope ="session" class="javabeans.BookStoreHeader"></jsp:useBean>
	<jsp:useBean id ="errorPrinter" scope ="session" class="javabeans.ErrorPrinter"></jsp:useBean>
	<jsp:useBean id ="tomUtility" scope ="session" class="javabeans.TomsUtility"></jsp:useBean>
	<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
	<%@page import ="javax.servlet.http.HttpServletRequest"%>
    <%@page import ="java.net.*"%>
    <%@page import ="java.sql.*"%>
	<%@page import ="java.util.Calendar"%>
	<link rel = 'stylesheet' type = 'text/css' href = 'theme/style.css' />
  <title>Member Home</title>
<div class="wrapper">
 <%=header.getHeader(member.getIsLoggedIn())%>
</head>

<body>
	
	<%
		try{
			Calendar today = Calendar.getInstance();
			String isUpdateInfo = request.getParameter("updateInfo");
			String todayMonth = tomUtility.getMonth(today.get(Calendar.MONTH));
			int todayYear = today.get(Calendar.YEAR);
			int todayDay = today.get(Calendar.DAY_OF_MONTH);
			String todaysDate = "TO_DATE('"+todayDay+"-"+todayMonth+"-"+todayYear+"', 'DD-MON-YYYY')";
			String URL = "jdbc:postgresql:postgres";
			Class.forName("org.postgresql.Driver");
			Connection con = DriverManager.getConnection(URL, "postgres", "user");
			Statement st = con.createStatement();
			ResultSet rs = null;
			if(member.getIsLoggedIn()){
				out.println("<table class =\"memberInfo\">");
				if(isUpdateInfo == null){
				out.println("<tr><td align ='right'><b>Email:			</b></td><td align ='left'>"+member.getEmail()+"</td></tr>" +
							"<tr><td align ='right'><b>First Name:		</b></td><td align ='left'>"+member.getFirstName()+"</td></tr>" +
							"<tr><td align ='right'><b>Last Name:		</b></td><td align ='left'>"+member.getLastName()+"</td></tr>" +
							"<tr><td align ='right'><b>Address:			</b></td><td align ='left'>"+member.getAddress()+"</td></tr>" +
							"<tr><td align ='right'><b>City:			</b></td><td align ='left'>"+member.getCity()+"</td></tr>" +
							"<tr><td align ='right'><b>State:			</b></td><td align ='left'>"+member.getState()+"</td></tr>" +
							"<tr><td align ='right'><b>Zip/Postal Code:	</b></td><td align ='left'>"+member.getZip()+"</td></tr>" +
							"<tr><td align ='right'><b>Phone Number:	</b></td><td align ='left'>"+member.getPhone()+"</td></tr>" +
							"<tr><td align ='right'><b>Current Password:</b></td><td align ='left'>"+member.getPassword()+"</td></tr>" +
							"<tr><td align ='right'><b>Password Hint:	</b></td><td align ='left'>"+member.getPasswordHint()+"</td></tr>" +
							"<tr><td align ='right'><b>Date Registered:	</b></td><td align ='left'>"+member.getRegisteredDate()+"</td></tr>" +
							"<tr><td align ='right'><b>Credit Card #:	</b></td><td align ='left'>"+member.getCreditCard()+"</td></tr>" +
							"<tr><td align ='right'><b>Credit Card Exp:	</b></td><td align ='left'>"+member.getCreditCardExpDate()+"</td></tr>" +
							"<tr><td colspan ='2' align ='center'><a href ='memberInformation.jsp?updateInfo=true'>Update Your Info!</a></td></tr></table>");
							String open_orders_select = "SELECT * FROM ORDERS "+
												"WHERE customerEmail = '"+member.getEmail()+"'" +
												"AND order_date_time > "+todaysDate+";";
											
							String orders_select = "SELECT * FROM ORDERS "+
													"WHERE customerEmail = '"+member.getEmail()+"';";
				out.println("<div class ='allOrders'>");
							rs = st.executeQuery(open_orders_select);		
							while(rs.next()){
								out.println("<div class ='orders'>open order:<a href ='orderStatus.jsp?order_id="+rs.getString("orderID")+"'>"+rs.getString("orderID")+"</a></div>");
							}
										
							rs = st.executeQuery(orders_select);		
							while(rs.next()){
								out.println("<div class ='orders'>shipped order:<a href ='orderStatus.jsp?order_id="+rs.getString("orderID")+"'>"+rs.getString("orderID")+"</a></div>");
							}
				out.println("</div>");
				}				
				
				else if(isUpdateInfo != null && isUpdateInfo.equals("true"))
				{
					response.setContentType("text/html");
					out.println("<form name ='memberInfoUpdate' method ='post' action='servlet/updateMemberInfo'>"+
								"<table class=\"memberInfo\"><tr><td align ='right'><b>Current First Name:</b></td><td align ='left'>"+member.getFirstName()+"</td><td align ='left'> <input type='text' name='fname' value ='"+member.getFirstName()+"'></td>"+
								"<tr><td align ='right'><b>Current Last Name:</b></td><td align ='left'>"+member.getLastName()+"</td><td align ='left'> <input type='text' name ='lname'value ='"+member.getLastName()+"'></td>"+
								"<tr><td align ='right'><b>Current Address:</b></td><td align ='left'>"+member.getAddress()+"</td><td align ='left'> <input type='text' name ='address'value ='"+member.getAddress()+"'></td>"+
								"<tr><td align ='right'><b>Current City:</b></td><td align ='left'>"+member.getCity()+"</td><td align ='left'> <input type='text' name ='city' value ='"+member.getCity()+"'></td>"+
								"<tr><td align ='right'><b>Current State:</b></td><td align ='left'>"+member.getState()+"</td><td align ='left'>"+
								"<select name='state'>"+
								"<option value='AL'>Alabama</option>       "+
								"<option value='AK'>Alaska</option>        "+
								"<option value='AZ'>Arizona</option>       "+
								"<option value='AR'>Arkansas</option>      "+
								"<option value='CA'>California</option>    "+
								"<option value='CO'>Colorado</option>      "+
								"<option value='CT'>Connecticut</option>   "+
								"<option value='DE'>Delaware</option>      "+
								"<option value='FA'>Florida</option>       "+
								"<option value='GA'>Georgia</option>       "+
								"<option value='HI'>Hawaii</option>        "+      
								"<option value='ID'>Idaho</option>         "+
								"<option value='IL'>Illinois</option>      "+
								"<option value='IN'>Indiana</option>       "+
								"<option value='IA'>Iowa</option>          "+
								"<option value='KS'>Kansas</option>        "+
								"<option value='KY'>Kentucky</option>      "+
								"<option value='LA'>Louisiana</option>     "+
								"<option value='ME'>Maine</option>         "+
								"<option value='MD'>Maryland</option>      "+
								"<option value='MA'>Massachusetts</option> "+
								"<option value='MI'>Michigan</option>      "+
								"<option value='MN'>Minnesota</option>     "+
								"<option value='MS'>Mississippi</option>   "+
								"<option value='MO'>Missouri</option>      "+
								"<option value='MT'>Montana</option>       "+
								"<option value='NE'>Nebraska</option>      "+
								"<option value='NV'>Nevada</option>        "+
								"<option value='NH'>New Hampshire</option> "+
								"<option value='NJ'>New Jersey</option>    "+
								"<option value='NM'>New Mexico</option>    "+
								"<option value='NY'>New York</option>      "+
								"<option value='NC'>North Carolina</option>"+
								"<option value='ND'>North Dakota</option>  "+
								"<option value='OH'>Ohio</option>          "+
								"<option value='OK'>Oklahoma</option>      "+
								"<option value='OR'>Oregon</option>        "+
								"<option value='PA' selected='yes'>Pennyslvania</option>"+
								"<option value='RI'>Rhode Island</option>  "+
								"<option value='SC'>South Carolina</option>"+
								"<option value='SD'>South Dakota</option>  "+
								"<option value='TN'>Tennessee</option>     "+
								"<option value='TX'>Texas</option>         "+
								"<option value='UT'>Utah</option>          "+
								"<option value='VT'>Vermont</option>       "+
								"<option value='VA'>Virginia</option>      "+
								"<option value='WA'>Washington</option>    "+
								"<option value='WV'>West Virginia</option> "+
								"<option value='WI'>Wisconsin</option>     "+
								"<option value='WY'>Wyoming</option>       "+
								"</select></td>"+
								"<tr><td align ='right'><b>Current Zip/Postal Code:	</b></td><td align ='left'>"+member.getZip()+"</td><td align ='left'> <input type ='text' name ='zip' value ='"+member.getZip()+"' size ='10'></td>"+
								"<tr><td align ='right'><b>Current Phone Number:</b></td><td align ='left'>"+member.getPhone()+"</td><td align ='left'> <input type ='text' name='phone' value ='"+member.getPhone()+"' size ='14'></td>"+
								"<tr><td align ='right'><b>Current Current Password:</b></td><td align ='left'>"+member.getPassword()+"</td><td align ='left'> <input type ='text' name ='password'value ='"+member.getPassword()+"' size ='15' maxlength ='15'></td>"+
								"<tr><td align ='right'><b>Current Password Hint:</b></td><td align ='left'>"+member.getPasswordHint()+"</td><td align ='left'> <input type ='text' name='passwordHint' value ='"+member.getPasswordHint()+"'size ='15' maxlength ='15'></td>"+
								"<tr><td align ='right'><b>Current Credit Card Number:</b></td><td align ='left'>"+member.getCreditCard()+"</td><td align ='left'> <input type ='text' name = 'creditCard' value ='"+member.getCreditCard()+"'size = '16' maxlength ='16'></td>"+
								"<tr><td align ='right' colspan ='1'><b>Current Credit Card Expiration Date:</b></td><td align ='left' colspan ='2'>"+member.getCreditCardExpDate()+"</td></tr>"+
								"<tr><td align ='right' colspan ='2'>"+
								"<b>Credit Card Expiration Month:</b></td>"+
								"<td colspan ='2' align ='left'><select name = 'month'>"+
								"<option value ='Jan'>1 January</option>   "+
								"<option value ='Feb'>2 February</option>  "+
								"<option value ='Mar'>3 March</option>     "+
								"<option value ='Apr'>4 April</option>     "+
								"<option value ='May'>5 May</option>       "+
								"<option value ='Jun'>6 June</option>      "+
								"<option value ='Jul'>7 July</option>      "+
								"<option value ='Aug'>8 August</option>    "+
								"<option value ='Sep'>9 September</option> "+
								"<option value ='Oct'>10 October</option>  "+
								"<option value ='Nov'>11 November</option> "+
								"<option value ='Dec'>12 December</option> "+
								"</select></td></tr>"+
								"<tr><td align ='right' colspan ='2'><b>Credit Card Expiration Year:</b></td>"+
								"<td align ='left' colspan ='2'><select name = 'year'>"+
								"<option value ='2011'>2011</option>"+
								"<option value ='2012'>2012</option>"+
								"<option value ='2013'>2013</option>"+
								"<option value ='2014'>2014</option>"+
								"<option value ='2015'>2015</option>"+
								"<option value ='2016'>2016</option>"+
								"<option value ='2017'>2017</option>"+
								"<option value ='2018'>2018</option>"+
								"</select></td></tr>"+
								"<tr><td colspan ='2'><a href ='javascript:history.go(-1)'>Back</a></td><td colspan ='2'><a href ='javascript:document.memberInfoUpdate.submit();'>Update Now</a></td></tr></form>");
								out.println("</table>");
				}		
			}
			else
			{
				out.println("<div class ='importantMessage'>Login to view information.</div>");
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