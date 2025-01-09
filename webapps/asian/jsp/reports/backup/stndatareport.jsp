<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="wms.dbconnect.DBPostgres" %> 
<%@ page import="java.text.*" %>


<%@ page import="java.io.*" %>  
<%@ page import="org.jfree.chart.JFreeChart" %>  
<%@ page import="org.jfree.chart.ChartUtilities" %>  

<%@ page  import="java.awt.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import ="org.jfree.data.general.*"%>
<%@ page  import="org.jfree.data.category.*"%>

<%@ page  import ="org.jfree.chart.ChartFactory" %>
<%@ page  import ="org.jfree.chart.ChartPanel" %>
<%@ page  import ="org.jfree.chart.axis.NumberAxis" %>
<%@ page  import ="org.jfree.chart.plot.PlotOrientation" %>

<%@ page  import ="org.jfree.ui.ApplicationFrame" %>
<%@ page  import ="org.jfree.ui.RefineryUtilities" %>


<%@ page  import ="org.jfree.chart.plot.XYPlot" %>
<%@ page  import ="org.jfree.chart.renderer.xy.XYLineAndShapeRenderer" %>
<%@ page  import ="org.jfree.data.xy.XYDataset" %>
<%@ page  import ="org.jfree.data.xy.XYSeries" %>
<%@ page  import ="org.jfree.data.xy.XYSeriesCollection" %>
<%@ page  import ="org.jfree.data.time.TimeSeries" %>
<%@ page  import ="org.jfree.data.time.Month" %>



<script>
function parameter(){
var vid1 = document.getElementById("state").value
		if (vid1==null || vid1==""){vid1=0;}
var vid2 = document.getElementById("district").value
		if (vid2==null || vid2==""){vid2=0;}
var vid3 = document.getElementById("county").value
		if (vid3==null || vid3==""){vid3=0;}
var vid4 = document.getElementById("location").value
		if (vid4==null || vid4==""){vid4=0;}
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
var vparam= document.getElementById("param").value
window.location.replace("/wms/jsp/reports/stndatareport.jsp?value1="+vid1+"&&value2="+vid2+"&&value3="+vid3+"&&value4="+vid4+"&&vfdate="+vfdate+"&&vtdate="+vtdate+"&&param="+vparam);
}


function search(){
var vid1 = document.getElementById("txtSearch").value
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
var vparam= document.getElementById("param").value
window.location.replace("stndatareport.jsp?search="+vid1+"&&vfdate="+vfdate+"&&vtdate="+vtdate+"&&param="+vparam);
}


</script>



<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
String query="";
%>
<%
String value1=request.getParameter("value1");
String value2=request.getParameter("value2");
String value3=request.getParameter("value3");
String value4=request.getParameter("value4");
String search=request.getParameter("search");

if (search!=null){
query="select clientid,state,district,county,location from station_configs_det where clientid='"+search+"'";	
	rs=stmt.executeQuery(query);
	while(rs.next()){
		value1=rs.getString("state");
		value2=rs.getString("district");
		value3=rs.getString("county");
		value4=rs.getString("clientid");
	}
}


if (value1==null){value1="0";}
if (value2==null){value2="0";}
if (value3==null){value3="0";}
if (value4==null){value4="0";}
if (search==null){search="0";}

String vfdate=request.getParameter("vfdate");
String vtdate=request.getParameter("vtdate");
String vparam=request.getParameter("param");

DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());
//out.println(formattedDate);

if(vfdate == null){ 
 vfdate=formattedDate;
 vtdate=formattedDate;
}

con = DBPostgres.getConnection();
stmt=con.createStatement();
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reports</title>

<script type="text/javascript" src="../../Script/tabber.js"></script>
<link rel="stylesheet" href="../../tabber/example.css" TYPE="text/css" MEDIA="screen">
<link rel="stylesheet" href="../../tabber/example-print.css" TYPE="text/css" MEDIA="print">
<link href="../../styles/text.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../Script/datepicker.js"></script>

</head>
<body>

<h1 class="Headings">Readings by Date</h1>


<div class="tabber">

     <div class="tabbertab">
	  <h2>Data</h2>
	  

<table width="100%" border="1" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
<tr><td width="10%" VALIGN=TOP>
<table width="10%" border="1" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
<!--   date selection starts here -->

