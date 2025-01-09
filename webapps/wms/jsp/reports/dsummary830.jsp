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
window.location.replace("dsummary830.jsp?value1="+vid1+"&&value2="+vid2+"&&vfdate="+vfdate+"&&vtdate="+vtdate);
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
<td><input id="fdate"  class="content style1" type="text" name="fdate" size="10" maxlength="12" value=<%=vfdate%>>
<a href="javascript:NewCal('fdate','ddmmyyyy',false)"><img src="../../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a></td>
</tr>
<tr><td class="content style1" align="right"><b>To</b></td>
<td><input id="tdate"  class="content style1" type="text" name="tdate" size="10" maxlength="12" value=<%=vtdate%>>
<a href="javascript:NewCal('tdate','ddmmyyyy',false)"><img src="../../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a></td>
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

	//updating the Audit_table
		count=stmt2.executeUpdate("insert into audit_table values((select user_id from users where user_role="+session.getAttribute("theRole")+" and login_name='"+session.getAttribute("theName")+"'),(select user_role from users where user_role="+session.getAttribute("theRole")+" and login_name='"+session.getAttribute("theName")+"'),'Data Summary','now()')");
  //end of auditing
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
	
<tr><td><table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" > 
<tr class="Blue-content" align="center">
<td>Day</td>
<td>Client ID</td>
<td>District</td>
<td>Mandal</td>
<td>Location</td>
<td>Latitude</td>
<td>Longitude</td>
<td colspan="3">Temparature<br>(&nbsp;&deg;C&nbsp;)</td>
<td colspan="3">Humidity<br>(&nbsp;&permil;&nbsp;)</td>
<td colspan="3">local_Pressure<br>(&nbsp;milibar&nbsp;)</td>
<td colspan="3">MSL_Pressure<br>(&nbsp;milibar&nbsp;)</td>
<td colspan="3">Wind Speed<br>(&nbsp;kmph&nbsp;)</td>
<td colspan="3">Wind Direction<br>(&nbsp;degrees&nbsp;)</td>
<td>Accumulated<br>Rainfall (mm)</td>
<td>Packet Count</td>
</tr>
<tr class="Blue-content">
<td colspan="7">&nbsp;</td>
<td>Min</td>
<td>Max</td>
<td>Avg</td>
<td>Min</td>
<td>Max</td>
<td>Avg</td>
<td>Min</td>
<td>Max</td>
<td>Avg</td>
<td>Min</td>
<td>Max</td>
<td>Avg</td>
<td>Min</td>
<td>Max</td>
<td>Avg</td>
<td>Min</td>
<td>Max</td>
<td>Avg</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
</tr>

<%
query="select pdate,st.clientid,latitude,longitude,location,(select group_value from parameter where param_id=state) as state,(select group_value from parameter where param_id=district) as district,coalesce((select group_value from parameter where param_id=county),'-') as county,pcount,temp_min,temp_max,temp_avg,humidity_min,humidity_max,humidity_avg,rain_max,pressure_min,pressure_max,pressure_avg,mslp_min,mslp_max,mslp_avg,wind_min,wind_max,wind_avg,winddir_min,winddir_max, winddir_avg from station_configs_det as st left outer join (select clientid,case when to_char(packet_date,'HH24MI') between '0000' and '0830' then to_char(packet_date ,'MM/DD/YYYY') else to_char(packet_date+ interval '1 Day','MM/DD/YYYY') end as pdate,count(1) as pcount,max(case when temp = 0 then null else temp end) as temp_max,min(case when temp = 0 then null else temp end) as temp_min,round(cast(avg(temp) as decimal),2) as temp_avg,max(case when humidity = 0 then null else humidity end) as humidity_max,min(case when humidity = 0 then null else humidity end) as humidity_min, round(cast(avg(humidity) as decimal),2) as humidity_avg,max(rain) as rain_max,max(case when local_pressure = 0 then null else local_pressure end) as pressure_max,min(case when local_pressure = 0 then null else local_pressure end) as pressure_min, round(cast(avg(case when local_pressure = 0 then null else local_pressure end) as decimal),2) as pressure_avg,max(case when mslp = 0 then null else mslp end) as mslp_max,min(case when mslp = 0 then null else mslp end) as mslp_min, round(cast(avg(case when mslp = 0 then null else mslp end) as decimal),2) as mslp_avg,max(wind)as wind_max,min(wind)as wind_min,round(cast(avg(wind) as decimal),2) as wind_avg, max(case when wind_direction = 0 then null else wind_direction end) as winddir_max,min(case when wind_direction= 0 then null else wind_direction end) as winddir_min,round(cast(avg(wind_direction) as decimal),1) as winddir_avg from data_packets where  packet_date >= to_date('"+vfdate+"','DD/MM/YYYY')-INTERVAL '1 DAY'+INTERVAL '8.5 HOUR' and packet_date < to_date('"+vtdate+"','DD/MM/YYYY')+ INTERVAL '8.5 HOUR' and packet_type='D' group by clientid,pdate ) as dp on st.clientid=dp.clientid where st.activate!=0";

