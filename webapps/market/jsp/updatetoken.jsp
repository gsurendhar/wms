<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*" %>


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

try
	{
Class.forName("com.mysql.jdbc.Driver");
// Class.forName("com.mysql.cj.jdbc.Driver");
con = DriverManager.getConnection( "jdbc:mysql://localhost:3306/market", "root", "abc123");
//		con=ConnectionProvider.getCon();
        stmt =  con.createStatement();

}

catch(Exception e)
{
	//System.out.println("Exception:"+e);
	out.println(e);
}
%>

 %>  
 


<%!
	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	ResultSet rsrole=null;
	Statement stmtrole=null;
	String query="";
	int count=0;
	int DisRow=0;
%>

<%

	String act = request.getParameter("act"); 
	String vid = request.getParameter("txtid");
	String vtoken = request.getParameter("txtCompany");

out.println(act);
 %>

<html>
<head>
<link href="../styles/styles.css" rel="stylesheet" type="text/css">

<title> User Management </title>
</head>
<body>


<form action="code.jsp" method="post" name="frmentry" >
<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch"  bgcolor="#DBEBFF"> 
<tr> <td colspan="2" align="Center" class="Blue-content"><%=act%> Code</td><tr> 
<tr><td class="Blue-content">access Token</td><td><input type="text" name="txtCompany" class="content style1" size="100"> </td></tr>
</tr>
 
  <tr>
 <td  align="right"><input type="submit" name="act" value="Insert"></td>
 <td  align="left"> <input type="submit" name="act" value="Cancel"></td>
 </tr>
</table>
<%
}
if ("Update".equalsIgnoreCase(act)){
		query=" update token set access_token='"+vtoken+"', date_inserted=now()";
		//out.println(query);
		stmt.executeUpdate(query);
	}
act=null;

rs=stmt.executeQuery("select access_token,date_inserted from token");
act="";
%>

<table width="100%" border="0" cellpadding="0" class=border cellspacing="0" id="stretch"  bgcolor="#DBEBFF">

<tr> <td colspan="5" align="Center" class="Blue-content">CODE List</td><tr> 
 <tr>
 <td colspan="3" ></td>
 <td align="right"><input type="submit" name="act" value="Update"></td>
 </tr>
<tr class="Blue-content"> <td>Access Token</td><td>Date Inserted</td> 
</tr>
<%	while(rs.next())
	{
%>
<tr class="content style1"> 
<td><%=rs.getString("access_token")%></td><td><%=rs.getString("date_inserted")%></td>
</tr>
<%	  DisRow++;	}
	
%>

<%} %>
 <tr>
 <td colspan="1" align="right"><input type="submit" name="act" value="Edit"></td>
</tr>
</table>
<%} 
%>
</form>
</body> 
</html>

