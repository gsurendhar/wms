<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>

<%@ page import="java.io.*" %>
<%@ page  import="java.awt.*" %>
<%@ page session = "true" %>



<%!
Connection con=null;
ResultSet rs=null;
ResultSet rs1=null;
Statement stmt=null;
String query="";
String query1="";
String query2="";
String e;

Integer vmintimeint =0;
Integer vmaxtimeint=0;

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
String prcchg = request.getParameter("prcchg");
if (prcchg == null){prcchg ="0";}
if ("1".equalsIgnoreCase(prcchg)){vcon1 = " where price_chg_today >=0 ";}  
if ("2".equalsIgnoreCase(prcchg)){vcon1 = " where price_chg_today < 0 ";}  	

String vtype=request.getParameter("val");
String vfdate="";
String vtdate="";
String vfordate="";


String vtrdval=request.getParameter("vtrdval");
if (vtrdval==null){vtrdval="5";}

//query="select max(last_traded_time)- INTERVAL 5 MINUTE F_DATE, max(last_traded_time) T_DATE,max(timeint)-5 min_timeint, max(timeint) max_timeint from intraday.market_data_sk;";
query="select  max(timeint)-5 min_timeint, max(timeint) max_timeint from intraday.market_data_sk;";
rs=stmt.executeQuery(query);
	while(rs.next()){
 		//vfdate=rs.getString("F_DATE");
		//vtdate=rs.getString("T_DATE");
		vmintimeint =rs.getInt("min_timeint");
		vmaxtimeint =rs.getInt("max_timeint"); 
		}
//rs.close();
//vfordate=vfdate;

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reports</title>
<!-- added for sorting table --->
<script type="text/javascript" src="../../Script/gs_sortable.js"></script>
<script type="text/javascript">
var TSort_Data = new Array ('my_table', 's', 's','f','f','f','f','f','f','f','f','f','f','f','f','f','f','f','f','f','f','f','f','f');
var TSort_Classes = new Array ('row1', 'row2');
var TSort_Initial = '1D,10D';
var TSort_Cookie = 'sortable_table';
tsRegister();
</script>
<script>
function parameter(){
var vgroup=document.getElementById("cmbGroup").value
var vtrdval=document.getElementById("txtTrdval").value
var vchg=document.getElementById("cmbPrchg").value
window.location.replace("intradayeq.jsp?vgroup="+vgroup+"&&vtrdval="+vtrdval+"&&prcchg="+vchg);
}
</script>

<meta http-equiv="imagetoolbar" content="no" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="Tue,01 Dec 2010 06:30:00 GMT">
<link href="../../styles/text.css" rel="stylesheet" type="text/css">
 </head>

<body>
<form >
<% if ("5".equalsIgnoreCase(vIchg)) { response.setIntHeader("Refresh", 5); }
   if ("10".equalsIgnoreCase(vIchg)) { response.setIntHeader("Refresh", 10);}
   if ("20".equalsIgnoreCase(vIchg)) { response.setIntHeader("Refresh", 20);}
   if ("30".equalsIgnoreCase(vIchg)) { response.setIntHeader("Refresh", 30);}
   if ("40".equalsIgnoreCase(vIchg)) { response.setIntHeader("Refresh", 40);}
   if ("50".equalsIgnoreCase(vIchg)) { response.setIntHeader("Refresh", 50);}
   else { response.setIntHeader("Refresh", 20);}
%> 



<input type="hidden" id=type value="<%=vtype%>" />

<table width="100%" border="0" cellpadding="1" VALIGN=TOP align="center">
<tr>
<td class="Blue-content"  align="left">
Group:
<select id="cmbGroup" name="cmbGroup" onchange="parameter()" class="content style1" size="0">
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

 
<b>Traded Value Yesterday:(Cr)</b><input type=text id="txtTrdval" name="txtTrdval"  class="content style1" value="<%=vtrdval%>" size="4"> 

Price Change:
<select id="cmbPrchg" name="cmbPrchg" onchange="parameter()" class="content style1">
	<option value="0" <%= "0".equals(prcchg) ? "selected" : "" %>>All</option>
	<option value="1" <%= "1".equals(prcchg) ? "selected" : "" %>>Up</option>
	<option value="2" <%= "2".equals(prcchg) ? "selected" : "" %>>Down</option>
</select>