<tr><td class="Blue-content" colspan="4"><b>Select Date Range</b></td></tr>
<tr><td class="content style1" align="right"><b>From</b></td>
<td><input id="fdate"  class="content style1" type="text" name="fdate" size="10" maxlength="12" value=<%=vfdate%>>
<a href="javascript:NewCal('fdate','ddmmyyyy',false)"><img src="../../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a></td>
</tr>
<tr><td class="content style1" align="right"><b>To</b></td>
<td><input id="tdate"  class="content style1" type="text" name="tdate" size="10" maxlength="12" value=<%=vtdate%>>
<a href="javascript:NewCal('tdate','ddmmyyyy',false)"><img src="../../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a></td>
</tr>

 <!-- date selection Ends here -->
<!--sensor selection -->
<tr><td class="Blue-content" colspan="6" align="left">Sensor
<select id="param" onchange="parameter()" class="content style1">
<option value="All">All</option>
<option value="Rain">Rain</option>
<option value="Temparature">Temparature</option>
<option value="Wind">Wind</option>
<option value="Humidity">Humidity</option>
<option value="LocalPressure">LocalPressure</option>
<option value="MSLP">MSLP</option>
<option value=<%=vparam%> selected disabled><%=vparam%></option> 
</select> </td></tr>

<!--sensor selection -->
<tr><td class="content style1"> StationID </td>
<td><input type=text name=txtSearch  class="content style1" value="<%=search%>" size="5">
<input class="content style1" type="submit" value="Search" onClick="search()"></td>

<tr><td class="Blue-content" colspan="6" align="left">Select Station</td></tr>
<% rs = stmt.executeQuery("select param_id as sid,group_value as state from parameter where active='Y' and group_family='LOCATION' and Group_name='STATE'"); %>
<tr><td class="content style1"><b> State </b></td>
<td>
<select id="state" onchange="parameter()" class="content style1">
<option value="0">--Please Select--</option>
<% while(rs.next()){ %>
<option value="<%=rs.getInt("sid")%>"><%=rs.getString("state")%></option>

<% if(rs.getString("sid").equals(value1)){%>
<option value="<%=value1%>" selected disabled><%=rs.getString("state")%></option> 
<%
}

}
%>
</select> </td></tr>
<tr><td class="content style1"><b> District</b> </td><td>
<select id="district" onchange="parameter()" class="content style1">
<option value="0">--Please Select--</option>
<%
rs=stmt.executeQuery("select param_id as did,group_value as district from parameter where active='Y' and group_family='LOCATION' and Group_name='DISTRICT' and parent_group='"+value1+"'");

while(rs.next()){
%>
<option value="<%=rs.getInt("did")%>" ><%=rs.getString("district")%></option>
<% if(rs.getString("did").equals(value2)){%>
<option value="<%=value2%>" selected disabled><%=rs.getString("district")%></option>
<%
}
}
%>
</select>
</td></tr>

<tr><td class="content style1"><b> Mandal</b> </td><td>
<select id="county" onchange="parameter()" class="content style1">
<option value="0">--Please Select--</option>
<%
rs=stmt.executeQuery("select param_id as cid,group_value as county from parameter where group_family='LOCATION' and Group_name='COUNTY' and parent_group='"+value2+"'");
while(rs.next()){
%>
<option value="<%=rs.getInt("cid")%>" ><%=rs.getString("county")%></option>
<% if(rs.getString("cid").equals(value3)){%>
<option value="<%=value3%>" selected disabled><%=rs.getString("county")%></option>
<%
}
}
%>
</select>
</td> </tr>
<%
query="select * from station_configs_det ";

if(value3.equalsIgnoreCase("0")) 
{
	query=query+" where state="+value1+" and district="+value2;
}
else{
	query=query+" where state="+value1+" and district="+value2+" and county="+value3;
					}
rs=stmt.executeQuery(query);
%>
<tr><td class="content style1"><b> Stations</b> </td>
<td class="content style1" align="left"  >
<select id="location" onchange="parameter()" class="content style1" size="20">
<option value="0">--Please Select--</option>
<%

