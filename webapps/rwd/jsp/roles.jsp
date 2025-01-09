
<%@ page import="java.util.*" %>

<%@page import="com.LoginDao"%>
<%@page import="com.LoginBean"%>
<jsp:useBean id="obj" class="com.LoginBean"/>
<jsp:setProperty property="*" name="obj"/>

<jsp:useBean id="objM" class="com.LoginBean"/>
<jsp:setProperty property="*" name="objM"/>


<%
//Sesssion Management
if(null == session.getAttribute("theName")){  
   response.sendRedirect("timeout.jsp");
}

Integer oid	= (Integer) session.getAttribute("theOid");


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
<link href="../styles/text.css" rel="stylesheet" type="text/css">

<title> Role Management </title>
<SCRIPT >


</SCRIPT>
</head>
<body>
<%
Integer vid=0;
int DisRow=0;
%>



<%if (act==null || ("Update".equalsIgnoreCase(act)) || ("Cancel".equalsIgnoreCase(act))||("Insert".equalsIgnoreCase(act))||("Delete".equalsIgnoreCase(act))) {
	LoginDao arole = new LoginDao();
	if ("Update".equalsIgnoreCase(act)){
		arole.updateRole(Integer.parseInt(vroleid),vname,mymenus);
		}
			
	if ("Insert".equalsIgnoreCase(act)){
		arole.addRole(oid,vname,mymenus);
		}

	if ("Delete".equalsIgnoreCase(act)){
		if (vroleid!=null) {
			arole.delRole(Integer.parseInt(vroleid));	
		 } else { %>
			<script> alert("no record selected!"); 
			history.go(-1);
			</script>
		<%}
		
	}

act="";
%>
<form action="roles.jsp" method="post" name="frmrlist" >
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
        <span class="left">Roles List <% %></span>
        
   
  </div>
  <div class="titlebox-content " id="t1">
  <hr class="clear" />
  <table class="ticket-list collection-as-table">
  <tr class="collection-as-table">
	<th class="collection-as-table">#</th>
	<th class="collection-as-table">Name</th>
	<th class="collection-as-table">select</th>
	<th class="collection-as-table">Menu(s) Assigned</th>
</tr>

			<%
			LoginDao role = new LoginDao();
			List<LoginBean> list1 =role.listRoles(oid);
			Iterator<LoginBean> D = list1.iterator();
			int x =0;
			while (D.hasNext()) {
			obj = (LoginBean)D.next();
			x++;
			if ( (x%2) == 0 ) { %>
			<tr class="evenline" > <%} else { %><tr class="oddline" >  <%}%>
			<td class="content style"><%=x%></td> 
			<td class="content style"><%=obj.getRole_desc()%></td>
			<td class="content style"><input type="radio" name="txtRoleid" value=<%=obj.getRole_id()%>></td>
			<!-- menu listing -->
			<td>
			<table>
			<% 
			LoginDao module = new LoginDao();
			List<LoginBean> list2 =module.listMenu(Integer.parseInt(obj.getRole_id()));
			Iterator<LoginBean> M = list2.iterator(); 
			while (M.hasNext()) {
			objM = (LoginBean)M.next();						
			%>
				<tr ><td class="content style"><%=objM.getModule()%></td><tr>
				<%}
				%>
			</table>
			<%	  DisRow++;	}
				if(DisRow==0)
			{	/*To write to the server if the resultset is null*/
			%>
			<tr><th colspan=6 class="content style1">No Records found</th></tr>
			<%} %>
</table>
</div>
</div>
</div>
</td>
</tr>
</table>



</form>
<% } else if ("Add".equalsIgnoreCase(act)){ 	%>
<form action="roles.jsp" method="post" name="frmradd" >

<table class="mytable" >
	<tr>
			<td align="right" colspan="7">
			<button type="submit" class="button-image" id="act" name="act" value="Insert"> <img src="../images/icon_save.png"  height="30" width="30" alt="Save" /></button>  
			<button type="submit" class="button-image" id="act" name="act" value="Cancel"> <img src="../images/icon_delete.png"  height="30" width="30" alt="Cancel" /></button> 
			</td>
	</tr>
</table>
<table class="mytable">
<tr valign="top"><td class="boxcontainer">
<div class="">
  <div class="titlebox" id="">
  <div class="titlebox-title">
        <span class="left"><%=act%> Role</span>
  </div>
  <div class="titlebox-content " id="t1">
  <hr class="clear" />
  <table class="ticket-list collection-as-table">
   <tr class="collection-as-table">
			<tr><td class="Blue-content">Role Name</td><td><input type="text" name="txtName" class="content style1" value=""> </td></tr>
			<tr><td class="Blue-content">Menu List</td><td>
			<% 		
			LoginDao role = new LoginDao();
			List<LoginBean> list1 =role.listModules(oid);
			Iterator<LoginBean> D = list1.iterator(); 
			while (D.hasNext()) {
			obj = (LoginBean)D.next();
			%>
			  <input name="options" type="checkbox" value="<%=obj.getModule_id() %>" > <%=obj.getModule()%><BR>
			<% }%>
			</td></tr>
</table>
</div>
</div>
</div>
</td>
</tr>
</table>
		 

</form>
<%} else if ("Edit".equalsIgnoreCase(act) ) { %>

<form action="roles.jsp" method="post" name="frmredit" >

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
        <span class="left"><%= act%> Role<% %></span>
        
   
  </div>
  <div class="titlebox-content " id="t1">
  <hr class="clear" />
  <table class="ticket-list collection-as-table">
		<%	if (vroleid!=null){
			LoginDao role = new LoginDao();
			obj.setRole_id(vroleid);
			role.findRole(obj);
		%>
		<tr><td class="Blue-content">Role ID</td><td><input type="text" readonly name="txtRoleid" class="content style1" value=<%=obj.getRole_id()%> ></td></tr>
		<tr><td class="Blue-content">Role Name</td><td><input type="text" name="txtName" class="content style1" value="<%=obj.getRole_desc()%>"> </td></tr>
		<tr><td class="Blue-content">Menu List</td><td>
		<%
		//LoginDao role = new LoginDao();
		List<LoginBean> list1 =role.listRoleMenu(Integer.parseInt(vroleid));
		Iterator<LoginBean> D = list1.iterator(); 
		while (D.hasNext()) {
		obj = (LoginBean)D.next();
		if (obj.getMenu_url()!=null){ %>
			  <INPUT name="options" type="CHECKBOX"  checked value="<%=obj.getModule_id()%>"> <%=obj.getModule()%><BR>
			  <%} else { %>
			 <INPUT name="options" type="checkbox"   value="<%=obj.getModule_id()%>"> <%=obj.getModule()%><BR>
			<%} }%>
			</td></tr> 
 	</table>
</div>
</div>
</div>
</td>
</tr>
</table>
			 <%} else { %>
				<script> alert("no record selected!"); 
				history.go(-1);
				</script>
			<%}%>
</form>
<%} %>
</body> 
</html>

