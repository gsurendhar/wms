<%@ page import ="oracle.jdbc.driver.*"%>
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

<script type="text/javascript" src="../../Script/gs_sortable.js"></script>
<script type="text/javascript">
var TSort_Data = new Array ('my_table', 'f');
var TSort_Classes = new Array ('row1', 'row2');
var TSort_Initial = 0;
//tsRegister();
</script>

<%!
Connection con=null;
ResultSet rs=null;
ResultSet rs1=null;
Statement stmt=null;
String query="";
String query1="";
Integer vh=230;
Integer vw=600;
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

String vscrip=request.getParameter("scrip");
if (vscrip==null){vscrip="BANKNIFTY";}

String vTchg = request.getParameter("vTchg");
if (vTchg == null){vTchg ="25";}
String vedate = request.getParameter("edate");
String vstrike = request.getParameter("strike");
float vceprice=0;
float vpeprice=0;
float vcecon=0;
float vpecon=0;

float vce_oic=0;
float vpe_oic=0;
float vce_oi=0;
float vpe_oi=0;

DecimalFormat decf = new DecimalFormat("####0.00");
DecimalFormat decfI = new DecimalFormat("####0");

	/* code for line chart */
	File image = File.createTempFile("image", "tmp");
	GradientPaint gradientpaint0 = new GradientPaint(0.0f, 0.0f, Color.blue,0.0f, 0.0f, Color.blue);
	GradientPaint gradientpaint1 = new GradientPaint(0.0F, 0.0F, Color.red,0.0f, 0.0f, new Color(136, 136, 255)); 
	
	final DefaultCategoryDataset datasetCont = new DefaultCategoryDataset();
	final DefaultCategoryDataset datasetPchg = new DefaultCategoryDataset();
	final DefaultCategoryDataset datasetOIchg = new DefaultCategoryDataset();


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Option <%=vscrip%> <%=vstrike%></title>
<link href="../../styles/text.css" rel="stylesheet" type="text/css">
<!-- added for sorting table --->
<script type="text/javascript" src="../../Script/gs_sortable.js"></script>
</head>
<body>
<table width="100%" border="1" class="border" cellpadding="1">
<tr><td>
<table width="100%" border="0" cellpadding="2" cellspacing="0">
<tr class="Headings"><td align="right">Code:</td><td class="contentHeadings"><%=vscrip%></td>
<td align="right">Expiry Date:</td> <td class="contentHeadings"><%=vedate%></td>
<td align="right">Strike Price:</td><td <td class="contentHeadings"><%=vstrike%></td></tr>
</table>
</td><td></td>
</tr>
<tr><td valign="top">
<table width="100%" border="1" cellpadding="2" cellspacing="0" id="my_table"  bgcolor="#DBEBFF" >
        <thead>
              <tr class="Blue-content">
		<th rowspan=2 width="70px">eDate</th>
		<th rowspan=2>Day</th>
		<th colspan=9 class="contentHeadings">Calls</th>
		<th rowspan=2>Strike</th>
		<th rowspan=2>OI<br>Call/Put<br>%</th>
		<th rowspan=2>Spot<br>Price</th>
		<th colspan=8 class="contentHeadings">Puts</th></tr>
		<tr class="Blue-content" align="center">
              <th>Price</th><th>Price <br>chg(%)</th>	
              <th>Cont.</th><th>Cont.<br>chg %</th>
              <th>Value<br>(Lacs)</th>
              <th>OI</th> <th>OI Chg.</th><th>OI<br>Chg %</th>
		<th>Cont.<br>Call<br>GAP%</th>
              <th>Price</th><th>Price <br>chg(%)</th>	
		<th>Cont.</th>  <th>Cont.<br>chg %</th>
              <th>Value<br>(Lacs)</th>
              <th>OI</td>
		<th>OI Chg.</th>
		<th>OI<br>Chg %</th>
		</tr>         
  </thead>
