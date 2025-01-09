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

<script>
function parameter(){
var vtchg=document.getElementById("cmbTchg").value
var vgroup=document.getElementById("cmbGroup").value
window.location.replace("groupcharts.jsp?vtchg="+vtchg+"&&vgroup="+vgroup);
}
</script>



<%!
Connection con=null;
ResultSet rs=null;
ResultSet rs1=null;
Statement stmt=null;
Statement stmt1=null;
String query="";
String query1="";

String e;
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


Integer vh=400;
Integer vw=200;
String vscrip="";
String vfdate="";

String vTchg = request.getParameter("vtchg");
if (vTchg == null){vTchg ="25";}
//out.println(vTchg);

String vgroup=request.getParameter("vgroup");
if (vgroup==null){vgroup="1";}
//out.println(vgroup);

String vcon="";
if ("0".equalsIgnoreCase(vgroup)){
	vcon= " ";
}
else {
	vcon=" and (code in ('NIFTY','BANKNIFTY') or code in (select CODE from code_group where group_id='"+vgroup+"'))" ;
	}


	query="SELECT TO_CHAR(to_date(MIN(EOD_DATE),'yyyymmdd'),'dd/mm/yyyy') F_EOD_DATE, TO_CHAR(to_date(max(EOD_DATE),'yyyymmdd'),'dd/mm/yyyy')T_EOD_DATE FROM (SELECT EOD_DATE FROM EOD_DATE ORDER BY 1 DESC) WHERE ROWNUM<="+vTchg; 
	rs=stmt.executeQuery(query);
	while(rs.next()){ vfdate=rs.getString(1);	}
	rs.close();


 /* code for line chart */
	File image = File.createTempFile("image", "tmp");
	final DefaultCategoryDataset datasetAVGPRICE = new DefaultCategoryDataset();
	final DefaultCategoryDataset datasetDQTY = new DefaultCategoryDataset();
	final DefaultCategoryDataset datasetNSEDPER = new DefaultCategoryDataset();
	final DefaultCategoryDataset datasetbseDQTY = new DefaultCategoryDataset();
	final DefaultCategoryDataset datasetOI = new DefaultCategoryDataset();




	GradientPaint gradientpaint0 = new GradientPaint(0.0f, 0.0f, Color.blue,0.0f, 0.0f, Color.blue);
	GradientPaint gradientpaint1 = new GradientPaint(0.0F, 0.0F, Color.red,0.0f, 0.0f, new Color(136, 136, 255));  
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

<table width="100%" border="0" cellpadding="0" VALIGN=TOP align="left">
<tr><td class="Blue-content"  colspan="2" align="left">
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
<td class="Blue-content"  align="left"  colspan="2">History Days:
<select id="cmbTchg" onchange="parameter()" class="content style1" size="0">
<%   if ("25".equalsIgnoreCase(vTchg)) { %> <option value="25" selected disabled >25</option> <% } else {%> <option value="25">25</option>
<% } if ("50".equalsIgnoreCase(vTchg)) { %> <option value="50" selected disabled >50</option> <% } else {%> <option value="50">50</option>
<% } if ("100".equalsIgnoreCase(vTchg)) { %> <option value="100"  selected disabled>100</option> <% } else {%> <option value="100">100</option>
<% } if ("150".equalsIgnoreCase(vTchg)) { %> <option value="150"  selected disabled>150</option> <% } else {%> <option value="150">150</option>
<% } if ("200".equalsIgnoreCase(vTchg)) { %> <option value="200"  selected disabled>200</option> <% } else {%> <option value="200">200</option>
<%} %>
</select>
</td></tr>

<tr  class="Blue-content"  align="center">
<td width="2px">C</td>
<td>PriceDelta 20DMA, Y-Rs</td>
<td>OI change% Y- %</td>
<td>NSE Del % Y- %</td>
<td>NSE Delivery(QTY) Y-Lakhs</td>
<td>BSE Delivery(QTY) Y-Lakhs</td>
</tr>
<tr>

