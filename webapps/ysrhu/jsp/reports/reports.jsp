<%@ page language="java" %>
<%@ page language="java" import="com.ConnectionProvider" %> 
<%@ page import="java.io.*,java.sql.*,java.text.*"%>

<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
String query="";
ResultSetMetaData md;


%>
<%
con = ConnectionProvider.getCon();
stmt=con.createStatement();


rs = stmt.executeQuery("select param_id as sid,group_value as state from parameter where active='Y' and group_family='LOCATION' and Group_name='STATE'");



md = rs.getMetaData();
int count = md.getColumnCount();
out.println("<table border=1>");
out.print("<tr>");
for (int i=1; i<=count; i++) {
	out.print("<td>");
	out.print(md.getColumnName(i));
	out.print("</td>");
	}
out.println("</tr>");


while(rs.next()){
	out.print("<tr>");
	for (int i=1; i<=count; i++) {
		out.print("<td>");
		out.print(rs.getString(i));
		out.print("</td>");
	}
	out.println("</tr>");
}


out.println("</tr>");
out.println("</table>");


%>