<%

	query="select a.*,spot.close_price spot_price from(";
	query= query+" select * from (SELECT ce.code,to_char(ce.expiry_date,'dd-Mon-yyyy') expiry_date,ce.instrument,";
	query= query+" ce.eod_date,to_char(to_date(ce.eod_date,'yyyymmdd'),'dd/mm/yy') run_date,ce.strike_pr,";
	query= query+" ce.option_type ce_type,ce.settle_pr ce_price,ce.contracts ce_contracts,ce.value_lacs ce_value,ce.open_int ce_OI,ce.chg_in_oi ce_oi_chg,";
	query= query+" pe.option_type pe_type,pe.settle_pr pe_price,pe.contracts pe_contracts,pe.value_lacs pe_value,pe.open_int pe_oi,pe.chg_in_oi pe_oi_chg";
	query= query+" FROM nse_fo CE,nse_fo PE";
	query= query+" WHERE ce.eod_date=pe.eod_date and ce.code=pe.code  and ce.strike_pr=pe.strike_pr  and ce.instrument=pe.instrument";
	query= query+" and ce.expiry_date= pe.expiry_date and ce.option_type='CE' and Pe.option_type='PE'";
	query= query+" AND ce.instrument LIKE 'OPT%' and ce.expiry_date=to_date('"+vedate+"','dd/Mon/yy') and ce.code='"+vscrip+"'"; 
	query= query+" and ce.strike_pr='"+vstrike+"'";
	query= query+" ORDER BY ce.eod_date desc)  where rownum <= "+vTchg+" order by eod_date) a,(select code,eod_date,close_price from nse_Bhav where SERIES='EQ') spot ";
	query= query+" where a.code=spot.code(+) and a.eod_date=spot.eod_date(+) order by a.eod_date";

	//out.println(query);
	rs=stmt.executeQuery(query);
	while(rs.next()){ 
	datasetCont.addValue(rs.getFloat("ce_contracts"),"Call Contracts",rs.getString("run_date"));
	datasetCont.addValue(rs.getFloat("pe_contracts"),"Puts Contracts",rs.getString("run_date"));
	vce_oic= rs.getFloat("ce_oi_chg");
	vce_oi= rs.getFloat("ce_oi");
	vpe_oic= rs.getFloat("pe_oi_chg");
	vpe_oi= rs.getFloat("pe_oi");



	if ( (vce_oi-vce_oic) != 0){datasetOIchg.addValue(vce_oic*100/(vce_oi-vce_oic),"Call OI Chg%",rs.getString("run_date"));} 
			else 	   {datasetOIchg.addValue(0,"Call OI Chg%",rs.getString("run_date"));}

	if ( (vpe_oi-vpe_oic) != 0){datasetOIchg.addValue(vpe_oic*100/(vpe_oi-vpe_oic),"Puts OI Chg%",rs.getString("run_date"));} 
			else 	{datasetOIchg.addValue(0,"Puts OI Chg%",rs.getString("run_date"));}




%>
               <tr class="content" align="right">
			<td><%=rs.getInt("eod_date")%></td>
			<td><%=rs.getString("run_date")%></td>
                    	<td><%=decf.format(rs.getFloat("ce_price"))%></td>
		<% if (vceprice==0){ %>
			<td>0</td>
		<% datasetPchg.addValue(0,"Call Price Chg%",rs.getString("run_date"));} 
			else {datasetPchg.addValue((rs.getFloat("ce_price")-vceprice)*100/vceprice,"Call Price Chg%",rs.getString("run_date"));%>
			<td><%=decf.format((rs.getFloat("ce_price")-vceprice)*100/vceprice)%></td>
		<%} %>
		       <td><%=rs.getString("ce_contracts")%></td>
			<td><%=decf.format((rs.getFloat("ce_contracts")-vcecon)*100/vcecon)%></td>
			<td><%=rs.getString("ce_value")%></td> 
                     <td><%=rs.getString("ce_oi")%></td><td><%=rs.getString("ce_oi_chg")%></td>
			<td><%=decf.format( vpe_oic*100/(vpe_oi-vpe_oic))%></td>
			<td><%=decfI.format(rs.getFloat("ce_contracts")*100/(rs.getFloat("ce_contracts")+rs.getFloat("pe_contracts"))) %></td>
                     <td><b><%=rs.getString("strike_pr")%><b></td>
			<td><b><%=decfI.format(rs.getFloat("ce_oi")*100/rs.getFloat("pe_oi"))%></b></td>
                     <td><b><%=decf.format(rs.getFloat("spot_price"))%><b></td>

			<td><%=decf.format(rs.getFloat("pe_price"))%></td>
		<% if (vpeprice==0){ %>
			<td>-</td>
			<% datasetPchg.addValue(0,"Puts Price Chg%",rs.getString("run_date"));
			} else { 
			datasetPchg.addValue((rs.getFloat("pe_price")-vpeprice)*100/vpeprice,"Puts Price Chg%",rs.getString("run_date"));
		%>
			<td><%=decf.format((rs.getFloat("pe_price")-vpeprice)*100/vpeprice)%></td>
		<%} %>

		       <td><%=rs.getString("pe_contracts")%></td>
			<td><%=decf.format((rs.getFloat("pe_contracts")-vpecon)*100/vpecon)%></td>

			<td><%=rs.getString("pe_value")%></td> 
                     <td><%=rs.getString("pe_oi")%></td><td><%=rs.getString("pe_oi_chg")%></td>
			<td><%=decf.format(vpe_oic*100/(vpe_oi-vpe_oic))%></td>

		</tr>
	<%
	vceprice=rs.getFloat("ce_price");
	vpeprice=rs.getFloat("pe_price");
	vcecon=rs.getFloat("ce_contracts");
	vpecon=rs.getFloat("pe_contracts");
	}%>
 </table>
