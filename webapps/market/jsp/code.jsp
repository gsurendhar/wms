<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%!
	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	ResultSet rsrole=null;
	Statement stmtrole=null;
	String query="";
	int count=0;
	int DisRow=0;
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
	System.out.println("Exception"+e);

}


	String act = request.getParameter("act"); 
	String vid = request.getParameter("txtid");
	String vcompany = request.getParameter("txtCompany");
	String vbusiness = request.getParameter("txtBusiness");
	String vbse = request.getParameter("txtBse");
	String vnse = request.getParameter("txtNse");
	String vmc = request.getParameter("txtMC");


 %>

<html>
<head>
<link href="../styles/styles.css" rel="stylesheet" type="text/css">

<title> User Management </title>
</head>
<body>


<form action="code.jsp" method="post" name="frmentry" >

<% if ("Edit".equalsIgnoreCase(act) ) { %>

<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch"  bgcolor="#DBEBFF"> 
<tr> <td colspan="2" align="Center" class="Blue-content">EDIT Customer</td><tr> 
</table>



<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch"  bgcolor="#DBEBFF"> 
	<%		//out.println(vid);
			if (vid!=null){
			rs=stmt.executeQuery("select * from scrip_code where id="+vid);
			while(rs.next())
	{
%>
<tr><td class="Blue-content">ID</td><td><input type="text" readonly name="txtid" size="10" class="content style1" value="<%=rs.getString("ID")%>" ></td></tr>

<tr><td class="Blue-content">Company</td><td><input type="text" name="txtCompany" size="40" class="content style1" value="<%=rs.getString("COMPANY")%>" ></td></tr>
<tr><td class="Blue-content">Business</td><td><input type="text" name="txtBusiness" size="40" class="content style1" value="<%=rs.getString("INDUSTRY")%>"> </td></tr>
<tr><td class="Blue-content">BSE ID</td><td><input type="text" name="txtBse" class="content style1" value="<%=rs.getString("BSE_CODE")%>"> </td></tr>
<tr><td class="Blue-content">NSE Code</td><td><input type="text" name="txtNse" class="content style1" value="<%=rs.getString("NSE_CODE")%>"> </td></tr>
<tr><td class="Blue-content">Money Conrol Link</td><td><input type="text" name="txtMC" size="100" class="content style1" value="<%=rs.getString("MC_LLINK")%>"> </td></tr>
</tr>
 <%} 
%>
  <tr>
 <td  align="right"><input type="submit" name="act" value="Update"></td>
 <td  align="left"> <input type="submit" name="act" value="Cancel"></td>
 </tr>
 <%
			}
	
	else { %>
<tr><td><b><center>No User selected</center></b></td></tr>
<td  align="center"> <input type="submit" name="act" value="Cancel"></td>
	
<%	} %>
 
</table>
<% }
else if ("Add".equalsIgnoreCase(act)){ 	
%>	
<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch"  bgcolor="#DBEBFF"> 
<tr> <td colspan="2" align="Center" class="Blue-content"><%=act%> Code</td><tr> 
<tr><td class="Blue-content">Company</td><td><input type="text" name="txtCompany" class="content style1" size="25"> </td></tr>
<tr><td class="Blue-content">Business</td><td><input type="text" name="txtBusiness" class="content style1" size="100"> </td></tr>
<tr><td class="Blue-content">BSE ID</td><td><input type="text" name="txtBse" class="content style1" size="100" > </td></tr>
<tr><td class="Blue-content">NSE Code</td><td><input type="text" name="txtNse" class="content style1" size="50"></td></tr>
<tr><td class="Blue-content">Money Conrol Link</td><td><input type="text" size="100" name="txtMC" class="content style1" > </td></tr>
</tr>
 
  <tr>
 <td  align="right"><input type="submit" name="act" value="Insert"></td>
 <td  align="left"> <input type="submit" name="act" value="Cancel"></td>
 </tr>
</table>

<%
}
else if (act==null || ("Update".equalsIgnoreCase(act)) || ("Cancel".equalsIgnoreCase(act))||("Insert".equalsIgnoreCase(act))||("Delete".equalsIgnoreCase(act))) 
{  
	if ("Update".equalsIgnoreCase(act)){
		query="update scrip_code set company='"+vcompany+"',Industry='"+vbusiness+"',BSE_CODE='"+vbse+"',NSE_CODE='"+vnse+"',mc_link='"+vmc+"' where id='"+vid+"'";
	//out.println(query);
	stmt.executeUpdate(query);
	}

if ("Insert".equalsIgnoreCase(act)){
		query="Insert into scrip_code (id,company,industry,bse_code,nse_code,mc_link) values (seq_code_id.NEXTVAL,'"+vcompany+"','"+vbusiness+"','"+vbse+"','"+vnse+"','"+vmc+"')";
		stmt.executeUpdate(query);
	}

act=null;

rs=stmt.executeQuery("select * from scrip_code order by company");
act="";
%>

<table width="100%" border="0" cellpadding="0" class=border cellspacing="0" id="stretch"  bgcolor="#DBEBFF">

<tr> <td colspan="5" align="Center" class="Blue-content">CODE List</td><tr> 
 <tr>
 <td colspan="3" ></td>
 <td align="right"><input type="submit" name="act" value="Add"></td>
 <!--  <td align="left"> <input type="submit" name="act" value="Edit">
  <input type="submit" name="act" value="Delete"> -->
 </tr>
<tr class="Blue-content"> <td>Company</td><td>Business</td> <td>BSE ID</td><td>NSE Code</td><td>Money Control</td>
</tr>
<%	while(rs.next())
	{
%>
<tr class="content style1"> 
<td><%=rs.getString("COMPANY")%></td><td><%=rs.getString("INDUSTRY")%></td><td><%=rs.getString("BSE_CODE")%></td>
<td><a href="code.jsp?act=Edit&&txtid=<%=rs.getString("ID")%>" target="_blank" style="font-size: 9pt; color: #990000 ;font-weight: bold"><%=rs.getString("NSE_CODE")%></a></td>
<td><a href="<%=rs.getString("MC_LINK")%>" target="_blank" style="font-size: 9pt; color: #990000 ;font-weight: normal"><%=rs.getString("MC_LINK")%></a></td>
<!-- <td><input type="radio" name="txtid" value=<%=rs.getString("id")%>></td> -->
</tr>
<%	  DisRow++;	}
	if(DisRow==0)
{	/*To write to the server if the resultset is null*/
%>
		<CENTER>
			<tr><th colspan=6 class="content style1">No Records found</th></tr>
		</CENTER>
<%} %>
 <tr>
 <td colspan="1" align="right"><input type="submit" name="act" value="Add"></td>
 <!-- <td colspan="1" align="center"> <input type="submit" name="act" value="Edit"></td>
  <td colspan="1" align="left"> <input type="submit" name="act" value="Delete"></td> -->

 </tr>
</table>
<%} 
else 
%>
</form>
</body> 
</html>

