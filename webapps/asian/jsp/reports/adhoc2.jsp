<!--  Adhoc2.jsp needs 2 inputs String1,String2 in the Query  -->

<%@ page import="java.sql.*" %>
<%@ page language="java" %>
<%@ page import="java.io.*,java.text.*"%>
<%@page import="java.util.*"%>


<%@page import="com.locationDao"%>
<%@page import="com.locationBean"%>
<jsp:useBean id="obj" class="com.locationBean"/>
<jsp:setProperty property="*" name="obj"/>


<%@ page language="java" import="com.ConnectionProvider" %> 
<%@ page import="java.sql.*"%>
<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
String query="";
ResultSetMetaData md;
String rep_title="";
String repquery="";
PreparedStatement pst = null;
%>

<script>
function param1(){
	var id = document.getElementById("id").value
	var vid1 = document.getElementById("state").value
	window.location.replace("adhoc2.jsp?id="+id+"&&value1="+vid1);
}

function param2(){
	var id = document.getElementById("id").value
	var vid1 = document.getElementById("state").value
	var vid2 = document.getElementById("district").value
	window.location.replace("adhoc2.jsp?id="+id+"&&value1="+vid1+"&&value2="+vid2);
	}

</script>

<%
locationDao location = new locationDao();

con = ConnectionProvider.getCon();
stmt=con.createStatement();

String id=request.getParameter("id");
String value1=request.getParameter("value1");
String value2=request.getParameter("value2");
if (id==null){id="0";}
if (value1==null){value1="0";}
if (value2==null){value2="0";}


if (!id.equalsIgnoreCase("0")){
	query="select * from reports where rep_id="+id;
	rs = stmt.executeQuery(query);
	while(rs.next()){
	rep_title=rs.getString("rep_title");
	repquery=rs.getString("rep_query");
					}
							}
%>

<html>
<head>
<link href="../../styles/text.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../Script/datepicker.js"></script>
</head>
<body>
<input type="hidden" id="id" name="id" value=<%=id%> >
 
<table>
	<tr><td  colspan="2" class="Headings" align="left" width="100%" ><%=rep_title %></td></tr>
	<tr><td valign="top">
		<table width="10%" class="border">
				<tr><td class="content style1"><b> State </b></td>
				<td>
					<select id="state" name="state" onchange="param1()" class="content style1">
						<option value="0">--Please Select--</option>
						<% 
						List<locationBean> list1 =location.viewStates();
						Iterator<locationBean> S = list1.iterator(); 
						while (S.hasNext()) {
						obj = (locationBean)S.next();
						%>
						<option value="<%=obj.getStateid()%>"><%=obj.getSname()%></option>
						<% if(obj.getStateid()==Integer.parseInt(value1)){%>
						<option value="<%=value1%>" selected ><%=obj.getSname()%></option> 
						<%} 
								}%>
					</select>
				</td>
			</tr>
			<tr><td class="content style1"><b> District</b> </td>
				<td>
					<select id="district" name="district" onchange="param2()" class="content style1">
							<option value="0">--Please Select--</option>
							<% 
							List<locationBean> list2 =location.viewDistrict(Integer.parseInt(value1));
							Iterator<locationBean> D = list2.iterator(); 
							while (D.hasNext()) {
							obj = (locationBean)D.next();
							%>
							<option value="<%=obj.getDistrict_id()%>" ><%=obj.getDname()%></option>
							<% if(obj.getDistrict_id()==Integer.parseInt(value2)){%>
							<option value="<%=value2%>" selected ><%=obj.getDname()%></option>
							<%}
									}%>
				
					</select>
				</td>
			</tr> 
		</table>
	</td>
	<td valign=top>
	<table width="100%" id="stretch" class="border"  border="1" cellspacing="0">
	<%


try {
pst = con.prepareStatement(repquery); 
pst.setString(1,value1);
pst.setString(2,value2);
rs = pst.executeQuery();

}
catch (Exception e) {
		out.println ("<tr class=red><td colspan=2>Oh oops - check your SQL\n -"+repquery+"  - "+e+"</td></tr>");
                }



md = rs.getMetaData();
int count = md.getColumnCount();
//out.println(count);

%>
<tr class="Blue-content">
<%
for (int i=1; i<=count; i++) {
	out.print("<td>");
	out.print(md.getColumnName(i).toUpperCase());
	out.print("</td>");
	}
out.println("</tr>");

while(rs.next()){
%>
<tr  class="readonly">
<%	for (int i=1; i<=count; i++) {
		out.print("<td>");
		out.print(rs.getString(i));
		out.print("</td>");
	}
	out.println("</tr>");
}


%>

</tr></table>
</td></tr>
</table>

<%
rs.close();
%>

</body>
</html>
