<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> WMS Dash Board </TITLE>
<link href="../styles/text.css" rel="stylesheet" type="text/css">
<script>
/* Auto Refresh Page with Time script*/

//enter refresh time in "minutes:seconds" Minutes should range from 0 to inifinity. Seconds should range from 0 to 59
var limit="10:00"

if (document.images){
var parselimit=limit.split(":")
parselimit=parselimit[0]*60+parselimit[1]*1
}
function beginrefresh(){
if (!document.images)
return
if (parselimit==1)
window.location.reload()
else{ 
parselimit-=1
curmin=Math.floor(parselimit/60)
cursec=parselimit%60
if (curmin!=0)
curtime=curmin+" minutes and "+cursec+" seconds left until page refresh!"
else
curtime=cursec+" seconds left until page refresh!"
window.status=curtime
setTimeout("beginrefresh()",1000)
}
}

window.onload=beginrefresh
</script>

</HEAD>

<BODY>

<!-- Sesssion Management -->
<%if(session.getAttribute("theName") == null){  
  // User is not logged in.
  out.println("your Session has expired");
  response.sendRedirect("../index.html?invalid=0");
}
%>
<!-- End of Sesssion Management -->

<table width="100%" class=border border="0" cellpadding="0" cellspacing="0" id="stretch" >
<!-- <tr><td align="center" colspan="3" class="Red-content" ><img src="../images/dashboard.jpg" width="150" height="50"></td></tr> --->
<tr><td></td></tr>
<tr class="Blue-content" align="center">

<td>Station Statistics<br>(Last 12 Hours)</td>
<td>Reporting stations<br>(Last 12 Hours) %</td>
<!-- <td>Recovery Statistics</td> -->
<td>&nbsp;</td></tr>
<tr>
 <td><iframe src="stationstats.jsp" height="300"  width="250" FRAMEBORDER="0"  scrolling="No"></iframe></td>
 <td><iframe src="stationstatsperbar.jsp" height="300"  width="300" FRAMEBORDER="0"  scrolling="No"></iframe></td>
 <td><iframe src="recoverystats.jsp" height="300"  width="250" FRAMEBORDER="0" scrolling="No"></iframe></td>
 <td><iframe src="messagestats.jsp" height="350" width="350" FRAMEBORDER="0" scrolling="No"></iframe></td>  
</tr>
</table>
</BODY>
</HTML>
