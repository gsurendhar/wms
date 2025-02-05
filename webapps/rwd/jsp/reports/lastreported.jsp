<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %> 

<script>

function params(){
var vid1 = document.getElementById("state").value
var vid2 =document.getElementById("district").value
window.location.replace("/wms/jsp/reports/lastreported.jsp?value1="+vid1+"&&value2="+vid2);
}
</script>

<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
Statement stmt2=null;
String query="";
int count;
%>
<%
String value1=request.getParameter("value1");
String value2=request.getParameter("value2");
if (value1==null){value1="0";}
if (value2==null){value2="0";}

con = ConnectionProvider.getCon();
stmt=con.createStatement();
stmt2=con.createStatement();
rs = stmt.executeQuery("select param_id as sid,group_value as state from parameter where active='Y' and group_family='LOCATION' and Group_name='STATE'");
%>
<html>
<head>
<link href="../../styles/text.css" rel="stylesheet" type="text/css">
</head>
<body>

<table width="100%" border="1" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
<tr><td width="10%" VALIGN=TOP>
<table width="10%" border="1" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>

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

	//updating the Audit_table
		count=stmt2.executeUpdate("insert into audit_table values((select user_id from users where user_role="+session.getAttribute("theRole")+" and login_name='"+session.getAttribute("theName")+"'),(select user_role from users where user_role="+session.getAttribute("theRole")+" and login_name='"+session.getAttribute("theName")+"'),'Last Reported','now()')");
  //end of auditing
}
}
%>
</select>
</td></tr>
</table>
</td>
<td valign=top>

<table width="100%" border="0" cellpadding="0" cellspacing="0" id="stretch" > 
	<tr><td class="Headings" align="center">Last Reported Stations</td></tr>
	<tr><td><table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" > 
<tr><td class="Blue-content">Client Id</td>
<td class="Blue-content">Location</td>
<td class="Blue-content">Latitude</td>
<td class="Blue-content">Longitude</td>
<!-- <td class="Blue-content">State</td> -->
<td class="Blue-content">District</td>
<td class="Blue-content">Packet DateTime</td>
<td class="Blue-content">Rain Packet</td>
<td class="Blue-content">Temp Packet</td>
<td class="Blue-content">Humidity Packet</td>
<td class="Blue-content">WindSpeed Packet</td>
<td class="Blue-content">WindDirection Packet</td>
<td class="Blue-content">Pressure Packet</td>
</tr>
<%
	
query="select clientid,location,state,district,longitude,latitude,coalesce(to_char(last_packet,'mm/dd/yyyy hh24:mi'),null,'-') as last_packet, coalesce(to_char(rain_sensors,'mm/dd/yyyy hh24:mi'),null,'-') as rain_sensors, coalesce(to_char(temp_sensors,'mm/dd/yyyy hh24:mi'),null,'-') as temp_sensors, coalesce(to_char(humid_sensors,'mm/dd/yyyy hh24:mi'),null,'-') as humid_sensors, coalesce(to_char(wind_sensors,'mm/dd/yyyy hh24:mi'),null,'-') as wind_sensors, coalesce(to_char(winddir_sensors,'mm/dd/yyyy hh24:mi'),null,'-') as winddir_sensors, coalesce(to_char(pressure_sensors,'mm/dd/yyyy hh24:mi'),null,'-') as pressure_sensors from ( select st.clientid,latitude,longitude,location,(select group_value from parameter where param_id=state) as state,(select group_value from parameter where param_id=district) as district,county,last_packet,rain_sensors,temp_sensors,humid_sensors,wind_sensors,winddir_sensors,pressure_sensors from station_configs_det as st left outer join  ( select clientid,max(packet_date) as last_packet, max(case when rain is not null then packet_date end) as rain_sensors, max(case when temp is not null then packet_date end) as temp_sensors,max(case when humidity is not null then packet_date end) as humid_sensors, max(case when wind is not null then packet_date end) as wind_sensors, max(case when wind_direction is not null then packet_date end) as winddir_sensors,  max(case when local_pressure is not null then packet_date end) as pressure_sensors from data_packets  group by clientid ) as dp on st.clientid=dp.clientid where st.activate!=0";

if(value2.equalsIgnoreCase("-1"))
{
	query=query+" and state="+value1+") as x";
	//updating the Audit_table
		count=stmt2.executeUpdate("insert into audit_table values((select user_id from users where user_role="+session.getAttribute("theRole")+" and login_name='"+session.getAttribute("theName")+"'),(select user_role from users where user_role="+session.getAttribute("theRole")+" and login_name='"+session.getAttribute("theName")+"'),'Last Reported','now()')");
  //end of auditing
}
else{
	query=query+" and district='"+value2+"') as x";
					}
rs=stmt.executeQuery(query);


System.out.println(query);
	rs=stmt.executeQuery(query);
	while(rs.next()){
%>
<tr><td class="readonly"><%=rs.getString("clientid")%></td>
<td class="readonly"><%=rs.getString("location")%></td>
<td class="readonly"><%=rs.getString("latitude")%></td>
<td class="readonly"><%=rs.getString("longitude")%></td>
<!-- <td class="readonly"><%=rs.getString("state")%></td> -->
<td class="readonly"><%=rs.getString("district")%></td>
<td class="readonly"><%=rs.getString("last_packet")%></td>
<td class="readonly"><%=rs.getString("rain_sensors")%></td>
<td class="readonly"><%=rs.getString("temp_sensors")%></td>
<td class="readonly"><%=rs.getString("humid_sensors")%></td>
<td class="readonly"><%=rs.getString("wind_sensors")%></td>
<td class="readonly"><%=rs.getString("winddir_sensors")%></td>
<td class="readonly"><%=rs.getString("pressure_sensors")%></td>
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
