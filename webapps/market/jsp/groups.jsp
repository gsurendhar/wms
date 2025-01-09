
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	ResultSet rs1=null;
	Statement stmt1=null;
	String query="";


    if(null == session.getAttribute("userr")){  
  // User is not logged in.
  out.println("your Session has expired");
  response.sendRedirect("Login.html?invalid=0");
} 


try
{

	/*Getting the connection variable from session*/

	con=(Connection)session.getAttribute("connection");
	stmt =  con.createStatement();
	stmt1 =  con.createStatement();
	
}
catch(Exception e)
{
	//System.out.println("Exception"+e);
	%><%=e%><%
}



	String act = request.getParameter("act"); 
	String vgroupid = request.getParameter("txtGroupid");

	String vname = request.getParameter("txtName");
//	String vlist = request.getParameter("LstMenu");
//	String vlist = request.getParameter("options");
//String vlist = request.getParameter("selected_fields");

//out.println("vlist"+vlist);
	

	String[] mymenus = request.getParameterValues("selected_fields");
       String[] mymenusa = request.getParameterValues("choose_fields");


	
 %>

<html>
<head>
<link href="../styles/styles.css" rel="stylesheet" type="text/css">
<script language="Javascript" src="../Script/move.js"></script>
<title> Role Management </title>
<SCRIPT LANGUAGE="JavaScript">


</SCRIPT>
</head>
<body>
<%
Integer vid=0;
Integer DisRow=0;
%>

<form method="post" name="frmgroup" >

