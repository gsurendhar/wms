<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>

<%@ page import="java.io.*" %>
<%@ page  import="java.awt.*" %>
<%@ page session = "true" %>

<script>
function parameter(){
var vtchg=document.getElementById("cmbTchg").value
var vgroup=document.getElementById("cmbGroup").value
var vtype=document.getElementById("type").value
window.location.replace("intraday.jsp?vtchg="+vtchg+"&&vgroup="+vgroup+"&&val="+vtype);
}
</script>




<!-- added for sorting table --->
<script type="text/javascript" src="../../Script/gs_sortable.js"></script>
<script type="text/javascript">
var TSort_Data = new Array ('my_table', 's', 's','f','f','f','f','f','f','f','f','f','f','f','f','f');
var TSort_Classes = new Array ('row1', 'row2');
var TSort_Initial = '1D,10D';
var TSort_Cookie = 'sortable_table';
tsRegister();
</script>


<%!
Connection con=null;
ResultSet rs=null;
ResultSet rs1=null;
Statement stmt=null;
String query="";
String query1="";
String query2="";
String e;

DecimalFormat decf = new DecimalFormat("####0.00");
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
%>

<%

DateFormat df = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
Integer rcount=1;


String vgroup=request.getParameter("vgroup");
if (vgroup==null){vgroup="0";}

String vIchg = request.getParameter("vtchg");
if (vIchg == null){vIchg ="5";}

String vcon="";
if ("0".equalsIgnoreCase(vgroup)){
	vcon= " ";
}
else {
	vcon=" and r.code in (select CODE from code_group where group_id='"+vgroup+"')" ;
	}

String vcon1="";

String vtype=request.getParameter("val");
if ("star".equalsIgnoreCase(vtype)){
	vcon1=  " and star like '*%' ";}
if ("down".equalsIgnoreCase(vtype)){
	vcon1=  " and star like '#%' ";}


if ("vol50".equalsIgnoreCase(vtype)){
	vcon1=  " and VOL_RISE_PER_20DMA >= -50  ";}

if ("vol100".equalsIgnoreCase(vtype)){
	vcon1=  " and VOL_RISE_PER_20DMA >= 0 ";}

if ("tracked".equalsIgnoreCase(vtype)){
	vcon1=  " and star!= '.'";}


String vfdate="";
String vtdate="";
String vfordate="";

query="select now()- INTERVAL "+vIchg+" MINUTE F_DATE, now() T_DATE ";



rs=stmt.executeQuery(query);
	while(rs.next()){
 		vfdate=rs.getString("F_DATE");
		vtdate=rs.getString("T_DATE");
		}
//rs.close();

query="select date(max(traded_time)) day from tick_data";
rs=stmt.executeQuery(query);
        while(rs.next()){
                vfordate=rs.getString("day");
                }
if (vfordate == null){vfordate=vfdate;}
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reports</title>
<script type="text/javascript" src="../../Script/tabber.js"></script>
<script language="javascript" type="text/javascript" src="../../Script/datepicker.js"></script> 
<meta http-equiv="imagetoolbar" content="no" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="Tue,01 Dec 2010 06:30:00 GMT">
<link href="../../styles/text.css" rel="stylesheet" type="text/css">

<script>
function checkUSB(){
    <%response.setHeader("Cache-Control","no-cache");%>
           
	var vtchg=document.getElementById("cmbTchg").value;
		if (vtchg == 5) { <% response.setIntHeader("Refresh", 5); %> }
		if (vtchg == 10) { <% response.setIntHeader("Refresh", 10); %> } 
		if (vtchg == 20) { <% response.setIntHeader("Refresh", 20); %> }
		if (vtchg == 40) { <% response.addHeader("Refresh","40"); %>  }
		if (vtchg == 60) { <% response.addHeader("Refresh","60"); %>  }
	}

</script>
</head>

<body>
<% response.setIntHeader("Refresh", 5);%>

<input type="hidden" id=type value="<%=vtype%>" />

<table width="100%" border="0" cellpadding="1" VALIGN=TOP align="center">

<tr>
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

Time Interval:
<select id="cmbTchg" onchange="parameter()" class="content style1" size="0">

<% if ("5".equalsIgnoreCase(vIchg)) { %> <option value="5"  selected disabled>5</option> <% } else {%> <option value="5">5</option>
<% } if ("10".equalsIgnoreCase(vIchg)) { %> <option value="10"  selected disabled>10</option> <% } else {%> <option value="10">10</option>
<% } if ("20".equalsIgnoreCase(vIchg)) { %> <option value="20"  selected disabled>20</option> <% } else {%> <option value="20">20</option>
<% } if ("30".equalsIgnoreCase(vIchg)) { %> <option value="30"  selected disabled>30</option> <% } else {%> <option value="30">30</option>
<% } if ("40".equalsIgnoreCase(vIchg)) { %> <option value="40"  selected disabled>40</option> <% } else {%> <option value="40">40</option>
<% } if ("60".equalsIgnoreCase(vIchg)) { %> <option value="60"  selected disabled>1 M</option> <% } else {%> <option value="60">1 M</option>
<% } if ("120".equalsIgnoreCase(vIchg)) { %> <option value="120"  selected disabled>2 M</option> <% } else {%> <option value="120">2 M</option>
<% } if ("300".equalsIgnoreCase(vIchg)) { %> <option value="300"  selected disabled>5 M</option> <% } else {%> <option value="300">5 M</option>
<% } if ("600".equalsIgnoreCase(vIchg)) { %> <option value="600"  selected disabled>10 M</option> <% } else {%> <option value="600">10 M</option>
<% } if ("1200".equalsIgnoreCase(vIchg)) { %> <option value="1200"  selected disabled>20 M</option> <% } else {%> <option value="1200">20 M</option>
<% } if ("1800".equalsIgnoreCase(vIchg)) { %> <option value="1800"  selected disabled>30 M</option> <% } else {%> <option value="1800">30 M</option>
<% } if ("3600".equalsIgnoreCase(vIchg)) { %> <option value="3600"  selected disabled>1 H</option> <% } else {%> <option value="3600">1 H</option>
<% } if ("7200".equalsIgnoreCase(vIchg)) { %> <option value="7200"  selected disabled>2 H</option> <% } else {%> <option value="7200">2 H</option>

<%} %>
</select>
</td>
</tr>

