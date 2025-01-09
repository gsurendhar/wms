<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@page import="java.util.ArrayList"%>

 

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

String vcode=request.getParameter("vcode");
String vscrip=request.getParameter("vcode");
String vIchg = request.getParameter("tint");
if (vIchg == null){vIchg ="1";}
int vInterval=Integer.parseInt(vIchg);
String vfdate=request.getParameter("vdate");
DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());
if(vfdate == null){  vfdate=formattedDate;}
DecimalFormat decf = new DecimalFormat("####0.00");
String vsNAME="";

String Query1 ="select tradingSymbol From intraday.instruments where instrument_token = "+vcode;
rs1=stmt.executeQuery(Query1);
while(rs1.next()){
	vsNAME = rs1.getString("tradingSymbol");
}
rs1.close();

String Query ="";

Query += " select md.last_traded_time, date_format(md.last_traded_time,'%Y-%m-%d %H:%i') daytime,";
Query += " date_format(md.last_traded_time,'%H:%i') time,";
Query += " round((md.last_price-open)*100/open,2) price_chg_per, ";
Query += " 0 oi_difference_percentage,round(md.volume_traded,0) current_volume ";
Query += " , md.last_price last_price,md.volume_traded,md.oi open_interest,md.low,md.open,md.high,md.average_traded_price";
Query += " , round((md.last_price - md.average_traded_price)*100/md.average_traded_price,2) average_current_per";
Query += " from (SELECT instrument_token,";
Query += " DATE_FORMAT(last_traded_time, '%Y-%m-%d %H:%i:00') - INTERVAL MINUTE(last_traded_time) % "+vInterval+" MINUTE AS interval_start,";
Query += " COUNT(*) AS record_count,max(id) max_id ";
Query += " FROM intraday.market_data_sk where instrument_token="+vcode;  
Query += " and last_traded_time >= str_to_date('"+vfdate+"','%d/%m/%Y') ";
Query += " GROUP BY interval_start,instrument_token ) x";
Query += " inner join intraday.market_data_sk md on md.id=x.max_id";

Query += " order by 1 ";

String time, AvgPrice,LastPrice;

rs=stmt.executeQuery(Query);
     StringBuilder dataPoints1 = new StringBuilder("[");
     StringBuilder dataPoints2 = new StringBuilder("[");
// List to store the result
    List<Map<String, Object>> resultList = new ArrayList<>();	
while(rs.next()){
 
			time = rs.getString("last_traded_time");
			 AvgPrice = rs.getString("average_traded_price");
             LastPrice = rs.getString("last_price");
			 dataPoints1.append("{ x: new Date('" + time + "'), y: " + AvgPrice + " },");
             dataPoints2.append("{ x: new Date('" + time + "'), y: " + LastPrice + " },");
		Map<String, Object> row = new HashMap<>();
            row.put("time", rs.getString("time"));
            row.put("last_price", rs.getString("last_price"));
			row.put("price_chg_per", rs.getString("price_chg_per"));
			row.put("average_current_per", rs.getString("average_current_per"));
			row.put("average_traded_price", rs.getString("average_traded_price"));
			row.put("oi_difference_percentage", rs.getString("oi_difference_percentage"));
            resultList.add(row);
		}
		request.setAttribute("resultList", resultList);
		
        // Remove the trailing comma and close the array
        if (dataPoints1.length() > 1) dataPoints1.setLength(dataPoints1.length() - 1);
        dataPoints1.append("]");

        if (dataPoints2.length() > 1) dataPoints2.setLength(dataPoints2.length() - 1);
        dataPoints2.append("]");
		
 
	//	out.println(dataArray);
%>  


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Intraday <%=vsNAME %></title>
<script type="text/javascript" src="../../Script/tabber.js"></script>
<script language="javascript" type="text/javascript" src="../../Script/datepicker.js"></script> 
<script>
	function parameter(){
	var vfdate= document.getElementById("fdate").value
	var vcode= document.getElementById("txtvcode").value
	var vichg=document.getElementById("cmbIchg").value
	window.location.replace("intradaydet.jsp?vcode="+vcode+"&&vdate="+vfdate+"&&tint="+vichg);
	}
</script>
<meta http-equiv="imagetoolbar" content="no" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="Tue,01 Dec 2010 06:30:00 GMT">
<link href="../../styles/text.css" rel="stylesheet" type="text/css">
<script>
window.onload = function () {
 
var chart = new CanvasJS.Chart("chartContainer", {
	theme:"light2",
	animationEnabled: true,
	title:{
		text: "Price Chart for <%out.print(vsNAME);%>"
	},
	axisY :{
		title: "Price",
		suffix: ""
	},
	toolTip: {
		shared: "true"
	},
	legend:{
		cursor:"pointer",
		itemclick : toggleDataSeries
	},
	data: [{
		type: "spline",
		visible: true,
		showInLegend: true,
		yValueFormatString: "##.00",
		name: "AvgPrice",
		backgroundColor: '#9BD0F5',
		dataPoints:<%out.print(dataPoints1);%>
	},
	{
		type: "spline",
		visible: true,
		showInLegend: true,
		yValueFormatString: "##.00",
		name: "LastPrice",
		dataPoints:<%out.print(dataPoints2);%>
	}
          ]
});
chart.render();

function toggleDataSeries(e) {
	if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible ){
		e.dataSeries.visible = false;
	} else {
		e.dataSeries.visible = true;
	}
	chart.render();
}

}
</script>


