<%@ page import="java.util.*" %>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com. ConnectionProvider" %> 
<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
String query="";
%>
<%
con =  ConnectionProvider.getCon();
stmt=con.createStatement();
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
<link href="../styles/text.css" rel="stylesheet" type="text/css">

<title> Alert Management </title>
<script>

</script>
</head>
<body>
<%
Integer vid=0;
int DisRow=0;
%>
<table class="mytable">
<tr valign="top"> 
<td class="boxcontainer">
<div class="">
  <div class="titlebox" id="">
  <div class="titlebox-title">
        <span class="left">Alert List</span>
        
   
  </div>
  <div class="titlebox-content " id="t1">
  <hr class="clear" />
  <table class="ticket-list collection-as-table">
  <tr class="collection-as-table">
	<th class="collection-as-table">#</th>
	<th class="collection-as-table">ClientID</th>
	<th class="collection-as-table">Location</th>
	<th class="collection-as-table">Alert Message</th>
	<th class="collection-as-table">firstReported</th>
	<th class="collection-as-table">LastReported</th>
</tr>

<% query="select a.clientid,location,message,to_char(min(packet_date),'dd/mm/yy hh24:mi') first_reported , to_char(max(packet_date),'dd/mm/yy hh24:mi')  last_reported";
query+=" from wms_alerts a join station_configs_det c on a.clientid=c.clientid and packet_date > current_date";
query+=" group by a.clientid,location,message";
query+=" order by 5 desc LIMIT 50";
	rs=stmt.executeQuery(query);
	int x =0;
	while(rs.next()){
		x++;
				if ( (x%2) == 0 ) { %>
<tr class="oddline" > <%} else { %><tr class="evenline" >  <%}%>
<td class="content style"><%=x%></td>

<td class="content style"><%=rs.getString("clientid")%></td>
<td class="content style"><%=rs.getString("location")%></td>
<td class="content style"><%=rs.getString("Message")%></td>
<td class="content style"><%=rs.getString("first_reported")%></td>
<td class="content style"><%=rs.getString("last_reported")%></td>
</tr>
<%}%>

</table>
</div>
</div>
</div>
</td>
</tr>
</table>

</form>
</body> 
</html>

