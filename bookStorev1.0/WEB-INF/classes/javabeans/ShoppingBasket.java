package javabeans;
import java.util.ArrayList;
import java.util.Date;

/**
 * 
 * @author Tom Reese
 *
 */
public class ShoppingBasket
{
	private double totalCost;
	private int itemQuantity;
	private ArrayList<Book> listBook = new ArrayList<Book>();
	private String orderInformation;
	
	/**
	 * This is the default constructor for ShoppingBasket.
	 */
	public ShoppingBasket()
	{}
	
	/*ACCESSORS!*/
	public String getBookISBN(int index)
	{
		return listBook.get(index).getISBN();
	}
	public String getAuthor(int index)
	{
		return listBook.get(index).getAuthor();
	}
	public String getTitleName(int index)
	{
		return listBook.get(index).getTitleName();
	}
	public String getEdition(int index)
	{
		return listBook.get(index).getEdition();
	}
	public double getPrice(int index)
	{
		return listBook.get(index).getPrice();
	}
	public Date getDateOfPublication(int index)
	{
		return listBook.get(index).getDate_Of_Publication();
	}
	public String getCategories(int index)
	{
		return listBook.get(index).getCategory();
	}
	public String getOrderInformation(){
		return orderInformation;
	}
	/*END ACESSORRS!*/
	
	public void setOrderInformation(String orderInformation)
	{
		this.orderInformation = orderInformation;
	}
	public void addToBasket(Book obj)
	{
		boolean itemFound = false;
		//list is empty go ahead and add
		if(listBook.size() <= 0){
			listBook.add(obj);
		}else{
			for(int i=0; i < listBook.size(); i++){
				//matching item, add the quantitys
				if(obj.getISBN().equals(listBook.get(i).getISBN())){
					listBook.get(i).setQuantity(listBook.get(i).getQuantity() + obj.getQuantity());
					itemFound = true;
				}
			}
			if(itemFound == false){
				listBook.add(obj);
			}
		}

	}
	public double getTotalCost()
	{
		//erase current total, recompute
		totalCost = 0.0;
		
		for(Book bk : listBook)
		{
			totalCost += ( bk.getPrice() * bk.getQuantity() );
		}
		return totalCost;
	}
	public int getListSize()
	{
		return listBook.size();
	}
	public int getItemQuantity(int index){

		return listBook.get(index).getQuantity();
	}
	public void removeBook(String bookISBN){
		for(int i =0; i < listBook.size(); i++)
		{
			if(listBook.get(i).getISBN().equals(bookISBN))
			{
				listBook.remove(i);
			}
		}
	}
	public void clearListBooks()
	{
		this.listBook.clear();
	}
}