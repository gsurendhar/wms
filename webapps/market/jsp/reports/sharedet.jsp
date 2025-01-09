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

<%
Connection con=null;
ResultSet rs=null;
ResultSet rs1=null;
Statement stmt=null;
Statement stmt1=null;

String query="";
String query1="";

Integer vh=550;
Integer vw=230;
float del_qty=0;
float vcprice=0;

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


String vtype=request.getParameter("type");
if (vtype == null){vtype ="SPOT";}
String vscrip=request.getParameter("scrip");
String vTchg = request.getParameter("vTchg");
if (vTchg == null){vTchg ="15";}

String vfdate="";
String vtdate="";
String vexchange="NSE";
String vOI="0";
String vBSE="0";


Integer rcount=1;

DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());

rs=stmt.executeQuery("select count(1) count from nse_fo where day >= subdate(current_date,20) and option_type='XX' and code='"+vscrip+"'");  
		while(rs.next()){ vOI =rs.getString(1);}

// rs=stmt.executeQuery("SELECT count(1) FROM BSE_BHAV x,SCRIP_CODE y WHERE y.bse_code=x.code and day > = subdate(current_date,20) and nse_code='"+vscrip+"'");  
//		while(rs.next()){ vBSE =rs.getString(1);}

		
	query="SELECT  min(day)  F_EOD_DATE,  max(day) T_EOD_DATE FROM (SELECT day FROM eod ORDER BY 1 DESC limit "+vTchg+")x"; 
	//out.println(query);
	rs=stmt.executeQuery(query);
	while(rs.next()){ vfdate=rs.getString(1);	
			    vtdate=rs.getString(1);	
	}

