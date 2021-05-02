



<%@page import = "java.sql.*" %>
<%@page import= "java.util.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.io.*" %>
<%@ page language="java" import = "java.util.Arrays" %>
<%@page language = "java" import = "java.util.Scanner" %>
<%@ page import="java.sql.SQLException"%>
<%@page language = "java" import = "java.io.File"%>
<%@page language = "java" import = "java.io.FileNotFoundException" %>
<%@page language = "java" import = "java.lang.*" %>


<%@page import= "org.apache.poi.hwpf.HWPFDocument"%>
<%@page import= "org.apache.poi.hwpf.extractor.WordExtractor"%>
<%@page import= "org.apache.poi.xwpf.usermodel.XWPFDocument"%>
<%@page import= "org.apache.poi.xwpf.usermodel.XWPFParagraph"%>


<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv = "Content-Type" Content = "text/html;charset=UTF-8">
	</head>

	<body>

	
		 <input type="button" onclick="gofront()" value="<<" />
		 
		 <script>
		 
			function gofront()
			{
				
				document.body.innerHTML = '';
				window.location.href="http://localhost:8080/raproject/home.html";
			}
			
			</script>
                        
                        
                        	<%
                          
		int Total_docs = 0;
                int R_docs = 0;
                Map<String, Double> map_idf = new HashMap<String, Double>();
                                  
                                
		String s1 = new String();
		String[] Doc_name = new String[100];
		int[] Doc_id = new int[100];
		String[] Words =new String[100];
		String[] Frequency = new String[100];
		int[] Total_words = new int[100];
		StringBuilder buffer = new StringBuilder();
		Boolean pro =false;
		String qRelevant = null;
		int flag;
		Scanner query=null,query_after_delete=null;
                
                Map<String,Map> tf_map = new HashMap<String,Map>();
                
                Map<String,Double> tfidf_map = new  HashMap<String,Double>();
                Map<String,Double> temp_map = new  HashMap<String,Double>();
                Map<Double,String> r_tfidf_map = new HashMap<Double,String>();
                
                double max;
                
                List<Double> sort_tfidf = new ArrayList<Double>();
                
                java.sql.Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
	
		String driverName = "com.mysql.jdbc.Driver";
		String URL = "jdbc:mysql://localhost:3306/information_retrival" ;
		String user = "root";
		String password = "*******";
		String sql ="SELECT * FROM relevant_words_docs";

                
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
				s1 = query.next(); // word till space
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
			Total_words[i] = rs.getInt("total_words");
			
				i++;
			while(rs.next())
			{
				
				Doc_id[i] = rs.getInt("doc_id" );
				Doc_name[i] = rs.getString("doc_name");
				Words[i] = rs.getString("words");
				Frequency[i] = rs.getString("frequency");
				Total_words[i] = rs.getInt("total_words");
				
				i++;
			}
		}
		
		else {
		
			out.println("error in retriving information from the database");
		}
                        i--;
                        Total_docs = Doc_id[i] - Doc_id[0] + 1;
		}catch(Exception e)
		{
				out.println(e);
				out.println("is there any problem?");
		}
		
		String[] qRelevant_tokens = new String[30];
		qRelevant_tokens = qRelevant.split(" ");
                
                
		
		%>
                
                <h2> YOUR QUERY WAS: </h2>
		
		
		<%
			while(query_after_delete.hasNext())
			{
				String abc = query_after_delete.next();
				out.println(abc);
			}
		%>
                
                <%
		
		
		for(int i=0; i<qRelevant_tokens.length && qRelevant_tokens[i] != null; i++)
		{ 
				Map<String,Double> tf_m = new HashMap<String,Double>();		
					
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
                                                    R_docs++;
                                                    
                                                    double fre = Double.parseDouble(frequency_tokens[k]);
                                                    fre = fre/Total_words[j];
                                                    double val = Math.round(fre * 10000d)/10000d;
                                    
                                                    tf_m.put(Doc_name[j],val);
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
                        
			
			// term which occurred on all documents, will get less idf value as it is less relevant; rare terms will get high idf values

                         tf_map.put(qRelevant_tokens[i],tf_m); 

                          double div = (double)Total_docs/(R_docs + 1);
                        
                        double rel = Math.log(div);
                        
                        double val = Math.round(rel * 10000d)/10000d;
                        
                        map_idf.put(qRelevant_tokens[i],val);
                        
		}
                
                
                
		%>
		
                 <%
                    
                            for(Map.Entry m:map_idf.entrySet())
                                                               {
                                Object IDF = m.getValue();
                                Object QRELEVANT = m.getKey();
                                
                                Double IDf = new Double(IDF.toString());
                                String QRELEVANt = new String(QRELEVANT.toString());
                                
                                for(Map.Entry m1:tf_map.entrySet())
                                                                       {
                                    if(QRELEVANt.equals(m1.getKey()))
                                                                               {
                                        temp_map = tf_map.get(QRELEVANt);
                                        
                                        for(Map.Entry m2:temp_map.entrySet())
                                                                                       {
                                           Object TF = m2.getValue();
                                            Object DOCS = m2.getKey();
                                
                                        Double Tf = new Double(TF.toString());
                                        String DOCs = new String(DOCS.toString()); 
                                        
                                          double tf_idf_v1 = Tf * IDf;
                                          double tf_idf_v = Math.round(tf_idf_v1 * 10000d)/10000d;
                                          int flag2 = 0;
                                          %>
                                          <!-- There is some problem with the loop below, its not running actually-->
                                          <%
                                          if(tfidf_map.isEmpty())
                                                                                           {
                                              tfidf_map.put(DOCs,tf_idf_v);
                                                 flag2 = 0;
                                                 break;
                                          }
                                          
                                         for(Map.Entry m3:tfidf_map.entrySet())
                                        {
                                            
                                              if(DOCs.equals(m3.getKey()))
                                                                                                 {
                                                 Object tf_v = m3.getValue();
                                                 Double tf_val = new Double(tf_v.toString());
                                
                                                 tfidf_map.remove(DOCs);
                                                 tf_val = tf_val + tf_idf_v;
                                                 tfidf_map.put(DOCs,tf_val);
                                                 flag2 = 0;
                                                 break;
                                             }
                                            else{
                                                  flag2 = 1;
                                                  continue;
                                                 
                                                                                         }
                                         }
                                         
                                         if(flag2 == 1)
                                                                                         {
                                             tfidf_map.put(DOCs,tf_idf_v);
                                         }
                                            
                                        }
                                        break;
                                    }
                                }
                            }
                            
                            
                            out.println("<br /><br />"+tfidf_map);
                            
               %>
               
                <%
                    
                             for(Map.Entry m4:tfidf_map.entrySet())
                                                               {
                                
                                
                                Object tfidf = m4.getValue();
                                                                
                                Double Tfidf = new Double(tfidf.toString());
                                                                
                               sort_tfidf.add(Tfidf);
                        }
                
                %>
                
                <!-- Now we need to sort the arraylist-->
                
                <%
                 Double [] sort_tfidf_array = new Double[sort_tfidf.size()];
                 
                 for(int i = 0;i < sort_tfidf.size();i++)
                                       {
                    sort_tfidf_array[i] = sort_tfidf.get(i).doubleValue();
                    
                    
                    
                    }
                    %>
                    <!-- insertion sort to sort the array in descending order -->
                  <%
            
                
                int j = 0;
                for(int i = 1;i < sort_tfidf_array.length;i++)
                                       {
                    max = sort_tfidf_array[i];
                    j = i - 1;
                    while(j >= 0 && sort_tfidf_array[j] < max)
                                               {
                        sort_tfidf_array[j+1] = sort_tfidf_array[j];
                        j = j - 1;
                    }
                    sort_tfidf_array[j+1] = max;
                    
                }
                %>
                <!--
                for(int k =0 ;k< sort_tfidf_array.length;k++)
                                       {
                    out.println(sort_tfidf_array[k]);
                }
                -->
               
               
                <%
                   
                    for(Map.Entry mm:tfidf_map.entrySet())
                                               {
                        Object tfidf = mm.getValue();
                        Object document = mm.getKey();
                                
                        Double Tfidf = new Double(tfidf.toString());
                        String Document = new String(document.toString());
                        
                        r_tfidf_map.put(Tfidf,Document);

                    }
                    
                    
                    String filename = new String();
                    
                    for(Double d:sort_tfidf_array)
                                               {
                        for(Map.Entry mmm:r_tfidf_map.entrySet())
                                                       {
                            Object Docu = mmm.getValue();
                            String docu = new String(Docu.toString());
                                
                                               
                            if(d.equals(mmm.getKey()))
                           {
                                
                                File din = new File("C:\\Users\\user_name\\Desktop\\sample_set_files\\");
				File[] listOfFiles = din.listFiles();
				
				
                                //Creating Scanner instance to read file
                                for(File file:listOfFiles){
                                if(file.isFile() && (file.getName().substring(file.getName().lastIndexOf('.') + 1).equals("doc")))
                                {
                                    filename = file.getName();
                                    if(filename.equals(docu))
                                    {
                                        out.println("<br /><br />");
                                        %>
                                        
                                        <a href ="<%=file.getName()%>"><%out.println(file.getName());%></a>
                                        
                                        <%
                                    }
                                }	
                                    
                              } 
                            }
                        }
                    }
                    
                %>
                
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
			out.println("there is some problem with rs");
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
			out.println("there is some problem with ps");
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
			out.println("there is some problem with the connection itself");
		}
		
		try{
			Arrays.fill(qRelevant_tokens,null);
			Arrays.fill(Doc_name,null);
			Arrays.fill(Words,null);
			Arrays.fill(Frequency,null);
			
			
		}
catch(Exception e)
{
		out.println(e);
}
		 %>
		 <br><br><br>
		 
			
		 </body>
		 </html>
