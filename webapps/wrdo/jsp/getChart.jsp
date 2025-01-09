<%@ page import="java.io.*" %>  
<%@ page import="org.jfree.chart.JFreeChart" %>  
<%@ page import="org.jfree.chart.ChartUtilities" %>  

<%@ page  import="java.awt.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import ="org.jfree.data.general.*"%>

<!-- Sesssion Management -->
<%if(null == session.getAttribute("theName")){  
  // User is not logged in.
  out.println("your Session has expired");
  response.sendRedirect("../index.html?invalid=0");
}
%>
<!-- End of Sesssion Management -->

<%  

String v1=request.getParameter("v1");
String v2=request.getParameter("v2");
String v3=request.getParameter("v3");
String v4=request.getParameter("v4");
String v5=request.getParameter("v5");
String v6=request.getParameter("v6");
String v7=request.getParameter("v7");
String d1=request.getParameter("d1");
String d2=request.getParameter("d2");
String d3=request.getParameter("d3");
String d4=request.getParameter("d4");
String d5=request.getParameter("d5");
String d6=request.getParameter("d6");
String d7=request.getParameter("d7");

 try 
 {  
 File image = File.createTempFile("image", "tmp");
 
 
 // Assume that we have the chart 
     final DefaultPieDataset data = new DefaultPieDataset();
			data.setValue(d1+"="+v1, new Double(v1));
            data.setValue(d2+"="+v2, new Double(v2));
			
		if (v3!=null){data.setValue(d3, new Double(v3));}
		if (v4!=null){data.setValue(d4, new Double(v4));}
		if (v5!=null){data.setValue(d5, new Double(v5));}
		if (v6!=null){data.setValue(d6, new Double(v6));}
		if (v7!=null){data.setValue(d7, new Double(v7));}
           //JFreeChart chart = ChartFactory.createPieChart("Pie Chart ", data, false, false, false);
	JFreeChart chart = ChartFactory.createPieChart3D("", data, true, true, false);



 //
 ChartUtilities.saveChartAsPNG(image, chart, 200, 175);  

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
