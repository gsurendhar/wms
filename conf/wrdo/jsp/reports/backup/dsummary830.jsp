<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="wms.dbconnect.DBPostgres" %> 
<%@ page import="java.text.*" %>

<script>

function params(){
var vid1 = document.getElementById("state").value
var vid2 =document.getElementById("district").value
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
window.location.replace("/wms/jsp/reports/dsummary830.jsp?value1="+vid1+"&&value2="+vid2+"&&vfdate="+vfdate+"&&vtdate="+vtdate);
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

con = DBPostgres.getConnection();
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

<table width="100%" border="0" cellpadding="0" cellspacing="0" id="stretch" > 
	<tr><td class="Headings" align="center">Data Summary 8:30AM - 8:30AM</td></tr>
<tr><td><table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" > 
<tr class="Blue-content" align="center">
<td>Day</td>
<td>Client ID</td>
<td>District</td>
<td>Mandal</td>
<td>Location</td>
<td>Latitude</td>
<td>Longitude</td>
<td colspan="2">Temparature</br>(&nbsp;&deg;C&nbsp;)</td>
<td colspan="2">Humidity<br/>(&nbsp;&permil;&nbsp;)</td>
<td colspan="3">Pressure<br>(&nbsp;milibar&nbsp;)</td>
<td>Accumulated<br>Rainfall (mm)</td>
</tr>
<tr class="Blue-content">
<td colspan="7">&nbsp;</td>
<td>Max</td>
<td>Min</td>
<td>Max</td>
<td>Min</td>
<td>Max</td>
<td>Min</td>
<td>Avg</td>
<td>&nbsp;</td>
</tr>

<%
query="select pdate,st.clientid,latitude,longitude,location,(select group_value from parameter where param_id=state) as state,(select group_value from parameter where param_id=district) as district,coalesce((select group_value from parameter where param_id=county),'-') as county,temp_max,temp_min,humidity_max,humidity_min,rain_max,pressure_max,pressure_min,pressure_avg from station_configs_det as st join (select clientid, to_date('"+vtdate+"','DD/MM/YYYY') as pdate,max(case when temp = 0 then null else temp end)as temp_max,min(case when temp = 0 then null else temp end)as temp_min,max(case when humidity = 0 then null else humidity end)as humidity_max,min(case when humidity = 0 then null else humidity end)as humidity_min,max(case when rain = 0 then null else rain end)as rain_max,max(case when local_pressure = 0 then null else local_pressure end)as pressure_max,min(case when local_pressure = 0 then null else local_pressure end)as pressure_min,avg(case when local_pressure = 0 then null else local_pressure end)as pressure_avg from data_packets where packet_date >= to_date('"+vfdate+"','DD/MM/YYYY')+INTERVAL '8.5 HOUR' and packet_date < to_date('"+vtdate+"','DD/MM/YYYY')+ INTERVAL '8.5 HOUR' group by clientid,pdate ) as dp on st.clientid=dp.clientid where st.activate!=0";

if(value2.equalsIgnoreCase("-1")) {	query=query+" and state='"+value1+"'";}
	else{ query=query+" and district='"+value2+"'";}

query=query+" order by clientid,pdate";
rs=stmt.executeQuery(query);


System.out.println(query);
	rs=stmt.executeQuery(query);
	while(rs.next()){
%>
<tr  class="readonly">
<td><%=rs.getString("pdate")%></td><td><%=rs.getString("clientid")%></td><td><%=rs.getString("district")%></td><td><%=rs.getString("county")%></td>
<td><%=rs.getString("location")%></td><td><%=rs.getString("latitude")%></td><td><%=rs.getString("longitude")%></td>
<td><%=rs.getDouble("temp_max")%></td><td><%=rs.getDouble("temp_min")%></td><td><%=rs.getDouble("humidity_max")%></td>
<td><%=rs.getDouble("humidity_min")%></td><td><%=rs.getDouble("pressure_max")%></td><td><%=rs.getDouble("pressure_min")%></td>
<td><%=rs.getDouble("pressure_avg")%></td><td><%=rs.getDouble("rain_max")%></td>
</tr>
<%
}
%>

</tr></table>

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
