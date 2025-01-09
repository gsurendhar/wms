<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %> 

<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null; 

%>
<%
con = ConnectionProvider.getCon();
stmt=con.createStatement();

rs=stmt.executeQuery("select active_stations,reporting,(active_stations-reporting) as not_reporting  from (select count(1) as Active_stations from station_configs_det where activate!=0 and address not in('ARG')) active ,(select count(distinct(clientid)) as Reporting from data_packets as dp where packet_date >= CURRENT_TIMESTAMP - INTERVAL '12 Hours' and exists  (select 1 from station_configs_det as scd where activate!=0 and dp.clientid=scd.clientid and address not in('ARG')) ) Reporting");

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


String strXML ="<graph caption='Station Statistics' bgColor='F1f1f1' decimalPrecision='0' showPercentageValues='0' showNames='1' numberPrefix='' showValues='1' showPercentageInLabel='0' pieYScale='45' pieBorderAlpha='40' pieFillAlpha='70' pieSliceDepth='15' pieRadius='100'>";
strXML +="    <set value='"+vWorking+"' name='Reporting' color='FF9966'/>";
strXML +="    <set value='"+vFaulty+"' name='Faulty' color='FF0000'/>";
strXML +="</graph>";

%>

<%
con = ConnectionProvider.getCon();
stmt=con.createStatement();

rs=stmt.executeQuery("select active_stations,reporting,(active_stations-reporting) as not_reporting  from (select count(1) as Active_stations from station_configs_det where activate!=0 and clientid<10840 and address in('ARG')) active ,(select count(distinct(clientid)) as Reporting from data_packets as dp where packet_date >= CURRENT_TIMESTAMP - INTERVAL '12 Hours' and dp.clientid<10840 and exists  (select 1 from station_configs_det as scd where activate!=0 and dp.clientid=scd.clientid and address in('ARG')) ) Reporting");

Integer vTotal1=0;
Integer vWorking1=0;
Integer vFaulty1=0;
int DisRow1=0;
while(rs.next()){ 
	vTotal1= rs.getInt(1) ;
	vWorking1= rs.getInt(2) ;
	vFaulty1= rs.getInt(3) ;
	DisRow++;
	}


String strXML1 ="<graph caption='Station Statistics' bgColor='F1f1f1' decimalPrecision='0' showPercentageValues='0' showNames='1' numberPrefix='' showValues='1' showPercentageInLabel='0' pieYScale='45' pieBorderAlpha='40' pieFillAlpha='70' pieSliceDepth='15' pieRadius='100'>";
strXML1 +="    <set value='"+vWorking1+"' name='Reporting' color='FF9966'/>";
strXML1 +="    <set value='"+vFaulty1+"' name='Faulty' color='FF0000'/>";
strXML1 +="</graph>";

%>


<HTML>
<HEAD>
<TITLE> WMS Dash Board </TITLE>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
<script>
/* Auto Refresh Page with Time script*/

//enter refresh time in "minutes:seconds" Minutes should range from 0 to inifinity. Seconds should range from 0 to 59
var limit="2:00"

if (document.images){
var parselimit=limit.split(":")
parselimit=parselimit[0]*60+parselimit[1]*1
}
function beginrefresh(){
if (!document.images)
return
if (parselimit==1)
window.location.reload()
else{ 
parselimit-=1
curmin=Math.floor(parselimit/60)
cursec=parselimit%60
if (curmin!=0)
curtime=curmin+" minutes and "+cursec+" seconds left until page refresh!"
else
curtime=cursec+" seconds left until page refresh!"
window.status=curtime
setTimeout("beginrefresh()",1000)
}
}

window.onload=beginrefresh
</script>

</HEAD>

<BODY>

<!-- Sesssion Management -->
<%if(null == session.getAttribute("theName")){  
  // User is not logged in.
  out.println("your Session has expired");
  response.sendRedirect("../timeout.jsp");
}
%>
<!-- End of Sesssion Management -->

<table width="30%" height="30%" class=border border="0" cellpadding="0" cellspacing="0" id="stretch" >
<tr><td><a href="messagestats.jsp" target="_blank" class="Blue-content">Top 20 Hottest Places Last 24 hours</td></tr>
<tr><td><a href="messagestats_1.jsp" target="_blank" class="Blue-content">Top 20 Raining Places(Last 24 hors-up to 08.30 AM)</td></tr>
<tr><td><a href="messagestats_2.jsp" target="_blank" class="Blue-content">Top 20 Raining Places(updated from 08.30 AM)</td></tr>
</table>
<%
stmt.close();
rs.close();
%>
</BODY>
</HTML>
