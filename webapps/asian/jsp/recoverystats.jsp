
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %> 
<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
%>

<html>
<head>
<TITLE> Station Statistics </TITLE>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
con = ConnectionProvider.getCon();
stmt=con.createStatement();
%>
<table width="100%" border="0" cellpadding="0" cellspacing="5" id="stretch" >
<tr><td class="Blue-content" align="center" colspan="2">Recovery Statistics </td></tr>
<!--<tr><td class="red-content" align="center" colspan="2">(Last 12 hours)</td></tr> -->
<tr><td></td></tr>
<tr><td></td></tr><tr><td></td></tr>

<%
rs=stmt.executeQuery("select 1 as sl,'Active' as type,count(1) as stations from station_configs_det union select 2 as sl,'Reporting' as type,count(distinct(clientid)) as stations from data_packets where packet_date >= CURRENT_TIMESTAMP - INTERVAL '12 HOUR'  order by 1");

//rs=stmt.executeQuery("select count(1) as unprocessed from ozekimessagein");
while(rs.next()){%>
<tr><td><a href=# class="Blue-content"><%=rs.getString(2)%></td><td class="content style1"><a href="stations.jsp?v1="<%=rs.getString(2)%> class="Blue-content"><%=rs.getString(3)%></td> </tr>
<%
}%>
</table>
</body>
</html>
