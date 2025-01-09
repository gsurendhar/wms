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

rs=stmt.executeQuery("select active_stations,reporting,(active_stations-reporting) as not_reporting from (select count(1) as Active_stations from station_configs_det where activate!=0) active ,(select count(distinct(clientid)) as Reporting from data_packets  where packet_date >= current_date - INTERVAL '12 Hours') Reporting");

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

<table width="100%" class=border border="0" cellpadding="0" cellspacing="0" id="stretch" >

<tr class="Blue-content" align="center">

<td>Station Statistics<br>(Last 12 Hours)</td>
<td>Reporting stations<br>(Last 12 Hours) %</td>

<td></td>
<td>&nbsp;</td></tr>
<tr>
<td>
	<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase=http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="200" height="375" id="Column3D" >
	<param name="movie" value="../../../FusionCharts/Charts/FCF_Pie3D.swf" />
	<param name="FlashVars" value="&dataURL=Data.xml&chartWidth=200&chartHeight=250">
	<param name="quality" value="high" />
	<embed src="../../../FusionCharts/Charts/FCF_Pie3D.swf" flashVars="&dataXML=<%=strXML%>&chartWidth=250&chartHeight=200" quality="high" width="250" height="250" name="stats" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
	</object>
	<table border="1" cellpadding="1" cellspacing="1" class="border">
	<tr><td><a href="stnlist.jsp?v1=t" target="_blank" class="Blue-content">Total</td><td class="content style1"><a href="stnlist.jsp?v1=t" target="_blank" class="Blue-content"><%=vTotal%></td> </tr>
	<tr><td><a href="stnlist.jsp?v1=w" target="_blank" class="Blue-content">Working</td><td class="content style1"><a href="stnlist.jsp?v1=w" target="_blank" class="Blue-content"><%=vWorking%></td> </tr>
	<tr><td><a href="stnlist.jsp?v1=n" target="_blank" class="Blue-content">Not Working</td><td class="content style1"><a href="stnlist.jsp?v1=n" target="_blank" class="Blue-content"><%=vFaulty%></td> </tr>
	</table>
</td>


<!--<td><iframe src="stationstatsper.jsp" height="300"  width="300" FRAMEBORDER="0"  scrolling="No"></iframe></td>  -->
<td><iframe src="stationstatsperbar.jsp" height="300"  width="300" FRAMEBORDER="0"  scrolling="No"></iframe></td>
<!-- <td><iframe src="recoverystats.jsp" height="300"  width="250" FRAMEBORDER="0" scrolling="No"></iframe></td> 
<td><iframe src="messagestats.jsp" height="350" width="350" FRAMEBORDER="0" scrolling="No"></iframe></td>
-->
<td><iframe src="alerts.jsp" height="300" width="600" FRAMEBORDER="0" scrolling="Yes "></iframe></td>

</tr>
</table>
<%
stmt.close();
rs.close();
%>
</BODY>
</HTML>
