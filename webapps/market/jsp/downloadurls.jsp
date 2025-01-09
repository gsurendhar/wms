
<%@ page import ="oracle.jdbc.driver.*"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>

<script>
function parameter(){
var vfdate= document.getElementById("fdate").value
window.location.replace("downloadurls.jsp?vfdate="+vfdate);
}
</script>

<%
response.setContentType("text/html");
Connection con=null;
Statement stmt=null;
ResultSet rs=null;


String query;
String query1;

	try
	{
	//Class.forName("oracle.jdbc.driver.OracleDriver"); 
	//con = DriverManager.getConnection( "jdbc:oracle:thin:@localhost:1521:xe", "share", "abc123"); 
	//stmt =  con.createStatement();
    con=(Connection)session.getAttribute("connection");
	stmt =  con.createStatement();
   
	
	}

catch(Exception ex)
	{
		out.println(ex);
		
	}

String vfdate=request.getParameter("vfdate");

//out.println(vfdate);

if(vfdate == null){ 
// vfdate=formattedDate;
		rs=stmt.executeQuery("SELECT current_date");  
		while(rs.next()){
		vfdate=rs.getString(1);
		}
}


query = "SELECT NSE_BULK,CM_NSE_BHAV,NSE_MTO,NSE_FO,NSE_BHAV,BSE_BHAV  FROM ";

query=query+"(SELECT COUNT(1) CM_NSE_BHAV FROM NSE_BHAV WHERE DAY='"+vfdate+"') b,";
query=query+"(SELECT COUNT(1) NSE_MTO FROM NSE_MTO WHERE DAY='"+vfdate+"') c,";
query=query+"(SELECT COUNT(1) NSE_BHAV FROM BSE_BHAV WHERE DAY='"+vfdate+"') d,";
query=query+"(SELECT COUNT(1) NSE_FO FROM NSE_FO WHERE DAY= '"+vfdate+"')e, ";
query=query+"(SELECT COUNT(1) BSE_BHAV FROM BSE_BHAV WHERE DAY='"+vfdate+"') f, ";
query=query+"(SELECT COUNT(1) BSE_MTO FROM NSE_BULK WHERE DAY='"+vfdate+"') a,"; 

