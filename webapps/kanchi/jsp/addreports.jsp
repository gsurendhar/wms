<%@ page import="java.util.*" %>
<%@page import="com.creportsDao"%>
<%@page import="com.creportsBean"%>
<jsp:useBean id="obj" class="com.creportsBean"/>
<jsp:setProperty property="*" name="obj"/>

<%
	String act = request.getParameter("act"); 
	String vrepid = request.getParameter("txtRepid");
	String vrepname = request.getParameter("txtRepname");
	String vreptitle = request.getParameter("txtReptitle");
	String vrepquery = request.getParameter("txtRepquery");
	String vreptemplate = request.getParameter("txtReptemplate");
 %>

<html>
<head>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
<title> Report Management </title>
</head>
<body>
<%
Integer vid=0;
int DisRow=0;
%>



<%if (act==null||"Update".equalsIgnoreCase(act)||"Cancel".equalsIgnoreCase(act)||"Insert".equalsIgnoreCase(act)||"Delete".equalsIgnoreCase(act) ) { 
		if ("Update".equalsIgnoreCase(act)){
			obj.setRepid(Integer.parseInt(vrepid));
			obj.setName(vrepname);
			obj.setTitle(vreptitle);
			obj.setQuery(vrepquery);
			obj.setTemplate(vreptemplate);
			creportsDao rep = new creportsDao();
			rep.updateReport(obj);
		}
		
		
		if ("Insert".equalsIgnoreCase(act)){
		vrepquery = vrepquery.replace( "'","''");
		obj.setRepid(Integer.parseInt(vrepid));
		obj.setName(vrepname);
		obj.setTitle(vreptitle);
		obj.setQuery(vrepquery);
		obj.setTemplate(vreptemplate);								
		creportsDao rep = new creportsDao();
		rep.addReport(obj);
		}
		if ("Delete".equalsIgnoreCase(act)){
			if(vrepid==null){ %>
				<script> alert("no report selected for Deletion!"); 
				history.go(-1);
				</script>
			<% } else{	
						creportsDao user = new creportsDao();
						user.delete(Integer.parseInt(vrepid));
					}
							}
		act="";
%>
<form name="listreports" action="addreports.jsp" method="post" name="frmentry" >
<table class="mytable" >
	<tr>
			<td align="right">
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
        <span class="left">Reports Admin</span>
  </div>
  <div class="titlebox-content " id="t1">
  <hr class="clear" />
  <table border="1" >
	<tr class="Blue-content"><td align="center">Report ID</td><td  align="center">Report Name</td>
	<td  align="center">Title</td><td  align="center">Query</td><td  align="center">Template</td><td  align="center">select</td>
	</tr>

	<%		creportsDao rep = new creportsDao();
			List<creportsBean> list =rep.viewAllReports();
			Iterator<creportsBean> i = list.iterator();
			int x =0;
			while (i.hasNext())	{
				x++;
				obj = (creportsBean)i.next();
				if ( (x%2) == 0 ) { %>
<tr class="oddline" > <%} else { %><tr class="evenline" >  <%}%>
<td class="content style"><%=x%></td><td class="content style"><%=obj.getName()%></td>
<td class="content style"><%=obj.getTitle()%></td><td class="content style"><%=obj.getQuery()%></td>
<td class="content style"><%=obj.getTemplate()%></td>
<td><input type="radio" name="txtRepid" value=<%=obj.getRepid()%>></td>
</tr>
<%} %>
</table>
</div></div></div></td></tr>
</table>
</form>

<%}  else if ("Edit".equalsIgnoreCase(act) ) {%>
<form name="frmedit" action="addreports.jsp" method="post" name="frmentry" >
	<table class="mytable" >
	<tr>
		<td width="80%" align="Center" class="Headings"><%=act%> Report</td>
		<td width="80%" align="right">
			<button type="submit" class="button-image" id="act" name="act" value="Update"> <img src="../images/icon_save.png"  height="30" width="30" alt="Save" /></button>  
			<button type="submit" class="button-image" id="act" name="act" value="Cancel"> <img src="../images/icon_delete.png"  height="30" width="30" alt="Cancel" /></button> 
		</td>
	</tr>
	</table>
<table class="mytable">
<tr valign="top"><td class="boxcontainer">
<div class="">
  <div class="titlebox" id="">
  <div class="titlebox-title">
        <span class="left"><%=act%> User</span>
  </div>
  <div class="titlebox-content " id="t1">
  <hr class="clear" />
  <table class="ticket-list collection-as-table">
   
		<%
				
		if (vrepid!=null){
			creportsDao rep = new creportsDao();
			obj.setRepid(Integer.parseInt(vrepid));
			rep.getReport(obj);
			{ %>
		<tr><td class="Blue-content">Report ID</td><td width="80%"><input type="text" readonly name="txtRepid" class="content style1" size="3" maxlength="4" value=<%=obj.getRepid()%> ></td></tr>
		<tr><td class="Blue-content">Report Name</td><td><input type="text" name="txtRepname" class="content style1" size="25" maxlength="30" value="<%=obj.getName()%>" ></td></tr>
		<tr><td class="Blue-content">Title</td><td><input type="text" name="txtReptitle" size="25" maxlength="30" class="content style1" value="<%=obj.getTitle()%>" ></td></tr>
		<tr><td class="Blue-content">Query</td><td><textarea name="txtRepquery" class="content style1" cols="80" rows="10" ><%=obj.getQuery()%> </textarea></td></tr>
		<tr><td class="Blue-content">Template</td><td><input type="text" name="txtReptemplate" class="content style1" size="25" maxlength="30" value="<%=obj.getTemplate()%>" ></td></tr>
		<%} 
			}%>
</table>
	</div>
	</div>
</div>
</td></tr>
</table>


</form>
 
<%} else if ("Add".equalsIgnoreCase(act) ) {%>
<form name="frmad" action="addreports.jsp" method="post" name="frmentry" >
	<table class="mytable" >
	<tr>
		<td width="80%" align="Center" class="Headings"><%=act%> Report</td>
		<td width="80%" align="right">
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
        <span class="left"><%=act%> Reports</span>
  </div>
  <div class="titlebox-content " id="t1">
  <hr class="clear" />
  <table class="ticket-list collection-as-table">
   <tr class="collection-as-table">
	<td class="Blue-content">Report Name</td><td><input type="text" name="txtRepname" class="content style1" size="25" maxlength="30" value="" ></td></tr>
<tr><td class="Blue-content">Title</td><td><input type="text" name="txtReptitle" size="25" maxlength="30" class="content style1" value="" ></td></tr>
<tr><td class="Blue-content">Query</td><td><textarea name="txtRepquery" class="content style1" cols="80" rows="10"></textarea></td></tr>
<tr><td class="Blue-content">Template</td><td><input type="text" name="txtReptemplate" class="content style1" size="25" maxlength="30" value="adhoc4.jsp" ></td></tr>
</table>
</div>
</div>
</div>
</td>
</tr>
</table>

</form>
<%}%>
</body> 
</html>

