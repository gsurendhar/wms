
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="wms.dbconnect.DBPostgres" %> 
<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
String query="";
ResultSetMetaData md;
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
<TITLE> Station Statistics </TITLE>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
</head>
<body>
<form action="packetedit.jsp" method="post" name="frmentry" >
<%
con = DBPostgres.getConnection();
stmt=con.createStatement();
String value1=request.getParameter("v1");
String value2=request.getParameter("v2");
String value3=request.getParameter("v3");
String act = request.getParameter("act"); 
	//out.println(act);

if ("Save".equalsIgnoreCase(act) ) { 
	String vrain=request.getParameter("txtRain");
	String vtemp=request.getParameter("txtTemp");
	String vwind=request.getParameter("txtWind");
	String vwinddir=request.getParameter("txtWinddirection");
	String vhumidity=request.getParameter("txtHumidity");
	String vpressure=request.getParameter("txtPressure");

	query="update data_packets set rain="+vrain+",temp="+vtemp+",wind="+vwind+",humidity="+vhumidity+",local_pressure="+vpressure+" where clientid='"+value1+"' and packetno='"+value2+"' and packet_date=to_timestamp('"+value3+"','DD/MM/YY HH24:MI:SS')";
	//out.println(query);
	stmt.executeUpdate(query);	
	act="";
}
	

		%>

<table width="100%" border="0" cellpadding="0" cellspacing="0" id="stretch"> 
<tr height="100%" valign="center"> 
<td colspan="2" valign="center" height="100%">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF"> 
		<tr><td height="100%" align="left" valign="bottom" scope="col">
		<!-- <a href="#"> -->
		<img src="../images/Logo.jpg" width="100" height="50">
		<!-- </a> -->
		</td></tr>
		<tr><td background="../images/Logo_bottom.jpg" scope="col"><img src="../images/Logo_bottom.jpg" width="3" height="4"></td></tr>
	</table>
</td>
</table>


<%

rs=stmt.executeQuery("select to_char(packet_date,'DD/MM/YY HH24:MI') as date,clientid,packetno,rain,temp,wind,wind_direction,mslp,humidity,local_pressure from data_packets where clientid='"+value1+"' and packetno='"+value2+"' and packet_date=to_timestamp('"+value3+"','DD/MM/YY HH24:MI:SS')");
%>


<table width="100%" class="border" border="0" cellpadding="0" cellspacing="5" id="stretch" >
<tr><td class="Headings" align="center" colspan="2">Packet Edit</td></tr>

</table>
<table width="100%" class="border" border="0" cellpadding="0" cellspacing="5" id="stretch" >
<%while(rs.next()){ %>
<tr><td class="Blue-content">Clientid</td>
<td class="content style1"><%=rs.getString("clientid")%></td> </tr>
<tr><td class="Blue-content">Date/time</td>
<td class="content style1"><%=rs.getString("date")%></td> </tr>
<tr><td class="Blue-content">Packet No</td>
<td class="content style1"><%=rs.getString("packetno")%></td> </tr>
</td></tr>

<tr><td class="Blue-content">Rain(mm)</td><td><input type="text" class="content style1" name="txtRain" size="6" maxlength="10" value="<%=rs.getDouble("rain")%>"</td></tr>
<tr><td class="Blue-content">Temp</td><td><input type="text" class="content style1" name="txtTemp" size="6" maxlength="10" value="<%=rs.getDouble("temp")%>"</td></tr>

<tr><td class="Blue-content">Wind</td><td><input type="text" class="content style1" name="txtWind" size="6" maxlength="10" value="<%=rs.getDouble("wind")%>"</td></tr>
<tr><td class="Blue-content">Wind_direction</td><td><input type="text" class="content style1" name="txtWinddirection" size="6" maxlength="10" value="<%=rs.getDouble("wind_direction")%>"</td></tr>
<tr><td class="Blue-content">humidity</td><td><input type="text" class="content style1" name="txtHumidity" size="6" maxlength="10" value="<%=rs.getDouble("humidity")%>"</td></tr>
<tr><td class="Blue-content">Local Pressure</td><td><input type="text" class="content style1" name="txtPressure" size="8" maxlength="12" value="<%=rs.getDouble("local_pressure")%>"</td></tr>
</table>
<table width="100%"  class="border" border="0" cellpadding="0" cellspacing="0" id="stretch" >
<tr><td align="right" ><input type="submit"name="act" value="Save" </td>
<td align="center"><input type="submit" name="act" value="Reset"</td>
<td align="left"><input type="submit" name="act" value="Close" onclick="javascript:window.close()"</td>
</tr>
<input type=hidden name=v1 value="<%=value1%>">
<input type=hidden name=v2 value="<%=value2%>">
<input type=hidden name=v3 value="<%=value3%>">

 <%
}
rs.close();
con.close();
%>
</table>

</form>
</body>
</html>