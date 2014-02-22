package javabeans;
import java.io.PrintWriter;
import java.io.StringWriter;

/**
 * 
 * @author Tom Reese
 *
 */
public class ErrorPrinter {
	String currentError;
	
	/**
	 * 
	 */
	public ErrorPrinter(){}
	
	/**
	 * 
	 * @return
	 */
	public String getCurrentError()
	{
	        return currentError;
	}
	
	/**
	 * 
	 * @param t
	 */
	public void setCurrentError(Throwable t)
	{
		StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw, true);
        t.printStackTrace(pw);
        pw.flush();
        sw.flush();
        this.currentError = sw.toString();
	}
}
