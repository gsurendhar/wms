<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>


<%@ page import="java.io.*" %>
<%@ page  import="java.awt.*" %>


<script>
function parameter(){
var vfdate= document.getElementById("fdate").value
var vcode= document.getElementById("txtvcode").value
var vspot= document.getElementById("txtspot").value
window.location.replace("intradaydet.jsp?vcode="+vcode+"&&vfdate="+vfdate+"&&spot="+vspot);
}
</script>



<%!
Connection con=null;
ResultSet rs=null;
ResultSet rs1=null;
Statement stmt=null;
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

String vfdate=request.getParameter("vdate");
String vcode=request.getParameter("vcode");
String vspot=request.getParameter("spot");
String vdtime="" ;
String vpath = "/usr/share/apache-tomcat-7.0.32/webapps/market/jsp/reports/tmp/";

String query="";

String e;
String vOI;
String vsNAME="";
String vtype ="";

float vpvol=0;



DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());
if(vfdate == null){  vfdate=formattedDate;}

DecimalFormat decf = new DecimalFormat("####0.00");
DecimalFormat decfI = new DecimalFormat("####0");

	query="select a.* ,b.cur_traded_qty*1000 ttl_trd_qnty,b.type from ";
	query=query+" (SELECT scrip_code code ,scrip_name name,max(last_traded_date)  last_traded_date FROM intraday ";
	query=query+" WHERE date_inserted >=  to_date('"+vfdate+"','dd/mm/yyyy')-1  and scrip_code='"+vcode+"'";
	query=query+" group by scrip_code ,scrip_name) a,research_page b ";
	query=query+" where nvl(substr(name,1,instr(name,' ')-1),name) = b.code";
	query=query+" and b.eod_date=(select max(eod_date) from eod_date where eod_date < to_char(a.last_traded_date,'YYYYMMDD'))";
	//out.println(query);
	rs=stmt.executeQuery(query);

	while(rs.next()){
		vsNAME =rs.getString("name");
		vpvol = rs.getFloat("ttl_trd_qnty");
		vtype = rs.getString("type");

	}
	rs.close();
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Intraday <%=vsNAME %></title>
<script type="text/javascript" src="../../Script/tabber.js"></script>
<script language="javascript" type="text/javascript" src="../../Script/datepicker.js"></script> 
<meta http-equiv="imagetoolbar" content="no" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="Tue,01 Dec 2010 06:30:00 GMT">
<link href="../../styles/text.css" rel="stylesheet" type="text/css">
</head>
<body>
<% response.setIntHeader("Refresh", 300); %>

<%
query="SELECT X.SCRIP_CODE,x.ID,x.ttime,x.low,x.high,OPEN,Y.PRICE CLOSE,qty,p_qty, (qty-p_qty)*100/p_qty qty_chg,vol_rise_per,coc_per,oi_difference_percentage,OPEN_INTEREST FROM( ";
query= query+" SELECT SCRIP_CODE,ID,TTIME,MIN(price) LOW,MAX(price) HIGH,MAX(DRANK) MAX_DRANK,MIN(DRANK),";
query= query+" SUM(CASE WHEN DRANK=1 THEN PRICE END) OPEN FROM ";
query= query+" (SELECT a.SCRIP_CODE,scrip_name,current_price price,low,high,TO_CHAR(a.last_traded_date,'HH24:MI:SS') TIME,FTIME,TTIME,";
query= query+" T.ID,DENSE_RANK() OVER (PARTITION BY ID  ORDER BY TO_CHAR(a.last_traded_date,'HH24:MI:SS')) AS drank ";
query= query+" FROM INTRADAY a, TIME_dim T where last_traded_date >= to_date('"+vfdate+"','dd/mm/yyyy') and last_traded_date < to_date('"+vfdate+"','dd/mm/yyyy')+1 ";
query= query+" AND SCRIP_CODE='"+vcode+"' AND TO_CHAR(a.last_traded_date,'HH24:MI') >= T.ftime ";
query= query+" AND TO_CHAR(a.last_traded_date,'HH24:MI') < T.TTIME) A ";
query= query+" GROUP BY SCRIP_CODE,ID,TTIME) X, ";
query= query+" (SELECT a.SCRIP_CODE,scrip_name,current_price price,low,high,qty,p_qty,TO_CHAR(a.last_traded_date,'HH24:MI:SS') TIME,FTIME,TTIME, ";
query= query+" vol_rise_per,coc_per,oi_difference_percentage,OPEN_INTEREST,";
query= query+" T.ID,DENSE_RANK() OVER (PARTITION BY ID  ORDER BY TO_CHAR(a.last_traded_date,'HH24:MI:SS')) AS drank";
query= query+" FROM INTRADAY a, TIME_dim T where last_traded_date >= to_date('"+vfdate+"','dd/mm/yyyy') and last_traded_date < to_date('"+vfdate+"','dd/mm/yyyy')+1 ";
query= query+" AND SCRIP_CODE='"+vcode+"' AND TO_CHAR(a.last_traded_date,'HH24:MI') >= T.ftime AND TO_CHAR(a.last_traded_date,'HH24:MI') < T.TTIME) Y";
query= query+" WHERE x.SCRIP_CODE=y.SCRIP_CODE AND MAX_DRANK=DRANK AND X.ID=Y.ID ORDER BY x.ID";


