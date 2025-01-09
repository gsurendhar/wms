<%@ page language="java" %>
<%@ page language="java" import="wms.dbconnect.DBPostgres" %> 
<%@ page import="java.io.*,java.sql.*,java.text.*"%>



<script>

function params(){
var vid1 = document.getElementById("state").value
var vid2 =document.getElementById("district").value
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
var vparam= document.getElementById("param").value
window.location.replace("/wms/jsp/reports/dataanalysis.jsp?value1="+vid1+"&&value2="+vid2+"&&vfdate="+vfdate+"&&vtdate="+vtdate);
}

function expxl(){
var vid1 = document.getElementById("state").value
var vid2 =document.getElementById("district").value
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
var vparam= document.getElementById("param").value
window.location.replace("/wms/jsp/reports/dataanalysis.jsp?value1="+vid1+"&&value2="+vid2+"&&vfdate="+vfdate+"&&vtdate="+vtdate+"&&param="+vparam);
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
	<tr><td class="Headings" align="center" width="80%">Data Analysis (Sensors)</td>
	<td align="right"><input type="image" src="../../images/excel.jpg" alt="Submit" name="param" value="export" onclick="expxl()"></td>
	</tr>

<tr><td colspan=2><table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" > 
<tr class="Blue-content">
<td colspan="7">&nbsp;</td>
<td colspan="6" align="center">Packets</td>
</tr>
<tr class="Blue-content">
<td>Day</td><td>Client Id</td><td>District</td><td>Mandal</td><td>Location</td><td>Latitude</td><td>Longitude</td>
<td>Data</td><td>Temp</td><td>Rainfall</td><td>Humidity</td><td>Pressure</td><td>Wind</td>
</tr>

<!-- exporting to excel -->
<% 
String filename = "c:\\dataanalysis.csv";
FileWriter fw = new FileWriter(filename);

if ("export".equalsIgnoreCase(vparam)){
fw.append("Day,Client Id,District,Mandal,Location,Latitude,Longitude,Data Packets,Temp Packets,Rain Packets,Humidity Packets,Pressure PAckets,Wind Packets");
fw.append('\n');
}
%>

<!-- exporting to excel -->

<%
query="select dp.* ,latitude,longitude,location,(select group_value from parameter where param_id=state) as state,(select group_value from parameter where param_id=district) as district,coalesce((select group_value from parameter where param_id=county),'-') as county ";
query=query+" from station_configs_det as st left outer join  ( select ";

//query=query+" case when to_char(packet_date,'HH24:MI') < '08:30' then to_char((packet_date-INTERVAL '1 DAY'),'DD/MM/YYYY') else to_char(packet_date,'DD/MM/YYYY') end as pdate, ";

query=query+" to_char(packet_date,'DD/MM/YYYY') as pdate,clientid,sum(case when packet_type ='D' then 1 else 0 end)as data_packets,sum(case when temp !=0 or temp is not null then 1 else 0 end)as temp_packets,sum(case when rain is not null then 1 else 0 end)as rain_packets, sum(case when local_pressure is not null then 1 else 0 end)as pressure_packets,sum(case when humidity is not null then 1 else 0 end)as humidity_packets, sum(case when wind is not null then 1 else 0 end)as wind_packets from data_packets  where packet_type='D' ";

//query=query+" and  packet_date >= to_date('"+vfdate+"','DD/MM/YYYY')+INTERVAL '8.5 HOUR' and packet_date < to_date('"+vtdate+"','DD/MM/YYYY')+ INTERVAL '32.5 HOUR' ";

query=query+" and  packet_date >= to_date('"+vfdate+"','DD/MM/YYYY') and packet_date < to_date('"+vtdate+"','DD/MM/YYYY')+ INTERVAL '24 HOUR' ";
query=query+" group by clientid,pdate ) as dp on st.clientid=dp.clientid where st.activate!=0 ";

if(value2.equalsIgnoreCase("-1")) {	query=query+" and state='"+value1+"'";}
	else{ query=query+" and district='"+value2+"'";}

query=query+" order by clientid,pdate";
rs=stmt.executeQuery(query);


	rs=stmt.executeQuery(query);
	while(rs.next()){
%>
<tr  class="readonly">
<td><%=rs.getString("pdate")%></td><td><%=rs.getString("clientid")%></td><td><%=rs.getString("district")%></td><td><%=rs.getString("county")%></td>
<td><%=rs.getString("location")%></td><td><%=rs.getString("latitude")%></td><td><%=rs.getString("longitude")%></td>
<td><%=rs.getInt("data_packets")%>
<td><%=rs.getInt("temp_packets")%></td><td><%=rs.getInt("rain_packets")%></td><td><%=rs.getInt("humidity_packets")%></td>
<td><%=rs.getInt("pressure_packets")%></td><td><%=rs.getInt("wind_packets")%></td>
</tr>
<!-- exporting to excel -->
<%
if ("export".equalsIgnoreCase(vparam)){
fw.append(rs.getString("pdate")); 
fw.append(',');
fw.append(rs.getString("clientid"));
fw.append(',');
fw.append(rs.getString("district"));
fw.append(',');
fw.append(rs.getString("county")); 
fw.append(',');
fw.append(rs.getString("location")); 
fw.append(',');
fw.append(rs.getString("latitude")); 
fw.append(',');
fw.append(rs.getString("longitude")); 
fw.append(',');
fw.append(rs.getString("data_packets")); 
fw.append(',');
fw.append(rs.getString("temp_packets")); 
fw.append(',');
fw.append(rs.getString("rain_packets")); 
fw.append(',');
fw.append(rs.getString("humidity_packets")); 
fw.append(',');
fw.append(rs.getString("pressure_packets")); 
fw.append(',');
fw.append(rs.getString("wind_packets")); 
fw.append(',');
fw.append('\n');
}

} 
fw.flush();
fw.close();


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
