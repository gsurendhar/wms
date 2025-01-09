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

<script>
function parameter(){
var vscrip=document.getElementById("cmbScrip").value;
var vTchg =document.getElementById("cmbTchg").value;
window.location.replace("options.jsp?scrip="+vscrip+"&&vTchg="+vTchg);
}

function parameter_scrip(){
var vscrip=document.getElementById("cmbScrip").value
window.location.replace("options.jsp?scrip="+vscrip);
}

</script>


<!-- added for sorting table --->
<script type="text/javascript" src="../../Script/gs_sortable.js"></script>
<script type="text/javascript">
var TSort_Data = new Array ('my_table', '-', '-', 'f','f','f','f','f','f','f','f','f','f','f','f','f','f','f','f');
var TSort_Classes = new Array ('row1', 'row2');
var TSort_Initial = 7;
//tsRegister();
</script>

<%!
Connection con=null;
ResultSet rs=null;
ResultSet rs1=null;
Statement stmt=null;
String query="";
String query1="";
String tputs="";
String tcalls="";
String rdate="";
Integer vh=230;
Integer vw=800;
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

DecimalFormat decf = new DecimalFormat("####0.00");
DecimalFormat decfI = new DecimalFormat("####0");


DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reports</title>
<script type="text/javascript" src="../../Script/tabber.js"></script>
<script language="javascript" type="text/javascript" src="../../Script/datepicker.js"></script>
<link href="../../styles/text.css" rel="stylesheet" type="text/css">
</head>
<body>
<table width="100%" border="0" class="border" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
<tr><td valign=top>
<table width="100%" border="0" class="border" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
<tr><td class="Blue-content"  align="left" colspan="2">
Scrip:
<select id="cmbScrip" onchange="parameter_scrip()" class="content style1" size="0" style="width: 200px;">
<option value="0">--Select--</option>
<%
rs1=stmt.executeQuery("select distinct code from nse_fo where eod_date=(select max(eod_date) from eod_date) order by 1");
while(rs1.next()){
%>
<option value="<%=rs1.getString("code")%>" ><%=rs1.getString("code")%></option>
<% if(rs1.getString("code").equals(vscrip)){%>
<option value="<%=vscrip%>" selected ><%=rs1.getString("code")%></option>
<%
}
}
%>
</select>
</td>
<%		 /* code for line chart */
	File image = File.createTempFile("image", "tmp");
	final DefaultCategoryDataset datasetCont = new DefaultCategoryDataset();
	final DefaultCategoryDataset datasetContStr = new DefaultCategoryDataset();

	Integer rcount=0;
	query="select to_char(to_date(eod_date,'yyyymmdd'),'dd/mm') day,eod_date,sum(decode(option_type,'CE',contracts)) ce_contracts,sum(decode(option_type,'PE',contracts)) pe_contracts ";
	query=query+"	from nse_fo where eod_date>=(select to_char(sysdate-"+vTchg+",'yyyymmdd') from dual)  and code='"+vscrip+"' and instrument LIKE 'OPT%'";
	query=query+"	group by to_char(to_date(eod_date,'yyyymmdd'),'dd/mm'),eod_date order by eod_date desc";
	rs1=stmt.executeQuery(query); 
	while(rs1.next()){
		datasetCont.addValue(rs1.getFloat("ce_contracts"),"Call Contracts",rs1.getString("day"));
		datasetCont.addValue(rs1.getFloat("pe_contracts"),"Puts Contracts",rs1.getString("day"));
		if (rcount==0){	tcalls=rs1.getString("ce_contracts");
					tputs=rs1.getString("pe_contracts");
					rdate=rs1.getString("day");
			}
		rcount=rcount+1;
	}
%>
<td class="Blue-content" align="right">Total Calls Contracts for <%=rdate%>:<td><td align="left" class="content"><%=tcalls%></td>
<td class="Blue-content" align="right">Total Puts Contracts for <%=rdate%>:<td><td align="left" class="content"><%=tputs%></td>

<td class="Blue-content" align="right">
History Days:
<select id="cmbTchg" onchange="parameter()" class="content style1" size="0">
<%   if ("25".equalsIgnoreCase(vTchg)) { %> <option value="25" selected disabled >25</option> <% } else {%> <option value="25">25</option>
<% } if ("50".equalsIgnoreCase(vTchg)) { %> <option value="50" selected disabled >50</option> <% } else {%> <option value="50">50</option>
<% } if ("100".equalsIgnoreCase(vTchg)) { %> <option value="100"  selected disabled>100</option> <% } else {%> <option value="100">100</option>
<% } if ("150".equalsIgnoreCase(vTchg)) { %> <option value="150"  selected disabled>150</option> <% } else {%> <option value="150">150</option>
<% } if ("200".equalsIgnoreCase(vTchg)) { %> <option value="200"  selected disabled>200</option> <% } else {%> <option value="200">200</option>
<%} %>
</select>
</td>
</tr>
</table>


