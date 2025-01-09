<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>


<%@ page import="java.io.*" %>  
<%@ page import="org.jfree.chart.JFreeChart" %>  
<%@ page import="org.jfree.chart.ChartUtilities" %>  

<%@ page  import="java.awt.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import ="org.jfree.data.general.*"%>
<%@ page  import="org.jfree.data.category.*"%>

<%@ page  import ="org.jfree.chart.ChartFactory" %>
<%@ page  import ="org.jfree.chart.ChartPanel" %>
<%@ page  import ="org.jfree.chart.axis.NumberAxis" %>
<%@ page  import ="org.jfree.chart.plot.PlotOrientation" %>

<%@ page  import ="org.jfree.ui.ApplicationFrame" %>
<%@ page  import ="org.jfree.ui.RefineryUtilities" %>


<%@ page  import ="org.jfree.chart.plot.XYPlot" %>
<%@ page  import ="org.jfree.chart.renderer.xy.XYLineAndShapeRenderer" %>
<%@ page  import ="org.jfree.data.xy.XYDataset" %>
<%@ page  import ="org.jfree.data.xy.XYSeries" %>
<%@ page  import ="org.jfree.data.xy.XYSeriesCollection" %>
<%@ page  import ="org.jfree.data.time.TimeSeries" %>
<%@ page  import ="org.jfree.data.time.Month" %>



<script>

function trim(s)
	{
	var l=0;
	var r=s.length -1;
	while (l < s.length && s[l] == ' '){ l++;}
	while (r > 1 && s[r] == ' ') {r-=1;}
	return s.substring(l,r+1);
}


function search(){
var vid4 = trim(document.getElementById("txtSearch").value)
var search=vid4.toUpperCase();
window.open("sharedet.jsp?vexchange=NSE&&scrip="+search);
}



function searchTover(){
	//alert("Turnover Search");
var vtover = document.getElementById("txtTover").value
//var vfdate= document.getElementById("fdate").value
//var vtdate= document.getElementById("tdate").value
var vqty= document.getElementById("txtQty").value
window.location.replace("shareanalysis.jsp?vtover="+vtover+"&&vqty="+vqty);
}


<% 
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
 response.setHeader("Pragma","no-cache"); //HTTP 1.0
 response.setDateHeader("Expires", -1);
 %>

</script>

<!-- added for sorting table --->
<script type="text/javascript" src="../../Script/gs_sortable.js"></script>
<script type="text/javascript">
var TSort_Data = new Array ('my_table', 's', 'i', 'f','f','f','f','f','f','f','f','f','f','f','','','f');
var TSort_Classes = new Array ('row1', 'row2');
var TSort_Initial = 1;
//tsRegister();
</script>


<%!
Connection con=null;
ResultSet rs=null;
ResultSet rs1=null;
Statement stmt=null;
String query="";
String e;  
%>

<%
try
{
	//Class.forName("oracle.jdbc.driver.OracleDriver"); 
	//con = DriverManager.getConnection( "jdbc:oracle:thin:@localhost:1521:xe", "share", "abc123"); 
	con=(Connection)session.getAttribute("connection");
	stmt =  con.createStatement();

}

catch(Exception e)
{
	System.out.println("Exception"+e);
}
%>

<%

String value4=request.getParameter("value4");
String search=request.getParameter("value4");
String vtover=request.getParameter("vtover");
String vqty=request.getParameter("vqty");

if (value4==null){value4="0";}
if (search==null){search=" ";}
if (vqty==null){vqty="1.5";}
if (vtover==null){vtover="5000";}


String vfdate=request.getParameter("vfdate");
String vtdate=request.getParameter("vtdate");
String vparam=request.getParameter("param");

Integer rcount=1;

DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());


if(vfdate == null){ 
// vfdate=formattedDate;

		rs=stmt.executeQuery("SELECT TO_CHAR(to_date(MIN(EOD_DATE),'yyyymmdd'),'dd/mm/yyyy') EOD_DATE FROM (SELECT EOD_DATE FROM EOD_DATE ORDER BY 1 DESC) WHERE ROWNUM<=30");  
		while(rs.next()){
		vfdate=rs.getString(1);
		}
 vtdate=formattedDate;
}
if (vparam==null){vparam="All";}



