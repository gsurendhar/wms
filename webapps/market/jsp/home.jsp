<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%!
Connection con=null;
Connection con1=null;
ResultSet rs=null;
ResultSet rs1=null;
Statement stmt=null;
Statement stmt1=null;
Integer Vmoduleid=0;
String Vroleid=null;
String query="";

%>
<script>

function search(){
var vid4 = document.getElementById("searchBox").value;
var search=vid4.toUpperCase();
// window.open("jsp/reports/sharedet.jsp?type=SPOT&&vTchg=35&&scrip="+search);
window.open("jsp/intraday/intradayeq.jsp);
}
}
</script> 

<%

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
	con1=(Connection)session.getAttribute("connection");
	stmt1 =  con.createStatement();
	
}
catch(Exception e)
{
	//System.out.println("Exception"+e);
	%><%=e%><%
}

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Market Analysis</title>
<link href="css/jquery.ennui.contentslider.css" rel="stylesheet" type="text/css" media="screen,projection" />

<link href="styles/wavereportstyles.css" type="text/css" rel="stylesheet"  />
<link href="styles/dropdowncss.css" type="text/css" rel="stylesheet"  />
<link href="styles/text.css" rel="stylesheet" type="text/css" />



<script src="Script/dropdownjs.js" language="javascript" type="text/javascript"></script>


<link href="libs/jqueryui/1.8/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="libs/jquery/1.4/jquery.min.js"></script>
<script src="libs/jqueryui/1.8/jquery-ui.js"></script>




<script>
	$(document).ready(function() {
		var myArr = [];
	
		$.ajax({
			type: "GET",
			url: "jsp/shares.xml", // change to full path of file on server
			dataType: "xml",
			success: parseXml,
			complete: setupAC,
			failure: function(data) {
				alert("XML File could not be found");
				}
		});
	
		function parseXml(xml)
		{
			//find every query value
			$(xml).find("share").each(function()
			{
				myArr.push($(this).attr("label"));
			});	
		}
		
		function setupAC() {
			$("input#searchBox").autocomplete({
					source: myArr,
					minLength: 1,
					select: function(event, ui) {
						$("input#searchBox").val(ui.item.value);
						$("#searchForm").submit();
					}
			});
		}
	});
</script>



<style>
#menuwrapper, #p7menubar ul a {height: 1%;}
a:active {width: auto;}
</style>

</head>

 
<body onload="ExpMenu();">

<table width="100%" border="0" cellpadding="0" cellspacing="0" id="stretch"> 
<tr height="100%" valign="center"> 
<td colspan="2" valign="center" height="100%">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF"> 
		<!-- <tr><td height="100%" align="left" valign="bottom" scope="col"><img src="images/logo.gif" width="100" height="50"></td> -->
		<tr>
		<td class="content style1" align="right"><b>CODE</b> 
<!-- 		<input type=text id="txtSearch" name="txtSearch"  class="content style1" value="" size="10">
		<input class="content style1" type="submit" value="Search" onClick="search()"></td> 
-->
		<input class="content style1" type="text" id="searchBox" name="searchString" />
  		<button name="searchKeyword" id="searchKeyword" value="Search" onClick="search()" >Sumbit</button>
		</tr>

		<tr>
		<td align="right" class="content style1">
		<script type="text/javascript">
			var currentTime = new Date()
			var month = currentTime.getMonth() + 1
			var day = currentTime.getDate()
			var year = currentTime.getFullYear()
			document.write(day + "/" + month + "/" + year)
		</script>
		</td></tr>
<!-- 		<tr><td background="../images/Logo_bottom.jpg" colspan="2" scope="col"><img src="../images/Logo_bottom.jpg" width="3" height="4"></td></tr> -->
	</table>
</td>
</table>
<table>
	<tr height="100%" valign="center">
<%	rs1=stmt1.executeQuery("select module_id as id,module_name as name,(case when module_url ='' then 'blank.jsp' else module_url end) as url  from module where module_id in (select module_id from role_privilages where role_id="+session.getAttribute("theRole")+") order by 1");%>
		<table width="100%" border="1">
		<div id="menuwrapper">
		<ul id="p7menubar"> 
	<%  while(rs1.next()){ 
		Vmoduleid=rs1.getInt(1);
	%>
		 
		 <li><a class="trigger" href="<%=rs1.getString("url")%>" target="frame1"><%=rs1.getString("name")%></a><ul>
		 <% rs = stmt.executeQuery("select module_id,menu_id,menu_name,menu_url from module_menu where module_id="+Vmoduleid+" order by 1,2"); %>
		 <%while(rs.next()){%>
			<li><a href="<%=rs.getString("menu_url")%>" target="frame1"><%=rs.getString("menu_name")%></a></li>
		<%}
		 if ("Reporting".equalsIgnoreCase(rs1.getString(2))){
					rs = stmt.executeQuery("select rep_id,rep_name,rep_template from reports"); 
					while(rs.next()){%>
					<li><a href="reports/<%=rs.getString("rep_template")%>?id=<%=rs.getString("rep_id")%>" target="frame1"><%=rs.getString("rep_name")%></a></li>
		 
		 <%
					}
		 }

		 %>
			
			
			</ul></li>
	<%}%>
			<li><a href="index.jsp" title="Logout" onclick="javascript: return submit_Confirm();">Logout </a></li>
		</ul>


<br class="clearit">
</div>
<!-- <iframe name="frame1" src="jsp/reports/shares.jsp" width="100%" height="1000" frameborder="0" ></iframe> -->
<iframe name="frame1" src="jsp/intraday/intradayeq.jsp" width="100%" height="1000" frameborder="0" ></iframe>
</tr>
</table>

</table>
</body>
</html>

