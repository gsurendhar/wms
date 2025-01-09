
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<%
	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	ResultSet rs1=null;
	Statement stmt1=null;
	String query="";



try
{

	/*Getting the connection variable from session*/

	con=(Connection)session.getAttribute("connection");
	stmt =  con.createStatement();
	stmt1 =  con.createStatement();
	
}
catch(Exception e)
{
	%><%=e%><%
}
Integer userid=0;
String sdate="";

DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
DecimalFormat decf = new DecimalFormat("####0.00");

query="select user_id from users where login_name='"+session.getAttribute("userr")+"'";
rs=stmt.executeQuery(query);
	while (rs.next()){
		userid=rs.getInt("user_id");
	}
//out.println(userid);

	String act = request.getParameter("act"); 
//out.println(act);

	

	String vnoteid = request.getParameter("txtNoteid");


String vcode = request.getParameter("searchString");
String vseries = request.getParameter("cmbSeries");
String vedate = request.getParameter("fdate");

String veprice = request.getParameter("eprice");
String vsloss = request.getParameter("sprice");
String vtarget= request.getParameter("tprice");
String venotes = request.getParameter("exitNotes");
String vexitnotes = request.getParameter("eNotes");



	
Integer vid=0;
Integer DisRow=0;

%>

<html>
<head>
<link href="../styles/styles.css" rel="stylesheet" type="text/css">
<script language="Javascript" src="../Script/move.js"></script>
<title> Role Management </title>

<link href="../libs/jqueryui/1.8/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="../libs/jquery/1.4/jquery.min.js"></script>
<script src="../libs/jqueryui/1.8/jquery-ui.js"></script>
<script language="javascript" type="text/javascript" src="../Script/datepicker.js"></script> 


