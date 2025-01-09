<%@ page language="java" import="wms.dbconnect.DBPostgres" %> 
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	ResultSetMetaData md;
	int	urec=0;
	String query="";


    try{
        //con = ConnectionProvider.getCon();
	con = DBPostgres.getConnection();
		stmt=con.createStatement();
	}catch(Exception e){
			out.println(e.getMessage());
		  }
    
    
 String act = request.getParameter("act");
 String Que = request.getParameter("txtRepquery");
 String Query = Que.toUpperCase();
  //out.println(Query);
		
 %>

<html>
<head>
<link href="../styles/text.css" rel="stylesheet" type="text/css">

<title> Query Management </title>
</head>
<body>

<form action="query.jsp" method="post" name="frmentry" >
<table width="100%" border="0" cellpadding="0" cellspacing="0" id="stretch"  bgcolor="#DBEBFF"> 
<tr><td class="Blue-content">Query</td><td><textarea name="txtRepquery" class="content style1" cols="80" rows="5" ><%=Query%></textarea>
<input type="submit" name="act" value="Run"></td></tr>
</table>

<%if ("Run".equalsIgnoreCase(act) ) {

	boolean  b = Query.startsWith("SELECT");
	//out.println(b);
	
	if(b){
		try {
		rs=stmt.executeQuery(Query);
		}
		catch (Exception e) {
				out.println ("<tr class=red><td colspan=2>oops - check your SQL\n -"+e+"</td></tr>");
		                }
	md = rs.getMetaData();
	int ccount = md.getColumnCount();
	int rcount = 0;

	%>
<table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" >
<tr class="Blue-content">
<%
for (int i=1; i<=ccount; i++) {
	out.print("<td>");
	out.print(md.getColumnName(i));
	out.print("</td>");
	}
out.println("</tr>");

while(rs.next()){
	rcount=rcount+1;
%>
<tr  class="readonly">
<%	for (int i=1; i<=ccount; i++) {
		out.print("<td>");
		out.print(rs.getString(i));
		out.print("</td>");
	}
	out.println("</tr>");
}


%>

</tr>
</table>
<% out.println("<tr>"+rcount+" rows selected...</tr>"); %> 
<%}
	else {
		
		try {
		urec=stmt.executeUpdate(Query);
			}
			catch (Exception e) {
			out.println ("<tr class=red><td colspan=2>oops - check your SQL\n -"+e+"</td></tr>");
		              }
		out.println("<tr>"+urec+" rows updated</tr>"); 
		}

}%>
</form>
</body>
</html>
