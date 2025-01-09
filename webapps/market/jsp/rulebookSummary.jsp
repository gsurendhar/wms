<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%!
	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	ResultSet rsrole=null;
	Statement stmtrole=null;
	String query="";
	int count=0;
	int DisRow=0;
	%>

<%



try
{

	/*Getting the connection variable from session*/

	con=(Connection)session.getAttribute("connection");
	stmt =  con.createStatement();
	stmtrole  =  con.createStatement();
	
}
catch(Exception e)
{
	System.out.println("Exception"+e);

}

	String act = request.getParameter("act"); 
	String vid = request.getParameter("id");
	String vname=request.getParameter("txtKPI");
	String vval=request.getParameter("txtVal");
	String vactive=request.getParameter("txtActive");
	

 %>

<html>
<head>
<link href="../styles/styles.css" rel="stylesheet" type="text/css">
<title> Rule Book Management </title>
<script type="text/javascript" src="../../Script/gs_sortable.js"></script>

</head>
<body>


<form action="rulebook.jsp" method="post" name="frmentry" >

<% if ("Edit".equalsIgnoreCase(act) ) { 
rs=stmt.executeQuery("select * from intraday.kpi_rules where id="+vid);
%>


<table width="100%" id="stretch">

	<tr>
			<td align="right" colspan="7">
			<button type="submit" class="button-image" id="act" name="act" value="Update"> <img src="../images/icon_save.png"  height="30" width="30" alt="Add" /></button>  
			<button type="submit" class="button-image" id="act" name="act" value="Cancel" > <img src="../images/icon_delete.png"  height="30" width="30" alt="Add" /></button>
			</td>
	</tr>
</table>

<table width="100%" class="border" border="1" id="stretch"  bgcolor="#DBEBFF"> 

<%	while(rs.next()) { %>
<tr> <td colspan="3" align="Center" class="Headings"><%=act%> Rule</td><tr> 

<tr><td class="Blue-content"><b>Indicator:</b></td><td><%=rs.getString("NAME")%></td> </tr>
<tr><td class="Blue-content"><b>Value:</b></td>
<td><input type=text id=txtVal name=txtVal  class="content style1" value="<%=rs.getString("VALUE")%>" size="10"></td></tr>
<tr><td class="Blue-content"><b>Active:</b></td>
<td><input type=text id=txtActive name=txtActive  class="content style1" value="<%=rs.getString("ACTIVE")%>" size="5"></td> </tr>
</tr>
<tr>
<input type="hidden" name="id" value="<%=vid%>"></td>
</tr>
</table>

<% }
	} else if ("Add".equalsIgnoreCase(act)){ 	
%>	
<table width="100%" id="stretch">

	<tr>
			<td align="right" colspan="7">
			<button type="submit" class="button-image" id="act" name="act" value="Insert"> <img src="../images/icon_save.png"  height="30" width="30" alt="Add" /></button>  
			<button type="submit" class="button-image" id="act" name="act" value="Cancel" > <img src="../images/icon_delete.png"  height="30" width="30" alt="Add" /></button>
			</td>
	</tr>
</table>

<table width="100%" class="border" border="1" cellpadding="0" cellspacing="0" id="stretch"  bgcolor="#DBEBFF"> 
<tr> <td colspan="3" align="Center" class="Blue-content">New Rule</td><tr> 
<tr>
<td class="Blue-content"><b>Indicator:</b><input type=text id=txtKPI name=txtKPI  class="content style1" value="" size="10"></td>
<td class="Blue-content"><b>Value:</b><input type=text id=txtVal name=txtVal  class="content style1" value="" size="25"></td> 
</tr>
<tr><td colspan="3"><textarea rows="4" cols="150" class="content style1" name="txtRemarks"></textarea></td></tr>
</table>

<%
}
else if (act==null || ("Update".equalsIgnoreCase(act)) || ("Cancel".equalsIgnoreCase(act))||("Insert".equalsIgnoreCase(act))||("Delete".equalsIgnoreCase(act))) 
{  
if ("Update".equalsIgnoreCase(act)){
		query="update intraday.kpi_rules set  ";
		if (vactive!=null){query=query+"Active='"+vactive+"'";}
		if (vval!=null){query=query+",VALUE='"+vval+"'";}
		query+=" where id='"+vid+"'" ;
		//out.println(query);
	stmt.executeUpdate(query);
	}

if ("Insert".equalsIgnoreCase(act)){
		
		query="insert into intraday.kpi_rules(NAME,VALUE) values ('"+vname+"','"+vval+"')";
		//out.println(query);
		stmt.executeUpdate(query);
	}
if ("Delete".equalsIgnoreCase(act)){
		query="update intraday.kpi_rules set active='N' where id='"+vid+"'";

		stmt.executeUpdate(query);
	}
act=null;
rs=stmt.executeQuery("select * from intraday.kpi_rules where active='Y' order by  id ");
act="";
%>


<table width="100%" >

	<tr>
			<td align="right" colspan="7">
			
			<button type="submit" class="button-image" id="act" name="act" value="Edit" > <img src="../images/icon_edit.png"  height="30" width="30" alt="edit" /></button>
			<!-- <button type="submit" class="button-image" id="act" name="act" value="Delete"> <img src="../images/icon_delete.png"  height="30" width="30" alt="Delete" /></button> 
			<button type="submit" class="button-image" id="act" name="act" value="Add"> <img src="../images/icon_add.png"  height="30" width="30" alt="Add" /></button>  
			-->
			</td>
	</tr>
</table>


<table width="50%" class="border" border="1" cellpadding="1" cellspacing="0" id="stretch"  bgcolor="#DBEBFF">

<tr> <td colspan="18" align="Center" class="Headings">Rule List</td><tr>

 
<tr class="Blue-content" align="center" border="1"> 
<td>Rule Type</td><td>Value</td><td>Active</td>  

<td>select</td>
</tr>
<%	while(rs.next())
	{
%>
<tr class="content style1" align="center">
<td align="left"><%=rs.getString("Name")%></td><td align="center"><%=rs.getString("VALUE")%> </td>
<td align="center"><%=rs.getString("ACTIVE")%> </td>
<td><input type="radio" name="id" value=<%=rs.getString("id")%>></td>


</tr>
<%	  DisRow++;	}
	if(DisRow==0)
{	/*To write to the server if the resultset is null*/
%>
		<CENTER>
			<tr><th colspan=10 class="content style1">No Records found</th></tr>
		</CENTER>
<%} %>

</table>
<%} %>
</form>
</body> 
</html>

