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


<%@ page  import ="org.jfree.data.time.TimeSeries" %>
<%@ page  import ="org.jfree.data.time.Month" %>



<script>
function parameter(){
var vfdate= document.getElementById("fdate").value
//var vtdate= document.getElementById("tdate").value
//var vscrip= document.getElementById("txtScrip").value
//var vexchange= document.getElementById("txtExchange").value
window.location.replace("FIIinv.jsp?vfdate="+vfdate);
}
</script>



<%!
Connection con=null;
ResultSet rs=null;
ResultSet rs1=null;
Statement stmt=null;
String query="";
String query1="";
String e;  
%>

<%
try
{
	//out.println(session.getAttribute("connection"));
	con=(Connection)session.getAttribute("connection");
	stmt =  con.createStatement();

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

Integer rcount=1;

DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());


if(vfdate == null){ 
// vfdate=formattedDate;

		rs=stmt.executeQuery("SELECT to_char(to_date(to_char(sysdate-180,'YYYYMM'),'YYYYMM'),'dd/mm/yyyy') edate from dual"); 

		while(rs.next()){
		vfdate=rs.getString(1);
		}
 vtdate=formattedDate;
}

//println(vfdate);

query1="SELECT * from vw_fii_inv ";
query1=query1+" where day between to_char(to_date('"+vfdate+"','dd/mm/yyyy')-16,'yyyymmdd') AND to_char(sysdate,'yyyymmdd') ";
query1=query1+" ORDER BY 1 ";


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


<table width="100%" border="1" class="border" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>

<tr class="Heading"><td align ="center" class="Blue-content" colspan=3>FII Investment every fortnight Starting on
<input id="fdate"  class="content style1" type="text" name="fdate" size="10" maxlength="12" value=<%=vfdate%>>
<a href="javascript:NewCal('fdate','ddmmyyyy',false)"><img src="../../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a>
</td> 
<td><input class="content style1" type="submit" value="Go" onClick="parameter()"></td>
</tr>

</table>

<table width="100%" border="1" cellpadding="2"  bgcolor="#DBEBFF" cellspacing="0" id="stretch" > 

<!-- 
<tr class="Blue-content" align="center" valign="top">
<td>From</td>
<td>To </td>
<td>All<br>Sectors</td>
<td>Auto</td>
<td>Banks</td><td>Other Financial Services</td> <td>Total Financial Services</td>
<td>Capital Goods</td><td>Chemicals & Petrochemicals</td><td>Coal</td><td>Commercial Services & Supplies</td>
<td>Construction Materials</td><td>Consumer Durables</td><td>Diversified</td><td>Diversified Consumer Services</td>
<td>Food, Beverages & Tobacco</td><td>Forest Materials</td><td>General Industrials</td><td>Hardware Technology & Equipment</td>
<td>Healthcare Equipment & Supplies</td><td>Healthcare Services</td><td>Hotels, Restaurants & Tourism</td><td>Household & Personal Products</td>
<td>Media</td><td>Metals & Mining</td><td>Oil & Gas</td><td>Pharma & Biotec</td><td>Realty</td><td>Retailing</td><td>Software & Services</td>
<td>Telecom Services</td><td>Telecom Equipment</td><td>Textiles, Apparels & Accessories</td>
<td>Airlines</td><td>Logg</td><td>Marine<br>Port<br>&<br>Serv</td><td>Roads & Highways</td><td>Shipping</td><td>Surface Transportation</td><td>Transport Related Services</td>
<td>Transportation <br>Total</td>
<td>Utilities</td>
<td>Sovereign</td><td>Others*</td>
</tr>  -->

<tr class="Blue-content" align="center" valign="top">
<!-- <td>From</td>-->
<td rowspan="2">End Date </td>
<td colspan="3">Auto</td>
<td colspan="3">Financial<br>Services</td>
<td colspan="3">Capital Goods</td>
<td colspan="3">Chemicals</td>
<td colspan="3">Coal</td>
<td colspan="3">Commerical<br>Serv & Supp</td>
<td colspan="3">Construction<br>Material</td>
<td colspan="3">Construction<br>Durables</td>
<td colspan="3">Diversified</td>
<td colspan="3">Diversified Consumer Services</td>
<td colspan="3">Food,Beverages<br>&<br>Tobacco</td>

<td colspan="3">Forest<br>Material</td>
<td colspan="3">Gen.Indus<br>trials</td>
<td colspan="3">Hardware<br>Tech&Equipment</td>
<td colspan="3">Healthcare<br>Equip & Supplies</td>
<td colspan="3">Healthcare<br>Serv.</td>
<td colspan="3">Hotel, Rest<br>& Tourism</td>

