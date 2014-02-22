package javabeans;
/**
 * 
 * @author Tom Reese
 *
 */
public class BookShelf {
	private String bookSearch;
	private int counter, cursorPos, maxRow;
	private boolean isMaxRowSet;
	
	public BookShelf()
	{}
	/*ACCESSORS*/
	public int getCursorPos()
	{
		return cursorPos;
	}
	public int getCounter()
	{
		return counter;
	}
	public String getBookSearch()
	{
		return bookSearch;
	}
	public int getMaxRow()
	{
		return maxRow;
	}
	public boolean getIsMaxRowSet()
	{
		return isMaxRowSet;
	}
	/*MUTATORS*/
	public void setCounter(int counter)
	{
		this.counter = counter;
	}
	public void setCursorPos(int cursorPos)
	{
		this.cursorPos = cursorPos;
	}
	public void setBookSearch(String bookSearch)
	{
		this.bookSearch = bookSearch;
	}
	public void setMaxRow(int maxRow)
	{
		this.maxRow = maxRow;
	}
	public void setIsMaxRowSet(boolean isMaxRowSet)
	{
		this.isMaxRowSet = isMaxRowSet;
	}
}
