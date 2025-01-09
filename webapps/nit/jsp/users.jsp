<%@ page import="java.util.*" %>


<%@page import="com.usersDao"%>
<%@page import="com.usersBean"%>
<jsp:useBean id="obj" class="com.usersBean"/>
<jsp:setProperty property="*" name="obj"/>

<%@page import="com.LoginDao"%>
<%@page import="com.LoginBean"%>
<jsp:useBean id="objL" class="com.LoginBean"/>
<jsp:setProperty property="*" name="objL"/>


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
	String vuserid = request.getParameter("txtUserid");
	String vname = request.getParameter("txtName");
	String vlname = request.getParameter("txtLName");
	String vpswd = request.getParameter("txtPswd");
	String vrole = request.getParameter("txtRole");
	String vphone = request.getParameter("txtPhone");
	String vemail = request.getParameter("txtEmail");
	
	Integer oid	= (Integer) session.getAttribute("theOid");
 %>

<html>
<head>
<link href="../styles/text.css" rel="stylesheet" type="text/css">

<title> User Management </title>
<script>

function checkForm()
{ 	
			if (FrmUser.txtAct.value="insert"){
			if (!FrmUser.txtName.value){
				alert("Name Can't be empty")
					FrmUser.txtName.focus();
				return false;
				}
			if (!FrmUser.txtLName.value){
				alert("Login name can't be empty and should be Unique")
					FrmUser.txtLName.focus();
				return false;
				}
			if (!FrmUser.txtPswd.value){
				alert("password can't be empty")
					FrmUser.txtPswd.focus();
				return false;
				}
			if (!FrmUser.txtRole.value){
				alert("Choose Role ............")
					FrmUser.txtRole.focus();
				return false;
				}

			if (!FrmUser.txtPhone.value){
				alert("Phone no can't be empty")
					FrmUser.txtPhone.focus();
				return false;
				}
			if (!FrmUser.txtEmail.value){
				alert("Email can't be empty")
					FrmUser.txtEmail.focus();
				return false;
				}
		}
}

</script>
</head>
<body>
<%
Integer vid=0;
int DisRow=0;
%>


