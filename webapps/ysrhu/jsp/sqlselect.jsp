<%@ page language="java" %>
<%@ page language="java" import="com.ConnectionProvider" %> 
<%@ page import="java.io.*,java.sql.*,java.text.*"%>

<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
ResultSetMetaData md;
%>

<%

String query=request.getParameter("txtQuery");
if (query==null){query="";}
con = ConnectionProvider.getCon();
stmt=con.createStatement();
%>
<html>
<head>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
</head>
<body>
<form action="sqlselect.jsp" method="post" name="frmentry" >
<table width="100%" border="1" class=border cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
	<tr><td class="Headings" align="center" colspan="3">SQL Management</td></tr>
	<tr><td class="Blue-content">  Query</a></td>
	<!-- </tr>	<tr> -->
	<td><textarea name="txtQuery" class="content style1" cols="120" rows="5" align=center ><%=query%></textarea></td>
	<!-- </tr><tr> -->
	<td class="Blue-content"><input type="submit" name="go" value="Go"></td></tr>
</table>
<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" > 
<%
if (!"".equalsIgnoreCase(query)){
try
	{
		rs =stmt.executeQuery(query);
		md = rs.getMetaData();
		int count = md.getColumnCount();
		//out.println(count);

	%>
<tr class="Blue-content">
<%
for (int i=1; i<=count; i++) {
	out.print("<td>");
	out.print(md.getColumnName(i));
	out.print("</td>");
	}
out.println("</tr>");

while(rs.next()){
%>
<tr  class="readonly">
<%	for (int i=1; i<=count; i++) {
		out.print("<td>");
		out.print(rs.getString(i));
		out.print("</td>");
	}
	out.println("</tr>");
}


%>



<%
}
catch(Exception e)
{
	%>
<tr class="Blue-content" align="center">
<%
	out.println("<td>Exception: "+e+"</td></tr>");
}
	}
%>
</tr></table>
</form>
</body>
</html>
