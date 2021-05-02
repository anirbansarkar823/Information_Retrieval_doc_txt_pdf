<%-- 
    Document   : reading_single_pdf_file
    Created on : 11 Jul, 2017, 6:52:43 PM
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
            File file = new File("C:\\Users\\user_name\\Desktop\\drdo_project\\doc_files\\document1.pdf");
            PDDocument doc = PDDocument.load(file);
            
            PDFTextStripper pdfStripper = new PDFTextStripper();
            String text = pdfStripper.getText(doc);
            out.println(text);
            doc.close();
            
               }
            catch(Exception e)
                               {
                out.println(e);
    }
%>
    </body>
</html>
