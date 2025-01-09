<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="javax.servlet.*,java.text.*" %>

<%@ page import="java.util.*" %>

<%@page import="com.orgDao"%>
<jsp:useBean id="obj" class="com.orgBean"/>
<jsp:setProperty property="*" name="obj"/>

<%@page import="com.locationDao"%>
<%@page import="com.locationBean"%>
<jsp:useBean id="objL" class="com.locationBean"/>
<jsp:setProperty property="*" name="objL"/>


<%
//Sesssion Management
if(null == session.getAttribute("theName")){  
 response.sendRedirect("timeout.jsp");
}

String act=request.getParameter("act");
Integer oid	= (Integer) session.getAttribute("theOid");

locationDao location = new locationDao();


if ("Update".equalsIgnoreCase(act)){
	obj.setOid((Integer) session.getAttribute("theOid"));
	obj.setName(request.getParameter("txtorg"));
	obj.setAddress1(request.getParameter("txtaddr1"));
	obj.setAddress2(request.getParameter("txtaddr2"));
	obj.setCity(request.getParameter("txtcity"));
	obj.setEmail(request.getParameter("txtemail"));
	obj.setEmail(request.getParameter("txtemail"));
	obj.setDstateid(Integer.parseInt(request.getParameter("cmbstate")));
	orgDao org = new orgDao();
	org.update(obj);
	}
%>

<html>
<head>
<link href="../styles/text.css" rel="stylesheet" type="text/css" />
<script language="javascript">
			function validate(objForm){
				
				if(objForm.txtorg.value.length==0){
					alert("Please enter  Organization Name!");
					objForm.txtorg.focus();
					return false;
				}
				
				if(objForm.txtaddr.value.length==0){
					alert("Please enter Address !");
					objForm.txtaddr.focus();
					return false;
				}
				if(objForm.txtemail.value.length==0){
					alert("Please enter Email address !");
					objForm.txtaddr.focus();
					return false;
				}
				return true;
			}
</script>
</head>
<body>

<form name="frmorg" action="orgprofile.jsp" method="post">
<table width="100%" border="0" cellpadding="0" cellspacing="0" id="stretch"> 
<tr>
			<td  align="right" colspan="2">
			<button type="submit" class="button-image" name="act" value="Update"> <img src="../images/icon_save.png"  height="30" width="30" alt="Add" /></button>
			<!-- <button type="submit" class="button-image" name="act" value="Edit"> <img src="../images/icon_edit.png"  height="30" width="30" alt="Add" /></button>
			<button type="submit" class="button-image" name="act" value=refresh> <img src="../images/icon_refresh.png"  height="30" width="30" alt="reset" /></button> -->
			</td>
</tr>
<tr><td class="Blue-content">Organization Details</td></tr>
	<%
	
	obj.setOid(oid);	
	orgDao org = new orgDao();
	org.findOrg(obj);
					
	 %>
	<tr><td class="label">Name:</td><td><input class="content style1" type=text name=txtorg size="30"  maxlength="50" value="<%=obj.getName()%>" /></td></tr>
	<tr><td class="label">Address1:</td><td><input class="content style1" type=text name=txtaddr1 size="30"  maxlength="50" value="<%=obj.getAddress1()%>" /></td></tr>
	<tr><td class="label">Address2:</td><td><input class="content style1" type=text name=txtaddr2 size="30"  maxlength="50" value="<%=obj.getAddress2()%>" /></td></tr>
	<tr><td class="label">City:</td><td><input class="content style1" type=text name=txtcity size="30"  maxlength="50" value="<%=obj.getCity()%>" /></td></tr>
	<tr><td class="label">Email:</td><td><input class="content style1" type=text name=txtemail size="30"  maxlength="50" value="<%=obj.getEmail()%>" /></td></tr>
	<tr><td class="label">Default State for Site:</td>
	<td>
		<select id="state" name=cmbstate  class="content style1">
			<option value="0">--Please Select--</option>
			<% 
			List<locationBean> list1 =location.viewStates();
			Iterator<locationBean> S = list1.iterator(); 
			while (S.hasNext()) {
			objL = (locationBean)S.next();
			%>
			<option value="<%=objL.getStateid()%>"><%=objL.getSname()%></option>
			<% if(objL.getStateid()==obj.getDstateid()){%>
			<option value="<%=obj.getDstateid()%>" selected ><%=objL.getSname()%></option> 
			<%			}	 
				}%>
			</select> </td></tr>
		
</table>
</form>
</body> 
</html>

