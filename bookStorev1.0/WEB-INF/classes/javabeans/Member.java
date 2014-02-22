package javabeans;

/**
 * 
 * @author Tom Reese
 *
 */
public class Member
{
	private String email, fname, lname, address, city, state, zip_code, phone_number, 
					password, password_hint, registered_date, credit_card, credit_card_exp_date;
	private boolean isLoggedIn;
	/**
	 * The default constructor.
	 */
	public Member(){}
	
	/**
	 * This is the parameterized constructor for the class Member.
	 * @param email the members email.
	 * @param fname the members first name.
	 * @param lname the members last name.
	 * @param address the members address.
	 * @param city the members city.
	 * @param state the members state.
	 * @param zip_code the members zip code.
	 * @param phone_number the members phone number.
	 * @param password the members password.
	 * @param password_hint the members password hint.
	 * @param registered_date the members registered date.
	 * @param credit_card the members credit card number.
	 * @param credit_card_exp_date the members credit card expiration date.
	 */
	public Member(String email, String fname, String lname, String address, String city, String state, String zip_code, String phone_number, 
					String password, String password_hint, String registered_date, String credit_card, String credit_card_exp_date)
	{
		this.email = email;
		this.fname = fname;
		this.lname = lname;
		this.address = address;
		this.city = city;
		this.state = state;
		this.zip_code = zip_code;
		this.phone_number = phone_number;
		this.password = password;
		this.password_hint = password_hint;
		this.registered_date = registered_date;
		this.credit_card = credit_card;
		this.credit_card_exp_date = credit_card_exp_date;
	}

	//ACCESSORS
	public String getEmail()
	{
		return email;
	}
	public String getFirstName()
	{
		return fname;
	}
	public String getLastName()
	{
		return lname;
	}
	public String getAddress()
	{
		return address;
	}
	public String getCity()
	{
		return city;
	}
	public String getState()
	{
		return state;
	}
	public String getZip()
	{
		return zip_code;
	}
	public String getPhone()
	{
		return phone_number;
	}
	public String getPassword()
	{
		return password;
	}
	public String getPasswordHint()
	{
		return password_hint;
	}
	public String getRegisteredDate()
	{
		return registered_date;
	}
	public String getCreditCard()
	{
		return credit_card;
	}
	public String getCreditCardExpDate()
	{
		return credit_card_exp_date;
	}
	public boolean getIsLoggedIn()
	{
		return isLoggedIn;
	}
	//MUTATORS
	public void setEmail(String email)
	{
		this.email = email;
	}
	public void setFname(String fname)
	{
		this.fname = fname;
	}
	public void setLname(String lname)
	{
		this.lname = lname;
	}
	public void setAddress(String address)
	{
		this.address = address;
	}
	public void setCity(String city)
	{
		this.city = city;
	}
	public void setState(String state)
	{
		this.state = state;
	}
	public void setZip(String zip_code)
	{
		this.zip_code = zip_code;
	}
	public void setPhone(String phone_number)
	{
		this.phone_number = phone_number;
	}
	public void setPassword(String password)
	{
		this.password = password;
	}
	public void setPasswordHint(String password_hint)
	{
		this.password_hint = password_hint;
	}
	public void setRegisteredDate(String registered_date)
	{
		this.registered_date = registered_date;
	}
	public void setCreditCard(String credit_card)
	{
		this.credit_card = credit_card;
	}
	public void setCreditCardExpDate(String credit_card_exp_date)
	{
		this.credit_card_exp_date = credit_card_exp_date;
	}
	public void setIsLoggedIn(boolean isLoggedIn)
	{
		this.isLoggedIn = isLoggedIn;
	}
	

}