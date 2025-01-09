<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %> 
<%@ page import="java.text.*" %>

<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
String query="";
String e;
int count;
%>
<%
String vfdate=request.getParameter("vfdate");
String vtdate=request.getParameter("vtdate");
String vclientid=request.getParameter("cid");
String vday=request.getParameter("day");
if (vday==null){vday="1";}//run for previous day

DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());

con = ConnectionProvider.getCon();
stmt=con.createStatement();

query="select dp.clientid,to_char(packet_date,'dd/mm/yyyy hh24:mi:ss') as date,scd.longitude,scd.latitude,scd.location,scd.state,coalesce((select group_value from parameter where param_id=county),'-') as county,par.group_value,";
query+=" dp.* from data_packets as dp,";
query+="(select clientid,longitude,latitude,location,state,district,county from station_configs_det) as scd ,";
query+="(select param_id,group_value from parameter) as par where packet_type='D' ";
if ("1".equalsIgnoreCase(vday)){
        query+=" and packet_date > current_date - Interval '1 Day' +Interval '8.5 hours' and packet_date <= current_date +Interval '8.5 hours' ";
}
else if ("0".equalsIgnoreCase(vday)) {
        query+=" and packet_date > current_date +Interval '8.5 hours' ";
        }
else {
        query+=" and packet_date > now() - Interval '12.10 hours' ";
        }
query+="and dp.clientid=scd.clientid and par.param_id=scd.district and dp.clientid='"+vclientid+"'";
query=query+" order by clientid,date";
rs=stmt.executeQuery(query);

%>
<html>
<head>
</head>
<body>

<table width="100%" border="1" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
<tr>
<td valign=top>

<table width="100%" border="0" cacellpadding="0" cellspacing="0" id="stretch" > 
	<tr><td class="Headings" align="center" width="80%">Detailed Data</td></tr>
	<!-- <tr><td class="Blue-content" align="center" width="80%"> from  Hrs to  Hrs</td></tr> -->



<tr><td><table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" > 
<tr class="Blue-content" align="center">
<td rowspan="2">Location</td>
<td rowspan="2">Date Time</td>
<td colspan="3"> Temparature(&nbsp;&deg;C&nbsp;)</td>
<td colspan="3">Humidity<br>(&#37;)</td>
<td rowspan="2">Dew<br> Point</td>
<td colspan="3">Wind Speed<br>(&nbsp;m/sec&nbsp;)</td>
<td colspan="3">Wind Direction<br>(&nbsp;degrees<br>from north&nbsp;)</td>
<td colspan="2">Gust </td>
<td colspan="2">Rainfall<br>(&nbsp;mm&nbsp;)</td>
</tr>
<tr  class="Blue-content" align="center">
<td>Min</td><td>Now</td><td>Max</td>
<td>Min</td><td>Now</td><td>Max</td>
<td>Min</td><td>Now</td><td>Max</td>
<td>Min</td><td>Now</td><td>Max</td>
<td>Speed<br>(&nbsp;m/sec&nbsp;)</td>
<td>Direction<br>(&nbsp;degrees)</td>
<td>Cummulative</td><td>Data<br>Period</td>


</tr>

<%
	while(rs.next()){
%>
<tr  class="readonly">
<!-- <td><%=rs.getString("clientid")%></td><td><%=rs.getString("group_value")%></td><td><%=rs.getString("county")%></td> -->
<td><%=rs.getString("location")%></td><td><%=rs.getString("date")%></td>
<% if (rs.getString("temp_min")==null){ %><td align="right"> </td><%} else {%><td align="right"><%=rs.getDouble("temp_min")%></td><%}%>
<% if (rs.getString("temp")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("temp")%></td><%}%>
<% if (rs.getString("temp_max")==null){ %><td align="right"> </td><%} else {%><td align="right"><%=rs.getDouble("temp_max")%></td><%}%>

<% if (rs.getString("humidity_min")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("humidity_min")%></td><%}%>
<% if (rs.getString("humidity")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("humidity")%></td><%}%>
<% if (rs.getString("humidity_max")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("humidity_max")%></td><%}%>
<% if (rs.getString("dew_point")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("dew_point")%></td><%}%>

<% if (rs.getString("wind_min")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("wind_min")%></td><%}%>
<% if (rs.getString("wind")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("wind")%></td><%}%>
<% if (rs.getString("wind_max")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("wind_max")%></td><%}%>
<% if (rs.getString("wind_direction_min")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("wind_direction_min")%></td><%}%>
<% if (rs.getString("wind_direction")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("wind_direction")%></td><%}%>
<% if (rs.getString("wind_direction_max")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("wind_direction_max")%></td><%}%>
<% if (rs.getString("gust")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("gust")%></td><%}%>
<% if (rs.getString("gust_direction")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("gust_direction")%></td><%}%>
<% if (rs.getString("rain")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("rain")%></td><%}%>
<% if (rs.getString("hrain")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=String.format("%.2f",rs.getDouble("hrain"))%></td><%}%>
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