//if ("NIFTY".equalsIgnoreCase(vscrip)||"BANKNIFTY".equalsIgnoreCase(vscrip)){
if ("IDX".equalsIgnoreCase(vtype)){
query1 = "select to_char(to_date(n.eod_date,'yyyymmdd'),'dd/mm/yyyy') day,to_char(to_date(n.eod_date,'yyyymmdd'),'Mon-dd') mday, n.eod_date,n.code,";
query1 = query1+"open_price,high_price,low_price,";
query1 = query1+" 0 nse_del, Price20DMA, nseqty20DMA,Price20DMA,0 MACD,0 MACD_9EMA,0 MACD_CROSS,";
	query1 += " (CASE WHEN (prev_close-price20DMA) < 0 and (n.close-Price20DMA) >=0 THEN 'Buy' ";
	query1 += " WHEN (prev_close-price20DMA) > 0 and (n.close-Price20DMA) < 0 THEN 'Sell' ";
	query1 += " WHEN (prev_close-price20DMA) >= 0 and (n.close-Price20DMA) >=0 and (prev_close <= n.close) THEN 'AR' ";
	query1 += " WHEN (prev_close-price20DMA) >= 0 and (n.close-Price20DMA)>=0 and (prev_close > n.close) THEN 'AF' ";
	query1 += " WHEN (prev_close-price20DMA) < 0 and (n.close-Price20DMA) < 0 and (prev_close <= n.close) THEN 'BR' ";
	query1 += " WHEN (prev_close-price20DMA) < 0 and (n.close-Price20DMA) < 0 and (prev_close > n.close) THEN 'BF'  else '.' end) DMA20_CROSS, ";
// ROUND(((n.CLOSE-n.PREV_CLOSE)/n.PREV_CLOSE)*100,2) PRICE_CHANGE_PER, ";
query1 = query1+" ROUND(((n.CLOSE-n.OPEN)/n.OPEN)*100,2) PRICE_CHANGE_PER,";
query1 +=" n.volume nse_qty,";
query1 = query1+" n.turnover turnover_lacs,n.close close_price,n.open prev_close,";
query1 = query1+" change_per price_change_per,0 bse_del,0 bse_qty,0 bse_turnover,coalesce(fo.open_int,0) open_int,";
query1 = query1+" coalesce(fo.chg_in_oi,0) chg_in_oi,coalesce(oi_chg_per,0) oi_chg_per,coalesce(fo.opt_puts_open_int,0) opt_puts_open_int,";
query1 = query1+" coalesce(fo.opt_puts_chg_in_oi,0) opt_puts_chg_in_oi,coalesce(opt_puts_oi_chg_per,0) opt_puts_oi_chg_per,";
query1 = query1+" coalesce(fo.opt_calls_open_int,0) opt_calls_open_int,coalesce(fo.opt_calls_chg_in_oi,0) opt_calls_chg_in_oi,";
query1 = query1+" coalesce(opt_calls_oi_chg_per,0) opt_calls_oi_chg_per,0 bulk_buy,0 bulk_sell,0 nse_delivery,0 bse_delivery ,";
query1 = query1+" round(((fut_close_price-n.close)*100/n.close),2) coc_per,0 limit_per,1 cur_delivery,1 prev_delivery,";
query1 +=" (select turnover  from nse_ind ni where ni.eod_date=(select max(eod_date) from eod_date where eod_date<n.eod_date) and ni.code=n.ind_code) prev_turnover_lacs";
//query1 +=" (SELECT CHANGE_PER FROM NSE_IND WHERE CODE='CNX Nifty' AND EOD_DATE=n.EOD_DATE) NIFTY_CHG_PER, ";
//query1 +=" (SELECT CHANGE_PER FROM NSE_IND WHERE CODE='CNX Bank' AND EOD_DATE=n.EOD_DATE) BKNIFTY_CHG_PER ";
query1 = query1+"  from (select eod_date,(case when code='CNX Nifty' then 'NIFTY'";
query1 = query1+"			when code ='CNX Bank' then 'BANKNIFTY'";
query1 = query1+"			when code ='CNX IT' then 'CNXIT' end) code,";
query1 = query1+"		code ind_code,open,close,prev_Close,volume,turnover,change_per";
query1 = query1+" ,close_price_20DMA Price20DMA,ttl_trd_qnty_20DMA nseqty20DMA,close_price_18DMA,close_price_36DMA,close_price_72DMA from nse_ind where code in ('CNX Nifty','CNX Bank','CNX IT')) N,";
query1 = query1+" (select eod_date,code,close fut_close_price,OPEN open_price,high high_price,low low_price from nse_fo where exists (select 1 from ";
query1 = query1+" (select eod_date,code,min(expiry_date) expiry_date from nse_fo where option_type='XX' and eod_date >= to_char(sysdate-90,'yyyymmdd') ";
query1 = query1+" group by eod_date,code) a  where a.code=nse_fo.code and a.eod_date=nse_fo.eod_date  and a.expiry_date=nse_fo.expiry_date) and option_type='XX') fut_close,";
query1 = query1+" vw_nse_fo fo";
query1 = query1+" where n.code=fut_close.code and n.eod_date=fut_close.eod_date and n.code=fo.code(+) and n.eod_date=fo.eod_date(+)";
query1 = query1+" and replace(n.code,' ','') ='"+vscrip+"' and n.eod_date > = to_char(to_date('"+vfdate+"','dd/mm/yyyy'),'yyyymmdd') ";
query1 = query1+" order by eod_date asc";}
//if ("CD".equalsIgnoreCase(vtype)){
//	query1= "SELECT to_char(to_date(n.eod_date,'YYYYMMDD'),'DD/MM/YYYY') day,TO_CHAR(TO_DATE(N.EOD_DATE,'YYYYMMDD'),'DD/MM') MDAY,";
//	query1= query1+" n.eod_date,n.code,'-' bse_code,DECODE(n.cur_delivery_per,'-',0,n.cur_delivery_per) nse_del,n.cur_traded_qty/100000 nse_qty,n.cur_turnover_lakh nse_turnover,";
//	query1= query1+" n.cur_price close_price,n.cur_price-price20dma price20dma, (n.cur_traded_qty/100000) - nseqty20DMA  nseqty20DMA,";
//	query1= query1+" prev_price prev_close,round(((n.cur_price-n.prev_price)/n.prev_price)*100,2) price_change_per,0 bse_del,0 bse_qty,0 bse_turnover,";
//	query1= query1+" coalesce(OPEN_INT,0)/100000 open_int,coalesce(CHG_IN_OI,0) CHG_IN_OI,COALESCE(OI_CHG_PER,0) OI_CHG_PER,0 bulk_buy,0 bulk_sell,";
//	query1= query1+" 0 nse_delivery,0 bse_delivery,.0001 coc_per,0 mplimit,0 limit_per,1 cur_delivery,1 prev_delivery";
//	query1= query1+" from research_page n,";
//	query1= query1+" (select code,type,sum(cur_price)/count(1) Price20DMA,round((sum(cur_traded_qty)/count(1))/100000,2) nseqty20DMA  from research_page ";
//	query1= query1+" where eod_date >= (select min(eod_date) from (select eod_date from eod_date order by 1 desc) where rownum<=20) group by code,type) DMA20 ";
//	query1= query1+" where n.type='CD'  AND n.code='"+vscrip+"' and n.eod_date >= to_char(to_date('"+vfdate+"','dd/mm/yyyy'),'yyyymmdd') ";
//	query1= query1+" and n.code=DMA20.code and n.type=DMA20.type order by n.eod_date asc";
//	}
if ("SPOT".equalsIgnoreCase(vtype)){
	 
	
query1="select x.*,n.low low_price,n.high high_price,open open_price," ; 
//query1 += " #(CASE WHEN (CUR_DIV>=0 and PREV_DIV<0) THEN 'Buy' when (CUR_DIV<0 and PREV_DIV>=0) then 'Sell' WHEN (CUR_DIV-PREV_DIV) >=0 THEN 'C R' when (CUR_DIV-PREV_DIV)<0 then 'C F' else ' ' end) MACD_CROSS, "; 
query1 += " (CASE WHEN (prev_close-price20DMA) < 0 and (close_price-Price20DMA) >=0 THEN 'Buy' "; 
query1 += " WHEN (prev_close-price20DMA) > 0 and (close_price-Price20DMA) < 0 THEN 'Sell'";  
query1 += " WHEN (prev_close-price20DMA) >= 0 and (close_price-Price20DMA) >=0 and (prev_close <= close_price) THEN 'AR' "; 
query1 += " WHEN (prev_close-price20DMA) >= 0 and (close_price-Price20DMA)>=0 and (prev_close > close_price) THEN 'AF'";  
query1 += " WHEN (prev_close-price20DMA) < 0 and (close_price-Price20DMA) < 0 and (prev_close <= close_price) THEN 'BR' "; 
query1 += " WHEN (prev_close-price20DMA) < 0 and (close_price-Price20DMA) < 0 and (prev_close > close_price) THEN 'BF'  else '.' end) DMA20_CROSS  from ("; 
query1 += " select cur.series,cur.day,date_format(cur.day,'%M-%d') MDAY,"; 
query1 += " cur.code,cur.del_qty NSE_DELIVERY , if(cur.del_qty='-',0,cur.del_per) nse_del,cur.tottrdqty nse_qty,cur.turnover/100000 turnover_lacs,"; 
query1 += " cur.cur_price close_price, cur.price_20DMA price20DMA,cur.price_change_per,";
query1 += " prev.cur_price prev_close, prev.price_20DMA prev_price20DMA,";
query1 += " coalesce(cur.open_int,0)/100000 open_int,coalesce(cur.chg_in_oi,0) chg_in_oi,coalesce(cur.oi_chg_per,0) oi_chg_per,cur.del_qty/100000 cur_delivery,prev.del_qty/100000 prev_delivery,";
query1 += " cur.TURNOVER/100000 cur_turnover_lacs,  prev.TURNOVER/100000 prev_turnover_lacs, cur.del_per,cur.del_diff_per,round((cur.del_qty_20DMA-prev.del_qty_20DMA)*100/prev.del_qty_20DMA,2) del_20dma_chg_per";
query1 += " ,round(((cur.DEL_QTY/cur.TOTTRDQTY) / (cur.DEL_QTY_20DMA/cur.VOL_20DMA))*100,2) del_del20dma,round(((cur.DEL_QTY/cur.TOTTRDQTY) - (cur.DEL_QTY_20DMA/cur.VOL_20DMA))*100,2) del_del20dma_diff";
query1 += " from research_page cur  inner join research_page prev on cur.code=prev.code";
query1 += " inner join (select day c_eod,(select max(day)  from eod b where b.day < a.day) p_eod from eod a) e on  cur.day=c_eod and prev.day=p_eod ";
query1 += " where  cur.code='"+vscrip+"' and cur.day >=  '"+vfdate+"' ) x inner join nse_bhav n on n.code=x.code and x.day=n.day and n.series=x.series and n.series='EQ' "; 
query1 += " order by x.day "; 
}


	float vndel_max = 0;
	float vndel_min = 0;
	
	float vbdel_max=0;
	float vbdel_min=0;

	float voic_max=0;
	float voic_min=0;

	float voicl_max=0;
	float voicl_min=0;

	float vqty_max=0;
	float vqty_min=0;

	float vlp_max=0;
	float vlp_min=0;
	float vdqty_max=0;
	float vdqty_min=0;
	Integer vbqty_max=2;
	Integer vbqty_min=0;

	float vprice=0;
	float v20dmanseturn =0;
	float  v20dmanseturnMIN =0;

