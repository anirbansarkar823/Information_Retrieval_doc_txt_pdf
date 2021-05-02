

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import= "org.apache.jasper.tagplugins.jstl.core.Out"%>
<%@page language="java" import= "java.io.File" %>
<%@page language="java" import= "java.io.FileInputStream"%>
<%@page language="java" import= "java.util.List"%>

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
        try{
            File file = new File("document1.doc");
            
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
            
            
        }catch(Exception e)
                               {
            out.println("There is no file with doc extension");
        }
        
        %>
        
        <!-- Reading docx files-->
        
        <%
            try{
            File file1 = new File("document1.docx");
            FileInputStream fis = new FileInputStream(file1.getAbsolutePath());
            
            XWPFDocument docu = new XWPFDocument(fis);
            
            List<XWPFParagraph> paragraphs = docu.getParagraphs();
            
            out.println("Total no. of paragraphs "+paragraphs.size());
            
            for(XWPFParagraph parag: paragraphs)
                               {
                out.println("<br /><br />" +parag.getText());
            }
            
            fis.close();
                  }catch(Exception e)
                                                   {
                      out.println("There is no file with docx entension");
                  }
        %>
    </body>
</html>
