<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %> 
<%@ page import="java.text.*" %>

<script>


function parameter(){
var vid1 = document.getElementById("state").value
		if (vid1==null || vid1==""){vid1=0;}
var vid2 = document.getElementById("district").value
		if (vid2==null || vid2==""){vid2=0;}
var vid3 = 0
var vid4 = 0
//var vid3 = document.getElementById("county").value
//		if (vid3==null || vid3==""){vid3=0;}
//var vid4 = document.getElementById("location").value
//		if (vid4==null || vid4==""){vid4=0;}
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
//var vparam= document.getElementById("param").value
window.location.replace("reported.jsp?value1="+vid1+"&&value2="+vid2+"&&value3="+vid3+"&&value4="+vid4+"&&vfdate="+vfdate+"&&vtdate="+vtdate);
}


</script>



<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
Statement stmt2=null;
String query="";
int count;
%>
<%
String value1=request.getParameter("value1");
String value2=request.getParameter("value2");
String value3=request.getParameter("value3");
String value4=request.getParameter("value4");
if (value1==null){value1="0";}
if (value2==null){value2="0";}
if (value3==null){value3="0";}
if (value4==null){value4="0";}

String vfdate=request.getParameter("vfdate");
String vtdate=request.getParameter("vtdate");

DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());

if(vfdate == null){ 
 vfdate=formattedDate;
 vtdate=formattedDate;
}

con = ConnectionProvider.getCon();
stmt=con.createStatement();
stmt2=con.createStatement();
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
<!--   date selection starts here -->

<tr><td class="Blue-content" colspan="4"><b>Select Date Range</b></td></tr>
<tr><td class="content style1" align="right"><b>From</b></td>
<td><input id="fdate"  class="content style1" type="text" name="fdate" size="10" maxlength="10" value=<%=vfdate%>>
<a href="javascript:NewCal('fdate','ddmmyyyy',false)"><img src="../../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a></td>
</tr>
<tr><td class="content style1" align="right"><b>To</b></td>
<td><input id="tdate"  class="content style1" type="text" name="tdate" size="10" maxlength="10" value=<%=vtdate%>>
<a href="javascript:NewCal('tdate','ddmmyyyy',false)"><img src="../../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a></td>
</tr>

 <!-- date selection Ends here -->
<tr><td class="Blue-content" colspan="6" align="left">Select Station</td></tr>
<tr><td class="content style1"><b> State </b></td>
<td>
<select id="state" onchange="parameter()" class="content style1">
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
<select id="district" onchange="parameter()" class="content style1">
<option value="0">--Please Select--</option>
<option value="-1">All</option>
<%
rs=stmt.executeQuery("select param_id as did,group_value as district from parameter where active='Y' and group_family='LOCATION' and Group_name='DISTRICT' and parent_group='"+value1+"'");
while(rs.next()){
%>
<option value="<%=rs.getInt("did")%>" ><%=rs.getString("district")%></option>
<% 
	if(rs.getString("did").equals(value2)){%>
<option value="<%=value2%>" selected disabled><%=rs.getString("district")%></option>
<%
			//updating the Audit_table
		count=stmt2.executeUpdate("insert into audit_table values((select user_id from users where user_role="+session.getAttribute("theRole")+" and login_name='"+session.getAttribute("theName")+"'),(select user_role from users where user_role="+session.getAttribute("theRole")+" and login_name='"+session.getAttribute("theName")+"'),'% Reported','now()')");
  //end of auditing
}
}
%>
</select>
</td></tr>

</table>
</td>
<td valign=top>
<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" > 
<tr class="Blue-content" align="center"><td >District</td>
<td>Total</td>
<td>Not Reporting</td>
<td>90%-100% %</td>
<td>80% -90%</td>
<td>70%-80%</td>
<td>60%-70%</td>
<td>50%-60%</td>
<td>< 50%</td>
</tr>