float vr1=0;
float vr2=0;
float vr3=0;

float vs1=0;
float vs2=0;
float vs3=0;

String strDay="";


%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Details <%=vscrip%></title>
<script type="text/javascript" src="../../Script/tabber.js"></script>
<script language="javascript" type="text/javascript" src="../../Script/datepicker.js"></script> 
<meta http-equiv="imagetoolbar" content="no" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="Tue,01 Dec 2010 06:30:00 GMT">
<link href="../../styles/text.css" rel="stylesheet" type="text/css">

<link href="../../libs/jqueryui/1.8/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="../../libs/jquery/1.4/jquery.min.js"></script>
<script src="../../libs/jqueryui/1.8/jquery-ui.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>

<script>
function parameter(){
var vscrip= document.getElementById("txtScrip").value
var vTchg =document.getElementById("cmbTchg").value
var vType =document.getElementById("txtType").value
window.location.replace("sharedet.jsp?scrip="+vscrip+"&&vTchg="+vTchg+"&&type="+vType);
}
</script>

<script>
function search(){
var vscrip= document.getElementById("searchBox").value
var vTchg =document.getElementById("cmbTchg").value
var vType =document.getElementById("txtType").value


	if ((vscrip == "NIFTY")||(vscrip == "BANKNIFTY")) {
		vType="IDX";
	} else {vType="SPOT";}

window.location.replace("sharedet.jsp?scrip="+vscrip+"&&vTchg="+vTchg+"&&type="+vType);
}
</script>

