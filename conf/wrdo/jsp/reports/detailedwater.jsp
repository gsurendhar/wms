<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %> 
<%@ page import="java.text.*" %>

<script>

function params(){

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
        var vfhr= document.getElementById("fhr").value	
	var vfmin= document.getElementById("fmin").value
	var vthr= document.getElementById("thr").value
	var vtmin= document.getElementById("tmin").value
window.location.replace("detailedwater.jsp?value1="+vid1+"&&value2="+vid2+"&&value3="+vid3+"&&value4="+vid4+"&&vfdate="+vfdate+"&&vtdate="+vtdate+"&&fhr="+vfhr+"&&fmin="+vfmin+"&&thr="+vthr+"&&tmin="+vtmin);
}
</script>

<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
Statement stmt2=null;
String query="";
String e;
int count;
%>
<%
String value1=request.getParameter("value1");
String value2=request.getParameter("value2");
String value3=request.getParameter("value3");
String value4=request.getParameter("value4");
String vfdate=request.getParameter("vfdate");
String vtdate=request.getParameter("vtdate");
	String vfhr=request.getParameter("fhr");
	String vfmin=request.getParameter("fmin");
	String vthr=request.getParameter("thr");
	String vtmin=request.getParameter("tmin");



if (value1==null){value1="0";}
if (value2==null){value2="0";}


DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());

if(vfdate == null){ 
 vfdate=formattedDate;
 vtdate=formattedDate;
 vfhr="00";
 vfmin="00";
 vthr="00";
 vtmin="00";
}

con = ConnectionProvider.getCon();
stmt=con.createStatement();
stmt2=con.createStatement();
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
<td>
 <input id="fdate"  class="content style1" type="text" name="fdate" size="10" maxlength="12" value=<%=vfdate%>>
<a href="javascript:NewCal('fdate','ddmmyyyy',false)"><img src="../../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a>
<select id="fhr" class="content style1">
<% for (int i=0; i<24; i++) {
	e=Integer.toString(i);
	if (e.length()==1){e="0"+e;}%>
<option value="<%=e%>"><%=e%></option>
<%}%>
<option value=<%=vfhr%> selected disabled><%=vfhr%></option>
</select><a class="content style1">Hr</a>
<select id="fmin" class="content style1">
<% 	for (int i=0; i<60; i++) {
		e=Integer.toString(i);
		if (e.length()==1){e="0"+e;}%>
<option value="<%=e%>"><%=e%></option>
<%}%>
<option value=<%=vfmin%> selected disabled><%=vfmin%></option>
</select><a class="content style1">Mi</a>
</td>

</td>
</tr>
<tr><td class="content style1" align="right"><b>To</b></td>
<td><input id="tdate"  class="content style1" type="text" name="tdate" size="10" maxlength="12" value=<%=vtdate%>>
<a href="javascript:NewCal('tdate','ddmmyyyy',false)"><img src="../../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a>
<select id="thr" class="content style1">
<% for (int i=0; i<24; i++) {
	e=Integer.toString(i);
	if (e.length()==1){e="0"+e;}%>
<option value="<%=e%>"><%=e%></option>
<%}%>
<option value=<%=vthr%> selected disabled><%=vthr%></option>
</select><a class="content style1">Hr</a>
<select id="tmin" class="content style1">
<% 	for (int i=0; i<60; i++) {
		e=Integer.toString(i);
		if (e.length()==1){e="0"+e;}%>
<option value="<%=e%>"><%=e%></option>
<%}%>
<option value=<%=vtmin%> selected disabled><%=vtmin%></option>
</select><a class="content style1">Mi</a>
</td>
</tr>

 <!-- date selection Ends here -->




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

<tr><td class="content style1"><b> Mandal</b> </td><td>
<select id="county" onchange="params()" class="content style1">
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
<tr><td class="content style1"><b> Stations</b> </td>
<td class="content style1" align="left"  >
<select id="location" onchange="params()" class="content style1" size="20">
<option value="0">--Please Select--</option>
<%
query="select * from station_configs_det ";
query=query+" where state="+value1+" and district="+value2+" and county="+value3;
query=query+" order by location";
rs=stmt.executeQuery(query);

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
<!----
<table width="100%" border="0" cellpadding="0" cellspacing="0" id="stretch" > 
	<tr><td class="Headings" align="center">Detailed Data 8:30AM - 8:30AM</td></tr>

---->

