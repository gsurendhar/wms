<%@ page import="java.sql.*" %>
<%@ page language="java" %>
<%@ page import="java.io.*,java.text.*"%>
<%@page import="java.util.*"%>


<%@page import="com.locationDao"%>
<%@page import="com.locationBean"%>
<jsp:useBean id="obj" class="com.locationBean"/>
<jsp:setProperty property="*" name="obj"/>


<%@page import="com.datapacketsDao"%>
<%@page import="com.datapacketsBean"%>
<jsp:useBean id="objDP" class="com.datapacketsBean"/>
<jsp:setProperty property="*" name="objDP"/>

  




<%
locationDao location = new locationDao();
datapacketsDao dp = new datapacketsDao();

String value1=request.getParameter("value1");
String value2=request.getParameter("value2");
String value3=request.getParameter("value3");
String value4=request.getParameter("value4");
String search=request.getParameter("search");
if (search==null){search="0";}

if (!search.equalsIgnoreCase("0")){
	obj.setLocation_id(Integer.parseInt(search));
	locationDao loc = new locationDao();
	loc.searchLocation(obj);
	int Location_id=obj.getLocation_id();
	String Lname=obj.getLname();
		value1=String.valueOf(obj.getStateid());
		value2=String.valueOf(obj.getDistrict_id());
		value3=String.valueOf(obj.getCounty_id());
		value4=String.valueOf(obj.getLocation_id());
	}


if (value1==null){value1="0";}
if (value2==null){value2="0";}
if (value3==null){value3="0";}
if (value4==null){value4="0";}
if (!value4.equalsIgnoreCase("0")){search=value4;}



String vfdate=request.getParameter("vfdate");
String vtdate=request.getParameter("vtdate");

DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());
//out.println(formattedDate);

if(vfdate == null){ 
 vfdate=formattedDate;
 vtdate=formattedDate;
}


%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reports</title>

<link href="../styles/text.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../Script/datepicker.js"></script>

<script>
function parameter(){
var vid1 = document.getElementById("state").value
		if (vid1==null || vid1==""){vid1=0;}
var vid2 = document.getElementById("district").value
		if (vid2==null || vid2==""){vid2=0;}
var vid3 = document.getElementById("county").value
		if (vid3==null || vid3==""){vid3=0;}
var vid4 = document.getElementById("location").value
		if (vid4==null || vid4==""){vid4=0;}
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
window.location.replace("packets.jsp?value1="+vid1+"&&value2="+vid2+"&&value3="+vid3+"&&value4="+vid4+"&&vfdate="+vfdate+"&&vtdate="+vtdate);
}

function search(){
var vid1 = document.getElementById("txtSearch").value
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
window.location.replace("packets.jsp?search="+vid1+"&&vfdate="+vfdate+"&&vtdate="+vtdate);
}

</script>