<table width="100%" border="1" id="my_table" cellpadding="2" cellspacing="0" id="stretch" >
   <thead>
       <tr class="Blue-content">
		<th rowspan=2>Expiry<br>Date</th>
		<th colspan=7 class="contentHeadings">Calls</th>
		<th rowspan=2>Strike</th>
		<th rowspan=2>OI<br>Call/Put<br>%</th>
		<th colspan=7 class="contentHeadings">Puts</th>
	</tr>
	<tr class="Blue-content" align="center">
       	<th>Price</th><th>Contracts</th>
              <th>Cont.<br>chg %</th><th>Value<br>(Lacs)</th>
             	<th>OI</th><th>OI Chg.</th><th>OI<br>Chg %</th>
		<th>Price</th><th>Contracts</th>
		<th>Cont.<br>chg %</th><th>Value<br>(Lacs)</th>
              <th>OI</td><th>OI Chg.</th><th>OI<br>Chg %</th>
      	</tr>         
   </thead>
<%
	query="SELECT ce.code,to_char(ce.expiry_date,'dd-Mon-yyyy') expiry_date, ";
	query= query+" ce.option_type ce_type,ce.settle_pr ce_price,ce.contracts ce_contracts,";
	query= query+" (select contracts from nse_fo where instrument=ce.instrument and option_type=ce.option_type ";
	query= query+" and code=ce.code and eod_date=(select max(eod_date) from eod_date where eod_date !=ce.eod_date) ";
	query= query+" and strike_pr=ce.strike_pr and expiry_date=ce.expiry_date) ce_p_contracts,";
	query= query+" ce.value_lacs ce_value,ce.open_int ce_OI,ce.chg_in_oi ce_oi_chg,";
	query= query+" pe.strike_pr,pe.eod_date,";
	query= query+" pe.option_type pe_type,pe.settle_pr pe_price,pe.contracts pe_contracts,";
	query= query+" (select contracts from nse_fo where instrument=pe.instrument and option_type=pe.option_type ";
	query= query+" and code=pe.code and eod_date=(select max(eod_date) from eod_date where eod_date !=pe.eod_date) ";
	query= query+" and strike_pr=pe.strike_pr and expiry_date=pe.expiry_date) pe_p_contracts,";
	query= query+" pe.value_lacs pe_value,pe.open_int pe_oi,pe.chg_in_oi pe_oi_chg";
	query= query+" FROM nse_fo CE,nse_fo PE";
	query= query+" WHERE ce.eod_date=pe.eod_date and ce.code=pe.code  and ce.strike_pr=pe.strike_pr  and ce.instrument=pe.instrument";
	query= query+" and ce.expiry_date= pe.expiry_date and ce.option_type='CE' and Pe.option_type='PE'";
	query= query+" and ce.eod_date=(SELECT MAX(eod_date) FROM eod_date)   AND ce.instrument LIKE 'OPT%' ";
	query= query+" AND ce.expiry_date=(SELECT MIN(expiry_date) FROM nse_fo WHERE eod_date=(SELECT MAX(eod_date) FROM eod_date)) ";
	query= query+" AND (ce.contracts>0  or pe.contracts >0) AND ce.code ='"+vscrip+"'"; 
	query= query+" ORDER BY ce.strike_pr desc ";
	//out.println(query);
	rs=stmt.executeQuery(query);
			while(rs.next()){ 
		datasetContStr.addValue(rs.getFloat("ce_contracts"),"Call Contracts",rs.getString("strike_pr"));
		datasetContStr.addValue(rs.getFloat("pe_contracts"),"Puts Contracts",rs.getString("strike_pr"));

%>
                <tr class="content" align="right">
                     <!-- <td align="left">
			<a href="optiondet.jsp?scrip=<%=rs.getString("code")%>&&edate=<%=rs.getString("expiry_date")%>&&strike=<%=rs.getString("strike_pr")%>&&vTchg=<%=vTchg%>" target="_blank" style="font-size:8pt; color: #990000 ;font-weight: normal" > 
			<%=rs.getString("CODE")%></a></td>
			-->
			<td><a href="optiondet.jsp?scrip=<%=rs.getString("code")%>&&edate=<%=rs.getString("expiry_date")%>&&strike=<%=rs.getString("strike_pr")%>&&vTchg=<%=vTchg%>" target="_blank" style="font-size:8pt; color: #990000 ;font-weight: normal">
			<%=rs.getString("expiry_date")%></a></td>
			<td><%=decf.format(rs.getFloat("ce_price"))%></td>
		       <td><%=rs.getString("ce_contracts")%></td>
			<td><%=decf.format((rs.getFloat("ce_contracts")-rs.getFloat("ce_p_contracts"))*100/rs.getFloat("ce_p_contracts"))%></td>

			<td><%=rs.getString("ce_value")%></td> 
                     <td><%=rs.getString("ce_oi")%></td><td><%=rs.getString("ce_oi_chg")%></td>
			<td><%=decf.format(rs.getFloat("ce_oi_chg")*100/(rs.getFloat("ce_oi")-rs.getFloat("ce_oi_chg")))%></td>

                     <td><a href="optiondet.jsp?scrip=<%=rs.getString("code")%>&&edate=<%=rs.getString("expiry_date")%>&&strike=<%=rs.getString("strike_pr")%>&&vTchg=<%=vTchg%>" target="_blank" style="font-size: 8pt; color: #990000 ;font-weight: normal" ><b><%=rs.getString("strike_pr")%><b></a></td>
			<td><a href="optiondet.jsp?scrip=<%=rs.getString("code")%>&&edate=<%=rs.getString("expiry_date")%>&&strike=<%=rs.getString("strike_pr")%>&&vTchg=<%=vTchg%>" target="_blank" style="font-size: 8pt; color: #990000 ;font-weight: normal" >
				<b><%=decfI.format(rs.getFloat("ce_oi")*100/rs.getFloat("pe_oi"))%></b></a></td>
			<td><%=decf.format(rs.getFloat("pe_price"))%></td>
		       <td><%=rs.getString("pe_contracts")%></td>
			<td><%=decf.format((rs.getFloat("pe_contracts")-rs.getFloat("pe_p_contracts"))*100/rs.getFloat("pe_p_contracts"))%></td>
			<td><%=rs.getString("pe_value")%></td> 
                     <td><%=rs.getString("pe_oi")%></td><td><%=rs.getString("pe_oi_chg")%></td>
			<td><%=decf.format(rs.getFloat("pe_oi_chg")*100/(rs.getFloat("pe_oi")-rs.getFloat("pe_oi_chg")))%></td>

			<!-- <td><%=rs.getString("eod_date")%></td> -->
              </tr>
	<%}%>
 </table>
