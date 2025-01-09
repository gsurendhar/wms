<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.io.*"%>
<%@ page language="java" import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %>

<%
 // response.setIntHeader("Refresh",300); //in your case 60*5=300 (for 5 min)
%>

<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
String query="";
%>

<%
con =  ConnectionProvider.getCon();
stmt=con.createStatement();
%>
<html>
<body>
<%try{
  String fName =  "/usr/share/tomcat/webapps/bws/combined.csv";
  String thisLine;
  int count=0;
  FileInputStream fis = new FileInputStream(fName);
  DataInputStream myInput = new DataInputStream(fis);
  int i=0;
%>
<table>
<%
myInput.readLine(); 
while ((thisLine = myInput.readLine()) != null)
{
	String strar[] =new String[] {thisLine};
	//out.println("Sucessfully inserted messages"+strar[0]);
	int vl=strar.length-1;
	if (strar.length > 0) {
        query="insert into ozekimessagein(msg,receivedtime) values(";
for(int j=0;j<strar.length;j++)
        {

        if(j==vl){
                query+="'" +strar[j]+ "'";
                //out.print("'" +strar[j]+ "'");
                }
        else
                {
                //out.print("'" +strar[j]+ "', ");
                query+="'" +strar[j]+ "',";
                }
        }
        query+=",now());";
	stmt.executeUpdate(query);
        i++;
}
}
out.println("Sucessfully inserted "+i+" messages");
}
catch(Exception ex)
        {
                out.println(ex);

        }
%>
</table>
</body>
</html>