<% 	if ("Edit".equalsIgnoreCase(act) ) { %>

<form name="FrmUserEdit" action="users.jsp" method="post">

<table class="mytable" >
	<tr>
			<td align="right" colspan="7">
			<button type="submit" class="button-image" id="act" name="act" value="Update"> <img src="../images/icon_save.png"  height="30" width="30" alt="Save" /></button>  
			<button type="submit" class="button-image" id="act" name="act" value="Cancel"> <img src="../images/icon_delete.png"  height="30" width="30" alt="Cancel" /></button> 
			</td>
	</tr>
</table>
<table class="mytable">
<tr valign="top"> 
<td class="boxcontainer">
<div class="">
  <div class="titlebox" id="">
  <div class="titlebox-title">
        <span class="left"><%=act%> User</span>
  </div>
  <div class="titlebox-content " id="t1">
  <hr class="clear" />
  <table class="ticket-list collection-as-table">
   <tr class="collection-as-table">
	  	<%
	if (request.getParameter("txtUserid")!=null){
	obj.setUser_id(Integer.parseInt(request.getParameter("txtUserid")));
	usersDao user = new usersDao();
	user.searchUser(obj);
	{ %>
		
	<tr><td class="Blue-content">User ID</td><td><input type="text" readonly name="txtUserid" size="3" class="content style1" value=<%=obj.getUser_id()%> ></td></tr>
	<tr><td class="Blue-content">Name</td><td><input type="text" name="txtName" class="content style1" value=<%=obj.getUser_name()%>> </td></tr>
	<tr><td class="Blue-content">Login Name</td><td><input type="text" readonly name="txtLName" class="content style1" value=<%=obj.getLogin_name()%>> </td></tr>
	<tr><td class="Blue-content">Password</td><td><input type="password" name="txtPswd" class="content style1" value=<%=obj.getUser_password()%>></td></tr>


<tr><td class="Blue-content">Role</td><td>
<select id="role" name=txtRole size="1" class="content style1">
<option value="0">--Please Select--</option>
<%
LoginDao login = new LoginDao();
List<LoginBean> list =login.listRoles(oid);
Iterator<LoginBean> S = list.iterator(); 
while (S.hasNext()) {
objL = (LoginBean)S.next();
%>
<option value="<%=objL.getRole_id()%>"><%=objL.getRole_desc()%></option>
<% if(Integer.parseInt(objL.getRole_id())==obj.getUser_role()){%>
			<option value="<%=objL.getRole_id()%>" selected ><%=objL.getRole_desc()%></option> 
<% }
}
%>
</select>
</td></tr>
<tr><td class="Blue-content">Phone</td><td><input type="text" name="txtPhone" size="10" class="content style1" value=<%=obj.getContact_phone()%>></td></tr>
<tr><td class="Blue-content">Email</td><td><input type="text" name="txtEmail" size="30" class="content style1" value=<%=obj.getEmail()%>></td></tr>
 <%}%>
  <%}else { %>
		<tr><td align="center"><b>No User selected</b></td></tr>
	<%} %>
 
 </table>
</div>
</div>
</div>
</td>
</tr>
</table>
 
</form>
<% } else if ("Add".equalsIgnoreCase(act)){ %>

<form name="FrmUser" action="users.jsp" method="post" onsubmit="return checkForm()">

<table class="mytable" >
	<tr>
			<td align="right" colspan="7">
			<button type="submit" class="button-image" id="act" name="act" value="Insert"> <img src="../images/icon_save.png"  height="30" width="30" alt="Save" /></button>  
			<button type="submit" class="button-image" id="act" name="act" value="Cancel"> <img src="../images/icon_delete.png"  height="30" width="30" alt="Cancel" /></button> 
			</td>
	</tr>
</table>
<table class="mytable">
<tr valign="top"> 
<td class="boxcontainer">
<div class="">
  <div class="titlebox" id="">
  <div class="titlebox-title">
        <span class="left"><%=act%> User</span>
        
   
  </div>
  <div class="titlebox-content " id="t1">
  <hr class="clear" />
  <table class="ticket-list collection-as-table">
   <tr class="collection-as-table">
	<tr><td class="label">Name</td><td><input type="text" name="txtName" class="content style1" value=""> </td></tr>
	<tr><td class="label">Login Name</td><td><input type="text" name="txtLName" class="content style1" value=""></td></tr>
	<tr><td class="label">Password</td><td><input type="password" name="txtPswd" class="content style1" value=""></td></tr>
	<tr><td class="label">Role</td>
	<td>
	<select id="role" name=txtRole size="1" class="content style1">
	<option value="0">--Please Select--</option>
	<%
		LoginDao login = new LoginDao();
		List<LoginBean> list =login.listRoles(oid);
		Iterator<LoginBean> S = list.iterator(); 
		while (S.hasNext()) {
		objL = (LoginBean)S.next();
	%>
	<option value="<%=objL.getRole_id()%>"><%=objL.getRole_desc()%></option>
	<%} %>
	</select></td>
	</tr>
	<tr><td class="label">Phone</td><td><input type="text" name="txtPhone" class="content style1" value=""></td></tr>
	<tr><td class="label">Email</td><td><input type="text" name="txtEmail" class="content style1" value=""></td></tr>
	<tr><td class="label">Designation</td><td><input type="text" name="txtDesignation" class="content style1" ></td></tr>
	<tr> <td  align="right"><input type="hidden" value="insert" name="txtAct"></td></tr>
</table>
</div>
</div>
</div>
</td>
</tr>
</table>
</form>
	
<%
} 
else if (act==null || ("Update".equalsIgnoreCase(act)) || ("Cancel".equalsIgnoreCase(act))||("Insert".equalsIgnoreCase(act))||("Delete".equalsIgnoreCase(act))) 
{  
	if ("Update".equalsIgnoreCase(act)){
		
		obj.setUser_id(Integer.parseInt(request.getParameter("txtUserid")));
		obj.setUser_name(request.getParameter("txtName"));
		obj.setLogin_name(request.getParameter("txtLName"));
		obj.setUser_password(request.getParameter("txtPswd"));
		obj.setUser_role(Integer.parseInt(request.getParameter("txtRole")));
		obj.setContact_phone(request.getParameter("txtPhone"));
		obj.setEmail(request.getParameter("txtEmail"));
		obj.setDesignation(request.getParameter("txtDesignation"));
		usersDao user = new usersDao();
		user.updateUser(obj);
	}

if ("Insert".equalsIgnoreCase(act)){
	obj.setOid(oid);
	obj.setUser_name(request.getParameter("txtName"));
	obj.setLogin_name(request.getParameter("txtLName"));
	obj.setUser_password(request.getParameter("txtPswd"));
	obj.setUser_role(Integer.parseInt(request.getParameter("txtRole")));
	obj.setContact_phone(request.getParameter("txtPhone"));
	obj.setEmail(request.getParameter("txtEmail"));
	obj.setDesignation(request.getParameter("txtDesignation"));
		
	usersDao user = new usersDao();
	user.addUser(obj);
	}
if ("Delete".equalsIgnoreCase(act)){
		if(request.getParameter("txtUserid")==null){ %>
		<script> alert("no record selected!"); 
			history.go(-1);
		</script>
		<% } else{	
		usersDao user = new usersDao();
		user.delete(Integer.parseInt(request.getParameter("txtUserid")));
		}
	}
act="";
%>

<form name="FrmUserList" action="users.jsp" method="post">
<table class="mytable" >
	<tr>
			<td align="right" colspan="7">
			<button type="submit" class="button-image" id="act" name="act" value="Add"> <img src="../images/icon_add.png"  height="30" width="30" alt="Add" /></button>  
			<button type="submit" class="button-image" id="act" name="act" value="Edit" > <img src="../images/icon_edit.png"  height="30" width="30" alt="Add" /></button>
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
        <span class="left">User List <% %></span>
        
   
  </div>
  <div class="titlebox-content " id="t1">
  <hr class="clear" />
  <table class="ticket-list collection-as-table">
  <tr class="collection-as-table">
	<th class="collection-as-table">ID</th>
	<th class="collection-as-table">Name</th>
	<th class="collection-as-table">Login Name</th>
	<th class="collection-as-table">Role</th>
	<th class="collection-as-table">Phone</th>
	<th class="collection-as-table">Email</th>
	<th class="collection-as-table">Select</th>
</tr>

<% usersDao user = new usersDao();
			List<usersBean> list =user.viewAllUsers(oid);
			Iterator<usersBean> i = list.iterator();
			int x =0;
			while (i.hasNext())	{
				x++;
				obj = (usersBean)i.next();
				if ( (x%2) == 0 ) { %>
<tr class="oddline" > <%} else { %><tr class="evenline" >  <%}%>
<td class="content style"><%=x%></td><td class="content style"><%=obj.getUser_name()%></td>
<td class="content style"><%=obj.getLogin_name()%></td><td class="content style"><%=obj.getRole()%></td>
<td class="content style"><%=obj.getContact_phone()%></td><td class="content style"><%=obj.getEmail()%></td>
<td><input type="radio" name="txtUserid" value=<%=obj.getUser_id()%>></td>
</tr>
<%} %>

</table>
</div>
</div>
</div>
</td>
</tr>
</table>
<%} %> 

</form>
</body> 
</html>

