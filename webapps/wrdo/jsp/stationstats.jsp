
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

%>
<table width="100%" border="0" cellpadding="0" cellspacing="5" id="stretch" >
<!-- <tr><td class="Blue-content" align="center" colspan="2">Station Statistics </td></tr>
<tr><td class="red-content" align="center" colspan="2">(Last 12 hours)</td></tr>
<tr><td></td></tr> -->

<%

rs=stmt.executeQuery("select active_stations,reporting,(active_stations-reporting) as not_reporting from(select count(1) as Active_stations,(select count(distinct(clientid)) as stations from data_packets  where packet_date >= CURRENT_TIMESTAMP - INTERVAL '12 HOUR' and clientid!=15000 ) as Reporting  from station_configs_det where activate!=0 ) as st");
Integer vTotal=0;
Integer vWorking=0;
Integer vFaulty=0;
int DisRow=0;
while(rs.next()){ 
	vTotal= rs.getInt(1) ;
	vWorking= rs.getInt(2) ;
	vFaulty= rs.getInt(3) ;
	DisRow++;
	}
	%>
<tr><td>
<img src="getChart.jsp?v1=<%=vWorking%>&&v2=<%=vFaulty%>&&d1=Good&&d2=faulty" alt="Progress chart" />
</td></tr>
<tr><td><a href="stnlist.jsp?v1=t" target="_blank" class="Blue-content">Total</td><td class="content style1"><a href="stnlist.jsp?v1=t" target="_blank" class="Blue-content"><%=vTotal%></td> </tr>
<tr><td><a href="stnlist.jsp?v1=w" target="_blank" class="Blue-content">Working</td><td class="content style1"><a href="stnlist.jsp?v1=w" target="_blank" class="Blue-content"><%=vWorking%></td> </tr>
<tr><td><a href="stnlist.jsp?v1=n" target="_blank" class="Blue-content">Not Working</td><td class="content style1"><a href="stnlist.jsp?v1=n" target="_blank" class="Blue-content"><%=vFaulty%></td> </tr>
<!--
<tr><td class="Blue-content" align="center" colspan="2">Active Sensor Problems </td></tr>
<%
rs=stmt.executeQuery("select count(distinct(case when rain is null then clientid  end)) as rain_sensors,count(distinct(case when temp is null then clientid end)) as temp_sensors,count(distinct(case when wind is null then clientid else 0 end)) as wind_sensors,count(distinct(case when local_pressure is null then clientid else 0 end)) as pressure_sensors  from data_packets where packet_type='D'and packet_date >= CURRENT_TIMESTAMP - INTERVAL '12 HOUR'");

//rs=stmt.executeQuery("select count(1) as unprocessed from ozekimessagein");
while(rs.next()){%>
<tr><td><a href=# class="Blue-content">Rain Sensors</td><td class="content style1"><a href="sensors.jsp?v1=R"  target="_blank" class="Blue-content"><%=rs.getString(1)%></td> </tr>
<tr><td><a href=# class="Blue-content">Temp Sensors</td><td class="content style1"><a href="sensors.jsp?v1=T" target="_blank"  class="Blue-content"><%=rs.getString(2)%></td> </tr>
<tr><td><a href=# class="Blue-content">Wind Sensors</td><td class="content style1"><a href="sensors.jsp?v1=W"  target="_blank" class="Blue-content"><%=rs.getString(3)%></td> </tr>
<tr><td><a href=# class="Blue-content">Pressure Sensors</td><td class="content style1"><a href="sensors.jsp?v1=P"  target="_blank" class="Blue-content" target="new"><%=rs.getString(4)%></td> </tr> -->
<%
	}
%>


</table>
</body>
</html>