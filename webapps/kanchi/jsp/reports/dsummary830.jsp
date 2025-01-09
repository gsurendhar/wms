<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" import="com.ConnectionProvider" %> 
<%@ page import="java.text.*" %>

<script>

function params(){
var vid1 = document.getElementById("state").value
var vid2 =document.getElementById("district").value
var vfdate= document.getElementById("fdate").value
var vtdate= document.getElementById("tdate").value
window.location.replace("dsummary830.jsp?value1="+vid1+"&&value2="+vid2+"&&vfdate="+vfdate+"&&vtdate="+vtdate);
}

// Quick and simple export target #table_id into a csv
function download_table_as_csv(tblCustomers, separator = ',') {
    // Select rows from table_id
    var rows = document.querySelectorAll('table#' +tblCustomers + ' tr');
    // Construct csv
    var csv = [];
    for (var i = 0; i < rows.length; i++) {
        var row = [], cols = rows[i].querySelectorAll('td, th');
        for (var j = 0; j < cols.length; j++) {
            // Clean innertext to remove multiple spaces and jumpline (break csv)
            var data = cols[j].innerText.replace(/(\r\n|\n|\r)/gm, '').replace(/(\s\s)/gm, ' ')
            // Escape double-quote with double-double-quote (see https://stackoverflow.com/questions/17808511/properly-escape-a-double-quote-in-csv)
            data = data.replace(/"/g, '""');
            // Push escaped string
            row.push('"' + data + '"');
        }
        csv.push(row.join(separator));
    }
    var csv_string = csv.join('\n');
    // Download it
    var filename = 'AWS Summary_' + new Date().toLocaleDateString() + '.csv';
    var link = document.createElement('a');
    link.style.display = 'none';
    link.setAttribute('target', '_blank');
    link.setAttribute('href', 'data:text/csv;charset=utf-8,' + encodeURIComponent(csv_string));
    link.setAttribute('download', filename);
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}
</script>
<%!
Connection con=null;
ResultSet rs=null;
Statement stmt=null;
Statement stmt2=null;
String query="";
int count;
%>
<%
String value1=request.getParameter("value1");
String value2=request.getParameter("value2");
String vfdate=request.getParameter("vfdate");
String vtdate=request.getParameter("vtdate");
String vparam=request.getParameter("param");

if (value1==null){value1="0";}
if (value2==null){value2="0";}


DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String formattedDate = df.format(new java.util.Date());


if(vfdate == null){ 
 vfdate=formattedDate;
 vtdate=formattedDate;
}

con = ConnectionProvider.getCon();
stmt=con.createStatement();
stmt2=con.createStatement();
rs = stmt.executeQuery("select param_id as sid,group_value as state from parameter where active='Y' and group_family='LOCATION' and Group_name='STATE'");
%>
<html>
<head>
<link href="../../styles/text.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../../Script/datepicker.js"></script>

<style>
.export {
  border: 2px solid black;
  background-color: white;
  color: black;
  padding: 5px 15px;
  font-size: 15px;
  font-family:Georgia;
   font-weight: bold;
  margin-bottom:3px;
  cursor: pointer;
}
/* Green */
.success {
  border-color: black;
 
  color: white;
  background-color: #4d4dff;
  opacity:0.8;
}

.success:hover {
  background-color: #99ff99;
  color: black;
}
</style>

</head>
<body>
<!-- export to excel script start-->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
 <script src="../../Script/table2excel.js" type="text/javascript"></script>
 <script type="text/javascript">
        function Export() {
            $("#tblCustomers").table2excel({
				filename: "AWS Summary :"+ new Date().toLocaleString().replace(/[\-\:\.]/g, " ") + ".xls"
            });
        }
    </script>
<!-- export to excel script end-->

<table width="100%" border="1" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>
<tr><td width="10%" VALIGN=TOP>
<table width="10%" border="1" cellpadding="1"  bgcolor="#DBEBFF" VALIGN=TOP>

<!--   date selection starts here -->

<tr><td class="Blue-content" colspan="4"><b>Select Date Range</b></td></tr>
<tr><td class="content style1" align="right"><b>From</b></td>
<td><input id="fdate"  class="content style1" type="text" name="fdate" size="10" maxlength="12" value=<%=vfdate%>>
<a href="javascript:NewCal('fdate','ddmmyyyy',false)"><img src="../../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a></td>
</tr>
<tr><td class="content style1" align="right"><b>To</b></td>
<td><input id="tdate"  class="content style1" type="text" name="tdate" size="10" maxlength="12" value=<%=vtdate%>>
<a href="javascript:NewCal('tdate','ddmmyyyy',false)"><img src="../../images/calendar.JPG" width="16" height="16" border="0" alt="Pick a date"></a></td>
</tr>
 <!-- date selection Ends here -->

<tr><td class="Blue-content" colspan="6" align="left">Select Station</td></tr>
<tr><td class="content style1"><b> State </b></td>
<td>
<select id="state" onchange="params()" class="content style1">
<option value="0">--Please Select--</option>
<% while(rs.next()){ %>
<option value="<%=rs.getInt("sid")%>"><%=rs.getString("state")%></option>

<% if(rs.getString("sid").equals(value1)){%>
<option value="<%=value1%>" selected disabled><%=rs.getString("state")%></option> 
<%
}

}
%>
</select> </td></tr>
<tr><td class="content style1"><b> District</b> </td><td>
<select id="district" onchange="params()" class="content style1">
<option value="0">--Please Select--</option>
<option value="-1">All</option>

<%
rs=stmt.executeQuery("select param_id as did,group_value as district from parameter where active='Y' and group_family='LOCATION' and Group_name='DISTRICT' and parent_group='"+value1+"' order by group_value");

while(rs.next()){
%>
<option value="<%=rs.getInt("did")%>" ><%=rs.getString("district")%></option>
<% if(rs.getString("did").equals(value2)){%>
<option value="<%=value2%>" selected disabled><%=rs.getString("district")%></option>
<%
}
}
%>
</select>
</td></tr>
</table>
</td>
<td valign=top>

<!----
<table width="100%" border="0" cellpadding="0" cellspacing="0" id="stretch" > 
	<tr><td class="Headings" align="center">Data Summary 8:30AM - 8:30AM</td></tr>
--->
<table width="100%" border="1" cellpadding="0" cellspacing="0"  >
	<tr>
	
<td align="right"bgcolor="#cce0fb" >

<input type="image" src="../../images/excel.jpg" height="70%">
<button class="export success" value="Export" onclick="Export()" > Export</button>&nbsp
<button class="export success"  onclick="download_table_as_csv('tblCustomers');" >Csv</button>&nbsp

</td>


</tr>


<table id="tblCustomers" width="100%" border="1" cacellpadding="0" cellspacing="0" id="stretch" > 
	<tr><td class="Headings" align="center" colspan=23 width="80%">All AWS Data Summary  from <%=vfdate%> 8:30AM  to <%=vtdate%> 8:30AM</td></tr>
	
<!--<tr><td><table width="100%" border="1" cellpadding="0" cellspacing="0" id="stretch" > -->
<tr class="Blue-content" align="center">
<td rowspan="2">Day</td>
<td rowspan="2">Client ID</td>
<td rowspan="2">District</td>
<td rowspan="2">Block</td>
<td rowspan="2">Location</td>
<td colspan="3">Temparature<br>(&nbsp;&deg;C&nbsp;)</td>
<td colspan="3">Humidity<br>(&#37;)</td>
<td colspan="3">Wind Speed<br>(m/s)</td>
<td colspan="3">Wind Direction<br>(Degrees)</td>
<td colspan="3">Pressure<br>(millibar)</td>

<td rowspan="2">Accumulated<br>Rainfall (mm)</td>
<!-- <td rowspan="2">ET0</td> -->
<td rowspan="2">Packet Count</td>
</tr>

<tr class="Blue-content">
<td>Min</td>
<td>Max</td>
<td>Avg</td>
<td>Min</td>
<td>Max</td>
<td>Avg</td>
<td>Min</td>
<td>Max</td>
<td>Avg</td>
<td>Min</td><td>Max</td><td>Avg</td>
<td>Min</td><td>Max</td><td>Avg</td>
</tr>

<%

query="select pdate,st.clientid,latitude,longitude,location,(select group_value from parameter where param_id=state) as state,(select group_value from parameter where param_id=district) as district,coalesce((select group_value from parameter ";
query+=" where param_id=county),'-') as county,pcount,temp_min,temp_max,temp_avg,humidity_min,humidity_max,humidity_avg,rain_max,pressure_min,pressure_max,pressure_avg,mslp_min,mslp_max,mslp_avg,wind_min,wind_max,wind_avg,winddir_min,winddir_max, winddir_avg,et0 "; 
query+=" from station_configs_det  as st left outer join (";
query+=" select x.*, (pmin.evop_pan-pmax.evop_pan-rain_max)*0.75  et0  from ( ";

query+=" select clientid,case when to_char(packet_date,'HH24MI') between '0000' and '0830' then to_char(packet_date ,'DD/MM/YYYY') else to_char(packet_date+ interval '1 Day','DD/MM/YYYY') end as pdate,";
query+=" count(1) as pcount,max(case when temp_max <= 0 then null else temp_max end) as temp_max,min(case when temp_min <= 0 then null else temp_min end) as temp_min,round(cast(avg(case when temp <= 0 then null else temp end) as decimal),2)  as temp_avg,";
query+=" max(case when humidity <= 0 then null else humidity end) as humidity_max,min(case when humidity <= 0 then null else humidity end) as humidity_min, round(cast(avg(case when humidity <= 0 then null else humidity end) as decimal),2) as humidity_avg,";
query+=" max(rain) as rain_max,max(case when local_pressure <= 0 then null else local_pressure end) as pressure_max,min(case when local_pressure <= 0 then null else local_pressure end) as pressure_min, ";
query+=" round(cast(avg(case when local_pressure <= 0 then null else local_pressure end) as decimal),2) as pressure_avg,";
query+=" max(case when mslp <= 0 then null else mslp end) as mslp_max,min(case when mslp <= 0 then null else mslp end) as mslp_min, ";
query+=" round(cast(avg(case when mslp <= 0 then null else mslp end) as decimal),2) as mslp_avg,";
query+=" max(case when wind <= 0 then null else wind end) as wind_max,min(case when wind <= 0 then null else wind end) as wind_min,round(cast(avg(case when wind <= 0 then null else wind end) as decimal),2) as wind_avg, ";
query+=" max(case when wind_direction_avg <= 0 then null else wind_direction_avg end) as winddir_max,min(case when wind_direction_avg<= 0 then null else wind_direction_avg end) as winddir_min,round(cast(avg(case when wind_direction_avg<=0 then null else wind_direction_avg end) as decimal),1) as winddir_avg,"; 
query+=" min(case when evop_pan !=999 then packet_date end) firstPacketDate,max(case when evop_pan !=999 then packet_date end) lastPacketDate";
query+=" from data_packets";
//query+=" where  packet_date >= to_date('"+vfdate+"','DD/MM/YYYY')   and packet_date < to_date('"+vtdate+"','DD/MM/YYYY')+ INTERVAL '1 DAY' ";
query+=" where  packet_date > to_date('"+vfdate+"','DD/MM/YYYY')+INTERVAL '8.5 HOUR' and packet_date <= to_date('"+vtdate+"','DD/MM/YYYY')+ INTERVAL '8.5 HOUR' ";

//query+=" and to_char(packet_date,'HH24MI') between '0830' and '1739' ";
//query+=" and packet_type='D' group by clientid,pdate ";  
query+=" and packet_type='D' group by clientid,(case when to_char(packet_date,'HH24MI') between '0000' and '0830' then to_char(packet_date ,'DD/MM/YYYY') else to_char(packet_date+ interval '1 Day','DD/MM/YYYY') end) ) as x ";
query+=" left outer join data_packets as Pmin on x.firstPacketDate=Pmin.packet_date and Pmin.packet_type='D' and pmin.clientid=x.clientid ";
query+=" left outer join data_packets as Pmax on x.lastPacketDate=Pmax.packet_date and Pmax.packet_type='D' and pmax.clientid=x.clientid ";
query+=" ) as dp on st.clientid=dp.clientid where st.clientid<10059 and st.activate!=0";


if(value2.equalsIgnoreCase("-1")) {	query=query+" and state='"+value1+"'";
  }
	else{ query=query+" and district='"+value2+"'";}

query=query+" order by clientid,pdate";
rs=stmt.executeQuery(query);


//System.out.println(query);
//out.println(query);

while(rs.next()){
%>
<tr  class="readonly">
<!--------<td><%=rs.getString("pdate")%></td>---------->
<% if (rs.getString("pdate")==null){ %><td align="right">---</td><%} else {%><td align="right"><%=rs.getString("pdate")%></td><%}%>
<td><%=rs.getString("clientid")%></td><td><%=rs.getString("district")%></td>
<td><%=rs.getString("county")%></td>
<td><%=rs.getString("location")%></td>

<% if (rs.getString("temp_min")==null){ %><td align="right">NA</td><%} else {%><td align="right"><%=rs.getDouble("temp_min")%></td><%}%>
<% if (rs.getString("temp_max")==null){ %><td align="right">NA</td><%} else {%><td align="right"><%=rs.getDouble("temp_max")%></td><%}%>
<% if (rs.getString("temp_avg")==null){ %><td align="right">NA</td><%} else {%><td align="right"><%=rs.getDouble("temp_avg")%></td><%}%>

<% if (rs.getString("humidity_min")==null){ %><td align="right">NA</td><%} else {%><td align="right"><%=rs.getDouble("humidity_min")%></td><%}%>
<% if (rs.getString("humidity_max")==null){ %><td align="right">NA</td><%} else {%><td align="right"><%=rs.getDouble("humidity_max")%></td><%}%>
<% if (rs.getString("humidity_avg")==null){ %><td align="right">NA</td><%} else {%><td align="right"><%=rs.getDouble("humidity_avg")%></td><%}%>


<% if (rs.getString("wind_min")==null){ %><td align="right">NA</td><%} else {%><td align="right"><%=rs.getDouble("wind_min")%></td><%}%>
<% if (rs.getString("wind_max")==null){ %><td align="right">NA</td><%} else {%><td align="right"><%=rs.getDouble("wind_max")%></td><%}%>
<% if (rs.getString("wind_avg")==null){ %><td align="right">NA</td><%} else {%><td align="right"><%=rs.getDouble("wind_avg")%></td><%}%>

<% if (rs.getString("winddir_min")==null){ %><td align="right">NA</td><%} else {%><td align="right"><%=rs.getDouble("winddir_min")%></td><%}%>
<% if (rs.getString("winddir_max")==null){ %><td align="right">NA</td><%} else {%><td align="right"><%=rs.getDouble("winddir_max")%></td><%}%>
<% if (rs.getString("winddir_avg")==null){ %><td align="right">NA</td><%} else {%><td align="right"><%=rs.getDouble("winddir_avg")%></td><%}%>


<% if (rs.getString("pressure_min")==null){ %><td align="right">NA</td><%} else {%><td align="right"><%=rs.getDouble("pressure_min")%></td><%}%>
<% if (rs.getString("pressure_max")==null){ %><td align="right">NA</td><%} else {%><td align="right"><%=rs.getDouble("pressure_max")%></td><%}%>
<% if (rs.getString("pressure_avg")==null){ %><td align="right">NA</td><%} else {%><td align="right"><%=rs.getDouble("pressure_avg")%></td><%}%>


<% if (rs.getString("rain_max")==null){ %><td align="right">NA</td><%} else {%><td align="right"><%=rs.getDouble("rain_max")%></td><%}%>

<!---- old code ---without N/A 
<td><%=rs.getDouble("temp_max")%></td><td><%=rs.getDouble("temp_min")%></td><td><%=rs.getDouble("temp_avg")%></td>
<td><%=rs.getDouble("humidity_max")%></td><td><%=rs.getDouble("humidity_min")%></td><td><%=rs.getDouble("humidity_avg")%></td>
<td><%=rs.getDouble("pressure_max")%></td><td><%=rs.getDouble("pressure_min")%></td>
<td><%=rs.getDouble("pressure_avg")%></td>
<td><%=rs.getDouble("rain_max")%></td> 
<td align="right"><%=rs.getDouble("et0")%></td> ---->
<td align="center"><%=rs.getInt("pcount")%></td> 
</tr>
<%
}
%>


</tr></table>

</table>



	</table>
</td></tr>
</table>

</body>
</html>
