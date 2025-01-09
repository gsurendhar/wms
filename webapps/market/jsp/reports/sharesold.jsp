<%@ page import ="oracle.jdbc.driver.*"%>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>



<script>
function parameter(){
//var vexchange=document.getElementById("cmbExchange").value
var vgroup=document.getElementById("cmbGroup").value
var vprice=document.getElementById("txtPrice").value
var vqty=document.getElementById("txtQty").value
var vtrdval=document.getElementById("txtTrdval").value
//var vpdays=document.getElementById("txtPdays").value
//var vldays=document.getElementById("txtLdays").value
var vdel=document.getElementById("txtDel").value
//window.location.replace("shares.jsp?vexchange="+vexchange+"&&vprice="+vprice+"&&vqty="+vqty+"&&vtrdval="+vtrdval+"&&vpdays="+vpdays+"&&vldays="+vldays+"&&vdel="+vdel);
//window.location.replace("shares.jsp?vexchange="+vexchange+"&vprice="+vprice+"&vqty="+vqty+"&vtrdval="+vtrdval+"&vpdays="+vpdays+"&vldays="+vldays+"&vdel="+vdel+"&&vgroup="+vgroup);
window.location.replace("shares.jsp?vexchange=NSE&vprice="+vprice+"&vqty="+vqty+"&vtrdval="+vtrdval+"&vdel="+vdel+"&&vgroup="+vgroup);
}

</script>


<!-- added for sorting table --->
<script type="text/javascript" src="../../Script/gs_sortable.js"></script>
<script type="text/javascript">
var TSort_Data = new Array ('my_table', 's', 'i', 'f','f','f','f','f','f','f','f','f','f','f','f','f','f','f');
var TSort_Classes = new Array ('row1', 'row2');
var TSort_Initial = 1;
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
%>

<%
String vprice=request.getParameter("vprice");
String vqty=request.getParameter("vqty");
String vpdays=request.getParameter("vpdays");
String vldays=request.getParameter("vldays");
String vdel=request.getParameter("vdel");
String vtrdval=request.getParameter("vtrdval");
String vscrip=request.getParameter("vscrip");
String vgroup=request.getParameter("vgroup");

//String vexchange=request.getParameter("vexchange");
String vexchange="NSE";
if (vgroup==null){vgroup="1";}



if (vscrip==null){vscrip="0";}
if (vexchange==null){vexchange="NSE";}

if (vpdays==null){vpdays="1";}
if (vldays==null){vldays="1";}
if (vdel==null){vdel="-99";}
if (vqty==null){vqty="1";}
if (vtrdval==null){vtrdval="500";}
if (vprice==null){vprice="10";}
if (vgroup==null){vgroup="0";}

String vfdate=request.getParameter("vfdate");
String vtdate=request.getParameter("vtdate");

Integer rcount=1;


DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());


if(vfdate == null){
 vfdate=formattedDate;
 vtdate=formattedDate;
}

