
<%@ page language="java" %>
<%@ page import="java.io.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*"%>

<%@page import="com.locationDao"%>
<%@page import="com.locationBean"%>
<jsp:useBean id="obj" class="com.locationBean"/>
<jsp:setProperty property="*" name="obj"/>


<script>

function getDistrict(){
	var vid1 = document.getElementById("state").value;
	window.location.replace("StationMaint.jsp?value1="+vid1);
}

function getCounty(){
	var vid1 = document.getElementById("state").value;
	var vid2 = document.getElementById("district").value;
	window.location.replace("StationMaint.jsp?value1="+vid1+"&&value2="+vid2);
}


function getLocations(){
	var vid1 = document.getElementById("state").value;
	var vid2 = document.getElementById("district").value;
	var vid3 = document.getElementById("county").value;
	window.location.replace("StationMaint.jsp?value1="+vid1+"&&value2="+vid2+"&&value3="+vid3);
	}

function getStation(){
	var vid1 = document.getElementById("state").value;
	var vid2 = document.getElementById("district").value;
	var vid3 = document.getElementById("county").value;
	var vid4 = document.getElementById("location").value;
window.location.replace("StationMaint.jsp?value1="+vid1+"&&value2="+vid2+"&&value3="+vid3+"&&value4="+vid4);
}

function search(){
	var vid1 = document.getElementById("txtSearch").value;
	window.location.replace("StationMaint.jsp?search="+vid1);
}

</script>


<%

locationDao location = new locationDao();

String value1=request.getParameter("value1");
String value2=request.getParameter("value2");
String value3=request.getParameter("value3");
String value4=request.getParameter("value4");
String search=request.getParameter("txtSearch");
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

String mid=request.getParameter("mid");
if (mid != null){	
%>
<script>
	alert('Sending Message');
</script>
<%
locationDao updateLoc = new locationDao();
//updateLoc.SendMaintCmd(Integer.parseInt(value4),Integer.parseInt(mid));
}


if (value1==null){value1="0";}
if (value2==null){value2="0";}
if (value3==null){value3="0";}
if (value4==null){value4="0";}
if (search==null){search="0";}

mid="";

%>
<html>
<head>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
</head>
<body>
<form action="StationMaint.jsp" method="post" name="frmrSearch" >

<table  Style="width:100%;">
<tr><td width="10%" VALIGN=TOP>
	<table class="border">
		<tr><td class="Blue-content" colspan="6" align="left">Select Station</td></tr>
		<tr><td class="content style1"><b> ID </b></td><td><input type=text id=txtSearch name=txtSearch  class="content style1" value="<%=search%>" size="5">
		<button type="submit" class="button-image" id="act" name="act" value="Find"> <img src="../images/icon_search.png"  height="20" width="20" alt="Search" /></button>
		</tr>

		<tr><td class="content style1"><b> State </b></td>
			<td>
				<select id="state" onchange="getDistrict()" class="content style1">
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
				<select id="district" onchange="getCounty()" class="content style1">
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
				<select id="county" onchange="getLocations()" class="content style1">
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
				<select id="location" onchange="getStation()" class="content style1" size="20">
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

	<%
	if (!value4.equalsIgnoreCase("0")){
		obj.setLocation_id(Integer.parseInt(value4));
		locationDao loc = new locationDao();
		loc.searchLocation(obj);
	%>
  <td width="80%" VALIGN=TOP>
		<table    Style="width:100%;">
				<tr><td class="Blue-content">ID</td><td><input type=text  class="readonly" name="value4" size="7" value="<%=obj.getLocation_id()%>"></td>
					<td class="Blue-content">District</td><td class="readonly"><%=obj.getDname()%></td>
					<td class="Blue-content">Mandal</td><td class="readonly"><%=obj.getCname()%></td>
				</tr>
				<tr><td class="Blue-content">Location</td><td class="readonly"><%=obj.getLname()%></td>	
					<td class="Blue-content">Station SIM #</td><td class="readonly"><%=obj.getStn_sim()%></td>
					<td class="Blue-content">Server SIM</td><td class="readonly"><%=obj.getSrv_sim()%></td>
				</tr>
				<tr><td class="Blue-content">Contact Person</td><td class="readonly"><%=obj.getCname()%></td>
					<td class="Blue-content">Email</td><td class="readonly"><%=obj.getCemail()%></td>
					<td class="Blue-content">Last Reported</td><td class="readonly" ><%=obj.getLsignal()%></td>
				</tr>
		</table>
<%
} 
if (!"0".equalsIgnoreCase(value4)){
	%>
<table   class=border Style="width:100%;">
	<tr class="Blue-content"><td>ID</td><td>Task</td><td>Command</td><td>Send<br>SMS</td></tr>
<% 
locationDao cmd = new locationDao();
List<locationBean> cmdlist =cmd.getMaintCmd();
Iterator<locationBean> CL = cmdlist.iterator(); 

while (CL.hasNext()) {
obj = (locationBean)CL.next();
%>
	<tr class="readonly">
			<td><%=obj.getCmd_id()%></td><td><%=obj.getCmd_desc()%></td><td><%=obj.getCmd()%></td>
			<td><button type="submit" class="button-image" id="mid" name="mid" value="<%=obj.getCmd_id()%>" > <img src="../images/icon_send.png"  height="20" width="20" alt="Cancel" /></button>
			</td>
		</tr>
	
<%} %>
	<tr><td colspan="2" align="center"><a href="commlog.jsp?v1=<%=value4%>" target="_blank" class="Blue-content">Communication Log</a></td>
<%}%>

</table>
</td></tr>

</table>

</form>

</body>
</html>
