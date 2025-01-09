<%@ page language="java" %>
<%@ page language="java" import="com.ConnectionProvider" %> 
<%@ page import="java.io.*,java.sql.*,java.text.*"%>



<script>

function params(){
var vid1 = document.getElementById("state").value
var vid2 =document.getElementById("district").value
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
var vparam= document.getElementById("param").value
	var vfhr= document.getElementById("fhr").value	
	var vfmin= document.getElementById("fmin").value
	var vthr= document.getElementById("thr").value
	var vtmin= document.getElementById("tmin").value
window.location.replace("reportpercent.jsp?value1="+vid1+"&&value2="+vid2+"&&vfdate="+vfdate+"&&vtdate="+vtdate+"&&fhr="+vfhr+"&&fmin="+vfmin+"&&thr="+vthr+"&&tmin="+vtmin+"&&param="+vparam);
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
String vparam=request.getParameter("param");
	String vfhr=request.getParameter("fhr");
	String vfmin=request.getParameter("fmin");
	String vthr=request.getParameter("thr");
	String vtmin=request.getParameter("tmin");

if (value1==null){value1="0";}
if (value2==null){value2="0";}
if (vparam==null) {vparam="All";}


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
</head>
<body>

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

<!--percentage selection -->
<tr><td class="Blue-content" colspan="6" align="left">Reported
<select id="param" onchange="params()" class="content style1">
<option value="All">All</option>
<option value="90">90</option>
<option value="80">80</option>
<option value="70">70</option>
<option value="60">60</option>
<option value="50">50</option>
<option value="50Lower">50Lower</option>
<option value="NotReporting">NotReporting</option>
<option value=<%=vparam%> selected disabled><%=vparam%></option> 
</select>% </td></tr>

<!--sensor selection -->

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
		count=stmt2.executeUpdate("insert into audit_table values((select user_id from users where user_role="+session.getAttribute("theRole")+" and login_name='"+session.getAttribute("theName")+"'),(select user_role from users where user_role="+session.getAttribute("theRole")+" and login_name='"+session.getAttribute("theName")+"'),'Report By Percentage','now()')");
  //end of auditing
}
}
%>
</select>
</td></tr>
</table>
</td>
<td valign=top>

<table width="100%" border="0" cacellpadding="0" cellspacing="0" id="stretch" > 
	<tr><td class="Headings" align="center" width="80%">Reporting Stations (Percentage)</td></tr>
	<tr><td><br></td></tr>
	<tr><td class="Blue-content" align="center" width="80%">from <%=vfdate%> <%=vfhr%>:<%=vfmin%> Hrs to <%=vtdate%> <%=vthr%>:<%=vtmin%> Hrs</td></tr>



<tr><td colspan=2><table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" > 

<tr class="Blue-content">
<td>Client Id</td><td>District</td><td>Mandal</td><td>Location</td><td>Latitude</td><td>Longitude</td>
<td>Messages<BR>Received</td>
</tr>

<%

//out.println(vparam);
query="select * from (select a.clientid,latitude,longitude,location,(select group_value from parameter where param_id=state) as state,(select group_value from parameter where param_id=district) as district,coalesce((select group_value from parameter where param_id=county),'-') as county , received/(date_part('epoch',((to_timestamp('"+vtdate+","+vthr+":"+vtmin+"','dd/mm/yyyy,hh24:mi')  -to_timestamp('"+vfdate+","+vfhr+":"+vfmin+"','dd/mm/yyyy,hh24:mi') ) ::interval)/60)/datafreq)*100 as received_per from station_configs_det as a left outer join (";

query=query+" select clientid,count(1) as received from data_packets where packet_type='D' and  packet_date >= to_timestamp('"+vfdate+","+vfhr+":"+vfmin+"','dd/mm/yyyy,hh24:mi') and packet_date < to_timestamp('"+vtdate+","+vthr+":"+vtmin+"','dd/mm/yyyy,hh24:mi') and packet_type='D' group by clientid) as b on (a.clientid=b.clientid) where 1=1 ";


if(value2.equalsIgnoreCase("-1")) {	query=query+" and state='"+value1+"') as X ";
	//updating the Audit_table
		count=stmt2.executeUpdate("insert into audit_table values((select user_id from users where user_role="+session.getAttribute("theRole")+" and login_name='"+session.getAttribute("theName")+"'),(select user_role from users where user_role="+session.getAttribute("theRole")+" and login_name='"+session.getAttribute("theName")+"'),'Report By Percentage','now()')");
  //end of auditing
  }
else{ query=query+" and district='"+value2+"') as X ";}

if(vparam.equalsIgnoreCase("50Lower")) {query=query+" where received_per< 50";}
if(vparam.equalsIgnoreCase("NotReporting")) {query=query+" where (received_per=0 or received_per is null)";}

query=query+" order by state,district,county,location";
//out.println(query);

rs=stmt.executeQuery(query);

	while(rs.next()){
%>
<tr  class="readonly">
<td><%=rs.getString("clientid")%></td><td><%=rs.getString("district")%></td><td><%=rs.getString("county")%></td>
<td><%=rs.getString("location")%></td><td><%=rs.getString("latitude")%></td><td><%=rs.getString("longitude")%></td>
<td><%=rs.getInt("received_per")%>%</td>
</tr>
<%} %>
</tr></table>

</table>



	</table>
</td></tr>
</table>
<%
rs.close();
%>

</body>
</html>