</td></tr>

<%	GradientPaint gradientpaint0 = new GradientPaint(0.0f, 0.0f, Color.blue,0.0f, 0.0f, Color.blue);
	GradientPaint gradientpaint1 = new GradientPaint(0.0F, 0.0F, Color.red,0.0f, 0.0f, new Color(136, 136, 255)); 
		JFreeChart chartCont = ChartFactory.createBarChart("", "<--- Date", "Contracts", datasetCont, PlotOrientation.VERTICAL,true, false, false);
		CategoryPlot plotCont = (CategoryPlot)chartCont.getPlot();
				chartCont.getTitle().setPaint(Color.black); 
				chartCont.setBackgroundPaint(ChartColor.WHITE);
				CategoryAxis xAxisCont = (CategoryAxis)plotCont.getDomainAxis();
				xAxisCont.setTickLabelsVisible(true);
				xAxisCont.setCategoryLabelPositions(CategoryLabelPositions.UP_45);
				NumberAxis rangeAxisCont = (NumberAxis) plotCont.getRangeAxis();
				//rangeAxisCont.setRange(vcoc_min, vcoc_max);
		
				
 			BarRenderer rCont = (BarRenderer) chartCont.getCategoryPlot().getRenderer();  
			rCont.setSeriesPaint(0, gradientpaint0);  
			rCont.setSeriesPaint(1,gradientpaint1 );
			//rcoc.setBarPainter(new StandardBarPainter());
			rCont.setDrawBarOutline(false);
			rCont.setShadowVisible(false);
			ChartUtilities.saveChartAsJPEG(new File("/usr/share/apache-tomcat-7.0.32/webapps/market/jsp/reports/tmp/chartCont"+vscrip+".jpg"), chartCont, vw, vh);
	

		JFreeChart chartContStr = ChartFactory.createBarChart("", "Strike Price", "Contracts", datasetContStr, PlotOrientation.VERTICAL,true, false, false);
		CategoryPlot plotContStr = (CategoryPlot)chartContStr.getPlot();
				chartContStr.getTitle().setPaint(Color.black); 
				chartContStr.setBackgroundPaint(ChartColor.WHITE);
				CategoryAxis xAxisContStr = (CategoryAxis)plotContStr.getDomainAxis();
				xAxisContStr.setTickLabelsVisible(true);
				xAxisContStr.setCategoryLabelPositions(CategoryLabelPositions.UP_45);
				NumberAxis rangeAxisContStr = (NumberAxis) plotContStr.getRangeAxis();
				//rangeAxisCont.setRange(vcoc_min, vcoc_max);
		
				
 			BarRenderer rContStr = (BarRenderer) chartContStr.getCategoryPlot().getRenderer();  
			rContStr.setSeriesPaint(0, gradientpaint0);  
			rContStr.setSeriesPaint(1,gradientpaint1 );
			//rContStr.setBarPainter(new StandardBarPainter());
			rContStr.setDrawBarOutline(false);
			rContStr.setShadowVisible(false);
			ChartUtilities.saveChartAsJPEG(new File("/usr/share/apache-tomcat-7.0.32/webapps/market/jsp/reports/tmp/chartContStr"+vscrip+".jpg"), chartContStr, vw, vh);
%>
<tr><td>
<img src="tmp/chartContStr<%=vscrip%>.jpg">
<img src="tmp/chartCont<%=vscrip%>.jpg">
</td>

</tr>


</body>
</html>
