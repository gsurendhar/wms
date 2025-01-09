
<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" import="java.util.*"%>

<%
	response.setContentType("text/html");
try
	{
if(session.getAttribute("theRole") != null){
	session.removeAttribute("theRole");
}
if(session.getAttribute("theName") != null){
	session.removeAttribute("theName");
}
	}
catch(Exception ex)
	{
		out.println(ex);
	}


//session.invalidate(); 

response.sendRedirect("index.jsp");

%>
