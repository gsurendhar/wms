<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.io.*"%>
<%@ page language="java" import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %>

<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
String query="";
%>

<%
con =  ConnectionProvider.getCon();
stmt=con.createStatement();
Integer vlid=73150;
 rs=stmt.executeQuery("select max(id) from (select max(id) as id from ozekimessagein  union select max(id) as id from ozekimessagein_backup )as x");
 while(rs.next()){
 vlid=rs.getInt(1);
 }
%>


<%try {
String u = "http://localhost/wms/messages3.jsp";
u+="?lid="+vlid+"&&sid=KANCHI";
System.out.println(u);
//System.out.println(vlid);
String f = "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/kanchi/getcsv.txt";
//out.println(f);

URL url = new URL(u);
URLConnection connection = url.openConnection();
InputStream stream = connection.getInputStream();
BufferedInputStream in = new BufferedInputStream(stream);
FileOutputStream file = new FileOutputStream(f);
BufferedOutputStream out1 = new BufferedOutputStream(file);

          int bufSizeHint = 8 * 1024;
      int read = -1;
      byte[] buf = new byte[bufSizeHint];
      while ((read = in.read(buf, 0, bufSizeHint)) >= 0) {
          out1.write(buf, 0, read);
      }
      out1.flush();
          out1.close();
          out.println("Sucess");
}
catch(Exception ex)
        {
                out.println(ex);

        }
 %>

<html>
<body>
<%
   String fName =  "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps/kanchi/getcsv.txt";
   String thisLine;
  int count=0;
  FileInputStream fis = new FileInputStream(fName);
  DataInputStream myInput = new DataInputStream(fis);
  int i=0;
%>
<table>
<%
while ((thisLine = myInput.readLine()) != null)
{
String strar[] = thisLine.split(";");


int vl=strar.length-1;
//out.println(strar.length);
if (strar.length > 2) {
        query="insert into ozekimessagein(id,receivedtime,msg) values(";
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
        query+=");";
       // out.println(query);
        //stmt.executeUpdate("insert into ozekimessagein(id,msg,receivedtime) values("+query+")");
        //query1="insert into ozekimessagein(id,msg,receivedtime) values("+query+")";

        stmt.executeUpdate(query);
        i++;

        }

}
out.println("Sucessfully inserted "+i+" messages");
%>
</table>
</body>
</html>

