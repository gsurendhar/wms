<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %> 
<%@ page import="java.text.*" %>

<script>

function params(){
var vid1 = document.getElementById("state").value
var vid2 =document.getElementById("district").value
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
window.location.replace("/wms/jsp/reports/dsummary.jsp?value1="+vid1+"&&value2="+vid2+"&&vfdate="+vfdate+"&&vtdate="+vtdate);
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
String vfdate=request.getParameter("vfdate");
String vtdate=request.getParameter("vtdate");
String vparam=request.getParameter("param");

if (value1==null){value1="0";}
if (value2==null){value2="0";}



DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());

if(vfdate == null){ 
 vfdate=formattedDate;
 vtdate=formattedDate;
}

con = ConnectionProvider.getCon();
stmt=con.createStatement();
rs = stmt.executeQuery("select param_id as sid,group_value as state from parameter where active='Y' and group_family='LOCATION' and Group_name='STATE'");
%>
<html>
<head>
<link href="../../styles/text.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../Script/datepicker.js"></script>
</head>
<body>

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


<tr><td class="Blue-content" colspan="6" align="left">Select Station</td></tr>
<tr><td class="content style1"><b> State </b></td>
<td>
<select id="state" onchange="params()" class="content style1">
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
<select id="district" onchange="params()" class="content style1">
<option value="0">--Please Select--</option>
<option value="-1">All</option>

<%
rs=stmt.executeQuery("select param_id as did,group_value as district from parameter where active='Y' and group_family='LOCATION' and Group_name='DISTRICT' and parent_group='"+value1+"' order by group_value");

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
</table>
</td>
<td valign=top>

<!----
<table width="100%" border="0" cellpadding="0" cellspacing="0" id="stretch" > 
	<tr><td class="Headings" align="center">Data Summary 8:30AM - 8:30AM</td></tr>
--->

<table width="100%" border="0" cacellpadding="0" cellspacing="0" id="stretch" > 
	<tr><td class="Headings" align="center" width="80%">All Data Summary</td></tr>
	<tr><td class="Blue-content" align="center" width="80%"> from <%=vfdate%> 8:30AM to <%=vtdate%> 8:30AM </td></tr>

<tr><td><table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" > 
<tr class="Blue-content" align="center">
<td>Day</td>
<td>Client ID</td>
<td>District</td>
<td>Mandal</td>
<td>Location</td>
<td>Latitude</td>
<td>Longitude</td>

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

<%query="select pdate,st.clientid,latitude,longitude,location,(select group_value from parameter where param_id=state) as state,(select group_value from parameter where param_id=district) as district,coalesce((select group_value from parameter where param_id=county),'-') as county,temp_max,temp_min,temp_avg,humidity_max,humidity_min,humidity_avg,rain_max,pressure_max,pressure_min,pressure_avg from station_configs_det as st left outer join (select clientid,to_date('"+vtdate+"','DD/MM/YYYY') as pdate,max(case when temp = 0 then null else temp end) as temp_max,min(case when temp = 0 then null else temp end) as temp_min,round(cast(avg(temp) as decimal),2) as temp_avg,max(case when humidity = 0 then null else humidity end) as humidity_max,min(case when humidity = 0 then null else humidity end) as humidity_min, round(cast(avg(humidity) as decimal),2) as humidity_avg,max(rain) as rain_max,max(case when local_pressure = 0 then null else local_pressure end) as pressure_max,min(case when local_pressure = 0 then null else local_pressure end) as pressure_min, round(cast(avg(case when local_pressure = 0 then null else local_pressure end) as decimal),2) as pressure_avg,max(case when wind = 0 then null else wind end) as wind_max,min(case when wind = 0 then null else wind end) as wind_min, round(cast(avg(case when wind = 0 then null else wind end) as decimal),2) as wind_avg, max(case when wind_direction = 0 then null else wind_direction end) as wind_direction_max,min(case when wind_direction = 0 then null else wind_direction end) aswind_direction_min, round(cast(avg(case when wind_direction = 0 then null else wind_direction end) as decimal),2) as wind_direction_avg from data_packets where packet_date >= to_date('"+vfdate+"','DD/MM/YYYY')+INTERVAL '8.5 HOUR' and packet_date < to_date('"+vtdate+"','DD/MM/YYYY')+ INTERVAL '8.5 HOUR' group by clientid,pdate ) as dp on st.clientid=dp.clientid where st.activate!=0";

if(value2.equalsIgnoreCase("-1")) {	query=query+" and state='"+value1+"'";}
	else{ query=query+" and district='"+value2+"'";}

query=query+" order by clientid,pdate";
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


</tr></table>

</table>


<!--------------------

<%
query="select pdate,st.clientid,latitude,longitude,location,(select group_value from parameter where param_id=state) as state,(select group_value from parameter where param_id=district) as district,coalesce((select group_value from parameter where param_id=county),'-') as county,temp_max,temp_min,temp_avg,humidity_max,humidity_min,humidity_avg,rain_max,pressure_max,pressure_min,pressure_avg from station_configs_det as st left outer join (select clientid,to_date('"+vtdate+"','DD/MM/YYYY') as pdate,max(case when temp = 0 then null else temp end) as temp_max,min(case when temp = 0 then null else temp end) as temp_min,round(cast(avg(temp) as decimal),2) as temp_avg,max(case when humidity = 0 then null else humidity end) as humidity_max,min(case when humidity = 0 then null else humidity end) as humidity_min, round(cast(avg(humidity) as decimal),2) as humidity_avg,max(rain) as rain_max,max(case when local_pressure = 0 then null else local_pressure end) as pressure_max,min(case when local_pressure = 0 then null else local_pressure end) as pressure_min, round(cast(avg(case when local_pressure = 0 then null else local_pressure end) as decimal),2) as pressure_avg,max(case when wind = 0 then null else wind end) as wind_max,min(case when wind = 0 then null else wind end) as wind_min, round(cast(avg(case when wind = 0 then null else wind end) as decimal),2) as wind_avg, max(case when wind_direction = 0 then null else wind_direction end) as wind_direction_max,min(case when wind_direction = 0 then null else wind_direction end) aswind_direction_min, round(cast(avg(case when wind_direction = 0 then null else wind_direction end) as decimal),2) as wind_direction_avg from data_packets where packet_date >= to_date('"+vfdate+"','DD/MM/YYYY')+INTERVAL '8.5 HOUR' and packet_date < to_date('"+vtdate+"','DD/MM/YYYY')+ INTERVAL '8.5 HOUR' group by clientid,pdate ) as dp on st.clientid=dp.clientid where st.activate!=0";

if(value2.equalsIgnoreCase("-1")) {	query=query+" and state='"+value1+"'";}
	else{ query=query+" and district='"+value2+"'";}

query=query+" order by clientid,pdate";
rs=stmt.executeQuery(query);


System.out.println(query);
	rs=stmt.executeQuery(query);
	while(rs.next()){
%>

----->

</td></tr>
</table>
<%} %>

</body>
</html>
