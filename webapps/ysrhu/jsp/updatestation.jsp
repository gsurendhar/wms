
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %> 
<%!
Connection con=null;
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rscnt=null;
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

<html>
<head>
<TITLE> Station Details Update </TITLE>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
String lid=request.getParameter("lid");
String cmd=request.getParameter("action");
String sid=request.getParameter("value1");
String did=request.getParameter("value2");
String cid=request.getParameter("value3");
Integer vdist=0;
Integer vcounty=0;
String vct_name="";
String vdt_name="";
Integer vstate=0;
String voperator="";

con = ConnectionProvider.getCon();
stmt=con.createStatement();
%>
<form action="stnupdatechk.jsp" method="get" Name="updatestn">
<table width="100%" border="0" cellpadding="0" cellspacing="5" id="stretch" > 
<input type="hidden" name="lid" value="<%=lid%>" >


<%
if(cmd.equalsIgnoreCase("update"))
{
//rs1=stmt.executeQuery("select * from station_configs_det where state="+value1+" and district="+value2+" and county="+value3+" and clientid="+value4 );
rs1=stmt.executeQuery("select *,(select group_value from parameter where  param_id=state) as st_name,(select group_value from parameter where  param_id=district) as dt_name,(select group_value from parameter where  param_id=county) as ct_name from station_configs_det where clientid="+lid );
while(rs1.next()){
vstate=rs1.getInt("state");
vdist=rs1.getInt("district");
vcounty=rs1.getInt("county");
vct_name=rs1.getString("ct_name");
vdt_name=rs1.getString("dt_name");
voperator=rs1.getString("operator");
%>

<input type="hidden" name="sid" value="<%=rs1.getString("state")%>" >
<input type="hidden" name="did" value="<%=rs1.getString("district")%>" >

<table width="100%" border="0" cellpadding="1" cellspacing="2" id="stretch" >
<tr><td class="Blue-content">ClientID</td><td><input readonly="read-only" name="txtclientid" class="content style1"  value="<%=rs1.getString("clientid")%>" ></td>
<td class="Blue-content">State</td><td class="content style1"><%=rs1.getString("st_name")%></td>
<td class="Blue-content">District</td><td class="content style1"><%=rs1.getString("dt_name")%></td></tr><tr>

<!-- <td class="Blue-content">Mandal</td><td><input  readonly="read-only" class="content style1"  value="<%=rs1.getString("county")%>"</td></tr> -->

<td class="Blue-content">Location</td><td><input class="content style1" name="txtLocation"  value="<%=rs1.getString("Location")%>" ></td>
<td class="Blue-content">Address</td><td><input  class="content style1" name="txtAddress" value="<%=rs1.getString("address")%>"></td>
<td class="Blue-content">Client Alias</td><td><input class="content style1" name="txtCalias" value="<%=rs1.getString("client_alias")%>"></td></tr>
<tr><td class="Blue-content">Longitude</td><td><input  class="content style1" name="txtLongitude" value="<%=rs1.getString("Longitude")%>" ></td>
<td class="Blue-content">Latitude</td><td><input  class="content style1" name="txtLatitude" value="<%=rs1.getString("Latitude")%>" ></td>
<td class="Blue-content">Altitude</td><td><input  class="content style1" name="txtAltitude" value="<%=rs1.getString("Altitude")%>"></td></tr>
<tr><td class="Blue-content">Station SIM #</td><td><input  class="content style1" name="txtstn_sim" value="<%=rs1.getString("stn_sim")%>" ></td>
<td class="Blue-content">Data Frequency</td><td><input  class="content style1"  name="txtdatafreq" value="<%=rs1.getString("datafreq")%>" ></td>
<td class="Blue-content">Comm Frequency</td><td><input  class="content style1" name="txtcommfreq" value="<%=rs1.getString("commfreq")%>" ></td></tr>

<tr><td class="Blue-content">Wind Averaging</td><td><input  class="content style1"  name="txtwindavg" value="<%=rs1.getString("windavg")%>"></td>
<td class="Blue-content">Rain Calibration</td><td><input  class="content style1"  name="txtcalibrationrain" value="<%=rs1.getString("calibrationrain")%>"></td>
<td class="Blue-content">Wind Calibration</td><td><input  class="content style1"  name="txtcalibrationwind" value="<%=rs1.getString("calibrationwind")%>"></td></tr>
<tr><td class="Blue-content">Server SIM</td><td><input  class="content style1"  name="txtsrv_sim" value="<%=rs1.getString("srv_sim")%>"></td>
<td class="Blue-content">Server Backup SIM1</td><td><input  class="content style1"  name="txtsrv_sim_bkp1" value="<%=rs1.getString("srv_sim_bkp1")%>"></td>
<td class="Blue-content">Server Backup SIM1</td><td><input  class="content style1"  name="txtsrv_sim_bkp2" value="<%=rs1.getString("srv_sim_bkp2")%>"></td></tr>
<!-- <tr><td class="Blue-content">Time 1</td><td><input  class="content style1"  name="txtparamtime1" value="<%=rs1.getString("paramtime1")%>"</td>
<td class="Blue-content">Time 2</td><td><input  class="content style1"  name="txtparamtime2" value="<%=rs1.getString("paramtime2")%>"</td>
<td class="Blue-content">Time 3</td><td><input  class="content style1"  name="txtparamtime3" value="<%=rs1.getString("paramtime3")%>"</td></tr> 
<tr><td class="Blue-content">Future Expansion</td><td><input  class="content style1"  name="txtfutureexpansion" value="<%=rs1.getString("futureexpansion")%>"</td>
<td class="Blue-content">Num Settings</td><td><input  class="content style1"  name="txtnumsettings" value="<%=rs1.getString("numsettings")%>"</td>
<td class="Blue-content">Numbers</td><td><input  class="content style1"  name="txtphnumbers" value="<%=rs1.getString("phnumbers")%>"</td></tr>
<tr><td class="Blue-content">Activate</td><td><input  class="content style1"  name="txtactivate" value="<%=rs1.getString("activate")%>"</td>
<td class="Blue-content">Watchdog</td><td><input  class="content style1"  name="txtwatchdog" value="<%=rs1.getString("watchdog")%>"</td>
<td class="Blue-content">Flash</td><td><input  class="content style1"  name="txtflash" value="<%=rs1.getString("flash")%>"</td></tr>
-->
<tr>
<td class="Blue-content">Contact Person</td><td><input  class="content style1"  name="txtcontact_person" value="<%=rs1.getString("contact_person")%>"></td>

<td class="Blue-content">Contact Phone</td>
		<td><textarea name="txtcontact_phone" rows="4" cols="40" class="readonly" ><%=rs1.getString("contact_phone")%></textarea></td>
<td class="Blue-content">Email</td><td>
			<textarea name="txtemailid" rows="4" cols="50" class="readonly" ><%=rs1.getString("emailid")%></textarea> </td></tr>



<%
	}
%>
<!-- Routine to populate Mandals in Drop down Box-->

	<%
	query="select param_id as cid,group_value as county from parameter where group_family='LOCATION' and Group_name='COUNTY' and parent_group='"+vdist+"'";
	rs=stmt.executeQuery(query);
		%>
<tr><td class="Blue-content"> Mandal </td>
<td>	<select id="county" name="optCounty" class="content style1">
	<option value="0">--Please Select--</option>
	<% while(rs.next()){ %>
	<option value="<%=rs.getInt("cid")%>" ><%=rs.getString("county")%></option>
	<%}%>

	<option value="<%=vcounty%>" selected disabled><%=vct_name%></option>
</select> </td>
<!-- END Routine to populate Mandals in Drop down Box-->

<%
	query="select param_id as did,group_value as district from parameter where group_family='LOCATION' and Group_name='DISTRICT' and parent_group="+vstate;
	rs=stmt.executeQuery(query);
%>
<td class="Blue-content"> District </td>
<td>	<select id="distrinct" name="optDistrict" class="content style1">
	<option value="0">--Please Select--</option>
	<% while(rs.next()){ %>
	<option value="<%=rs.getInt("did")%>" ><%=rs.getString("district")%></option>
	<%}%>
<option value="<%=vdist%>" selected disabled><%=vdt_name%></option>
	
</select> </td>
	
<%
	query="select group_value as operator from PARAMETER where group_family='OPERATOR' and active='Y'";
	rs=stmt.executeQuery(query);
%>
<td class="Blue-content"> SIM Operator </td>
<td>	<select id="operator" name="optOperartor" class="content style1">
	<option value="0">--Please Select--</option>
	<% while(rs.next()){ %>
	<option value="<%=rs.getString("operator")%>" ><%=rs.getString("operator")%></option>
	<%}%>
<option value="<%=voperator%>" selected ><%=voperator%></option>
	
</select> </td>

</tr>

<tr><td colspan="2" align="right"><input type="submit" name="action"  value="save" ></td>
<td colspan="2" align="left"><input type="submit" name="action"  value="cancel" ></td></tr>
<%
}
if(cmd.equalsIgnoreCase("add"))  {

rs1=stmt.executeQuery("select max(clientid)+1 as clientid,(select group_value from parameter where param_id ="+sid+") AS state, (select group_value from parameter where param_id="+did+") as district, (select group_value from parameter where param_id="+cid+") as Mandal from station_configs_det");
%>
<input type="hidden" name="sid" value="<%=sid%>" >
<input type="hidden" name="did" value="<%=did%>" >
<input type="hidden" name="optCounty" value="<%=cid%>" >

<%
while(rs1.next()){
%>
<tr><td class="Blue-content">State</td><td class="content style1"><%=rs1.getString(2)%></td>
<td class="Blue-content">District</td><td class="content style1"><%=rs1.getString(3)%></td>
<td class="Blue-content">Mandal</td><td class="content style1"><%=rs1.getString(4)%></td></tr>
<input type="hidden" name="value4" value="<%=rs1.getString("clientid")%>" >
<tr><td class="Blue-content">ClientID</td><td><input  class="content style1" name="txtclientid" class="content style1"  value="<%=rs1.getString("clientid")%>"></td>
<%} %>
<td class="Blue-content">Location</td><td><input class="content style1" name="txtLocation"  value=""></td>
<td class="Blue-content">Address</td><td><input  class="content style1" name="txtAddress" value=""></td></tr>
<tr><td class="Blue-content">Longitude</td><td><input  class="content style1" name="txtLongitude" value=""></td>
<td class="Blue-content">Latitude</td><td><input  class="content style1" name="txtLatitude" value=""></td>
<td class="Blue-content">Altitude</td><td><input  class="content style1" name="txtAltitude" value=""></td></tr>
<tr><td class="Blue-content">Station SIM #</td><td><input  class="content style1" name="txtstn_sim" value=""></td>
<td class="Blue-content">Data Frequency</td><td><input  class="content style1"  name="txtdatafreq" value=""></td>
<td class="Blue-content">Comm Frequency</td><td><input  class="content style1" name="txtcommfreq" value=""></td></tr>
<tr><td class="Blue-content">Wind Averaging</td><td><input  class="content style1"  name="txtwindavg" value=""></td>
<td class="Blue-content">Rain Calibration</td><td><input  class="content style1"  name="txtcalibrationrain" value=""></td>
<td class="Blue-content">Wind Calibration</td><td><input  class="content style1"  name="txtcalibrationwind" value=""></td></tr>
<tr><td class="Blue-content">Server SIM</td><td><input  class="content style1"  name="txtsrv_sim" value=""></td>
<td class="Blue-content">Server Backup SIM1</td><td><input  class="content style1"  name="txtsrv_sim_bkp1" value=""></td>
<td class="Blue-content">Server Backup SIM1</td><td><input  class="content style1"  name="txtsrv_sim_bkp2" value=""></td></tr>
<!-- <tr><td class="Blue-content">Time 1</td><td><input  class="content style1"  name="txtparamtime1" value=""</td>
<td class="Blue-content">Time 2</td><td><input  class="content style1"  name="txtparamtime2" value=""</td>
<td class="Blue-content">Time 3</td><td><input  class="content style1"  name="txtparamtime3" value=""</td></tr>
<tr> <td class="Blue-content">Future Expansion</td><td><input type="hidden" class="content style1"  name="txtfutureexpansion" value="1"</td>
<td class="Blue-content">Num Settings</td><td><input type="hidden" class="content style1"  name="txtnumsettings" value="1"</td>
<td class="Blue-content">Numbers</td><td><input type="hidden" class="content style1"  name="txtphnumbers" value="1"</td></tr>
<tr><td class="Blue-content">Activate</td><td><input  class="content style1"  name="txtactivate" value=""</td>

 <td><select id="txtactivate"  name="txtactivate" class="content style1">
	<option value=1 ><%="Yes"%></option>
	<option value=0 ><%="No"%></option>
</select> </td>
<td class="Blue-content">Watchdog</td>
<td><select id="txtwatchdog"  name="txtwatchdog" class="content style1">
	<option value=1 ><%="Yes"%></option>
	<option value=0 ><%="No"%></option>
</select> </td>
<td class="Blue-content">Flash</td>
<td><select id="txtflash" name="txtflash"  class="content style1">
	<option value=1 ><%="Yes"%></option>
	<option value=0 ><%="No"%></option>
</select> </td></tr>
 -->
<tr><td class="Blue-content">Contact Person</td><td><input  class="content style1"  name="txtcontact_person" value=""></td>
<td class="Blue-content">Contact Phone</td><td><input  class="content style1"  name="txtcontact_phone" value=""></td>
<td class="Blue-content">Email</td><td><input  class="content style1"  name="txtemailid" value=""></td></tr>



<%
	query="select group_value as operator from PARAMETER where group_family='OPERATOR' and active='Y'";
	rs=stmt.executeQuery(query);
%>
<tr><td class="Blue-content"> SIM Operatpr </td>
<td>	<select id="operator" name="optOperartor" class="content style1">
	<option value="0">--Please Select--</option>
	<% while(rs.next()){ %>
	<option value="<%=rs.getString("operator")%>" ><%=rs.getString("operator")%></option>
	<%}%>
<option value="<%=voperator%>" selected ><%=voperator%></option>
	
</select> </td></tr>

<tr><td colspan="2" align="right"><input type="submit" name="action"  value="insert" ></td>
<td colspan="2" align="left"><input type="submit" name="action"  value="cancel" ></td></tr>
<%
  }
  
%>
</table>
</form>
</body>
</html>