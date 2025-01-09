<%@ page language="java" import="com.ConnectionProvider" %> 
<%@ page import="java.sql.*"%>
<%
	response.setContentType("text/html");
String sid=request.getParameter("sid");
String did=request.getParameter("did");

//out.println(sid);
//out.println(did);

String vtxtcounty=request.getParameter("optCounty");
String vtxtdistrict=request.getParameter("optDistrict");
String vtxtclientid=request.getParameter("txtclientid");
String vtxtLocation=request.getParameter("txtLocation");
String vtxtAddress=request.getParameter("txtAddress");
String vtxtLongitude=request.getParameter("txtLongitude");
String vtxtLatitude=request.getParameter("txtLatitude");
String vtxtAltitude=request.getParameter("txtAltitude");
String vtxtstn_sim=request.getParameter("txtstn_sim");
String vtxtdatafreq=request.getParameter("txtdatafreq");
String vtxtcommfreq=request.getParameter("txtcommfreq");
String vtxtwindavg=request.getParameter("txtwindavg");
String vtxtcalibrationrain=request.getParameter("txtcalibrationrain");
String vtxtcalibrationwind=request.getParameter("txtcalibrationwind");
String vtxtsrv_sim=request.getParameter("txtsrv_sim");
String vtxtsrv_sim_bkp1=request.getParameter("txtsrv_sim_bkp1");
String vtxtsrv_sim_bkp2=request.getParameter("txtsrv_sim_bkp2");
/*String vtxtparamtime1=request.getParameter("txtparamtime1");
String vtxtparamtime2=request.getParameter("txtparamtime2");
String vtxtparamtime3=request.getParameter("txtparamtime3");
String vtxtfutureexpansion=request.getParameter("txtfutureexpansion");
String vtxtnumsettings=request.getParameter("txtnumsettings");
String vtxtphnumbers=request.getParameter("txtphnumbers");
String vtxtactivate=request.getParameter("txtactivate");
String vtxtwatchdog=request.getParameter("txtwatchdog");
String vtxtflash=request.getParameter("txtflash"); */
String vtxtcontact_phone=request.getParameter("txtcontact_phone");
String vtxtcontact_person=request.getParameter("txtcontact_person");
//String vtxtadditionalcommands=request.getParameter("txtadditionalcommands");
String vtxtemailid=request.getParameter("txtemailid");
String cmd=request.getParameter("action");
String vtxtcalias=request.getParameter("txtCalias");

String vtxtoperator=request.getParameter("optOperartor");
String vtxtwmsl=request.getParameter("txtwmsl");
String vtxtmslp=request.getParameter("txtmslp");