while(rs.next()){
%>
<option value="<%=rs.getInt("clientid")%>" ><%=rs.getString("location")%></option>
<% if(rs.getString("clientid").equals(value4)){%>
<option value="<%=value4%>" selected disabled><%=rs.getString("location")%></option>
<%
}
}
%>
</select>
</td></tr>
</table>
</td>
<td valign=top>
<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" > 
<!--v<tr><td class="Blue-content" colspan="6" align="center">Data View</td></tr> -->
<tr><td class="Blue-content">Date & Time</td>
<% 	if ("All".equalsIgnoreCase(vparam) ) { %>
<td class="Blue-content">Rain ( mm)</td><td class="Blue-content">Temparature(&ordm; C)</td>
<td class="Blue-content">Wind&nbsp;Speed<br/>(&nbsp;kmph&nbsp;)</td></td>
<td class="Blue-content">Wind<br> Direction<br/>(&nbsp;&deg;from&nbsp;north&nbsp;)</td><td class="Blue-content">Humidity<br/>(&nbsp;&permil;&nbsp;)</td><td class="Blue-content">Local Pressure<br>(&nbsp;milibar&nbsp;)</td><td class="Blue-content">MSLP <br>(&nbsp;milibar&nbsp;)</td></tr>
<%} else if ("Rain".equalsIgnoreCase(vparam) ) { %>
	<td class="Blue-content">Rain ( mm)</td></tr>
<%} else if ("Temparature".equalsIgnoreCase(vparam) ) { %>
	<td class="Blue-content">Temparature(&ordm; C)</td></tr>
<%} else if ("Wind".equalsIgnoreCase(vparam) ) { %>
	<td class="Blue-content">Wind Speed<br/>(&nbsp;kmph&nbsp;)</td><td class="Blue-content">Wind<br>Direction<br/>(&nbsp;&deg;from&nbsp;north&nbsp;)</td></tr>
<%} else if ("Humidity".equalsIgnoreCase(vparam) ) { %>
	<td class="Blue-content">Humidity<br/>(&nbsp;&permil;&nbsp;)</td></tr>
<%} else if ("LocalPressure".equalsIgnoreCase(vparam) ) { %>
	<td class="Blue-content">Local Pressure<br>(&nbsp;milibar&nbsp;)</td></tr>
<%} else if ("MSLP".equalsIgnoreCase(vparam) ) { %>
<td class="Blue-content">Mean Sea-level Pressure<br>(&nbsp;milibar&nbsp;)</td></tr>
<%}%>
<%
	query="select to_char(packet_date,'DD/MM/YY HH24:MI') as date,rain,temp,wind,wind_direction,mslp,humidity,local_pressure from data_packets as a where clientid="+value4+" and packet_type='D' and packet_date between to_date('"+vfdate+"','dd/mm/yyyy') and to_date('"+vtdate+"','dd/mm/yyyy')+ INTERVAL '1 DAY' order by packet_date";
	//System.out.println(query);
	rs=stmt.executeQuery(query);
	while(rs.next()){
%>
<tr><td class="readonly"><%=rs.getString(1)%></td>
<% 	if ("All".equalsIgnoreCase(vparam) ) { %>
<!-- <td class="readonly"><%=rs.getDouble("rain")%></td>
<td class="readonly"><%=rs.getDouble("temp")%></td>
<td class="readonly"><%=rs.getDouble("wind")%></td><td class="readonly"><%=rs.getDouble("wind_direction")%></td>
<td class="readonly"><%=rs.getDouble("humidity")%></td>
<td class="readonly"><%=rs.getDouble("local_pressure")%></td>
<td class="readonly"><%=rs.getDouble("mslp")%></td> -->

<% if (rs.getString("rain")==null){ %><td class="readonly">N/A</td><%} else {%><td class="readonly"><%=rs.getDouble("rain")%></td><%}%>
		<% if (rs.getString("temp")==null){ %><td class="readonly">N/A</td><%} else {%><td class="readonly"> <%=rs.getDouble("temp")%></td><%}%>
		<% if (rs.getString("wind")==null){ %><td class="readonly">N/A</td><%} else {%><td class="readonly"> <%=rs.getDouble("wind")%></td><%}%>
		<% if (rs.getString("wind_direction")==null){ %><td class="readonly">N/A</td><%} else {%><td class="readonly"> <%=rs.getDouble("wind_direction")%></td><%}%>
		<% if (rs.getString("humidity")==null){ %><td class="readonly" >N/A</td><%} else {%><td class="readonly"> <%=rs.getDouble("humidity")%></td><%}%>
		<% if (rs.getString("local_pressure")==null){ %><td class="readonly">N/A</td><%} else {%><td class="readonly"> <%=rs.getDouble("local_pressure")%></td><%}%>
		<% if (rs.getString("mslp")==null){ %><td class="readonly">N/A</td><%} else {%><td class="readonly"> <%=rs.getDouble("mslp")%></td><%}%>

</tr>

<%} else if ("Rain".equalsIgnoreCase(vparam) ) { %>
		<% if (rs.getString("rain")==null){ %><td class="readonly">N/A</td><%} else {%><td class="readonly"><%=rs.getDouble("rain")%></td><%}%></tr>
<%} else if ("Temparature".equalsIgnoreCase(vparam) ) { %>
	<% if (rs.getString("temp")==null){ %><td class="readonly">N/A</td><%} else {%><td class="readonly"> <%=rs.getDouble("temp")%></td><%}%></tr>
<%} else if ("Wind".equalsIgnoreCase(vparam) ) { %>
	<% if (rs.getString("wind")==null){ %><td class="readonly">N/A</td><%} else {%><td class="readonly"> <%=rs.getDouble("wind")%></td><%}%>
	<% if (rs.getString("wind_direction")==null){ %><td class="readonly">N/A</td><%} else {%><td class="readonly"> <%=rs.getDouble("wind_direction")%></td><%}%>
	</tr>
<%} else if ("Humidity".equalsIgnoreCase(vparam) ) { %>
	<% if (rs.getString("humidity")==null){ %><td class="readonly">N/A</td><%} else {%><td class="readonly"> <%=rs.getDouble("humidity")%></td><%}%></tr>
<%} else if ("LocalPressure".equalsIgnoreCase(vparam) ) { %>
	<% if (rs.getString("local_pressure")==null){ %><td class="readonly">N/A</td><%} else {%><td class="readonly"> <%=rs.getDouble("local_pressure")%></td><%}%></tr>
<%} else if ("MSLP".equalsIgnoreCase(vparam) ) { %>
	<% if (rs.getString("mslp")==null){ %><td class="readonly" >N/A</td><%} else {%><td class="readonly"> <%=rs.getDouble("mslp")%></td><%}%></tr>
<%}%>




<%
}
%>



