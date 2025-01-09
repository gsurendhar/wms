<!--  Adhoc4.jsp needs 4 inputs - Date1, Date2, String1,String2 in the Query  -->

<%@ page language="java" %>
<%@ page language="java" import="com.ConnectionProvider" %> 
<%@ page import="java.io.*,java.sql.*,java.text.*"%>



<script>

function params(){
var vid1 = document.getElementById("state").value
var vid2 =document.getElementById("district").value
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
var vftime= document.getElementById("ftime").value
var vttime= document.getElementById("ttime").value
window.location.replace("adhoc6.jsp?value1="+vid1+"&&value2="+vid2+"&&vfdate="+vfdate+"&&vtdate="+vtdate+"&&vftime="+vftime+"&&vttime="+vttime);
}


</script>

<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
String query="";
ResultSetMetaData md;
String rep_title="";
String repquery="";
PreparedStatement pst = null;
String e; 
%>
<%
String id=request.getParameter("id");
String value1=request.getParameter("value1");
String value2=request.getParameter("value2");
String vfdate=request.getParameter("vfdate");
String vtdate=request.getParameter("vtdate");
String vttime=request.getParameter("vttime");
String vftime=request.getParameter("vftime");
String vparam=request.getParameter("param");

if (value1==null){value1="0";}
if (value2==null){value2="0";}
if (vftime==null){vftime="00";}
if (vttime==null){vttime="00";}






DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());


if(vfdate == null){ 
 vfdate=formattedDate;
 vtdate=formattedDate;
}

String vfdatetime=vfdate+' '+vftime;
String vtdatetime=vtdate+' '+vttime;

con = ConnectionProvider.getCon();
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
<!--   date selection starts here -->

<tr><td class="Blue-content" colspan="4"><b>Select Date Range</b></td></tr>
<tr><td class="content style1" align="right"><b>From</b></td>
<td><input id="fdate"  class="content style1" type="text" name="fdate" size="10" maxlength="12" value=<%=vfdate%>>
<a href="javascript:NewCal('fdate','ddmmyyyy',false)"><img src="../../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a>
<select id="ftime" name="ftime" class="content style1">
<% for (int i=0; i<24; i++) {
	e=Integer.toString(i);
	if (e.length()==1){e="0"+e;}%>
<option value="<%=e%>"><%=e%></option>
<%}%>
<option value=<%=vftime%> selected><%=vftime%></option>
</select><a class="content style1">Hrs</a>
</td></tr>

<tr><td class="content style1" align="right"><b>To</b></td>
<td><input id="tdate"  class="content style1" type="text" name="tdate" size="10" maxlength="12" value=<%=vtdate%>>
<a href="javascript:NewCal('tdate','ddmmyyyy',false)"><img src="../../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a>
<select id="ttime" name="ttime" class="content style1">
<% for (int i=0; i<24; i++) {
	e=Integer.toString(i);
	if (e.length()==1){e="0"+e;}%>
<option value="<%=e%>"><%=e%></option>
<%}%>
<option value=<%=vttime%> selected disabled><%=vttime%></option>
</select><a class="content style1">Hrs</a>
</td></tr>
 <!-- date selection Ends here -->

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
<option value="-1">All</option>

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
	<tr><td class="Headings" align="center" width="80%"><%=rep_title%> </td></tr>
	<tr><td class="content" align="center" width="80%">for Date/Time Range <%=vfdatetime%>:00 Hrs to <%=vtdatetime%>:00Hrs</td></tr>

<tr><td colspan=2><table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" > 

<%
try {
pst = con.prepareStatement(repquery); 
//pst.setString(1,vfdate);
//pst.setString(2,vtdate);

pst.setString(1,vfdatetime);
pst.setString(2,vtdatetime);
pst.setString(3,value1);
pst.setString(4,value2);


}
catch (Exception e) {
		out.println ("<tr class=red><td colspan=2>Oh oops - check your SQL\n -"+repquery+"  - "+e+"</td></tr>");
                }





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
%>

</body>
</html>
