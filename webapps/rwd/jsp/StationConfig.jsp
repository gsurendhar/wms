<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %> 
<script>


function stn(){
var vid1 = document.getElementById("state").value
	if (vid1==null || vid1==""){vid1=0;}
var vid2 = document.getElementById("district").value
	if (vid2==null || vid2==""){vid2=0;}
var vid3 = document.getElementById("county").value
	if (vid3==null || vid3==""){vid3=0;}
var vid4 = document.getElementById("location").value
	if (vid4==null || vid4==""){vid4=0;}
window.location.replace("StationConfig.jsp?value1="+vid1+"&&value2="+vid2+"&&value3="+vid3+"&&value4="+vid4);
}

function updatestn(){
var vid4 = document.getElementById("location").value
		if (vid4==null || vid4==""){
	vid4 = document.getElementById("txtSearch").value}
window.location.replace("updatestation.jsp?lid="+vid4+"&&action=update");
}

function addstn(){
var vid1 = document.getElementById("state").value
var vid2 = document.getElementById("district").value
var vid3 = document.getElementById("county").value
var vid4 = document.getElementById("location").value

if (vid1==0){
	alert("Please select State");
	window.location.replace("StationConfig.jsp");
	} 
else {
	if (vid2==0){
		alert("Please select District");
		window.location.replace("StationConfig.jsp?value1="+vid1);
				}
	else{
		if (vid3==0){
		alert("Please select Mandal");
		window.location.replace("StationConfig.jsp?value1="+vid1+"&&value2="+vid2);
				}
		else{
			window.location.replace("updatestation.jsp?value1="+vid1+"&&value2="+vid2+"&&value3="+vid3+"&&action=add");
		}
		}

	}
}

function search(){
var vid1 = document.getElementById("txtSearch").value
window.location.replace("StationConfig.jsp?search="+vid1);
}

</script>


<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
String query="";
int cid;
%>
<%
String value1=request.getParameter("value1");
String value2=request.getParameter("value2");
String value3=request.getParameter("value3");
String value4=request.getParameter("value4");
String search=request.getParameter("search");





con = ConnectionProvider.getCon();
stmt=con.createStatement();




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

rs = stmt.executeQuery("select param_id as sid,group_value as state from parameter where active='Y' and group_family='LOCATION' and Group_name='STATE'");
%>
<html>
<head>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
</head>
<body>


<table width="100%" border="0" cellpadding="0" cellspacing="0" id="stretch"  bgcolor="#DBEBFF">
<tr><td width="10%" VALIGN=TOP>
  <table width="10%" border="0" class=border cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
	<tr><td class="Blue-content" colspan="6" align="center">Station Details</td></tr>
	<tr><td class="content style1"> StationID </td>
	<td><input type=text name=txtSearch  class="content style1" value="<%=search%>" size="5">
	<input class="content style1" type="submit" value="Search" onClick="search()"></td>
	
	
	
	<tr><td class="content style1"> State </td>
	<td>
	<select id="state" onchange="stn()" class="content style1">
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
	<tr><td class="content style1"> District </td><td>
	<select id="district" onchange="stn()" class="content style1">
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

	<tr><td class="content style1"> Mandal/Taluq </td><td>
	<select id="county" onchange="stn()" class="content style1">
	<option value="0">--Please Select--</option>
	<%
		rs=stmt.executeQuery("select param_id as cid,group_value as county from parameter where group_family='LOCATION' and Group_name='COUNTY' and parent_group='"+value2+"' order by 2");
	while(rs.next()){
	%>
	<option value="<%=rs.getInt("cid")%>" ><%=rs.getString("county")%></option>
	<% if(rs.getString("cid").equals(value3)){%>
	<option value="<%=value3%>" selected disabled><%=rs.getString("county")%></option>
	<%
	}
	}
		%>
	</select> </td></tr>
	<%
	
	query="select *from station_configs_det ";
		if(value3.equalsIgnoreCase("0")) {
				query=query+" where state="+value1+" and district="+value2+" order by location";
					}
				else{
								query=query+" where state="+value1+" and district="+value2+" and county="+value3+" order by location";
				}