if(value2.equalsIgnoreCase("-1")) {	query=query+" and state='"+value1+"'";
//updating the Audit_table
		count=stmt2.executeUpdate("insert into audit_table values((select user_id from users where user_role="+session.getAttribute("theRole")+" and login_name='"+session.getAttribute("theName")+"'),(select user_role from users where user_role="+session.getAttribute("theRole")+" and login_name='"+session.getAttribute("theName")+"'),'Data Summary','now()')");
  //end of auditing
  }
	else{ query=query+" and district='"+value2+"'";}

query=query+" order by clientid,pdate";
rs=stmt.executeQuery(query);


//System.out.println(query);
//out.println(query);
	rs=stmt.executeQuery(query);
	while(rs.next()){
%>
<tr  class="readonly">
<!--------<td><%=rs.getString("pdate")%></td>---------->
<% if (rs.getString("pdate")==null){ %><td align="right">---</td><%} else {%><td align="right"><%=rs.getString("pdate")%></td><%}%>
<td><%=rs.getString("clientid")%></td><td><%=rs.getString("district")%></td><td><%=rs.getString("county")%></td>
<td><%=rs.getString("location")%></td><td><%=rs.getString("latitude")%></td><td><%=rs.getString("longitude")%></td>


<% if (rs.getString("temp_min")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("temp_min")%></td><%}%>

<% if (rs.getString("temp_max")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("temp_max")%></td><%}%>
<% if (rs.getString("temp_avg")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("temp_avg")%></td><%}%>
<% if (rs.getString("humidity_min")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("humidity_min")%></td><%}%>
<% if (rs.getString("humidity_max")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("humidity_max")%></td><%}%>
<% if (rs.getString("humidity_avg")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("humidity_avg")%></td><%}%>
<% if (rs.getString("pressure_min")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("pressure_min")%></td><%}%>
<% if (rs.getString("pressure_max")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("pressure_max")%></td><%}%>
<% if (rs.getString("pressure_avg")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("pressure_avg")%></td><%}%>
<% if (rs.getString("mslp_min")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("mslp_min")%></td><%}%>
<% if (rs.getString("mslp_max")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("mslp_max")%></td><%}%>
<% if (rs.getString("mslp_avg")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("mslp_avg")%></td><%}%>


<% if (rs.getString("wind_min")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("wind_min")%></td><%}%>
<% if (rs.getString("wind_max")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("wind_max")%></td><%}%>

<% if (rs.getString("wind_avg")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("wind_avg")%></td><%}%>
<% if (rs.getString("winddir_min")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("winddir_min")%></td><%}%>
<% if (rs.getString("winddir_max")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("winddir_max")%></td><%}%>

<% if (rs.getString("winddir_avg")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("winddir_avg")%></td><%}%>



<% if (rs.getString("rain_max")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("rain_max")%></td><%}%>

<!---- old code ---without N/A 
<td><%=rs.getDouble("temp_max")%></td><td><%=rs.getDouble("temp_min")%></td><td><%=rs.getDouble("temp_avg")%></td>
<td><%=rs.getDouble("humidity_max")%></td><td><%=rs.getDouble("humidity_min")%></td><td><%=rs.getDouble("humidity_avg")%></td>
<td><%=rs.getDouble("pressure_max")%></td><td><%=rs.getDouble("pressure_min")%></td>

<td><%=rs.getDouble("pressure_avg")%></td>

<td><%=rs.getDouble("rain_max")%></td> ---->
<td align="center"><%=rs.getInt("pcount")%></td> 
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
