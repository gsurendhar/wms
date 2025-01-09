
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %> 
<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;

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
<%
con = ConnectionProvider.getCon();
stmt=con.createStatement();
String value1=request.getParameter("v1");
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
<tr><td class="Blue-content" align="center" colspan="2">Comm Log</td></tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="5" id="stretch" >


<tr><td></td></tr>

<%


rs=stmt.executeQuery("select sender,type,msg,to_char(receivedtime,'DD/MM/YYYY HH24:MI:SS') as receivedtime from (select sender,'Recieved' as type,msg,to_timestamp(receivedtime,'YYYY-MM-DD HH24:MI:SS') as receivedtime from error_messages where PROCESSED !='X' union select '+91'||receiver as receiver,'Sent',msg,to_timestamp(senttime,'YYYY-MM-DD HH24:MI:SS') as senttime from ozekimessageout where status='sent' union select  '+91'||recipient as recipient,'Sent',text,sent_date from smsserver_out where status='S') as x where sender=(select '+91'||stn_sim from station_configs_det where clientid='"+value1+"' ) order by 4");
%>


<table width="100%" class="border" border="0" cellpadding="0" cellspacing="5" id="stretch" >
<tr><td class="Blue-content">Sender</td><td class="Blue-content">Type</td><td class="Blue-content">Message</td>
<td class="Blue-content">Date/Time</td>
</tr>
<%
while(rs.next()){ %>
<tr>
<td class="readonly"><%=rs.getString(1)%></td><td class="readonly"><%=rs.getString(2)%></td><td class="readonly"><%=rs.getString(3)%></td>
<td class="readonly"><%=rs.getString(4)%></td>
</tr>
<%
}
rs.close();

%>
</table>
</table>
</body>
</html>