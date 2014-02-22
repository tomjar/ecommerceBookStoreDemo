<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <%@page import ="javabeans.*"%>
	<%@page import ="java.net.*"%>
	<%@page import ="java.sql.*"%>
	<%@page import ="java.util.*"%>
	<jsp:useBean id ="header" scope ="session" class="javabeans.BookStoreHeader"></jsp:useBean>
	<jsp:useBean id ="bookShelfSearch" scope ="session" class="javabeans.BookShelf"></jsp:useBean>
	<jsp:useBean id ="member" scope ="session" class="javabeans.Member"></jsp:useBean>
	<jsp:useBean id ="errorPrinter" scope ="session" class="javabeans.ErrorPrinter"></jsp:useBean>
	<%@ page contentType="text/html; charset=iso-8859-1" language="java" %>
	<link rel = 'stylesheet' type = 'text/css' href = 'theme/style.css' />
	<title>Search</title>
	<div class="wrapper">
	<%=header.getHeader(member.getIsLoggedIn())%>
  </head>

  <body>
  <form name ="searchBooks" method ="post" action="servlet/search">
      <table class = "widetable">
        <tr>
          <td align ="right" valign ="top">
            <strong>Search through books database, enter a keyword.</strong>
          </td>
          <td valign="top">
            <input type="text" name="search_string" size="15" maxlength="25">
			<br>
            <input type ="submit" value ="Search Now">
          </td>
        </tr>
	<%
		String isSearching = request.getParameter("search");
		String isSearchEmpty = request.getParameter("searchEmpty");
		String nav = request.getParameter("nav");
		int index = 0;
		
		//empty search
		if(isSearchEmpty != null && isSearchEmpty.equals("true")){
			out.println("<div class =\"importantMessage\">Please enter a keyword to search by.</div>");
		}
		else if(nav != null){
		
			
			String SQLSearch =  "SELECT * FROM BOOKS "+
								"WHERE lower(author) LIKE ('" + bookShelfSearch.getBookSearch()+ "') OR " +
								"lower(titleName) LIKE ('" + bookShelfSearch.getBookSearch() + "') OR " + 
								"lower(category) LIKE ('" + bookShelfSearch.getBookSearch() + "');";
			try{
					Class.forName("org.postgresql.Driver");
					String URL = "jdbc:postgresql:postgres";
					Connection con = DriverManager.getConnection(URL, "postgres", "user");
					Statement st = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = null;
					
					rs = st.executeQuery(SQLSearch);
					
					//go to the last row returned by this query
					if(!bookShelfSearch.getIsMaxRowSet()){
					rs.last();
					bookShelfSearch.setMaxRow(rs.getRow());
					bookShelfSearch.setIsMaxRowSet(true);
					session.setAttribute("bookShelfSearch", bookShelfSearch);
					}
					
					if(bookShelfSearch.getMaxRow() <= 0)
					{
						out.println("<div class =\"importantMessage\">No results found, try something else.</div>");
					}
					
						out.println("<tr><td colspan =\"2\"><b>Results #: "+bookShelfSearch.getMaxRow()+"</b></td></tr>");
					
					if(nav.equals("default")){
						bookShelfSearch.setCursorPos(0);
					}
						else if(nav.equals("forward") && bookShelfSearch.getCursorPos() + (bookShelfSearch.getMaxRow() / 2)<  bookShelfSearch.getMaxRow()){
							bookShelfSearch.setCursorPos(bookShelfSearch.getCursorPos() + 10);
						}
							else if(nav.equals("backward") && bookShelfSearch.getCursorPos() != 0){
								bookShelfSearch.setCursorPos(bookShelfSearch.getCursorPos() - 10);
							}
					if(bookShelfSearch.getMaxRow() > 10)
					{
						//next and previous links
						out.println("<tr>"+
									"<td align =\"right\">"+
									"<a href=\"bookSearch.jsp?nav=backward\" title=\"Previous\">Previous 10</a>"+
									"</td>"+
									"<td align =\"left\">"+
									"<a href=\"bookSearch.jsp?nav=forward\" title=\"Next\">Next 10</a>"+
									"</td>"+
									"</tr>");
					}
					rs.absolute(bookShelfSearch.getCursorPos());
					
						while(rs.next() && index < 10){
							response.setContentType("text/html");
							out.println("<tr><td valign='top' align ='right'>" +
									"<a href = \"bookInfo.jsp?id="+rs.getString("ISBN")+"\"><img src =\""+rs.getString("ISBN")+ ".jpg\" width = '100' height = '150' title ='"+rs.getString("titleName")+"'></a></td>"+ 
									"<td><b>Book Title:</b><a href = 'bookInfo.jsp?id="+rs.getString("ISBN")+"' title ='"+rs.getString("titleName")+"'>" +rs.getString("titleName") +"</a><br>"+
									"<b>Book Author:</b>" +rs.getString("author") +"<br>"+
									"<b>Book Price:</b>" +rs.getDouble("price") +"<br></td></tr>");
										index++;	
									bookShelfSearch.setIsMaxRowSet(false);
						}
					out.println("</table></form>");
				}
				catch(Exception e){
				errorPrinter.setCurrentError(e);
				session.setAttribute("errorPrinter", errorPrinter);
				response.sendRedirect(response.encodeRedirectURL("errorOccurred.jsp"));
				}
			}
	%>
	</div>
  </body>
</html>