</head>
<body>
<table class="table" border="2" cellpadding="1" cellspacing="0"   >
	
<tr>
	<td valign=top>	
<table  class="border" border="0" cellpadding="0"  bgcolor="#DBEBFF" >
<tr class="content style1">
	<td  class="Blue-content" colspan="1" ><B><%=vscrip%></B>
		<input class="content style1" type="text" id="searchBox" name="searchString" size="10" />
	 	<button name="searchKeyword" id="searchKeyword" class="content style1" value="Search" onClick="search()" >Go</button>

		
			<% 
				query="select * from scrip_code where nse_code='"+vscrip+"'";
				rs=stmt.executeQuery(query);  
				while(rs.next()){
				%>
	 
				News:
				<a href="http://www.bseindia.com/stock-share-price/news/news/<%=rs.getString("bse_code")%>/" target="_blank" style="font-size: 9pt; color: #499999 ;font-weight: normal" >BSE</a>
				<a href="<%=rs.getString("mc_link")%>" target="_blank" style="font-size: 9pt; color: #600000 ;font-weight: normal">MC</a>
				<%} %>
			Days:
			<select id="cmbTchg" onchange="parameter()" class="content style1" size="0" width="2">
			<%   if ("35".equalsIgnoreCase(vTchg)) { %> <option value="15" selected disabled >15</option> <% } else {%> <option value="15">15</option>	
			<% }  if ("35".equalsIgnoreCase(vTchg)) { %> <option value="35" selected disabled >35</option> <% } else {%> <option value="35">35</option>
			<% } if ("70".equalsIgnoreCase(vTchg)) { %> <option value="70" selected disabled >70</option> <% } else {%> <option value="70">70</option>
			<% } if ("105".equalsIgnoreCase(vTchg)) { %> <option value="105" selected disabled >105</option> <% } else {%> <option value="105">105</option>
			<% } if ("140".equalsIgnoreCase(vTchg)) { %> <option value="140" selected disabled>140</option> <% } else {%> <option value="140">140</option>
			<% } if ("175".equalsIgnoreCase(vTchg)) { %> <option value="175" selected disabled>175</option> <% } else {%> <option value="175">175</option>
			<% } if ("250".equalsIgnoreCase(vTchg)) { %> <option value="250" selected disabled>250</option> <% } else {%> <option value="250">250</option>
			<%} %>
			</select>				
		</td>


