<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>

<%@ page import="java.io.*" %>
<%@ page  import="java.awt.*" %>
<%@ page session = "true" %>

<script>
function parameter(){
var vtchg=document.getElementById("cmbTchg").value
var vgroup=document.getElementById("cmbGroup").value
window.location.replace("intradayfutures.jsp?vtchg="+vtchg+"&&vgroup="+vgroup);
}
</script>




<!-- added for sorting table --->
<script type="text/javascript" src="../../Script/gs_sortable.js"></script>
<script type="text/javascript">
var TSort_Data = new Array ('my_table', 's', 's', 's','f','f','f','f','f','f','f','f','f');
var TSort_Classes = new Array ('row1', 'row2');
var TSort_Initial = '1D,10D';
var TSort_Cookie = 'sortable_table';
tsRegister();
</script>


<%!
Connection con=null;
ResultSet rs=null;
ResultSet rs1=null;
Statement stmt=null;
String query="";
String e;
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


Integer rcount=1;

String vTchg = request.getParameter("vtchg");
if (vTchg == null){vTchg ="5";}
//out.println(vTchg);

String vgroup=request.getParameter("vgroup");
if (vgroup==null){vgroup="0";}
//out.println(vgroup);

String vcon="";
if ("0".equalsIgnoreCase(vgroup)){
	vcon= " ";
}
else {
	vcon=" where sname in ('NIFTY','BANKNIFTY') or sname in (select CODE from code_group where group_id='"+vgroup+"')" ;
	}


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
<% response.setIntHeader("Refresh", 140); %>



<table width="100%" border="0" cellpadding="1" VALIGN=TOP align="left">
<tr>
<td class="Blue-content"  align="left">Time Interval:
<select id="cmbTchg" onchange="parameter()" class="content style1" size="0">

<%   if ("1".equalsIgnoreCase(vTchg)) { %> <option value="1" selected disabled >1</option> <% } else {%> <option value="1">1</option>
<% } if ("2".equalsIgnoreCase(vTchg)) { %> <option value="2"  selected disabled>2</option> <% } else {%> <option value="2">2</option>
<% } if ("3".equalsIgnoreCase(vTchg)) { %> <option value="3"  selected disabled>3</option> <% } else {%> <option value="3">3</option>
<% } if ("4".equalsIgnoreCase(vTchg)) { %> <option value="4"  selected disabled>4</option> <% } else {%> <option value="4">4</option>
<% } if ("5".equalsIgnoreCase(vTchg)) { %> <option value="5"  selected disabled>5</option> <% } else {%> <option value="5">5</option>
<% } if ("10".equalsIgnoreCase(vTchg)) { %> <option value="10"  selected disabled>10</option> <% } else {%> <option value="10">10</option>
<% } if ("30".equalsIgnoreCase(vTchg)) { %> <option value="30"  selected disabled>30</option> <% } else {%> <option value="30">30</option>
<% } if ("60".equalsIgnoreCase(vTchg)) { %> <option value="60"  selected disabled>60</option> <% } else {%> <option value="60">60</option>

<%} %>

</select>
</td>
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
</tr>

<tr ><td valign=top align="center" colspan="2">

<table  border="1" id="my_table"  cellpadding="2" cellspacing="0" align="left" >
 <thead>
 	<tr class="Blue-content" align="center">
	<td>Time</td><td>Exchange</td><td>Scrip</td>
	<td>Fut.Price</td><td>Spot Price</td><td>COC %</td><td>OI %</td>
<td>COC <br>chg %</td>
<td>Volume<br>Rise %</td>

<td>Vol Rise <br> Delta %</td>
<td>Price Rise <br>Delta</td>
<td>Price <br>Rise %</td>
	</tr>
</thead>

