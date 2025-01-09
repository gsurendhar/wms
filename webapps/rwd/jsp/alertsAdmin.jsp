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
<%
	String act = request.getParameter("act"); 
	String vID = request.getParameter("txtID");
	String vmin = request.getParameter("txtmin");
	String vmax = request.getParameter("txtmax");
	String valert = request.getParameter("chkAlert");
	String verror = request.getParameter("chkError");

	
	Integer oid	= (Integer) session.getAttribute("theOid");
 %>

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

if ("Add".equalsIgnoreCase(act)){ %>
<form name="FrmAddList" action="alertsAdmin.jsp" method="post">
<table class="mytable" >
	<tr>
			<td align="right" colspan="7">
			<button type="submit" class="button-image" id="act" name="act" value="AddP"> <img src="../images/icon_save.png"  height="30" width="30" alt="Add" /></button>  
			<button type="submit" class="button-image" id="act" name="act" value="DeleteP"> <img src="../images/icon_delete.png"  height="30" width="30" alt="Cancel" /></button> 
			</td>
	</tr>
</table>
<table class="mytable">
<tr valign="top"> 
<td class="boxcontainer">
<div class="">
  <div class="titlebox" id="">
  <div class="titlebox-title">
        <span class="left">Add Alert Parameters</span>
  </div>
  <div class="titlebox-content " id="t1">
  <hr class="clear" />
  <table class="ticket-list collection-as-table">
  <tr class="collection-as-table">
	<th class="collection-as-table">ID</th>
	<th class="collection-as-table">Parameter</th>
	<th class="collection-as-table">Min Value</th>
	<th class="collection-as-table">Max	Value</th>
	<th class="collection-as-table">Alert</th>
	<th class="collection-as-table">Error</th>
	<th class="collection-as-table">Select</th>
</tr>

<% rs=stmt.executeQuery("select * from alert_params where active!='Y' order by param");
	int x =0;
	while(rs.next()){
		x++;
				if ( (x%2) == 0 ) { %>
<tr class="oddline" > <%} else { %><tr class="evenline" >  <%}%>
<td class="content style"><%=x%></td>

<td class="content style"><%=rs.getString("Description")%></td>
<td class="content style"><input type="text" name="txtmin" size="6" maxlength="10" value="<%=rs.getString("min_value")%>"></td>
<td class="content style"><input type="text" name="txtmax" size="6" maxlength="10" value="<%=rs.getString("max_value")%>"></td>
<td><input type="checkbox" name="chkAlert"></td>
<td><input type="checkbox"  name="chkError"></td>
<td><input type="radio" name="txtID" value=<%=rs.getInt("id")%>></td>
</tr>
<% } %>

</table>
</div>
</div>
</div>
</td>
</tr>
</table>
</form>

<% } else if ("Edit".equalsIgnoreCase(act)){ %>
<form name="FrmAddList" action="alertsAdmin.jsp" method="post">
<table class="mytable" >
	<tr>
			<td align="right" colspan="7">
			<button type="submit" class="button-image" id="act" name="act" value="AddP"> <img src="../images/icon_save.png"  height="30" width="30" alt="Add" /></button>  
			<button type="submit" class="button-image" id="act" name="act" value="DeleteP"> <img src="../images/icon_delete.png"  height="30" width="30" alt="Cancel" /></button> 
			</td>
	</tr>
</table>
<table class="mytable">
<tr valign="top"> 
<td class="boxcontainer">
<div class="">
  <div class="titlebox" id="">
  <div class="titlebox-title">
        <span class="left">Add Alert Parameters</span>
  </div>
  <div class="titlebox-content " id="t1">
  <hr class="clear" />
  <table class="ticket-list collection-as-table">
  <tr class="collection-as-table">
	<th class="collection-as-table">ID</th>
	<th class="collection-as-table">Parameter</th>
	<th class="collection-as-table">Min Value</th>
	<th class="collection-as-table">Max	Value</th>
	<th class="collection-as-table">Alert</th>
	<th class="collection-as-table">Error</th>
	<th class="collection-as-table">Select</th>
</tr>

<% rs=stmt.executeQuery("select * from alert_params where id='"+vID+"'");
	int x =0;
	while(rs.next()){
		x++;
				if ( (x%2) == 0 ) { %>
<tr class="oddline" > <%} else { %><tr class="evenline" >  <%}%>
<td class="content style"><%=x%></td>

<td class="content style"><%=rs.getString("Description")%></td>
<td class="content style"><input type="text" name="txtmin" size="6" maxlength="10" value="<%=rs.getString("min_value")%>"></td>
<td class="content style"><input type="text" name="txtmax" size="6" maxlength="10" value="<%=rs.getString("max_value")%>"></td>
<td>
<%if ("Y".equalsIgnoreCase(rs.getString("alert"))) { %>
	<input type="checkbox" name="chkAlert" checked > <%} else { %> <input type="checkbox"  name="chkAlert"><%} %>
</td>
<td>
<%if ("Y".equalsIgnoreCase(rs.getString("error"))) { %>
	<input type="checkbox" name="chkError" checked > <%} else { %> <input type="checkbox"  name="chkError"><%} %>
</td>
<td><input type="radio" name="txtID" checked="checked" value=<%=rs.getInt("id")%>></td>
</tr>
<% } %>

</table>
</div>
</div>
</div>
</td>
</tr>
</table>
</form>
<%} 
else if (act==null ||("DeleteP".equalsIgnoreCase(act)) ||("AddP".equalsIgnoreCase(act)) || 
("Update".equalsIgnoreCase(act)) || ("Cancel".equalsIgnoreCase(act))||("Insert".equalsIgnoreCase(act))||("Delete".equalsIgnoreCase(act))) 
	{  
			if ("AddP".equalsIgnoreCase(act)){
				if(vID==null){ %>
				<script> alert("no Sensor selected!"); 
						history.go(-1);
				</script>
				<% } else{	
				query="update alert_params set active='Y',min_value='"+vmin+"',max_value='"+vmax+"'";
				if ("on".equalsIgnoreCase(verror)){	query+=",error='Y'";}else {query+=",error='N'";}
				if ("on".equalsIgnoreCase(valert)){ query+=",alert='Y'";}else {query+=",alert='N'";}
					query+=" where id='"+vID+"'";
					//out.println(query);
					stmt.executeUpdate(query);
					}
				}
			if ("Update".equalsIgnoreCase(act)){
				query="update alert_params set min_value='"+vmin+"',max_value='"+vmax+"'";
				if ("on".equalsIgnoreCase(verror)){
					query+=",error='Y'";
				}
				else {query+=",error='N'";}
				if ("on".equalsIgnoreCase(valert)){
					query+=",alert='Y'";
				}
				else {query+=",alert='N'";}
				query+=" where id='"+vID+"'";
				//out.println(query);
				stmt.executeUpdate(query);
				}									
			
				if ("Insert".equalsIgnoreCase(act)){
				}
			if ("Delete".equalsIgnoreCase(act)){
					if(request.getParameter("txtID")==null){ %>
						<script> alert("no record selected!"); 
								history.go(-1);
						</script>
			<% } else{	
					query="update alert_params set active='N' where id='"+vID+"'";
			//out.println(query);
					stmt.executeUpdate(query);
					}
				}
act="";
%>

<form name="FrmUserList" action="alertsAdmin.jsp" method="post">
<table class="mytable" >
	<tr>
			<td align="right" colspan="7">
			<button type="submit" class="button-image" id="act" name="act" value="Add"> <img src="../images/icon_add.png"  height="30" width="30" alt="Add" /></button>  
			<button type="submit" class="button-image" id="act" name="act" value="Edit" > <img src="../images/icon_edit.png"  height="30" width="30" alt="Edit" /></button>
			<button type="submit" class="button-image" id="act" name="act" value="Delete"> <img src="../images/icon_delete.png"  height="30" width="30" alt="Delete" /></button> 
			</td>
	</tr>
</table>
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
	<th class="collection-as-table">ID</th>
	<th class="collection-as-table">Parameter</th>
	<th class="collection-as-table">Min Value</th>
	<th class="collection-as-table">Max	Value</th>
	<th class="collection-as-table">Alert</th>
	<th class="collection-as-table">Error</th>
	<th class="collection-as-table">Select</th>
</tr>

<% rs=stmt.executeQuery("select * from alert_params where active='Y' order by param");
	int x =0;
	while(rs.next()){
		x++;
				if ( (x%2) == 0 ) { %>
<tr class="oddline" > <%} else { %><tr class="evenline" >  <%}%>
<td class="content style"><%=x%></td>

<td class="content style"><%=rs.getString("Description")%></td>
<td class="content style"><input type="text" name="txtmin" size="6" maxlength="10" readonly value="<%=rs.getString("min_value")%>"></td>
<td class="content style"><input type="text" name="txtmax" size="6" maxlength="10" readonly value="<%=rs.getString("max_value")%>"></td>
<td>
<%if ("Y".equalsIgnoreCase(rs.getString("alert"))) { %>
	<input type="checkbox" name="chkAlert" checked disabled> <%} else { %> <input type="checkbox" disabled name="chkAlert"><%} %>
</td>
<td>
<%if ("Y".equalsIgnoreCase(rs.getString("error"))) { %>
	<input type="checkbox" name="chkError" checked disabled> <%} else { %> <input type="checkbox" disabled name="chkError"><%} %>
</td>
<td><input type="radio" name="txtID" value=<%=rs.getInt("id")%>></td>
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
<%} %>
</body> 
</html>

