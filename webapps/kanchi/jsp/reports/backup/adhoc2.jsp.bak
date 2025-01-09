<!--  Adhoc2.jsp needs 2 inputs String1,String2 in the Query  -->

<%@ page language="java" %>
<%@ page language="java" import="wms.dbconnect.DBPostgres" %> 
<%@ page import="java.io.*,java.sql.*,java.text.*"%>



<script>

function params(){
var vid1 = document.getElementById("state").value
var vid2 =document.getElementById("district").value
var vparam= document.getElementById("param").value
var id= document.getElementById("id").value
window.location.replace("/wms/jsp/reports/adhoc2.jsp?id="+id+"&&value1="+vid1+"&&value2="+vid2);
}

function expxl(){
var	id= document.getElementById("id").value
var vid1 = document.getElementById("state").value
var vid2 =document.getElementById("district").value
var vparam= document.getElementById("param").value
window.location.replace("/wms/jsp/reports/adhoc2.jsp?value1="+vid1+"&&value2="+vid2+"&&param="+vparam);
}

</script>

<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
String query="";
ResultSetMetaData md;
String rep_id="";
String rep_title="";
String repquery="";
PreparedStatement pst = null;
%>
<%
String id=request.getParameter("id");
String value1=request.getParameter("value1");
String value2=request.getParameter("value2");
String vparam=request.getParameter("param");

if (value1==null){value1="0";}
if (value2==null){value2="0";}




con = DBPostgres.getConnection();
stmt=con.createStatement();

if (id!=null){
rs = stmt.executeQuery("select * from reports where rep_id="+id);
while(rs.next()){
	rep_title=rs.getString("rep_title");
	repquery=rs.getString("rep_query");
}
}

rs = stmt.executeQuery("select param_id as sid,group_value as state from parameter where active='Y' and group_family='LOCATION' and Group_name='STATE'");
%>
<html>
<head>
<link href="../../styles/text.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../Script/datepicker.js"></script>
</head>
<body>

<table width="100%" border="1" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
<tr><td width="10%" VALIGN=TOP>
<table width="10%" border="1" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
<input type="hidden" name="id" value=<%=id%> >


<tr><td class="Blue-content" colspan="6" align="left">Select Station</td></tr>
<tr><td class="content style1"><b> State </b></td>
<td>
<select id="state" onchange="params()" class="content style1">
<option value="0">--Please Select--</option>
<% while(rs.next()){ %>
<option value="<%=rs.getInt("sid")%>"><%=rs.getString("state")%></option>

<% if(rs.getString("sid").equals(value1)){%>
<option value="<%=value1%>" selected disabled><%=rs.getString("state")%></option> 
<%
}

}
%>
</select> </td></tr>
<tr><td class="content style1"><b> District</b> </td><td>
<select id="district" onchange="params()" class="content style1">
<option value="0">--Please Select--</option>

<%
rs=stmt.executeQuery("select param_id as did,group_value as district from parameter where active='Y' and group_family='LOCATION' and Group_name='DISTRICT' and parent_group='"+value1+"' order by group_value");

while(rs.next()){
%>
<option value="<%=rs.getInt("did")%>" ><%=rs.getString("district")%></option>
<% if(rs.getString("did").equals(value2)){%>
<option value="<%=value2%>" selected disabled><%=rs.getString("district")%></option>
<%
}
}
%>
</select>
</td></tr>
</table>
</td>
<td valign=top>

<table width="100%" border="0" cellpadding="0" cellspacing="0" id="stretch" > 
	<tr><td class="Headings" align="center" width="80%"><%=rep_title %></td>
	<td align="right"><input type="image" src="../../images/excel.jpg" alt="Submit" name="param" value="export" onclick="expxl()"></td>
	</tr>

<tr><td colspan=2><table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" > 

<%

//out.println(repquery);

pst = con.prepareStatement(repquery); 
pst.setString(1,value1);
pst.setString(2,value2);



rs = pst.executeQuery();


md = rs.getMetaData();
int count = md.getColumnCount();
//out.println(count);

%>
<tr class="Blue-content">
<%
for (int i=1; i<=count; i++) {
	out.print("<td>");
	out.print(md.getColumnName(i));
	out.print("</td>");
	}
out.println("</tr>");

while(rs.next()){
%>
<tr  class="readonly">
<%	for (int i=1; i<=count; i++) {
		out.print("<td>");
		out.print(rs.getString(i));
		out.print("</td>");
	}
	out.println("</tr>");
}


%>

</tr></table>

</table>



	</table>
</td></tr>
</table>
<%
rs.close();
con.close();
%>

</body>
</html>
