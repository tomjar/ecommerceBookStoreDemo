package javabeans;

/**
 * 
 * @author Tom Reese
 *
 */
public class BookStoreHeader {

	private String buttonHeader;
	private String footer;
	private String banner;
	private String homeLink, browseLink, searchLink, accountLink, contactUsLink, shoppingLink;
	private String logoutLink;
	
	public BookStoreHeader()
	{}
	public String getHeader(boolean loggedIn)
	{
		homeLink = "<a href =\"index.jsp\" title =\"Home\">Home</a>";
		browseLink = "<a href =\"bookBrowsing.jsp?nav=default&count=10\" title =\"Browse\">Browse</a>";
		searchLink = "<a href =\"bookSearch.jsp\" title =\"Search\">Search</a>";
		accountLink = "<a href =\"memberInformation.jsp\" title =\"Account Information\">Account Information</a>";
		contactUsLink = "<a href =\"contactUs.jsp\" title =\"Contact Us\">Contact Us</a>";
		shoppingLink = "<a href =\"shoppingBasket.jsp\" title =\"Shopping Basket\">Shopping Cart</a>";
		
		banner ="<a href =\"index.jsp\"><img class = \"banner\" src =\"book_logo.png\" title =\"Home\"></a>";
		
		buttonHeader ="<div class =\"header\">"+
						  "<div class =\"navlink\">"+homeLink+"</div>" +
						  "<div class =\"navlink\">"+browseLink+"</div>" +
						  "<div class =\"navlink\">"+searchLink+"</div>" +
						  "<div class =\"navlink\">"+accountLink+"</div>" +
						  "<div class =\"navlink\">"+contactUsLink+"</div>" +
						  "<div class =\"navlink\">"+shoppingLink+"</div>" +
					  "</div>";
		if(loggedIn)
		{
			logoutLink = "<div class =\"logoutLink\"><a href=\"index.jsp?loggedOut=true\" title=\"Logout\">Logout</a></div>";
		}
		else
		{
			logoutLink ="";
		}
		
		return banner + buttonHeader + logoutLink;
	}
	
	public String getFooter()
	{
		footer = "<div class = \"footer\">"+
					  "<div class =\"navlink\">"+homeLink+"</div>" +
					  "<div class =\"navlink\">"+browseLink+"</div>" +
					  "<div class =\"navlink\">"+searchLink+"</div>" +
					  "<div class =\"navlink\">"+accountLink+"</div>" +
					  "<div class =\"navlink\">"+contactUsLink+"</div>" +
					  "<div class =\"navlink\">"+shoppingLink+"</div>" +
				  "</div>";
		
		return footer;
	}
	
}
