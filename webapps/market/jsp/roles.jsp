
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
	String vroleid = request.getParameter("txtRoleid");
	String vname = request.getParameter("txtName");
//	String vlist = request.getParameter("LstMenu");
	String vlist = request.getParameter("options");
//	out.println("vlist"+vlist);
	
	String vlname = request.getParameter("txtLName");
	String vpswd = request.getParameter("txtPswd");
	String vrole = request.getParameter("txtRole");
	String vphone = request.getParameter("txtPhone");
	String vemail = request.getParameter("txtEmail");
	String[] mymenus = request.getParameterValues("options");


	
 %>

<html>
<head>
<link href="../styles/styles.css" rel="stylesheet" type="text/css">

<title> Role Management </title>
<SCRIPT LANGUAGE="JavaScript">


</SCRIPT>
</head>
<body>
<%
Integer vid=0;
Integer DisRow=0;
%>

<form action="roles.jsp" method="post" name="frmentry" >

<% 	if ("Edit".equalsIgnoreCase(act) ) { %>
<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch"  bgcolor="#DBEBFF"> 
<tr> <td colspan="2" align="Center" class="Headings"><%=act%> Role</td><tr> 
	<%		if (vroleid!=null){
			rs=stmt.executeQuery("select group_name as id ,group_value as role from parameter where group_family='USER_ROLES' and group_name='"+vroleid+"'");
			while (rs.next()){
%>
<tr><td class="Blue-content">Role ID</td><td><input type="text" readonly name="txtRoleid" class="content style1" value=<%=rs.getString(1)%> ></td></tr>
<tr><td class="Blue-content">Role Name</td><td><input type="text" name="txtName" class="content style1" value="<%=rs.getString(2)%>"> </td></tr>
<% rs1=stmt1.executeQuery("select a.module_id,a.module_name,b.module_id as r_module_id from module a left outer join (select * from role_privilages where role_id="+vroleid+")  b on (a.module_id=b.module_id )"); %>
<tr><td class="Blue-content">Menu List</td><td>
  <% while (rs1.next()){
	if (rs1.getString("r_module_id")!=null){ %>
  <INPUT NAME="options" TYPE="CHECKBOX"  checked VALUE="<%=rs1.getInt(1) %>"> <%=rs1.getString(2)%><BR>
  <%} else { %>
 <INPUT NAME="options" TYPE="CHECKBOX"  VALUE="<%=rs1.getInt(1) %>"> <%=rs1.getString(2)%><BR>
<%} }%>
</td></tr>
 <% }%>
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
	rs=stmt.executeQuery("select max(group_name)+1 from parameter where group_family='USER_ROLES'");
	%>
<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch"  bgcolor="#DBEBFF"> 
<tr> <td colspan="2" align="Center" class="Blue-content"><%=act%> User</td><tr> 
 <%	while(rs.next())
	{
	vid=rs.getInt(1);
	}
%>
<tr><td class="Blue-content">Role ID</td><td><input type="text" readonly name="txtRoleid" class="content style1" value=<%=vid%> ></td></tr>
<tr><td class="Blue-content">Role Name</td><td><input type="text" name="txtName" class="content style1" value=""> </td></tr>
<% rs1=stmt1.executeQuery("select module_id,module_name from module order by 1"); %>
<tr><td class="Blue-content">Menu List</td><td>
  <% while (rs1.next()){ %>
  <INPUT NAME="options" TYPE="CHECKBOX" VALUE="<%=rs1.getInt(1) %>"> <%=rs1.getString(2)%><BR>
<% }%>
</td></tr>
 
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
		query="update parameter set group_value='"+vname+"' where group_family='USER_ROLES' and group_name='"+vroleid+"'";
		//out.println(query);
		stmt.executeUpdate(query);
		if (mymenus != null ) {
			query="delete from role_privilages where role_id="+vroleid;
			stmt.executeUpdate(query);
			//out.println(query);
			for (int i = 0; i < mymenus.length; i++) {
			//out.print("<P>" + mymenus[i] + "</p>");
			query="Insert into role_privilages (role_id,module_id) values ("+vroleid+","+mymenus[i]+")";
			//out.println(query);
			stmt.executeUpdate(query);
			}
		}
			
	}

if ("Insert".equalsIgnoreCase(act)){
		query="Insert into parameter (group_family,group_name,group_value,active) values ('USER_ROLES','"+vroleid+"','"+vname+"','Y')";
		//out.println(query);
		stmt.executeUpdate(query);
    if (mymenus != null ) {
	for (int i = 0; i < mymenus.length; i++) {
      out.print("<P>" + mymenus[i] + "</p>");
	  query="Insert into role_privilages (role_id,module_id) values ("+vroleid+","+mymenus[i]+")";
	  //out.println(query);
	  stmt.executeUpdate(query);
	}
	}

	}
if ("Delete".equalsIgnoreCase(act)){

		query="delete from parameter where group_family='USER_ROLES' and  group_name='"+vroleid+"'";
		out.println(query);
		stmt.executeUpdate(query);
		query="delete from role_privilages where role_id='"+vroleid+"'";
		out.println(query);
		stmt.executeUpdate(query);
	}

rs=stmt.executeQuery("select group_name as id ,group_value as role from parameter where group_family='USER_ROLES' order by 1");
act="";
%>

<table width="50%" align="center" border="1" cellpadding="0" cellspacing="0" id="stretch"  bgcolor="#DBEBFF">

<tr> <td colspan="4" align="Center" class="Headings"><%=act%> Role List</td><tr> 
<tr class="Blue-content"><td>Role ID</td><td>Name</td><td>select</td><td>Menu(s) Assigned</td>
</tr>
<%	while(rs.next())
	{
	vroleid=rs.getString(1);
%>
<tr class="content style1"> 
<td align="center"><%=rs.getString(1)%></td><td><%=rs.getString(2)%></td>
<%String txtName=rs.getString(2);%>
<td><input type="radio" name="txtRoleid" value=<%=rs.getString(1)%>></td>
<!-- menu listing -->
<td><table border="0">
<% rs1=stmt1.executeQuery("select a.module_id,module_name from role_Privilages a,module b where a.module_id=b.module_id and role_id="+vroleid+" order by 1");
while(rs1.next())
	{ %>
	<tr class="black-text"><td><%=rs1.getString(2)%></td><tr>
	<%}
	%>
</table></td>

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