rs=stmt.executeQuery(query);

%>

<%
int vrec=0;
float pqty=0;
float yAxisMinValue1=0;
float yAxisMaxValue1=0;


String strcsXML1 = "";
String strXMLDAY =  "";
   	

//
String strQTYCHG = "";
String strXMLQTYper = "";


//
String strOI ="";
String strOIp ="";
String strCOC ="";


//out.println(query);
while(rs.next()){   
	vrec=vrec+1;
	if (vrec==1){
			yAxisMinValue1=rs.getInt("low");
			yAxisMaxValue1=rs.getInt("high");
			
		}
	
	if (yAxisMinValue1 > rs.getInt("low")){ yAxisMinValue1= rs.getInt("low");}
	if (yAxisMaxValue1 < rs.getInt("high")){ yAxisMaxValue1= rs.getInt("high");}
	

	strcsXML1 += " <set open='"+rs.getFloat("open")+"'  high='"+rs.getFloat("high")+"'  low='"+rs.getFloat("low")+"'   close='"+rs.getFloat("close")+"' x='"+vrec+"' volume='"+(rs.getFloat("qty")-pqty)+"'/>";
	
	strXMLDAY  +="<category label='"+rs.getString("ttime")+"' x='"+vrec+"'/>";
	
	strQTYCHG +="<set value='"+rs.getFloat("qty_chg")+"'/>";


 	strXMLQTYper +="<set value='"+rs.getFloat("vol_rise_per")+"'/>";


	strOI +="<set value='"+rs.getFloat("oi_difference_percentage")+"'/>";	
	strOIp +="<set value='"+rs.getFloat("OPEN_INTEREST")+"'/>";


 	strCOC +="<set value='"+rs.getFloat("coc_per")+"'/>";

pqty=rs.getFloat("qty");

}

//yAxisMinValue1=yAxisMinValue1-(yAxisMinValue1*1/100);
//
String strXML = "<chart numpdivlines='5' caption='Price change' PYAxisMinValue='"+yAxisMinValue1+"' PYAxisMaxValue='"+yAxisMaxValue1+"' numberprefix='' bearbordercolor='E33C3C' bearfillcolor='E33C3C' bullfillcolor='2A6045' bullbordercolor='1F3165' pyaxisname='Price' vyaxisname='Trd Volume ' volumeheightpercent='20' showborder='0'  rotateNames='1'>";
strXML += "<categories font='Arial' fontSize='8' fontColor='000000'>";
strXML += strXMLDAY;
strXML += "</categories>";
strXML += "<dataset>";
strXML += strcsXML1;
strXML += "</dataset>";
strXML += "</chart>";

//
String strXMLTRD = "<chart caption='OI Chg per / Vol Raise per' subcaption='' PYAxisMinValue='100'  xaxisname='Time' PYaxisname='Vol Chg Per' SYAxisName='OI Change' decimals='2' numberPrefix='' numberSuffix='' sNumberSuffix='%25' setAdaptiveSYMin='1' showPlotBorder='1' palette='2'  rotateNames='1'>";
strXMLTRD += "<categories font='Arial' fontSize='8' fontColor='000000'>";
strXMLTRD += strXMLDAY;
strXMLTRD += "</categories>";
strXMLTRD += "<dataset>";
strXMLTRD += "<dataSet seriesName='Volume change Per (prevClose to Current)' color='000080' showValues='0'>";
strXMLTRD += strQTYCHG ;
//strXMLTRD += strXMLQTYper;
strXMLTRD += "</dataSet>";
strXMLTRD += "</dataset>";
strXMLTRD += "<lineSet seriesname='OI Change Per' showValues='0' lineThickness='2'>";

strXMLTRD += strOI;
strXMLTRD += "</lineSet>";
strXMLTRD  += "</chart>";




%>

<table width="100%" border="0" class="border" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
    <tr> <td>
     <table width="50%" border="1" class="border" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>



