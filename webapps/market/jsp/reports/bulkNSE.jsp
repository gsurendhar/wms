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
String vexchange="NSE";

Integer rcount=1;

DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());

	query1 ="select a.*,(buy-sell) BULK_DIFF from (";
	query1 += "select EOD_DATE,CODE,sum(case when TRADE_TYPE='SELL' then QUANTITY else 0 end)/100000 SELL, ";
	query1 += "sum(case when TRADE_TYPE='BUY' then QUANTITY else 0 end)/100000 BUY ";
	query1 += "from nse_bulk where CODE='"+vscrip+"'";
	query1 += "group by EOD_DATE,CODE ) a ";
	query1 += "where SELL-BUY !=0 and ROWNUM<="+vTchg+" order by eod_date";
	


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
window.location.replace("bulkNSE.jsp?scrip="+vscrip+"&&vTchg="+vTchg);
}
</script>

<script>
function search(){
var vscrip= document.getElementById("searchBox").value
var vTchg =document.getElementById("cmbTchg").value
window.location.replace("bulkNSE.jsp?scrip="+vscrip+"&&vTchg="+vTchg);
}
</script>


<script>
	$(document).ready(function() {
		var myArr = [];
	
		$.ajax({
			type: "GET",
			url: "../shares.xml", // change to full path of file on server
			dataType: "xml",
			success: parseXml,
			complete: setupAC,
			failure: function(data) {
				alert("XML File could not be found");
				}
		});
	
		function parseXml(xml)
		{
			//find every query value
			$(xml).find("share").each(function()
			{
				myArr.push($(this).attr("label"));
			});	
		}
		
		function setupAC() {
			$("input#searchBox").autocomplete({
					source: myArr,
					minLength: 1,
					select: function(event, ui) {
						$("input#searchBox").val(ui.item.value);
						$("#searchForm").submit();
					}
			});
		}
	});
</script>

</head>
<body>
<table calss="table" border="0" cellpadding="1" cellspacing="0"   >
<tr>
<td valign=top>	
<table  class="border" border="0" cellpadding="0"  bgcolor="#DBEBFF" VALIGN="TOP">
<tr><td colspan="2" class="Blue-content">BULK Transactions for <B><%=vscrip%> </td></tr>
<tr class="content style1">
	<td class="Blue-content" colspan="1" >
		<input class="content style1" type="text" id="searchBox" name="searchString" size="10" />
	 	<button name="searchKeyword" id="searchKeyword" class="content style1" value="Search" onClick="search()" >Go</button>
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
<input type="hidden" id="txtType" name="txtType" size="10" maxlength="12" value=<%=vtype%>>
</tr>

<tr>
<td valign=top>
	<table width="100%" border="1" cellpadding="2"  bgcolor="#DBEBFF" cellspacing="0" id="stretch" > 

	<tr class="Blue-content" align="center">
	<td>Day</td>
	<td>Buy</td>
	<td>Sell</td>
	<td>Bulk<br>(Lakhs)</td> 
	</tr>
<% 
rs1=stmt1.executeQuery(query1);
while(rs1.next()){

if (rcount==1){ %><tr class="content" align="right" bgcolor="#FFFFFF">
<% rcount=0; } else{ %><tr class="content" align="right" bgcolor="#DBEBFF">
<% rcount=1;} %>
	<td><%=rs1.getString(1)%></td>
	<td><%=decf.format(rs1.getFloat(3))%></td>
	<td><%=decf.format(rs1.getFloat(4))%></td>
	<td><%=decf.format(rs1.getFloat(5))%></td>
</tr> 
<%  } %>
</table>
</td>
<td valign=top colspan="2">
	<table width="100%" border="1" cellpadding="2"  bgcolor="#DBEBFF" cellspacing="0" id="stretch" > 

	<tr class="Blue-content" align="center">
	<td rowspan="1">Day</td>
	<td rowspan="1">Client</td>
	<td rowspan="1">Buy</td>
	<td rowspan="1">Sell</td>
	<td>Bulk<br>(Lakhs)</td> 

</tr>
<% 
	query="select a.*,(buy-sell) BULK_DIFF from (";
	query += "select EOD_DATE,CODE,CLIENT_NAME,sum(case when TRADE_TYPE='SELL' then QUANTITY else 0 end)/100000 SELL, ";
	query += "sum(case when TRADE_TYPE='BUY' then QUANTITY else 0 end)/100000 BUY ";
	query += "from nse_bulk where CODE='"+vscrip+"'";
	query += "group by EOD_DATE,CODE,CLIENT_NAME ) a ";
	query += "where SELL-BUY !=0 and ROWNUM<="+vTchg+" order by eod_date,CLIENT_NAME ";
//out.println(query);

rs=stmt.executeQuery(query);

while(rs.next()){

if (rcount==1){ %><tr class="content" align="right" bgcolor="#FFFFFF">
<% rcount=0; } else{ %><tr class="content" align="right" bgcolor="#DBEBFF">
<% rcount=1;} %>
	<td><%=rs.getString(1)%></td>
	<td align="left"><%=rs.getString(3)%></td>
	<td><%=decf.format(rs.getFloat(4))%></td>
	<td><%=decf.format(rs.getFloat(5))%></td>
	<td><%=decf.format(rs.getFloat(6))%></td>

	</tr> 
<%  } %>

<% 
try{

rs1.close();
stmt.close();
}
catch(Exception e1)
{
	System.out.println("Exception"+e1);
}

finally{
rs1.close();
}
%>
</body>
</html>

