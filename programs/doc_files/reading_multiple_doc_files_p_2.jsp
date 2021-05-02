
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import= "org.apache.jasper.tagplugins.jstl.core.Out"%>
<%@page language="java" import= "java.io.File" %>
<%@page language="java" import= "java.io.FileInputStream"%>
<%@page language="java" import= "java.util.List"%>

<%@page import= "org.apache.poi.hwpf.HWPFDocument"%>
<%@page import= "org.apache.poi.hwpf.extractor.WordExtractor"%>
<%@page import= "org.apache.poi.xwpf.usermodel.XWPFDocument"%>
<%@page import= "org.apache.poi.xwpf.usermodel.XWPFParagraph"%>

<%@ page language="java" import="java.util.Scanner" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
		
		int i=0;
        try{                   
                   
                File din = new File("C:\\Users\\user_name\\Desktop\\sample_set_files\\");
		
                File[] listOfFiles = din.listFiles();
				
				
                //Creating Scanner instance to read file
                for(File file:listOfFiles){
				i++;
                    if(file.isFile() && (file.getName().substring(file.getName().lastIndexOf('.') + 1).equals("doc")))
                {
					
					
					
			                                                                   
                
            FileInputStream fis = new FileInputStream(file.getAbsolutePath());
            
            HWPFDocument doc = new HWPFDocument(fis);
            
            WordExtractor we = new WordExtractor(doc);
            
            String[] paragraphs = we.getParagraphText();
            
            out.println("Total no. of paragraphs " + paragraphs.length);
            
            for(String para: paragraphs)
                               {
                out.println("<br /><br />" + para.toString());
                
            }
            
            fis.close();
				out.println( "<br /><br /><br />");
                       }
                                       }
            
        }catch(Exception e)
                               {
							   if(i == 0)
            out.println("There is no file with doc extension");
			
			else
			out.println("There is no more file with doc extension");
        }
        out.println("<br /><br /><br />");
        
        %>
        
        <!-- Reading docx files-->
        
        <%
		
		int j = 0;
            try{
            File din = new File("C:\\Users\\user_name\\Desktop\\sample_set_files\\");
		
                File[] listOfFiles = din.listFiles();
				
				
                //Creating Scanner instance to read file
                for(File file:listOfFiles){
				j++;
                    if(file.isFile() && (file.getName().substring(file.getName().lastIndexOf('.') + 1).equals("docx")))
                {
					
			
            FileInputStream fis = new FileInputStream(file.getAbsolutePath());
            
            XWPFDocument docu = new XWPFDocument(fis);
            
            List<XWPFParagraph> paragraphs = docu.getParagraphs();
            
            out.println("Total no. of paragraphs "+paragraphs.size());
            
            for(XWPFParagraph parag: paragraphs)
                               {
                out.println("<br /><br />" +parag.getText());
            }
                       
            fis.close();
                       }
              }
                  }catch(Exception e)
                                                   {
												   if(j == 0)
                      out.println("there is no file with docx extension");
					  else
						out.println("there is no more file with docx extension");
                  }
        %>
        
                

    </body>
</html>