<input class="content style1"  type="submit" value="Go" onClick="parameter()">
</td>
</tr>
<tr> <td>
<table  border="1"  cellpadding="2" cellspacing="0" align="left" >
 <thead>
 	<tr class="Blue-content" align="center">
	<th width="20%">Time</th>	
	<th width="10%">Index</th>
	<th width="10%">Close</th>
	<th width="10%">open</th>
	<th width="10%">Low</th>
	<th width="10%">High</th>
	<th width="10%">Current</th>
	<th width="10%">Change %</th>
	</tr>
</thead>
<%
String vsql1 ="";
vsql1="select i.tradingsymbol,last_traded_time traded_time,open,low,high,close,last_price price,round((last_price-close)*100/close,2) changePer ,round(price_change,2)change_per  ";
vsql1 +="from intraday.market_data_sk t  inner join  (select instrument_token,max(id) id from intraday.market_data_sk where instrument_token in (26009,26002,20000) and timeint >= (select max(timeint) - 10 from intraday.market_data_sk )group by instrument_token) x  on x.id=t.id  ";
vsql1 +="inner join intraday.instruments i on i.instrument_token=t.instrument_token  ";
rs1=stmt.executeQuery(vsql1);

while(rs1.next()){
%>
<tr class="content" align="right" >
<td align="left"><%=rs1.getString("traded_time")%></td>
<td align="left"><%=rs1.getString("tradingsymbol")%></a></td>
<td><%=rs1.getFloat("close")%></td>
<td><%=rs1.getFloat("open")%></td>
<td><%=rs1.getFloat("low")%></td>
<td><%=rs1.getFloat("high")%></td>
<td><%=rs1.getFloat("price")%></td>
<td><%=rs1.getFloat("changePer")%></td>

<%}
// rs1.close();
%>
</table>
</td> 

<%

// query1 +=" round((a.volume_traded-md_1m.volume_traded)*100/md_1m.volume_traded,2) vol_1m, round((a.volume_traded-md_2m.volume_traded)*100/md_2m.volume_traded,2) vol_2m, ";
// query1 +=" round((a.last_price-md_1m.last_price)*100/md_1m.last_price,2) price_1m,round((a.last_price-md_2m.last_price)*100/md_2m.last_price,2) price_2m, "


query1="select * from (select 'NSE' exchange,i.scripCode scrip_code,i.tradingsymbol scrip_name, a.instrument_token instrument ,a.last_price current_price,round(a.price_change/a.open,2) per_change,a.volume_traded qty,r.tottrdqty p_qty, ";
query1 += " round((a.last_price - a.average_traded_price)*100/a.average_traded_price,2) average_current_per,";
query1 +=" a.open,a.low,a.high,a.close, date_format(a.last_traded_time,'%H:%i:%s') last_traded_time, a.last_traded_time last_traded_date, (a.last_price-b.last_price) price_chg_delta,";
query1 +=" round((a.last_price-a.open)*100/a.open,2) price_chg_today, round((a.last_price-b.last_price)*100/b.last_price,2) price_chg_delta_per, (a.volume_traded-b.volume_traded) vol_rise_delta, ";
query1 +=" a.close prev_price,r.tottrdqty prev_traded_qty, round(r.tottrdval/10000000,2) turnover, round((a.volume_traded/r.tottrdqty)*100,2) VOL_RISE_PER, 0 OI_DIF_PER,round(((a.open-r.last)/r.last)*100,2) gap, ";
query1 +=" round((a.last_price-md_3m.last_price)*100/md_3m.last_price,2) price_3m, ";
query1 +=" round((a.volume_traded-md_3m.volume_traded)*100/md_3m.volume_traded,2) vol_3m, ";
// query1 +=" ma.avg_price avg_5d_price ,ma.avg_volume avg_5d_volume, round(a.volume_traded/ma.avg_volume,2) vol_rise_times ,";
query1 +=" round(r.TOTTRDVAL/10000000,2) yesterday_turnover,a.average_traded_price ,AVG_5D_TOTTRDVAL,";
query1 +=" (a.volume_traded*a.average_traded_price) trd_val_today, ";
query1 +=" round((a.volume_traded*a.average_traded_price)*100/AVG_5D_TOTTRDVAL,2) trd_val_5day_per ";
query1 +=" from (";
query1 +=" select instrument_token,min(id) min_id,max(id)max_id,max(if(timeint = "+vmaxtimeint+"-3 , id,0)) id_3m,";
query1 +=" max(if(timeint = "+vmaxtimeint+"-2 ,id,0)) id_2m, max(if(timeint = "+vmaxtimeint+"-1 ,id,0)) id_1m from intraday.market_data_sk where timeint between "+vmintimeint+" and  "+vmaxtimeint+" group by instrument_token) t";
query1 +=" inner join intraday.market_data_sk a on T.instrument_token=a.instrument_token and t.max_id=a.id ";
query1 +=" inner join intraday.market_data_sk b on a.instrument_token=b.instrument_token and t.min_id=b.id ";
query1 +=" inner join intraday.script_master i on i.scripCode=t.instrument_token ";
query1 +=" inner join intraday.nse_bhav r on r.code=i.tradingsymbol and r.day =(select max(day) from intraday.nse_bhav) ";
query1 +=" inner join intraday.nse_bhav_5day bhav_5day on bhav_5day.tradingSymbol = i.tradingsymbol and bhav_5day.day=r.day";
//query1 +=" left outer join intraday.market_data_sk md_1m on t.instrument_token=md_1m.instrument_token and t.id_1m=md_1m.id"; 
//query1 +=" left outer join intraday.market_data_sk md_2m on t.instrument_token=md_2m.instrument_token and t.id_2m=md_2m.id"; 
query1 +=" left outer join intraday.market_data_sk md_3m on t.instrument_token=md_3m.instrument_token and t.id_3m=md_3m.id"; 
//query1 +=" left outer join intraday.market_5day_1m_avg ma on a.instrument_token= ma.instrument_token and date_format(a.last_traded_time,'%H:%i')=ma.time ";