<% 
query="select CODE from code_group where group_id='"+vgroup+"'";
rs=stmt.executeQuery(query);
while(rs.next()){ 
vscrip=rs.getString("code");
%>
<!-- <td valign=top align="center" colspan="2">
<table  border="0"   cellpadding="0" cellspacing="0" align="left" > -->
	<%
	//query1= "select * from nse_bhav where code='"+vscrip+"' and eod_date >= (select min(eod_date) from (select eod_date from (select eod_date from eod_date order by eod_date desc) where rownum<="+vTchg+")) order by eod_date desc";
	
	query1= "SELECT to_char(to_date(n.eod_date,'YYYYMMDD'),'DD/MM/YYYY') day,TO_CHAR(TO_DATE(N.EOD_DATE,'YYYYMMDD'),'DD/MM') MDAY, n.eod_date,n.code,b.bse_code,DECODE(n.delivery_per,'-',0,n.delivery_per) nse_del,n.TTL_TRD_QNTY/100000 nse_qty,n.turnover_lacs nse_turnover,";
	query1= query1+" n.close_price, n.close_price-Price20DMA Price20DMA,(n.TTL_TRD_QNTY/100000) - nseqty20DMA  nseqty20DMA,";
	query1= query1+" n.prev_close,round(((n.CLOSE_PRICE-n.PREV_CLOSE)/n.PREV_CLOSE)*100,2) PRICE_CHANGE_PER,b.bse_del,b.bse_qty,b.bse_turnover,";
	query1= query1+"coalesce(fo.OPEN_INT,0)/100000 open_int,coalesce(fo.CHG_IN_OI,0) CHG_IN_OI,COALESCE(OI_CHG_PER,0) OI_CHG_PER,";
	query1= query1+" COALESCE(BULK_BUY,0) BULK_BUY,COALESCE(BULK_SELL,0) bulk_sell,";
	query1= query1+" round(N.DELIVERY/100000,2) NSE_DELIVERY, round(BSE_DELIVERY/100000,2) BSE_DELIVERY,";
	query1= query1+" round(((fut_close_price-n.close_price)*100/n.close_price),2) coc_per,nvl(mplimit,0) mplimit,nvl(round((open_int/mplimit)*100,2),0) limit_per,";
	query1= query1+" (select delivery/100000  from nse_bhav where eod_date=(select max(eod_date) from nse_bhav b where b.code=n.code and b.eod_date<n.eod_date) and code=n.code) prev_delivery,n.delivery/100000 cur_delivery ";
	query1= query1+" FROM NSE_BHAV N,(SELECT EOD_DATE,BSE_CODE, NSE_CODE, DELIVERY BSE_DELIVERY,ROUND(turnover/100000,2)BSE_TURNOVER, TTL_TRD_QNTY bse_qty,delivery_per bse_del FROM BSE_BHAV x,SCRIP_CODE y WHERE y.bse_code=x.code) B ,VW_NSE_FO FO ";
	query1= query1+" ,(select EOD_DATE,CODE,CLOSE fut_close_price from nse_Fo where exists (select 1 from (select EOD_DATE,CODE,min(EXPIRY_DATE) expiry_date from NSE_FO where  OPTION_TYPE='XX' ";
	query1= query1+" AND EOD_DATE >= to_char(sysdate-90,'YYYYMMDD') group by EOD_DATE,CODE) a where a.code=nse_fo.code and a.eod_date=nse_fo.eod_date and a.expiry_date=nse_fo.expiry_date) ";
	query1= query1+" and  OPTION_TYPE='XX') fut_close,(select eod_date,nse_code code,limit mplimit from mpl ) mpl, ";
	query1= query1+" (select code,sum(close_price)/count(1) Price20DMA,round((sum(TTL_TRD_QNTY)/count(1))/100000,2) nseqty20DMA  from nse_bhav where ";
	query1= query1+" eod_date >= (select min(eod_date) from (select eod_date from eod_date order by 1 desc) where rownum<=20) group by code) DMA20";
	query1= query1+" WHERE N.EOD_DATE=B.EOD_DATE(+) AND N.CODe=B.NSE_CODE(+) AND N.EOD_DATE=FO.EOD_DATE(+) AND N.CODE=FO.CODE(+) AND N.series='EQ' AND n.code='"+vscrip+"' and n.eod_date >= to_char(to_date('"+vfdate+"','dd/mm/yyyy'),'yyyymmdd') ";
	query1= query1+" and n.eod_date=fut_close.eod_date(+) and n.code=fut_close.code(+) and n.code=mpl.code(+)  and n.eod_date=mpl.eod_date(+) and n.code=DMA20.code";
	query1= query1+" order by n.eod_date desc";
	//out.println(query1);
	rs1=stmt1.executeQuery(query1);
	while(rs1.next()){ 



		datasetAVGPRICE.addValue(rs1.getFloat("Price20DMA"),"PriceDelta 20DMA",rs1.getString("mday"));

		datasetOI.addValue(rs1.getFloat("OI_CHG_PER"),"OI Chg %",rs1.getString("mday"));
		datasetOI.addValue(rs1.getFloat("PRICE_CHANGE_PER"),"Price Change %",rs1.getString("mday"));

		datasetNSEDPER.addValue(rs1.getFloat("nse_del"),"OI Chg %",rs1.getString("mday"));
		datasetNSEDPER.addValue(rs1.getFloat("PRICE_CHANGE_PER"),"Price Change %",rs1.getString("mday"));

		
		datasetDQTY.addValue(rs1.getFloat("cur_delivery"),"NSE Delivery(QTY)" ,rs1.getString("mday"));
		datasetDQTY.addValue(rs1.getFloat("PRICE_CHANGE_PER"),"Price Change %" ,rs1.getString("mday"));
		
		datasetbseDQTY.addValue(rs1.getFloat("BSE_DELIVERY"),"BSE Delivery(QTY)",rs1.getString("mday"));
		datasetbseDQTY.addValue(rs1.getFloat("PRICE_CHANGE_PER"),"Price Change %",rs1.getString("mday"));
		
	



//NSE del_qty
			JFreeChart chartDQTY = ChartFactory.createBarChart("", "", "", datasetDQTY, PlotOrientation.VERTICAL,false, false, false);
				CategoryPlot plotDQTY = (CategoryPlot)chartDQTY.getPlot();
				chartDQTY.getTitle().setPaint(Color.black); 
				chartDQTY.setBackgroundPaint(ChartColor.WHITE);
				CategoryAxis xAxisDQTY = (CategoryAxis)plotDQTY.getDomainAxis();
				xAxisDQTY.setTickLabelsVisible(false);
				xAxisDQTY.setCategoryLabelPositions(CategoryLabelPositions.UP_45);
				NumberAxis rangeAxisDQTY = (NumberAxis) plotDQTY.getRangeAxis();
				//rangeAxisDQTY.setRange(vdqty_min, vdqty_max);
	 			BarRenderer rDQTY = (BarRenderer) chartDQTY.getCategoryPlot().getRenderer();  
			rDQTY.setSeriesPaint(0, gradientpaint0);
			rDQTY.setSeriesPaint(1, gradientpaint1);
			rDQTY.setDrawBarOutline(false);
			rDQTY.setShadowVisible(false); 
			ChartUtilities.saveChartAsJPEG(new File("/usr/share/apache-tomcat-7.0.32/webapps/market/jsp/reports/tmp/chartDQTY"+vscrip+".jpg"), chartDQTY, vh, vw);

//NSE del_per
			JFreeChart chartNSEDPER = ChartFactory.createBarChart("", "", "", datasetNSEDPER, PlotOrientation.VERTICAL,false, false, false);
				CategoryPlot plotNSEDPER = (CategoryPlot)chartNSEDPER.getPlot();
				chartNSEDPER.getTitle().setPaint(Color.black); 
				chartNSEDPER.setBackgroundPaint(ChartColor.WHITE);
				CategoryAxis xAxisNSEDPER = (CategoryAxis)plotNSEDPER.getDomainAxis();
				xAxisNSEDPER.setTickLabelsVisible(false);
				xAxisNSEDPER.setCategoryLabelPositions(CategoryLabelPositions.UP_45);
				NumberAxis rangeAxisNSEDPER = (NumberAxis) plotNSEDPER.getRangeAxis();
				BarRenderer rNSEDPER = (BarRenderer) chartNSEDPER.getCategoryPlot().getRenderer();  
			rNSEDPER .setSeriesPaint(0, gradientpaint0);
			rNSEDPER .setSeriesPaint(1, gradientpaint1);
			rNSEDPER .setDrawBarOutline(false);
			rNSEDPER .setShadowVisible(false); 
			ChartUtilities.saveChartAsJPEG(new File("/usr/share/apache-tomcat-7.0.32/webapps/market/jsp/reports/tmp/chartNSEDPER"+vscrip+".jpg"), chartNSEDPER, vh, vw);

//NSE  Price Delta
			JFreeChart chartAVGPRICE = ChartFactory.createBarChart("", "", "", datasetAVGPRICE, PlotOrientation.VERTICAL,false, false, false);
			CategoryPlot plotAVGPRICE = (CategoryPlot)chartAVGPRICE.getPlot();
			chartAVGPRICE.getTitle().setPaint(Color.black); 
			chartAVGPRICE.setBackgroundPaint(ChartColor.WHITE);
			CategoryAxis xAxisAVGPRICE = (CategoryAxis)plotAVGPRICE.getDomainAxis();
			xAxisAVGPRICE.setTickLabelsVisible(false);
			xAxisAVGPRICE.setCategoryLabelPositions(CategoryLabelPositions.UP_45);
			NumberAxis rangeAxisAVGPRICE = (NumberAxis) plotAVGPRICE.getRangeAxis();
				//rangeAxisAVGPRICE.setRange(vcprice, vprice);
				
 			BarRenderer rAVGPRICE = (BarRenderer) chartAVGPRICE.getCategoryPlot().getRenderer();  
			rAVGPRICE.setSeriesPaint(0, gradientpaint1); 
			rAVGPRICE.setDrawBarOutline(false);
			rAVGPRICE.setShadowVisible(false); 
			ChartUtilities.saveChartAsJPEG(new File("/usr/share/apache-tomcat-7.0.32/webapps/market/jsp/reports/tmp/chartAVGPRICE"+vscrip+".jpg"), chartAVGPRICE, vh, vw);

//BSE Quantity
			JFreeChart chartbseDQTY = ChartFactory.createBarChart("", "", "", datasetbseDQTY, PlotOrientation.VERTICAL,false, false, false);
			CategoryPlot plotbseDQTY = (CategoryPlot)chartbseDQTY.getPlot();
			chartbseDQTY.getTitle().setPaint(Color.red); 
			chartbseDQTY.setBackgroundPaint(ChartColor.WHITE);
			CategoryAxis xAxisbseDQTY = (CategoryAxis)plotbseDQTY.getDomainAxis();
			xAxisbseDQTY.setTickLabelsVisible(false);
			xAxisbseDQTY.setCategoryLabelPositions(CategoryLabelPositions.UP_45);
			NumberAxis rangeAxisbseDQTY = (NumberAxis) plotbseDQTY.getRangeAxis();
				//rangeAxisbseDQTY.setRange(0, vbqty_max);
				//rangeAxisbseDQTY.setRange(0, 100);
			BarRenderer rbseDQTY = (BarRenderer) chartbseDQTY.getCategoryPlot().getRenderer();  
			rbseDQTY.setSeriesPaint(0, gradientpaint0);
			rbseDQTY.setSeriesPaint(1, gradientpaint1);  
			rbseDQTY.setDrawBarOutline(false);
			rbseDQTY.setShadowVisible(false); 
			ChartUtilities.saveChartAsJPEG(new File("/usr/share/apache-tomcat-7.0.32/webapps/market/jsp/reports/tmp/chartbseDQTY"+vscrip+".jpg"), chartbseDQTY, vh, vw);
	

// OI Chart
JFreeChart chartOI = ChartFactory.createBarChart("", "", "", datasetOI, PlotOrientation.VERTICAL,false, false, false);
			CategoryPlot plotOI = (CategoryPlot)chartOI.getPlot();
			chartOI.getTitle().setPaint(Color.green); 
			chartOI.setBackgroundPaint(ChartColor.WHITE);
			CategoryAxis xAxisOI = (CategoryAxis)plotOI.getDomainAxis();
			xAxisOI.setTickLabelsVisible(false);
			xAxisOI.setCategoryLabelPositions(CategoryLabelPositions.UP_45);
			NumberAxis rangeAxisOI = (NumberAxis) plotOI.getRangeAxis();
				//rangeAxisOI.setRange(voic_min, voic_max);
			BarRenderer roi = (BarRenderer) chartOI.getCategoryPlot().getRenderer();  
			roi.setSeriesPaint(0, gradientpaint0);
			roi.setSeriesPaint(1, gradientpaint1); 
			roi.setDrawBarOutline(false);
			roi.setShadowVisible(false); 
			ChartUtilities.saveChartAsJPEG(new File("/usr/share/apache-tomcat-7.0.32/webapps/market/jsp/reports/tmp/chartOI"+vscrip+".jpg"), chartOI, vh, vw);



	}
//rs1.close();
%>
<tr><td class="Blue-content"  align="left"><%=vscrip%></td><td><img src="tmp/chartAVGPRICE<%=vscrip%>.jpg"></td>
<td><img src="tmp/chartOI<%=vscrip%>.jpg"></td>
<td><img src="tmp/chartNSEDPER<%=vscrip%>.jpg"></td>
<td><img src="tmp/chartDQTY<%=vscrip%>.jpg"></td>
<td><img src="tmp/chartbseDQTY<%=vscrip%>.jpg"></td>
</tr>

</td>
<%}
rs.close();%>
</tr>
</table>
</td>
</tr>

</body>
</html>


