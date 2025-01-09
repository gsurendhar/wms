<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="wms.dbconnect.DBPostgres" %> 
<script>

function district(){
var vid1 = document.getElementById("state").value
var vid2 = 0
var vid3 = 0
var vid4 = 0
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
window.location.replace("/wms/jsp/stnlocations.jsp?value1="+vid1+"&&value2="+vid2+"&&value3="+vid3+"&&value4="+vid4+"&&vfdate="+vfdate+"&&vtdate="+vtdate);
}

function county(){
var vid1 = document.getElementById("state").value
var vid2 = document.getElementById("district").value
var vid3 = 0
var vid4 = 0
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
//window.location.replace("/wms/jsp/StationConfig.jsp?value1="+vid1+"&&value2="+vid2);
window.location.replace("/wms/jsp/stnlocations.jsp?value1="+vid1+"&&value2="+vid2+"&&value3="+vid3+"&&value4="+vid4+"&&vfdate="+vfdate+"&&vtdate="+vtdate);
}

function loc(){
var vid1 = document.getElementById("state").value
var vid2 = document.getElementById("district").value
var vid3 = document.getElementById("county").value
var vid4 = 0
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
//window.location.replace("/wms/jsp/StationConfig.jsp?value1="+vid1+"&&value2="+vid2+"&&value3="+vid3);
window.location.replace("/wms/jsp/stnlocations.jsp?value1="+vid1+"&&value2="+vid2+"&&value3="+vid3+"&&value4="+vid4+"&&vfdate="+vfdate+"&&vtdate="+vtdate);
}

function stn(){
var vid1 = document.getElementById("state").value
var vid2 = document.getElementById("district").value
var vid3 = document.getElementById("county").value
var vid4 = document.getElementById("location").value
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
window.location.replace("/wms/jsp/stnlocations.jsp?value1="+vid1+"&&value2="+vid2+"&&value3="+vid3+"&&value4="+vid4+"&&vfdate="+vfdate+"&&vtdate="+vtdate);
}



</script>



<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
String query="";
%>

<!-- Sesssion Management -->
<%if(null == session.getAttribute("theName")){  
  // User is not logged in.
  out.println("your Session has expired");
  response.sendRedirect("../index.html?invalid=0");
}
%>
<!-- End of Sesssion Management -->


<%
String value1=request.getParameter("value1");
String value2=request.getParameter("value2");
String value3=request.getParameter("value3");
String value4=request.getParameter("value4");
String vfdate=request.getParameter("vfdate");
String vtdate=request.getParameter("vtdate");

con = DBPostgres.getConnection();
stmt=con.createStatement();
rs = stmt.executeQuery("select param_id as sid,group_value as state from parameter where active='Y' and group_family='LOCATION' and Group_name='STATE'");
%>
<html>
<head>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../Script/datepicker.js"></script>
</head>
<body>

<table width="100%" border="1" cellpadding="1"  bgcolor="#FFCCCC" VALIGN=TOP>
<tr><td width="10%" VALIGN=TOP>
<table width="10%" border="1" cellpadding="1"  bgcolor="#FFCCCC" VALIGN=TOP>
<!--   date selection starts here -->

<tr><td class="Blue-content" colspan="4"><b>Select Date Range</b></td></tr>
<tr><td class="Blue-content" align="right"><b>From</b></td>
<td><input id="fdate" type="text" name="fdate" size="8" maxlength="10" value=<%=vfdate%>></td>
<td> <a href="javascript:NewCal('fdate','ddmmyyyy',false)"><img src="../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a></td>
</tr>
<tr><td class="Blue-content" align="right"><b>To</b></td>
<td><input id="tdate" type="text" name="tdate" size="8" maxlength="10" value=<%=vtdate%>></td>
<td> <a href="javascript:NewCal('tdate','ddmmyyyy',false)"><img src="../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a></td>
</tr>

 <!-- date selection Ends here -->
<tr><td class="Blue-content" colspan="6" align="center">Select Station</td></tr>
<tr><td class="content style1"> State </td>
<td>
<select id="state" onchange="district()" class="content style1">
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
<select id="district" onchange="county()" class="content style1">
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

<tr><td class="content style1"> Mandal </td><td>
<select id="county" onchange="loc()" class="content style1">
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
rs=stmt.executeQuery(query);
%>
<tr><td class="content style1"> Locations </td>
<td class="content style1" align="left"  >
<select id="location" onchange="stn()" class="content style1" size="20">
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
<!--v<tr><td class="Blue-content" colspan="6" align="center">Data View</td></tr> -->
<tr><td class="Blue-content">Date & Time</td><td class="Blue-content">Rain ( mm)</td><td class="Blue-content">Temparature(&ordm; C)</td><td class="Blue-content">Wind</td>
<td class="Blue-content">Wind Direction</td><td class="Blue-content">Humidity</td><td class="Blue-content">Local Pressure</td><td class="Blue-content">MSLP</td></tr>
<%
	query="select to_char(packet_date,'DD/MM/YY HH24:MI') as date,rain,temp,wind,wind_direction,mslp,humidity,local_pressure from data_packets as a where clientid="+value4+" and packet_type='D' and packet_date between to_date('"+vfdate+"','dd/mm/yyyy') and to_date('"+vtdate+"','dd/mm/yyyy')+ INTERVAL '1 DAY' order by packet_date";
	//System.out.println(query);
	rs=stmt.executeQuery(query);
	while(rs.next()){
%>
<tr><td class="readonly"><%=rs.getString(1)%></td>
<td class="readonly"><%=rs.getDouble("rain")%></td>
<td class="readonly"><%=rs.getDouble(3)%></td>
<td class="readonly"><%=rs.getDouble(4)%></td>
<td class="readonly"><%=rs.getDouble(5)%></td>
<td class="readonly"><%=rs.getDouble(7)%></td>
<td class="readonly"><%=rs.getDouble(8)%></td>
<td class="readonly"><%=rs.getDouble(6)%></td>
</tr>
<%
}
%>



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
