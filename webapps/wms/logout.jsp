<%
if(session.getAttribute("userName") != null)
	session.removeAttribute("userName");
if(session.getAttribute("roleId") != null)
	session.removeAttribute("roleId");
%>
