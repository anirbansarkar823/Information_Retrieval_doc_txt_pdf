<%-- 
    Document   : reading_multiple_pdf_files
    Created on : 13 Jul, 2017, 8:48:44 AM
    Author     : Anirban
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import= "java.io.IOException"%>
<%@page import = "java.io.File"%>

<%@page import = "org.apache.pdfbox.pdmodel.PDDocument"%>
<%@page import = "org.apache.pdfbox.text.PDFTextStripper"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        <%
            try{
            File din = new File("C:\\Users\\user_name\\Desktop\\drdo_project\\doc_files\\");
            File[] listOfFiles = din.listFiles();
            
             for(File file:listOfFiles){
                    if(file.isFile() && (file.getName().substring(file.getName().lastIndexOf('.') + 1).equals("pdf")))
                {
		
                    PDDocument doc = PDDocument.load(file);
            
                     PDFTextStripper pdfStripper = new PDFTextStripper();
                       String text = pdfStripper.getText(doc);
                       out.println(text + "<br /><br />");
                         doc.close();
            
               }
                                       }
                         }
            catch(Exception e)
                               {
                out.println(e);
    }
%>
        
          
       
    </body>
</html>