rs = stmt.executeQuery(query);
while(rs.next()){
		%>
<%
	query=" SELECT 'NSE' EXCHANGE,'FII' TYPE,'http://www.nseindia.com/products/dynaContent/equities/equities/htms/fiiEQ.htm?id='||'"+vfdate+"' URL,'.txt' EXT from dual";

	if (rs.getInt(1)==0){ //NSE_BULK
		query=query+" UNION SELECT 'NSE' EXCHANGE,'Bulk' TYPE,'http://www.nseindia.com/content/equities/bulk.csv' URL ,'.csv' EXT FROM dual UNION SELECT 'NSE' EXCHANGE,'Block' TYPE,'http://www.nseindia.com/content/equities/block.csv' URL,'.csv' EXT FROM dual ";
	}
	else {
		query=query+" UNION SELECT 'NSE' EXCHANGE,'Bulk' TYPE,'-' URL ,'.csv' EXT FROM dual ";
	}
	
	if (rs.getInt(2)==0){ //"CM_NSE_BHAV"
		query=query+" UNION SELECT 'NSE' EXCHANGE,'Bhav' TYPE,'http://www.nseindia.com/content/historical/EQUITIES/'||TO_CHAR(SDATE,'YYYY/MON')||'/cm'||TO_CHAR(SDATE,'DDMONYYYY')||'bhav.csv.zip' URL ,'.zip' EXT FROM (SELECT TO_DATE('"+vfdate+"','dd/mm/yyyy') sdate FROM dual)";
	}

	if (rs.getInt("NSE_MTO")==0){
		query=query+" UNION SELECT 'NSE' EXCHANGE,'MTO' TYPE,'http://www.nseindia.com/archives/equities/mto/MTO_'||TO_CHAR(SDATE,'DDMMYYYY')||'.DAT' URL,'.dat' EXT FROM  (SELECT TO_DATE('"+vfdate+"','dd/mm/yyyy') sdate FROM dual)";
	}
	if (rs.getInt("NSE_FO")==0){
		query=query+" UNION SELECT 'NSE' EXCHANGE,'FO' TYPE,'http://www.nseindia.com/content/historical/DERIVATIVES/'||TO_CHAR(SDATE,'YYYY/MON')||'/fo'||TO_CHAR(SDATE,'DDMONYYYY')||'bhav.csv.zip' URL,'.zip' EXT FROM (SELECT TO_DATE('"+vfdate+"','dd/mm/yyyy') sdate FROM dual)";
	}
	if (rs.getInt("BSE_BHAV")==0){
		query=query+"UNION SELECT 'BSE' EXCHANGE,'Bhav' TYPE,'http://www.bseindia.com/BSEDATA/gross/'||TO_CHAR(SDATE,'YYYY')||'/SCBSEALL'||TO_CHAR(SDATE,'DDMM')||'.zip' URL,'.zip' EXT FROM (SELECT TO_DATE('"+vfdate+"','dd/mm/yyyy') sdate FROM dual) ";
	}
	if (rs.getInt("BSE_BULK")==0){ 
		query=query+" UNION SELECT 'BSE' EXCHANGE,'Bulk' TYPE,'http://www.bseindia.com/stockinfo/BulkBlockCSV.aspx?deal=1&scode=0&fdate='||TO_CHAR(SDATE,'DD/MM/YYYY')||'&tdate='||TO_CHAR(SDATE-0,'DD/MM/YYYY') URL ,'.csv' EXT FROM (SELECT TO_DATE('"+vfdate+"','dd/mm/yyyy') sdate FROM dual) UNION SELECT 'BSE' EXCHANGE,'Block' TYPE,'http://www.bseindia.com/stockinfo/BulkBlockCSV.aspx?deal=2&scode=0&fdate='||TO_CHAR(SDATE,'DD/MM/YYYY')||'&tdate='||TO_CHAR(SDATE,'DD/MM/YYYY') URL ,'.csv' EXT  FROM (SELECT TO_DATE('"+vfdate+"','dd/mm/yyyy') sdate FROM dual)";
	}
	
}

//out.println(query);

/* query="SELECT 'NSE' EXCHANGE,'MTO' TYPE,'http://www.nseindia.com/archives/equities/mto/MTO_'||TO_CHAR(SDATE,'DDMMYYYY')||'.DAT' URL,'.dat' EXT FROM  (SELECT TO_DATE('"+vfdate+"','dd/mm/yyyy') sdate FROM dual)";
query=query+" UNION SELECT 'NSE' EXCHANGE,'Bhav' TYPE,'http://www.nseindia.com/content/historical/EQUITIES/'||TO_CHAR(SDATE,'YYYY/MON')||'/cm'||TO_CHAR(SDATE,'DDMONYYYY')||'bhav.csv.zip' URL ,'.zip' EXT FROM (SELECT TO_DATE('"+vfdate+"','dd/mm/yyyy') sdate FROM dual)";
query=query+" UNION SELECT 'NSE' EXCHANGE,'Bulk' TYPE,'http://www.nseindia.com/content/equities/bulk.csv' URL ,'.csv' EXT FROM dual";
query=query+" UNION SELECT 'NSE' EXCHANGE,'Block' TYPE,'http://www.nseindia.com/content/equities/block.csv' URL,'.csv' EXT FROM dual ";
query=query+" UNION SELECT 'NSE' EXCHANGE,'FO' TYPE,'http://www.nseindia.com/content/historical/DERIVATIVES/'||TO_CHAR(SDATE,'YYYY/MON')||'/fo'||TO_CHAR(SDATE,'DDMONYYYY')||'bhav.csv.zip' URL,'.zip' EXT FROM (SELECT TO_DATE('"+vfdate+"','dd/mm/yyyy') sdate FROM dual)";
query=query+" UNION SELECT 'BSE' EXCHANGE,'Bhav' TYPE,'http://www.bseindia.com/BSEDATA/gross/'||TO_CHAR(SDATE,'YYYY')||'/SCBSEALL'||TO_CHAR(SDATE,'DDMM')||'.zip' URL,'.zip' EXT FROM (SELECT TO_DATE('"+vfdate+"','dd/mm/yyyy') sdate FROM dual)";
query=query+" UNION SELECT 'BSE' EXCHANGE,'Bulk' TYPE,'http://www.bseindia.com/stockinfo/BulkBlockCSV.aspx?deal=1&scode=0&fdate='||TO_CHAR(SDATE,'DD/MM/YYYY')||'&tdate='||TO_CHAR(SDATE-0,'DD/MM/YYYY') URL ,'.csv' EXT FROM (SELECT TO_DATE('"+vfdate+"','dd/mm/yyyy') sdate FROM dual)";
query=query+" UNION SELECT 'BSE' EXCHANGE,'Block' TYPE,'http://www.bseindia.com/stockinfo/BulkBlockCSV.aspx?deal=2&scode=0&fdate='||TO_CHAR(SDATE,'DD/MM/YYYY')||'&tdate='||TO_CHAR(SDATE,'DD/MM/YYYY') URL ,'.csv' EXT  FROM (SELECT TO_DATE('"+vfdate+"','dd/mm/yyyy') sdate FROM dual)";
query=query+" order by 1,2";
*/


