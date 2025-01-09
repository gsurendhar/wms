<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.ArrayList" %>

 
<%@ page session = "true" %>




<%!
Connection con=null;
ResultSet rs=null;
ResultSet rs1=null;
Statement stmt=null;
String query="";
String query1="";
String query2="";
String e;

Integer vmintimeint =0;
Integer vmaxtimeint=0;

DecimalFormat decf = new DecimalFormat("####0.00");
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

DateFormat df = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");

String vIchg = request.getParameter("vtchg");
if (vIchg == null){vIchg ="5";}


String vfordate=request.getParameter("");


String vtrdval=request.getParameter("vtrdval");
if (vtrdval==null){vtrdval="5";}
 
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>NSE BHAV</title>
 

<meta http-equiv="imagetoolbar" content="no" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="Tue,01 Dec 2010 06:30:00 GMT">
<link href="../../styles/text.css" rel="stylesheet" type="text/css">
 </head>

<body>
<form >
<% if ("5".equalsIgnoreCase(vIchg)) { response.setIntHeader("Refresh", 5); }
   if ("10".equalsIgnoreCase(vIchg)) { response.setIntHeader("Refresh", 10);}
   if ("20".equalsIgnoreCase(vIchg)) { response.setIntHeader("Refresh", 20);}
   if ("30".equalsIgnoreCase(vIchg)) { response.setIntHeader("Refresh", 30);}
   if ("40".equalsIgnoreCase(vIchg)) { response.setIntHeader("Refresh", 40);}
   if ("50".equalsIgnoreCase(vIchg)) { response.setIntHeader("Refresh", 50);}
   else { response.setIntHeader("Refresh", 20);}
%> 


<%
String vsql ="select a.DAY,EXCHANGE,a.CODE,SERIES,OPEN,HIGH,LOW,CLOSE,LAST,round(TOTTRDVAL/10000000,4) TOTTRDVAL,round(AVG_5D_TOTTRDVAL/10000000,4) AVG_5D_TOTTRDVAL from intraday.nse_bhav a left outer join intraday.nse_bhav_5day b on a.CODE=b.tradingSymbol and a.day=b.day where a.day=(select max(day) from intraday.nse_bhav) and SERIES='EQ'";
 
rs=stmt.executeQuery(vsql);
		ResultSetMetaData metadata = rs.getMetaData();
		int count = metadata.getColumnCount();
		ArrayList<String> columns = new ArrayList<>(); %>
<table  border="1" id="my_table"  cellpadding="2" cellspacing="0" align="left" >
 <thead> 
 <tr class="Blue-content" align="center">
        <%for(int i=1; i<=count;i++)
            { 
             String name = metadata.getColumnName(i);
             columns.add(name);      
        %>
          <th><%=name%></th> 
        <% } %>
    </tr>
</thead>
<%	
while(rs.next()){
%>
<tr class="content" align="left" >
  
         <% for(int i=0;i<columns.size();i++) { %>
                    <td><%= rs.getString(columns.get(i))%></td>
         <% } %> 
 </tr>
	
<%}
rs1.close();
%>
</table>
</td> 

</tr>
</form>
</body>
</html>