<td valign=top>
<table width="100%" border="1" cellpadding="2"  bgcolor="#DBEBFF" cellspacing="0" id="stretch" >  
<tr class="content style1"><td class="Blue-content" colspan="4"><%=vsNAME%></td>
<td colspan="3">
<input id="fdate"  class="content style1" type="text" name="fdate" size="10" maxlength="12" value=<%=vfdate%>>
	<a href="javascript:NewCal('fdate','ddmmyyyy',false)"><img src="../../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a>
<input class="content style1"  type="submit" value="Go" onClick="parameter()">
<input type="hidden" id="txtspot"  name="txtspot" size="10" maxlength="12" value=<%=vspot%> />
<input type="hidden" id="txtvcode"  name="txtvcode" size="10" maxlength="12" value=<%=vcode%> />


</td>
</tr>

<tr class="Blue-content" align="center">
<td>Time</td><td>Fut<br>Price</td><td>Spot Price</td><td>Price<br>Chng %</td><td>COC %</td><td>OI %</td><td>Vol<br>Rise %</td>

</tr>

<%
query="select distinct to_char(last_traded_date,'hh24:mi:ss') time,";
query= query+" (case when substr(scrip_name,1,instr(scrip_name,' ')-1) is null then scrip_name else substr(scrip_name,1,instr(scrip_name,' ')-1) end) sname,";
query= query+" exchange,scrip_code,scrip_name,current_price,underlying,per_change,coc_per,oi_difference_percentage,vol_rise_per,qty,p_qty,p_high,p_low,p_close,turnover,";
query= query+" oi_difference,open_interest,close,low,open,high,p_open,last_traded_time";
query= query+" from intraday i where scrip_code='"+vcode+"' and last_traded_date >= to_date('"+vfdate+"','dd/mm/yyyy') and last_traded_date <to_date('"+vfdate+"','dd/mm/yyyy')+1 ";
query= query+" order by 1";

rs=stmt.executeQuery(query);

while(rs.next()){ 

%>
<tr class="content" align="right" bgcolor="#FFFFFF">
<td><%=rs.getString("time")%></td>
<td><%=decf.format(rs.getFloat("CURRENT_PRICE"))%></td>
<td><%=decf.format(rs.getFloat("UNDERLYING"))%></td>
<td><%=decf.format(rs.getFloat("PER_CHANGE"))%></td>
<td><%=decf.format(rs.getFloat("COC_PER"))%></td>
<td><%=decf.format(rs.getFloat("OI_DIFFERENCE_PERCENTAGE"))%></td>
<td><%=decf.format((rs.getFloat("qty")-rs.getFloat("p_qty"))*100/rs.getFloat("p_qty"))%></td>

</tr>
<% vOI=rs.getString("OI_DIFFERENCE_PERCENTAGE"); 
vsNAME=rs.getString("SNAME"); 
} 

rs.close();

%>
</table>
</td>

<td valign=top>
	<table width="100%" border="0" cellpadding="2" cellspacing="0" id="stretch" bgcolor="#DBEBFF">
			<tr>
				 <td colspan=2>
				      <OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase=http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="500" height="600" id="Column3D" >
				         <param name="movie" value="../../../FusionCharts/Charts/CandleStick.swf" />
				         <param name="FlashVars" value="&dataURL=Data.xml&chartWidth=500&chartHeight=600">
				         <param name="quality" value="high" />
				         <embed src="../../../FusionCharts/Charts/CandleStick.swf" flashVars="&dataXML=<%=strXML%>&chartWidth=720&chartHeight=400" quality="high" width="850" height="425" name="Price" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
				      </object>
				</td>
				
			</tr>
			<tr>	
				<td colspan=2>
			 		<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase=http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="500" height="600" id="Column3D" >
				         <param name="movie" value="../../../FusionCharts/Charts/FCF_Candlestick.swf" />
				         <param name="FlashVars" value="&dataURL=Data.xml&chartWidth=500&chartHeight=600">
				         <param name="quality" value="high" />
				      	 <embed src="../../../FusionCharts/Charts/MSStackedColumn2DLineDY.swf" flashVars="&dataXML=<%=strXMLTRD%>&chartWidth=800&chartHeight=250" quality="high" width="850" height="275" name="Column3D" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" /> 
            				
					</object>
				</td>
			</tr>



	</table> 
</td>

<td valign=top>
<jsp:include page="sharedet.jsp">
	 <jsp:param name="scrip" value="<%=vsNAME%>" />
	 <jsp:param name="type" value="<%=vtype%>" />
</jsp:include>


</td>

</tr>



</table>
</body>
</html>


