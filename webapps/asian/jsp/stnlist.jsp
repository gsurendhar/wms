
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %> 
<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;

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
<TITLE> Station Statistics </TITLE>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
con = ConnectionProvider.getCon();
stmt=con.createStatement();
String value1=request.getParameter("v1");
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" id="stretch"> 
<tr height="100%" valign="center"> 
<td colspan="2" valign="center" height="100%">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF"> 
		<tr><td height="100%" align="left" valign="bottom" scope="col">
		<!-- <a href="#"> -->
		<img src="../images/Logo.jpg" width="100" height="50">
		<!-- </a> -->
		</td></tr>
		<tr><td background="../images/Logo_bottom.jpg" scope="col"><img src="../images/Logo_bottom.jpg" width="3" height="4"></td></tr>
	</table>
</td>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="5" id="stretch" >


<tr><td></td></tr>

<%

if(value1.equalsIgnoreCase("t")) {
rs=stmt.executeQuery("select a.clientid,(select group_value from parameter where param_id=a.state) as state,(select group_value from parameter where param_id=a.district) as district,coalesce((select group_value from parameter where param_id=a.county),null,'N/A') as county, a.location,a.longitude,a.latitude, coalesce(to_char((last_reported),'MM/DD/YYYY HH24:MI'),null,'-') as packet_date from station_configs_det as a where activate!=0 ORDER BY district,county");
%>
<tr><td class="Blue-content" align="center" colspan="2">All Stations List</td></tr>
<%
}
if(value1.equalsIgnoreCase("w")) {
rs=stmt.executeQuery("select a.clientid,(select group_value from parameter where param_id=a.state) as state,(select group_value from parameter where param_id=a.district) as district,coalesce((select group_value from parameter where param_id=a.county),null,'N/A') as county,a.location,a.longitude,a.latitude,coalesce(to_char((last_reported),'MM/DD/YYYY HH24:MI'),null,'-') as packet_date from station_configs_det as a where activate!=0 and a.clientid  in (select distinct clientid from data_packets where packet_date >= CURRENT_TIMESTAMP - INTERVAL '12 HOUR') and clientid!=15000  order by district,county");
%>
<tr><td class="Blue-content" align="center" colspan="2">Working Stations List</td></tr>
<%
}
if(value1.equalsIgnoreCase("n")) {
rs=stmt.executeQuery("select a.clientid,(select group_value from parameter where param_id=a.state) as state,(select group_value from parameter where param_id=a.district) as district, coalesce((select group_value from parameter where param_id=a.county),null,'N/A') as county,a.location,a.longitude,a.latitude, coalesce(to_char((last_reported),'MM/DD/YYYY HH24:MI'),null,'-') as packet_date from station_configs_det as a where activate!=0 and a.clientid not in (select distinct clientid from data_packets where packet_date >= CURRENT_TIMESTAMP - INTERVAL '12 HOUR'and clientid!=15000) order by district,county,packet_date");
%>
<tr><td class="Blue-content" align="center" colspan="2">Not Working Stations List</td></tr>
<%
}
%>

<table width="90%" class="border" border="0" cellpadding="0" cellspacing="5" id="stretch" >
<tr><td class="Blue-content">clientid</td><td class="Blue-content">State</td><td class="Blue-content">District</td>
<td class="Blue-content">Block</td><td class="Blue-content">Location</td><td class="Blue-content">Longitude</td>
<td class="Blue-content">Latitude</td><td class="Blue-content">Data Last Received<br>(mm/dd/yyyy hh24:mi)</td>
</tr>
<%
while(rs.next()){ %>
<tr>
<td class="readonly"><%=rs.getString(1)%></td><td class="readonly"><%=rs.getString(2)%></td><td class="readonly"><%=rs.getString(3)%></td>
<td class="readonly"><%=rs.getString(4)%></td><td class="readonly"><%=rs.getString(5)%></td><td class="readonly"><%=rs.getString(6)%></td>
<td class="readonly"><%=rs.getString(7)%></td><td class="readonly"><%=rs.getString(8)%></td>
</tr>
<%
}
rs.close();
%>
</table>
</table>
</body>
</html>
