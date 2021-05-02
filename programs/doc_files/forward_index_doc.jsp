
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.io.*" errorPage="" %>
<%@page language = "java" import = "java.util.Map"%>
<%@page language = "java" import = "java.util.Scanner" %>
<%@page language = "java" import = "java.util.HashMap" %>
<%@page import = "java.sql.*" %>
<%@page language = "java" import = "java.io.File"%>
<%@page language = "java" import = "java.io.FileNotFoundException" %>
<%@ page import="java.sql.SQLException"%>

<%@page import= "org.apache.poi.hwpf.HWPFDocument"%>
<%@page import= "org.apache.poi.hwpf.extractor.WordExtractor"%>
<%@page import= "org.apache.poi.xwpf.usermodel.XWPFDocument"%>
<%@page import= "org.apache.poi.xwpf.usermodel.XWPFParagraph"%>


<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
      <%
	  

	  
	  String driverName = "com.mysql.jdbc.Driver";
	  String URL = "jdbc:mysql://localhost:3306/information_retrival";
	  String username = "root";
	  String password = "******";
	  java.sql.Connection conn = null;
	  PreparedStatement ps = null;
	  
	  try{
		  Class.forName(driverName);
		   conn = DriverManager.getConnection(URL, username, password);
		  
		  if(conn != null)
		  {
			 out.println("");
		  }
		  else{
				out.println("not connected");
		  }
		 }
		  catch(SQLException e)
		  {
			  out.println(e);
			  e.printStackTrace();
		  }
		  
	    
		String fileName = new String();
		
	String[] stopwords = {"a", "the", "when", "about", "above", "above", "across", "after", "afterwards", "again", "against", "all", "almost",
            "alone", "along", "already", "also", "although", "always", "am", "among", "amongst", "amoungst", "amount", "an", "and",
            "another", "any", "anyhow", "anyone", "anything", "anyway", "anywhere", "are", "around", "as", "at", "back", "be", "became",
            "because", "become", "becomes", "becoming", "been", "before", "beforehand", "behind", "being", "below", "beside", "besides",
            "between", "beyond", "bill", "both", "bottom", "but", "by", "call", "can", "cannot", "cant", "co", "con", "could", "couldnt",
            "cry", "de", "describe", "detail", "do", "done", "down", "due", "during", "each", "eg", "eight", "either", "eleven", "else",
            "elsewhere", "empty", "enough", "etc", "even", "ever", "every", "everyone", "everything", "everywhere", "except", "few",
            "fifteen", "fify", "fill", "find", "fire", "first", "five", "for", "former", "formerly", "forty", "found", "four", "from",
            "front", "full", "further", "get", "give", "go", "had", "has", "hasnt",
            "have", "he", "hence", "her", "here", "hereafter", "hereby", "herein", "hereupon", "hers", "herself",
            "him", "himself", "his", "how", "however", "hundred", "ie", "if", "in", "inc", "indeed", "interest", "into",
            "is", "it", "its", "itself", "keep", "last", "latter", "latterly", "least", "less", "ltd", "made", "many",
            "may", "me", "meanwhile", "might", "mill", "mine", "more", "moreover", "most", "mostly", "move", "much", "must",
            "my", "myself", "name", "namely", "neither", "never", "nevertheless", "next", "nine", "no", "nobody", "none",
            "noone", "nor", "not", "nothing", "now", "nowhere", "of", "off", "often", "on", "once", "one", "only", "onto",
            "or", "other", "others", "otherwise", "our", "ours", "ourselves", "out", "over", "own", "part", "per", "perhaps",
            "please", "put", "rather", "re", "same", "see", "seem", "seemed", "seeming", "seems", "serious", "several", "she",
            "should", "show", "side", "since", "sincere", "six", "sixty", "so", "some", "somehow", "someone", "something",
            "sometime", "sometimes", "somewhere", "still", "such", "system", "take", "ten", "than", "that", "the", "their",
            "them", "themselves", "then", "thence", "there", "thereafter", "thereby", "therefore", "therein", "thereupon",
            "these", "they", "thickv", "thin", "third", "this", "those", "though", "three", "through", "throughout", "thru",
            "thus", "to", "together", "too", "top", "toward", "towards", "twelve", "twenty", "two", "un", "under", "until",
            "up", "upon", "us", "very", "via", "was", "we", "well", "were", "what", "whatever", "when", "whence", "whenever",
            "where", "whereafter", "whereas", "whereby", "wherein", "whereupon", "wherever", "whether", "which", "while",
            "whither", "who", "whoever", "whole", "whom", "whose", "why", "will", "with", "within", "without", "would", "yet",
            "you", "your", "yours", "yourself", "yourselves", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "1.", "2.", "3.", "4.", "5.", "6.", "11",
            "7.", "8.", "9.", "12", "13", "14", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
            "terms", "CONDITIONS", "conditions", "values", "interested.", "care", "sure", ".", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "{", "}", "[", "]", ":", ";", ",", "<", ".", ">", "/", "?", "_", "-", "+", "=",
            "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
            "contact", "grounds", "buyers", "tried", "said,", "plan", "value", "principle.", "forces", "sent:", "is,", "was", "like",
            "discussion", "tmus", "diffrent.", "layout", "area.", "thanks", "thankyou", "hello", "bye", "rise", "fell", "fall", "psqft.", "http://", "km", "miles"};

