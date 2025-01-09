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
        var vfhr= document.getElementById("fhr").value	
	var vfmin= document.getElementById("fmin").value
	var vthr= document.getElementById("thr").value
	var vtmin= document.getElementById("tmin").value
window.location.replace("detailedwater.jsp?value1="+vid1+"&&value2="+vid2+"&&vfdate="+vfdate+"&&vtdate="+vtdate+"&&fhr="+vfhr+"&&fmin="+vfmin+"&&thr="+vthr+"&&tmin="+vtmin);
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

<style>
.export {
  border: 2px solid black;
  background-color: white;
  color: black;
  padding: 5px 15px;
  font-size: 15px;
  font-family:Georgia;
   font-weight: bold;
  margin-bottom:3px;
  cursor: pointer;
}
/* Green */
.success {
  border-color: black;
 
  color: white;
  background-color: #4d4dff;
  opacity:0.8;
}

.success:hover {
  background-color: #99ff99;
  color: black;
}
</style>

</head>

<body>
<!-- export to excel script start-->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
 <script src="../../Script/table2excel.js" type="text/javascript"></script>
 <script type="text/javascript">
        function Export() {
            $("#tblCustomers").table2excel({
				filename: "Detailed_Data :"+ new Date().toLocaleString().replace(/[\-\:\.]/g, " ") + ".xls"
            });
        }
    </script>
<!-- export to excel script end-->


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
</table>
</td>
<td valign=top>
<!----
<table width="100%" border="0" cellpadding="0" cellspacing="0" id="stretch" > 
	<tr><td class="Headings" align="center">Detailed Data 8:30AM - 8:30AM</td></tr>

---->
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
	<tr>
	
<td align="right"bgcolor="#fffff8" >
<button class="export success"> Export</button>&nbsp
<input type="image" src="../../images/excel.jpg" height="70%" value="Export" onclick="Export()">

</td>


</tr>

<tr><td><table id="tblCustomers" width="100%" border="1" cellpadding="0" cellspacing="0"  > 
	<tr>
<td class="headings" align="center" colspan="5"> WaterLevel Detailed Data from <%=vfdate%> <%=vfhr%>:<%=vfmin%> Hrs to <%=vtdate%> <%=vthr%>:<%=vtmin%> Hrs</td>
</tr>




<tr class="Blue-content" align="center">
<td rowspan="1">Client ID</td>
<td rowspan="1">District</td>
<td rowspan="1">Location</td>
<td rowspan="1">Date Time</td>
<!-- <td>Latitude</td> <td>Longitude</td> -->
<td>Depth of<br>Water(m) </td>
</tr>

<%
query="select dp.clientid,to_char(packet_date,'dd/mm/yyyy hh24:mi:ss') as date,scd.longitude,scd.latitude,scd.location,scd.state,coalesce((select group_value from parameter where param_id=county),'-') as county,par.group_value,";
//query+="temp,temp_min,temp_max,humidity_min,humidity,humidity_max,dew_point,wind_min,wind_direction,wind,wind_direction,wind,wind_direction,";
query+="local_pressure,mslp,rain,hrain,solar_rad,soil_moist1,soil_moist2,soil_moist3,soil_temp, bubler,leaf_wetness,rwlr,"; 
query+=" dp.* from data_packets as dp,";
query+="(select clientid,longitude,latitude,location,state,district,county from station_configs_det) as scd ,";
query+="(select param_id,group_value from parameter) as par where dp.clientid=10002 and packet_type='D' ";
query+="and packet_date >= to_timestamp('"+vfdate+","+vfhr+":"+vfmin+"','dd/mm/yyyy,hh24:mi:ss') and packet_date <= to_timestamp('"+vtdate+","+vthr+":"+vtmin+"','dd/mm/yyyy,hh24:mi:ss') ";
query+="and dp.clientid=scd.clientid and par.param_id=scd.district";

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
<% if (rs.getString("rwlr")==null){ %><td align="right"> NA</td><%} else {%><td align="right"><%=rs.getDouble("rwlr")%></td><%}%>
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