<table width="100%" border="0" cacellpadding="0" cellspacing="0" id="stretch" > 
	<tr><td class="Headings" align="center" width="80%">RIVER GAUGE DATA</td></tr>
	<tr><td class="Blue-content" align="center" width="80%"> from <%=vfdate%> <%=vfhr%>:<%=vfmin%> Hrs to <%=vtdate%> <%=vthr%>:<%=vtmin%> Hrs</td></tr>



<tr><td><table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" > 
<tr class="Blue-content" align="center">
<td rowspan="2">Client ID</td>
<td rowspan="2">District</td>
<td rowspan="2">Location</td>
<td rowspan="2">Date Time</td>
<!-- <td colspan="3">Water</td> -->
</tr>
<tr  class="Blue-content" align="center">
<!---<td>Hieght of<br>Water Level(m)<br>from Instrument</td> --->
<td>Depth of<br>Water(m) </td>
<td>Cross Sectional<br>Area<br> in smt.(A) </td>
<!---<td>Surface Velocity<br> in (m/sec) </td> --->
<td>Mean Velocity<br>in  (m/sec) </td>
<td>Discharge<br> in cumecs(Q) </td>


</tr>

<%
query="select dp.clientid,to_char(packet_date,'dd/mm/yyyy hh24:mi:ss') as date,scd.longitude,scd.latitude,scd.location,scd.state,coalesce((select group_value from parameter where param_id=county),'-') as county,par.group_value,";
//query+="temp,temp_min,temp_max,humidity_min,humidity,humidity_max,dew_point,wind_min,wind_direction,wind,wind_direction,wind,wind_direction,";
//query+="local_pressure,mslp,rain,hrain,solar_rad,soil_moist1,soil_moist2,soil_moist3,soil_temp, bubler,leaf_wetness,water_level 
//query+=" dp.*,(scd.wmsl+water_level)water_msl from data_packets as dp,";
query+=" dp.*,round(cast(scd.wmsl-(water_level-scd.mslpoint1) as numeric),3) water_msl,round(cast( scd.paramtime1*power((scd.wmsl-(water_level-scd.mslpoint1)),2)+scd.paramtime2*(scd.wmsl-(water_level-scd.mslpoint1))+scd.paramtime3 as numeric),4) water_area,round(cast((scd.param4*water_velocity)+scd.param5 as numeric),3) mean_velocity,round(cast((round(cast(scd.paramtime1*power((scd.wmsl-(water_level-scd.mslpoint1)),2)+scd.paramtime2*(scd.wmsl-(water_level-scd.mslpoint1))+scd.paramtime3 as numeric),4))*(round(cast((scd.param4*water_velocity)+scd.param5 as numeric),3))as numeric),4) water_discharge from data_packets as dp,";
query+="(select clientid,longitude,latitude,location,state,district,county,wmsl,mslpoint1,paramtime1,paramtime2,paramtime3,param4,param5 from station_configs_det) as scd ,";
query+="(select param_id,group_value from parameter) as par where dp.clientid="+value4+" and  packet_type='D' ";
query+="and packet_date >= to_timestamp('"+vfdate+","+vfhr+":"+vfmin+"','dd/mm/yyyy,hh24:mi:ss') and packet_date < to_timestamp('"+vtdate+","+vthr+":"+vtmin+"','dd/mm/yyyy,hh24:mi:ss') ";
query+="and dp.clientid=scd.clientid and par.param_id=scd.district and dp.water_level !='999.999'";

if(value2.equalsIgnoreCase("-1")) {	query=query+" and state='"+value1+"'";  }
	else{ query=query+" and district='"+value2+"'";}

query=query+" order by clientid,date";
rs=stmt.executeQuery(query);


System.out.println(query);
	rs=stmt.executeQuery(query);
	while(rs.next()){
%>
<tr  class="readonly">
<td><%=rs.getString("clientid")%></td><td><%=rs.getString("group_value")%></td>
<td><%=rs.getString("location")%></td><td><%=rs.getString("date")%></td>
<!-- <td><%=rs.getString("latitude")%></td> <td><%=rs.getString("longitude")%></td> -->

<!-- <% if (rs.getString("water_level")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("water_level")%></td><%}%> -->
<% if (rs.getString("water_msl")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("water_msl")%></td><%}%>
<% if (rs.getString("water_area")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("water_area")%></td><%}%>
<!-- <% if (rs.getString("water_velocity")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("water_velocity")%></td><%}%> -->
<% if (rs.getString("mean_velocity")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("mean_velocity")%></td><%}%>
<% if (rs.getString("water_discharge")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("water_discharge")%></td><%}%>
</tr>
<%
}
%>
</tr></table>

</table>



	</table>
</td></tr>
</table>
</body>
</html>
