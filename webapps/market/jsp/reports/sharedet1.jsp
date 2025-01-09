<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>


<%@ page import="java.io.*" %>
<%@ page  import="java.awt.*" %>


<%@ page import="org.jfree.chart.*" %>
<%@ page import="org.jfree.chart.renderer.category.*" %>  
<%@ page import="org.jfree.chart.plot.*" %>  

<%@ page import="org.jfree.chart.ChartFactory" %>
<%@ page import="org.jfree.chart.ChartUtilities" %>
<%@ page import="org.jfree.chart.ChartColor" %>
<%@ page import="org.jfree.chart.JFreeChart" %>
<%@ page import="org.jfree.chart.plot.CategoryPlot" %>
<%@ page import="org.jfree.chart.plot.PlotOrientation" %>
<%@ page import="org.jfree.chart.axis.CategoryLabelPositions" %>
<%@ page import="org.jfree.chart.axis.CategoryAxis" %>
<%@ page import="org.jfree.chart.axis.ValueAxis" %>
<%@ page import="org.jfree.chart.axis.NumberAxis" %>
<%@ page import="org.jfree.data.category.DefaultCategoryDataset" %>

<%@ page  import ="org.jfree.chart.plot.XYPlot" %>
<%@ page  import ="org.jfree.data.xy.XYDataset" %>
<%@ page  import ="org.jfree.data.xy.XYSeries" %>

<%@ page import="org.jfree.data.category.*" %>  
<%@ page import="org.jfree.data.general.DefaultPieDataset" %>  
<%@ page import="org.jfree.data.xy.*" %>  
<%@ page import="org.jfree.data.*" %>  








<%@ page   %>

<script>
function parameter(){
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
var vscrip= document.getElementById("txtScrip").value
var vexchange= document.getElementById("txtExchange").value
var vOI= document.getElementById("txtOI").value
	//alert(vexchange);
window.location.replace("sharedet.jsp?vexchange="+vexchange+"&&scrip="+vscrip+"&&vfdate="+vfdate+"&&vtdate="+vtdate+"&&OI="+vOI);
}
</script>



<%
Connection con=null;
ResultSet rs=null;
ResultSet rs1=null;
Statement stmt=null;
Statement stmt1=null;

String query="";
String query1="";

Integer vh=600;
Integer vw=300;
float del_qty=0;

DecimalFormat decf = new DecimalFormat("####0.00");
%>

<%
try
{
	con=(Connection)session.getAttribute("connection");
	stmt =  con.createStatement();
	stmt1 =  con.createStatement();

}

catch(Exception e)
{
	System.out.println("Exception"+e);
}
%>

<%
String vscrip=request.getParameter("scrip");
String vfdate=request.getParameter("vfdate");
String vtdate=request.getParameter("vtdate");
String vexchange=request.getParameter("vexchange");
String vOI=request.getParameter("OI");

Integer rcount=1;

DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());


if(vfdate == null){ 
// vfdate=formattedDate;

		rs=stmt.executeQuery("SELECT TO_CHAR(to_date(MIN(EOD_DATE),'yyyymmdd'),'dd/mm/yyyy') EOD_DATE FROM (SELECT EOD_DATE FROM EOD_DATE ORDER BY 1 DESC) WHERE ROWNUM<=60");  
		while(rs.next()){
		vfdate=rs.getString(1);
		}
 vtdate=formattedDate;
}
//out.println(vscrip);


