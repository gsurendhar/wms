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
if (vlid==null){vlid="0";}
String vsearch= request.getParameter("vsearch");
if (vsearch==null){vsearch= "";}

%>
<head>
<TITLE> HTTP message</TITLE>
<link href="styles/text.css" rel="stylesheet" type="text/css">
<script>
function parameter(){
// var vrule=document.getElementById("cmbLimit").value
var vsearch=document.getElementById("txtSearch").value
//window.location.replace("messages.jsp?vsearch="+vsearch+"vlimit="+vlimit);
window.location.replace("messages.jsp?vsearch="+vsearch);
}
</script>
</head>
<body>
<%
con = ConnectionProvider.getCon();
stmt=con.createStatement();
query="select msg,substr(receivedtime,1,19) as receivedtime,operator,id from (select * from ozekimessagein where sender='http' and id > "+vlid+" order by receivedtime desc)  as t ";
if ("".equalsIgnoreCase("vsearch")){query +=" limit 100 " ;}
	else { query +=" where msg like '%"+vsearch+"%' limit 200";}

	

rs=stmt.executeQuery(query);
%>
<tr class="Blue-content" align="right">
<td><b>Search:</b><input type=text id=txtSearch name=txtSearch  class="content style1" value="<%=vsearch%>" size="20">
<input class="content style1"  type="submit" value="Go" onClick="parameter()">
</td></tr>

<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" >

<tr class="Headings"><td>Received Time</td><td>Operator</td><td>Message</td><td>UniqueID</td></tr>
<%
	while(rs.next()) {%>
<tr  class="content style1"><td><%=rs.getString(2)%></td><td><%=rs.getString(3)%></td><td><%=rs.getString(1)%></td><td><%=rs.getString(4)%></td></tr>
<%   	}
%>
</table>
</body>
</html>
