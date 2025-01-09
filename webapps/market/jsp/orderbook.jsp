<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>


<%!
        Connection con=null;
        ResultSet rs=null;
        Statement stmt=null;
        ResultSet rsrole=null;
        Statement stmtrole=null;
        String query="";
%>

<%

DecimalFormat decf = new DecimalFormat("####0.00");

try
{

        /*Getting the connection variable from session*/

        con=(Connection)session.getAttribute("connection");
        stmt =  con.createStatement();
        stmtrole  =  con.createStatement();

}
catch(Exception e)
{
        out.println("Exception"+e);

}

String vfdate=request.getParameter("fdate");
DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());
if(vfdate == null){ vfdate=request.getParameter("txtfdate") ; }
if(vfdate == null){ vfdate=formattedDate;}

String act = request.getParameter("act"); 
	String vid = request.getParameter("id");


%>

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> Orders Dash Board </TITLE>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../Script/tabber.js"></script>
<script language="javascript" type="text/javascript" src="../Script/datepicker.js"></script> 
<script type="text/javascript" src="../Script/gs_sortable.js"></script>
<script type="text/javascript">
var TSort_Data = new Array ('my_table',  's','f','f','f','f','f','f','f','f','f','f','f','f','f','f');
var TSort_Classes = new Array ('row1', 'row2');
var TSort_Initial = '1D,4D';
var TSort_Cookie = 'sortable_table';
tsRegister();
</script>
<script>
function parameter(){
	var vfdate= document.getElementById("fdate").value
	window.location.replace("orderbook.jsp?vdate="+vfdate);
}
</script>
</HEAD>

<BODY>

<form action="orderbook.jsp" method="post" name="frmentry" >
<% response.setIntHeader("Refresh", 20); %>
<% if ("Sq.Off".equalsIgnoreCase(act) ) { 
rs=stmt.executeQuery("select * from intraday.kpi_rules where id="+vid);
}
%>

<% 
Integer i =0;
Double tbuy_value=0.00;
Double tPL=0.00;
Double tMTMPL=0.00;

query = "select x.* ,round((sold_value -sold_buy_value),2) relealized_PL ,round((open_qty*md.last_price)-open_value,2) MTM_PL ,md.last_price,md.last_traded_time, (open_qty*md.last_price) Buy_NSELL_VALUE";
query +=", round((md.last_price-md.high)*100/md.last_price,2) high_chg_per";
query +=" from (select al.Exchange,al.tradingSymbol,al.scrip_code,";
query +=" (select max(id) from intraday.market_data_sk where instrument_token =al.scrip_code and last_traded_time >=now() - interval 5 minute) last_price_id ,";
query +=" al.buy_qty,al.buy_value,buy_orders,avg_buy_price,ifnull(avg_sell_price,0) avg_sell_price, ifnull(sold_qty,0) sold_qty,ifnull(sold_value,0) sold_value,ifnull(sold_orders,0) sold_orders, ";
query +=" ifnull(open_qty,0) open_qty, ifnull(open_value,0) open_value,ifnull(open_orders,0) open_orders,sold_buy_value ";
query +=" from (select Exchange,tradingSymbol,scrip_code,round(avg(price),2) avg_buy_price,max(price) max_buy_price,sum(qty) buy_qty, round(sum(price*qty),2) buy_value,count(1) buy_orders, round(sum(if(ref_order_id is not null,price*qty,0))) sold_buy_value ";
query +=" from intraday.orders o ";
query +=" where o.date_inserted >= str_to_date('"+vfdate+"','%d/%m/%Y') and o.date_inserted < str_to_date('"+vfdate+"','%d/%m/%Y') + INTERVAL 1 DAY ";
query +=" and status='pending' and type='BUY' group by Exchange,tradingSymbol,scrip_code ) al ";
query +=" left outer join (select Exchange,tradingSymbol,scrip_code,max(price) max_buy_price,sum(qty) open_qty, round(sum(price*qty),2) open_value,count(1) open_orders from intraday.orders o ";
query +=" where o.date_inserted >= str_to_date('"+vfdate+"','%d/%m/%Y') and o.date_inserted < str_to_date('"+vfdate+"','%d/%m/%Y') + INTERVAL 1 DAY ";
query +=" and status='pending' and type='BUY' and ref_order_id is null group by Exchange,tradingSymbol,scrip_code ) open ";
query +=" on al.Exchange=open.Exchange and al.tradingSymbol=open.tradingSymbol and al.scrip_code=open.scrip_code ";
query +=" left outer join ( select Exchange,tradingSymbol,scrip_code,max(price) max_buy_price,sum(qty) sold_qty, round(avg(price),2) avg_sell_price, round(sum(price*qty),2) sold_value,count(1) sold_orders from intraday.orders o ";
query +=" where o.date_inserted >= str_to_date('"+vfdate+"','%d/%m/%Y') and o.date_inserted < str_to_date('"+vfdate+"','%d/%m/%Y') + INTERVAL 1 DAY ";
query +=" and status='pending' and type='SELL' and ref_order_id is not null group by Exchange,tradingSymbol,scrip_code ) sold ";
query +=" on al.Exchange=sold.Exchange and al.tradingSymbol=sold.tradingSymbol and al.scrip_code=sold.scrip_code ) X";
query +=" left outer join intraday.market_data_sk md on md.id=  last_price_id ";      
 
// out.println(query);
rs=stmt.executeQuery(query);

// List to store the result
List<Map<String, Object>> resultList = new ArrayList<>();	