<td colspan="3">Household<br>& Perso<br>Products</td>
<td colspan="3">Media</td>
<td colspan="3">Metals &<br>Mining</td>
<td colspan="3">Oil & Gas</td>
<td colspan="3">Pharma & Biotec</td>
<td colspan="3">Realty</td>
<td colspan="3">Retail</td>
<td colspan="3">Software &<br>Services</td>
<td colspan="3">Telecom<br>Services</td>
<td colspan="3">Telecom<br>Equipment</td>
<td colspan="3">Textiles<br>App & Access.</td>
<td colspan="3">Transportaion</td>
<td colspan="3">Utilities</td>
<td colspan="3">Sovereign</td>
<td colspan="3">Others*</td>
<td colspan="3">TOTAL</td>
</tr> 
<tr class="Blue-content" align="center" valign="top">
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>
<td>Inv</td><td>AUC</td><td>AUC &#916</td>

</tr>


		<%


//		out.println(query1);
				
int d3=0;
int d5=0;
int d7=0;
int d9=0;
int d11=0;
int d13=0;
int d15=0;
int d17=0;
int d19=0;
int d21=0;
int d23=0;
int d25=0;
int d27=0;
int d29=0;
int d31=0;
int d33=0;
int d35=0;
int d37=0;
int d39=0;
int d41=0;
int d43=0;
int d45=0;
int d47=0;
int d49=0;
int d51=0;
int d53=0;
int d55=0;
int d57=0;
int d59=0;
int d61=0;
int d63=0;
int d65=0;
int d67=0;

