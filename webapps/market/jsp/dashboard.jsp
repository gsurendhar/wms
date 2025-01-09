<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%!
	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	ResultSet rsrole=null;
	Statement stmtrole=null;
	String query="";
%>

<%



try
{

	/*Getting the connection variable from session*/

	con=(Connection)session.getAttribute("connection");
	stmt =  con.createStatement();
	stmtrole  =  con.createStatement();
	
}
catch(Exception e)
{
	out.println("Exception"+e);

}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> WMS Dash Board </TITLE>
<link href="../styles/text.css" rel="stylesheet" type="text/css">

</HEAD>

<BODY>


<%	rs=stmt.executeQuery("select  max(day)  eod_date from eod");
			while(rs.next())
	{
%>
<table width="100%" class=border border="0" cellpadding="0" cellspacing="0" id="stretch" >
<tr><td></td></tr>
<tr><td class="Blue-content">Last Data Updated</td><td class="content style1"> <%=rs.getString(1)%> </td></tr>
</table>
<%}%>
<%
query="select a.day,dayname(a.day) dow,nse_bhav,nse_mto,nse_bulk,nse_fo,nse_research,bse_bhav,bse_mto,bse_research"; 
query +=" from  (select day,count(1) nse_bhav from nse_bhav group by day ) a";    
query +=" left outer join ( select day,count(1) nse_mto from nse_mto group by day ) b on a.day=b.day"; 
query +=" left outer join ( select day,count(1) nse_bulk from nse_bulk group by day ) c on a.day=c.day"; 
query +=" left outer join ( select day,count(1) nse_fo from nse_fo group by day ) fo on a.day=fo.day"; 
query +=" left outer join ( select day,count(1) nse_research from research_page group by day ) r on a.day=r.day"; 
query +=" left outer join ( select day,count(1) bse_bhav from bse_bhav group by day ) bbhav on a.day=bbhav.day"; 
query +=" left outer join ( select day,count(1) bse_mto from bse_mto group by day ) bmto on a.day=bmto.day"; 
query +=" left outer join ( select day,count(1) bse_research from bse_research_page group by day ) br on a.day=br.day";  
query +=" order by a.day desc limit 10";
 
 rs = stmt.executeQuery(query);
%>

<table width="100%" border="1" class="border" cellpadding="1"  bgcolor="#DBEBFF">
<tr><td class="Headings" align="Center" colspan="2"><b>Data Load Details (last 10 Days) </b></td></tr>
<tr>
<td>
<table width="100%" border="1" cellpadding="2"  bgcolor="#DBEBFF" cellspacing="0" id="stretch" > 
<tr class="Blue-content" align="center">
<td rowspan="2">Date</td><td rowspan="2">Day</td>
<td rowspan="1" colspan="5">NSE</td>
<td rowspan="1" colspan="3">BSE</td>

</tr>

<tr  class="Blue-content" align="center">
<!-- <td>Date</td><td>Day</td> -->
<td> BHAV</td><td>MTO</td><td>FO</td><td>BULK</td><td>Research</td>
 <td>BHAV</td><td>MTO</td><td>Research</td>
 </tr> 

<% while(rs.next()){ %>
	<tr class="content style1" align="center"><td><%=rs.getString("day")%></td><td align="left"><%=rs.getString("dow")%></td>
	<td><%=rs.getString("NSE_BHAV")%></td><td><%=rs.getString("NSE_MTO")%></td><td><%=rs.getString("NSE_FO")%></td>
	<td><%=rs.getString("NSE_BULK")%></td><td><%=rs.getString("nse_research")%></td> 
	
	<td><%=rs.getString("BSE_BHAV")%></td><td><%=rs.getString("BSE_MTO")%></td><td><%=rs.getString("bse_research")%></td>

	</tr>
	<%} %>
</table>
</td>
</tr>
</table>


</BODY>
</HTML>
