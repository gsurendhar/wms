<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>



<script>
function parameter(){
var vgroup=document.getElementById("cmbGroup").value
var vprice=document.getElementById("txtPrice").value
//var vqty=document.getElementById("txtQty").value
var vtrdval=document.getElementById("txtTrdval").value
var vdel=document.getElementById("txtDel").value
var vcdel=document.getElementById("cmbCday").value
var vpchg=document.getElementById("cmbPchg").value
var vnsedel=document.getElementById("cmbNSEdel").value;
var voichg=document.getElementById("cmbOIchg").value;

var vTchg =document.getElementById("cmbTchg").value;
var vp20DMAc =document.getElementById("cmb20DMAprice").value;
var vTqty =document.getElementById("cmbTrdqty").value;
var Vol20D =document.getElementById("cmbVol20DMAchg").value;
var vgap=document.getElementById("cmbGAP").value;
var vdiv=document.getElementById("cmbDiv").value;
var vtype=document.getElementById("cmbStr").value;
var v20dmac=document.getElementById("cmbP20DMAC").value;


window.location.replace("shares.jsp?type="+vtype+"&&vdiv="+vdiv+"&&vprice="+vprice+"&&vGAP="+vgap+"&&vdel="+vdel+"&&Vol20D="+Vol20D+"&&vtrdval="+vtrdval+"&&vgroup="+vgroup+"&&cdel="+vcdel+"&&pchg="+vpchg+"&&nsedel="+vnsedel+"&&oichg="+voichg+"&&vTchg="+vTchg+"&&p20DMAc="+vp20DMAc+"&&tqty="+vTqty+"&&c20dma="+v20dmac);

}


function parameter_rule(){
var vrule=document.getElementById("cmbRule").value
var vgroup=document.getElementById("cmbGroup").value
var vprice=document.getElementById("txtPrice").value
var vqty=document.getElementById("txtQty").value
var vtrdval=document.getElementById("txtTrdval").value
var vdel=document.getElementById("txtDel").value
var vTchg =document.getElementById("cmbTchg").value
var vTqty =document.getElementById("cmbT").value
window.location.replace("shares.jsp?vrule="+vrule+"&&vprice="+vprice+"&&vqty="+vqty+"&&vdel="+vdel+"&&vtrdval="+vtrdval+"&&vgroup="+vgroup+"&&vTchg="+vTchg+"&&tqty="+vTqty);
}


function parameter_day(){
var vday=document.getElementById("cmbDay").value
window.location.replace("shares.jsp?vday="+vday);
}

</script>


<!-- added for sorting table --->
<script type="text/javascript" src="../../Script/gs_sortable.js"></script>
<script type="text/javascript">
var TSort_Data = new Array ('my_table', 's', 's','i', 'f','f','f','f','f','f','f','f','f','f','f','f','f','s','s','s');
var TSort_Classes = new Array ('row1', 'row2');
//var TSort_Initial = 1;
//tsRegister();
</script>

<%!

        Connection con=null;
        ResultSet rs=null;
        ResultSet rs1=null;
        Statement stmt=null;
String query="";
String query1="";
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

String vprice=request.getParameter("vprice");
String vpdays=request.getParameter("vpdays");
String vldays=request.getParameter("vldays");
String vdel=request.getParameter("vdel");
String vtrdval=request.getParameter("vtrdval");
String vscrip=request.getParameter("vscrip");

String vcdel=request.getParameter("cdel");
//String vp1del=request.getParameter("p1del");
//String vp2del=request.getParameter("p2del");
String vpchg=request.getParameter("pchg");
//String vpchg1=request.getParameter("pchg1");
//String vpchg2=request.getParameter("pchg2");


String vtqty=request.getParameter("tqty");
String volchg20DMA = request.getParameter("Vol20D");
String vnsedel=request.getParameter("nsedel");
//String vnsedel1=request.getParameter("nsedel1");
//String vnsedel2=request.getParameter("nsedel2");


// String vbsedel=request.getParameter("bsedel");
// String vbseqty=request.getParameter("bseqty");
String voichg=request.getParameter("oichg");
String vcocchg=request.getParameter("cocchg");
String vrule=request.getParameter("vrule");
String vp20DMAc=request.getParameter("p20DMAc");
String v20DMA=request.getParameter("c20dma");