int rscount=1;
	rs1=stmt.executeQuery(query1);

		

	while(rs1.next()){		
       	if (rscount > 1){ 
			
		%>
<% if (rcount==1){ %>
				<tr class="content" align="right" bgcolor="#FFFFFF">
<% rcount=0;
	} else { %>
				<tr class="content" align="right" bgcolor="#DBEBFF">
<% rcount=1;} %>
<td><%=rs1.getString("eod")%></td>

<td><%=rs1.getInt(2)%></td>
<td><%=rs1.getInt(3)%></b></td>
<td><b><%=rs1.getInt(3)-(d3+rs1.getInt(2))%></b></td>

<td><%=rs1.getInt(4)%></td>
<td><%=rs1.getInt(5)%></td>
<td><b><%=rs1.getInt(5)-(d5+rs1.getInt(4))%></b></td>

<td><%=rs1.getInt(6)%></b></td>
<td><%=rs1.getInt(7)%></b></td>
<td><b><%=rs1.getInt(7)-(d7+rs1.getInt(6))%></b></td>

<td><%=rs1.getInt(8)%></b></td>
<td><%=rs1.getInt(9)%></b></td>
<td><b><%=rs1.getInt(9)-(d9+rs1.getInt(8))%></b></td>

<td><%=rs1.getInt(10)%></b></td>
<td><%=rs1.getInt(11)%></b></td>
<td><b><%=rs1.getInt(11)-(d11+rs1.getInt(10))%></b></td>

<td><%=rs1.getInt(12)%></b></td>
<td><%=rs1.getInt(13)%></b></td>
<td><b><%=rs1.getInt(13)-(d13+rs1.getInt(12))%></b></td>

<td><%=rs1.getInt(14)%></b></td>
<td><%=rs1.getInt(15)%></b></td>
<td><b><%=rs1.getInt(15)-(d15+rs1.getInt(14))%></b></td>

<td><%=rs1.getInt(16)%></b></td>
<td><%=rs1.getInt(17)%></b></td>
<td><b><%=rs1.getInt(17)-(d17+rs1.getInt(16))%></b></td>

<td><%=rs1.getInt(18)%></b></td>
<td><%=rs1.getInt(19)%></b></td>
<td><b><%=rs1.getInt(19)-(d19+rs1.getInt(18))%></b></td>

<td><%=rs1.getInt(20)%></b></td>
<td><%=rs1.getInt(21)%></b></td>
<td><b><%=rs1.getInt(21)-(d21+rs1.getInt(20))%></b></td>

<td><%=rs1.getInt(22)%></b></td>
<td><%=rs1.getInt(23)%></b></td>
<td><b><%=rs1.getInt(23)-(d23+rs1.getInt(22))%></b></td>

<td><%=rs1.getInt(24)%></b></td>
<td><%=rs1.getInt(25)%></b></td>
<td><b><%=rs1.getInt(25)-(d25+rs1.getInt(24))%></b></td>

<td><%=rs1.getInt(26)%></b></td>
<td><%=rs1.getInt(27)%></b></td>
<td><b><%=rs1.getInt(27)-(d27+rs1.getInt(26))%></b></td>

<td><%=rs1.getInt(28)%></b></td>
<td><%=rs1.getInt(29)%></b></td>
<td><b><%=rs1.getInt(29)-(d29+rs1.getInt(28))%></b></td>

<td><%=rs1.getInt(30)%></b></td>
<td><%=rs1.getInt(31)%></b></td>
<td><b><%=rs1.getInt(31)-(d31+rs1.getInt(30))%></b></td>

<td><%=rs1.getInt(32)%></td>
<td><%=rs1.getInt(33)%></b></td>
<td><b><%=rs1.getInt(33)-(d33+rs1.getInt(32))%></b></td>

<td><%=rs1.getInt(34)%></td>
<td><%=rs1.getInt(35)%></td>
<td><b><%=rs1.getInt(35)-(d35+rs1.getInt(34))%></b></td>

<td><%=rs1.getInt(36)%></b></td>
<td><%=rs1.getInt(37)%></b></td>
<td><b><%=rs1.getInt(37)-(d37+rs1.getInt(36))%></b></td>

<td><%=rs1.getInt(38)%></b></td>
<td><%=rs1.getInt(39)%></b></td>
<td><b><%=rs1.getInt(39)-(d39+rs1.getInt(38))%></b></td>

<td><%=rs1.getInt(40)%></b></td>
<td><%=rs1.getInt(41)%></b></td>
<td><b><%=rs1.getInt(41)-(d41+rs1.getInt(40))%></b></td>

<td><%=rs1.getInt(42)%></td>
<td><%=rs1.getInt(43)%></b></td>
<td><b><%=rs1.getInt(43)-(d43+rs1.getInt(42))%></b></td>

<td><%=rs1.getInt(44)%></td>
<td><%=rs1.getInt(45)%></td>
<td><b><%=rs1.getInt(45)-(d45+rs1.getInt(44))%></b></td>

<td><%=rs1.getInt(46)%></b></td>
<td><%=rs1.getInt(47)%></b></td>
<td><b><%=rs1.getInt(47)-(d47+rs1.getInt(46))%></b></td>

<td><%=rs1.getInt(48)%></b></td>
<td><%=rs1.getInt(49)%></b></td>
<td><b><%=rs1.getInt(49)-(d49+rs1.getInt(48))%></b></td>

<td><%=rs1.getInt(50)%></b></td>
<td><%=rs1.getInt(51)%></b></td>
<td><b><%=rs1.getInt(51)-(d51+rs1.getInt(50))%></b></td>

<td><%=rs1.getInt(52)%></td>
<td><%=rs1.getInt(53)%></b></td>
<td><b><%=rs1.getInt(53)-(d53+rs1.getInt(52))%></b></td>

<td><%=rs1.getInt(54)%></td>
<td><%=rs1.getInt(55)%></td>
<td><b><%=rs1.getInt(55)-(d55+rs1.getInt(54))%></b></td>

<td><%=rs1.getInt(56)%></b></td>
<td><%=rs1.getInt(57)%></b></td>
<td><b><%=rs1.getInt(57)-(d57+rs1.getInt(56))%></b></td>

<td><%=rs1.getInt(58)%></b></td>
<td><%=rs1.getInt(59)%></b></td>
<td><b><%=rs1.getInt(59)-(d59+rs1.getInt(58))%></b></td>

<td><%=rs1.getInt(60)%></b></td>
<td><%=rs1.getInt(61)%></b></td>
<td><b><%=rs1.getInt(61)-(d61+rs1.getInt(60))%></b></td>

<td><%=rs1.getInt(62)%></td>
<td><%=rs1.getInt(63)%></b></td>
<td><b><%=rs1.getInt(63)-(d63+rs1.getInt(62))%></b></td>

<td><%=rs1.getInt(64)%></td>
<td><%=rs1.getInt(65)%></td>
<td><b><%=rs1.getInt(65)-(d65+rs1.getInt(64))%></b></td>

<td><%=rs1.getInt(66)%></b></td>
<td><%=rs1.getInt(67)%></b></td>
<td><b><%=rs1.getInt(67)-(d67+rs1.getInt(66))%></b></td>

</tr> 
<% 
}
rscount++;

d3=rs1.getInt(3);
d5=rs1.getInt(5);
d7=rs1.getInt(7);
d9=rs1.getInt(9);
d11=rs1.getInt(11);
d13=rs1.getInt(13);
d15=rs1.getInt(15);
d17=rs1.getInt(17);
d19=rs1.getInt(19);
d21=rs1.getInt(21);
d23=rs1.getInt(23);
d25=rs1.getInt(25);
d27=rs1.getInt(27);
d29=rs1.getInt(29);
d31=rs1.getInt(31);
d33=rs1.getInt(33);
d35=rs1.getInt(35);
d37=rs1.getInt(37);
d39=rs1.getInt(39);
d41=rs1.getInt(41);
d43=rs1.getInt(43);
d45=rs1.getInt(45);
d47=rs1.getInt(47);
d49=rs1.getInt(49);
d51=rs1.getInt(51);
d53=rs1.getInt(53);
d55=rs1.getInt(55);
d57=rs1.getInt(57);
d59=rs1.getInt(59);
d61=rs1.getInt(61);
d63=rs1.getInt(63);
d65=rs1.getInt(65);
d67=rs1.getInt(67);




} %>
</table>

</body>
</html>

