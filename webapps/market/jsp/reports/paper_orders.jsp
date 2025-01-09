<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import ="oracle.jdbc.driver.*"%>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>

<script>
function parameter(){
var vday=document.getElementById("cmbDay").value
var vgroup=document.getElementById("cmbGroup").value
window.location.replace("paper_orders.jsp?vday="+vday+"&&vgroup="+vgroup);
}

</script>


<%!

        Connection con=null;
        ResultSet rs=null;
        ResultSet rs1=null;
        Statement stmt=null;
	String query="";
	

%>

<%
try
{
        con=(Connection)session.getAttribute("connection");
        stmt =  con.createStatement();
}
catch(Exception e)
{
        System.out.println("Exception"+e);
}

	String vday= request.getParameter("vday");
	if (vday==null){
		rs=stmt.executeQuery("select max(eod_date)+1 from eod_date");
		while(rs.next()){
			vday=rs.getString(1);
		}
	}

String vgroup=request.getParameter("vgroup");
if (vgroup==null){vgroup="0";}
	
String vcon="";

if (! "0".equalsIgnoreCase(vgroup)){vcon=" and scrip_name in (select CODE from code_group where group_id='"+vgroup+"')" ;}
	

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Paper Orders</title>
<link href="../../styles/text.css" rel="stylesheet" type="text/css">
</head>
<body>
<% response.setIntHeader("Refresh", 15);%>
<table width="75%" border="3" class="border" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
<tr><td valign=top>
	<table width="100%" border="1" class="border" cellpadding="2" cellspacing="0"  bgcolor="#DBEBFF" VALIGN=TOP>
	<tr class="Blue-content">

	<td class="Blue-content"  align="left" colspan="1">
 	Day:
	<select id="cmbDay" onchange="parameter()" class="content style1" size="0" style="width: 80px;">
	<option value="0">--Select--</option>
	<%
rs1=stmt.executeQuery("select to_char(sysdate,'yyyymmdd')eod_date,to_char(sysdate,'dd-mm-yy')  eod_day from dual union all select eod_date,to_char(to_date(eod_date,'yyyymmdd'),'dd-mm-yy') eod_day from (select eod_date from eod_date order by 1 desc) where rownum<10");
while(rs1.next()){
%>
<option value="<%=rs1.getString("eod_date")%>" ><%=rs1.getString("eod_day")%></option>
<% if(rs1.getString("eod_date").equals(vday)){%>
<option value="<%=vday%>" disabled selected ><%=rs1.getString("eod_day")%></option>
<%
}
}
%>
</select>
</td>

<td class="Blue-content"  align="left">
Group:
<select id="cmbGroup" onchange="parameter()" class="content style1" size="0">
<option value="0">--Select--</option>
<%

rs1=stmt.executeQuery("select group_name as id ,group_value as name from parameter where group_family='GROUP' order by 1");
while(rs1.next()){
%>
<option value="<%=rs1.getString("id")%>" ><%=rs1.getString("name")%></option>
<% if(rs1.getString("id").equals(vgroup)){%>
<option value="<%=vgroup%>" selected ><%=rs1.getString("name")%></option>
<%
}
}
%>
</select>
</td>
</tr>
</table>

<tr><td>


<table width="100%" border="1" id="my_table" cellpadding="0" cellspacing="0" id="stretch" class="hoverTable">
<tr class="Blue-content"><td valign=top>DATE ADDED</td><td>SCRIP NAME</td><td>TRADED DATE</td><td>PRICE</td><td>PRICE_CHG</td><td>VOL_TIME</td><td>AVERAGE_FLAG</td>
<td>DEL_AVG_3DAY</td><td>NIFTY FLAG</td>
<td>CURRENT<BR>PRICE</td><td>LAST TRADED</td>
</tr>
<%
query = "select t.*,x.current_price latest_price,x.last_traded_date last_trade from tmp_orders t inner join ";
query+="(select a.scrip_code,current_price,high,low,average,last_traded_date from intraday a ";
query+="inner join (select scrip_code,max(date_inserted) tmax from intraday group by scrip_code) b on a.scrip_code=b.scrip_code and a.date_inserted=tmax) x ";
query+="on t.scrip_code=x.scrip_code where t.date_inserted >= to_date('"+vday+"','YYYYMMDD')"+vcon;
rs=stmt.executeQuery(query);
while(rs.next()){
%>
<tr class="content">
<td><%=rs.getString("date_inserted")%></td><td><%=rs.getString("scrip_name")%></td><td><%=rs.getString("last_traded_date")%></td><td><%=rs.getString("current_price")%></td>
<td><%=rs.getString("price_chg")%></td><td><%=rs.getString("vol_times")%></td><td><%=rs.getString("average_flag")%></td>
<td><%=rs.getString("DEL_AVG_3DAY")%></td><td><%=rs.getString("NIFTY_FLAG")%></td>
<td><%=rs.getString("latest_price")%></td><td><%=rs.getString("last_Trade")%></td>
</tr>
<% }
rs.close();%>
</table></td></tr>
</body>
</html>