<% if(value1.equalsIgnoreCase("0") & value2.equalsIgnoreCase("0")){%>
<tr><td colspan=7 class="readonly" align="center">Select Date and Location</td><tr>
<%}
else if (!value1.equalsIgnoreCase("0") & !value2.equalsIgnoreCase("0")){
//query="select sum(case when percent >=90 then 1 end) as reporting90, sum(case when percent >=80 and percent <90 then 1 end) as reporting80";
//query=query+", sum(case when percent >=70 and percent <80 then 1 end)as reporting70,sum(case when percent >=60 and percent <70 then 1 end)as reporting60";
//query=query+",sum(case when percent >=50 and percent <60 then 1 end)as reporting50,sum(case when percent <50  then 1 end)as rep50less from ";
//query=query+"(select st.clientid,Percent from station_configs_det as st left outer join (select clientid,";
//query=query+"cast((count(distinct (to_Char(packet_date,'YYYYMMDD HH24')))/((EXTRACT(epoch FROM (to_date('01/06/2010 00:00','dd/mm/yyyy hh24:mi')+ INTERVAL '1 DAY'))- EXTRACT(epoch FROM to_date('01/05/2010','dd/mm/yyyy')))/3600))*100 as integer) as Percent  from data_packets ";
//query=query+"where packet_date between to_date('01/05/2010','dd/mm/yyyy') and to_date('01/06/2010 00:00','dd/mm/yyyy hh24:mi')+ INTERVAL '1 DAY' group by clientid ) as a on (st.clientid=a.clientid) where st.activate!=0";


query="select group_value as district,count(1) as Total,COALESCE(sum(case when percent is null then 1 end),0) as Norep,COALESCE(sum(case when percent >=90 then 1 end),0)as reporting90,COALESCE(sum(case when percent >=80 and percent <90 then 1 end),0) as reporting80,COALESCE(sum(case when percent >=70 and percent <80 then 1 end),0) as reporting70, COALESCE(sum(case when percent >=60 and percent <70 then 1 end),0) as reporting60, sum(case when percent >=50 and percent <60 then 1 end)as reporting50, sum(case when percent <50  then 1 end)as rep50less from (select st.clientid,district, st.datafreq,packet_count,minutes, minutes/st.datafreq,cast(packet_count*100/(minutes/st.datafreq) as integer) as Percent  from station_configs_det as st left outer join (select clientid,count(distinct (to_Char(packet_date,'YYYYMMDD HH24'))) as packet_count,((EXTRACT(epoch FROM to_date('"+vtdate+"','DD/MM/YYYY')+Interval '1 DAY')-EXTRACT(epoch FROM to_date('"+vfdate+"','DD/MM/YYYY')))/60) as minutes from data_packets  where packet_date between to_date('"+vfdate+"','DD/MM/YYYY') and to_date('"+vtdate+"','DD/MM/YYYY')+Interval '1 DAY' group by clientid) as a on (st.clientid=a.clientid) where st.activate!=0 ";

if(value2.equalsIgnoreCase("0")||value2.equalsIgnoreCase("-1"))
{
	query=query+" and state="+value1+") as x";

				//updating the Audit_table
		count=stmt2.executeUpdate("insert into audit_table values((select user_id from users where user_role="+session.getAttribute("theRole")+" and login_name='"+session.getAttribute("theName")+"'),(select user_role from users where user_role="+session.getAttribute("theRole")+" and login_name='"+session.getAttribute("theName")+"'),'% Reported','now()')");
  //end of auditing
}
else{
	query=query+" and district='"+value2+"') as x";
					}
query=query+"  left outer join parameter as y on (x.district=y.param_id) group by y.group_value order by district";
//out.println(query);
rs=stmt.executeQuery(query);
	while(rs.next()){
%>
<tr align ="center" class="readonly">
<td align="left" ><%=rs.getString("district")%></td>
<td><%=rs.getString("Total")%></td>
<td class="readonly"><%=rs.getString("Norep")%></td>
<td class="readonly"><%=rs.getString("reporting90")%></td>
<td class="readonly"><%=rs.getString("reporting80")%></td>
<td class="readonly"><%=rs.getInt("reporting70")%></td>
<td class="readonly"><%=rs.getInt("reporting60")%></td>
<td class="readonly"><%=rs.getInt("reporting50")%></td>
<td class="readonly"><%=rs.getInt("rep50less")%></td>
</tr>
<%
}
}
%>



</table>



	</table>
</td></tr>
</table>
</body>
</html>