//if ("NSE".equalsIgnoreCase(vexchange)){
if ("NIFTY".equalsIgnoreCase(vscrip)||"BANKNIFTY".equalsIgnoreCase(vscrip)){

query1 = "select to_char(to_date(n.eod_date,'yyyymmdd'),'dd/mm/yyyy') day,to_char(to_date(n.eod_date,'yyyymmdd'),'dd/mm') mday, n.eod_date";
query1 = query1+",n.code,0 nse_del,n.volume nse_qty,n.turnover nse_turnover,n.close close_price,n.open prev_close,";
query1 = query1+" change_per price_change_per,0 bse_del,0 bse_qty,0 bse_turnover,coalesce(fo.open_int,0) open_int,";
query1 = query1+" coalesce(fo.chg_in_oi,0) chg_in_oi,coalesce(oi_chg_per,0) oi_chg_per,coalesce(fo.opt_puts_open_int,0) opt_puts_open_int,";
query1 = query1+" coalesce(fo.opt_puts_chg_in_oi,0) opt_puts_chg_in_oi,coalesce(opt_puts_oi_chg_per,0) opt_puts_oi_chg_per,";
query1 = query1+" coalesce(fo.opt_calls_open_int,0) opt_calls_open_int,coalesce(fo.opt_calls_chg_in_oi,0) opt_calls_chg_in_oi,";
query1 = query1+" coalesce(opt_calls_oi_chg_per,0) opt_calls_oi_chg_per,0 bulk_buy,0 bulk_sell,0 nse_delivery,0 bse_delivery ,";
query1 = query1+" round(((fut_close_price-n.close)*100/n.close),2) coc_per,0 limit_per,1 cur_delivery,1 prev_delivery  from ";
query1 = query1+" (select eod_date,decode( code,'CNX Nifty','NIFTY','CNX Bank','BANKNIFTY','-') code,open,close,volume,turnover,change_per";
query1 = query1+" from nse_ind where code in ('CNX Nifty','CNX Bank')) N,";
query1 = query1+" (select eod_date,code,close fut_close_price from nse_fo where exists (select 1 from ";
query1 = query1+" (select eod_date,code,min(expiry_date) expiry_date from nse_fo where option_type='XX' and eod_date >= to_char(sysdate-90,'yyyymmdd') ";
query1 = query1+" group by eod_date,code) a  where a.code=nse_fo.code and a.eod_date=nse_fo.eod_date  and a.expiry_date=nse_fo.expiry_date) and option_type='XX') fut_close,";
query1 = query1+" vw_nse_fo fo ";
query1 = query1+" where n.code=fut_close.code and n.eod_date=fut_close.eod_date and n.code=fo.code(+) and n.eod_date=fo.eod_date(+)";
query1 = query1+" and n.code ='"+vscrip+"' and n.eod_date between to_char(to_date('"+vfdate+"','dd/mm/yyyy'),'yyyymmdd') and to_char(to_date('"+vtdate+"','dd/mm/yyyy'),'yyyymmdd') ";
query1 = query1+" order by eod_date desc";
			
//	out.println(query1);
}
else {
	query1= "SELECT to_char(to_date(n.eod_date,'YYYYMMDD'),'DD/MM/YYYY') day,TO_CHAR(TO_DATE(N.EOD_DATE,'YYYYMMDD'),'DD/MM') MDAY, n.eod_date,n.code,DECODE(n.delivery_per,'-',0,n.delivery_per) nse_del,n.TTL_TRD_QNTY nse_qty,n.turnover_lacs nse_turnover,n.close_price,n.prev_close,round(((n.CLOSE_PRICE-n.PREV_CLOSE)/n.PREV_CLOSE)*100,2) PRICE_CHANGE_PER,b.bse_del,b.bse_qty,b.bse_turnover,";
	query1= query1+"coalesce(fo.OPEN_INT,0) open_int,coalesce(fo.CHG_IN_OI,0) CHG_IN_OI,COALESCE(OI_CHG_PER,0) OI_CHG_PER,";
	//query1= query1+"coalesce(fo.OPT_PUTS_OPEN_INT,0) OPT_PUTS_open_int,coalesce(fo.OPT_PUTS_CHG_IN_OI,0) OPT_PUTS_CHG_IN_OI,COALESCE(OPT_PUTS_OI_CHG_PER,0) OPT_PUTS_OI_CHG_PER,";
	//query1= query1+"coalesce(fo.OPT_CALLS_OPEN_INT,0) OPT_CALLS_open_int,coalesce(fo.OPT_CALLS_CHG_IN_OI,0) OPT_CALLS_CHG_IN_OI,COALESCE(OPT_CALLS_OI_CHG_PER,0) OPT_CALLS_OI_CHG_PER,";
	query1= query1+" COALESCE(BULK_BUY,0) BULK_BUY,COALESCE(BULK_SELL,0) bulk_sell,";
	query1= query1+" round(N.DELIVERY/1000,2) NSE_DELIVERY, round(BSE_DELIVERY/1000,2) BSE_DELIVERY,";
	query1= query1+" round(((fut_close_price-n.close_price)*100/n.close_price),2) coc_per,mplimit,round((open_int/mplimit)*100,2) limit_per, ";
	query1= query1+" (select delivery  from nse_bhav where eod_date=(select max(eod_date) from nse_bhav b where b.code=n.code and b.eod_date<n.eod_date) and code=n.code) prev_delivery,n.delivery cur_delivery ";
	query1= query1+" FROM NSE_BHAV N,(SELECT EOD_DATE, NSE_CODE, DELIVERY BSE_DELIVERY,ROUND(turnover/100000,2)BSE_TURNOVER, TTL_TRD_QNTY bse_qty,delivery_per bse_del FROM BSE_BHAV x,SCRIP_CODE y WHERE y.bse_code=x.code) B ,VW_NSE_FO FO ";
	query1= query1+" ,(select EOD_DATE,CODE,CLOSE fut_close_price from nse_Fo where exists (select 1 from (select EOD_DATE,CODE,min(EXPIRY_DATE) expiry_date from NSE_FO where  OPTION_TYPE='XX' ";
	query1= query1+" AND EOD_DATE >= to_char(sysdate-90,'YYYYMMDD') group by EOD_DATE,CODE) a where a.code=nse_fo.code and a.eod_date=nse_fo.eod_date and a.expiry_date=nse_fo.expiry_date) ";
	query1= query1+" and  OPTION_TYPE='XX') fut_close,(select eod_date,nse_code code,limit mplimit from mpl ) mpl ";
	query1= query1+" WHERE N.EOD_DATE=B.EOD_DATE(+) AND N.CODe=B.NSE_CODE(+) AND N.EOD_DATE=FO.EOD_DATE(+) AND N.CODE=FO.CODE(+) AND N.series='EQ' AND n.code='"+vscrip+"' and n.eod_date between to_char(to_date('"+vfdate+"','dd/mm/yyyy'),'yyyymmdd') and to_char(to_date('"+vtdate+"','dd/mm/yyyy'),'yyyymmdd') ";
	query1= query1+" and n.eod_date=fut_close.eod_date(+) and n.code=fut_close.code(+) and n.code=mpl.code(+)  and n.eod_date=mpl.eod_date(+)	";
	query1= query1+" order by n.eod_date desc";
	// out.println(query1);
	}
