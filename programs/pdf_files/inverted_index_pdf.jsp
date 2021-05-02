<%-- 
    Document   : inverted_index_pdf
    Created on : 13 Jul, 2017, 8:02:18 PM
    Author     : Anirban
--%>

<%@page import = "java.sql.*" %>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.io.*" %>
<%@ page language="java" import = "java.util.Arrays" %>
<%@page language = "java" import = "java.util.Scanner" %>
<%@ page import="java.sql.SQLException"%>
<%@page language = "java" import = "java.io.File"%>
<%@page language = "java" import = "java.io.FileNotFoundException" %>

<%@page import = "org.apache.pdfbox.pdmodel.PDDocument"%>
<%@page import = "org.apache.pdfbox.text.PDFTextStripper"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv = "Content-Type" Content = "text/html;charset=UTF-8">
	</head>

	<body>

	
		 <input type="button" onclick="gob()" value="<<" />
		 
		 <script>
		 
			function gob()
			{
				
				document.body.innerHTML = '';
				window.location.href="http://localhost:8080/drdo_project/home_pdf.html#loaded";
			}
			
			</script>
			
		<script>
    
    window.onload = function() {
    if(!window.location.hash) {
        window.location = window.location + '#loaded';
        window.location.reload();
    }
}
    
</script>

	<%


		String s1 = new String();
		String[] Doc_name = new String[100];
		int[] Doc_id = new int[100];
		String[] Words =new String[100];
		String[] Frequency = new String[100];
		StringBuilder buffer = new StringBuilder();
		StringBuilder buffer1 = new StringBuilder();
		Boolean pro =false;
		String qRelevant = null;
		int flag;
		String[] inverted = new String[30];
		Scanner query=null,query_after_delete=null;

	

	
		java.sql.Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		String driverName = "com.mysql.jdbc.Driver";
		String URL = "jdbc:mysql://localhost:3306/information_retrival" ;
		String user = "root";
		String password = "*********";
		String sql ="SELECT * FROM relevant_words_pdf";
		
		try{
			query = new Scanner(new String(request.getParameter("Query")));
			query_after_delete = new Scanner(new String(request.getParameter("Query")));
			
		}catch(Exception e)
		{
			out.println(e);
		}

		String[] stopwords = {"a", "about", "above", "above", "across", "after", "afterwards", "again", "against", "all", "almost",
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
            "discussion", "tmus", "diffrent", "layout", "area", "thanks", "thankyou", "hello", "bye", "rise", "fell", "fall", "psqft.", "http://", "km", "miles"};
			
			try{
				
			while(query.hasNext())
			{
				flag = 1;
				s1 = query.next();
				s1 = s1.toLowerCase();
				for(int i=0;i < stopwords.length;i++)
				{
					if(s1.equals(stopwords[i]))
					{
						flag = 0;
						break;
					}
				}
		
				if(flag != 0)
				{
		
					if(s1.length() > 0)
					{
						if(pro)
						{
							try{
								buffer.append(" ");
							}catch(Exception e)
							{
								out.println(e);
							}
						}
						try{
							buffer.append(s1);
						}catch(Exception e)
						{
							out.println(e);
						}
						pro = true;	
					}
				}
			}
			}catch(Exception e)
			{
				out.println(e);
				out.println("Re-check your query");
			}
			
		
		try{
			qRelevant = buffer.toString();
		}catch(Exception e)
		{
			out.println(e);
		}
		pro = false;
		
		
		try{
		
			Class.forName(driverName);
			conn = DriverManager.getConnection(URL, user, password);
		}
		
		catch(SQLException e )
		{
			out.println(e);
			
		}
		

		try{
			ps = conn.prepareStatement(sql);
		}
		catch(SQLException e){
			out.println(e);
		
		}
					
			
		try{
			rs = ps.executeQuery();
		}
		catch(SQLException e){
			out.println(e);
			
		}

		
		
		try{
			int i = 0;
			
		if(rs.next())
		{
			Doc_id[i] = rs.getInt("doc_id" );
			Doc_name[i] = rs.getString("doc_name");
			Words[i] = rs.getString("words");
			Frequency[i] = rs.getString("frequency");
				i++;
			while(rs.next())
			{
				
				Doc_id[i] = rs.getInt("doc_id" );
				Doc_name[i] = rs.getString("doc_name");
				Words[i] = rs.getString("words");
				Frequency[i] = rs.getString("frequency");
				
				
				i++;
			}
		}
		
		else {
		
			out.println("error in retriving information from the database");
		}
		}catch(Exception e)
		{
				out.println(e);
				out.println("is there any problem?");
		}
		
		String[] qRelevant_tokens = new String[30];
		qRelevant_tokens = qRelevant.split(" ");
		
		%>
		
		<h2> YOUR QUERY WAS: </h2>
		<br />
		
		<%
			while(query_after_delete.hasNext())
			{
				String abc = query_after_delete.next();
				out.println(abc);
			}
		%>
		
		<br /><br /><br /><br />
		<table border ="2">
		<tr>
		<th>word</th>
		<th> document</th>
		</tr>
		
		
			
		<%
		
		
		for(int i=0; i<qRelevant_tokens.length && qRelevant_tokens[i] != null; i++)
		{
			for(int j=0; j<Words.length && Words[j] != null; j++)
			{
				String[] words_tokens = Words[j].split(" ");
				String[] frequency_tokens = Frequency[j].split(" ");
				int k =0;
				for( String w :words_tokens)
				{
					try{
		
						if(w.equals(qRelevant_tokens[i]))
						{
							if(pro)
							{
								buffer1.append(" ");
								
							}
							buffer1.append(Doc_name[j]+"("+frequency_tokens[k]+")");
							
							pro = true;
							break;
						}
		
						else{
								k++;
						}
					}
					catch(Exception e)
					{
						out.println(e);
		
					}
				}
				
			}
		
			pro =  false;
			inverted[i] = buffer1.toString();
			
		%>
		
		<tr>
		<td>
			<% out.println(qRelevant_tokens[i]); %>
		
		</td>
		
		
		<td>
			<% out.println(inverted[i]); %>
		</td>
		
		</tr>
		
		<%
		}
		%>
		
		</table>
		
		<%
		if(rs != null)
		{
			try{
				rs.close();
			}
			catch(Exception e)
			{
				out.println(e);
			}
		}
		else{
			out.println("there is some locha with rs");
		}
		
		
		if(ps != null)
		{
			try{
				ps.close();
			}
			catch(Exception e)
			{
				out.println(e);
			}
		}
		else{
			out.println("there is some locha with ps");
		}
		
		if(conn != null)
		{
			try{
				conn.close();
		}catch(Exception e)
		{
			out.println(e);
		}
		}
		else{
			out.println("there is some locha with the connection itself");
		}
		
		try{
			Arrays.fill(qRelevant_tokens,null);
			Arrays.fill(Doc_name,null);
			Arrays.fill(Words,null);
			Arrays.fill(Frequency,null);
			Arrays.fill(inverted,null);
			
		}
catch(Exception e)
{
		out.println(e);
}
		 %>
		 <br><br><br>
		 
			
		 </body>
		 </html>
		 
		
		