</table>



	</table>
</td></tr>
</table>

     </div>


     <div class="tabbertab">
	  <h2>Graphs</h2>
	  
<% rs = stmt.executeQuery("select param_id as sid,group_value as state from parameter where active='Y' and group_family='LOCATION' and Group_name='STATE'"); %>
<table width="100%" border="1" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
<tr><td width="10%" VALIGN=TOP>
<table width="10%" border="1" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
<!--   date selection starts here -->

<tr><td class="Blue-content" colspan="4"><b>Select Date Range</b></td></tr>
<tr><td class="content style1" align="right"><b>From</b></td>
<td><input id="fdate"  class="content style1" type="text" name="fdate" size="10" maxlength="12" value=<%=vfdate%>>
<a href="javascript:NewCal('fdate','ddmmyyyy',false)"><img src="../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a></td>
</tr>
<tr><td class="content style1" align="right"><b>To</b></td>
<td><input id="tdate"  class="content style1" type="text" name="tdate" size="10" maxlength="12" value=<%=vtdate%>>
<a href="javascript:NewCal('tdate','ddmmyyyy',false)"><img src="../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a></td>
</tr>

 <!-- date selection Ends here -->
<!--sensor selection -->
<tr><td class="Blue-content" colspan="6" align="left">Select Parameter</td></tr>
<tr><td></td><td>
<select id="param" onchange="parameter()" class="content style1">
<option value="All">All</option>
<option value="Rain">Rain</option>
<option value="Temparature">Temparature</option>
<option value="Wind">Wind</option>
<option value="Humidity">Humidity</option>
<option value="LocalPressure">LocalPressure</option>
<option value="MSLP">MSLP</option>
<option value=<%=vparam%> selected disabled><%=vparam%></option> 
</select> </td></tr>

<!--sensor selection -->

<tr><td class="Blue-content" colspan="6" align="left">Select Station</td></tr>
<tr><td class="content style1"><b> State </b></td>
<td>
<select id="state" onchange="parameter()" class="content style1">
<option value="0">--Please Select--</option>
<% while(rs.next()){ %>
<option value="<%=rs.getInt("sid")%>"><%=rs.getString("state")%></option>

<% if(rs.getString("sid").equals(value1)){%>
<option value="<%=value1%>" selected disabled><%=rs.getString("state")%></option> 
<%
}

}
%>
</select> </td></tr>
<tr><td class="content style1"><b> District</b> </td><td>
<select id="district" onchange="parameter()" class="content style1">
<option value="0">--Please Select--</option>
<%
rs=stmt.executeQuery("select param_id as did,group_value as district from parameter where active='Y' and group_family='LOCATION' and Group_name='DISTRICT' and parent_group='"+value1+"'");

while(rs.next()){
%>
<option value="<%=rs.getInt("did")%>" ><%=rs.getString("district")%></option>
<% if(rs.getString("did").equals(value2)){%>
<option value="<%=value2%>" selected disabled><%=rs.getString("district")%></option>
<%
}
}
%>
</select>
</td></tr>

