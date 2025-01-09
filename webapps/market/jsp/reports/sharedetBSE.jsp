<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>


<%@ page import="java.io.*" %>
<%@ page  import="java.awt.*" %>


<%@ page   %>


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
String vscrip=request.getParameter("scrip");
String vTchg = request.getParameter("vTchg");
if (vTchg == null){vTchg ="35";}

String vfdate="";
String vtdate="";
String vexchange="BSE";
String vOI="0";
String vBSE="0";


Integer rcount=1;

DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());

rs=stmt.executeQuery("select count(1) count from nse_fo where day >= subdate(current_date,20) and option_type='XX' and code='"+vscrip+"'");  
		while(rs.next()){ vOI =rs.getString(1);}

rs=stmt.executeQuery("SELECT count(1) FROM BSE_BHAV x,SCRIP_CODE y WHERE y.bse_code=x.code and day >= subdate(current_date,20) and nse_code='"+vscrip+"'");  
		while(rs.next()){ vBSE =rs.getString(1);}

		
	query="SELECT min(day) F_EOD_DATE, max(day) T_EOD_DATE FROM (SELECT day FROM eod ORDER BY 1 DESC limit "+vTchg+")e"; 
	//out.println(query);
	rs=stmt.executeQuery(query);
	while(rs.next()){ vfdate=rs.getString(1);	
			    vtdate=rs.getString(1);	
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


<script>
function parameter(){
var vscrip= document.getElementById("txtScrip").value
var vTchg =document.getElementById("cmbTchg").value
var vType =document.getElementById("txtType").value
window.location.replace("sharedetBSE.jsp?scrip="+vscrip+"&&vTchg="+vTchg+"&&type="+vType);
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

window.location.replace("sharedetBSE.jsp?scrip="+vscrip+"&&vTchg="+vTchg+"&&type="+vType);
}
</script>



</head>
<body>
<table calss="table" border="0" cellpadding="1" cellspacing="0"   >
<tr>
<td valign=top>	
<table  class="border" border="0" cellpadding="0"  bgcolor="#DBEBFF" VALIGN="TOP">
<tr class="content style1">
	<td  class="Blue-content" colspan="1" ><B><%=vscrip%>
		<input class="content style1" type="text" id="searchBox" name="searchString" size="10" />
	 	<button name="searchKeyword" id="searchKeyword" class="content style1" value="Search" onClick="search()" >Go</button>

		
			<% 
				query="select * from scrip_code where nse_code='"+vscrip+"'";
				rs=stmt.executeQuery(query);  
				while(rs.next()){
				%>
				BSE CODE:  <B><%=rs.getString("BSE_CODE")%><br> 
				News:
				<a href="http://www.bseindia.com/stock-share-price/news/news/<%=rs.getString("bse_code")%>/" target="_blank" style="font-size: 9pt; color: #499999 ;font-weight: normal" >BSE</a>
				<a href="<%=rs.getString("mc_link")%>" target="_blank" style="font-size: 9pt; color: #600000 ;font-weight: normal">MC</a>
				<%} %>
			Days:
			<select id="cmbTchg" onchange="parameter()" class="content style1" size="0" width="2">
			<%   if ("35".equalsIgnoreCase(vTchg)) { %> <option value="35" selected disabled >35</option> <% } else {%> <option value="35">35</option>
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
				query=query+" ROUND((P-S1)+R1,2) as R2, ROUND(P-(R1-S1),2) S2 ,"; 
				query=query+" ROUND(high_price+2*(P-low_price),2) R3,";
				query=query+" ROUND(low_price-2*(high_price-P),2) S3 ";
				query=query+" FROM ( select CODE,P, (2*P) - low_price as R1,(2*P) - high_price as S1,high_price,low_price,close_price from (";
				query=query+" select nse_code code ,(high+ low+close)/3 AS P,high high_price,low low_price,close close_price from bse_bhav b inner join scrip_code s on s.isin=b.isin_code";
				query=query+" where day=(select max(day) from eod) ";
				query=query+" and nse_code='"+vscrip+"')x)y";
				
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
	<td>Del Qty %</td><td>Turnover<br>(Lakhs)</td>
	<!-- <td>20 DMA<BR>Cross</td>
	<td>Week 20DMA<br>Cross</td> -->

	<!-- <td>Chg%</td> <td>STOCK<br>chg%</td><td>Chg%</td><td>STOCK<br>chg%</td>-->
	</tr>

 <% 
 query1 ="select code,nse_code,isin_code,day,cur_price close_price,PRICE_CHANGE_PER,cur_delivery del_qty,del_qty_per,turnover_lakh ";
 query1 +="from bse_research_page r inner join scrip_code sc on sc.isin=r.isin_code";
 query1 +=" where sc.nse_code='"+vscrip+"' and r.day >=  '"+vfdate+"'";
 query1 +="order by day desc ";

 //out.println(query1);
int vrec=0;
float trd_val_chg=0;
rs1=stmt1.executeQuery(query1);
while(rs1.next()){
 %>
<tr class="content style1" align="right">				
	<td><%=rs1.getString("day")%></td>
	<td><%=decf.format(rs1.getFloat("close_price"))%></td>
	<td><%=decf.format(rs1.getFloat("PRICE_CHANGE_PER"))%></td>
    <td><%=decf.format(rs1.getFloat("del_qty_per"))%></td>
	<td><%= decf.format(rs1.getFloat("turnover_lakh"))%></td> 
</tr> 
<%  }  
%>

</table></td></tr>
</table>
<td valign=top>
<!-- <iframe width="1000" height="1400" style="margin-bottom:5px" src="http://nseguide.com/charts.php?name=<%=vscrip%>" ></iframe> -->
<iframe width="1000" height="1400" style="margin-bottom:5px" src="http://chartink.com/stocks/<%=vscrip%>.html" ></iframe>
</td>
</tr>
</table>




</body>
</html>