while(rs.next()) { 
i=i+1;
tbuy_value =tbuy_value+ rs.getFloat("buy_value");
tMTMPL=tMTMPL+ rs.getFloat("MTM_PL");
tPL = tPL+ rs.getFloat("relealized_PL");

Map<String, Object> row = new HashMap<>();
			row.put("scrip_code", rs.getString("scrip_code"));
            row.put("exchange", rs.getString("exchange"));
            row.put("tradingsymbol", rs.getString("tradingsymbol"));
			row.put("last_traded_time", rs.getString("last_traded_time"));
			row.put("buy_orders", rs.getInt("buy_orders"));
			row.put("buy_qty",rs.getInt("buy_qty"));
			row.put("sold_orders",rs.getInt("sold_orders"));
			row.put("sold_qty",rs.getInt("sold_qty"));
			row.put("open_orders", rs.getInt("open_orders"));
			row.put("open_qty",rs.getInt("open_qty"));
			row.put("buy_value",rs.getFloat("buy_value"));
			row.put("sold_value",  rs.getFloat("sold_value"));
		    row.put("relealized_PL", rs.getFloat("relealized_PL"));
			row.put("MTM_PL",rs.getFloat("MTM_PL"));
			row.put("avg_buy_price",rs.getFloat("avg_buy_price"));
			row.put("avg_sell_price",rs.getFloat("avg_sell_price"));
			row.put("last_price",rs.getFloat("last_price"));
			row.put("high_chg_per",rs.getFloat("high_chg_per"));
            resultList.add(row);
}
request.setAttribute("resultList", resultList);
%>
<table width="100%" border="0" cellpadding="1" VALIGN=TOP align="center">
<tr>
<td>
<table  border="1" cellpadding="2" cellspacing="0" align="left" >
<tr>

<td class="content style1">Buy Value: <%=decf.format(tbuy_value)%></td> 
<td class="content style1">P/L: <%=decf.format(tPL)%></td> 
<td class="content style1">MTM PL: <%=decf.format(tMTMPL)%></td> 
<td>
	<input id="fdate" class="content style1" type="text" name="fdate" size="10" maxlength="12" onchange="parameter()" value=<%=vfdate%>>
	<a href="javascript:NewCal('fdate','ddmmyyyy',false)"><img src="../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a>
	<input class="content style1"  type="submit" value="Go" onClick="parameter()">
	<input type="hidden" id="txtfdate"  name="txtfdate" size="10" maxlength="12" value=<%=vfdate%> />
</td></tr>
</table>
</td>
</tr>

<tr><td>
<table  id="my_table" border="1" cellpadding="2" cellspacing="0" align="left" >
<thead>
  	<tr class="Blue-content" align="center">
	<th>Scrip</th>
	<th>Buy<br>Orders</th><th>Buy<br>Qty</th>
	<th>Sold<br>Orders</th><th>Sold<br>Qty</th>
	<th>Open<br>Orders</th><th>Open<br>Qty</th>
	<th>Buy<br>Value</th><th>Sell<br>Value</th>
	<th>Realized<br>P/L</th>
	<th>MTM<br>P/L</th>
	<th>Avg Buy<br>Price</th><th>Avg Sell<br>Price</th><th>Current<br>Price</th>
	<th>High<br>Chg %</th>
	<th>Last Traded Time</th>
	<th>
	<button type="submit" class="button-image" id="act" name="act" value="Sq.Off" > SquareOff</button>
	</th>
	</tr>
</thead>
<%

       // Retrieve the list and display it
        List<Map<String, Object>> resultList1 = (List<Map<String, Object>>) request.getAttribute("resultList");
        if (resultList1 != null) {
            for (Map<String, Object> row : resultList1) {
%>

<tr class="content style1" align="center">
		<td align="left">
		<a href="intraday/orderbookDetail.jsp?vcode=<%=row.get("scrip_code")%>&&fdate=<%=vfdate%>" target="popup" style="font-size: 9pt; color: #990000 ;font-weight: normal" onclick="window.open('intraday/orderbookDetail.jsp?vcode=<%=row.get("scrip_code")%>&&fdate=<%=vfdate%>','popup','width=1000,height=1000'); return false;"><%=row.get("tradingsymbol")%>
		</a></td>
		<td><%=row.get("buy_orders")%></td><td align="right"><%=row.get("buy_qty")%></td>
		<td><%=row.get("sold_orders")%></td><td align="right"><%=row.get("sold_qty")%></td>
		<td><%=row.get("open_orders")%></td><td align="right"><%=row.get("open_qty")%></td>
        <td align="right"><%=decf.format(row.get("buy_value"))%></td><td align="right"><%=decf.format(row.get("sold_value"))%></td>
		<td align="right"><%=row.get("relealized_PL")%></td>
		<td align="right"><%=decf.format(row.get("MTM_PL"))%></td>
		<td align="right"><%=decf.format(row.get("avg_buy_price"))%></td><td align="right"><%=decf.format(row.get("avg_sell_price"))%>
		</td><td align="right"><%=decf.format(row.get("last_price"))%></td>
		<td align="right"><%=decf.format(row.get("high_chg_per"))%></td>
		<td align="right"><%=row.get("last_traded_time")%></td>
		<td><input type="radio" name="id"  value=<%=row.get("scrip_code")%> /></td>
		
 </tr>

<% } 
		}%>
<tr>
</table> 

</td></tr>
</table>
</form>
</BODY>
</HTML>
