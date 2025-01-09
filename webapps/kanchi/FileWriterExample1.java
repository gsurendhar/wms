
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
//import java.sql.SQLException;
import java.sql.Statement;
//import java.sql.PreparedStatement;
import java.io.FileWriter;  

public class FileWriterExample1 {  
    public static void main(String args[]){    

 
		 try{  		   
			    FileWriter fw=new FileWriter("/opt/apache-tomcat-7.0.94/webapps/bws/map/layers/Bihar_AWSmasterdata_ARG_2.js");  
           fw.write("var json_Bihar_AWSmasterdata_ARG_2 = {");
		   fw.append("\n");
		   fw.append("\"type\": \"FeatureCollection\",");
fw.append("\n");
fw.append("\"name\": \"Bihar_AWSmasterdata_ARG_2\",");		  
fw.append("\n");
fw.append("\"crs\": { \"type\": \"name\", \"properties\": { \"name\": \"urn:ogc:def:crs:OGC:1.3:CRS84\" } },");	
fw.append("\n");
fw.append("\"features\": [");

 // String JDBC_DRIVER = "org.postgresql.Driver";  
  String DB_URL = "jdbc:postgresql://192.168.1.176:5432/bws";

   //  Database credentials
  String USER = "postgres";
  String PASS = "obel123";
     Connection conn = null;
   Statement stmt = null;


				Class.forName("org.postgresql.Driver");
				conn = DriverManager.getConnection(DB_URL, USER, PASS);

             stmt = conn.createStatement();

      String sql = "SELECT p.clientid,p.district,p.block,p.location,to_char(d.packet_date,'dd-mm-yyyy hh24:mi') odate,p.latitude,p.longitude,d.rain from aws_stations p,data_packets d where p.clientid=d.clientid and id in (select max(id) from data_packets group by clientid) ";
      ResultSet rs = stmt.executeQuery(sql);
      
      while(rs.next()){

	
	  fw.append("{ \"type\": \"Feature\", \"properties\": { \"ClientID\": "+rs.getInt("clientid")+", \"District\": \""+rs.getString("district")+"\", \"Block\": \""+rs.getString("block")+"\", \"Location\": \""+rs.getString("location")+"\", \"Date_Time\": \""+rs.getString("odate")+"\", \"latitude\": "+rs.getFloat("latitude")+", \"longitude\": "+rs.getFloat("longitude")+", \"Rain(mm)\": "+rs.getFloat("rain")+" }, \"geometry\": { \"type\": \"Point\", \"coordinates\": [ "+rs.getFloat("longitude")+", "+rs.getFloat("latitude")+" ] } },");
	 
	  fw.append("\n");
      }
      rs.close();
	
        


fw.append("]}");

           fw.close();    
          }catch(Exception e){System.out.println(e);}    
          System.out.println("Success...");    
     }    
}  