%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reports</title>
<script type="text/javascript" src="../../Script/tabber.js"></script>
<script language="javascript" type="text/javascript" src="../../Script/datepicker.js"></script> 
<link href="../../styles/text.css" rel="stylesheet" type="text/css">
</head>
<body>


	  

<table width="100%" border="1" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
<tr><td width="15%" VALIGN=TOP>
<table width="100%" border="0" class="border" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
<tr><td class="Blue-content" colspan="4"><b>Criteria</b></td></tr>
<tr ><td class="Blue-content" colspan="2"><b>Qty>=</b><input type=text id=txtQty name=txtQty  class="content style1" value="<%=vqty%>" size="2"><b>x AvgQty</b></td></tr>

<tr><td class="Blue-content" colspan="2"><b>Turnover>=</b><input type=text name=txtTover  id=txtTover class="content style1" value="<%=vtover%>" size="5">Lakhs</td></tr>
<tr><td  colspan="2" align ="center" ><input class="content style1" type="submit" value="Search" onClick="searchTover()"></td>

</table>

<table width="100%" border="1" class="border" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>

<tr><td class="Blue-content" colspan="6" align="left">Select ..</td></tr>

<tr><td class="content style1"><b>Code</b> </td>
<td><input type=text name=txtSearch  class="content style1" value="<%=search%>" size="10">
<input class="content style1" type="submit" value="Search" onClick="search()"></td>




</table>
</td>
<td valign=top>

			<%

				query="SELECT * FROM ";
				query=query+" (SELECT to_char(to_date(a.EOD_DATE,'YYYYMMDD'),'DD/MM/YY') eod_date,a.CODE,ROUND((B.DELIVERY/B.TTL_TRD_QNTY)*100,2) DELIVERY_PER1,ROUND((A.DELIVERY/A.TTL_TRD_QNTY)*100,2) DELIVERY_PER2, ";
				query=query+" ROUND(((A.DELIVERY/A.TTL_TRD_QNTY)-(B.DELIVERY/B.TTL_TRD_QNTY))/(B.DELIVERY/B.TTL_TRD_QNTY)*100,2) AS DIFF_PER, ";
				query=query+" ROUND(A.TTL_TRD_QNTY/1000,2) TRADED_QTY, A.TURNOVER_LACS TRADED_VALUE,A.CLOSE_PRICE PRICE,A.PREV_CLOSE, ";
				query=query+" ROUND(((A.CLOSE_PRICE-A.PREV_CLOSE)/A.PREV_CLOSE)*100,2) PRICE_CHANGE_PER, OPEN_INT,CHG_IN_OI,OI_CHG_PER ";
				query=query+" FROM NSE_BHAV A ,NSE_BHAV B, ";
				query=query+" (SELECT EOD_DATE,CODE, SUM(OPEN_INT) OPEN_INT,SUM(CHG_IN_OI) "; 
				query=query+" CHG_IN_OI,ROUND(SUM(CHG_IN_OI)*100/SUM(OPEN_INT-CHG_IN_OI),2)OI_CHG_PER FROM NSE_FO WHERE INSTRUMENT='FUTSTK' AND ";
				query=query+" OPTION_TYPE='XX' AND EOD_DATE=(SELECT MAX(EOD_DATE) FROM EOD_DATE) GROUP BY EOD_DATE,CODE) FO  ";
				query=query+" WHERE a.series='EQ' AND a.series=b.series AND a.code=b.code AND a.code=FO.code(+) ";
				query=query+" AND a.EOD_DATE= (SELECT MAX(EOD_DATE) FROM EOD_DATE) ";
				query=query+" AND b.EOD_DATE=(SELECT MAX(EOD_DATE) FROM EOD_DATE WHERE EOD_DATE !=(SELECT MAX(EOD_DATE) FROM EOD_DATE)) ";
				query=query+" AND a.TTL_TRD_QNTY >0 AND b.TTL_TRD_QNTY >0 AND b.delivery>0) NSE, ";
				query=query+" (SELECT c.nse_code code,a.code bse_code,ROUND((B.DELIVERY/B.TTL_TRD_QNTY)*100,2) BSE_DELIVERY_PER1,";
				query=query+" ROUND((A.DELIVERY/A.TTL_TRD_QNTY)*100,2) BSE_DELIVERY_PER2,";
				query=query+" ROUND(((A.DELIVERY/A.TTL_TRD_QNTY)-(B.DELIVERY/B.TTL_TRD_QNTY))/(B.DELIVERY/B.TTL_TRD_QNTY)*100,2) BSE_DIFF_PER,";
				query=query+" A.TTL_TRD_QNTY/1000 BSE_TRADED_QTY,ROUND(A.TURNOVER/100000,2) BSE_TRADED_VALUE";
				query=query+" FROM BSE_BHAV A,BSE_BHAV B,SCRIP_CODE c";
				query=query+" WHERE a.EOD_DATE= (SELECT MAX(EOD_DATE) FROM EOD_DATE)";
				query=query+" AND b.EOD_DATE=(SELECT MAX(EOD_DATE) FROM EOD_DATE WHERE EOD_DATE !=(SELECT MAX(EOD_DATE) FROM EOD_DATE))";
				query=query+" AND a.code=b.code AND c.bse_code=a.code AND a.TTL_TRD_QNTY >0 AND b.TTL_TRD_QNTY>0 AND b.delivery>0 )BSE ";
				query=query+" WHERE nse.code=bse.code(+) ";
				query=query+" AND nse.code IN (SELECT CODE FROM RISING_TURNOVER WHERE nse_Qty > average_qty*"+vqty+" AND NSE_TURNOVER >="+vtover+") ";
				query=query+" order by nse.code";

				// out.println(query);
				rs=stmt.executeQuery(query);