//out.println(vtxtcounty);
out.println(vtxtoperator);

	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	String query="";


    try{
        con = ConnectionProvider.getCon();
		stmt=con.createStatement();
	}catch(Exception e){
			System.out.println(e.getMessage());
		  }

  if(cmd.equalsIgnoreCase("save"))
  {
     
    
       query= "update station_configs_det set location='"+vtxtLocation+"',Longitude='"+vtxtLongitude+"',Latitude='"+vtxtLatitude+"', Altitude='"+vtxtAltitude+"', stn_sim='"+vtxtstn_sim+"', datafreq='"+vtxtdatafreq+"', commfreq='"+vtxtcommfreq+"', windavg='"+vtxtwindavg+"', calibrationrain='"+vtxtcalibrationrain+"', calibrationwind='"+vtxtcalibrationwind+"', srv_sim='"+vtxtsrv_sim+"', srv_sim_bkp1='"+vtxtsrv_sim_bkp1+"', srv_sim_bkp2='"+vtxtsrv_sim_bkp2+"',  contact_person='"+vtxtcontact_person+"', contact_phone='"+vtxtcontact_phone+"', emailid='"+vtxtemailid+"',address='"+vtxtAddress+"'";
       if (vtxtcalias!=null){ query+=",client_alias='"+vtxtcalias+"'";}
	   if (vtxtcounty!=null){ query=query+" ,county='"+vtxtcounty+"'";}
	   if (vtxtdistrict!=null){query=query+" ,district='"+vtxtdistrict+"'";	}
	   if (vtxtwmsl!=null){query=query+" ,wmsl='"+vtxtwmsl+"'"; } 
	   if (vtxtmslp!=null){query=query+" ,mslpoint1='"+vtxtmslp+"'"; } 
 
		if (vtxtoperator!=null){
			query=query+" ,operator='"+vtxtoperator+"'";
		}
		 
		 query=query+" where clientid="+vtxtclientid;

	 out.println(query);
	  stmt.executeUpdate(query);
 //response.sendRedirect("/wms/jsp/StationConfig.jsp?value1="+sid+"&&value2="+did+"&&value3=0&&value4="+vtxtclientid);	  
	}

  if(cmd.equalsIgnoreCase("insert"))
  {
       
		   //query= "Insert into station_configs_det(clientid,location,Longitude,Latitude,Altitude,stn_sim,datafreq,commfreq,paramtime1,paramtime2,paramtime3,windavg,calibrationrain,calibrationwind,srv_sim,srv_sim_bkp1,srv_sim_bkp2,futureexpansion,numsettings,phnumbers,activate,watchdog,flash,contact_person,additionalcommands,emailid,address,state,district,county)  values ("+vtxtclientid+", '"+vtxtLocation+"', '"+vtxtLongitude+"','"+vtxtLatitude+"', '"+vtxtAltitude+"','"+vtxtstn_sim+"','"+vtxtdatafreq+"', '"+vtxtcommfreq+"','"+vtxtparamtime1+"','"+vtxtparamtime2+"','"+vtxtparamtime3+"','"+vtxtwindavg+"','"+vtxtcalibrationrain+"','"+vtxtcalibrationwind+"','"+vtxtsrv_sim+"','"+vtxtsrv_sim_bkp1+"','"+vtxtsrv_sim_bkp2+"','"+vtxtfutureexpansion+"','"+vtxtnumsettings+"','"+vtxtphnumbers+"','"+vtxtactivate+"','"+vtxtwatchdog+"','"+vtxtflash+"','"+vtxtcontact_person+"','"+vtxtadditionalcommands+"','"+vtxtemailid+"','"+vtxtAddress+"',"+sid+","+did+","+vtxtcounty+")";
	   query= "Insert into station_configs_det(clientid,location,Longitude,Latitude,Altitude,stn_sim,datafreq,commfreq,windavg,calibrationrain,calibrationwind,srv_sim,srv_sim_bkp1,srv_sim_bkp2,contact_person,contact_phone,emailid,address,state,district,county,Operator)  values ("+vtxtclientid+", '"+vtxtLocation+"', '"+vtxtLongitude+"','"+vtxtLatitude+"', '"+vtxtAltitude+"','"+vtxtstn_sim+"','"+vtxtdatafreq+"', '"+vtxtcommfreq+"','"+vtxtwindavg+"','"+vtxtcalibrationrain+"','"+vtxtcalibrationwind+"','"+vtxtsrv_sim+"','"+vtxtsrv_sim_bkp1+"','"+vtxtsrv_sim_bkp2+"','"+vtxtcontact_person+"','"+vtxtcontact_phone+"','"+vtxtemailid+"','"+vtxtAddress+"',"+sid+","+did+",'"+vtxtcounty+"','"+vtxtoperator+"')";

	//out.println(query);
	stmt.executeUpdate(query);

//response.sendRedirect("/wms/jsp/StationConfig.jsp?value1="+sid+"&&value2="+did+"&&value3="+vtxtcounty+"&&value4="+vtxtclientid);
	}

//response.sendRedirect("/wms/jsp/StationConfig.jsp?value1="+sid+"&&value2="+did+"&&value3="+vtxtcounty+"&&value4="+vtxtclientid);
response.sendRedirect("StationConfig.jsp?search="+vtxtclientid);
%>