rs = stmt.executeQuery(query);

//out.println(vfdate);

 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reports</title>
<script type="text/javascript" src="../Script/tabber.js"></script>
<script language="javascript" type="text/javascript" src="../Script/datepicker.js"></script> 
<link href="../styles/text.css" rel="stylesheet" type="text/css">
</head>
<body>


	  

<table width="100%" border="1" class="border" cellpadding="1"  bgcolor="#DBEBFF">
<tr><td class="Headings" align="Center" colspan="2"><b>Data Download URLs</b></td></tr>
<!--   date selection starts here -->
<tr>
<td>
	<table width="100%" border="1" cellpadding="2"  bgcolor="#DBEBFF" cellspacing="0" id="stretch"   VALIGN=TOP> 
	<tr><td class="Blue-content" align="left" width="15%"><b>Select date:</b>
	<input id="fdate"  class="content style1" type="text" name="fdate" size="10" maxlength="12" value=<%=vfdate%>>
	<a href="javascript:NewCal('fdate','ddmmyyyy',false)"><img src="../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a>
	<!--   date selection ends here -->
	<input class="content style1" type="submit" value="Go" onClick="parameter()"></td> <tr>
	</td></tr>
	</table>
</td>
<td>
<table width="100%" border="1" cellpadding="2"  bgcolor="#DBEBFF" cellspacing="0" id="stretch" > 
<tr  class="Blue-content" align="left"><td>Exchange</td><td>Type</td><td>URL</td><td>Status</td></tr>
<% while(rs.next()){ %>
	<tr class="Blue-content" align="left"><td><%=rs.getString(1)%></td><td><%=rs.getString(2)%></td>
	<td><a href=<%=rs.getString(3)%>><%=rs.getString(3)%></td>
	<td class="red-content"><%
	try {
String u = rs.getString(3);
String f = "c:\\shares\\"+rs.getString(1)+"\\"+rs.getString(1)+rs.getString(2)+rs.getString(4);

URL url = new URL(u);
URLConnection connection = url.openConnection();
InputStream stream = connection.getInputStream();
BufferedInputStream in = new BufferedInputStream(stream);
FileOutputStream file = new FileOutputStream(f);
BufferedOutputStream out1 = new BufferedOutputStream(file);

	  int bufSizeHint = 8 * 1024;
      int read = -1;
      byte[] buf = new byte[bufSizeHint];
      while ((read = in.read(buf, 0, bufSizeHint)) >= 0) {
          out1.write(buf, 0, read);
      }
      out1.flush();
	  out1.close();
	  out.println("Sucess");
}
catch(Exception ex)
	{
		out.println(ex);
		
	}
	%> </td></tr>

	
<%}%>


</table>
</td>
</tr>
</table>
</body>
</html>