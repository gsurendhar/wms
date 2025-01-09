
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	ResultSet rs1=null;
	Statement stmt1=null;
	String query="";


    if(null == session.getAttribute("userr")){  
  // User is not logged in.
  out.println("your Session has expired");
  response.sendRedirect("Login.html?invalid=0");
} 


try
{

	/*Getting the connection variable from session*/

	con=(Connection)session.getAttribute("connection");
	stmt =  con.createStatement();
	stmt1 =  con.createStatement();
	
}
catch(Exception e)
{
	//System.out.println("Exception"+e);
	%><%=e%><%
}



	String act = request.getParameter("act"); 
	String vgroupid = request.getParameter("txtGroupid");

	String vname = request.getParameter("txtName");


	String[] mymenus = request.getParameterValues("selected_fields");
    String[] mymenusa = request.getParameterValues("choose_fields");


	
 %>

<html>
<head>
<link href="../styles/styles.css" rel="stylesheet" type="text/css">
<script language="Javascript" src="../Script/move.js"></script>
<title> Scrip Management </title>
<SCRIPT LANGUAGE="JavaScript">


</SCRIPT>
</head>
<body>
<%
Integer vid=0;
Integer DisRow=0;
%>
<%
	if ("Update".equalsIgnoreCase(act)){
		if (mymenus != null ) {
			for (int i = 0; i < mymenus.length; i++) {
			//out.print("<P>" + mymenus[i] + "</p>");
			query="update scrip_master set ACTIVE='Y' where SHORT_NAME='"+mymenus[i]+"'";
			//out.println(query);
			stmt.executeUpdate(query);
			}
		}
	if (mymenusa != null ) {
			for (int i = 0; i < mymenusa.length; i++) {
			query="update scrip_master set ACTIVE='N' where SHORT_NAME='"+mymenusa[i]+"'";
			//out.println(query);
			stmt.executeUpdate(query);
			}
		}


act="";

}
%>
<form method="post" name="frmgroup" >
<% 
%>
<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch"  bgcolor="#DBEBFF"> 
<tr><td class="Blue-content" align="center">Avialble List</td><td>&nbsp;</td><td class="Blue-content" align="center">Selected List</td></tr>

	<% rs1=stmt1.executeQuery("select SHORT_NAME from scrip_master where ACTIVE='N' AND segment='EQ' and EXCHANGE='NC' order by 1"); %>
	<% rs=stmt.executeQuery("select SHORT_NAME from scrip_master where ACTIVE='Y' AND segment='EQ' and EXCHANGE='NC' order by 1"); %>
<tr>
<td width="15%" align="center"><select name="choose_fields" size="10" class="content" multiple="true" style="width:120px;height:260px">
				  <% while (rs1.next()){ %>
				  <option value="<%=rs1.getString(1)%>"><%=rs1.getString(1)%></option>
				<% }%>
			</select>
			</td>
				<td width="5%" align="center"> 
						<input type="button" name="rightFields" value="&gt;" onclick="move(document.frmgroup.choose_fields,document.frmgroup.selected_fields)" > 
						<br><br><input type="button" name="leftPartner"  value="&lt;" onclick="move(document.frmgroup.selected_fields,document.frmgroup.choose_fields)" > 
				</td>

				<td class="content" width="15%" align="center">
				<select name="selected_fields" size="5" class="content" multiple="true" style="width:120px;height:260px"  >
						 <% while (rs.next()){ %>
						  <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
						 <% }%>
						 </select>
				</td>


  <tr>
 <td  align="right"><input type="submit" name="act" value="Update"></td>
 <td  align="left"> <input type="submit" name="act" value="Cancel"></td>
 </tr>
</table>
 </table>



</form>
</body> 
</html>

