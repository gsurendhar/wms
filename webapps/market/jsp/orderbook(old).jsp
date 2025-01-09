<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%!
        Connection con=null;
        ResultSet rs=null;
        Statement stmt=null;
        ResultSet rsrole=null;
        Statement stmtrole=null;
        String query="";
%>

<%



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
String act = request.getParameter("act");
String vtype=request.getParameter("cmbType");
if (vtype==null){vtype=request.getParameter("txtType");}
//out.println("Type:"+vtype);
//out.println("Act:"+act);
 

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> Orders Dash Board </TITLE>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
<script>
function parameter_type(){
	var vtype=document.getElementById("cmbType").value
	window.location.replace("orderbook.jsp?cmbType="+vtype);
}

function parameter(){
	var vtype=document.getElementById("cmbType").value
	var vact=document.getElementById("act").value
	window.location.replace("orderbook.jsp?cmbType="+vtype+"&&act="+vact);
}
</script>
<script type="text/javascript" src="../Script/gs_sortable.js"></script>
<script type="text/javascript">
var TSort_Data = new Array ('my_table', 'i', 's','s','s','f','f');
var TSort_Classes = new Array ('row1', 'row2');
var TSort_Initial = '3D,10D';
var TSort_Cookie = 'sortable_table';
tsRegister();
</script>
</HEAD>

<BODY>
<form action="orderbook.jsp" method="post" name="frmentry" >
<% response.setIntHeader("Refresh", 20); %>

<tr>
<td>
<table  border="1" cellpadding="2" cellspacing="0" align="left" >
  	<tr class="Blue-content" align="center">
	<td>Sl#</td><td>Ex</td><td>Scrip</td>
	<td>Buy Orders</td><td>Buy Qty</td>
	<td>Sold Orders</td><td>Sold Qty</td>
	<td>Open Orders</td><td>Open Qty</td>
	<td>Buy Value</td><td>Sell Value</td>
	<td>Open Value</td>
	<td>Realized<br>P/L</td>
	<td>UnRealized<br>P/L</td>
	<td>Avg Buy<br>Price</td><td>Avg Sell<br>Price</td><td>Current<br>Price</td>
	</tr>
<% 
Integer i =0;