</head>
<body>

	  
<table width="100%">
<tr>
	<td width="10%" VALIGN=TOP>
	<table width="10%" class="border" >
		<tr><td class="Blue-content" colspan="4"><b>Select Date Range</b></td></tr>
		<tr><td class="content style1" align="right"><b>From</b></td>
		<td><input id="fdate"  class="content style1" type="text" name="fdate" size="10" maxlength="12" value=<%=vfdate%>>
		<a href="javascript:NewCal('fdate','ddmmyyyy',false)"><img src="../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a></td>
		</tr>
		<tr><td class="content style1" align="right"><b>To</b></td>
		<td><input id="tdate"  class="content style1" type="text" name="tdate" size="10" maxlength="12" value=<%=vtdate%>>
		<a href="javascript:NewCal('tdate','ddmmyyyy',false)"><img src="../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a></td>
		</tr>
		<tr><td class="Blue-content" colspan="6" align="left">Select Station</td></tr>
		<tr><td class="content style1"><b> StationID </b></td><td><input type=text id=txtSearch name=txtSearch  class="content style1" value="<%=search%>" size="5">
		<input class="content style1" type="submit" value="Search" onClick="search()"></td>
		</tr>

		<tr><td class="content style1"><b> State </b></td>
			<td>
				<select id="state" onchange="parameter()" class="content style1">
				<option value="0">--Please Select--</option>
					<% 
					List<locationBean> list1 =location.viewStates();
					Iterator<locationBean> S = list1.iterator(); 
					while (S.hasNext()) {
					obj = (locationBean)S.next();
					%>
					<option value="<%=obj.getStateid()%>"><%=obj.getSname()%></option>
					<% if(obj.getStateid()==Integer.parseInt(value1)){%>
					<option value="<%=value1%>" selected ><%=obj.getSname()%></option> 
					<%} 
							}%>
				</select>
			</td>
		</tr>

		<tr><td class="content style1"><b> District</b> </td>
			<td>
				<select id="district" onchange="parameter()" class="content style1">
				<option value="0">--Please Select--</option>
							<% 
							List<locationBean> list2 =location.viewDistrict(Integer.parseInt(value1));
							Iterator<locationBean> D = list2.iterator(); 
							while (D.hasNext()) {
							obj = (locationBean)D.next();
							%>
							<option value="<%=obj.getDistrict_id()%>" ><%=obj.getDname()%></option>
							<% if(obj.getDistrict_id()==Integer.parseInt(value2)){%>
							<option value="<%=value2%>" selected ><%=obj.getDname()%></option>
							<%}
									}%>
				
				</select>
			</td>
		</tr>

		<tr><td class="content style1"><b>Mandal</b> </td>
			<td>
				<select id="county" onchange="parameter()" class="content style1">
				<option value="0">--Please Select--</option>
				<%
							List<locationBean> list3 =location.viewCounty(Integer.parseInt(value2));
							Iterator<locationBean> C = list3.iterator(); 
							while (C.hasNext()) {
								obj = (locationBean)C.next();
							%>
						<option value="<%=obj.getCounty_id()%>" ><%=obj.getCname()%></option>
						<% if(obj.getCounty_id()==Integer.parseInt(value3)){%>
						<option value="<%=value3%>" selected ><%=obj.getCname()%></option>
						<%}
						}%>
				
				</select>
			</td>
		</tr>

		<tr><td class="content style1"><b> Stations</b> </td>
			<td>
				<select id="location" onchange="parameter()" class="content style1" size="20">
					<option value="0">--Please Select--</option>
					<%
							List<locationBean> list4;		
							
							if(value3.equalsIgnoreCase("0")) {
								list4 =location.viewStations(Integer.parseInt(value1),Integer.parseInt(value2));
								}
							else{
								list4 =location.viewStations(Integer.parseInt(value1),Integer.parseInt(value2),Integer.parseInt(value3));
								}	
								Iterator<locationBean> V = list4.iterator(); 
								while (V.hasNext()) {
									obj = (locationBean)V.next();
								%>
							<option value="<%=obj.getLocation_id()%>" ><%=obj.getLname()%></option>
							<% if(obj.getLocation_id()==Integer.parseInt(value4)){%>
							<option value="<%=value3%>" selected ><%=obj.getLname()%></option>
							<%}
							}%>
					
				</select>
			</td>
		</tr>
	</table>
	</td>
	<td valign=top>
		<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" > 
			<tr><td class="Blue-content">Date Time</td>
				<td class="Blue-content">Rain (mm)</td><td class="Blue-content">Temparature(&ordm; C)</td><td class="Blue-content">Wind</td>
				<td class="Blue-content">Wind<br> Direction</td><td class="Blue-content">Humidity</td><td class="Blue-content">Local Pressure</td><td class="Blue-content">MSLP</td>
			</tr>
			<% 
			if(!value4.equalsIgnoreCase("0")) {
				Float vrain  = null;
				Float vtemp  = null;
				Float vwind  = null;
				Float vwind_direction  = null;
				Float vhumidity  = null;
				Float vlocal_pressure  = null;
				Float vmslp  = null;
				
			List<datapacketsBean> listP = dp.viewPackets(Integer.parseInt(value4), vfdate, vtdate);
						Iterator<datapacketsBean> DP = listP.iterator(); 
					while (DP.hasNext()) {
					objDP = (datapacketsBean)DP.next();
					vrain = objDP.getRain();
					vtemp = objDP.getTemp();
					vwind = objDP.getWind();
					vwind_direction = objDP.getWind_direction();
					vhumidity = objDP.getHumidity();
					vlocal_pressure = objDP.getLocal_pressure();
					vmslp = objDP.getMslp();
					
			%>
			<tr>
		<!-- <td class="readonly"><a href="packetedit.jsp?v1=<%=objDP.getStation_id()%>&&v2=<%=objDP.getPacketno()%>&&v3=<%=objDP.getDtime()%>" target="_blank" class="Blue-content"><%=objDP.getDtime()%></a></td>
		 -->
				<td class="readonly" class="Blue-content"><%=objDP.getDtime()%></td>
				<td class="readonly"><% if (vrain == null){ %>N/A<%} else {%><%=vrain%><%}%></td>
				<td class="readonly"><% if (vtemp == null){ %>N/A<%} else {%><%=vtemp%><%}%></td>
				<td class="readonly"><% if (vtemp == null){ %>N/A<%} else {%><%=vtemp%><%}%></td>
				<td class="readonly"><% if (vwind == null){ %>N/A<%} else {%><%=vwind%><%}%></td>
				<td class="readonly"><% if (vhumidity == null){ %>N/A<%} else {%><%=vhumidity%><%}%></td>
				<td class="readonly"><% if (vlocal_pressure == null){ %>N/A<%} else {%><%=vlocal_pressure%><%}%></td>
				<td class="readonly"><% if (vmslp == null){ %>N/A<%} else {%><%=vmslp%><%}%></td>
				
				
			</tr>
				<%} 
					}%>
		</table>
	</td>
</tr>
</table>
  
</body>
</html>
