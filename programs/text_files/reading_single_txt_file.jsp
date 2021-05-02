<%-- 
    Document   : reading_single_txt_file
    Created on : 9 Jun, 2017, 8:05:43 PM
    Author     : Anirban
--%>

<%@page import="org.apache.jasper.tagplugins.jstl.core.Out"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.io.File"%>
<%@ page language="java" import="java.io.FileNotFoundException"%>
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
           
            
                File text = new File("C:\\Users\\User_Name\\Desktop\\sample_set_files\\document1.txt");
                //this is the creation of file instance to reference to text files..
                
                //Creating Scanner instance to read file 
                Scanner scnn = new Scanner(text);
                
                //Reading each line
                int lineNumber = 1;
                %>
                <table border="1">
                    <tr>
                        <th>document</th>
                        <th>words</th>
                    </tr>
                    
                    <tr>
                        <td><% out.println(text.getName()); %></td>
                        <td>
                    
                 <%
                while(scnn.hasNextLine())
                       {
                            String line = scnn.nextLine();
                      %>
                           
                              
                            <% out.println("line " + lineNumber + ": " + line + "<br /><br />"); %>
                               
                <%
                            lineNumber++;
                }
                %>
                </td>
                           </tr>
               </table>
           
        
         
   
    </body>
</html>