//}

	float vndel_max = 0;
	float vndel_min = 0;
	
	float vbdel_max=0;
	float vbdel_min=0;

	float voic_max=0;
	float voic_min=0;

	float vcoc_max=0;
	float vcoc_min=0;

	float voicl_max=0;
	float voicl_min=0;

	float vqty_max=0;
	float vqty_min=0;

	float vlp_max=0;
	float vlp_min=0;
	float vdqty_max=0;
	float vdqty_min=0;


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
</head>
<body>


<table width="100%" border="1" class="border" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
<tr class="content style1"><td class="Blue-content">NSE CODE:</td> <td  colspan=""><B><%=vscrip%></td>
				<% 
				query="select * from scrip_code where nse_code='"+vscrip+"'";
				rs=stmt.executeQuery(query);  
				while(rs.next()){
				%>
				  <td class="Blue-content">BSE CODE:</td><td  colspan="3"><B> <%=rs.getString(3)%></td> 
				<tr class="content style1"><td class="Blue-content">COMPANY:</td> <td  colspan=""><B><%=rs.getString(1)%></td> <td class="Blue-content">BUSINESS:</td> <td  colspan="3"><B><%=rs.getString(2)%></td> <tr> <tr> 
				<BR>
				
				<%} %>
				</tr>
<!--   date selection starts here -->