<% 
query= " select intra.*,";
query=query+" (vol_rise_per-substr(chg_per,instr(chg_per,';',1,1)+1,instr(chg_per,';',1,2)-instr(chg_per,';',1,1)-1)) vol_rise_delta, ";
query=query+" (per_change-substr(chg_per,instr(chg_per,';',1,2)+1,instr(chg_per,';',1,3)-instr(chg_per,';',1,2)-1)) price_change_delta ";
query=query+" from ( ";
query=query+" select to_char(i.LAST_TRADED_DATE,'hh24') hh,to_char(i.LAST_TRADED_DATE,'mi') mi,to_char(i.LAST_TRADED_DATE,'dd') dd, ";
query=query+" to_char(i.LAST_TRADED_DATE,'mm') mm,to_char(i.LAST_TRADED_DATE,'yyyy') yyyy,i.*,";
query=query+" (case when substr(scrip_name,1,instr(scrip_name,' ')-1) is null then scrip_name else substr(scrip_name,1,instr(scrip_name,' ')-1) end) sname,";
query=query+" round(to_char(i.LAST_TRADED_DATE,'hh24')+(to_char(i.LAST_TRADED_DATE,'mi')/60),2) time, ";
query=query+" coc_per-(select coc_per as prev_coc_per from intraday y where y.scrip_code=i.scrip_code ";
query=query+"    and last_traded_date = (select min(last_traded_date) from intraday x where x.scrip_code=i.scrip_code and last_traded_date >= trunc(i.last_traded_date))";
query=query+"      ) coc_chg_per, (";
query=query+"      select to_char(coc_per)||';'||to_char(vol_rise_per)||';'||to_char(per_change)||';'||to_Char(LAST_TRADED_DATE,'HH24:MI') as prev ";
query=query+"      from intraday y where y.scrip_code=i.scrip_code ";
query=query+"      and LAST_TRADED_DATE = (select max(LAST_TRADED_DATE) from intraday x where x.scrip_code=i.scrip_code ";
query=query+"      and last_traded_date >= trunc(i.LAST_TRADED_DATE) and LAST_TRADED_DATE < i.LAST_TRADED_DATE-"+vTchg+"/1440 )) chg_per ";
query=query+" from intraday i , (select scrip_code,max(last_traded_date) last_traded_date from intraday";
query=query+" where last_traded_date >= trunc(sysdate-4) group by scrip_code) t";
query=query+" where i.scrip_code=t.scrip_code and i.last_traded_date>= (select trunc(max(last_traded_date)) from intraday) and i.last_traded_date=t.last_traded_date) intra "+vcon ;
query=query+" order by scrip_name  ";                                                                                                                  

//out.println(query);
rs=stmt.executeQuery(query);

while(rs.next()){  %>
<tr class="content" align="right" >
<td><%=rs.getString("dd")%>/<%=rs.getString("mm")%>/<%=rs.getString("yyyy")%>  <%=rs.getString("hh")%>:<%=rs.getString("mi")%></td>
<td align="center"><%=rs.getString("exchange")%></td>
<td align="left"><a href="intradaydet.jsp?vcode=<%=rs.getString("scrip_code")%>&&vdate=<%=rs.getString("dd")%>/<%=rs.getString("mm")%>/<%=rs.getString("yyyy")%>&&spot=<%=rs.getString("UNDERLYING")%> " target="_blank" style="font-size: 9pt; color: #990000 ;font-weight: normal" ><%=rs.getString("scrip_name")%></td>
<td><%=rs.getFloat("CURRENT_PRICE")%></td><td><%=rs.getFloat("UNDERLYING")%></td>
<td><%=rs.getFloat("COC_PER")%></td>
<td><%=rs.getFloat("OI_DIFFERENCE_PERCENTAGE")%></td>
<td><%=rs.getFloat("COC_CHG_PER")%></td>
<td><%=rs.getFloat("VOL_RISE_PER")%></td>

<td><%=rs.getFloat("vol_rise_delta")%></td>
<td><%=rs.getFloat("price_change_delta")%></td>
<td><%=rs.getFloat("PER_CHANGE")%></td>


</tr>

<% }%>

</table>
</td>
</tr>

</body>
</html>


