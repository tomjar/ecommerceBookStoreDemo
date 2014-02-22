<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <%@page import ="javabeans.*"%>
 <%@page import ="java.util.*"%>
 <jsp:useBean id ="header" scope ="session" class="javabeans.BookStoreHeader"></jsp:useBean>
 <jsp:useBean id ="member" scope ="session" class="javabeans.Member"></jsp:useBean>
 <%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
 <link rel = 'stylesheet' type = 'text/css' href = 'theme/style.css' />
  <script type="text/javascript">
//this calls to these functions and validates the form submission
var re_id = /^\d{9}$/;
var re_dl_num = /^\d{8}$/;
var re_zip_code = /^\d{5}$/;
var re_alt_zip_code = /^\d{5}[\-]\d{4}$/;

function idCheck(ssn)
{
	if(re_id.test(ssn))
	{
		document.getElementById("id_message").innerHTML = "<font color = 'green'>correct</font>";
	}
	else
	{
		document.getElementById("id_message").innerHTML = "<font color = 'red'>incorrect</font>";
	}
}

function dlNumCheck(dl_num)
{
	if(re_dl_num.test(dl_num))
	{
		document.getElementById("dl_num_message").innerHTML = "<font color = 'green'>correct</font>";
	}
	else
	{
		document.getElementById("dl_num_message").innerHTML = "<font color = 'red'>incorrect</font>";
	}
}

function zipCheck(zip)
{
	if(re_zip_code.test(zip) || re_alt_zip_code.test())
	{
		document.getElementById("zip_message").innerHTML = "<font color = 'green'>correct</font>";
	}
	else
	{
		document.getElementById("zip_message").innerHTML = "<font color = 'red'>incorrect</font>";
	}
}

</script>

  <title>Register</title>
  <div class ="wrapper">
  <%=header.getHeader(member.getIsLoggedIn())%>
</head>