<td class="Blue-content" align="left"><b>From:</b>
<input id="fdate"  class="content style1" type="text" name="fdate" size="10" maxlength="12" value=<%=vfdate%>>
<a href="javascript:NewCal('fdate','ddmmyyyy',false)"><img src="../../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a>
</td>

<td class="Blue-content" align="left"><b>To</b>
<input id="tdate"  class="content style1" type="text" name="tdate" size="10" maxlength="12" value=<%=vtdate%>>
<a href="javascript:NewCal('tdate','ddmmyyyy',false)"><img src="../../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a>

</td>


 <!-- date selection Ends here 

<input class="content style1" type="hidden" id="txtExchange" name="txtExchange" size="10" maxlength="12" value=<%=vexchange%>>
-->
<input class="content style1" type="hidden" id="txtScrip" name="txtScrip" size="10" maxlength="12" value=<%=vscrip%>>

<td class="Blue-content">Exchange:<input class="content style1" id="txtExchange" name="txtExchange"  size="4" maxlength="12" value=<%=vexchange%>></td>
<td><input class="content style1" type="submit" value="Go" onClick="parameter()"></td> <tr>
</table>
<table><tr><td valign=top>

				<table width="100%" border="1" cellpadding="2"  bgcolor="#DBEBFF" cellspacing="0" id="stretch" > 
				<tr class="Blue-content" align="center">
				<td>Day</td><td>NSE<br>Price</td><td>Price<BR>Change<br>%</td>
				<td>NSE<br>Del<BR>%</td><td>BSE<br>Del<BR>%</td>
				<td>OI Change<br>%</td>
				<td>COC<br>%</td>
				<!-- <td>NSE<br>Turnover<BR>(Lakhs)</td> -->
				<!-- <td>BSE&nbsp;Turnover<BR>(in Lakhs)</td> -->
				<td>OI Close</td>
				
<!-- <td>Prev <br>Delivery</td> -->
<td>Curr<br>Delivery</td>
<td>Del Qty<br> %</td>
<td>OI Limit<br> %</td>


				</tr>


				</tr>

				<%
				 rs1=stmt1.executeQuery(query1);
				 /* code for line chart */
				File image = File.createTempFile("image", "tmp");
				final DefaultCategoryDataset dataset = new DefaultCategoryDataset();
				final DefaultCategoryDataset dataset1 = new DefaultCategoryDataset();
				final DefaultCategoryDataset datasetOI = new DefaultCategoryDataset();
				final DefaultCategoryDataset datasetCOC = new DefaultCategoryDataset();
				final DefaultCategoryDataset datasetOIC = new DefaultCategoryDataset();
				final DefaultCategoryDataset datasetQTY = new DefaultCategoryDataset();
				final DefaultCategoryDataset datasetLP = new DefaultCategoryDataset();
				final DefaultCategoryDataset datasetDQTY = new DefaultCategoryDataset();

				 