<%

query1 = "select date_format(a.traded_time,'%H') hh,date_format(a.traded_time,'%i') mi,date_format(a.traded_time,'%s') ss,date_format(a.traded_time,'%d') dd, ";
query1 +=" date_format(a.traded_time,'%m') mm,date_format(a.traded_time,'%Y') yyyy, ";
query1 +=" i.exchange,i.exchange_token scrip_code,i.tradingsymbol scrip_name,";
query1 +=" a.instrument,a.price current_price,round(a.change_per,2) per_change,a.vol_traded qty,r.tottrdqty p_qty,a.open,a.low,a.high,a.close,";
query1 +=" date_format(a.traded_time,'%H:%i:%s') last_traded_time,a.traded_time last_traded_date,";
query1 +=" (a.price-b.price) price_chg_delta ,round((a.price-b.price)*100/b.price,2) price_chg_delta_per,(a.vol_traded-b.vol_traded) vol_rise_delta,";
query1 +=" r.cur_price prev_price,r.tottrdqty prev_traded_qty,r.price_20DMA, r.vol_20dma,";
query1 +=" round((a.vol_traded/r.tottrdqty)*100,2) VOL_RISE_PER, (a.vol_traded/r.vol_20dma)*100 VOL_RISE_PER_20DMA,0 OI_DIF_PER,round(((a.open-r.cur_price)/r.cur_price)*100,2) gap";
query1 +=" from ";
//  query1 +=" (select instrument,min(id) min_id,max(id)max_id, (max(traded_time)-min(traded_time))*1440*60 tsec from tick_data where traded_time >= '"+vfordate+"' group by instrument) T";
query1 +=" (select instrument,min(id) min_id,max(id)max_id, (max(traded_time)-min(traded_time))*1440*60 tsec from tick_data where traded_time >= '"+vfdate+"'  and traded_time < '"+vtdate+"' group by instrument) T";
query1 +=" inner join tick_data a on T.instrument=a.instrument and T.max_id=a.id";
query1 +=" inner join tick_data b on a.instrument=b.instrument and T.min_id=b.id";
query1 +=" inner join instruments i on i.instrument_token=t.instrument ";
query1 +=" inner join research_page r on r.code=i.tradingsymbol and r.day =(select max(day) from eod where day < a.traded_time) ";
query1 +="  "+vcon+" order by a.traded_time desc ";

// out.println(query1);
// out.println("vcon:"+vcon);
//out.print("vcon1:"+vcon1);
%>


<tr><td>
<table  border="1" id="my_table"  cellpadding="2" cellspacing="0" align="left" >
 <thead>
 	<tr class="Blue-content" align="center">
	<th>Time</th>	
	<th width="20%">Scrip</th>
	
	<th>Price</th>
	<th>Volume<br>Rise %</th>
	<th>Volume<br>Rise % <br>20DMA</th>
	<th>Vol Rise <br> Delta %</th>
	<th>Vol Rise <br> Delta %<br>20DMA</th>
	<th>Price<br>chg %<br>Delta</th>
	<th>Price <br>chg %</th>
<!--  <th>Volume<br>qty</th>
 <th>Volume<br>p_Qty</th> -->
	<th>GAP %</th>
	<th>Today<br>Low</th>
	<th>Today<br>High</th>
	<th>Today<br>Open</th>
	<th>Yest<br>Close</th>
</tr>
</thead>

<% 
//out.println(query1);
rs=stmt.executeQuery(query1);

while(rs.next()){  %>
<tr class="content" align="right" >
<td align="center"><%=rs.getString("last_traded_date")%></td>
<td align="left"><a href="intradaydet.jsp?vcode=<%=rs.getString("scrip_name")%>&&vdate=<%=rs.getString("dd")%>/<%=rs.getString("mm")%>/<%=rs.getString("yyyy")%>" target="_blank" style="font-size: 9pt; color: #990000 ;font-weight: normal" >
<%=rs.getString("scrip_name")%></td>

<td><%=rs.getFloat("CURRENT_PRICE")%></td>
<td><%=rs.getFloat("VOL_RISE_PER")%></td>
<td><%=rs.getFloat("VOL_RISE_PER_20DMA")%></td>
<td><%=rs.getFloat("vol_rise_delta")%></td>
<td><%=rs.getString("VOL_RISE_PER_20DMA")%></td>
<td><%=rs.getString("price_chg_delta")%></td>
<td><%=rs.getFloat("PER_CHANGE")%></td>
<!-- <td><%=rs.getString("qty")%></td>
<td><%=rs.getString("p_qty")%></td> -->
<td><%=rs.getString("gap")%></td> 
 
<td color="red"><%=rs.getString("low")%></td> 
<td><%=rs.getString("high")%></td> 
<td><%=rs.getString("open")%></td>
<td><%=rs.getString("prev_price")%></td>




</tr>

<%}
rs.close();%>
</table>
</td>

</tr>


</body>
</html>




