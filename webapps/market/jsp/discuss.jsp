<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%!
	Connection con=null;
	ResultSet rs=null;
	ResultSet rs1=null;
	Statement stmt=null;
	Statement stmt1=null;
	String query="";
	String query1="";
	
%>

<%

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
	out.println("Exception"+e);

}


String act = request.getParameter("act");
Integer vid=0;
String vremarks="";
String vsubject="";
String vuser=(String)session.getAttribute("userr");

//out.println(vuser);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> WMS Dash Board </TITLE>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
<style type="text/css">
/* Menu container */
.menu	{
	border:solid #FF9900 1px;
	padding:10px 5px 10px 5px;

	}

/* Menu styles */
.menu ul
	{
	margin:0px;
	padding:0px;
	text-decoration:none;
	}
.menu li
	{
	margin:0px 0px 0px 5px;
	padding:0px;
	list-style-type:none;
	text-align:left;
	font-family:Arial,Helvetica,sans-serif;
	font-size:13px;
	font-weight:normal;
	}

/* Submenu styles */
.menu ul ul 
	{
	background-color:#F6F6F6;
	}
.menu li li
	{
	margin:0px 0px 0px 16px;
	}

/* Symbol styles */
.menu .symbol-item,
.menu .symbol-open,
.menu .symbol-close
	{
	float:left;
	width:16px;
	height:1em;
	background-position:left center;
	background-repeat:no-repeat;
	}
.menu .symbol-item  { background-image:url(../images/icons/page.png); }
.menu .symbol-close { background-image:url(../images/icons/plus.png);}
.menu .symbol-open  { background-image:url(../images/icons/minus.png); }
.menu .symbol-item.last  { }
.menu .symbol-close.last { }
.menu .symbol-open.last  { }

/* Menu line styles */
.menu li.item  { font-weight:normal; }
.menu li.close { font-weight:normal; }
.menu li.open  { font-weight:bold; }
.menu li.item.last  { }
.menu li.close.last { }
.menu li.open.last  { }

a.go:link, a.go:visited, a.go:active
        {
        display:block;
        height:26px;
        width:100px;
        background-color:#FFFFFF;
        color:#333333;
        font-family:Arial,Helvetica,sans-serif;
        font-size:12px;
        font-weight:bold;
        text-align:right;
        text-decoration:none;
        line-height:26px;
        padding-right:30px;
        background-image:url(go.gif);
        background-position:right;
        background-repeat:no-repeat;
        }
a.go:hover
        {
        text-decoration:none;
        color:#488400;
        }
#example3 { width:40%; background-color:#F9F9F9; padding:0px; margin-left:24px; }
#example3 li { list-style:none; margin:1px 0px; }
#example3 li a { display:block; height:16px; padding:0px 4px; background-color:#EEEEFF; }
#example3 li ul { margin:0px; padding:0px; }
#example3 li ul li a { background-color:#F9F9F9; border-bottom: solid #ECECEC 1px; padding-left:20px; }
</style>

<script src="../Script/TreeMenu.js" type="text/javascript"></script>
</HEAD>

<BODY>
<% if ("Add".equalsIgnoreCase(act)) { %>
<form action="discuss.jsp" method="post" name="frmadd" >
<table width="100%" border="0" cellpadding="1" >
<tr>
			<td  align="right" colspan="2">
			<button type="submit" class="button-image" name="act" value="Insert"> <img src="../images/icon_save.png"  height="30" width="30" alt="Add" /></button>
			<button type="submit" class="button-image" name="act" value="All" > <img src="../images/icon_delete.png"  height="30" width="30" alt="Cancel" /></button>
			</td>
</tr>
<tr><td class="Blue-content"> Subject :</td><td><input class="content style1" type="text" name="txtSubject" value=""><td></tr>
<tr><td class="Blue-content"> Description :</td><td class="content style1"> <TEXTAREA id = "txtRemarks" Name="txtRemarks" class="content style1" rows="4" cols="100" ></TEXTAREA><td></tr>
</table>
</form>
<%} else {%>

<form action="discuss.jsp" method="post" name="frmadd" >
<table width="100%" border="0"  >
<tr>
			<td  align="right">
			<button type="submit" class="button-image" name="act" value="Add"> <img src="../images/icon_add.png"  height="30" width="30" alt="Add" /></button>
			<!-- <button type="submit" class="button-image" name="act" value="Edit"> <img src="../images/icon_edit.png"  height="30" width="30" alt="Edit" /></button>
			<button type="submit" class="button-image" name="act" value="Delete"> <img src="../images/icon_delete.png"  height="30" width="30" alt="Delete" /></button>
			-->
			</td>
</tr>
</table>
<div class="menu">
<ul id="example">
<%
if ("tsave".equalsIgnoreCase(act)){
	vid=Integer.parseInt(request.getParameter("id"));
	vremarks=request.getParameter("txtRemarks");
	query="insert into discussions (id,parent_id,remarks,user_id) select seq_discuss_id.nextval,"+vid+",'"+vremarks+"',user_id from users where login_name='"+vuser+"'";

	//out.println(query);
	stmt.executeUpdate(query);
}

if ("Insert".equalsIgnoreCase(act)){
	vsubject=request.getParameter("txtSubject");
	vremarks=request.getParameter("txtRemarks");
	query="insert into discussions (id,subject,remarks,user_id)  select seq_discuss_id.nextval,'"+vsubject+"','"+vremarks+"',user_id from users where login_name='"+vuser+"'";
	//out.println(query);
	stmt.executeUpdate(query);
}


query="select id,parent_id,subject,remarks,d.user_id,login_name,to_char(d.date_inserted,'dd/mm/yy hh24:mi') date_inserted  from discussions d, users u where d.user_id=u.user_id and parent_id=0 order by date_inserted desc";
rs=stmt.executeQuery(query);
while(rs.next()){
vid=rs.getInt("id");
%>
<li class="Blue-content"><%=rs.getString("subject")%> [<%=rs.getString("login_name")%>]-[<%=rs.getString("Date_Inserted")%>]
	
	<ul>
		<li><%=rs.getString("remarks")%>
			<a href="discuss.jsp?act=tadd&&id=<%=vid%>"><img src="../images/plus.jpg"  height="10" width="10" alt="Add Thread"/></a>
		</li>
	<% query1="select id,parent_id,subject,remarks,d.user_id,login_name,to_char(d.date_inserted,'dd/mm/yy hh24:mi') date_inserted  from discussions d, users u where d.user_id=u.user_id and parent_id="+vid+" order by date_inserted";
	    rs1=stmt1.executeQuery(query1);
	    while(rs1.next()){ %>
	
		<li class="content style1">[<%=rs1.getString("login_name")%>]-[<%=rs1.getString("Date_Inserted")%>] : <%=rs1.getString("remarks")%>
	
	<%}%>
	<%if ("tadd".equalsIgnoreCase(act)){
			if (Integer.parseInt(request.getParameter("id"))==vid){ %>
			<input type="hidden" name="id" value=<%=vid%> />
			<li><TEXTAREA id = "txtRemarks" Name="txtRemarks" class="content style1" rows="4" cols="100" ></TEXTAREA>
			<button type="submit" class="button-image" name="act" value="tsave"><img src="../images/icon_save.png"  height="30" width="30" alt="save Thread"/></a>
			</li>
			<%}
				}%>	
	</ul>
	
	
	
</li>
<%} %>

</ul>
<script type="text/javascript">make_tree_menu('example');</script>
</div>
</form>
<%} %>
</BODY>
</HTML>
