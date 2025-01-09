<%@ page language="java" import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %>
<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
String query=null;
%>
<%

String vlid= request.getParameter("lid");
String vsid= request.getParameter("sid");

if (vlid==null){vlid="0";}

%>
<head>
<TITLE> HTTP message</TITLE>
<link href="styles/text.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
con = ConnectionProvider.getCon();
stmt=con.createStatement();
query="select msg,substr(receivedtime,1,19) as receivedtime,operator,id from (select * from ozekimessagein where id > "+vlid+" and msg like '%"+vsid+"%' order by id )  as t ";
//out.println(query);
rs=stmt.executeQuery(query);
while(rs.next()) {
	out.println(rs.getString("id")+";"+rs.getString("msg")+";"+rs.getString("receivedtime")+";");
}
%>
</table>
</body>
</html>