query1 +=" where r.tottrdval/10000000 >="+vtrdval+" "+vcon+" order by a.last_traded_time desc )x"+vcon1;
// out.println(query1);
%>


<tr><td>
<table  border="1" id="my_table"  cellpadding="2" cellspacing="0" align="left" >
 <thead>
 	<tr class="Blue-content" align="center">
	<th>Time</th>	
	<th width="10%">Scrip</th>
	<th>Price</th>
	<th>Price<br>chg(%)</th>
	<th>Avg2Last<br>Price<br>Chg(%)</th>
	<th>Traded.<br>Val %<br>(now/5Day Avg)</th>
	<th>Vol Rise<br>to Yest<br>(%)</th>
	<th>Vol<br>3 Min<br>%</th>
	<th>Price<br>3 Min<br>%</th>
	<th>Low</th>
    <th>High</th>
    <th>Open</th>
	
	<th>Volume</th>
	<th>avg <br>price</th>
	<th>Yesteday<br>Turnover(Cr)</th>
	<th>5 Day Avg<br>Turnover(Cr)</th>
	<th>Today<br>Turnover(Cr)</th>
</tr>
</thead>

<% 
//out.println(query1);
Integer all=0;
Integer pos=0;
Integer neg=0;

rs=stmt.executeQuery(query1);
while(rs.next()){  
all = all+1;
if(rs.getFloat("price_chg_today") >0 ){pos=pos+1;} 
	else {neg=neg+1;}
 

%>
<tr class="content" align="right" >
<td align="center"><%=rs.getString("last_traded_time")%></td>
<td align="left">
<a href="intradaydet.jsp?vcode=<%=rs.getString("scrip_code")%>" target="popup" style="font-size: 9pt; color: #990000 ;font-weight: normal" onclick="window.open('intradaydet.jsp?vcode=<%=rs.getString("scrip_code")%>','popup','width=1000,height=1000'); return false;">
<%=rs.getString("scrip_name")%></a></td>
<td><%=rs.getFloat("CURRENT_PRICE")%></td>
<td><%=rs.getFloat("price_chg_today")%></td>
<td align="center" ><%=rs.getFloat("average_current_per")%></td>
<td><%=rs.getString("trd_val_5day_per")%></td>
<td><%=rs.getFloat("VOL_RISE_PER")%></td>
<td><%=rs.getFloat("vol_3m")%></td>
<td><%=rs.getFloat("price_3m")%></td>
<td><%=rs.getString("low")%></td>
<td><%=rs.getString("high")%></td>
<td><%=rs.getString("open")%></td>
<td><%=rs.getString("qty")%></td>
<td><%=rs.getString("average_traded_price")%></td>
<td><%=rs.getString("yesterday_turnover")%></td>
<td><%=rs.getFloat("AVG_5D_TOTTRDVAL")/10000000%></td>
<td><%=rs.getFloat("trd_val_today")/10000000%></td>
<%}
%>
</table>
</td>
<td valign="top"><table border="1" class="content">
<tr><td>All </td><td><%=all%></td></tr>
<tr><td>Up </td><td><%=pos%></td></tr>
<tr><td>Down </td><td><%=neg%></td></tr>
</tr>
</table></td>
</tr>
</form>
</body>
</html>