while(rs1.next()){
					del_qty=(rs1.getFloat("cur_delivery")-rs1.getFloat("prev_delivery"))*100/rs1.getFloat("prev_delivery");

			               dataset.addValue(rs1.getFloat("nse_del"),"NSE Delivery",rs1.getString("mday"));
					 dataset.addValue(rs1.getFloat("PRICE_CHANGE_PER"),"Price Change %",rs1.getString("mday"));
					 dataset1.addValue(rs1.getFloat("bse_del"),"BSE Delivery",rs1.getString("mday"));
					 datasetQTY.addValue(rs1.getFloat("nse_qty"),"Nse Qty",rs1.getString("mday"));
					 datasetDQTY.addValue(rs1.getFloat("cur_delivery"),"Delivery" ,rs1.getString("mday"));
   if (vndel_max < rs1.getFloat("nse_del")){vndel_max = rs1.getFloat("nse_del")+1; }
   if (vndel_max < rs1.getFloat("PRICE_CHANGE_PER")){vndel_max = rs1.getFloat("PRICE_CHANGE_PER")+1; }
   if (vndel_min > rs1.getFloat("nse_del")){vndel_min = rs1.getFloat("nse_del")-1; }
   if (vndel_min > rs1.getFloat("PRICE_CHANGE_PER")){vndel_min = rs1.getFloat("PRICE_CHANGE_PER")-1; }

   if (vbdel_max < rs1.getFloat("bse_del")){vbdel_max = rs1.getFloat("bse_del")+1; }
   if (vbdel_min > rs1.getFloat("bse_del")){vbdel_min = rs1.getFloat("bse_del")-1; }
  
   if (vqty_max < rs1.getFloat("nse_qty")){vqty_max = rs1.getFloat("nse_qty")+100; }
   if (vqty_min > rs1.getFloat("nse_qty")){vqty_min = rs1.getFloat("nse_qty")-100; }
   if (vdqty_max < rs1.getFloat("cur_delivery")){vdqty_max = rs1.getFloat("cur_delivery")+10; }
   if (vdqty_min > rs1.getFloat("cur_delivery")){vdqty_min = rs1.getFloat("cur_delivery")-10; }

if (!"null".equalsIgnoreCase(vOI) ) {
					out.println(vOI);
				}


 

%>

<% if (rcount==1){ %>
				<tr class="content" align="right" bgcolor="#FFFFFF">
<% rcount=0;
	} else { %>
				<tr class="content" align="right" bgcolor="#DBEBFF">
<% rcount=1;} %>

	<td><%=rs1.getString("day")%></td><td><%=decf.format(rs1.getFloat("close_price"))%></td>
	<td><%=decf.format(rs1.getFloat("PRICE_CHANGE_PER"))%></td>
					<td><%=decf.format(rs1.getFloat("nse_del"))%></td><td><%=decf.format(rs1.getFloat("bse_del"))%></td>
					 <td><%=decf.format(rs1.getFloat("OI_CHG_PER"))%></td>
					 <td><%=decf.format(rs1.getFloat("COC_PER"))%></td>	
					<!-- <td><%=rs1.getString("nse_turnover")%></td> -->
					<!-- <td><%=rs1.getString("bse_turnover")%></td> -->
					
					<td><%=rs1.getString("open_int")%></td>
				<!-- <td><%=rs1.getString("prev_delivery")%></td>  -->
					<td><%=rs1.getString("cur_delivery")%></td>
					
				<td><%= decf.format(del_qty)%></td>
				<td><%=rs1.getFloat("limit_per")%></td>




	</tr> 
<% 
} %>
</table>
</td>

<td valign=top>	
			<table width="100%" border="0" cellpadding="2" cellspacing="0" id="stretch" bgcolor="#DBEBFF"> 
			<tr><td>
			<!-- <img src="chartnse.jpg" id="reloader" onload="setTimeout('document.getElementById(\'reloader\').src=\'chartnse.jpg?\'+new Date().getMilliseconds()', 10000)" /> -->
			<img src="tmp/chartnse<%=vscrip%>.jpg">
			</td></tr>
			<tr><td>
			<img src="tmp/chartDQTY<%=vscrip%>.jpg">
			</td></tr>

			<tr><td>
			<img src="tmp/chartOI<%=vscrip%>.jpg">
			</td></tr>
			<tr><td>
			<img src="tmp/chartCOC<%=vscrip%>.jpg">
			</td></tr>
			<tr><td>
			<img src="tmp/chartOIC<%=vscrip%>.jpg">
			</td></tr>
			<tr><td>
			<img src="tmp/chartQTY<%=vscrip%>.jpg">
			</td></tr>
<%if ("NIFTY".equalsIgnoreCase(vscrip)||"BANKNIFTY".equalsIgnoreCase(vscrip)){

}
else {

%>			
		<!--	<tr><td>
			<img src="tmp/chartLP<%=vscrip%>.jpg">
			</td></tr> -->			
			<tr><td>
			<img src="tmp/chartbse<%=vscrip%>.jpg">
			</td></tr>

<%}%>
		</table>
</td>
</tr>
</table>

<% 
try{

rs1.close();
stmt.close();
}
catch(Exception e1)
{
	System.out.println("Exception"+e1);
}

finally{
rs1.close();
stmt.close();
}
%>
</body>
</html>

