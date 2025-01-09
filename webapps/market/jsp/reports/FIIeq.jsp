<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>


<%@ page import="java.io.*" %>  


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

DecimalFormat decf = new DecimalFormat("####0.00");

if(vfdate == null){ 
// vfdate=formattedDate;

		rs=stmt.executeQuery(" SELECT day FROM EOD ORDER BY day desc limit 24,1"); 

		while(rs.next()){
		vfdate=rs.getString(1);
		}
 vtdate=formattedDate;
}


query1= "select * from ";
query1= query1+" (select to_char(to_date(day,'YYYYMMDD'),'DD-MON-YY') RDATE,day,sum(IF_CONTRACT_BUY) IF_CONTRACT_BUY ,sum(IF_BUY_AMOUNT) IF_BUY_AMOUNT ,sum(IF_SELL_AMOUNT) IF_SELL_AMOUNT,";
query1= query1+" sum(IF_BUY_AMOUNT)-sum(IF_SELL_AMOUNT) IF_NET, ";
query1= query1+" sum(IF_OI_CONTRACTS) IF_OI_CONTRACTS,sum(SF_CONTRACT_BUY) SF_CONTRACT_BUY ,sum(SF_BUY_AMOUNT) SF_BUY_AMOUNT,sum(SF_SELL_AMOUNT) SF_SELL_AMOUNT,";
query1= query1+" sum(SF_BUY_AMOUNT)-sum(SF_SELL_AMOUNT) SF_NET, ";
query1= query1+" sum(IO_BUY_AMOUNT)-sum(IO_SELL_AMOUNT) IO_NET, ";
query1= query1+" sum(SF_OI_CONTRACTS) SF_OI_CONTRACTS from(";
query1= query1+" select day, Decode(CATEGORY,'INDEX FUTURES',CONTRACTS_BUY,0) IF_CONTRACT_BUY ,";
query1= query1+" if(CATEGORY='INDEX FUTURES',BUY_AMOUNT,0) IF_BUY_AMOUNT ,";
query1= query1+" if(CATEGORY=,'INDEX FUTURES',SELL_AMOUNT,0) IF_SELL_AMOUNT ,";
query1= query1+" if(CATEGORY=,'INDEX FUTURES',OI_CONTRACTS,0) IF_OI_CONTRACTS ,";
query1= query1+" if(CATEGORY=,'STOCK FUTURES',CONTRACTS_BUY,0) SF_CONTRACT_BUY ,";
query1= query1+" if(CATEGORY=,'STOCK FUTURES',BUY_AMOUNT,0) SF_BUY_AMOUNT,";
query1= query1+" if(CATEGORY=,'STOCK FUTURES',SELL_AMOUNT,0) SF_SELL_AMOUNT, ";
query1= query1+" if(CATEGORY=,'STOCK FUTURES',OI_CONTRACTS,0) SF_OI_CONTRACTS, ";
query1= query1+" if(CATEGORY=,'INDEX OPTIONS',BUY_AMOUNT,0) IO_BUY_AMOUNT,";
query1= query1+" if(CATEGORY=,'INDEX OPTIONS',SELL_AMOUNT,0) IO_SELL_AMOUNT ";
query1= query1+" from fii_fo_daily  where  day between  '"+vfdate+"' and  '"+vtdate+"'";
query1= query1+" AND CATEGORY in ('STOCK FUTURES','INDEX FUTURES','INDEX OPTIONS') )group by day) FII_FO,";
query1= query1+" (SELECT day Day1,sell,buy,net ";
query1= query1+"  FROM FII_EQ_DAILY a where CATEGORY like 'FII%' ";
query1= query1+"  and day between to_char(to_date('"+vfdate+"','dd/mm/yyyy'),'yyyymmdd') and to_char(to_date('"+vtdate+"','dd/mm/yyyy'),'yyyymmdd') )FII_EQ ";
query1= query1+"  ,(select EOD_DATE,CLOSE,POINTS_CHANGE,CHANGE_PER from nse_ind where code='CNX Nifty') NSE";
query1= query1+"  where fii_fo.day=fii_eq.day1(+) and fii_fo.day=nse.eod_date(+) order by day";

%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reports</title>
<script type="text/javascript" src="../../Script/tabber.js"></script>
<script language="javascript" type="text/javascript" src="../../Script/datepicker.js"></script> 
<link href="../../styles/text.css" rel="stylesheet" type="text/css">

<script>
function parameter(){
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
window.location.replace("FIIeq.jsp?vfdate="+vfdate+"&&vtdate="+vtdate);
}
</script>

</head>
<body>


