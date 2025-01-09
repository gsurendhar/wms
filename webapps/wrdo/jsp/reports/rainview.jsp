<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %> 
<%@ page import="java.text.*" %>

<script>


function parameter(){
var vid1 = document.getElementById("state").value
		if (vid1==null || vid1==""){vid1=0;}
var vid2 = document.getElementById("district").value
		if (vid2==null || vid2==""){vid2=0;}
var vid3 = 0
var vid4 = 0
var vfdate= document.getElementById("fdate").value
var vfhr= document.getElementById("fhr").value	
var vfmin= document.getElementById("fmin").value
window.location.replace("rainview.jsp?value1="+vid1+"&&value2="+vid2+"&&value3="+vid3+"&&value4="+vid4+"&&vfdate="+vfdate+"&&fhr="+vfhr+"&&fmin="+vfmin);
}


</script>



<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
Statement stmt2=null;
String query="";
String e; 
String vdist="";
int count;
%>
<%
String value1=request.getParameter("value1");
String value2=request.getParameter("value2");
String value3=request.getParameter("value3");
String value4=request.getParameter("value4");
String vfhr=request.getParameter("fhr");
String vfmin=request.getParameter("fmin");

if (value1==null){value1="0";}
if (value2==null){value2="0";}
if (value3==null){value3="0";}
if (value4==null){value4="0";}

String vfdate=request.getParameter("vfdate");
String vtdate=request.getParameter("vtdate");

DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());

if(vfdate == null){ 
 vfdate=formattedDate;
// vtdate=formattedDate;
 vfhr="00";
 vfmin="00";
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
<td><input id="fdate"  class="content style1" type="text" name="fdate" size="10" maxlength="10" value=<%=vfdate%>>
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
</td></tr>


 <!-- date selection Ends here -->
<tr><td class="Blue-content" colspan="6" align="left">Select Station</td></tr>
<tr><td class="content style1"><b> State </b></td>
<td>
<select id="state" onchange="parameter()" class="content style1">
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
<select id="district" onchange="parameter()" class="content style1">
<option value="0">--Please Select--</option>
<option value="-1">All</option>
<%
rs=stmt.executeQuery("select param_id as did,group_value as district from parameter where active='Y' and group_family='LOCATION' and Group_name='DISTRICT' and parent_group='"+value1+"'  order by 2");

while(rs.next()){
%>
<option value="<%=rs.getInt("did")%>" ><%=rs.getString("district")%></option>
<% if(rs.getString("did").equals(value2)){%>
<option value="<%=value2%>" selected disabled><%=rs.getString("district")%></option>
<%
		//updating the Audit_table
		count=stmt2.executeUpdate("insert into audit_table values((select user_id from users where user_role="+session.getAttribute("theRole")+" and login_name='"+session.getAttribute("theName")+"'),(select user_role from users where user_role="+session.getAttribute("theRole")+" and login_name='"+session.getAttribute("theName")+"'),'Rainfall at Specific Time','now()')");
  //end of auditing
}
}
%>
</select>
</td></tr>

</table>
</td>
<td valign=top>
<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" >
	<tr><td class="Headings" align="center">Rainfall at Specific Time Report</td></tr>
	
	<% 
	if (!"0".equalsIgnoreCase(value2)||"-1".equalsIgnoreCase(value2)){
	query="select group_value as district from parameter where param_id='"+value2+"'";
	rs=stmt.executeQuery(query);
	while(rs.next()){ vdist="for "+rs.getString(1)+" District at";}
	if ("-1".equalsIgnoreCase(value2)){vdist=" for All Districts at";}
	if (!"".equalsIgnoreCase(vdist)){ %>
	<tr><td class="Red-content" align="center"><%=vdist+" "+vfdate+" "+vfhr+":"+vfmin %></td></tr>
	<%}
	}%>
	<tr><td>
	<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" > 
	<tr class="Blue-content" align="center">
<td>Sl.</td>
<td>ClientID</td>
<td>District</td>
<td>Mandal</td>
<td>Location</td>
<td>Latitude</td>
<td>Longitude</td>
<td>Last Updated<br>before <br>Selected Date/time<br>(24hrs)</td>
<td>Rain (mm)</td>
</tr>


<% if(value1.equalsIgnoreCase("0") & value2.equalsIgnoreCase("0")){%>
<tr><td colspan=7 class="readonly" align="center">Select Date and Location</td><tr>
<%}
else if (!value1.equalsIgnoreCase("0") & !value2.equalsIgnoreCase("0")){

query="select x.clientid,(select group_value from parameter where param_id=district) as district,coalesce((select group_value from parameter where param_id=county),'-') as county,x.location,latitude,longitude,coalesce(y.packet_date,'N/A') as packet_date, y.rain from station_configs_det as x left outer join ";
query=query+" (select a.clientid,to_char(a.packet_date,'mm/dd/yyyy hh24:mi') as packet_date,rain from data_packets a, (select clientid,max(packet_date) as packet_date from data_packets where rain is not null and packet_date between ";
query=query+" to_timestamp('"+vfdate+","+vfhr+":"+vfmin+"','dd/mm/yyyy,hh24:mi') - INTERVAL '24 hours' and  to_timestamp('"+vfdate+","+vfhr+":"+vfmin+"','dd/mm/yyyy,hh24:mi')+INTERVAL '1 SEC' and packet_type='D' group by clientid ) as b where  a.clientid=b.clientid and a.packet_date=b.packet_date and  packet_type='D'  ) as y on (x.clientid=y.clientid) ";
query=query+" where x.clientid not in (6000001,6000002) ";


if(value2.equalsIgnoreCase("0")||value2.equalsIgnoreCase("-1"))
{
	query=query+" and state="+value1;
}
else{
	query=query+" and district='"+value2+"'";
					}
query=query+" order by district,county,location";
//out.println(query);
rs=stmt.executeQuery(query);
	int i=0;
while(rs.next()){
i=i+1;
%>
<tr align ="left" class="readonly">
<td><%=i%></td>
<td><%=rs.getString("clientid")%></td>
<td><%=rs.getString("district")%></td>
<td><%=rs.getString("county")%></td>
<td><%=rs.getString("location")%></td>
<td><%=rs.getString("latitude")%></td>
<td><%=rs.getString("longitude")%></td>
<td><%=rs.getString("packet_date")%></td>
<% if (rs.getString("rain")==null){ %><td align="right">N/A</td><%} else {%><td align="right"><%=rs.getDouble("rain")%></td><%}%>

</tr>
<%
}
}
%>



</table>



	</table>
</td></tr>
</table>

</body>
</html>
