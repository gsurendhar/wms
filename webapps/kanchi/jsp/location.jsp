<%@ page language="java" %>
<%@ page import="java.io.*,java.text.*"%>
<%@page import="java.util.*"%>

<%@page import="com.locationDao"%>
<%@page import="com.locationBean"%>
<jsp:useBean id="obj" class="com.locationBean"/>
<jsp:setProperty property="*" name="obj"/>



  
<% 
//Sesssion Management
if(null == session.getAttribute("theName")){  
   response.sendRedirect("timeout.jsp");
}
%>

<%
Integer oid	= (Integer) session.getAttribute("theOid");

String state=request.getParameter("state");
String dist=request.getParameter("dist");
String county=request.getParameter("county");

if (state==null){state="0";}
if (dist==null){dist="0";}
if (county==null){county="0";}

int vstateid=Integer.parseInt(state);
int vdistid=Integer.parseInt(dist);
//int vcountyid=Integer.parseInt(county);

String lid=request.getParameter("lid");
String act=request.getParameter("act");
locationDao location = new locationDao();




%>
<html>
<head>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../Script/datepicker.js"></script>
<BODY bgcolor="#DBEBFF">

<script>
function params(){
	var vid1 = document.getElementById("state").value;
	var vid2 =document.getElementById("dist").value;
	var vid3 =document.getElementById("county").value;
	//alert(vid1);
	window.location.replace("location.jsp?state="+vid1+"&&dist="+vid2+"&&county="+vid3);
	}
</script>