%>
	<table width="100%" border="1" id="my_table" cellpadding="2" cellspacing="0" id="stretch" >
		<thead>
			<tr class="Blue-content" align="center"><!-- <td>Date</td> -->
			<td width="5%">Code</td>
			<td><b>NSE<BR>Closing Price(Rs)</b></td>
			<td><b>NSE<BR>Price Change %</b></td>
			<td>NSE<BR>Past Delivery(%)</td><td>NSE<BR> Latest Delivery(%)</td><td>NSE<BR>change in Delivery(%)</td>
			<td>BSE<BR>Past Delivery(%)</td><td>BSE<BR>Latest Delivery(%)</td><td>BSE<BR>change in Delivery(%)</td>
			<td>NSE<BR>Traded Qty(Thousands)</td><td>BSE<BR>Traded Qty(Thousands)</td>
			<td>NSE<BR>Traded Value (Lakhs)</td><td>BSE<BR>Traded Value (Lakhs)</td>
			<td>OI Close</td><td>OI Change</td><td>OI Change (%)</td>
			<td width="5%">Live</td>
			</tr>
	</thead>		
		<% 	while(rs.next()){ %>

			<tr class="content" align="right">
			<!-- <td><%=rs.getString("eod_date")%></td> -->
			<td align="left"><a href="sharedet.jsp?scrip=<%=rs.getString("code")%>&&vexchange=NSE" target="_blank" style="font-size: 9pt; color: #990000 ;font-weight: normal" > <%=rs.getString("code")%></a></td>
			<td><%=rs.getString("PRICE")%></td>
			<td><%=rs.getString("PRICE_CHANGE_PER")%></td>
			<td><%=rs.getString("DELIVERY_PER1")%></td> <td><%=rs.getString("DELIVERY_PER2")%></td><td><%=rs.getString("DIFF_PER")%></td> 
			<td><%=rs.getString("BSE_DELIVERY_PER1")%></td><td><%=rs.getString("BSE_DELIVERY_PER2")%></td><td><%=rs.getString("BSE_DIFF_PER")%></td>
			<td><%=rs.getString("TRADED_QTY")%></td> <td><%=rs.getString("BSE_TRADED_QTY")%></td>
			<td><%=rs.getString("TRADED_VALUE")%></td> <td><%=rs.getString("BSE_TRADED_VALUE")%></td>
			<td><%=rs.getString("OPEN_INT")%></td><td><%=rs.getString("CHG_IN_OI")%></td><td><%=rs.getString("OI_CHG_PER")%></td>
			<td align="left"><a href="http://www.nseindia.com/marketinfo/charting/OnlineStockChart.jsp?symbol=<%=rs.getString(1)%>&charttype=ONLINE_STOCK&series=EQ&mkttype=N" target="_blank" style="font-size: 9pt; color: #990000 ;font-weight: normal" ><img src="../../images/nse_logo.gif" alt="NSE live" width="20" height="20" border="0" /></a></td>
			</tr>	
		<%} %>
			</table>
			



	</table>
</td></tr>
</table>


</body>
</html>