</head>
<body>
<% response.setIntHeader("Refresh", 300); %>

<table width="100%" border="" name="tab1" class="border" cellpadding="0"  bgcolor="#DBEBFF">
 <tr> 
 <td valign="top">
  <table width="30%" border="0" name="tab2" class="border" cellpadding="0"  bgcolor="#DBEBFF" VALIGN=TOP>
	<tr><td valign=top>
	<table width="100%" border="1" cellpadding="2"  bgcolor="#DBEBFF" cellspacing="0" id="stretch" >  
		<tr class="content style1"><td class="Blue-content" colspan="3"><%=vsNAME%></td>
		<td class="Blue-content"  align="left" colspan="3">Time Interval:
		<select id="cmbIchg" onchange="parameter()" class="content style1" size="0">
			<%   if ("1".equalsIgnoreCase(vIchg)) { %> <option value="1" selected disabled >1</option> <% } else {%> <option value="1">1</option>
			<% } if ("2".equalsIgnoreCase(vIchg)) { %> <option value="2"  selected disabled>2</option> <% } else {%> <option value="2">2</option>
			<% } if ("3".equalsIgnoreCase(vIchg)) { %> <option value="3"  selected disabled>3</option> <% } else {%> <option value="3">3</option>
			<% } if ("4".equalsIgnoreCase(vIchg)) { %> <option value="4"  selected disabled>4</option> <% } else {%> <option value="4">4</option>
			<% } if ("5".equalsIgnoreCase(vIchg)) { %> <option value="5"  selected disabled>5</option> <% } else {%> <option value="5">5</option>
			<% } if ("10".equalsIgnoreCase(vIchg)) { %> <option value="10"  selected disabled>10</option> <% } else {%> <option value="10">10</option>
			<% } if ("15".equalsIgnoreCase(vIchg)) { %> <option value="15"  selected disabled>15</option> <% } else {%> <option value="15">15</option>
			<% } if ("20".equalsIgnoreCase(vIchg)) { %> <option value="20"  selected disabled>20</option> <% } else {%> <option value="20">20</option>
			<% } if ("30".equalsIgnoreCase(vIchg)) { %> <option value="30"  selected disabled>30</option> <% } else {%> <option value="30">30</option>
			<%} %>
		</select>
		</td>
		</tr>
		<tr>
		<td colspan="5">
		<input id="fdate"  class="content style1" type="text" name="fdate" size="10" maxlength="12" onchange="parameter()" value=<%=vfdate%>>
		<a href="javascript:NewCal('fdate','ddmmyyyy',false)"><img src="../../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a>
		<input class="content style1"  type="submit" value="Go" onClick="parameter()">
		<input type="hidden" id="txtvcode"  name="txtvcode" size="10" maxlength="12" value=<%=vcode%> />
		<input type="hidden" id="txtfdate"  name="txtfdate" size="10" maxlength="12" value=<%=vfdate%> />
		</td>
		</tr>
		<tr class="Blue-content" align="center">
			<td>Time</td><td>Price</td>
			<td>Price<br>Chg %</td>
			
			<td>Avg. <br> Price</td>
			<td>Avg2Last<br>Price<br>Chg(%)</td>
	<!-- 		<td>OI %</td> 
			<td>Current<br>Vol</td>  -->
		</tr>
<%
        // Retrieve the list and display it
        List<Map<String, Object>> resultList1 = (List<Map<String, Object>>) request.getAttribute("resultList");
        if (resultList1 != null) {
            for (Map<String, Object> row : resultList1) {
%>

 	<tr class="content" align="right" bgcolor="#FFFFFF">
        <td><%= row.get("time") %></td>
        <td><%= row.get("last_price") %></td>
		<td><%= row.get("price_chg_per") %></td>
		<td><%= row.get("average_traded_price") %></td>
		<td align="center" ><%= row.get("average_current_per")%></td>
	<!-- 	<td><%= row.get("current_volume") %></td>
		<td><%= row.get("oi_difference_percentage") %></td> -->
    </tr>
	
 
<%
            }
        }
    %>
 
	
	</table>
	</td>
<td valign="top">
<div id="chartContainer" style="height: 370px; width: 100%;"></div>
<script src="../../jquery/canvasjs.min.js"></script>
</td>
</tr>
</table>
</td>
</tr>
</table>

</body>
</html>

