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

String vscrip=request.getParameter("vcode");
String vfdate=request.getParameter("fdate");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> Orders Dash Board </TITLE>
<link href="../../styles/text.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../Script/gs_sortable.js"></script>
<script type="text/javascript">
var TSort_Data = new Array ('my_table', 'i', 's','s','s','f','f','d');
var TSort_Classes = new Array ('row1', 'row6');
var TSort_Initial = '3D,10D';
var TSort_Cookie = 'sortable_table';
tsRegister();
</script>
</HEAD>

<BODY>
<form action="orderbook.jsp" method="post" name="frmentry" >
<% response.setIntHeader("Refresh", 20); %>

<tr>
<%
query  ="  select id,exchange,type transaction_type,tradingsymbol,scrip_code,price, qty, date_inserted time,ifnull(trigger_price,'') trigger_price, ifnull(trigger_date,'') trigger_date, status, comments from intraday.orders ";
query +=" where status='Pending' and date_inserted >= str_to_date('"+vfdate+"','%d/%m/%Y') and date_inserted < str_to_date('"+vfdate+"','%d/%m/%Y') + INTERVAL 1 DAY ";
query +=" and tradingsymbol=(select tradingSymbol from intraday.script_master  where scripCode="+vscrip+") order by  tradingsymbol,date_inserted";
//out.println(query);
rs = stmt.executeQuery(query);
Integer i =0;
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
		<a href="intradaydet.jsp?vcode=<%=rs.getString("tradingsymbol")%>" target="popup" style="font-size: 9pt; color: #990000 ;font-weight: normal" onclick="window.open('intradaydet.jsp?vcode=<%=rs.getString("scrip_code")%>','popup','width=1000,height=1000'); return false;"><%=rs.getString("tradingsymbol")%>
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
