<%@ page language="java" %>
<%@ page language="java" import="com.ConnectionProvider" %> 
<%@ page import="java.io.*,java.sql.*,java.text.*"%>


<script>
function params(){
var vid1 = document.getElementById("state").value
var vid2 =document.getElementById("district").value
var vid3 =document.getElementById("location").value
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
window.location.replace("recovery.jsp?value1="+vid1+"&&value2="+vid2+"&&value3="+vid3+"&&vfdate="+vfdate+"&&vtdate="+vtdate);
}

function find(){
var vid1 = document.getElementById("txtFind").value
alert(vid1);
window.location.replace("recovery.jsp?find="+vid1);

}


</script>

<%!
Connection con=null;
ResultSet rs=null;
ResultSet rs1=null;
Statement stmt=null;
Statement stmt2=null;
String query="";
ResultSetMetaData md;
PreparedStatement pst = null;
int reccount;
int rscount;
int[] vid;
%>
<%

String value1=request.getParameter("value1");
String value2=request.getParameter("value2");
String value3=request.getParameter("value3");
String vfdate=request.getParameter("vfdate");
String vtdate=request.getParameter("vtdate");
String act = request.getParameter("act"); 
String find=request.getParameter("find");
//out.println(find);

if (find!=null){
query="select clientid,state,district,county,location from station_configs_det where clientid='"+find+"'";	
	rs=stmt.executeQuery(query);
	while(rs.next()){
		value1=rs.getString("state");
		value2=rs.getString("district");
		value3=rs.getString("county");
	}
}


if (value1==null){value1="0";}
if (value2==null){value2="0";}
if (value3==null){value3="0";}
//if (find==null){find="0";}


DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());


if(vfdate == null){ 
 vfdate=formattedDate;
 vtdate=formattedDate;
}

con = ConnectionProvider.getCon();
stmt=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
stmt2=con.createStatement();
//pst=con.prepareStatement("select packet_recovery(?)");
rs = stmt.executeQuery("select param_id as sid,group_value as state from parameter where active='Y' and group_family='LOCATION' and Group_name='STATE'");
%>
<html>
<head>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../Script/datepicker.js"></script>
</head>
<body bgcolor="#DBEBFF">
<form action="recovery.jsp" method="post" name="frmentry" >


<input type="hidden" name="value1" value="<%=value1%>">
<input type="hidden" name="value2" value="<%=value2%>">
<input type="hidden" name="value3" value="<%=value3%>">
<input type="hidden" name="vfdate" value="<%=vfdate%>">
<input type="hidden" name="vtdate" value="<%=vtdate%>">

<table width="100%" border="0" class=border cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP id="stretch"  >
<tr><td width="10%" VALIGN=TOP>
<table width="10%" border="0" class=border cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>

<!--   date selection starts here -->

<tr><td class="Blue-content" colspan="4"><b>Select Date Range</b></td></tr>
<tr><td class="content style1" align="right"><b>From</b></td>
<td><input id="fdate"  class="content style1" type="text" name="fdate" size="10" maxlength="12" value=<%=vfdate%>>
<a href="javascript:NewCal('fdate','ddmmyyyy',false)"><img src="../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a></td>
</tr>
<tr><td class="content style1" align="right"><b>To</b></td>
<td><input id="tdate"  class="content style1" type="text" name="tdate" size="10" maxlength="12" value=<%=vtdate%>>
<a href="javascript:NewCal('tdate','ddmmyyyy',false)"><img src="../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a></td>
</tr>
 <!-- date selection Ends here -->

<tr><td class="Blue-content" colspan="6" align="left">Select Station</td></tr>
<!-- <tr><td class="content style1"><b> ID </b></td>
	<td><input type=text name="txtFind"  class="content style1" value="<%=find%>" size="5">
	<input class="content style1" type="submit" value="Search" onClick="find()"></td></tr> -->

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

<%
query="select * from station_configs_det ";
query=query+" where state="+value1+" and district="+value2+" order by location";
rs=stmt.executeQuery(query);
%>
<tr><td class="content style1"><b> Stations</b> </td>
<td class="content style1" align="left"  >
<select id="location" onchange="params()" class="content style1" size="20">
<option value="0">--Please Select--</option>
<%

while(rs.next()){
%>
<option value="<%=rs.getInt("clientid")%>" ><%=rs.getString("location")%></option>
<% if(rs.getString("clientid").equals(value3)){%>
<option value="<%=value3%>" selected disabled><%=rs.getString("location")%></option>
<%
}
}
%>
</select>
</td></tr>
<tr><td colspan=2 align="center"><input type="submit"  name="act" value="Search"><input type="submit"  name="act" value="Recover"></td></tr>



</table>
</td>
<td valign=top>
<table width="100%" border="0" class=border cellpadding="0" cellspacing="0" id="stretch" > 
	<% 	if ("Search".equalsIgnoreCase(act)&& value3!=null &&vfdate !=null && vtdate!=null ) {
		query="select check_messages("+value3+",'"+vfdate+"','"+vtdate+"')";
		//out.println(query);
		rs=stmt.executeQuery(query);
while (rs.next()){ %>
	<tr class="readonly" align="center"><td colspan="6">Found <%=rs.getString(1)%> missing packets </td></tr>	
	<% 
	}
	
	query="select id as Recover_id,clientid,to_char(fromtime,'DD/MM/YYYY HH24:MI') as Start_time,to_char(to_time,'DD/MM/YYYY HH24:MI') as End_time from packet_recovery where clientid="+value3;
		rs=stmt.executeQuery(query);
		md = rs.getMetaData();
		int count = md.getColumnCount();
		rs.last();
		rscount=rs.getRow();
		rs.beforeFirst();
		vid=new int[rscount];
		int j=0;
	%>
<tr class="Blue-content">
<%
for (int i=1; i<=count; i++) {
	out.print("<td>");
	out.print((md.getColumnName(i)));
	out.print("</td>");
	}
	out.print("<td>");
//	out.print("Select");
	out.print("</td>");

out.println("</tr>");
while(rs.next()){
%>
<tr  class="readonly">
<%	for (int i=1; i<=count; i++) {
		out.print("<td>");
		out.print(rs.getString(i));
		out.print("</td>");
	}
	out.print("<td>");
	out.print("<input type=checkbox name=select checked=true");
	out.print("</td>");
	out.println("</tr>");
	//for(int i=0;i<rscount;i++){
		vid[j]=rs.getInt(1);
		j++;
	//}
			}	

	}
if ("Recover".equalsIgnoreCase(act)&& value3!=null &&vfdate !=null && vtdate!=null ) {
	reccount=stmt2.executeUpdate("truncate table messages_in");
	for(int j=0;j<rscount;j++){
		query="select packet_recovery("+vid[j]+")";
		//out.println(query);
		rs1=stmt2.executeQuery(query);
	}
	reccount=stmt2.executeUpdate("insert into ozekimessageout(receiver,msg,status,receivedtime,operator)  select distinct phone_no,message,'send',now(), operator from messages_in");
	%>
<tr class="readonly" align="center"><td colspan="6">Recovery Initiated for missing packets. check the logs if messages has been submited </td></tr>	
<% }  %>


</table>



</table>
</td></tr>
</table>
<%
rs.close();
%>
</form>
</body>
</html>
