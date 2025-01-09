<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="javax.servlet.*,java.text.*" %>

<%@ page import="java.util.*" %>
<%@page import="com.LoginDao"%>
<%@page import="com.LoginBean"%>


<%!
Integer Vmoduleid=0;
String Vroleid=null;
String query="";
int count;
%>
<%

if(null == session.getAttribute("theName")){  
  // User is not logged in.
  out.println("your Session has expired");
  response.sendRedirect("../index.jsp?invalid=0");
}

out.println(session.getAttribute("theOid"));
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>WMS Administrator</title>
<link href="../styles/dropdowncss.css" type="text/css" rel="stylesheet"  />
<script src="../Script/dropdownjs.js" language="javascript" type="text/javascript"></script>

<style>
#menuwrapper, #p7menubar ul a {height: 1%;}
a:active {width: auto;}
</style>
</head>

<body onload="ExpMenu();">

<table width="100%" id="stretch"> 
<tr><td colspan="2" >
	<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF"> 
		<tr><td height="100%" align="left" valign="bottom" scope="col">
		<img src="../images/Logo.jpg" width="100" height="50" />
		</td><td align="right" class="Blue-content">
		<script type="text/javascript">
			var currentTime = new Date()
			var month = currentTime.getMonth() + 1
			var day = currentTime.getDate()
			var year = currentTime.getFullYear()
			document.write(day + "/" + month + "/" + year)
		</script>
		</td></tr>
		<tr><td  background="../images/Logo_bottom.jpg" colspan="2" scope="col"> <img src="../images/Logo_bottom.jpg" width="3" height="3" /></td></tr>
	</table>
</td></tr>
<tr><td>
	<table width="100%" border="0">
		<tr><td>
		<div id="menuwrapper">
		<ul id="p7menubar"> 
		<% 	Integer rid	= (Integer) session.getAttribute("theRole");
					LoginDao menu = new LoginDao();
					LoginBean lb = new LoginBean();
					List<LoginBean> list1 =menu.listMenu(rid);
					Iterator<LoginBean> S = list1.iterator(); 
					while (S.hasNext()) {
					lb = (LoginBean)S.next();
					Vmoduleid=lb.getModule_id();
		%>
	
		 <li><a class="trigger" href="<%=lb.getMenu_url()%>" target="frame1"><%=lb.getModule()%></a><ul>
		 <% 
				 	LoginDao menus = new LoginDao();	 
				 	LoginBean lb1 = new LoginBean();
					List<LoginBean> listMM =menus.listMenus(Vmoduleid);
					Iterator<LoginBean> M = listMM.iterator(); 
					while (M.hasNext()) {
					lb1 = (LoginBean)M.next();
					%>
					<li><a href="<%=lb1.getMenu_url()%>" target="frame1"><%=lb1.getModule()%></a></li>
					
					<% }
					
					if ("Reporting".equalsIgnoreCase(lb.getModule())){
							out.println("<b>Custom Reports</b>");
							LoginDao reports = new LoginDao();	 
						 	LoginBean lbreports = new LoginBean();
							List<LoginBean> listR =reports.listCreports();
							Iterator<LoginBean> R = listR.iterator(); 
							while (R.hasNext()) {
							lbreports = (LoginBean)R.next();
					%>
				<li><a href="reports/<%=lbreports.getMenu_url()%>?id=<%=lbreports.getModule_id()%>" target="frame1"><%=lbreports.getModule()%></a></li>
					<%							} 
																		}
					%>
					
					
		 			
		</ul></li>
	<%}%>
			<li><a href="uprofile.jsp" target="frame1">Edit Profile</a></li>
			<li><a href="../" title="Logout" onclick="javascript: return submit_Confirm();">Logout </a></li>
		</ul>
<br class="clearit"/>
		</div>
		</td></tr>
	</table>
</td></tr>
<tr><td>
<iframe name="frame1" src="dashboard.jsp" width="100%" height="810"></iframe>
</td></tr>
</table>

</body>
</html>