<script>
	$(document).ready(function() {
		var myArr = [];
	
		$.ajax({
			type: "GET",
			url: "shares.xml", // change to full path of file on server
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

<form method="post" name="frmTnotes" >

<% 	if ("Edit".equalsIgnoreCase(act) ) { 
	rs=stmt.executeQuery("select * from trade_notes t where user_id="+userid+" and note_id="+vnoteid+" order by 1");
%>
<table width="100%" >

	<tr>
			<td align="right" colspan="7">
			<button type="submit" class="button-image" id="act" name="act" value="Update"> <img src="../images/icon_save.png"  height="30" width="30" alt="Update" /></button>  
			<button type="submit" class="button-image" id="act" name="act" value="Cancel" > <img src="../images/icon_delete.png"  height="30" width="30" alt="Add" /></button>
			</td>
	</tr>
</table>


<table width="100%" align="center" border="1" cellpadding="0" cellspacing="0" id="stretch"  bgcolor="#DBEBFF">
<tr> <td colspan="8" align="Center" class="Headings">Trade Notes</td><tr> 
<tr class="Blue-content">
<!-- <td>Sl.No</td> -->
<td>CODE</td><td>Series</td><td>Entry Date</td>
<td>Entry Price</td>
<td>StopLoss Price</td>
<td>Target</td>
</tr>
<%while(rs.next()){ %>

<tr class="Blue-content">
<td><%=rs.getString("CODE")%>
<input type="hidden" name=txtNoteid value="<%=rs.getString("note_id")%>"/>
</td>
<td>
<select id="cmbSeries" name="cmbSeries" class="content style1" size="0">
<option value="EQ" >EQ</option>
<option value="FO" >FO</option>
</select>
</td>

<td>
<input id="fdate"  class="content style1" type="text" name="fdate" size="10" maxlength="12" value="<%=df.format(rs.getDate("entry_date"))%>" >
	<a href="javascript:NewCal('fdate','ddmmyyyy',false)"><img src="../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a>
</td>

<td><input class="content style1" type="text" id="eprice" name="eprice" value=<%=rs.getString("entry_price")%> /></td>
<td><input class="content style1" type="text" id="sprice" name="sprice" value=<%=rs.getString("stop_loss")%> /></td>
<td><input class="content style1" type="text" id="tprice" name="tprice" value=<%=rs.getString("Target")%> /></td>
</tr>
<tr class="Blue-content">
<td>Entry Notes </td>
<td colspan="5" class="content style"><textarea name="eNotes" cols="80" rows="3" class="content style1"><%=rs.getString("entry_notes")%></textarea></td>
</tr>

<tr class="Blue-content">
<td>Exit Notes </td>
<td colspan="5" class="content style"><textarea name="exitNotes" cols="80" rows="3" class="content style1"><%=rs.getString("exit_notes")%></textarea></td>
</tr>
<%}%>
</table>

<% }
else if ("Add".equalsIgnoreCase(act)){ 
%> 
<table width="100%" >

	<tr>
			<td align="right" colspan="7">
			<button type="submit" class="button-image" id="act" name="act" value="Insert"> <img src="../images/icon_save.png"  height="30" width="30" alt="Add" /></button>  
			<button type="submit" class="button-image" id="act" name="act" value="Cancel" > <img src="../images/icon_delete.png"  height="30" width="30" alt="Add" /></button>
			</td>
	</tr>
</table>

<table width="100%" align="center" border="1" cellpadding="0" cellspacing="0" id="stretch"  bgcolor="#DBEBFF">
<tr> <td colspan="8" align="Center" class="Headings">Trade Notes</td><tr> 
<tr class="Blue-content">
<!-- <td>Sl.No</td> -->
<td>CODE</td><td>Series</td><td>Entry Date</td>
<td>Entry Price</td>
<td>StopLoss Price</td>
<td>Target</td>
</tr>
<tr class="Blue-content">
<td>
<input class="content style1" type="text" id="searchBox" name="searchString" />
</td>
<td>
<select id="cmbSeries" name="cmbSeries" class="content style1" size="0">
<option value="EQ" >EQ</option>
<option value="FO" >FO</option>
</select>
</td>

<td>
<input id="fdate"  class="content style1" type="text" name="fdate" size="10" maxlength="12" value="" >
	<a href="javascript:NewCal('fdate','ddmmyyyy',false)"><img src="../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a>
</td>

<td><input class="content style1" type="text" id="eprice" name="eprice"/></td>
<td><input class="content style1" type="text" id="sprice" name="sprice"/></td>
<td><input class="content style1" type="text" id="tprice" name="tprice"/></td>
</tr>
<tr class="Blue-content">
<td>Entry Notes </td>
<td colspan="5" class="content style"><textarea name="eNotes" cols="80" rows="3"></textarea></td>
</tr>

<tr class="Blue-content">
<td>Exit Notes </td>
<td colspan="5" class="content style"><textarea name="exitNotes" cols="80" rows="3"></textarea></td>
</tr>

</table>

<%
} 
else if (act==null || ("Update".equalsIgnoreCase(act)) || ("Cancel".equalsIgnoreCase(act))||("Insert".equalsIgnoreCase(act))||("Delete".equalsIgnoreCase(act))) 
{ 

if ("Delete".equalsIgnoreCase(act)){
		query="delete from trade_notes where note_id='"+vnoteid+"'";
		stmt.executeUpdate(query);
		}


if ("Insert".equalsIgnoreCase(act)){
		query="Insert into trade_notes (note_id,code,series,entry_date,entry_price,stop_loss,Target,entry_notes,exit_notes,user_id) ";
		query +=" values (seq_note_id.nextval,'"+vcode+"','"+vseries+"',to_date('"+vedate+"','dd/mm/yyyy'),"+veprice+","+vsloss+","+vtarget+",'"+venotes+"','"+vexitnotes+"',"+userid+")";

	
		// out.println(query);
		stmt.executeUpdate(query);
		}

if ("Update".equalsIgnoreCase(act)){
		query="update trade_notes set series='"+vseries+"',entry_price="+veprice+",stop_loss="+vsloss+",target="+vtarget+",entry_notes='"+venotes+"',exit_notes='"+vexitnotes+"'";
		query +="  where note_id='"+vnoteid+"'";	
		//out.println(query);
		stmt.executeUpdate(query);

		}

rs=stmt.executeQuery("select * from trade_notes order by 1");
act="";
Integer recno =1;
%>

<table width="100%" >

	<tr>
			<td align="right" colspan="7">
			<button type="submit" class="button-image" id="act" name="act" value="Add"> <img src="../images/icon_add.png"  height="30" width="30" alt="Add" /></button>  
			<button type="submit" class="button-image" id="act" name="act" value="Edit" > <img src="../images/icon_edit.png"  height="30" width="30" alt="edit" /></button>
			<button type="submit" class="button-image" id="act" name="act" value="Delete"> <img src="../images/icon_delete.png"  height="30" width="30" alt="Delete" /></button> 
			</td>
	</tr>
</table>

<table width="75%" align="center" border="1" cellpadding="0" cellspacing="1" id="stretch"  bgcolor="#DBEBFF">

<tr> <td colspan="11" align="Center" class="Headings">Trade Notes</td><tr> 
<tr class="Blue-content"><td>ID</td><td>CODE</td><td>Series</td>
<td>Entry Price</td>
<td>Entry Date</td>
<td>S/L Price</td>
<td>Target</td>
<td>Entry Notes</td>
<td>Exit Notes</td>
<td>Added By</td>
<td>select</td>

</tr>
<%	while(rs.next()){ %>
<tr class="content style1"> 
<td align="left"><%=recno%></td>
<td align="center"><%=rs.getString(2)%></td>
<td align="center"><%=rs.getString("series")%></td>
<td align="right"><%=decf.format(rs.getFloat("entry_price"))%></td>
<td align="center"><%=df.format(rs.getDate("entry_date"))%></td>
<td align="right"><%=decf.format(rs.getFloat("stop_loss"))%></td>
<td align="right" ><%=decf.format(rs.getFloat("target"))%></td>
<td align="center" width="25%"><%=rs.getString("entry_notes")%></td>
<td align="center" width="25%"><%=rs.getString("exit_notes")%></td>
<td align="center" width="25%"><%=rs.getString("user_id")%></td>


<td><input type="radio" name="txtNoteid" value=<%=rs.getString(1)%>></td>

<%
recno++;
} 
%>
 
</table>
<%} %>
</form>
</body> 
</html>