query=" select x.* ,round((sold_value -sold_buy_value),2) relealized_PL ,(unrealized_Qty*last_price) unrealized_PL  ";
query +=" from (select al.Exchange,al.tradingSymbol,al.scrip_code,(select last_price from intraday.market_data_sk  where instrument_token = al.scrip_code order by 1 desc limit 1) last_price, ";
query +=" al.buy_qty,al.buy_value,buy_orders,avg_buy_price,ifnull(avg_sell_price,0) avg_sell_price,";
query +=" ifnull(sold_qty,0) sold_qty,ifnull(sold_value,0) sold_value,ifnull(sold_orders,0) sold_orders,";
query +=" ifnull(open_qty,0) open_qty, ifnull(open_value,0) open_value,ifnull(open_orders,0) open_orders,";
query +=" sold_buy_value,ifnull(unrealized_Qty,0) unrealized_qty";
query +=" from (select  Exchange,tradingSymbol,scrip_code,round(avg(price),2) avg_buy_price,max(price) max_buy_price,sum(qty) buy_qty, round(sum(price*qty),2) buy_value,count(1) buy_orders,";
query +=" round(sum(if(ref_order_id is not null,price*qty,0))) sold_buy_value";
query +=" from intraday.orders o  where o.date_inserted >= current_date and status='pending' and type='BUY' ";
query +=" group by Exchange,tradingSymbol,scrip_code ) al ";
query +=" left outer join (select  Exchange,tradingSymbol,scrip_code,max(price) max_buy_price,sum(qty) open_qty, round(sum(price*qty),2) open_value,count(1) open_orders from intraday.orders o  ";
query +=" where o.date_inserted >= current_date and status='pending' and type='BUY' and ref_order_id is null ";
query +=" group by Exchange,tradingSymbol,scrip_code ) open on al.Exchange=open.Exchange and al.tradingSymbol=open.tradingSymbol and al.scrip_code=open.scrip_code";
query +=" left outer join ( select  Exchange,tradingSymbol,scrip_code,max(price) max_buy_price,sum(qty) sold_qty, round(avg(price),2) avg_sell_price, round(sum(price*qty),2) sold_value,count(1) sold_orders ,";
query +=" round(sum(if(ref_order_id is not null,qty,0))) unrealized_Qty from intraday.orders o where o.date_inserted >= current_date and status='pending' and type='SELL' and ref_order_id is not null ";
query +=" group by Exchange,tradingSymbol,scrip_code  ) sold  on al.Exchange=sold.Exchange and al.tradingSymbol=sold.tradingSymbol and al.scrip_code=sold.scrip_code ) X ";
rs=stmt.executeQuery(query);
while(rs.next()) { 
i=i+1; 
%>
<tr class="content style1" align="center">
		<td><%=i%></td><td align="left"><%=rs.getString("exchange")%></td>
		<td align="left">
		<a href="orderDetail.jsp?vcode=<%=rs.getString("tradingsymbol")%>" target="popup" style="font-size: 9pt; color: #990000 ;font-weight: normal" onclick="window.open('intraday/intradaydet.jsp?vcode=<%=rs.getString("scrip_code")%>','popup','width=1000,height=1000'); return false;"><%=rs.getString("tradingsymbol")%>
		</a></td>
		<td align="left"><%=rs.getString("buy_orders")%></td><td align="left"><%=rs.getString("buy_qty")%></td>
		<td align="left"><%=rs.getString("sold_orders")%></td><td align="left"><%=rs.getString("sold_qty")%></td>
		<td align="left"><%=rs.getString("open_orders")%></td><td align="left"><%=rs.getString("open_qty")%></td>
        <td align="left"><%=rs.getString("buy_value")%></td><td align="left"><%=rs.getString("sold_value")%></td>
		<td align="left"><%=rs.getString("open_value")%></td>
		<td align="left"><%=rs.getString("relealized_PL")%></td>
		<td align="left"><%=rs.getString("unrealized_PL")%></td>
		<td align="left"><%=rs.getString("avg_buy_price")%></td><td align="left"><%=rs.getString("avg_sell_price")%></td><td align="left"><%=rs.getString("last_price")%></td>
		
 </tr>

<% } %>
</table> 
</td>
<%
query  ="  select id,exchange,type transaction_type,tradingsymbol,scrip_code,price, qty, date_inserted time,ifnull(trigger_price,'') trigger_price, ifnull(trigger_date,'') trigger_date, status, comments from intraday.orders where status='Pending' and date_inserted > current_date order by  tradingsymbol,date_inserted";
rs = stmt.executeQuery(query);
%>

<td>
<table  border="1" id="my_table"  cellpadding="2" cellspacing="0" align="left" >
 <thead>
 	<tr class="Blue-content" align="center">
	<th>Sl#</th><th>Exchange</th>
	<th> Buy/Sell</th><th>Scrip</th><th>OrderPrice</th><th>Qty</th>
	<th>OrderTime</th> 
	<th>TriggerPrice</th><th>TriggerDate</th>
	<th>status</th><th>comments</th> 
	</tr>
</thead>

<% while(rs.next()){ %>
        <tr class="content style1" align="center"><td><%=rs.getString("id")%></td><td align="left"><%=rs.getString("exchange")%></td>
        <td><%=rs.getString("transaction_type")%></td>
		<td align="left">
		<a href="intradaydet.jsp?vcode=<%=rs.getString("tradingsymbol")%>" target="popup" style="font-size: 9pt; color: #990000 ;font-weight: normal" onclick="window.open('intraday/intradaydet.jsp?vcode=<%=rs.getString("scrip_code")%>','popup','width=1000,height=1000'); return false;"><%=rs.getString("tradingsymbol")%>
		</a></td>
		<td align="left"><%=rs.getString("price")%></td>
		<td align="left"><%=rs.getString("qty")%></td>
        <td><%=rs.getString("time")%></td><td><%=rs.getString("trigger_price")%></td>
        <td><%=rs.getString("trigger_date")%></td><td><%=rs.getString("status")%></td>
		<td align="left"><%=rs.getString("comments")%></td>
         </tr>
        <%} %>
</table>
</td>


</tr>
</form>
</BODY>
</HTML>
