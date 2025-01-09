<%@ page language="java" import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %>
<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
%>

<%
String vmsg=request.getParameter("name");
%>
<head>
<TITLE> HTTP message</TITLE>
<link href="styles/text.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
con = ConnectionProvider.getCon();
stmt=con.createStatement();
%>
<table width="100%" border="0" cellpadding="0" cellspacing="5" id="stretch" >
<tr>
<td  class="content style1"><% out.println(vmsg); %></td>
</tr>


<%
   stmt.executeUpdate("insert into ozekimessagein(msg,sender,operator,msgtype,senttime,receivedtime) values('"+vmsg+"','http','http','http.text',localtimestamp,localtimestamp)");
%>

</table>
</body>
</html>
