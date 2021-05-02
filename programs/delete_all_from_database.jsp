<%@page import = "java.sql.*" %>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.io.*" %>
<%@ page language="java" import = "java.util.Arrays" %>
<%@page language = "java" import = "java.util.Scanner" %>
<%@ page import="java.sql.SQLException"%>



<!DOCTYPE html>
<html>
<head>
<meta http-equiv = "Content-Type" Content = "text/html ; charset = UTF-8">
</head>
<body>



<%

java.sql.Connection conn = null;
PreparedStatement ps = null;
String driverName = "com.mysql.jdbc.Driver";
String URL = "jdbc:mysql://localhost:3306/information_retrival" ;
String user = "root";
String password = "******";
String sql ="DELETE FROM relevant_words_docs WHERE doc_id=?";



	
		try{
		
		Class.forName(driverName);
		conn = DriverManager.getConnection(URL, user, password);
		}
		catch(SQLException e)
		{
			out.println("database connection problem <br /> <br />");
			out.println(e);
		}
		
		try
			{
				ps = conn.prepareStatement(sql);
				<%-- https://www.javatpoint.com/PreparedStatement-interface --%>
			}
		catch(Exception e)
			{
				out.println("ps exception <br /> <br />");
				out.println(e);
			}
			
			
		for(int i=1;i<=66;i++)
		{
			ps.setInt(1,i);
		try
			{
				 int dele = ps.executeUpdate();
				out.println(dele);
			}
		catch(Exception e)
			{
				out.println("re exception");
				out.println(e);
			}
		
		}
			
			try{
		ps.close();
		}catch(Exception e)
		{	out.println("ps exception <br /> <br />");
			out.println(e);
			}
			
			try{
			
		conn.close();
		}catch(Exception e)
		{out.println("database connection problem <br /> <br />");
			out.println(e);
			}
		
		
		 %>
		 </body>
		 </html>
		 
	
