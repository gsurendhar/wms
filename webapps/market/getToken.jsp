<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.sql.*" %> 

<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@page import="java.io.PrintStream"%>
 



 <%
 String Token;
 Connection con=null;
 Statement stmt=null;
 ResultSet rs=null;
 String query="";
 %>  
   <%-- Retrieve parameters from Session --%>
  <% Token = request.getParameter("request_token"); 
 // System.out.println(Token);
 //insert into token(token,date_inserted) values (Token,now());
   %>
 
<%

try
	{
//Class.forName("com.mysql.jdbc.Driver");
 Class.forName("com.mysql.cj.jdbc.Driver");
con = DriverManager.getConnection( "jdbc:mysql://192.168.1.60:3306/market", "root", "Obel@1919@");
//		con=ConnectionProvider.getCon();
        stmt =  con.createStatement();

	stmt.executeUpdate("delete from token;" );
	query="insert into token(request_token,date_inserted) values ('"+Token+"',now());";
	out.println(query);
	stmt.executeUpdate(query);
//	con.close();
	
	
}

catch(Exception e)
{
	System.out.println("Exception:"+e);
	out.println(e);
}
%>

 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
 Token:<%=Token%> 
</body>
</html>