<input type="hidden" id="txtScrip" name="txtScrip" size="10" maxlength="12" value=<%=vscrip%>>
<input type="hidden" id="txtOI" name="txtOI" size="10" maxlength="12" value=<%=vOI%>>
<input type="hidden" id="txtBSE" name="txtBSE" size="10" maxlength="12" value=<%=vBSE%>>
<input type="hidden" id="txtType" name="txtType" size="10" maxlength="12" value=<%=vtype%>>


</tr>

<tr>
	<td colspan="2" align="left">

				<table  border="1" cellpadding="0" cellspacing="0" width="90%">
				<tr class="content style1" align="center"><td colspan="2"></td><td colspan="3"><b>Resistance Levels</b></td><td colspan="3"><b>Support Levels</b></td></tr>
				<tr class="Blue-content" align="center"><td>Type</td><td>Pivot</td><td>R1</td><td>R2</td><td>R3</td><td>S1</td><td>S2</td><td>S3</td>
				</tr>
				
				<% 
				query="select 'Spot' type,code, ROUND(P,2) P,ROUND(R1,2) R1,ROUND(S1,2) S1, ";
				query=query+" ROUND((P-S1)+R1,2) as R2, ROUND(P-(R1-S1),2) S2 , ";
				//query=query+" ROUND(P-(P-(R1-S1))+((P-S1)+R1),2) R3,";
				query=query+" ROUND(high_price+2*(P-low_price),2) R3,";
				//query=query+" ROUND(P-(((P-S1)+R1)-( P-(R1-S1))),2) S3 ";
				query=query+" ROUND(low_price-2*(high_price-P),2) S3 ";
				query=query+" FROM ( select CODE,P, (2*P) - low_price as R1,(2*P) - high_price as S1,high_price,low_price,close_price from (";
				query=query+" select CODE,(high+ low+ close)/3 AS P,high high_price,low low_price,close close_price from nse_bhav ";
				query=query+" where day=(Select max(day) from eod) and series='EQ' and code='"+vscrip+"')x)y";
				//out.println(query);				
				rs=stmt.executeQuery(query);  
				while(rs.next()){ 
				%>
				<tr class="content style1" align="center">
				<td align="left"><%=rs.getString("type")%></td>
				<td><%=decf.format(rs.getFloat("P"))%></td>
				<td><%=decf.format(rs.getFloat("R1"))%></td>
				<td><%=decf.format(rs.getFloat("R2"))%></td>
 				<td><%=decf.format(rs.getFloat("R3"))%></td>
				<td><%=decf.format(rs.getFloat("S1"))%></td>
				<td><%=decf.format(rs.getFloat("S2"))%></td>
				<td><%=decf.format(rs.getFloat("S3"))%></td>
				</tr>
				<%} %>
				
				
				<%
				query="select 'Future' type,code, ROUND(P,2) P,ROUND(R1,2) R1,ROUND(S1,2) S1, ROUND((P-S1)+R1,2) as R2, ROUND(P-(R1-S1),2) S2 ,";
	 			query=query+" ROUND(high_price+2*(P-low_price),2) R3, ROUND(low_price-2*(high_price-P),2) S3 FROM ( ";
				query=query+" select CODE,edate,P, (2*P) - low_price as R1,(2*P) - high_price as S1,high_price,low_price,close_price from (";
				query=query+" select CODE,expiry_date as edate,(high+ low+ close)/3 AS P,";
				query=query+" high high_price,low low_price,close close_price from NSE_FO where instrument='FUTSTK' and day=(Select max(day) from eod) and code='"+vscrip+"' order by edate asc)x limit 1)y";
				rs=stmt.executeQuery(query);  
				while(rs.next()){ %>
				
				<tr style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; color: #500009 ;font-weight: normal" align="center">
				<td align="left"><%=rs.getString("type")%></td>
				<td><%=decf.format(rs.getFloat("P"))%></td>
				<td><%=decf.format(rs.getFloat("R1"))%></td>
				<td><%=decf.format(rs.getFloat("R2"))%></td>
 				<td><%=decf.format(rs.getFloat("R3"))%></td>
				<td><%=decf.format(rs.getFloat("S1"))%></td>
				<td><%=decf.format(rs.getFloat("S2"))%></td>
				<td><%=decf.format(rs.getFloat("S3"))%></td>
				</tr>
				<%} %>
				


				</table>
				</td>
</tr>

