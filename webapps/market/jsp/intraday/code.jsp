<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%!
	Connection con=null;
	ResultSet rs=null;
    ResultSet rs1=null;
	Statement stmt=null;
	ResultSet rsrole=null;
	Statement stmtupdate=null;
	String query="";
	String query1="";
	int count=0;
	int DisRow=0;
%>

<%



try
{

	/*Getting the connection variable from session*/

	con=(Connection)session.getAttribute("connection");
	stmt =  con.createStatement();
	stmtupdate  =  con.createStatement();
	
}
catch(Exception e)
{
	System.out.println("Exception"+e);

}


	String act = request.getParameter("act"); 
	String vid = request.getParameter("txtid");
	String vrule=request.getParameter("vrule");
	if (vrule==null){vrule="NSE-EQ";}
	String vselect=request.getParameter("vselect");
	if (vselect==null){vselect="Y";}
		
	String vsubscribe=request.getParameter("txtSelect");
	
	String vtoken= request.getParameter("txtToken");
	String tokens[] = request.getParameterValues("txtSelect"); 
	String vstart =  request.getParameter("vstart");
	String vend  =   request.getParameter("vend");
	if (vstart==null){vstart="1"; vend="100";}	
	
	
 %>
 
 

<script> 
function parameter_rule(){
var vrule=document.getElementById("cmbRule").value
var vselect=document.getElementById("cmbSelect").value
window.location.replace("code.jsp?vrule="+vrule+"&&vselect="+vselect);
}
</script>

<html>
<head>
<link href="../../styles/styles.css" rel="stylesheet" type="text/css">

<title> Code Management </title>
</head>
<body>


<form action="code.jsp" method="post" name="frmentry" >

<% 

System.out.println("act:"+act);
if ("next".equalsIgnoreCase(act)){
	vstart = Integer.toString(Integer.parseInt(vstart) + 100);
	vend = Integer.toString(Integer.parseInt(vend) + 100);
		}


if ("previous".equalsIgnoreCase(act)){ if (Integer.parseInt(vstart) > 1) {
	vstart = Integer.toString(Integer.parseInt(vstart) - 100);
	vend = Integer.toString(Integer.parseInt(vend) - 100);
	}
}
 

if ("update".equalsIgnoreCase(act)){
 
		String s[] = request.getParameterValues("txtSelect");
		if (s != null && s.length != 0) {
		//out.println("You have selected the option is: ");
		for (int i = 0; i < s.length; i++) {
		//out.println(s[i] + "\n" + "Thank you");
			query1="update intraday.instruments set subscribe='Y' where instrument_token='"+s[i]+"'";
			System.out.println(query1);
			stmtupdate.executeUpdate(query1);
		}
		}
}

query="select instrument_token,exchange,instrument_type,tradingsymbol,name,subscribe from  intraday.instruments where 1=1 ";
if (!"".equalsIgnoreCase(vrule)){query=query+" and concat(exchange,'-',instrument_type)='"+vrule+"'";}

if ("N".equalsIgnoreCase(vselect)){query=query+" and subscribe='N'";} 
else if ("All".equalsIgnoreCase(vselect)){query=query+"";}
else {query=query+" and subscribe like 'Y%'";}

query=query+" order by exchange,instrument_type,tradingsymbol limit "+vstart+","+vend;

rs=stmt.executeQuery(query);

act="";


%>



<table width="100%" border="1" cellpadding="0" class=border cellspacing="0" id="stretch"  bgcolor="#DBEBFF">
 
<tr>
<td class="Blue-content"  align="left" colspan="2">
select Type: 
<select id="cmbRule" onchange="parameter_rule()" class="content style1" size="0" style="width: 200px;">
<option value= "" ></option>
<option value= "NSE-EQ" >NSE-EQ</option>
<option value= "NFO-FUT" >NFO-FUT</option>
<option value= "NFO-CE" >NFO-CE</option>
<option value= "NFO-PE" >NFO-PE</option>
<option value="<%=vrule%>" selected disabled ><%=vrule%></option>
</select>
</td>
<td class="Blue-content"  align="left" colspan="1">
Select:
<select id="cmbSelect" onchange="parameter_rule()" class="content style1" size="0" style="width: 200px;">
<option value= "All" >All</option>
<option value= "Y" >Y</option>
<option value= "N" >N</option>
<option value="<%=vselect%>" selected ><%=vselect%></option>
</select>
</td>
<td>
 <button type="submit" class="button-image" name="act" value="previous"> <img src="../../images/prev.JPG"  height="10" width="10" alt="Save" /></button>
 <button type="submit" class="button-image" name="act" value="next"> <img src="../../images/next.JPG"  height="10" width="10" alt="Save" /></button>

 </td>
</tr>
<tr class="Blue-content"><td>Type</td> <td>Code</td><td>Name</td><td>Subscribe</td> 
</tr>
<%	while(rs.next())
	{
%>
 
<tr class="content style1">
<td>
 <input type="hidden" name="txtToken"  value=<%=rs.getString("instrument_token")%>>   
<input type="hidden" name="vrule"  value=<%=vrule%>>
<input type="hidden" name="vselect"  value=<%=vselect%>>
<input type="hidden" name="vstart"  value=<%=vstart%>>
<input type="hidden" name="vend"  value=<%=vend%>>
<%=rs.getString("exchange")%>-<%=rs.getString("instrument_type")%></td>
<td><%=rs.getString("Name")%></td>
<td><%=rs.getString("tradingsymbol")%></td>
<%if ("N".equalsIgnoreCase(rs.getString("subscribe"))) {%>
	<td><input type="checkbox" name="txtSelect"  value=<%=rs.getString("instrument_token")%>> </td>
<%} else {%>
	<td><input type="checkbox" name="txtSelect" checked="checked" value=<%=rs.getString("instrument_token")%>> </td>
<%} %>
<td>
  <button type="submit" class="button-image" name="act" value="update"> <img src="../../images/icon_save.png"  height="10" width="10" alt="Save" /></button>
</td> 

<% }%>


 </tr>
</table>
</form>

</body> 
</html>