<body>
<form name="newMember" method="post" action ="servlet/register">
	<%
	String loginValid = request.getParameter("login");
	String formValid = request.getParameter("formIncomplete");
	
		if(loginValid != null){
			if(loginValid.equals("exists"))
			{
				response.setContentType("text/html");
				out.println("<div class ='importantMessage'>That email already exists, please enter a valid email.</div>");
			}
		}
	%>
    <table class ="memberInfo">
		<tr>
			<td align ="right"><b>Email:</b></td>
			<td><input type="text" name="email" maxlength ="50"/> </td>
		</tr>
		<tr>
		  <td align ="right"><b>First Name:</b></td>
		  <td><input type="text" name="firstName" maxlength ="30"/></td>
		</tr>
		<tr>
		  <td align ="right"><b>Last Name:</b></td>
		  <td><input type="text" name="lastName" maxlength ="30"/></td>
		</tr>
		<tr>
		  <td align ="right"><b>Address:</b></td>
		  <td><input type="text" name="address" maxlength ="50"/></td>
		</tr>
		 <tr>
		  <td align ="right"><b>City:</b></td>
		  <td><input type="text" name="city" maxlength ="50"/></td>
		</tr>
		 <tr>
		  <td align ="right"><b>State:</b></td>
		  <td>
		   <select name="state">
			<option value="AL">Alabama</option>
			<option value="AK">Alaska</option>
			<option value="AZ">Arizona</option>
			<option value="AR">Arkansas</option>
			<option value="CA">California</option>
			<option value="CO">Colorado</option>
			<option value="CT">Connecticut</option>
			<option value="DE">Delaware</option>
			<option value="FA">Florida</option>
			<option value="GA">Georgia</option>
			<option value="HI">Hawaii</option>              
			<option value="ID">Idaho</option>
			<option value="IL">Illinois</option>
			<option value="IN">Indiana</option>
			<option value="IA">Iowa</option>
			<option value="KS">Kansas</option>
			<option value="KY">Kentucky</option>
			<option value="LA">Louisiana</option>
			<option value="ME">Maine</option>
			<option value="MD">Maryland</option>
			<option value="MA">Massachusetts</option>
			<option value="MI">Michigan</option>
			<option value="MN">Minnesota</option>
			<option value="MS">Mississippi</option>
			<option value="MO">Missouri</option>
			<option value="MT">Montana</option>
			<option value="NE">Nebraska</option>
			<option value="NV">Nevada</option>
			<option value="NH">New Hampshire</option>
			<option value="NJ">New Jersey</option>
			<option value="NM">New Mexico</option>
			<option value="NY">New York</option>
			<option value="NC">North Carolina</option>
			<option value="ND">North Dakota</option>
			<option value="OH">Ohio</option>
			<option value="OK">Oklahoma</option>
			<option value="OR">Oregon</option>
			<option value="PA" selected="yes">Pennyslvania</option>
			<option value="RI">Rhode Island</option>
			<option value="SC">South Carolina</option>
			<option value="SD">South Dakota</option>
			<option value="TN">Tennessee</option>
			<option value="TX">Texas</option>
			<option value="UT">Utah</option>
			<option value="VT">Vermont</option>
			<option value="VA">Virginia</option>
			<option value="WA">Washington</option>
			<option value="WV">West Virginia</option>
			<option value="WI">Wisconsin</option>
			<option value="WY">Wyoming</option>
		  </select>
		  </td>
		</tr>
		<tr>
		  <td align ="right"><b>Zip Code:</b></td>
		  <td><input type="text" name="zipCode" size ="5" maxlength ="5" onBlur = "zipCheck(zip_code.value)"/></td>
		</tr>
		<tr>
		  <td align ="right"><b>Phone Number:</b></td>
		  <td><input type="text" name="phoneNumber" size="12" maxlength ="12"/> </td>
		</tr>
		<tr>
			<td align ="right"><b>Credit Card Number:</b></td>
			<td><input type="text" name="creditCardNumber" size = "16" maxlength ="16"/> </td>
			<tr>
				<td align ="right"><b>Month:</b></td>
				<td colspan ="2"><select name = "month">
					<option value ="Jan">1 January</option>
					<option value ="Feb">2 February</option>
					<option value ="Mar">3 March</option>
					<option value ="Apr">4 April</option>
					<option value ="May">5 May</option>
					<option value ="Jun">6 June</option>
					<option value ="Jul">7 July</option>
					<option value ="Aug">8 August</option>
					<option value ="Sep">9 September</option>
					<option value ="Oct">10 October</option>
					<option value ="Nov">11 November</option>
					<option value ="Dec">12 December</option>
				</select>
				</td>
			</tr>
			<tr>
			<td align ="right"><b>Year:</b></td>
			<td colspan ="2">
			<select name = "year">
				<option value ="2011">2011</option>
				<option value ="2012">2012</option>
				<option value ="2013">2013</option>
				<option value ="2014">2014</option>
				<option value ="2015">2015</option>
				<option value ="2016">2016</option>
				<option value ="2017">2017</option>
				<option value ="2018">2018</option>
			</select>
			</td>
		  </tr>
		  <tr>
			<td align ="right"><b>Password:</span></b>
			<td><input type="password" name="password" size ="15"maxlength ="15"/></td>
		  </tr>
		  <tr>
			<td align ="right"><b>Confirm Password:</b></td>
			<td><input type="password" name="passwordConfirm" size ="15" maxlength ="15"/></td>
		  </tr>
		<tr>
			<td align ="right"><b>Password Hint:</b></td>
			<td><input type="text" name="passwordHint" size ="15" maxlength ="15"/><br>
			<input type ="submit" value ="Register Now">
			</td>
		</tr>
			
	</table>
  </form>
  <div class = "clearFooter">
	</div>
	<%=header.getFooter()%>
  </div>
</body>
</html>