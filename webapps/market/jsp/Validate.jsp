<!--
     File : Validate.jsp

 -->

<HTML>

<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.*" %>

<%@ page session="true" %>
<head>
	<LINK href="styles.css" type="text/css" rel="stylesheet">

<head>
<jsp:include page="MultiLevelmenu.htm"/><br><br><br>
<body Class=SC>
<%@ include file = "Header.html" %>
<BR><BR><BR>
<FONT FACE="Century Gothic">

<%! String user_id; %>
<%! String pass_word; %>
<%! int flag=0;  %>


<%

/*Declaration of variables*/

Connection con=null;
Statement stmt=null;
ResultSet rs=null;

%>

<%-- Retrieve parameters from Session --%>


<% user_id = request.getParameter("uid");
   pass_word = request.getParameter("pwd");
  
  System.out.println("user_id = "+user_id+"\t"+"pass_word = "+pass_word);
%>

<%

/*Checking for userid and password*/

if(pass_word.equals("") || user_id.equals(""))
{
	//System.out.println("Redirecting to login to fill all credentials..");
%>
	<jsp:forward page="Login.jsp">
		<jsp:param name="error" value="blankfields" />
   	      </jsp:forward>
<%
}
%>


<%
try
{
	Class.forName("oracle.jdbc.driver.OracleDriver"); 
	con = DriverManager.getConnection( "jdbc:oracle:thin:@localhost:1521:xe", "share", "abc123"); 
	stmt =  con.createStatement();

	/*Retrives data from the database*/
	rs = stmt.executeQuery("SELECT login_name,user_password,user_role from users where login_name ='"+user_id +"' and user_password='"+pass_word+"'");
	//System.out.println(rs);

	while(rs.next())
	{
	       	if(user_id.equals(rs.getString(1)) && pass_word.equals(rs.getString(2)))
	         { 
        	    System.out.println("User has successfully logged in...");
				/*Puts the username and connection variable to session*/
				session.setAttribute("userr",user_id);
				session.setAttribute("connection",con);
				int value = rs.getInt(3);
				if(!(value < 0 ))	session.setAttribute("theRole",new Integer(value));
        	    flag=1;
      
			 }
	}

}

catch(Exception e)
{
	System.out.println("Exception"+e);
}
%>


<%
	/*If username and password is validated, then the user is redirected to homepage*/
	if(flag==1)
	{
	flag=0;
%>	 
	<jsp:forward  page="home.jsp"/> 
<%
	}
	else
	{
	/*If username and password is not valid, then the user is redirected back to Loginpage*/
%>
	<jsp:forward page="Login.jsp">
	<jsp:param name="error" value="invalid" />
   	</jsp:forward>
	
<%
	}
%>



</BODY>
</HTML>
