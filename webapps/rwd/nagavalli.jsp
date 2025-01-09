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

String vlid="";
String vDatetime="";
 rs=stmt.executeQuery(" select x.clientid,coalesce(y.packet_date,'NA') as packet_date, y.water_level from station_configs_det as x left outer join (select a.clientid,to_char(a.packet_date,'dd/mm/yyyy hh24:mi') as packet_date,round(cast(water_level as decimal),2) as water_level from data_packets a, (select clientid,max(packet_date) as packet_date from data_packets where water_level is not null group by clientid ) as b where a.packet_date>=current_date- INTERVAL '6 hours' and a.clientid=b.clientid and a.packet_date=b.packet_date and  packet_type='D'  ) as y on (x.clientid=y.clientid) where x.clientid= 6000002;");
 while(rs.next()){
vDatetime=rs.getString(2);
 vlid=rs.getString(3);
 }
%>


<%try {
//String u = "http://api.msg91.com/api/v2/sendsms?authkey=180627AxbOUxrk2hP59ef82a0&mobiles=9398984284&message=hi&sender=Rivers&route=4&country=91";
String u = "http://api.msg91.com/api/v2/sendsms?authkey=180627AxbOUxrk2hP59ef82a0&mobiles=9959907790,8978080201,8978080215";
u+="&message= Nagavali water level is:"+vlid+"m  and dateandtime is:"+vDatetime+" &sender=rivers&route=4&country=91";
System.out.println(u);
String f = "/opt/apache-tomcat-7.0.94/webapps/rwd/getcsv.txt";
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
          out.println("Nagavali data Sucessfully sent");
}
catch(Exception ex)
        {
                out.println(ex);

        }
 %>