String vgroup=request.getParameter("vgroup");
//if (vgroup==null){vgroup="1";}

String vGAP=request.getParameter("vGAP");
if (vGAP==null){vGAP="U";}

String vdiv=request.getParameter("vdiv");
if (vdiv==null){vdiv="A";}


String v20dma=request.getParameter("v20dma");
if (v20dma==null){v20dma="A";}

String vtype=request.getParameter("type");


String vday= request.getParameter("vday");
	if (vday==null){
		rs=stmt.executeQuery("select max(day) from eod");
		while(rs.next()){
			vday=rs.getString(1);
		}
	}

String vexchange="NSE";
if (vgroup==null){vgroup="0";}
if (vrule==null){vrule="0";}
String vTchg = request.getParameter("vTchg");
if (vTchg == null){vTchg ="35";}

if (vscrip==null){vscrip="0";}
if (vexchange==null){vexchange="NSE";}

if (vpdays==null){vpdays="1";}
if (vldays==null){vldays="1";}
if (vdel==null){vdel="-100";}



if (vtrdval==null){vtrdval="2000";}
if (vprice==null){vprice="5";}
if (vgroup==null){vgroup="0";}


String vfdate=request.getParameter("vfdate");
String vtdate=request.getParameter("vtdate");

Integer rcount=1;


DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());

DecimalFormat decf = new DecimalFormat("####0.00");

if(vfdate == null){
 vfdate=formattedDate;
 vtdate=formattedDate;
}

String vcon="";
String vstar="";

if (! "0".equalsIgnoreCase(vgroup)){vcon=" and code in (select CODE from code_group where group_id='"+vgroup+"')" ;}


