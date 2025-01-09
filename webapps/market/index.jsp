<HTML>
<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.util.*" %>
<head>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	history.go(+1);
	//-->
	</SCRIPT>
	
	
 
	<LINK href="styles/styles.css" type="text/css" rel="stylesheet">
</head>

<!--Declaration of varaibles-->

<%! String errormsg ;%>
<%! String disluserid ;%>
<%! String dislpwd ;%>


<% 
   /*Retreiving user id and password*/
    disluserid = request.getParameter("uid");
    if(disluserid == null)
    disluserid = "";
    dislpwd = request.getParameter("pwd");
    if(dislpwd == null)
    dislpwd = "";
%>

<%  errormsg = request.getParameter("error") ;
    //System.out.println("errormsg = "+errormsg);
    if (errormsg == null)
    {
        //System.out.println("Error messages was null so clearing it..");
        errormsg = " ";
    }
    if(errormsg.equals("blankfields"))
    {
      %>
       <FONT COLOR="Red">
       Both the fields are Mandatory.Please fill up both fields.<BR><BR>
      <%
    }  
    if(errormsg.equals("invalid"))
    {
      %>
        <FONT COLOR="Red">
        Invalid Username and/or Password. Please re-enter. <BR><BR>
        <%
    } 
%>

<%-- ***** LOGIN SCREEN ***** --%>


 
 
<FORM NAME="LOGIN" ACTION="Validate.jsp" METHOD="POST" >
<BODY CLASS=SC onload="document.LOGIN.uid.focus();">
		<FONT COLOR="black">Enter your UserID and password to login<BR><BR></FONT>&nbsp;&nbsp;&nbsp;&nbsp;
		Userid   &nbsp;&nbsp;<input TYPE=text id = "usr" name=uid size="8" maxlength="8" /> <BR><BR>
		Password : <input TYPE=password name=pwd size="8"  maxlength="8" /><BR><BR>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
	
		<INPUT TYPE=submit name=submit value="Sign-in" />
		<INPUT TYPE=reset name=resett value="Reset" /> 
</FORM>

</BODY>
</HTML>
