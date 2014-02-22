package javabeans;

import java.util.ArrayList;
import java.util.Random;

public class TomsUtility {

	ArrayList<String> firstNames = new ArrayList<String>();
	ArrayList<String> lastNames = new ArrayList<String>();
	ArrayList<String> alphabet = new ArrayList<String>();
	ArrayList<String> special = new ArrayList<String>();
	ArrayList<String> months = new ArrayList<String>();
	ArrayList<String> streets = new ArrayList<String>();
	ArrayList<Integer> courseQuantitys = new ArrayList<Integer>();
	String currentFirstName, currentLastName, letter,
			letterTwo, letterThree, letterFour, day, month, year, itAll;
	int amountToGenerate, course, pLetter, courseID, stepIndex;
	Random random = new Random();
	/**
	 * This is the default constructor for toms utility class.
	 */
	public TomsUtility()
	{}
	
	/**
	 * This gets a random number based on the alphabet array.
	 * @return random number
	 */
	public int getRandomLetter()
	{
		pLetter = random.nextInt(alphabet.size());
		
		return pLetter;
	}
	/**
	 * This builds a unique random password for each student.
	 * @return random unique password
	 */
	public String getPassword()
	{
		//get a number between 10 to 1000
		int pnum = 1000 + random.nextInt(100000);
		letter = alphabet.get(getRandomLetter());
		letterTwo = alphabet.get(getRandomLetter());
		letterThree = alphabet.get(getRandomLetter());
		letterFour = alphabet.get(getRandomLetter());
		String password = letter + letterTwo + letterThree + letterFour + Integer.toString(pnum);
		return password;
	}
	/**
	 * This gets a random first name from the array.
	 * @return random first name
	 */
	public String getFirstName()
	{
		int f = random.nextInt(firstNames.size());
		String fname = firstNames.get(f);
		currentFirstName = fname;
		return fname;
	}
	/**
	 * This gets a random last name from the array.
	 * @return random last name
	 */
	public String getLastName()
	{
		int l = random.nextInt(lastNames.size());
		String lname = lastNames.get(l);
		currentLastName = lname;
		return lname;
	}
	
	/**
	 * This builds a unique id for each student.
	 * @return unique user id
	 */
	public String getStudentId()
	{
		int i = 10 + random.nextInt(989);
		char first = currentFirstName.charAt(0);
		char last = currentLastName.charAt(0);
		itAll = first + "" + last + "" + Integer.toString(i) + "" +"@gmail.com";
		return itAll;
	}

	
	/**
	 * This method builds a random date in the format TO_DATE(day, month, year)
	 * @return a string of a date
	 */
	public String getDate()
	{
		int rDay = 1 + random.nextInt(30);
		day = Integer.toString(rDay);
		int rMonth = random.nextInt(months.size());
		month = months.get(rMonth);
		int rYear = 1990 + random.nextInt(21);
		itAll = "TO_DATE(' "+ day +"-"+ month + "-"+ rYear +"', 'DD-MON-YYYY'";
		return itAll;
	}
	
	/**
	 * This builds a random book id min = 100000000 max = 800000000
	 * @return a random string book id
	 */
	public String getBookID()
	{
		int rBookID = 100000000 + random.nextInt(800000000);
		
		itAll = Integer.toString(rBookID);
		return itAll;	
	}
	public String getOrderID()
	{
		itAll = random.nextInt(100) +""+ random.nextInt(100)+""+random.nextInt(100) +""+ random.nextInt(100)+""+random.nextInt(100) +""+ random.nextInt(100);
		return itAll;
	}
	public String getOrderedItemID()
	{
		itAll = random.nextInt(100) +""+ random.nextInt(100)+""+random.nextInt(100) +""+ random.nextInt(100)+""+random.nextInt(100) +""+ random.nextInt(100);
		return itAll;
	}
	/**
	 * This returns a random book call number min = 10000000 max = 80000000
	 * @return a string containg the random number
	 */
	public String getCallNum()
	{
		int rCallNum = 10000000 + random.nextInt(80000000);
		
		itAll = Integer.toString(rCallNum);
		
		return itAll;
	}
	
	/**
	 * This builds a random address, gets a random first name to set the street name
	 * @return a random string containing the random address
	 */
	public String getAddress()
	{
		int rFirst = random.nextInt(firstNames.size());
		int rSType = random.nextInt(streets.size());
		int rNumber = 1000 + random.nextInt(8000);
		
		itAll = firstNames.get(rFirst) + Integer.toString(rNumber) + streets.get(rSType);
		return itAll;
	}
	
	/**
	 * 
	 * @param month
	 * @return
	 */
	public String getMonth(int month)
	{
		String thisMonth = "";
		switch(month)
		{
		case 0: thisMonth = "JAN"; break;
		case 1: thisMonth = "FEB"; break;
		case 2: thisMonth = "MAR"; break;
		case 3: thisMonth = "APR"; break;
		case 4: thisMonth = "MAY"; break;
		case 5: thisMonth = "JUN"; break;
		case 6: thisMonth = "JUL"; break;
		case 7: thisMonth = "AUG"; break;
		case 8: thisMonth = "SEP"; break;
		case 9: thisMonth = "OCT"; break;
		case 10: thisMonth = "NOV"; break;
		case 11: thisMonth = "DEC"; break;
		}
		
		return thisMonth;
	}
	
	/**
	 * 
	 * @param index
	 * @return
	 */
	public int getCourseQuantity(int index)
	{
		return courseQuantitys.get(index);
	}
	
