<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Login Page</title>

<link href="styles/text.css" rel="stylesheet" type="text/css">
<!-- <style type="text/css">
html,body {
       background-image: url(../images/topbanner.jpg);
       background-repeat: no-repeat;
        background-size: 100%;

}
</style> -->


<style type="text/css">
table.background { background: url("images/topbanner.jpg") no-repeat; background-size: 100%; }
</style>
</head>
<body>

<form action="loginprocess.jsp" method="post">
<table border="0" cellpadding="0" cellspacing="0" id="stretch" class="background"   style="width:100%;height:100px;"> 
	<tr><td valign="middle" height="100%"><img src="images/Logo.png" width="75" height="75"></img></td>  
	<td align="left" class="maintitle">APSIRE WATER LEVEL MONITERING SYSTEM</td>
	</tr>
<tr><td background="images/Logo_bottom.jpg" scope="col" colspan=2><img src="images/Logo_bottom.jpg" width="3" height="4"/></td></tr>
	 
</table>

<table width="390"  align="center" cellpadding="0" cellspacing="0">
  <tr><th colspan="3" scope="col"><img src="images/top-login.jpg" width="390" height="40"></th> </tr> 
     <tr><th height="113" colspan="3"  background="images/mid.jpg">
		<table width="80%"  border="0" cellspacing="2" cellpadding="2">
             <tr><th width="43%" scope="col">&nbsp;</th> <th width="57%" scope="col">&nbsp;</th> </tr>
             <tr><td align="right" class="content">User Name : </td><td><input id=uname name="uname" type="text" size="15" tabindex="1"></td> </tr>
             <tr><td align="right" class="content">Password : </td><td><input id=pass name="pass" type="password" size="15" maxlength="10" tabindex="1"></td></tr>
             <tr align="center"><td colspan="2">&nbsp;</td></tr>
        </table></th>
      </tr>
      <tr>
           <td><img src="images/BLeft.jpg" width="106" height="41"></td>
           <td><input type="image" src="images/Submit.jpg" name="submit" value="login" ></td>
           <td width="206"><img src="images/BRight.jpg" width="206" height="41"></td>
      </tr>
</table> 
</form>

</body>
</html>