if (!"0".equalsIgnoreCase(vrule)){
//out.println(vrule);
rs=stmt.executeQuery("select * from rule_book where rule_id='"+vrule+"'");
	while(rs.next()){
	vpchg=rs.getString("price_chg");
	vcdel=rs.getString("nse_cur_del");
	//vp1del=rs.getString("nse_prev1_del");
	//vp2del=rs.getString("nse_prev2_del");
	vnsedel=rs.getString("nse_del_per");
	//vbsedel=rs.getString("bse_del_per");
	//vbseqty=rs.getString("bse_del_qty");
	voichg=rs.getString("nse_oi_chg_per");
	}
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reports</title>
<script type="text/javascript" src="../../Script/tabber.js"></script>
<script language="javascript" type="text/javascript" src="../../Script/datepicker.js"></script>
<link href="../../styles/text.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="../../jquery/jquery-1.11.2.min.js"></script>
    
</head>

<body>
<table width="100%" border="0" class="border" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
<tr><td valign=top>
<table width="100%" border="1" class="border" cellpadding="2" cellspacing="0"  bgcolor="#DBEBFF" VALIGN=TOP>
<tr class="Blue-content">
<!--
<td class="Blue-content"  align="left" colspan="1">
 Rule:
<select id="cmbRule" onchange="parameter_rule()" class="content style1" size="0" style="width: 200px;">
<option value="0">--Select--</option>
<%
rs1=stmt.executeQuery("select rule_id as id ,substr(remarks,1,15) as name from rule_book order by 2");
while(rs1.next()){
%>
<option value="<%=rs1.getString("id")%>" ><%=rs1.getString("name")%></option>
<% if(rs1.getString("id").equals(vrule)){%>
<option value="<%=vrule%>" selected ><%=rs1.getString("name")%></option>
<%
}
}
%>
</select>
</td>

--> 
<td class="Blue-content"  align="left" colspan="1">
 Day:
<select id="cmbDay" onchange="parameter_day()" class="content style1" size="0" style="width: 80px;">
<option value="0">--Select--</option>
<%
rs1=stmt.executeQuery("select day eod_date,date_format(day,'%d-%m-%y') eod_day from eod order by 1 desc LIMIT 0, 10");
while(rs1.next()){
%>
<option value="<%=rs1.getString("eod_date")%>" ><%=rs1.getString("eod_day")%></option>
<% if(rs1.getString("eod_date").equals(vday)){%>
<option value="<%=vday%>" disabled selected ><%=rs1.getString("eod_day")%></option>
<%
}
}
%>
</select>
</td>

<!-- 
<td class="Blue-content"  align="left" colspan="1">
 Rule:
<select id="cmbRule" onchange="parameter_rule()" class="content style1" size="0" style="width: 200px;">
<option value="0">--Select--</option>
<%
rs1=stmt.executeQuery("select rule_id as id ,substr(remarks,1,15) as name from rule_book order by 2");
while(rs1.next()){
%>
<option value="<%=rs1.getString("id")%>" ><%=rs1.getString("name")%></option>
<% if(rs1.getString("id").equals(vrule)){%>
<option value="<%=vrule%>" selected ><%=rs1.getString("name")%></option>
<%
}
}
%>
</select>
</td>
-->
<td class="Blue-content"  align="left">
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
<td class="Blue-content" align="left">
History Days:
<select id="cmbTchg" onchange="parameter()" class="content style1" size="0">
<%   if ("25".equalsIgnoreCase(vTchg)) { %> <option value="35" selected disabled >35</option> <% } else {%> <option value="35">35</option>
<% } if ("50".equalsIgnoreCase(vTchg)) { %> <option value="50" selected disabled >50</option> <% } else {%> <option value="50">50</option>
<% } if ("100".equalsIgnoreCase(vTchg)) { %> <option value="100"  selected disabled>100</option> <% } else {%> <option value="100">100</option>
<% } if ("150".equalsIgnoreCase(vTchg)) { %> <option value="150"  selected disabled>150</option> <% } else {%> <option value="150">150</option>
<% } if ("200".equalsIgnoreCase(vTchg)) { %> <option value="200"  selected disabled>200</option> <% } else {%> <option value="200">200</option>
<%} %>
</select>
</td>
<td></td> 

</tr>


<tr class="Blue-content">
<td class="Blue-content"><b>Share Price:</b><input type=text id=txtPrice name=txtPrice  class="content style1" value="<%=vprice%>" size="4">and above</td>
<td class="Blue-content"><b>Traded Value:(Lacs)</b><input type=text id=txtTrdval name=txtTrdval  class="content style1" value="<%=vtrdval%>" size="4">and above
<input class="content style1"  type="submit" value="Go" onClick="parameter()">
</td> 


<td ><b>Del % </b><input type=text id=txtDel name=txtDel  class="content style1" value="<%=vdel%>" size="2"/></td>

<td>
MACD Cross &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
<select id="cmbDiv" onchange="parameter()" class="content style1" size="0">
<option value="A">All</option>


<option value="Buy" >Buy</option>
<option value="Sell" >Sell</option>
<option value="R"  >C R</option>
<option value="F"  >C F</option>

<% if ("Buy".equalsIgnoreCase(vdiv)) { %>
	<option value="Buy" selected disabled >Buy</option>
<% } if ("Sell".equalsIgnoreCase(vdiv)) { %>
<option value="Sell"  selected disabled>Sell</option>
<%} if ("R".equalsIgnoreCase(vdiv)) { %>
	<option value="R" selected disabled >C R</option>
<% } if ("F".equalsIgnoreCase(vdiv)) { %>
<option value="F"  selected disabled>C F</option>
<%} %>
</select>
</td> 


</tr>
<tr class="Blue-content">


<td>Price Chg:
<select id="cmbPchg" onchange="parameter()" class="content style1" size="0">
<option value="A">All</option>
<% if ("R1".equalsIgnoreCase(vpchg)) { %> <option value="R1" selected disabled >Raise 1</option> <% } else { %> <option value="R1" >Raise 1</option>
<%} if ("R2".equalsIgnoreCase(vpchg)) { %> <option value="R2" selected disabled >Raise 2</option><% } else { %> <option value="R2" >Raise 2</option>
<%} if ("R3".equalsIgnoreCase(vpchg)) { %> <option value="R3" selected disabled >Raise 3</option><% } else { %> <option value="R3" >Raise 3</option>
<%} if ("F1".equalsIgnoreCase(vpchg)) { %> <option value="F1" selected disabled >Fall 1</option><% } else { %> <option value="F1" >Fall 1</option>
<%} if ("F2".equalsIgnoreCase(vpchg)) { %> <option value="F2" selected disabled >Fall 2</option><% } else { %> <option value="F2" >Fall 2</option>
<%} if ("F3".equalsIgnoreCase(vpchg)) { %> <option value="F3" selected disabled >Fall 3</option><% } else { %> <option value="F3" >Fall 3</option>
<%} %>
</select>
</td>

<td></td>

<td>
OI Chg%:
<select id="cmbOIchg" onchange="parameter()" class="content style1" size="0">
<option value="A">All</option>
<% if ("R".equalsIgnoreCase(voichg)) { %><option value="R" selected disabled >Raise</option> <% } else { %><option value="R" >Raise</option>
<% } if ("F".equalsIgnoreCase(voichg)) { %> <option value="F"  selected disabled>Fall</option> <% } else { %><option value="F" >Fall</option>
<%} %>
</select>
</td> 

<td class="Blue-content">
Vol 20DMA Chg%:
<select id="cmbVol20DMAchg" onchange="parameter()" class="content style1" size="0">
<option value="U" >All</option>
<% if ("A".equalsIgnoreCase(volchg20DMA)) { %> <option value="A" selected disabled >Raise</option><% } else {%><option value="A" >Raise</option>
<% } if ("B".equalsIgnoreCase(volchg20DMA)) { %><option value="B"  selected disabled>Fall</option><% } else {%> <option value="B" >Fall</option>
<%} %>
</select>
</td>

</tr>

<tr class="Blue-content"  align="left">
<td>
Del Qty&nbsp;&nbsp;&nbsp;:
<select id="cmbCday" onchange="parameter()" class="content style1" size="0">
<option value="A">All</option>
<% if ("R1".equalsIgnoreCase(vcdel)) { %> <option value="R1" selected disabled >Raise 1</option><% } else { %> <option value="R1" >Raise 1</option>
<%} if ("R2".equalsIgnoreCase(vcdel)) { %> <option value="R2" selected disabled >Raise 2</option><% } else { %> <option value="R2" >Raise 2</option>
<%} if ("R3".equalsIgnoreCase(vcdel)) { %> <option value="R3" selected disabled >Raise 3</option><% } else { %> <option value="R3" >Raise 3</option>
<%} if ("F1".equalsIgnoreCase(vcdel)) { %> <option value="F1" selected disabled >Fall 1</option><% } else { %> <option value="F1" >Fall 1</option>
<%} if ("F2".equalsIgnoreCase(vcdel)) { %> <option value="F2" selected disabled >Fall 2</option><% } else { %> <option value="F2" >Fall 2</option>
<%} if ("F3".equalsIgnoreCase(vcdel)) { %> <option value="F3" selected disabled >Fall 3</option><% } else { %> <option value="F3" >Fall 3</option>
<%} %>
</select>
</td>
<td >
Vol Chg%:
<select id="cmbTrdqty" onchange="parameter()" class="content style1" size="0">
<option value="U" >All</option>
<% if ("A".equalsIgnoreCase(vtqty)) { %><option value="A" selected disabled >Raise</option><% } else {%><option value="A" >Raise</option>
<% }if ("B".equalsIgnoreCase(vtqty)) { %><option value="B"  selected disabled>Fall</option><% } else {%><option value="B" >Fall</option>
<%} %>
</select>
</td>


<td>
Star Stocks :
<select id="cmbStr" onchange="parameter()" class="content style1" size="0">
<option value="A">All</option>
<option value="S" >*</option>
<% if ("S".equalsIgnoreCase(vtype)) { %>
	<option value="S" selected disabled >*</option>
<%} %>
</select>
</td> 

<td class="Blue-content">
Price 20DMA chg%:
<select id="cmb20DMAprice" onchange="parameter()" class="content style1" size="0">
<option value="A" >All</option>
<% if ("R".equalsIgnoreCase(vp20DMAc)) { %><option value="R" selected disabled >Raise</option> <% } else { %><option value="R" >Raise</option>
<% } if ("F".equalsIgnoreCase(vp20DMAc)) { %> <option value="F"  selected disabled>Fall</option> <% } else { %><option value="F" >Fall</option>
<%} %>
</select>
</td>


 

</tr>


<tr class="Blue-content"  align="left">

<td>
Del%&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:
<select id="cmbNSEdel" onchange="parameter()" class="content style1" size="0">
<option value="A">All</option>
<% if ("R1".equalsIgnoreCase(vnsedel)) { %> <option value="R1" selected disabled >Raise 1</option><% } else { %> <option value="R1" >Raise 1</option>
<%} if ("R2".equalsIgnoreCase(vnsedel)) { %> <option value="R2" selected disabled >Raise 2</option><% } else { %> <option value="R2" >Raise 2</option>
<%} if ("R3".equalsIgnoreCase(vnsedel)) { %> <option value="R3" selected disabled >Raise 3</option><% } else { %> <option value="R3" >Raise 3</option>
<%} if ("F1".equalsIgnoreCase(vnsedel)) { %> <option value="F1" selected disabled >Fall 1</option><% } else { %> <option value="F1" >Fall 1</option>
<%} if ("F2".equalsIgnoreCase(vnsedel)) { %> <option value="F2" selected disabled >Fall 2</option><% } else { %> <option value="F2" >Fall 2</option>
<%} if ("F3".equalsIgnoreCase(vnsedel)) { %> <option value="F3" selected disabled >Fall 3</option><% } else { %> <option value="F3" >Fall 3</option>
<%} %>
</select>
</td>

<td>
GAP &nbsp;&nbsp; &nbsp;:
<select id="cmbGAP" onchange="parameter()" class="content style1" size="0">
<option value="U" >All</option>
<% if ("F".equalsIgnoreCase(vGAP)) { %>  <option value="F" selected disabled >Fall </option><% } else { %>	<option value="F" >Fall</option>
<% } if ("R".equalsIgnoreCase(vGAP)) { %> <option value="R" selected disabled >Raise</option><% } else { %>		<option value="R" >Raise</option>
<%} %>
</select>
</td>

<td></td>

<td>
Price 20DMA Cross:
<select id="cmbP20DMAC" onchange="parameter()" class="content style1" size="0">
<option value="A">All</option>
<%   if ("Buy".equalsIgnoreCase(v20DMA)) { %>  <option value="Buy" selected disabled >Buy</option>  <%} else {%><option value="Buy">Buy</option>
<% } if ("Sell".equalsIgnoreCase(v20DMA)) { %> <option value="Sell"  selected disabled>Sell</option><%} else {%><option value="Sell">Sell</option>
<% } if ("AR".equalsIgnoreCase(v20DMA)) { %>   <option value="AR" selected disabled >AR</option>    <%} else {%><option value="AR">AR</option>
<% } if ("AF".equalsIgnoreCase(v20DMA)) { %>   <option value="AF"  selected disabled>AF</option>    <%} else {%><option value="AF">AF</option>
<% } if ("BR".equalsIgnoreCase(v20DMA)) { %>   <option value="BR"  selected disabled>BR</option>    <%} else {%><option value="BR">BR</option>
<% } if ("BF".equalsIgnoreCase(v20DMA)) { %>   <option value="BF"  selected disabled>BF</option>    <%} else {%><option value="BF">BF</option>
<%} %>
</select>
</td>
</tr>

</table>



 

<%
query=" select * from (";
query +=" select x.*,(CASE WHEN (CUR_DIV>=0 and PREV_DIV<0) THEN 'Buy' when (CUR_DIV<0 and PREV_DIV>=0) then 'Sell' WHEN (CUR_DIV-PREV_DIV) >=0 THEN 'C R' when (CUR_DIV-PREV_DIV)<0 then 'C F' else ' ' end) MACD_CROSS ";
query +=" ,(CASE WHEN (P1_CLOSE-P1_PRICE_20DMA) < 0 and (CUR_PRICE-PRICE_20DMA) >=0 THEN 'Buy' WHEN (P1_CLOSE-P1_PRICE_20DMA) > 0 and  (CUR_PRICE-PRICE_20DMA) < 0 THEN 'Sell'";
query +=" WHEN (P1_CLOSE-P1_PRICE_20DMA) >= 0 and (CUR_PRICE-PRICE_20DMA) >=0 and P1_CLOSE <= CUR_PRICE  THEN 'AR' WHEN (P1_CLOSE-P1_PRICE_20DMA) >= 0 and (CUR_PRICE-PRICE_20DMA)>=0 and P1_CLOSE > CUR_PRICE  THEN 'AF'";
query +=" WHEN (P1_CLOSE-P1_PRICE_20DMA) < 0 and (CUR_PRICE-PRICE_20DMA) < 0 and P1_CLOSE <= CUR_PRICE  THEN 'BR' WHEN (P1_CLOSE-P1_PRICE_20DMA) < 0 and (CUR_PRICE-PRICE_20DMA) < 0 and P1_CLOSE > CUR_PRICE  THEN 'BF'";
query +=" else '.' end) DMA20_CROSS";
query +=" from (select R1.CODE,R1.SERIES, R1.CUR_PRICE,R1.PRICE_CHANGE_PER,R1.PRICE_GAP_PER,R1.TOTTRDQTY,R2.TOTTRDQTY P1_TOTTRDQTY,R3.TOTTRDQTY P2_TOTTRDQTY,R1.TOTTRDQTY_CHANGE_PER,";
query +=" R1.DEL_QTY,R1.DEL_PER,round(R1.TURNOVER/100000,2) cur_turnover_lakh,R2.DEL_PER P1_DEL_PER,R3.DEL_PER P2_DEL_PER, (R1.DEL_QTY-R2.DEL_QTY)*100/R2.DEL_QTY DEL_QTY_CHG_PER, ";
query +=" (R1.DEL_PER-R2.DEL_PER_07DMA)*100/R2.DEL_PER_07DMA DEL_PER_07_CHG_PER,";
query +=" R1.DEL_DIFF_PER,R2.DEL_DIFF_PER P1_DEL_DIFF_PER, R3.DEL_DIFF_PER P2_DEL_DIFF_PER,";
query +=" (R2.DEL_QTY-R3.DEL_QTY)*100/R3.DEL_QTY P1_DEL_QTY_CHG_PER,(R3.DEL_QTY-R4.DEL_QTY)*100/R4.DEL_QTY P2_DEL_QTY_CHG_PER,";
query +=" R1.PRICE_20DMA,R1.VOL_20DMA,R1.DEL_QTY_20DMA,(R1.PRICE_20DMA-R2.PRICE_20DMA) PRICE_CHG_20DMA,(R1.VOL_20DMA-R2.VOL_20DMA) VOL_CHG_20DMA,";
query +=" R2.CUR_PRICE P1_CLOSE,R3.CUR_PRICE P2_CLOSE,R4.CUR_PRICE P3_CLOSE ";
query +=" ,ifnull(R1.OI_CHG_PER,0) OI_CHG_PER,(R1.PRICE_20DMA-R2.PRICE_20DMA)*100/R2.PRICE_20DMA  PRICE_20DMA_CHG_PER";
query +=" ,(R1.DEL_QTY_20DMA- R2.DEL_QTY_20DMA)*100/R2.DEL_QTY_20DMA DEL_20DMA_CHG_PER";
query +=" ,R2.PRICE_20DMA P1_PRICE_20DMA, R3.PRICE_20DMA P3_PRICE_20DMA";
//query +=" , concat(R4.CUR_PRICE,',',R3.CUR_PRICE,',',R2.CUR_PRICE,',',R1.CUR_PRICE) price_bank ";
query +=",(R1.EMA_12DAY-R1.EMA_26DAY)-R1.MACD_9EMA CUR_DIV,(R1.EMA_12DAY-R1.EMA_26DAY)-R1.MACD_9EMA PREV_DIV";
query +=" from RESEARCH_PAGE r1  ";
query +=" left outer join RESEARCH_PAGE r2 on r1.code=r2.code";
query +=" left outer join RESEARCH_PAGE r3 on r1.code=r3.code";
query +=" left outer join RESEARCH_PAGE r4 on r1.code=r4.code";
query +=" where r1.day=(select day from eod where day='"+vday+"')";
query +=" and r2.day=(select day from eod where day<'"+vday+"' order by day desc limit 0,1)";
query +=" and r3.day=(select day from eod where day<'"+vday+"' order by day desc limit 1,1)";
query +=" and r4.day=(select day from eod where day<'"+vday+"' order by day desc limit 2,1)";
query +=" and r1.series='EQ') x)y ";
query +=" where CUR_PRICE >="+vprice+" "+vcon+" and ifnull(DEL_PER,0) >= "+vdel+" and cur_turnover_lakh >="+vtrdval;


if ("R1".equalsIgnoreCase(vcdel)){query +=" and DEL_PER >=0";}
if ("F1".equalsIgnoreCase(vcdel)){query +=" and DEL_PER <0";}
if ("R2".equalsIgnoreCase(vcdel)){query +=" and DEL_PER >=0 and P1_DEL_PER >=0";}
if ("F2".equalsIgnoreCase(vcdel)){query +=" and DEL_PER < 0 and P1_DEL_PER < 0";}
if ("R3".equalsIgnoreCase(vcdel)){query +=" and DEL_PER >=0 and P1_DEL_PER >=0 and P2_DEL_PER >=0";}
if ("F3".equalsIgnoreCase(vcdel)){query +=" and DEL_PER < 0 and P1_DEL_PER < 0 and P2_DEL_PER< 0";}





if ("R1".equalsIgnoreCase(vpchg)){query +=" and CUR_PRICE > P1_CLOSE";}
if ("F1".equalsIgnoreCase(vpchg)){query +=" and CUR_PRICE <= P1_CLOSE";}
if ("R2".equalsIgnoreCase(vpchg)){query +=" and CUR_PRICE > P1_CLOSE and P1_CLOSE > P2_CLOSE";}
if ("F2".equalsIgnoreCase(vpchg)){query +=" and CUR_PRICE <= P1_CLOSE and P1_CLOSE <= P2_CLOSE";}
if ("R3".equalsIgnoreCase(vpchg)){query +=" and CUR_PRICE > P1_CLOSE and P1_CLOSE > P2_CLOSE and P2_CLOSE > P2_CLOSE ";}
if ("F3".equalsIgnoreCase(vpchg)){query +=" and CUR_PRICE <= P1_CLOSE and P1_CLOSE <= P2_CLOSE and P2_CLOSE <= P3_CLOSE";}


if ("R1".equalsIgnoreCase(vnsedel)){query +=" and DEL_DIFF_PER >=0";}
if ("F1".equalsIgnoreCase(vnsedel)){query +=" and DEL_DIFF_PER < 0";}
if ("R2".equalsIgnoreCase(vnsedel)){query +=" and DEL_DIFF_PER >=0 and P1_DEL_DIFF_PER >=0";}
if ("F2".equalsIgnoreCase(vnsedel)){query +=" and DEL_DIFF_PER <0 and P1_DEL_DIFF_PER <0";}
if ("R3".equalsIgnoreCase(vnsedel)){query +=" and DEL_DIFF_PER >=0 and P1_DEL_DIFF_PER >=0 and P2_DEL_DIFF_PER >=0";}
if ("F3".equalsIgnoreCase(vnsedel)){query +=" and DEL_DIFF_PER < 0 and P1_DEL_DIFF_PER <0 and P2_DEL_DIFF_PER <0";}

if ("R".equalsIgnoreCase(voichg)){query +=" and ifnull(OI_CHG_PER,0) >0";}
if ("F".equalsIgnoreCase(voichg)){query +=" and ifnull(OI_CHG_PER,0) <=0";}


if ("S".equalsIgnoreCase(vtype)){query +=" and a.star like '%*%'";}





if ("A".equalsIgnoreCase(vtqty)){query +=" and round((TOTTRDQTY- P1_TOTTRDQTY)*100/P1_TOTTRDQTY,2)>=0";}
if ("B".equalsIgnoreCase(vtqty)){query +=" and round((TOTTRDQTY- P1_TOTTRDQTY)*100/P1_TOTTRDQTY,2) < 0";}


if ("A".equalsIgnoreCase(volchg20DMA)){query +=" and VOL_CHG_20DMA >=0";}
if ("B".equalsIgnoreCase(volchg20DMA)){query +=" and VOL_CHG_20DMA < 0";}



if ("R".equalsIgnoreCase(vp20DMAc)){query +=" and PRICE_20DMA_CHG_PER >=0 ";}
if ("F".equalsIgnoreCase(vp20DMAc)){query +=" and PRICE_20DMA_CHG_PER < 0 ";}

if ("R".equalsIgnoreCase(vGAP)){query +=" and PRICE_GAP_PER > 0 ";}
if ("F".equalsIgnoreCase(vGAP)){query +=" and PRICE_GAP_PER < 0 ";}


if ("R".equalsIgnoreCase(vdiv)){query +=" and MACD_CROSS ='C R' ";}
if ("F".equalsIgnoreCase(vdiv)){query +=" and MACD_CROSS = 'C F' ";}
if ("Buy".equalsIgnoreCase(vdiv)){query +=" and MACD_CROSS ='Buy' ";}
if ("Sell".equalsIgnoreCase(vdiv)){query +=" and MACD_CROSS = 'Sell' ";}


if ("Buy".equalsIgnoreCase(v20DMA)){query +=" and DMA20_CROSS ='Buy' ";}
if ("Sell".equalsIgnoreCase(v20DMA)){query +=" and DMA20_CROSS = 'Sell' ";}
if ("AR".equalsIgnoreCase(v20DMA)){query +=" and DMA20_CROSS = 'AR' ";}
if ("AF".equalsIgnoreCase(v20DMA)){query +=" and DMA20_CROSS = 'AF' ";}
if ("BR".equalsIgnoreCase(v20DMA)){query +=" and DMA20_CROSS = 'BR' ";}
if ("BF".equalsIgnoreCase(v20DMA)){query +=" and DMA20_CROSS = 'BF' ";}


//query= query+" ORDER BY FUT_VALUE DESC";

//System.out.println(query);
rs=stmt.executeQuery(query);
%>

<table width="100%" border="1" id="my_table" cellpadding="2" cellspacing="0" id="stretch" >
<thead>
<tr class="Blue-content" align="center">
<th>Code</th>
	<th>Price</th> <th>Price<br>Chg%</th>
	<th>Del QTY<br>Chg%</th>
		<th>Del<br>20DMA<br>Chg%</th>
		<th>Trd<br>Vol<br>Chg%</th>
		<th>Del<br>Chg%</th>
		<th>OI <br>Chg%</th>
		<th>Del Per<br>07Day Chg%</th>
		<th>Latest<br>Del%</th>
		<th>Past<br>Del%</th>
		<th>Del QTY1<br>Chg(%)</th>
		<th>Del QTY2<br>Chg(%)</th>
	<th>Price<br>20DMA</th>		
	<th>Price<br>20DMA<BR>Chg%</th>
<th>GAP <br>(Price %)</th>
<th>MACD<br>Crossing</th>
</tr>
 </thead>
  <%while(rs.next()){ %>
 <tr class="content" align="right">
   <td align="left">
		<a href="sharedet.jsp?type=SPOT&&scrip=<%=rs.getString("CODE")%>" target="_blank" style="font-size: 9pt; color: #990000 ;font-weight: normal" > 
		<%=rs.getString("CODE")%></a>
	</td>
	
	<td><%=decf.format(rs.getFloat("CUR_PRICE"))%></td>

          <% if (rs.getFloat("PRICE_CHANGE_PER") >=0){ %> 
							<td class="contentUp"><%=decf.format(rs.getFloat("PRICE_CHANGE_PER"))%></td>
				<% } else { %> 
							<td class="contentDown"> <%=decf.format(rs.getFloat("PRICE_CHANGE_PER"))%></td>
				<%}%>
			
        <td><%=decf.format(rs.getFloat("DEL_QTY_CHG_PER"))%></td>
        <td><%=decf.format(rs.getFloat("DEL_20DMA_CHG_PER"))%></td>	
		<td><%=decf.format(rs.getFloat("TOTTRDQTY_CHANGE_PER"))%></td>
		<td><%=decf.format(rs.getFloat("DEL_DIFF_PER"))%></td>
	<td><%=decf.format(rs.getFloat("OI_CHG_PER"))%></td>
	<td><%=decf.format(rs.getFloat("DEL_PER_07_CHG_PER"))%></td>
        <td><%=decf.format(rs.getFloat("DEL_PER"))%></td>
        <td><%=decf.format(rs.getFloat("P1_DEL_PER"))%></td> 
      
         <td><%=decf.format(rs.getFloat("P1_DEL_QTY_CHG_PER"))%></td>
        <td><%=decf.format(rs.getFloat("P2_DEL_QTY_CHG_PER"))%></td>
        
        <td><%=decf.format(rs.getFloat("PRICE_20DMA"))%></td>
        <td><%=decf.format(rs.getFloat("PRICE_20DMA_CHG_PER"))%></td>
        <td><%=decf.format(rs.getFloat("PRICE_GAP_PER"))%></td>
        <td align="center"><%=rs.getString("MACD_CROSS")%></td>
        
</tr>
	<%}%>
 </table>
</td>
</tr>





</body>
</html>
