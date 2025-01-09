<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="javax.servlet.*,java.text.*" %>

<%@ page import="java.util.*" %>
<%@page import="com.LoginDao"%>
<%@page import="com.LoginBean"%>


<%!
Integer Vmoduleid=0;
String Vroleid=null;
String query="";
int count;
%>
<%

if(null == session.getAttribute("theName")){  
  // User is not logged in.
  out.println("your Session has expired");
  response.sendRedirect("../index.jsp?invalid=0");
}

//out.println(session.getAttribute("theOid"));
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>WMS Administrator</title>
<link href="../styles/dropdowncss.css" type="text/css" rel="stylesheet"  />
<link href="../styles/text.css" rel="stylesheet" type="text/css">
<script src="../Script/dropdownjs.js" language="javascript" type="text/javascript"></script>

<style>
#menuwrapper, #p7menubar ul a {height: 1%;}
a:active {width: auto;}
</style>
</head>

<body onload="ExpMenu();">

<table width="100%" id="stretch"> 
<tr><td colspan="2" >
	<table width="50%" border="0" cellpadding="0" cellspacing="0" bgcolor="#7BE3F3"> 
			<!--<tr><td height="100%" align="left" valign="bottom" scope="col"> 
			<img src="../images/Logo.png" width="100" height="100" />-->
		</td><td align="middle" class="maintitle">
			Nalanda District Rainfall Distribution
		</td></tr>
	 <tr><td align="left" width="100%">
	<!-- <div data-include="../map/index.html"> </div>
	 
<div align="center"><a href="../map/index.html"></a></div>
	<iframe src="../map/index.html" align="middle" frameborder="1" width="1600" height="500" ></iframe> -->
	<a href="../Map_Nalanda/index.html"><img src="../images/Nalanda Rainfall Model map.png"  border="1" width="800" height="500" /> </a>
	
	
	 </td></tr>
	</table>
</td></tr>

</table>

</body>
</html>
