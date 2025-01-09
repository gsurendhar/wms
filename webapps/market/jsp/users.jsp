<%@ page language="java" import="java.sql.*" %>

<%!

	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	ResultSet rsrole=null;
	Statement stmtrole=null;
	String query="";
	
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
	String vuserid = request.getParameter("txtUserid");
	//out.println("Action="+act+"; User ID="+vuserid);
	String vname = request.getParameter("txtName");
	String vlname = request.getParameter("txtLName");
	String vpswd = request.getParameter("txtPswd");
	String vrole = request.getParameter("txtRole");
	String vphone = request.getParameter("txtPhone");
	String vemail = request.getParameter("txtEmail");
	//out.println(act);
 %>

<html>
<head>
<link href="../styles/styles.css" rel="stylesheet" type="text/css">

<title> User Management </title>
</head>
<body>
<%
Integer vid=0;
int DisRow=0;
%>

<form action="users.jsp" method="post" name="frmentry" >

<% 	if ("Edit".equalsIgnoreCase(act) ) { %>
<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch"  bgcolor="#DBEBFF"> 
<tr> <td colspan="2" align="Center" class="Blue-content"><%=act%> User</td><tr> 
	<%		if (vuserid!=null){
			rs=stmt.executeQuery("select u.*,(select group_value from parameter where group_family='USER_ROLES' and group_name=u.user_role) as role   from users u where user_id="+vuserid);
			while(rs.next())
	{
%>
<tr><td class="Blue-content">User ID</td><td><input type="text" readonly name="txtUserid" class="content style1" value=<%=rs.getString(1)%> ></td></tr>
<tr><td class="Blue-content">Name</td><td><input type="text" name="txtName" class="content style1" value=<%=rs.getString(2)%>> </td></tr>
<tr><td class="Blue-content">Login Name</td><td><input type="text" readonly name="txtLName" class="content style1" value=<%=rs.getString(4)%>> </td></tr>
<tr><td class="Blue-content">Password</td><td><input type="password" name="txtPswd" class="content style1" value=<%=rs.getString(5)%>></td></tr>
<% rsrole = stmtrole.executeQuery("select group_name as rid,group_value as role from parameter where group_family='USER_ROLES' "); %>
<!-- <tr><td class="Blue-content">Role</td><td><input type="text" name="txtRole"  class="content style1"value=<%=rs.getString(6)%>></td></tr>
 -->
 <tr><td class="Blue-content">Role</td><td>
<select id="role" name=txtRole size="1" class="content style1">
<option value="0">--Please Select--</option>
<% while(rsrole.next()){ %>
	<option value="<%=rsrole.getInt("rid")%>"><%=rsrole.getString("role")%></option>
<%
}
%>
<option value="<%=rs.getString(6)%>" selected disabled><%=rs.getString("role")%></option>
</select></td></tr>
<tr><td class="Blue-content">Phone</td><td><input type="text" name="txtPhone" class="content style1" value=<%=rs.getString(7)%>></td></tr>
<tr><td class="Blue-content">Email</td><td><input type="text" name="txtEmail" class="content style1" value=<%=rs.getString(8)%>></td></tr>

</tr>
 <%} 
%>
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
	rs=stmt.executeQuery("select max(user_id)+1 as userid from users");
	%>
<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch"  bgcolor="#DBEBFF"> 
<tr> <td colspan="2" align="Center" class="Blue-content"><%=act%> User</td><tr> 
 <%	while(rs.next())
	{
	vid=rs.getInt(1);
	}
%>
<tr><td class="Blue-content">User ID</td><td><input type="text" readonly name="txtUserid" class="content style1" value=<%=vid%> name="userid"></td></tr>
<tr><td class="Blue-content">Name</td><td><input type="text" name="txtName" class="content style1" value=""> </td></tr>
<tr><td class="Blue-content">Login Name</td><td><input type="text" name="txtLName" class="content style1" value=""></td></tr>
<tr><td class="Blue-content">Password</td><td><input type="password" name="txtPswd" class="content style1" value=""></td></tr>
<% rsrole = stmtrole.executeQuery("select group_name as rid,group_value as role from parameter where group_family='USER_ROLES' "); %>

<tr><td class="Blue-content">Role</td><td>
<select id="role" name=txtRole size="1" class="content style1">
<option value="0">--Please Select--</option>
<% while(rsrole.next()){ %>
	<option value="<%=rsrole.getInt("rid")%>"><%=rsrole.getString("role")%></option>
<%
}
%>
</select></td></tr>
<tr><td class="Blue-content">Phone</td><td><input type="text" name="txtPhone" class="content style1" value=""></td></tr>
<tr><td class="Blue-content">Email</td><td><input type="text" name="txtEmail" class="content style1" value=""></td></tr>

</tr>
 
  <tr>
 <td  align="right"><input type="submit" name="act" value="Insert"></td>
 <td  align="left"> <input type="submit" name="act" value="Cancel"></td>
 </tr>
</table>

<%
} 
else if (act==null || ("Update".equalsIgnoreCase(act)) || ("Cancel".equalsIgnoreCase(act))||("Insert".equalsIgnoreCase(act))||("Delete".equalsIgnoreCase(act))) 
{  
	if ("Update".equalsIgnoreCase(act)){
		query="update users set user_name='"+vname+"',login_name='"+vlname+"', user_password='"+vpswd+"', contact_phone='"+vphone+"',email='"+vemail+"'";
		if (vrole!=null) {query=query+",user_role='"+vrole+"' where user_id='"+vuserid+"'";}
		else{query=query+" where user_id='"+vuserid+"'";}
	stmt.executeUpdate(query);
	}

if ("Insert".equalsIgnoreCase(act)){
		query="Insert into users (user_id,user_name,login_name, user_password,contact_phone,email,user_role) values ('"+vuserid+"','"+vname+"','"+vlname+"','"+vpswd+"','"+vphone+"','"+vemail+"','"+vrole+"')";
		//out.println(query);
	stmt.executeUpdate(query);
	}
if ("Delete".equalsIgnoreCase(act)){
		query="delete from users where user_id='"+vuserid+"'";
		//out.println(query);
	stmt.executeUpdate(query);
	}
act=null;

rs=stmt.executeQuery(" SELECT a.*,(SELECT group_value FROM parameter WHERE group_family='USER_ROLES' AND group_name=user_role) AS ROLE FROM USERS a ORDER BY 1");
act="";
%>

<table width="100%" border="1" cellpadding="0" class=border cellspacing="0" id="stretch"  bgcolor="#DBEBFF">

<tr> <td colspan="7" align="Center" class="Blue-content"><%=act%> User List</td><tr> 
<tr class="Blue-content"><td >User ID</td><td>Name</td><td>Login Name</td><td>Role</td><td>Phone</td><td>Email</td><td>select</td>
</tr>
<%	while(rs.next())
	{
%>
<tr class="content style1"> 
<td><%=rs.getString(1)%></td><td><%=rs.getString(2)%></td><td><%=rs.getString(4)%></td><td><%=rs.getString(9)%></td><td><%=rs.getString(7)%></td><td><%=rs.getString(8)%></td><td><input type="radio" name="txtUserid" value=<%=rs.getString(1)%>></td>
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
 <td colspan="3" align="right"><input type="submit" name="act" value="Add"></td>
 <td colspan="1" align="center"> <input type="submit" name="act" value="Edit"></td>
 <td colspan="3" align="left"> <input type="submit" name="act" value="Delete"></td>
 </tr>
</table>
<%} 
else 
%>
</form>
</body> 
</html>