%>

<table border ="1">
<tr>
<th> DOCUMENTS</th>
<th> WORDS</th>
</tr>

<%

File din = new File("C:\\Users\\user_name\\Desktop\\sample_set_files\\");
		
                File[] listOfFiles = din.listFiles();
				
				
                //Creating Scanner instance to read file
                for(File file:listOfFiles){
				
                    if(file.isFile() && (file.getName().substring(file.getName().lastIndexOf('.') + 1).equals("doc")))
                {
					
					FileInputStream fis = new FileInputStream(file.getAbsolutePath());
            
					HWPFDocument doc = new HWPFDocument(fis);
            
					WordExtractor we = new WordExtractor(doc);
			
					Scanner scnn = new Scanner(we.getText());
					
					
					
                //Reading each word
                int wordNumber = 0;

	
	%>
	
	
	<tr>
	<td>
	
	<a href ="<%=file.getName()%>"><%out.println(file.getName());%></a>
	</td>
	
	<td>
	<%
	
	fileName = file.getName();
	
	Map<String, Integer> map = new HashMap<String, Integer>();
	Integer ONE = new Integer(1);
	
	while(scnn.hasNext())
	{
		wordNumber++;
		int flag = 1;
		String word = scnn.next();
		word = word.toLowerCase();
		for(int i=0; i<stopwords.length && flag != 0; i++)
		{
			if(word.equals(stopwords[i]))
			{
				flag = 0;
			}
		
		}
			if(flag != 0)
			{
				if(word.length() > 0)
				{
					Integer frequency = (Integer) map.get(word);
		
					if(frequency == null)
					{
						frequency = ONE;
					}
		
		
				else{
					int value = frequency.intValue();
					frequency = new Integer(value +1);
					}
		
					map.put(word,frequency);
				}
			}
		
		
		
	
	}
	out.println(map);
	
	
	
		StringBuilder buffer = new StringBuilder();
		boolean processedFirst = false;
		String firstParam = null, secondParam = null;
		
		try{
			for(Map.Entry m :map.entrySet())
			{
				if(processedFirst)
				{
					buffer.append(" ");
				}
				
				buffer.append(m.getKey());
				processedFirst = true;
				
			}
			firstParam = buffer.toString();
		}
		finally{
			buffer = null;
		}
		processedFirst = false;
		
		
		buffer = new StringBuilder();
		
		try{
			for(Map.Entry m: map.entrySet())
			{
				if(processedFirst)
				{
					buffer.append(" ");
				}
				
				buffer.append(m.getValue());
				processedFirst = true;
				
			}
			secondParam = buffer.toString();
		}
		finally{
			buffer = null;
		}
		
		
		String sql = "INSERT INTO relevant_words_docs( doc_name, words, frequency, total_words) VALUES (?,?,?,?)";
		
				try{
					ps = conn.prepareStatement(sql);
					ps.setString(1,fileName);
					ps.setString(2,firstParam);
					ps.setString(3,secondParam);
					ps.setInt(4,wordNumber);
					int a = ps.executeUpdate();
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
					
				if(ps != null)
				{
					try{
						ps.close();
						ps = null;
						
						}
						catch(Exception e)
						{
							e.printStackTrace();
						}
				}
				else
				{
					out.println("ps is still empty");
				}
				
				
			
		}
		
		}
		
		
		try{
				
				if(conn!= null && !conn.isClosed())
				{
					if(!conn.getAutoCommit())
					{
					conn.commit();
					conn.setAutoCommit(true);
					}
						conn.close();
						conn = null;
				}
				else{
				out.println("problem with connection");}
				}catch(SQLException e)
				{
					e.printStackTrace();
				}
		%>
		
		</td>
		</tr>
		
		</table>
		</body>
		</html>
		
	

