package javabeans;
import java.sql.Date;

/**
 * 
 * @author Tom Reese
 *
 */
public class Book{
	private String ISBN, author, titleName, edition, category, publisherId;
	private Date date_of_publication;
	private double price;
	private int counter, quantity;
	
	/**
	 * This is the default constructor for the class Book.
	 */
	public Book()
	{}
	
	/**
	 * 
	 * @param ISBN
	 * @param publisherId
	 * @param author
	 * @param titleName
	 * @param edition
	 * @param price
	 * @param date_of_publication
	 * @param categories
	 * @param quantity
	 */
	public Book(String ISBN, String publisherId, String author, String titleName, 
				String edition, double price, Date date_of_publication, String category,
				int quantity)
	{
		this.ISBN = ISBN;
		this.publisherId = publisherId;
		this.author = author;
		this.titleName = titleName;
		this.edition = edition;
		this.price = price;
		this.date_of_publication = date_of_publication;
		this.category = category;
		this.quantity = quantity;
		
	}
	/*!!ACCESSORS BEGIN!!*/
	public String getISBN()
	{
		return ISBN;
	}
	public String getAuthor()
	{
		return author;
	}
	public String getTitleName()
	{
		return titleName;
	}
	public String getEdition()
	{
		return edition;
	}
	public double getPrice()
	{
		return price;
	}
	public Date getDate_Of_Publication()
	{
		return date_of_publication;
	}
	public String getCategory()
	{
		return category;
	}
	public int getCounter()
	{
		return counter;
	}
	public String getPublisherId(){
		
		return publisherId;
	}
	public int getQuantity(){
		return quantity;
	}
	/*!!ACCESSORS END!!*/
	/*!!MUTATORS BEGIN!!*/
	public void setISBN(String isbn)
	{
		this.ISBN = isbn;
	}
	public void setAuthor(String author)
	{
		this.author = author;
	}
	public void setTitleName(String titlename)
	{
		this.titleName = titlename;
	}
	public void setEdition(String edition)
	{
		this.edition = edition;
	}
	public void setPrice(double price)
	{
		this.price = price;
	}
	public void setDate_Of_Publication(Date date)
	{
		this.date_of_publication = date;
	}
	public void setCategories(String cat)
	{
		this.category = cat;
	}
	public void setCounter(int newCount)
	{
		this.counter = newCount;
	}
	public void setPublisherId(String publisherId)
	{
		this.publisherId = publisherId;
	}
	public void setQuantity(int quantity){
		this.quantity = quantity;
	}
}