<table width="100%" border="1" class="border" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>

<tr class="Heading"><td align ="center" class="Blue-content" colspan=3>FII Daily Data</td> </tr>


<!--   date selection starts here -->

<td class="Blue-content" align="left"><b>From:</b>
<input id="fdate"  class="content style1" type="text" name="fdate" size="10" maxlength="12" value=<%=vfdate%>>
<a href="javascript:NewCal('fdate','ddmmyyyy',false)"><img src="../../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a>
</td>

<td class="Blue-content" align="left"><b>To</b>
<input id="tdate"  class="content style1" type="text" name="tdate" size="10" maxlength="12" value=<%=vtdate%>>
<a href="javascript:NewCal('tdate','ddmmyyyy',false)"><img src="../../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a>

</td>


 <!-- date selection Ends here -->

<input class="content style1" type="hidden" name="txtExchange" size="10" maxlength="12" value=<%=vexchange%>>
<input class="content style1" type="hidden" name="txtScrip" size="10" maxlength="12" value=<%=vscrip%>>

<td><input class="content style1" type="submit" value="Go" onClick="parameter()"></td> <tr>
</table>

<table width="100%" border="1" cellpadding="2"  bgcolor="#DBEBFF" cellspacing="0" id="stretch" > 
<tr class="Blue-content" align="center">
<td>Day</td>
<td>NSE Close</td>
<td>NSE<br> Change %</td>
<td> Cash Net </td>
<td> INDEX FUTURE<BR>Net </td>
<td> STOCK FUTURE<BR>Net </td>
<td> INDEX OPTIONS<BR>Net </td>
<!-- 
<td>Cash Buy <br> (crores)</td>
<td>Cash Sell<br> (Crores)</td>

<td> INDEX FUTURE<BR>Buy </td>
<td> INDEX FUTURE<BR>Sell </td>
<td> STOCK FUTURE<BR>Buy </td>
<td> STOCK FUTURE<BR>Sell </td>
-->

<td> INDEX FUTURE<BR> OI </td>
<td> STOCK FUTURE<BR> OI </td>


				</tr>

				<%


				//out.println(query1);
				
				 rs1=stmt.executeQuery(query1);

				 /* code for line chart */
				
				 while(rs1.next()){
					
		
				%>


<!-- <tr class="content style1" align="right"> -->
<% if (rcount==1){ %>
				<tr class="content" align="right" bgcolor="#FFFFFF">
<% rcount=0;
	} else { %>
				<tr class="content" align="right" bgcolor="#DBEBFF">
<% rcount=1;} %>
<td><%=rs1.getString("RDATE")%></td>
<td><%=decf.format(rs1.getFloat("CLOSE"))%></td>
<td><%=decf.format(rs1.getFloat("CHANGE_PER"))%></td>
<td><%=decf.format(rs1.getFloat("Net"))%></td>

<td><%=decf.format(rs1.getFloat("IF_NET"))%></td>
<td><%=decf.format(rs1.getFloat("SF_NET"))%></td>
<td><%=decf.format(rs1.getFloat("IO_NET"))%></td>
<!-- 
<td><%=decf.format(rs1.getFloat("buy"))%></td> 
<td><%=decf.format(rs1.getFloat("Sell"))%></td>

<td><%=decf.format(rs1.getFloat("IF_BUY_AMOUNT"))%></td>
<td><%=decf.format(rs1.getFloat("IF_SELL_AMOUNT"))%></td>
<td><%=decf.format(rs1.getFloat("SF_BUY_AMOUNT"))%></td>
<td><%=decf.format(rs1.getFloat("SF_SELL_AMOUNT"))%></td>
-->
<td><%=decf.format(rs1.getFloat("IF_OI_CONTRACTS"))%></td>
<td><%=decf.format(rs1.getFloat("SF_OI_CONTRACTS"))%></td>

</tr> 
<% 
				
	// JFreeChart chart = ChartFactory.createBarChart("Futures Net", "Day", "Crores", dataset, PlotOrientation.VERTICAL,true, true, true);
	// ChartUtilities.saveChartAsJPEG(new File("/usr/share/apache-tomcat-7.0.32/webapps/market/jsp/reports/fiichart.jpg"), chart, 900, 300);
} %>
</table>
<table width="90%" border="0" cellpadding="2" cellspacing="0" id="stretch" bgcolor="#DBEBFF"> 
<tr><td><img src="fiichart.jpg" id="reloader" onload="setTimeout('document.getElementById(\'reloader\').src=\'fiichart.jpg?\'+new Date().getMilliseconds()', 5000)" 

/></td></tr>
</table>



</body>
</html>

