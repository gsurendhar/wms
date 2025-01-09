
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com. ConnectionProvider" %> 
<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
String query="";
%>
<!-- Sesssion Management -->
<%if(null == session.getAttribute("theName")){  
  // User is not logged in.
  out.println("your Session has expired");
  response.sendRedirect("../index.html?invalid=0");
}
%>
<!-- End of Sesssion Management -->
<html>
<head>
<TITLE></TITLE>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
con =  ConnectionProvider.getCon();
stmt=con.createStatement();
%>
<table width="50%" border="0" class=border cellpadding="0" cellspacing="5" >
<tr><td class="Red-content" align="center" colspan="2">Messages Proccessing<br>(Last 12 hours)</td></tr>
<%
//rs=stmt.executeQuery("select 1 as sl,'Processed' as type,count(1) as messages  from ozekimessagein_backup where processed_date >=CURRENT_TIMESTAMP - INTERVAL '12 HOUR'  union select 2 as sl,'Pending' as type,count(1) as messages from ozekimessagein order by 1");
rs=stmt.executeQuery("select 2 as sl,'Pending' as type,count(1) as messages from ozekimessagein order by 1");
while(rs.next()){%>
<tr><td class="Blue-content"><%=rs.getString(2)%></td><td class="content style1"><%=rs.getString(3)%></td></tr>
<% } %>
<tr><td class="red-content" align="center" colspan="2">Top 5 Hottest Places<br>(Last 24 hours)</td></tr>
<% 
query="select x.clientid,location,round(cast(temp as decimal),2) as temp from (select clientid,max((case when temp >50 then 0 else temp end) ) as temp from data_packets where packet_date >=CURRENT_TIMESTAMP - INTERVAL '24 HOUR' and temp !=0 group by clientid order by temp desc) as x, station_configs_det as sc where x.clientid=sc.clientid LIMIT 5";

rs=stmt.executeQuery(query);
while(rs.next()){%>
<tr><td class="Blue-content"><%=rs.getString(1)%></td><td class="Blue-content"><%=rs.getString(2)%></td><td class="content style1"><%=rs.getString(3)%>&nbsp;&deg;C</td></tr>
<% } %>
<tr><td class="red-content" align="center" colspan="2">Top 5 Raining Places<br>(Last 24 hours)</td></tr>
<% 
query="select x.clientid,location,round(cast(rain as decimal),2) as rain from (select clientid,max(rain) as rain from data_packets where packet_date >=CURRENT_TIMESTAMP - INTERVAL '24 HOUR' and rain !=0 and packet_type='D' group by clientid order by rain desc) as x, station_configs_det as sc where x.clientid=sc.clientid LIMIT 5";

rs=stmt.executeQuery(query);
while(rs.next()){%>
<tr><td class="Blue-content"><%=rs.getString(1)%></td><td class="Blue-content"><%=rs.getString(2)%></td><td class="content style1"><%=rs.getString(3)%>&nbsp;mm</td></tr>
<% } %>

</table>
</body>
</html>