<% 	if ("Edit".equalsIgnoreCase(act) ) { %>
<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch"  bgcolor="#DBEBFF"> 
<tr> <td colspan="3" align="Center" class="Headings"><%=act%> Group/td><tr> 
	<%		if (vgroupid!=null){
			rs=stmt.executeQuery("select group_name as id ,group_value as group_name from parameter where group_family='GROUP' and group_name='"+vgroupid+"'");
			while (rs.next()){
%>
<tr><td class="Blue-content">Group ID&nbsp;<input type="text" readonly name="txtGroupid" size="3" class="content style1" value="<%=rs.getString(1)%>" ></td><td>&nbsp;</td>
<td class="Blue-content">Group Name&nbsp;<input type="text" id="txtName" name="txtName" class="content style1" value="<%=rs.getString(2)%>"> </td></tr>
 <% }%>
<tr><td class="Blue-content" align="center">Avialble List</td><td>&nbsp;</td><td class="Blue-content" align="center">Selected List</td></tr>

	<% rs1=stmt1.executeQuery("select distinct code from intraday.nse_bhav where day>= subdate(current_date,5) and SERIES='EQ' and code not in (select code from code_group a where group_id="+vgroupid+") order by 1"); %>
	<% rs=stmt.executeQuery("select code from code_group a where group_id="+vgroupid+" order by 1"); %>
<tr>
<td width="15%" align="center"><select name="choose_fields" size="10" class="content" multiple="true" style="width:120px;height:260px">
				  <% while (rs1.next()){ %>
				  <option value="<%=rs1.getString(1)%>"><%=rs1.getString(1)%></option>
				<% }%>
			</select>
			</td>
				<td width="5%" align="center"> 
						<input type="button" name="rightFields" value="&gt;" onclick="move(document.frmgroup.choose_fields,document.frmgroup.selected_fields)" > 
						<br><br><input type="button" name="leftPartner"  value="&lt;" onclick="move(document.frmgroup.selected_fields,document.frmgroup.choose_fields)" > 
				</td>

				<td class="content" width="15%" align="center">
				<select name="selected_fields" size="5" class="content" multiple="true" style="width:120px;height:260px"  >
						 <% while (rs.next()){ %>
						  <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
						 <% }%>
						 </select>
				</td>


  <tr>
 <td  align="right"><input type="submit" name="act" value="Update"></td>
 <td  align="left"> <input type="submit" name="act" value="Cancel"></td>
 </tr>
 <%
			}
	
	else { %>
<tr><td><b><center>No User selected</center></b></td></tr>
<td  align="center"> <input type="submit" name="act" value="Cancel"></td>
	
<%	} %>
 
</table>
<% }
else if ("Add".equalsIgnoreCase(act)){ 
	rs=stmt.executeQuery("select max(group_name)+1 from parameter where group_family='GROUP'");
	%>
<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch"  bgcolor="#DBEBFF"> 
<tr> <td colspan="3" align="Center" class="Headings"><%=act%> Group</td><tr> 
 <%	while(rs.next())
	{
	vid=rs.getInt(1);
	}
%>
<tr><td class="Blue-content">Group ID&nbsp;<input type="text" readonly name="txtGroupid" size="3" class="content style1" value=<%=vid%> ></td><td>&nbsp;</td>
<td class="Blue-content">Group Name&nbsp;<input type="text" id="txtName" name="txtName" class="content style1" value=""> </td></tr>
<tr><td class="Blue-content" align="center">Avialble List</td><td>&nbsp;</td><td class="Blue-content" align="center">Selected List</td></tr>

<% rs1=stmt1.executeQuery("select distinct code from nse_bhav where day>= subdate(current_date,5) order by 1"); %>

			<td width="15%" align="center"><select name="choose_fields" size="10" class="content" multiple="true" style="width:120px;height:260px">
				  <% while (rs1.next()){ %>
				  <option value="<%=rs1.getString(1)%>"><%=rs1.getString(1)%></option>
				<% }%>
			</select>
			</td>
				<td width="5%" align="center"> 
						<input type="button" name="rightFields" value="&gt;" onclick="move(document.frmgroup.choose_fields,document.frmgroup.selected_fields)" > 
						<br><br><input type="button" name="leftPartner"  value="&lt;" onclick="move(document.frmgroup.selected_fields,document.frmgroup.choose_fields)" > 
				</td>
				<td class="content" width="15%" align="center">
						<select name="selected_fields" size="5" class="content" multiple="true" style="width:120px;height:260px" selected >
					    </select>
				</td>
</tr>
  <tr>
 <td  align="right"><input type="submit" name="act" value="Insert" ></td>
 <td  align="left"> <input type="submit" name="act" value="Cancel"></td>
 </tr>
</table>

<%
} 
else if (act==null || ("Update".equalsIgnoreCase(act)) || ("Cancel".equalsIgnoreCase(act))||("Insert".equalsIgnoreCase(act))||("Delete".equalsIgnoreCase(act))) 
{  
	if ("Update".equalsIgnoreCase(act)){
		query="update parameter set group_value='"+vname+"' where group_family='GROUP' and group_name='"+vgroupid+"'";
		//out.println(query);
		stmt.executeUpdate(query);
		if (mymenus != null ) {
			query="delete from code_group where group_id="+vgroupid;
			stmt.executeUpdate(query);
			//out.println(query);
			for (int i = 0; i < mymenus.length; i++) {
			//out.print("<P>" + mymenus[i] + "</p>");
			query="Insert into code_group (group_id,code) values ("+vgroupid+",'"+mymenus[i]+"')";
			//out.println(query);
			stmt.executeUpdate(query);
			}
		}
	if (mymenusa != null ) {
			//query="delete from code_group where group_id="+vgroupid;
			//stmt.executeUpdate(query);
			//out.println(query);
			for (int i = 0; i < mymenusa.length; i++) {
			//out.print("<P>" + mymenus[i] + "</p>");
			//query="Insert into code_group (group_id,code) values ("+vgroupid+",'"+mymenusa[i]+"')";
			query="delete from code_group where group_id="+vgroupid+" and code='"+mymenusa[i]+"'";
			//out.println(query);
			stmt.executeUpdate(query);
			}
		}
			
	}

if ("Insert".equalsIgnoreCase(act)){
		query="Insert into parameter (group_family,group_name,group_value,active) values ('GROUP','"+vgroupid+"','"+vname+"','Y')";
		//out.println(query);
		stmt.executeUpdate(query);
    if (mymenus != null ) {
	for (int i = 0; i < mymenus.length; i++) {
      //out.print("<P>" + mymenus[i] + "</p>");
	  query="Insert into code_group (group_id,code) values ("+vgroupid+",'"+mymenus[i]+"')";
	  //out.println(query);
	  stmt.executeUpdate(query);
	}
	}

	}
if ("Delete".equalsIgnoreCase(act)){
		query="delete from code_group where group_id='"+vgroupid+"'";
		//out.println(query);
		stmt.executeUpdate(query);
		query="delete from parameter where group_family='GROUP' and  group_name='"+vgroupid+"'";
		//out.println(query);
		stmt.executeUpdate(query);
	}

rs=stmt.executeQuery("select group_name as id ,group_value as group_name from parameter where group_family='GROUP' order by 1");
act="";
%>

<table width="75%" align="center" border="1" cellpadding="0" cellspacing="0" id="stretch"  bgcolor="#DBEBFF">

<tr> <td colspan="4" align="Center" class="Headings">Group List</td><tr> 
<tr class="Blue-content"><td>Group ID</td><td>Name</td><td>select</td><td>Code List</td></tr>
<%	while(rs.next()){
	vgroupid=rs.getString(1);
%>
<tr class="content style1"> 
<td align="center"><%=rs.getString(1)%></td><td><%=rs.getString(2)%></td>
<%String txtName=rs.getString(2);%>

<td><input type="radio" name="txtGroupid" value=<%=rs.getString(1)%>></td>
<!-- menu listing -->
<td>
<% rs1=stmt1.executeQuery("select a.group_id,code from code_group a where group_id="+vgroupid+" order by 1");
%>
<select id="group" class="content" style="width:150;" size="10">
<% while(rs1.next()){ %>
<option value="<%=rs1.getString("code")%>" ><%=rs1.getString("code")%></option>
<%} %>
</select>
</td>

</tr>
<%	  DisRow++;	}
	if(DisRow==0)
{	/*To write to the server if the resultset is null*/
%>
		<CENTER>
			<tr><th colspan=6 class="content style1">No Records found</th></tr>
		</CENTER>
<%} %>
 <tr>
 <td colspan="2" align="right"><input type="submit" name="act" value="Add"></td>
 <td colspan="1" align="center"> <input type="submit" name="act" value="Edit"></td>
 <td colspan="1" align="left"> <input type="submit" name="act" value="Delete"></td>
<!--  <td colspan="1" align="left"> <input type="submit" name="act" value="Menu Management"></td> -->
 </tr>
</table>
<%} 
else 
%>
</form>
</body> 
</html>

