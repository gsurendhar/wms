
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %> 

<%@ page import="java.io.*" %>  
<%@ page import="org.jfree.chart.JFreeChart" %>  
<%@ page import="org.jfree.chart.ChartUtilities" %>  

<%@ page  import="java.awt.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import ="org.jfree.data.general.*"%>
<%@ page  import="org.jfree.data.category.*"%>

<%@ page  import ="org.jfree.chart.ChartFactory" %>
<%@ page  import ="org.jfree.chart.ChartPanel" %>
<%@ page  import ="org.jfree.chart.axis.NumberAxis" %>
<%@ page  import ="org.jfree.chart.plot.PlotOrientation" %>
<%@ page  import ="org.jfree.chart.plot.XYPlot" %>
<%@ page  import ="org.jfree.chart.renderer.xy.XYLineAndShapeRenderer" %>
<%@ page  import ="org.jfree.data.xy.XYSeriesCollection" %>
<%@ page  import ="org.jfree.data.xy.XYDataset" %>
<%@ page  import ="org.jfree.data.xy.XYSeries" %>

<%@ page  import ="org.jfree.ui.ApplicationFrame" %>
<%@ page  import ="org.jfree.ui.RefineryUtilities" %>

<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
String query="";
%>

<!-- Sesssion Management -->
<%if(null == session.getAttribute("theName")){  
  // User is not logged in.
  out.println("your Session has expired");
  response.sendRedirect("../index.html?invalid=0");
}
%>
<!-- End of Sesssion Management -->

<html>
<head>
<TITLE> Station Statistics </TITLE>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
con = ConnectionProvider.getCon();
stmt=con.createStatement();

query="select count(1) as Total,sum(case when percent is null then 1 end) as Norep,sum(case when percent >=90 then 1 end)as reporting90,sum(case when percent >=80 and percent <90 then 1 end)as reporting80,sum(case when percent >=70 and percent <80 then 1 end)as reporting70, sum(case when percent >=60 and percent <70 then 1 end)as reporting60, sum(case when percent >=50 and percent <60 then 1 end)as reporting50, sum(case when percent <50  then 1 end)as rep50less from (select st.clientid, st.datafreq,packet_count,minutes, minutes/st.datafreq,cast(packet_count*100/(minutes/st.datafreq) as integer) as Percent  from station_configs_det as st left outer join (select clientid,count(distinct (to_Char(packet_date,'YYYYMMDD HH24'))) as packet_count,((EXTRACT(epoch FROM CURRENT_TIMESTAMP)-EXTRACT(epoch FROM CURRENT_TIMESTAMP - Interval '1 DAY'))/60) as minutes from data_packets  where packet_date >= CURRENT_TIMESTAMP - Interval '1 DAY' group by clientid) as a on (st.clientid=a.clientid) where st.activate!=0) as x";


rs=stmt.executeQuery(query);
Integer vTotal=0;
Integer vNorep=0;
Integer v90=0;
Integer v80=0;
Integer v70=0;
Integer v60=0;
Integer v50=0;
Integer v40=0;


int DisRow=0;
while(rs.next()){ 
	vTotal=rs.getInt(1);
	vNorep=rs.getInt(2) ;
	v90= rs.getInt(3) ;
	v80= rs.getInt(4) ;
	v70= rs.getInt(5) ;
    v60= rs.getInt(6) ;
    v50= rs.getInt(7) ;
    v40= rs.getInt(8) ;

	DisRow++;
	}
%>

<%  
 try 
 {  
 File image = File.createTempFile("image", "tmp");
final DefaultCategoryDataset dataset = new DefaultCategoryDataset();
 dataset.addValue(v90, "90-100%", "");
 dataset.addValue(v80, "80-90%", "");
 dataset.addValue(v70, "70-80%", "");
dataset.addValue(v60, "60-70%", "");
dataset.addValue(v50, "50-60%", "");
dataset.addValue(v40, "<50%", "");
dataset.addValue(vNorep, "Not Working", "");
JFreeChart chart = ChartFactory.createBarChart3D("", "Working", "Stations", dataset, PlotOrientation.VERTICAL,true, true, false);

 //
 ChartUtilities.saveChartAsPNG(image, chart, 300, 280);  

 FileInputStream fileInStream = new FileInputStream(image);  
 OutputStream outStream = response.getOutputStream();     

 long fileLength;  
 byte[] byteStream;  

 fileLength = image.length();  
 byteStream = new byte[(int)fileLength];  
 fileInStream.read(byteStream, 0, (int)fileLength);  

 response.setContentType("image/png");  
 response.setContentLength((int)fileLength);  
 response.setHeader("Cache-Control", "no-store,no-cache, must-revalidate, post-check=0, pre-check=0");  
 response.setHeader("Pragma", "no-cache");  

 fileInStream.close();  
 outStream.write(byteStream);  
 outStream.flush();  
 outStream.close();  
 }  
 catch (IOException e)  
 {  
 System.err.println("Problem occurred creating chart.");  
 }  

   

%> 

</body>
</html>