rs=stmt.executeQuery(query);

	%>
	<tr><td class="content style1"> Stations / Locations </td>
	<td class="content style1" align="left"  >
	<select id="location" onchange="stn()" class="content style1" size="20">
	<option value="0">--Please Select--</option>
	<% while(rs.next()){ %>
	<option value="<%=rs.getInt("clientid")%>" ><%=rs.getString("location")%></option>
	<% if(rs.getString("clientid").equals(value4)){%>
	<option value="<%=value4%>" selected disabled><%=rs.getString("location")%></option>
	<%} } %>
	</select> </td></tr>
	<tr><td colspan="2" align="center"><input type="submit" name="operation1" onclick="addstn()" value="Add New" ></td></tr>
  </table>
  </td>

	<%
	query="select *, to_char(last_reported,'DD/MM/YYYY HH24:MI') as last_signal,(select group_value from parameter where  param_id=district) as dt_name,(select group_value from parameter where  param_id=county) as ct_name  from station_configs_det";

	if ("0".equalsIgnoreCase(search)){
				query=query+" where clientid="+value4; 
				}
	else {query=query+" where clientid='"+search+"'";
				}
		
	rs=stmt.executeQuery(query);
	while(rs.next()){ %>
			<input type=hidden name="lid" value="<%=rs.getString("clientid")%>" >
  
  <td width="80%" VALIGN=TOP>
	<table width="100%" border="0" class=border cellpadding="4" cellspacing="4" bgcolor="" VALIGN=TOP>
		<tr><td class="Blue-content">ID</td><td class="readonly"><%=rs.getString("clientid")%></td>
		<td class="Blue-content">District</td><td class="readonly"><%=rs.getString("dt_name")%></td>
		<td class="Blue-content">Mandal</td><td class="readonly"><%=rs.getString("ct_name")%></td></tr>
		<tr><td class="Blue-content">Location</td><td class="readonly"><%=rs.getString("location")%></td>	
		<td class="Blue-content">Location Address</td><td class="readonly"  colspan="1"><%=rs.getString("address")%></td>
		<td class="Blue-content">Datum</td><td class="readonly"><%=rs.getString("wmsl")%></td>
</tr>
		<tr><td class="Blue-content">Longitude (Degrees)</td><td class="readonly"><%=rs.getString("Longitude")%></td>
		<td class="Blue-content">Latitude (Degrees)</td><td class="readonly"><%=rs.getString("Latitude")%></td>
		<td class="Blue-content">Altitude (meters)</td><td class="readonly"><%=rs.getString("Altitude")%></td></tr>
		<tr><td class="Blue-content">Station SIM #</td><td class="readonly"><%=rs.getString("stn_sim")%></td>
		<td class="Blue-content">Data Frequency (minutes)</td><td class="readonly"><%=rs.getString("datafreq")%></td>
		<td class="Blue-content">Comm Frequency (minutes)</td><td class="readonly"><%=rs.getString("commfreq")%></td></tr>
		<tr><td class="Blue-content">Sensor Height</td><td class="readonly"><%=rs.getString("mslpoint1")%></td>
		<td class="Blue-content">Rain Calibration</td><td class="readonly"><%=rs.getString("calibrationrain")%></td>
		<td class="Blue-content">Wind Calibration</td><td class="readonly"><%=rs.getString("calibrationwind")%></td></tr>
		<tr><td class="Blue-content">Server SIM</td><td class="readonly"><%=rs.getString("srv_sim")%></td>
		<td class="Blue-content">Server Backup SIM1</td><td class="readonly"><%=rs.getString("srv_sim_bkp1")%></td>
		<td class="Blue-content">Server Backup SIM2</td><td class="readonly"><%=rs.getString("srv_sim_bkp2")%></td></tr>
		<!-- <tr><td class="Blue-content">Time 1 (HHMM)</td><td class="readonly"><%=rs.getString("paramtime1")%></td>
		<td class="Blue-content">Time 2 (HHMM)</td><td class="readonly"><%=rs.getString("paramtime2")%></td>
		<td class="Blue-content">Time 3 (HHMM)</td><td class="readonly"><%=rs.getString("paramtime3")%></td></tr>
		<tr><td class="Blue-content">Future Expansion</td><td class="readonly"><%=rs.getString("futureexpansion")%></td>
		<td class="Blue-content">Num Settings</td><td class="readonly"><%=rs.getString("numsettings")%></td>
		<td class="Blue-content">Numbers</td><td class="readonly"><%=rs.getString("phnumbers")%></td></tr>
		<tr><td class="Blue-content">Activate</td><td class="readonly"><%=rs.getString("activate")%></td>
		<td class="Blue-content">Watchdog</td><td class="readonly"><%=rs.getString("Watchdog")%></td>
		<td class="Blue-content">Flash</td><td class="readonly"><%=rs.getString("flash")%></td></tr> -->
		<tr><td class="Blue-content">Contact Person</td><td class="readonly"><%=rs.getString("contact_person")%></td>
		<td class="Blue-content">Contact Phone</td><td class="readonly">
			<textarea readonly rows="4" cols="40" class="readonly" name="txtPhone" ><%=rs.getString("contact_phone")%></textarea> </td>
		<td class="Blue-content">Email</td><td>
			<textarea readonly rows="4" cols="50" class="readonly" name="txtEmail" ><%=rs.getString("emailid")%></textarea> </td></tr>
		<tr><td class="Blue-content">Last Reported</td><td class="readonly" colspan=1><%=rs.getString("last_signal")%></td>
		<td class="Blue-content">SIM Operator</td><td class="readonly" colspan=1><%=rs.getString("operator")%></td>
		<td class="Blue-content">Client Alias</td><td class="readonly" colspan=1><%=rs.getString("client_alias")%></td>
		</tr>
		<tr><td><a href="http://maps.google.com/maps?q=<%=rs.getString("Latitude")%>,<%=rs.getString("Longitude")%>" target="_blank"><img  src="../images/googlemaps.png" alt="Show location on Google Maps"/> </a></td>
		<tr><td colspan="4" align="center"><input type="submit" name="operation2" onclick="updatestn()" value="Edit" ></td></tr>
		
		
	</table>
  </td></tr>
<%
}
%>
</table>

</body>
</html>