String vcon="";
if ("0".equalsIgnoreCase(vgroup)){
	vcon= " and 1=1 ";
}
else {
	vcon=" and nse.code in (select CODE from code_group where group_id='"+vgroup+"')" ;
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
</head>
<body>
<table width="100%" border="0" class="border" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
<tr><td class="Blue-content" colspan=2 align="left">
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
<td class="Blue-content"><b>Share Price:</b><input type=text id=txtPrice name=txtPrice  class="content style1" value="<%=vprice%>" size="4">and above</td></tr>
<tr><td class="Blue-content"><b>Traded Qty( Thousands):</b><input type=text id=txtQty name=txtQty  class="content style1" value="<%=vqty%>" size="8">and above</td>
<td class="Blue-content"><b>Traded Value:(Lacs)</b><input type=text id=txtTrdval name=txtTrdval  class="content style1" value="<%=vtrdval%>" size="8">and above</td>
<td class="Blue-content"><b>Delivery % Increase:</b><input type=text id=txtDel name=txtDel  class="content style1" value="<%=vdel%>" size="2"></td></tr>
<tr><td colspan="3" align="center"><input class="content style1"  type="submit" value="check" onClick="parameter()"></td></tr>
</table>


<%
query= "SELECT nse.code,cur_price,prev_price,cur_delivery,cur_delivery_per,cur_traded_qty, prev_delivery,prev_delivery_per,prev_traded_qty,";
query=query+" cur_fut_price,prev_fut_price,mpl.limit,open_int,round((open_int/mpl.limit)*100,2) limit_per,";
query=query+" bse_cur_delivery_per,bse_prev_delivery_per,bse_diff_per,bse_cur_traded_qty,bse_prev_traded_qty,bse_traded_change_per, ";
query=query+" chg_in_oi,oi_chg_per,round(((cur_price-prev_price)/prev_price)*100,2) price_change_per, ";
query=query+" round(((cur_traded_qty-prev_traded_qty)/prev_traded_qty)*100,2) traded_change_per,";
query=query+" round(((cur_delivery-prev_delivery)/prev_delivery)*100,2) del_qty_per,";
query=query+" round(((cur_delivery_per-prev_delivery_per)/prev_delivery_per)*100,2) diff_per,";
query=query+" round(((bse_cur_delivery_per-bse_prev_delivery_per)/bse_prev_delivery_per)*100,2) bse_diff_per, ";
query=query+" round(((cur_fut_price - cur_price)*100/cur_price),2) coc_per,";
query=query+" round(((cur_fut_price - cur_price)*100/cur_price),2)-round(((prev_fut_price - prev_price)*100/prev_price),2) coc_chg_per FROM ";
query=query+" (SELECT a.code,cur_delivery,cur_delivery_per,cur_traded_qty, prev_delivery,prev_delivery_per,prev_traded_qty, cur_fut_price,prev_fut_price ,cur_price,prev_price FROM ";
query=query+" ( SELECT CODE,close_price cur_price,DELIVERY cur_DELIVERY,ROUND((DELIVERY/TTL_TRD_QNTY)*100,2) cur_DELIVERY_PER,TTL_TRD_QNTY cur_TTL_TRD_QTY,";
query=query+" ROUND(TTL_TRD_QNTY/1000,2) cur_TRADED_QTY,TURNOVER cur_turnover";
query=query+" FROM NSE_BHAV WHERE series='EQ'  AND EOD_DATE = (SELECT MAX(EOD_DATE) FROM EOD_DATE) ) A,";
query=query+" (SELECT CODE,close_price prev_price,DELIVERY prev_DELIVERY,ROUND((DELIVERY/TTL_TRD_QNTY)*100,2) prev_DELIVERY_PER,TTL_TRD_QNTY prev_TTL_TRD_QTY,";
query=query+" ROUND(TTL_TRD_QNTY/1000,2) prev_TRADED_QTY FROM NSE_BHAV WHERE series='EQ' ";
query=query+" AND EOD_DATE = (SELECT MAX(EOD_DATE) FROM EOD_DATE WHERE eod_Date != (SELECT MAX(EOD_DATE) FROM EOD_DATE))) B,";
query=query+" (SELECT a.EOD_DATE,a.CODE,a.CLOSE cur_fut_price FROM nse_fo a,";
query=query+" (SELECT EOD_DATE,CODE,option_type,MIN(EXPIRY_DATE) expiry_date FROM NSE_FO WHERE eod_date = (SELECT MAX(EOD_DATE) FROM eod_date) ";
query=query+"  GROUP BY EOD_DATE,CODE,option_type) b";
query=query+"  WHERE a.code=b.code AND a.eod_date=b.eod_date AND a.expiry_date=b.expiry_date AND a.option_type=b.option_type AND  a.option_type='XX') cur_fo, ";
query=query+" (SELECT a.EOD_DATE,a.CODE,a.CLOSE prev_fut_price FROM nse_fo a,";
query=query+" (SELECT EOD_DATE,CODE,option_type,MIN(EXPIRY_DATE) expiry_date FROM NSE_FO";
query=query+"  WHERE eod_date = (SELECT MAX(EOD_DATE) FROM EOD_DATE WHERE eod_Date != (SELECT MAX(EOD_DATE) FROM EOD_DATE))";
query=query+"  GROUP BY EOD_DATE,CODE,option_type) b";
query=query+"  WHERE a.code=b.code AND a.eod_date=b.eod_date AND a.expiry_date=b.expiry_date AND a.option_type=b.option_type";
query=query+"  AND  a.option_type='XX') prev_fo WHERE a.code=b.code AND a.code=cur_fo.code(+) AND a.code=prev_fo.code(+)";
query=query+"  AND ((cur_delivery_per-prev_delivery_per)/prev_delivery_per)*100 >= '"+vdel+"'";
query=query+"  AND (cur_TTL_TRD_QTY/1000) >= "+vqty+" AND round(cur_TURNOVER/100000,2) >= "+vtrdval+" AND cur_price>="+vprice+" AND cur_price!=0";
query=query+"  AND cur_TTL_TRD_QTY !=0 AND prev_delivery_per !=0)NSE,  ";
query=query+" (SELECT NSE_CODE CODE,bse_cur_delivery_per,bse_prev_delivery_per,";
query=query+"  ROUND((bse_cur_delivery_per-bse_prev_delivery_per)*100/bse_prev_delivery_per,2) bse_diff_per,bse_cur_traded_qty,bse_prev_traded_qty,";
query=query+"  ROUND((bse_cur_traded_qty-bse_prev_traded_qty)*100/bse_prev_traded_qty,2) bse_traded_change_per  FROM ";
query=query+"  (SELECT code,ROUND(delivery/1000,2) bse_cur_delivery, ROUND(DELIVERY*100/TTL_TRD_QNTY,2)  bse_cur_delivery_per,";
query=query+" ROUND(TTL_TRD_QNTY/1000,2) bse_cur_traded_qty  FROM bse_bhav WHERE eod_date=(SELECT MAX(eod_date) FROM eod_date) AND ROUND(TTL_TRD_QNTY/1000,2)>0) a,";
query=query+" (SELECT code,ROUND(delivery/1000,2) bse_prev_delivery, ROUND(DELIVERY*100/TTL_TRD_QNTY,2)  bse_prev_delivery_per,";
query=query+" ROUND(TTL_TRD_QNTY/1000,2) bse_prev_traded_qty FROM bse_bhav WHERE eod_date=";
query=query+" (SELECT MAX(eod_date) FROM eod_date WHERE eod_date != (SELECT MAX(eod_date) FROM eod_date)) AND ROUND(TTL_TRD_QNTY/1000,2)>0 and ROUND(delivery/1000,2)!=0 ) b,scrip_code c";
query=query+" WHERE a.code=b.code  AND a.code=c.bse_code) BSE,  ";
query=query+" (SELECT EOD_DATE,CODE, OPEN_INT, CHG_IN_OI,OI_CHG_PER,OPT_PUTS_OPEN_INT,OPT_PUTS_CHG_IN_OI,OPT_PUTS_OI_CHG_PER,OPT_CALLS_OPEN_INT,";
query=query+" OPT_CALLS_CHG_IN_OI,OPT_CALLS_OI_CHG_PER FROM vw_nse_Fo WHERE EOD_DATE=(SELECT MAX(EOD_DATE) FROM EOD_DATE)) FO";
query=query+" ,(select nse_code code,limit  from mpl where eod_date=(select max(eod_date) from mpl))mpl  ";
query=query+" WHERE nse.code=bse.code(+) AND bse.code=FO.code(+) and nse.code=mpl.code(+)"+vcon;
out.println(query);
rs=stmt.executeQuery(query);
%>

<table width="100%" border="0" class="border" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
<tr><td valign=top>

<table width="100%" border="1" id="my_table" cellpadding="2" cellspacing="0" id="stretch" >
                <thead>
                        <tr class="Blue-content" align="center">
                        <td width="5%">Code</td><td><b>NSE<BR>Close<br>Price</b></td>
                        <td><b>NSE<BR>Price<br>Change<br>%</b></td>
                        <td>NSE<BR>Del %</td>
                        <td>BSE<BR>Del %</td>
                        <td>OI <br>Change <br> %</td>
                        <td>COC<br>%</td>
			   <td>COC <br>Change<br>%</td>
                        <td>NSE<BR>Past<br>Del<br>%</td><td>NSE<BR>Latest<br>Del<br>%</td>
                        <td>BSE<BR>Past<br>Del<br>%</td><td>BSE<BR>Latest<br>Del<br>%</td>
                        <td>OI <br>Close</td>
	<!--             <td><br>OI<br>Limit</td>             -->
			   <td>OI<br>% To<br>Limit</td>
                        <td>NSE QTY <br>(K)</td>
       <!--             <td>NSE<BR>Traded QTY Change(%)</td>   -->
			   <td>NSE<BR>Del QTY<br>Change(%)</td>
                          </tr>
                </thead>

		  <%   while(rs.next()){ %>
                	<tr class="content" align="right">
                        <td align="left"><a href="sharedet.jsp?scrip=<%=rs.getString("CODE")%>&&vexchange=<%=vexchange%>" target="_blank" style="font-size: 9pt; color: #990000 ;font-weight: normal" > <%=rs.getString("CODE")%></a></td>
			   <td><%=rs.getString("CUR_PRICE")%></td>
                        <td><%=rs.getString("PRICE_CHANGE_PER")%></td>
                        <td><%=rs.getString("DIFF_PER")%></td>
                        <td><%=rs.getString("BSE_DIFF_PER")%></td>
                        <td><%=rs.getString("OI_CHG_PER")%></td>
                        <td><%=rs.getString("COC_PER")%></td>
  			   <td><%=rs.getString("COC_CHG_PER")%></td>
                        <td><%=rs.getString("prev_delivery_per")%>
                        <td><%=rs.getString("cur_delivery_per")%></td>
			   <td><%=rs.getString("bse_prev_delivery_per")%></td> 
                        <td><%=rs.getString("bse_cur_delivery_per")%></td>
			   <td><%=rs.getString("OPEN_INT")%></td>
			   <td><%=rs.getString("LIMIT_PER")%></td>
                        <td><%=rs.getString("cur_traded_qty")%></td>
  			  <td><%=rs.getString("del_qty_per")%></td>
               </tr>
			<%}%>

<% 
query ="select cur.code,cur.eod_date,cur.close_price,cur.price_change_per,cur.open_int,cur.chg_in_oi,cur.oi_chg_per,cur.coc_per";
query= query+" ,round(((cur.fut_close_price - cur.close_price)*100/cur.close_price),2)-round(((prev.fut_close_price - prev.close_price)*100/prev.close_price),2) coc_chg_per";
query= query+" ,cur.nse_qty  from (select n.eod_date,n.code,n.close close_price,change_per PRICE_CHANGE_PER,coalesce(fo.OPEN_INT,0) open_int,coalesce(fo.CHG_IN_OI,0) CHG_IN_OI,";
query= query+" COALESCE(OI_CHG_PER,0) OI_CHG_PER,round(((fut_close_price-n.close)*100/n.close),2) coc_per, n.volume nse_qty, fut_close_price from ";
query= query+" (select eod_date,decode( code,'CNX Nifty','NIFTY','CNX Bank','BANKNIFTY','-') code,open,close,round(volume/100000,2) volume,turnover,change_per";
query= query+" from nse_ind where code in ('CNX Nifty','CNX Bank')) N,";
query= query+" (select EOD_DATE,CODE,CLOSE fut_close_price from nse_Fo where exists (select 1 from ";
query= query+" (select EOD_DATE,CODE,min(EXPIRY_DATE) expiry_date from NSE_FO where OPTION_TYPE='XX' AND EOD_DATE >= to_char(sysdate-90,'YYYYMMDD') group by EOD_DATE,CODE) a ";
query= query+" where a.code=nse_fo.code and a.eod_date=nse_fo.eod_date and a.expiry_date=nse_fo.expiry_date) ";
query= query+" and OPTION_TYPE='XX') fut_close ,vw_nse_fo fo";
query= query+" where n.code=fut_close.code(+) and n.eod_date=fut_close.eod_date(+)";
query= query+" and n.code=fo.code(+) and n.eod_date=fo.eod_date(+)";
query= query+" and n.eod_date=(select max(eod_date) from eod_date) ) CUR,";
query= query+" (select n.eod_date,n.code,n.close close_price,change_per PRICE_CHANGE_PER,coalesce(fo.OPEN_INT,0) open_int,coalesce(fo.CHG_IN_OI,0) CHG_IN_OI,";
query= query+" COALESCE(OI_CHG_PER,0) OI_CHG_PER, round(((fut_close_price-n.close)*100/n.close),2) coc_per,n.volume nse_qty,fut_close_price from ";
query= query+" (select eod_date,decode( code,'CNX Nifty','NIFTY','CNX Bank','BANKNIFTY','-') code,open,close,round(volume/100000,2) volume,turnover,change_per";
query= query+" from nse_ind where code in ('CNX Nifty','CNX Bank')) N,";
query= query+" (select EOD_DATE,CODE,CLOSE fut_close_price from nse_Fo where exists (select 1 from ";
query= query+" (select EOD_DATE,CODE,min(EXPIRY_DATE) expiry_date from NSE_FO where OPTION_TYPE='XX' AND EOD_DATE >= to_char(sysdate-90,'YYYYMMDD') group by EOD_DATE,CODE) a ";
query= query+" where a.code=nse_fo.code and a.eod_date=nse_fo.eod_date and a.expiry_date=nse_fo.expiry_date) and OPTION_TYPE='XX') fut_close ,vw_nse_fo fo ";
query= query+" where n.code=fut_close.code(+) and n.eod_date=fut_close.eod_date(+) and n.code=fo.code(+) and n.eod_date=fo.eod_date(+)";
query= query+" and n.eod_date=(select max(eod_date) from eod_date where eod_date != (select max(eod_date) from eod_date) )) PREV where cur.code=prev.code";
out.println(query);
			rs=stmt.executeQuery(query);
			 while(rs.next()){ %>
                	<tr class="content" align="right">
                        <td align="left"><a href="sharedet.jsp?scrip=<%=rs.getString("CODE")%>&&vexchange=<%=vexchange%>" target="_blank" style="font-size: 9pt; color: #990000 ;font-weight: normal" > <%=rs.getString("CODE")%></a></td>
			   <td><%=rs.getString("close_price")%></td>
                        <td><%=rs.getString("PRICE_CHANGE_PER")%></td>
                        <td>-</td>
                        <td>-</td>
                        <td><%=rs.getString("OI_CHG_PER")%></td>
                        <td><%=rs.getString("COC_PER")%></td>
			   <td><%=rs.getString("COC_CHG_PER")%></td> 
                        <td>-</td><td>-</td>
                        <td>-</td><td>-</td>
                        <td><%=rs.getString("OPEN_INT")%></td>
<!--			   <td>0</td> -->
			   <td>-</td>
                        <td><%=rs.getString("nse_qty")%></td>
			<td>-</td>  
              </tr>
			<%}%>
 </table>

</td>


<%
query1= "select * from ";
query1= query1+" (select to_char(to_date(day,'YYYYMMDD'),'DD/MM/YY') RDATE,day,sum(IF_CONTRACT_BUY) IF_CONTRACT_BUY ,sum(IF_BUY_AMOUNT) IF_BUY_AMOUNT ,sum(IF_SELL_AMOUNT) IF_SELL_AMOUNT,";
query1= query1+" sum(IF_BUY_AMOUNT)-sum(IF_SELL_AMOUNT) IF_NET, ";
query1= query1+" sum(IF_OI_CONTRACTS) IF_OI_CONTRACTS,sum(SF_CONTRACT_BUY) SF_CONTRACT_BUY ,sum(SF_BUY_AMOUNT) SF_BUY_AMOUNT,sum(SF_SELL_AMOUNT) SF_SELL_AMOUNT,";
query1= query1+" sum(SF_BUY_AMOUNT)-sum(SF_SELL_AMOUNT) SF_NET, ";
query1= query1+" sum(IO_BUY_AMOUNT)-sum(IO_SELL_AMOUNT) IO_NET, ";
query1= query1+" sum(SF_OI_CONTRACTS) SF_OI_CONTRACTS from(";
query1= query1+" select day, Decode(CATEGORY,'INDEX FUTURES',CONTRACTS_BUY,0) IF_CONTRACT_BUY ,";
query1= query1+" Decode(CATEGORY,'INDEX FUTURES',BUY_AMOUNT,0) IF_BUY_AMOUNT ,";
query1= query1+" Decode(CATEGORY,'INDEX FUTURES',SELL_AMOUNT,0) IF_SELL_AMOUNT ,";
query1= query1+" Decode(CATEGORY,'INDEX FUTURES',OI_CONTRACTS,0) IF_OI_CONTRACTS ,";
query1= query1+" Decode(CATEGORY,'STOCK FUTURES',CONTRACTS_BUY,0) SF_CONTRACT_BUY ,";
query1= query1+" Decode(CATEGORY,'STOCK FUTURES',BUY_AMOUNT,0) SF_BUY_AMOUNT,";
query1= query1+" Decode(CATEGORY,'STOCK FUTURES',SELL_AMOUNT,0) SF_SELL_AMOUNT, ";
query1= query1+" Decode(CATEGORY,'STOCK FUTURES',OI_CONTRACTS,0) SF_OI_CONTRACTS, ";
query1= query1+" Decode(CATEGORY,'INDEX OPTIONS',BUY_AMOUNT,0) IO_BUY_AMOUNT,";
query1= query1+" Decode(CATEGORY,'INDEX OPTIONS',SELL_AMOUNT,0) IO_SELL_AMOUNT ";
query1= query1+" from fii_fo_daily  where CATEGORY in ('STOCK FUTURES','INDEX FUTURES','INDEX OPTIONS') )group by day) FII_FO,";
query1= query1+" (SELECT day Day1,sell,buy,net ";
query1= query1+"  FROM FII_EQ_DAILY a where CATEGORY='FII' ";
query1= query1+"  and day in(select eod_date from  (select eod_date from eod_date order by eod_date desc)) )FII_EQ ";
query1= query1+"  where fii_fo.day=fii_eq.day1(+) order by day desc ";

//out.println(query1);
rs1=stmt.executeQuery(query1);

%>
<td valign=top>
<table width="100%" border="1" cellpadding="2"  bgcolor="#DBEBFF" cellspacing="0" id="stretch" > 
<tr class="Blue-content" align="center">
<td colspan="5"> FII EQ data </td>
</tr>
<tr class="Blue-content" align="center">
<td>Day</td>
<td>Cash Net</td>
<td>Index FUTURE<BR>Net </td>
<td>Stock FUTURE<BR>Net </td>
<td>Index OPTIONS<BR>Net </td>
</tr>

<% while(rs1.next()){ %>

<% if (rcount==1){ %>
				<tr class="content" align="right" bgcolor="#FFFFFF">
<% rcount=0;
	} else { %>
				<tr class="content" align="right" bgcolor="#DBEBFF">
<% rcount=1;} %>
<td><%=rs1.getString("RDATE")%></td>
<td><%=rs1.getDouble("Net")%></td>
<td><%=rs1.getDouble("IF_NET")%></td>
<td><%=rs1.getDouble("SF_NET")%></td>
<td><%=rs1.getDouble("IO_NET")%></td>
</tr>
<%}%>
</table>
</td>
</tr>

</body>
</html>