<tr>
<td valign=top colspan="2">
	<table width="100%" border="1" cellpadding="2"  bgcolor="#DBEBFF" cellspacing="0" id="stretch" > 

	<tr class="Blue-content" align="center">
	<td rowspan="1">Day</td>
	<td rowspan="1">Price</td>
	<td rowspan="1">Price<BR>Chg%</td>

	<% if ("IDX".equalsIgnoreCase(vtype)){ } else {%> <td colspan="1">Del<br>chg %</td><td>Del Qty<br>chg %</td>
	<td>Del<br>20DMA<br>Chg%</td>
	<td>Del To<br>Del20DMA<br>Chg%</td>
	<td>Del To<br>Del20DMA<br>Diff%</td>
	<td>Turnover<br>(Lakhs)</td> <%}%>
	<td>OI<br> Chg%</td>
	<td>20 DMA<BR>Cross</td>
	</tr>
<% 
// out.println(query1);
rs1=stmt1.executeQuery(query1);
int vrec=0;
float trd_val_chg=0;
/* code for line chart */
				File image = File.createTempFile("image", "tmp");
				final DefaultCategoryDataset dataset = new DefaultCategoryDataset();
 
while(rs1.next()){
	strDay = strDay+"'"+rs1.getString("day")+"',";
	
    del_qty=(rs1.getFloat("cur_delivery")-rs1.getFloat("prev_delivery"))*100/rs1.getFloat("prev_delivery");
    trd_val_chg=(rs1.getFloat("turnover_lacs")-rs1.getFloat("prev_turnover_lacs"))*100/rs1.getFloat("prev_turnover_lacs");
	
	dataset.addValue(rs1.getFloat("nse_qty")/1000,"Traded",rs1.getString("mday"));
	dataset.addValue(rs1.getFloat("NSE_DELIVERY")/1000,"Delivery",rs1.getString("mday"));

	JFreeChart barChart = ChartFactory.createBarChart(
         "Traded vs Delivery", 
         "Day", "Qty(Thousands)", 
         dataset,PlotOrientation.VERTICAL, 
         true, true, false);
         
      int width = 640;    /* Width of the image */
      int height = 480;   /* Height of the image */ 
      String fname = "/opt/tomcat/webapps/market/jsp/tmp/BarDel"+vscrip+".jpg";
      File BarChart = new File( "/opt/tomcat/webapps/market/jsp/tmp/BarDel"+vscrip+".jpg" ); 
      
      ChartUtilities.saveChartAsJPEG( BarChart , barChart , width , height );

%>
 <tr class="content style1" align="right">
	<td><%=rs1.getString("day")%></td>
	<td><%=decf.format(rs1.getFloat("close_price"))%></td>
	<td><%=decf.format(rs1.getFloat("PRICE_CHANGE_PER"))%></td>
	<td><%=decf.format(rs1.getFloat("DEL_PER"))%></td>
	<td><%=decf.format(rs1.getFloat("del_diff_per"))%></td>
	<td><%=decf.format(rs1.getFloat("del_20dma_chg_per"))%></td>
	<td><%=decf.format(rs1.getFloat("del_del20dma"))%></td>
	<td><%=decf.format(rs1.getFloat("del_del20dma_diff"))%></td>
	<td><%=decf.format(rs1.getFloat("turnover_lacs"))%><mtd>
	<td><%=decf.format(rs1.getFloat("oi_chg_per"))%></td>
	<td align ="center"><%=rs1.getString("DMA20_CROSS")%></td>

</tr>
<%  } %>
<tr>
<td valign=top colspan="11">	
	<table width="100%" border="0" cellpadding="2" cellspacing="0" id="stretch" bgcolor="#DBEBFF"> 
	<tr><td >
	<!-- <img src="chartnse.jpg" id="reloader" onload="setTimeout('document.getElementById(\'reloader\').src=\'chartnse.jpg?\'+new Date().getMilliseconds()', 10000)" /> -->
	<img src="../tmp/BarDel<%=vscrip%>.jpg">
	</td></tr>
 
</tr>			
</table>
</td></tr>
</table></td> 
	<td valign=top>
	<!-- <iframe width="1000" height="1400" style="margin-bottom:5px" src="http://nseguide.com/charts.php?name=<%=vscrip%>" ></iframe> -->
	<iframe width="1000" height="1400" style="margin-bottom:5px" src="http://chartink.com/stocks/<%=vscrip%>.html" ></iframe> 
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
}
%>
</body>
</html>


