<%@ page import ="oracle.jdbc.driver.*"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>

<script>
function parameter(){
var vfdate= document.getElementById("fdate").value
window.location.replace("downloaddata.jsp?vfdate="+vfdate);
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
	Class.forName("oracle.jdbc.driver.OracleDriver"); 
	con = DriverManager.getConnection( "jdbc:oracle:thin:@192.168.1.5:1521:orcl", "market", "obel123");
	stmt =  con.createStatement();
//    con=(Connection)session.getAttribute("connection");
//	stmt =  con.createStatement();
   
	
	}

catch(Exception ex)
	{
		out.println(ex);
		
	}

String vfdate=request.getParameter("vfdate");

//out.println(vfdate);

if(vfdate == null){ 
// vfdate=formattedDate;
		rs=stmt.executeQuery("SELECT TO_CHAR(SYSDATE,'dd/mm/yyyy') EOD_DATE FROM DUAL");  
		while(rs.next()){
		vfdate=rs.getString(1);
		}
}




	query="SELECT 'NSE' EXCHANGE,'FIIINV' TYPE,'https://www.fpi.nsdl.co.in/web/StaticReports/Fortnightly_Sector_wise_FII_Investment_Data/FIIInvestSector_Nov152014.htm' URL,'.txt' EXT FROM dual";

//out.println(query);

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


	  

</table width="100%" border="1" class="border" cellpadding="1"  bgcolor="#DBEBFF">
<tr><td class="Headings" align="Center" colspan="2"><b>Data Download URLs #</b></td></tr>
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
String f = "//usr/share/apache-tomcat-7.0.32/webapps/market/"+rs.getString(1)+"/"+rs.getString(1)+rs.getString(2)+rs.getString(4);
//out.println(f);

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
<%
rs.close();
stmt.close();
con.close();
%>
</table>
</body>
</html>