</td>

<%	

// Contracts	
		JFreeChart chartCont = ChartFactory.createBarChart("", "Date -->", "Count", datasetCont, PlotOrientation.VERTICAL,true, false, false);
		CategoryPlot plotCont = (CategoryPlot)chartCont.getPlot();
		chartCont.getTitle().setPaint(Color.black); 
		chartCont.setBackgroundPaint(ChartColor.WHITE);
		CategoryAxis xAxisCont = (CategoryAxis)plotCont.getDomainAxis();
		xAxisCont.setTickLabelsVisible(false);
		xAxisCont.setCategoryLabelPositions(CategoryLabelPositions.UP_45);
		NumberAxis rangeAxisCont = (NumberAxis) plotCont.getRangeAxis();
				//rangeAxisCont.setRange(vcoc_min, vcoc_max);
		BarRenderer rCont = (BarRenderer) chartCont.getCategoryPlot().getRenderer();  
		rCont.setSeriesPaint(0, gradientpaint0);  
		rCont.setSeriesPaint(1, gradientpaint1);
		//rcoc.setBarPainter(new StandardBarPainter());
		rCont.setDrawBarOutline(false);
		rCont.setShadowVisible(false);
		ChartUtilities.saveChartAsJPEG(new File("/usr/share/apache-tomcat-7.0.32/webapps/market/jsp/reports/tmp/chartContDet"+vscrip+".jpg"), chartCont, vw, vh);
// Price Change

		JFreeChart chartPchg = ChartFactory.createBarChart("", "Date -->", "%", datasetPchg, PlotOrientation.VERTICAL,true, false, false);
		CategoryPlot plotPchg = (CategoryPlot)chartPchg.getPlot();
		chartPchg.getTitle().setPaint(Color.black); 
		chartPchg.setBackgroundPaint(ChartColor.WHITE);
		CategoryAxis xAxisPchg = (CategoryAxis)plotPchg.getDomainAxis();
		xAxisPchg.setTickLabelsVisible(false);
		xAxisPchg.setCategoryLabelPositions(CategoryLabelPositions.UP_45);
		NumberAxis rangeAxisPchg = (NumberAxis) plotPchg.getRangeAxis();
				//rangeAxisPchg.setRange(vcoc_min, vcoc_max);
		BarRenderer rPchg = (BarRenderer) chartPchg.getCategoryPlot().getRenderer();  
		rPchg.setSeriesPaint(0, gradientpaint0);  
		rPchg.setSeriesPaint(1, gradientpaint1 );
		//rPchg.setBarPainter(new StandardBarPainter());
		rPchg.setDrawBarOutline(false);
		rPchg.setShadowVisible(false);
		ChartUtilities.saveChartAsJPEG(new File("/usr/share/apache-tomcat-7.0.32/webapps/market/jsp/reports/tmp/chartPchgDet"+vscrip+".jpg"), chartPchg, vw, vh);
// OI Change %
		JFreeChart chartOIchg = ChartFactory.createBarChart("", "Date -->", "%", datasetOIchg, PlotOrientation.VERTICAL,true, false, false);
		CategoryPlot plotOIchg = (CategoryPlot)chartOIchg.getPlot();
		chartOIchg.getTitle().setPaint(Color.black); 
		chartOIchg.setBackgroundPaint(ChartColor.WHITE);
		CategoryAxis xAxisOIchg = (CategoryAxis)plotOIchg.getDomainAxis();
		xAxisOIchg.setTickLabelsVisible(false);
		xAxisOIchg.setCategoryLabelPositions(CategoryLabelPositions.UP_45);
		NumberAxis rangeAxisOIchg = (NumberAxis) plotOIchg.getRangeAxis();
		BarRenderer rOIchg = (BarRenderer) chartOIchg.getCategoryPlot().getRenderer();  
		rOIchg.setSeriesPaint(0, gradientpaint0);  
		rOIchg.setSeriesPaint(1, gradientpaint1);
		//rOIchg.setBarPainter(new StandardBarPainter());
		rOIchg.setDrawBarOutline(false);
		rOIchg.setShadowVisible(false);
		ChartUtilities.saveChartAsJPEG(new File("/usr/share/apache-tomcat-7.0.32/webapps/market/jsp/reports/tmp/chartOIchgDet"+vscrip+".jpg"), chartOIchg, vw, vh);
%>
<td valign="top">
<table width="100%" VALIGN=TOP>
<tr><td valign="top"><img src="tmp/chartContDet<%=vscrip%>.jpg"></td></tr>
<tr><td valign="top"><img src="tmp/chartPchgDet<%=vscrip%>.jpg"></td></tr>
<tr><td valign="top"><img src="tmp/chartOIchgDet<%=vscrip%>.jpg"></td></tr>

</table>
</td>
</tr>
</table>
</body>
</html>