<tr><td class="content style1"><b> Mandal</b> </td><td>
<select id="county" onchange="parameter()" class="content style1">
<option value="0">--Please Select--</option>
<%
rs=stmt.executeQuery("select param_id as cid,group_value as county from parameter where group_family='LOCATION' and Group_name='COUNTY' and parent_group='"+value2+"'");
while(rs.next()){
%>
<option value="<%=rs.getInt("cid")%>" ><%=rs.getString("county")%></option>
<% if(rs.getString("cid").equals(value3)){%>
<option value="<%=value3%>" selected disabled><%=rs.getString("county")%></option>
<%
}
}
%>
</select>
</td> </tr>
<%
query="select * from station_configs_det ";

if(value3.equalsIgnoreCase("0")) 
{
	query=query+" where state="+value1+" and district="+value2;
}
else{
	query=query+" where state="+value1+" and district="+value2+" and county="+value3;
					}
rs=stmt.executeQuery(query);
%>
<tr><td class="content style1"><b> Stations</b> </td>
<td class="content style1" align="left"  >
<select id="location" onchange="parameter()" class="content style1" size="20">
<option value="0">--Please Select--</option>
<%

while(rs.next()){
%>
<option value="<%=rs.getInt("clientid")%>" ><%=rs.getString("location")%></option>
<% if(rs.getString("clientid").equals(value4)){%>
<option value="<%=value4%>" selected disabled><%=rs.getString("location")%></option>
<%
}
}
%>
</select>
</td></tr>
</table>
</td>
<td valign=top>
<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" > 

<%

query="select to_char(packet_date,'HH24') as date,rain,temp,wind,wind_direction,mslp,humidity,local_pressure from data_packets as a where clientid="+value4+" and packet_type='D' and packet_date between to_date('"+vfdate+"','dd/mm/yyyy') and to_date('"+vtdate+"','dd/mm/yyyy')+ INTERVAL '1 DAY' order by packet_date";
	//System.out.println(query);
	rs=stmt.executeQuery(query);

/* code for line chart */
 File image = File.createTempFile("image", "tmp");
final DefaultCategoryDataset dataset = new DefaultCategoryDataset();

	while(rs.next()){
		if ("Rain".equalsIgnoreCase(vparam) ) { dataset.addValue(rs.getDouble("rain"),"Rain",rs.getString("date"));}
	    else if ("Temparature".equalsIgnoreCase(vparam) ) {dataset.addValue(rs.getDouble("temp"),"Temp",rs.getString("date"));}
	    else if ("Wind".equalsIgnoreCase(vparam) ){dataset.addValue(rs.getDouble("wind"),"Wind",rs.getString("date"));}
		else if ("Humidity".equalsIgnoreCase(vparam) ){dataset.addValue(rs.getDouble("humidity"),"Humidity",rs.getString("date"));}
		else if ("LocalPressure".equalsIgnoreCase(vparam) ){dataset.addValue(rs.getDouble("local_pressure"),"Pressure",rs.getString("date"));}
		else if ("MSLP".equalsIgnoreCase(vparam) ){dataset.addValue(rs.getDouble("mslp"),"Temp",rs.getString("date"));}
		else if ("All".equalsIgnoreCase(vparam) ){
			dataset.addValue(rs.getDouble("temp"),"Temp",rs.getString("date"));
			dataset.addValue(rs.getDouble("rain"),"Rain",rs.getString("date"));
			dataset.addValue(rs.getDouble("wind"),"Wind",rs.getString("date"));
			dataset.addValue(rs.getDouble("humidity"),"Humidity",rs.getString("date"));
			dataset.addValue(rs.getDouble("local_pressure"),"Pressure",rs.getString("date"));
			dataset.addValue(rs.getDouble("mslp"),"Temp",rs.getString("date"));

		}
	}

		

JFreeChart chart = ChartFactory.createLineChart(vparam+" Chart", "Time(Hrs)", "Readings", dataset, PlotOrientation.VERTICAL,true, true, true);

ChartUtilities.saveChartAsJPEG(new File("C:\\Program Files\\Apache Software Foundation\\Tomcat 6.0\\webapps\\wms\\jsp\\chart.jpg"), chart, 900, 500);


%> 

<!-- <tr><td><img src="chart.jpg"></td></tr> -->
<img src="chart.jpg" id="reloader" onload="setTimeout('document.getElementById(\'reloader\').src=\'chart.jpg?\'+new Date().getMilliseconds()', 5000)" />
</table>



	</table>
</td></tr>
</table>

     </div>

<!--     <div class="tabbertab">
	  <h2>Tab 3</h2>
	  <p>Tab 3 content.</p>
     </div> -->

</div>

</body>
</html>