</head>
<body>
<% if ("Add".equalsIgnoreCase(act)){ %>
<form name="FrmAddloc" action="location.jsp" method="post">
<table width="100%" border="0" cellpadding="1" >
<tr>
			<td  align="right" colspan="2">
			<button type="submit" class="button-image" name="act" value="Insert"> <img src="../images/icon_save.png"  height="30" width="30" alt="Add" /></button>
			<button type="submit" class="button-image" name="act" value="Edit"> <img src="../images/icon_edit.png"  height="30" width="30" alt="Add" /></button>
			<button type="submit" class="button-image" name="act" value="Delete"> <img src="../images/icon_delete.png"  height="30" width="30" alt="Add" /></button>
			</td>
</tr>

<tr><td width="10%" VALIGN=TOP>
	<table width="100%" class="border"  cellpadding="1" >
	<tr><td class="Blue-content" colspan="6" align="left">Select</td></tr>
	<tr><td class="label"><b> State </b></td>
		<td><select id="state" name=state onchange="params()" class="content style1">
			<option value="0">--Please Select--</option>
			<% 
			List<locationBean> list1 =location.viewStates();
			Iterator<locationBean> S = list1.iterator(); 
			while (S.hasNext()) {
			obj = (locationBean)S.next();
			%>
			<option value="<%=obj.getStateid()%>"><%=obj.getSname()%></option>
			<% if(obj.getStateid()==vstateid){%>
			<option value="<%=vstateid%>" selected ><%=obj.getSname()%></option> 
						<%} 
								}%>
			</select> </td>
	<td class="label"><b> District</b> </td>
		<td><select id="dist" name=dist onchange="params()" class="content style1">
			<option value="0">--Please Select--</option>
			<% 
			List<locationBean> list2 =location.viewDistrict(vstateid);
			Iterator<locationBean> D = list2.iterator(); 
			while (D.hasNext()) {
			obj = (locationBean)D.next();
			%>
			<option value="<%=obj.getDistrict_id()%>" ><%=obj.getDname()%></option>
			<% if(obj.getDistrict_id()==vdistid){%>
			<option value="<%=vdistid%>" selected ><%=obj.getDname()%></option>
			<%}
					}%>
		</select></td>
		<td class="label"><b> Mandal</b> </td>
		<td><select id="county" name=county onchange="" class="content style1">
		<option value="0">--Please Select--</option>
			<%
			List<locationBean> list3 =location.viewCounty(vdistid);
			Iterator<locationBean> C = list3.iterator(); 
			while (C.hasNext()) {
				obj = (locationBean)C.next();
			%>
		<option value="<%=obj.getCounty_id()%>" ><%=obj.getCname()%></option>
		<% 	}%>
		</select>
		</td></tr>
	</table> 
	</td></tr>
	<tr><td Align="center">
	<table width="75%" border="0" cellpadding="0" cellspacing="5" id="stretch" > 
		<tr class="label"><td width="10%">Location</td><td><input type="text" class="content style1" size="50" id="txtName" name=txtName value="" /></td></tr>
		<tr><td class="label">Latitude</td><td><input type="text" class="content style1" id="txtlat" size="10" name=txtLat value="0" /></td></tr>
		<tr><td class="label">Longitude</td><td><input type="text" class="content style1" id="txtLong" size="10" name=txtLong value="0" /></td></tr>
		<tr><td class="label">Altitude</td><td><input type="text" class="content style1" id="txtAlt" size="10" name=txtAlt value="0" /></td></tr>
	</table>
	</td></tr>
</table>
</form>

<%} else if ("Edit".equalsIgnoreCase(act)){ 
		if (lid==null){ %>
	<script>
	alert("no record selected!");
	 history.go(-1);
	</script>
	<%} else { 
	
	obj.setLocation_id(Integer.parseInt(lid));
	locationDao loc = new locationDao();
	loc.searchLocation(obj);
	int Location_id=obj.getLocation_id();
	String Lname=obj.getLname();
	vstateid=obj.getStateid();
	vdistid=obj.getDistrict_id();
	//vcountyid=obj.getCounty_id();
	String Lat = obj.getLat();
	String Lon = obj.getLon();
	String Alt = obj.getAlt();
	%>
<form name="FrmEditloc" action="location.jsp" method="post">
<input type="hidden" name="lid" value="<%=Location_id%>" />

<table width="100%" border="0" cellpadding="1" >
<tr>
			<td  align="right" colspan="2">
			<button type="submit" class="button-image" name="act" value="Update"> <img src="../images/icon_save.png"  height="30" width="30" alt="Add" /></button>
			<button type="submit" class="button-image" name="act" value="Edit"> <img src="../images/icon_edit.png"  height="30" width="30" alt="Add" /></button>
			<button type="submit" class="button-image" name="act" value=refresh> <img src="../images/icon_refresh.png"  height="30" width="30" alt="reset" /></button>
			</td>
</tr>

<tr><td width="10%" VALIGN=TOP>
	<table width="100%" class="border"  cellpadding="1" >
	<tr><td class="Blue-content" colspan="6" align="left">Select</td></tr>
	<tr><td class="label"><b> State </b></td>
		<td><select id="state" name=state onchange="params()" class="content style1">
			<option value="0">--Please Select--</option>
			<% 
			List<locationBean> list1 =location.viewStates();
			Iterator<locationBean> S = list1.iterator(); 
			while (S.hasNext()) {
			obj = (locationBean)S.next();
			%>
			<option value="<%=obj.getStateid()%>"><%=obj.getSname()%></option>
			<% if(obj.getStateid()==vstateid){%>
			<option value="<%=vstateid%>" selected ><%=obj.getSname()%></option> 
							<%						} 
								}%>
			</select> </td>
	<td class="label"><b> District</b> </td>
		<td><select id="dist" name=dist onchange="params()" class="content style1">
			<option value="0">--Please Select--</option>
			<% 
			List<locationBean> list2 =location.viewDistrict(vstateid);
			Iterator<locationBean> D = list2.iterator(); 
			while (D.hasNext()) {
			obj = (locationBean)D.next();
			%>
			<option value="<%=obj.getDistrict_id()%>" ><%=obj.getDname()%></option>
			<% if(obj.getDistrict_id()==vdistid){%>
			<option value="<%=vdistid%>" selected ><%=obj.getDname()%></option>
			<%}
					}%>
			</select></td><td class="label"><b> Mandal</b> </td>
		<td><select id="county" name=county class="content style1">
		<option value="0">--Please Select--</option>
			<%
			List<locationBean> list3 =location.viewCounty(vdistid);
			Iterator<locationBean> C = list3.iterator(); 
			while (C.hasNext()) {
				obj = (locationBean)C.next();
			%>
		<option value="<%=obj.getCounty_id()%>" ><%=obj.getCname()%></option>
		<% 	}%>
		</select>
		</td></tr>
	</table> 
	</td></tr>
	<tr><td Align="center">
	<table width="75%" border="0" cellpadding="0" cellspacing="5" id="stretch" > 
		<tr class="label"><td width="10%">Location</td><td><input type="text" class="content style1" size="50" id="txtName" name=txtName value="<%=Lname%>" /></td></tr>
		<tr><td class="label">Latitude</td><td><input type="text" class="content style1" id="txtlat" size="10" name=txtLat value="<%=Lat%>" /></td></tr>
		<tr><td class="label">Longitude</td><td><input type="text" class="content style1" id="txtLong" size="10" name=txtLong value="<%=Lon%>" /></td></tr>
		<tr><td class="label">Altitude</td><td><input type="text" class="content style1" id="txtAlt" size="10" name=txtAlt value="<%=Alt%>" /></td></tr>
	</table>
	</td></tr>

</table>
</form>


<%}
	} else if ("mAdd".equalsIgnoreCase(act)){ 
				
		String Vmandal = request.getParameter("txtMandal");
		if ((Vmandal == null)||("".equalsIgnoreCase(Vmandal))){ }
		else {	location.addCounty(request.getParameter("txtMandal"),vdistid); }
	
	%>
	<form name="FrmAddMandal" action="location.jsp" method="post">
	<table width="100%" border="0" cellpadding="2" >
	
	<tr><td width="10%" VALIGN=TOP>
	<table width="80%" class="border"  cellpadding="1">
	<tr><td class="label"><b> State</b></td><td class="label"><b> District</b></td><td class="label"><b> Mandal</b></td></tr>
	<tr><td valign="top"><select id="state" name=state onchange="params()" class="content style1">
			<option value="0">--Please Select--</option>
			<% 
			List<locationBean> list1 =location.viewStates();
			Iterator<locationBean> S = list1.iterator(); 
			while (S.hasNext()) {
			obj = (locationBean)S.next();
			%>
			<option value="<%=obj.getStateid()%>"><%=obj.getSname()%></option>
			<% if(obj.getStateid()==vstateid){%>
			<option value="<%=vstateid%>" selected><%=obj.getSname()%></option> 
							<%						} 
								}%>
			</select> 
			</td>
	<td valign="top"> 
	<select id="dist" name=dist onchange="params()" class="content style1">
			<option value="0">--Please Select--</option>
			<% 
			List<locationBean> list2 =location.viewDistrict(vstateid);
			Iterator<locationBean> D = list2.iterator(); 
			while (D.hasNext()) {
			obj = (locationBean)D.next();
			%>
			<option value="<%=obj.getDistrict_id()%>" ><%=obj.getDname()%></option>
			<% if(obj.getDistrict_id()==vdistid){%>
			<option value="<%=vdistid%>" selected ><%=obj.getDname()%></option>
			<%}
					}%>
			</select>
			</td>
		
			<td> 
			<td>
			<select id="county" name=county  size="26" style="width: 140px;" class="content style1">
			<%
			List<locationBean> list3 =location.viewCounty(vdistid);
			Iterator<locationBean> C = list3.iterator(); 
			while (C.hasNext()) {
				obj = (locationBean)C.next();
			%>
			<option value="<%=obj.getCounty_id()%>" ><%=obj.getCname()%></option>
			<% 	}%>
			</select></td>
		<tr><td class="label" > Mandal </td><td><input class="Blue-content" type=text name="txtMandal" size="30"  maxlength="50" >
			<button type="submit" class="button-image" name="act" value="mAdd"> <img src="../images/icon_save.png"  height="30" width="30" alt="Mandal Add" /></button>
			
		</tr>
		
		
	</table>		
	</table>
	</form>
		
<%} else if (act==null || ("".equalsIgnoreCase(act))||("Search".equalsIgnoreCase(act)) ||("Update".equalsIgnoreCase(act)) || ("Cancel".equalsIgnoreCase(act))||
	("Insert".equalsIgnoreCase(act))||("Delete".equalsIgnoreCase(act))){
		if ("Insert".equalsIgnoreCase(act)){
			obj.setLname(request.getParameter("txtName"));
            obj.setLat(request.getParameter("txtLat"));
            obj.setLon(request.getParameter("txtLong"));
            obj.setAlt(request.getParameter("txtAlt"));
            obj.setStateid(vstateid);
            obj.setDistrict_id(vdistid);
            //obj.setCounty_id(vcountyid);
			//location.addLocation(obj);
			}	
		if ("Delete".equalsIgnoreCase(act)){
					if (lid==null){ %>
					<script>
						alert("no record selected!");
						history.go(-1);
					</script>
				<% } else {
				int id=Integer.parseInt(lid);
				location.delLocation(id);} 
			}
		
		if ("Update".equalsIgnoreCase(act)){
			int id=Integer.parseInt(lid);
			obj.setLocation_id(id);
			obj.setLname(request.getParameter("txtName"));
            obj.setLat(request.getParameter("txtLat"));
            obj.setLon(request.getParameter("txtLong"));
            obj.setAlt(request.getParameter("txtAlt"));
            obj.setStateid(vstateid);
            obj.setDistrict_id(vdistid);
            //obj.setCounty_id(vcountyid);
			
			}
		
%>	
<form name="Frmlistloc" action="location.jsp" method="post">

	<table  width="80%"  align="center" cellpadding="0" >
	<tr><td>&nbsp;</td></tr>
	<tr><td class="label"><b> State</b></td><td class="label"><b> District</b></td><td class="label"><b> Mandal</b>
	<% if (vdistid!=0){ %>
			<button type="submit" class="button-image" name="act" value="mAdd"> <img src="../images/icon_add.png"  height="20" width="20" alt="State Add" /></button>
			<%}%>
	</td></tr>
	<tr><td VALIGN=TOP>
			<select id="state" name=state onchange="params()" class="content style1">
			<option value="0">--Please Select--</option>
			<% 
			List<locationBean> list1 =location.viewStates();
			Iterator<locationBean> S = list1.iterator(); 
			while (S.hasNext()) {
			obj = (locationBean)S.next();
			%>
			<option value="<%=obj.getStateid()%>"><%=obj.getSname()%></option>
			<% if(obj.getStateid()==vstateid){%>
			<option value="<%=vstateid%>" selected><%=obj.getSname()%></option> 
							<%						} 
								}%>
			</select> 
		</td>
		<td VALIGN=TOP>
	 		<select id="dist" name=dist onchange="params()" class="content style1">
			<option value="0">--Please Select--</option>
			<% 
			List<locationBean> list2 =location.viewDistrict(vstateid);
			Iterator<locationBean> D = list2.iterator(); 
			while (D.hasNext()) {
			obj = (locationBean)D.next();
			%>
			<option value="<%=obj.getDistrict_id()%>" ><%=obj.getDname()%></option>
			<% if(obj.getDistrict_id()==vdistid){%>
			<option value="<%=vdistid%>" selected ><%=obj.getDname()%></option>
			<%}
					}%>
			</select>
		</td>
		<td>
			<select id="county" name=county  size="26" style="width: 140px;" class="content style1">
			<%
			List<locationBean> list3 =location.viewCounty(vdistid);
			Iterator<locationBean> C = list3.iterator(); 
			while (C.hasNext()) {
				obj = (locationBean)C.next();
			%>
			<option value="<%=obj.getCounty_id()%>" ><%=obj.getCname()%></option>
			<% 	}%>
			</select>
			
		</td>
		</tr>
	</table>
</form>
<%}%>

</body>
</html>
