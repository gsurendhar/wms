<%@page import="com.LoginDao"%>
<jsp:useBean id="obj" class="com.LoginBean"/>

<jsp:setProperty property="*" name="obj"/>

<%
LoginDao user = new LoginDao();
user.login(obj);

String login=obj.getUname();
String pass=obj.getPass();
String username=obj.getUsername();
int role=obj.getRole();
if (obj.isStatus()){
	
session.setAttribute("session","TRUE");
session.setAttribute("theName",login);
session.setAttribute("theRole",role);
session.setAttribute("theId",obj.getUid());
session.setAttribute("theOid",obj.getOrg_id());

response.sendRedirect("jsp/home.jsp");
%>

	
<%
}
else
{
out.print("Sorry, Login name  or password error");
%>
<jsp:include page="index.jsp"></jsp:include>
<%
}
%>