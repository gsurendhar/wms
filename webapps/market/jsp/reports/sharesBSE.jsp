<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>



<script>
function parameter(){
var vprice=document.getElementById("txtPrice").value
var vtrdval=document.getElementById("txtTrdval").value
var vdel=document.getElementById("txtDel").value
var vcdel=document.getElementById("cmbCday").value
var vpchg=document.getElementById("cmbPchg").value
var vnsedel=document.getElementById("cmbNSEdel").value;
var vTchg =document.getElementById("cmbTchg").value;
var vTqty =document.getElementById("cmbTrdqty").value;
var vgap=document.getElementById("cmbGAP").value;

window.location.replace("sharesBSE.jsp?vprice="+vprice+"&&vGAP="+vgap+"&&vdel="+vdel+"&&vtrdval="+vtrdval+"&&cdel="+vcdel+"&&pchg="+vpchg+"&&nsedel="+vnsedel+"&&vTchg="+vTchg+"&&tqty="+vTqty);

}


function parameter_day(){
var vday=document.getElementById("cmbDay").value
window.location.replace("sharesBSE.jsp?vday="+vday);
}

</script>
<!-- added for sorting table --->
<script type="text/javascript" src="../../Script/gs_sortable.js"> </script>
<script type="text/javascript">
var TSort_Data = new Array ('my_table', 's','f','f','f','f','f','f','f','f','f','f','f');
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
String vgroup=request.getParameter("vgroup");
String vcdel=request.getParameter("cdel");
String vpchg=request.getParameter("pchg");


String vTrend=request.getParameter("pTrend");
String vtqty=request.getParameter("tqty");
String volchg20DMA = request.getParameter("Vol20D");
String vnsedel=request.getParameter("nsedel");

String voichg=request.getParameter("oichg");
String vcocchg=request.getParameter("cocchg");
String vrule=request.getParameter("vrule");
String vp20DMAc=request.getParameter("p20DMAc");
String v20DMA=request.getParameter("c20dma");


String vGAP=request.getParameter("vGAP");
if (vGAP==null){vGAP="U";}

String vdiv=request.getParameter("vdiv");
if (vdiv==null){vdiv="A";}


String v20c=request.getParameter("v20c");
if (v20c==null){v20c="A";}


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


if (vtrdval==null){vtrdval="300";}
if (vprice==null){vprice="5";}
if (vgroup==null){vgroup="0";}

if (vTrend==null){vTrend="U";}

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
<table width="50%" border="0" class="border" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
<tr><td valign=top>
<table width="100%" border="1" class="border" cellpadding="2" cellspacing="0"  bgcolor="#DBEBFF" VALIGN=TOP>
<tr class="Blue-content">

<td class="Blue-content"  align="left" colspan="1">
 Day:
<select id="cmbDay" onchange="parameter_day()" class="content style1" size="0" style="width: 80px;">
<option value="0">--Select--</option>
<%
rs1=stmt.executeQuery("select day from eod order by 1 desc limit 0,10");
while(rs1.next()){
%>
<option value="<%=rs1.getString("day")%>" ><%=rs1.getString("day")%></option>
<% if(rs1.getString("day").equals(vday)){%>
<option value="<%=vday%>" disabled selected ><%=rs1.getString("day")%></option>
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


</tr>


<tr class="Blue-content">
<td class="Blue-content"><b>Share Price:</b><input type=text id=txtPrice name=txtPrice  class="content style1" value="<%=vprice%>" size="4">and above</td>
<td class="Blue-content"><b>Traded Value:(Lacs)</b><input type=text id=txtTrdval name=txtTrdval  class="content style1" value="<%=vtrdval%>" size="4">and above
<input class="content style1"  type="submit" value="Go" onClick="parameter()">
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
<td ><b>Del % </b><input type=text id=txtDel name=txtDel  class="content style1" value="<%=vdel%>" size="2"/></td>
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

</tr>

</table>


<%

query ="select * from (select cur.day,cur.ISIN_CODE isin ,sc.NSE_CODE code,cur.code bse_code,cur.cur_price,cur.price_change_per,cur.del_qty_per,round((cur.cur_traded_qty-cur.prev_traded_qty)*100/cur.prev_traded_qty,2) traded_qty_chg,";
query +=" round((cur.del_qty_per-prev1.del_qty_per)*100/prev1.del_qty_per,2) del_qty_diff_per,";
query +=" cur.diff_per del_diff_per,cur.price_20DMA,cur.vol_20DMA,round((cur.open-cur.prevclose)*100/cur.prevclose,2) gap, ";
query +=" prev1.del_qty_per prev1_del_qty_per,prev2.del_qty_per prev2_del_qty_per,";
query +=" round((cur.price_20DMA-prev1.price_20DMA)*100/prev1.price_20DMA,2) PRICE_CHG_20DMA, prev1.cur_price PREV1_CLOSE , prev2.cur_price PREV2_CLOSE,prev3.cur_price PREV3_CLOSE,cur.TURNOVER_LAKH from";
query +=" (select max(if(id=1,day,'2000-01-01')) prev1_date,max(if(id=2,day,'2000-01-01')) prev2_date,max(if(id=3,day,'2000-01-01')) prev3_date from(";
query +=" select @rownum :=@rownum+1 id,day from eod , (select @rownum:=0)x where day < '"+vday+"' order by day desc limit 0,3)x ) eod";
query +=" inner join BSE_RESEARCH_PAGE cur  on  cur.day=  '"+vday+"'";
query +=" inner join BSE_RESEARCH_PAGE prev1 on prev1.day=eod.prev1_date  and cur.code=prev1.code and cur.type=prev1.type";
query +=" inner join BSE_RESEARCH_PAGE prev2 on prev2.day=eod.prev2_date  and cur.code=prev2.code and cur.type=prev2.type";
query +=" inner join BSE_RESEARCH_PAGE prev3 on prev3.day=eod.prev3_date  and cur.code=prev3.code and cur.type=prev3.type ";
query +=" inner join  scrip_code sc on sc.ISIN=cur.ISIN_CODE ) x";
query +=" where  CUR_PRICE >="+vprice+" and del_qty_per >= "+vdel+" and TURNOVER_LAKH >="+vtrdval+"  ";

if ("R1".equalsIgnoreCase(vcdel)){query +=" and del_qty_per >=0";}
if ("F1".equalsIgnoreCase(vcdel)){query +=" and del_qty_per <0";}
if ("R2".equalsIgnoreCase(vcdel)){query +=" and del_qty_per >=0 and prev1_del_qty_per >=0";}
if ("F2".equalsIgnoreCase(vcdel)){query +=" and del_qty_per < 0 and prev1_del_qty_per < 0";}
if ("R3".equalsIgnoreCase(vcdel)){query +=" and del_qty_per >=0 and prev1_del_qty_per >=0 and prev2_del_qty_per >=0";}
if ("F3".equalsIgnoreCase(vcdel)){query +=" and del_qty_per < 0 and prev1_del_qty_per < 0 and prev2_del_qty_per< 0";}

if ("R1".equalsIgnoreCase(vpchg)){query +=" and CUR_PRICE >= PREV1_CLOSE";}
if ("F1".equalsIgnoreCase(vpchg)){query +=" and CUR_PRICE < PREV1_CLOSE";}
if ("R2".equalsIgnoreCase(vpchg)){query +=" and CUR_PRICE >= PREV1_CLOSE and PREV1_CLOSE >= PREV2_CLOSE";}
if ("F2".equalsIgnoreCase(vpchg)){query +=" and CUR_PRICE < PREV1_CLOSE and PREV1_CLOSE < PREV2_CLOSE";}
if ("R3".equalsIgnoreCase(vpchg)){query +=" and CUR_PRICE >= PREV1_CLOSE and PREV1_CLOSE >= PREV2_CLOSE and prev2_close >= prev3_close ";}
if ("F3".equalsIgnoreCase(vpchg)){query +=" and CUR_PRICE < PREV1_CLOSE and PREV1_CLOSE < PREV2_CLOSE and prev2_close < prev3_close";}

if ("R1".equalsIgnoreCase(vnsedel)){query +=" and DIFF_PER >=0";}
if ("F1".equalsIgnoreCase(vnsedel)){query +=" and DIFF_PER < 0";}
if ("R2".equalsIgnoreCase(vnsedel)){query +=" and DEL_QTY_PER >= PREV1_DEL_QTY_PER";}
if ("F2".equalsIgnoreCase(vnsedel)){query +=" and DEL_QTY_PER < PREV1_DEL_QTY_PER ";}
if ("R3".equalsIgnoreCase(vnsedel)){query +=" and (DEL_QTY_PER >= PREV1_DEL_QTY_PER) and (PREV1_DEL_QTY_PER  >= PREV2_DEL_QTY_PER)";}
if ("F3".equalsIgnoreCase(vnsedel)){query +=" and (DEL_QTY_PER < PREV1_DEL_QTY_PER) and (PREV1_DEL_QTY_PER < PREV2_DEL_QTY_PER )";}

if ("A".equalsIgnoreCase(vtqty)){query +=" and round((cur_traded_qty- prev_traded_qty)*100/prev_traded_qty,2)>=0";}
if ("B".equalsIgnoreCase(vtqty)){query +=" and round((cur_traded_qty- prev_traded_qty)*100/prev_traded_qty,2) < 0";}

if ("R".equalsIgnoreCase(vp20DMAc)){query +=" and PRICE_CHG_20DMA >=0 ";}
if ("F".equalsIgnoreCase(vp20DMAc)){query +=" and PRICE_CHG_20DMA < 0 ";}

if ("R".equalsIgnoreCase(vGAP)){query +=" and GAP > 0 ";}
if ("F".equalsIgnoreCase(vGAP)){query +=" and GAP < 0 ";}


//System.out.println(query);
rs=stmt.executeQuery(query);
%>

<table width="100%" border="1" id="my_table" cellpadding="2" cellspacing="0" id="stretch" >
<thead>
<tr class="Blue-content" align="center">
	<th>Code</th>
	<th>Price</th> <th>Price<br>Chg%</th>
	<th>Turnover<br>(Lakhs)</th>		
			<th>Del QTY<br>Chg%</th>
			<th>Trd. Vol<br>Chg%</th>
			<th>Del Qty<br>Chg%</th>
			<th>Latest<br>Del%<br>(T)</th>
			<th>Past<br>Del%<br>(T-1)</th>
			<th>Past<br>Del%<br>(T-2)</th>
			<th>Diff<br>Del%</th>
<th>Price<br>20DMA<BR>Chg%</th>
<th>GAP <br>(Price %)</th>
	</tr>
         </thead>
		  <%while(rs.next()){ %>
            <tr class="content" align="right">
             <td align="left">
					<a href="sharedetBSE.jsp?type=SPOT&&vTchg=<%=vTchg%>&&scrip=<%=rs.getString("CODE")%>" target="_blank" style="font-size: 9pt; color: #990000 ;font-weight: normal" > 
					<%=rs.getString("CODE")%></a></td>
			<td><%=decf.format(rs.getFloat("CUR_PRICE"))%></td>
                	<% if (rs.getFloat("PRICE_CHANGE_PER") >=0){ %> 
							<td class="contentUp"><%=decf.format(rs.getFloat("PRICE_CHANGE_PER"))%></td>
				<% } else { %> 
							<td class="contentDown"> <%=decf.format(rs.getFloat("PRICE_CHANGE_PER"))%></td>
				<%}%>
			<td><%=rs.getFloat("turnover_lakh")%></td>	
            		<td><%=rs.getString("del_qty_per")%></td>
			<td><%=decf.format(rs.getFloat("traded_qty_chg"))%></td>
			<td><%=decf.format(rs.getFloat("del_diff_per"))%></td>
			<td><%=rs.getString("del_qty_per")%></td>
			<td><%=rs.getString("prev1_del_qty_per")%></td>
			<td><%=rs.getString("prev2_del_qty_per")%></td>
<% if (rs.getFloat("del_qty_diff_per") >=0){ %>
	 <td class="contentUp"><%=decf.format(rs.getFloat("del_qty_diff_per"))%></td>
<% } else { %>
         <td class="contentDown"> <%=decf.format(rs.getFloat("del_qty_diff_per"))%></td>
<%}%>
<td><%=decf.format(rs.getFloat("PRICE_CHG_20DMA"))%></td>
<td><%=decf.format(rs.getFloat("GAP"))%></td>
</td>
      </tr>
	<%}%>
 </table>
</td>
</tr>
</body>
</html>
