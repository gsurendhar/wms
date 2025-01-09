<%@ page import="java.io.*,java.text.*"%>
<%@page import="java.util.*"%>


<%@page import="com.jobsDao"%>
<%@page import="com.jobsBean"%>
<jsp:useBean id="obj" class="com.jobsBean"/>
<jsp:setProperty property="*" name="obj"/>



<%
								
			String ndate=request.getParameter("ndate");
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			String formattedDate = df.format(new java.util.Date());
			//out.println(formattedDate);

			if(ndate == null){ ndate=formattedDate;	 
			}
			

			int	urec=0;
			
			String jobid =request.getParameter("txtJobid");
	 		String act = request.getParameter("act");
			String jname = request.getParameter("txtName");
			String jinterval = request.getParameter("txtInterval");
			String cmbinterval = request.getParameter("cmbInterval");
			String sqlcode = request.getParameter("txtSqlcode");
			String broken = request.getParameter("cmbEnable");
				
%>
<html>
<head>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../Script/datepicker.js"></script>
<BODY bgcolor="#DBEBFF">
</head>

<body>
<% 	if ("Edit".equalsIgnoreCase(act) ) { %>
<form action="jobs.jsp" method="post" name="frmedit" >
<table width="100%" border="0" cellpadding="1" >
	<tr>
			<td  align="right" colspan="2">
			<button type="submit" class="button-image" name="act" value="Update"> <img src="../images/icon_save.png"  height="30" width="30" alt="Update" /></button>
			<button type="submit" class="button-image" name="act" value="Cancel"> <img src="../images/icon_home.png"  height="30" width="30" alt="Cancel" /></button>
			</td>
	</tr>
	<% if ((jobid == null)){%>
		<script>
		alert("no record selected!");
		 history.go(-1);
		</script>
	<% } else{
		obj.setJobid(Integer.parseInt(jobid));
		jobsDao job = new jobsDao();
		job.getJob(obj); 
		%> 
<tr> <td colspan="2" align="Center" class="maintitle"><%=act%> Job</td><tr> 
	<tr><td class="Blue-content">Job ID</td><td><input type="text" readonly name="txtJobid" class="content style1" size="1" value="<%=obj.getJobid()%>" ></td></tr>
	<tr><td class="Blue-content">Name</td><td><input type="text" name="txtName" class="content style1" size="50" value="<%=obj.getName()%>"> </td></tr>
	<tr><td class="Blue-content">Interval</td><td class="Blue-content"><input type="text" name="txtInterval" class="content style1" size="10"  maxlength="20" value="<%=obj.getInterval()%>">Minutes</td></tr>
	<tr><td class="Blue-content">Disabled Job</td>
	<td>
		<select id="cmbEnable"  name="cmbEnable"  class="content style1">
			 <option value="N">N</option> 
			<option value="Y">Y</option>
			<% if(obj.getBroken().equalsIgnoreCase("N")){%>
					<option value="N" selected ><%="N"%></option>
					<%}%>
			<% if(obj.getBroken().equalsIgnoreCase("Y")){%>
					<option value="Y" selected ><%="Y"%></option>
					<%}%>
			</select>
	</td>
	</tr>
	<tr><td class="Blue-content">SQL Code</td><td> <TEXTAREA id="txtSqlcode" Name="txtSqlcode" class="content style1" rows="4" cols="50" ><%=obj.getWhat()%></TEXTAREA></td></tr>
	<tr><td class="Blue-content">Last Run</td><td><input type="text" readonly name="txtLastdate" class="content style1" size="25" maxlength="100" value="<%=obj.getLdate()%>"> </td></tr>
	<tr><td class="Blue-content">Next Run Date</td>
		<% ndate=obj.getNdate(); %>
		<td class="content style1"><input id="ndate" name="ndate" class="content style1" type="text" size="10" maxlength="12" value=<%=ndate%>>
		<a href="javascript:NewCal('ndate','ddmmyyyy',false)"><img src="../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a>
		<input type="text" name="txtHrs" class="content style1" size="2"  maxlength="2" value="<%=obj.getNhour()%>">:
		<input type="text" name="txtMin" class="content style1" size="2"  maxlength="2" value="<%=obj.getNmin()%>"> Hrs
</td></tr>
	
	<% } %>
</table>
</form>
	
<% } else if ("Add".equalsIgnoreCase(act) ) { %>
<form action="jobs.jsp" method="post" name="frmadd" >
<table width="100%" border="0" cellpadding="1" >
<tr>
			<td  align="right" colspan="2">
			<button type="submit" class="button-image" name="act" value="Insert"> <img src="../images/icon_save.png"  height="30" width="30" alt="Add" /></button>
			<button type="submit" class="button-image" name="act" value="Cancel"> <img src="../images/icon_home.png"  height="30" width="30" alt="Home" /></button>
			</td>
</tr>

<tr> <td colspan="2" align="Center" class="maintitle"><%=act%> Job</td><tr> 
<tr><td class="Blue-content">Name</td><td><input type="text" name="txtName" class="content style1" size="30"  maxlength="50" > </td></tr>
<tr>
	<td class="Blue-content">Interval</td>
	<td><input type="text" name="txtInterval" class="content style1" size="3"  maxlength="5" value="0">
	 
		<select id="cmbInterval" name="cmbInterval"  class="content style1">
			<option value="Minutes">Minutes</option>
			<option value="Hours">Hours</option>
			<option value="Days">Days</option>
		</select> </td>
	</tr>
<tr><td class="Blue-content">Next Run Date</td>
		<td class="content style1"><input id="ndate" name="ndate" class="content style1" type="text" size="10" maxlength="12" value=<%=ndate%>>
		<a href="javascript:NewCal('ndate','ddmmyyyy',false)"><img src="../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a>
		<input type="text" name="txtHrs" class="content style1" size="2"  maxlength="2" value="00">:
		<input type="text" name="txtMin" class="content style1" size="2"  maxlength="2" value="00"> Hrs
</td></tr>


<tr><td class="Blue-content">Disabled</td>
<td><select id="cmbEnable" name="cmbEnable"  class="content style1">
			<option value="N">N</option>
			<option value="Y">Y</option>
		</select> </td>
</tr>
<tr><td class="Blue-content">SQL Code</td><td> <TEXTAREA id = "txtSqlcode" Name="txtSqlcode" class="content style1" rows="4" cols="50" ></TEXTAREA></td></tr>
</table>
</form>
<% } else if (act==null || ("Update".equalsIgnoreCase(act))||("Cancel".equalsIgnoreCase(act))||("Insert".equalsIgnoreCase(act))||("Delete".equalsIgnoreCase(act))) 
	{
	
	if ("Update".equalsIgnoreCase(act)){
		
		obj.setJobid(Integer.parseInt(jobid));
		obj.setName(jname);
		obj.setInterval(Integer.parseInt(jinterval));
		//obj.setInterval_param(cmbinterval);
		obj.setBroken(broken);
		obj.setWhat(sqlcode);
		obj.setNdate(request.getParameter("ndate")+" "+request.getParameter("txtHrs")+":"+request.getParameter("txtMin"));
		jobsDao job = new jobsDao();
		job.updateJob(obj);
	}

	if ("Insert".equalsIgnoreCase(act)){ %>
		
		<%if ((jname.equalsIgnoreCase(""))||(sqlcode.equalsIgnoreCase(""))){ %>
		<script>
		alert("Enter job name and query!");
		 history.go(-1);
		</script>
		<%}else { 
			obj.setName(jname);
			obj.setInterval(Integer.parseInt(jinterval));
			obj.setInterval_param(cmbinterval);
			obj.setWhat(sqlcode);
			obj.setBroken(broken);
			obj.setNdate(request.getParameter("ndate")+" "+request.getParameter("txtHrs")+":"+request.getParameter("txtMin"));
			jobsDao job = new jobsDao();
			job.addjob(obj);
			}
		}
	
	if ("Delete".equalsIgnoreCase(act)){ %>
	<% if ((jobid == null)){%>
	<script>
	alert("no record selected!");
	 history.go(-1);
	</script>
	<%} else {
			jobsDao job = new jobsDao();
			job.delete(Integer.parseInt(jobid));
		}
	}
	
	
act=""; %>
<form action="jobs.jsp" method="post" name="frmeDisplay" >
<table width="100%" border="0"  >
<tr>
			<td  align="right">
			<button type="submit" class="button-image" name="act" value="Add"> <img src="../images/icon_add.png"  height="30" width="30" alt="Add" /></button>
			<button type="submit" class="button-image" name="act" value="Edit"> <img src="../images/icon_edit.png"  height="30" width="30" alt="Edit" /></button>
			<button type="submit" class="button-image" name="act" value="Delete"> <img src="../images/icon_delete.png"  height="30" width="30" alt="Delete" /></button>
			</td>
</tr>
<tr> <td colspan="9" align="Center" class="Headings">Jobs List</td><tr>
<tr><td>
	<table width="100%" border="1" class="queue-summary" >
		<tr class="Blue-content" align="center"><td >ID</td><td>Job Name</td>
		<td>Interval(Minutes)</td><td>Next Run</td><td>Last Run</td><td>Broken?</td><td>SQL Code</td>
		<td>Added Date</td>
		<td>Select</td></tr>
		
		<% jobsDao job = new jobsDao();
			List<jobsBean> list =job.viewAlljobs();
			Iterator<jobsBean> i = list.iterator();
			int x =0;
			while (i.hasNext())	{
				x++;
				obj = (jobsBean)i.next();
				if ( (x%2) == 0 ) { %>
			<tr class="oddline" > <%} else { %><tr class="evenline" >  <%}%>
			<tr class="content style1" align="center"> 
		<td><%=x%></td><td><%=obj.getName()%></td><td align="center"><%=obj.getInterval()%></td><td><%=obj.getNdate()%></td>
		
		<%if (obj.getLdate()==null){ %><td>-</td><%} else{ %> <td><%=obj.getLdate()%></td><%} %>
		
		<td align="center"><%=obj.getBroken()%></td><td><%=obj.getWhat()%></td>
		<td><%=obj.getIdate()%></td>
		<td><input type="radio" name="txtJobid" value=<%=obj.getJobid()%>></td>
		</tr>
		<% }
			if(x==0)  {	/*To write to the server if the resultset is null*/
		%>
				<tr><th colspan=6 class="content style1">No jobs found</th></tr>		
		<%} %>
		
		 <% } 
		
		%>
		</table>
</tr>
</table>
</form>
</body>
</html>

