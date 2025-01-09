<%@ page language="java" import="java.sql.*"%>
<%
out.println(session.getAttribute("theRole"));

if(session.getAttribute("theRole")== null)
{
out.println("<script>parent.location.href='../index.html'</script>");

}
%>