	public void addCourseQuantitys()
	{
//		o	Computer Programming Courses: 135 registered students.
		courseQuantitys.add(45);
		courseQuantitys.add(35);
		courseQuantitys.add(20);
		courseQuantitys.add(35);
	//o	Multimedia: 194 registered students.
		courseQuantitys.add(42);
		courseQuantitys.add(42);
		courseQuantitys.add(30);
		courseQuantitys.add(80);
	//Computer Aided Drafting: 120 registered students.
		courseQuantitys.add(30);
		courseQuantitys.add(25);
		courseQuantitys.add(25);
		courseQuantitys.add(40);
	//General Education: 459 registered students.
		courseQuantitys.add(150);
		courseQuantitys.add(109);
		courseQuantitys.add(75);
		courseQuantitys.add(125);
	}

	/**
	 * Fill the names array lists.
	 */
	public void addNames(){

		firstNames.add("Matt");
		firstNames.add("Tim");
		firstNames.add("Noah");
		firstNames.add("John");
		firstNames.add("Sam");
		firstNames.add("Jake");
		firstNames.add("Sean");
		firstNames.add("Mike");
		firstNames.add("Jesse");
		firstNames.add("Tom");
		firstNames.add("Pete");
		firstNames.add("James");
		firstNames.add("Jim");
		firstNames.add("Jonathan");
		firstNames.add("Reese");
		firstNames.add("Lucas");
		firstNames.add("David");
		firstNames.add("Bill");
		firstNames.add("Cody");
		firstNames.add("Brown");
		firstNames.add("Kato");
		firstNames.add("Greg");
		firstNames.add("Doug");
		firstNames.add("Jeremy");
		firstNames.add("Chris");
		//25 above this
		firstNames.add("Lance");
		firstNames.add("Christian");
		firstNames.add("Chandra");
		firstNames.add("Saundra");
		firstNames.add("Darren");
		firstNames.add("Neil");
		firstNames.add("Julio");
		firstNames.add("Earnestine");
		firstNames.add("Jerri");
		firstNames.add("Tania");
		firstNames.add("Clinton");
		firstNames.add("Max");
		firstNames.add("Kelly");
		firstNames.add("Fernando");
		firstNames.add("Guy");
		firstNames.add("Tyrone");
		firstNames.add("Mathew");
		firstNames.add("Melisa");
		firstNames.add("Katy");
		firstNames.add("Margery");
		firstNames.add("Lilia");
		firstNames.add("Noreen");
		firstNames.add("Penelope");
		firstNames.add("Dollie");
		firstNames.add("Sara");
		//50 above this
		
		
		lastNames.add("Lucas");
		lastNames.add("Brown");
		lastNames.add("Miller");
		lastNames.add("Khalid");
		lastNames.add("Salzano");
		lastNames.add("Velasques");
		lastNames.add("McGinness");
		lastNames.add("Jaco");
		lastNames.add("Siemens");
		lastNames.add("Rucks");
		lastNames.add("Leto");
		lastNames.add("Rispoli");
		lastNames.add("Herford");
		lastNames.add("Sarkissian");
		lastNames.add("Grabert");
		lastNames.add("Pigott");
		lastNames.add("Riesgo");
		lastNames.add("Shellanbarger");
		lastNames.add("Dussault");
		lastNames.add("Beerman");
		lastNames.add("Nolin");
		lastNames.add("Alt");
		lastNames.add("Portera");
		lastNames.add("Bengston");
		lastNames.add("Holkamp");
		//25 above this
		lastNames.add("Lucas");
		lastNames.add("Brown");
		lastNames.add("Miller");
		lastNames.add("Gates");
		lastNames.add("Salzano");
		lastNames.add("Velasques");
		lastNames.add("McGinness");
		lastNames.add("Jaco");
		lastNames.add("Siemens");
		lastNames.add("Rucks");
		lastNames.add("Leto");
		lastNames.add("Rispoli");
		lastNames.add("Herford");
		lastNames.add("Sarkissian");
		lastNames.add("Grabert");
		lastNames.add("Pigott");
		lastNames.add("Riesgo");
		lastNames.add("Shellanbarger");
		lastNames.add("Dussault");
		lastNames.add("Beerman");
		lastNames.add("Nolin");
		lastNames.add("Alt");
		lastNames.add("Portera");
		lastNames.add("Bengston");
		lastNames.add("Holkamp");
		//50 above this
	}
	/**
	 * Fill the alphabet array list.
	 */
	public void addAlphabet()
	{
		alphabet.add("a");
		alphabet.add("b");
		alphabet.add("c");
		alphabet.add("d");
		alphabet.add("e");
		alphabet.add("f");
		alphabet.add("g");
		alphabet.add("h");
		alphabet.add("i");
		alphabet.add("j");
		alphabet.add("k");
		alphabet.add("l");
		alphabet.add("m");
		alphabet.add("n");
		alphabet.add("o");
		alphabet.add("p");
		alphabet.add("q");
		alphabet.add("r");
		alphabet.add("s");
		alphabet.add("t");
		alphabet.add("u");
		alphabet.add("v");
		alphabet.add("w");
		alphabet.add("x");
		alphabet.add("y");
		alphabet.add("z");
	}
	
	public void addSpecialChars()
	{
		special.add("!");
		special.add("$");
		special.add("%");
		special.add("&");
		special.add("_");
		special.add("+");
		special.add("=");
		special.add(";");
		
	}
	
	public void addMonths()
	{
		months.add("JAN");
		months.add("FEB");
		months.add("MAR");
		months.add("APR");
		months.add("MAY");
		months.add("JUN");
		months.add("JUL");
		months.add("AUG");
		months.add("SEP");
		months.add("OCT");
		months.add("NOV");
		months.add("DEC");
	}
	
	public void addCommonStreets()
	{
		streets.add("Boulevard");
		streets.add("Street");
		streets.add("Road");
		streets.add("Circle");
		streets.add("Avenue");
	}
}
