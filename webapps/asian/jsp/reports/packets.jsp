<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %> 
<%@ page import="java.text.*" %>


<%@ page import="java.io.*" %>  
<%@ page import="org.jfree.chart.JFreeChart" %>  
<%@ page import="org.jfree.chart.ChartUtilities" %>  

<%@ page  import="java.awt.*" %>


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
window.location.replace("packets.jsp?value1="+vid1+"&&value2="+vid2+"&&value3="+vid3+"&&value4="+vid4+"&&vfdate="+vfdate+"&&vtdate="+vtdate);
}

function search(){
var vid1 = document.getElementById("txtSearch").value
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
window.location.replace("packets.jsp?search="+vid1+"&&vfdate="+vfdate+"&&vtdate="+vtdate);
}

</script>



<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
String query="";
%>
<%
con = ConnectionProvider.getCon();
stmt=con.createStatement();

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

String vfdate=request.getParameter("vfdate");
String vtdate=request.getParameter("vtdate");

DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());
//out.println(formattedDate);

if(vfdate == null){ 
 vfdate=formattedDate;
 vtdate=formattedDate;
}


%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reports</title>

<link href="../../styles/text.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../Script/datepicker.js"></script>

</head>
<body>

	  
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

<tr><td class="Blue-content" colspan="6" align="left">Select Station</td></tr>
	<tr><td class="content style1"> StationID </td>
	<td><input type=text name=txtSearch  class="content style1" value="<%=search%>" size="5">
	<input class="content style1" type="submit" value="Search" onClick="search()"></td>

<tr><td class="content style1"><b> State </b></td>
<td>
<select id="state" onchange="parameter()" class="content style1">
<option value="0">--Please Select--</option>
<% while(rs.next()){ %>
<option value="<%=rs.getInt("sid")%>"><%=rs.getString("state")%></option>

<% if(rs.getString("sid").equals(value1)){%>
<option value="<%=value1%>" selected disabled><%=rs.getString("state")%></option> 
<%}}%>
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
	query=query+" order by location";
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
		<tr>
		<td class="Blue-content">Date & Time</td>
		<td class="Blue-content">Rain ( mm)</td><td class="Blue-content">Temparature(&ordm; C)</td><td class="Blue-content">Wind</td>
		<td class="Blue-content">Wind<br> Direction</td><td class="Blue-content">Humidity</td><td class="Blue-content">Local Pressure</td><td class="Blue-content">MSLP</td>
		</tr>
<% 

	query="select to_char(packet_date,'DD/MM/YY HH24:MI:SS') as date,clientid,packetno,rain,temp,wind,wind_direction,mslp,humidity,local_pressure from data_packets_2010 as a where clientid="+value4+" and packet_type='D' and packet_date between to_date('"+vfdate+"','dd/mm/yyyy') and to_date('"+vtdate+"','dd/mm/yyyy')+ INTERVAL '1 DAY' order by packet_date";
	//System.out.println(query);
	rs=stmt.executeQuery(query);
	while(rs.next()){
%>
		<tr>
		<td class="readonly"><class="Blue-content"><%=rs.getString("date")%></td>
		<% if (rs.getString("rain")==null){ %><td class="readonly">N/A</td><%} else {%><td class="readonly"><%=rs.getDouble("rain")%></td><%}%>
		<% if (rs.getString("temp")==null){ %><td class="readonly">N/A</td><%} else {%><td class="readonly"> <%=rs.getDouble("temp")%></td><%}%>
		<% if (rs.getString("wind")==null){ %><td class="readonly">N/A</td><%} else {%><td class="readonly"> <%=rs.getDouble("wind")%></td><%}%>
		<% if (rs.getString("wind_direction")==null){ %><td class="readonly">N/A</td><%} else {%><td class="readonly"> <%=rs.getDouble("wind_direction")%></td><%}%>
		<% if (rs.getString("humidity")==null){ %><td class="readonly">N/A</td><%} else {%><td class="readonly"> <%=rs.getDouble("humidity")%></td><%}%>
		<% if (rs.getString("local_pressure")==null){ %><td class="readonly">N/A</td><%} else {%><td class="readonly"> <%=rs.getDouble("local_pressure")%></td><%}%>
		<% if (rs.getString("mslp")==null){ %><td class="readonly">N/A</td><%} else {%><td class="readonly"> <%=rs.getDouble("mslp")%></td><%}%>
		</tr>
<%}%>
</table>
</table>
</td></tr>
</table>
	  

<%
rs.close();
con.close();
%>
</body>
</html>
