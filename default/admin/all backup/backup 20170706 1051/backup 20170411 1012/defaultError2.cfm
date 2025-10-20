<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Sorry! This function is not avaiable in the means time, please try again later!</title>
<link rel="stylesheet" href="/stylesheet/app2.css"/>
<link rel="stylesheet" type="text/css" href="/stylesheet/css1.css" />
<link href="/stylesheet/headernew.css" rel="stylesheet" TYPE="text/css" >
  <link href="/stylesheet/left2.css" rel="stylesheet" type="text/css">
</head>


<cfoutput>
<body class="netiquette" style="top:0px; left:0px; width:100%;" >
<div id="headerlogo"  class="header" style="border-bottom:##0EA0D8 solid; height:100px; width:100%">
<table cellpadding="0" cellspacing="0" width="100%">
      <tr>
       <td width="300px" rowspan="2">
       <table  cellspacing="2" cellpadding="2" width="100%">
        <tr><td>
    <div class="company_logo" style="width:80%; text-align:center; height:80%">
    <img style="text-align:center; " width="100%" height="100%" src="/images/newlogo.png" />
    </div>
</td></tr></table>
   </td>
   <td rowspan="2" width="1000px" style="vertical-align:top;">
   <table width="100%" cellspacing="0" cellpadding="0">
        <tr><td>
        <div class="header_title">
        <font style="font-size:14px">Company ID: <strong>#replace(Session.companyid,left(Session.companyid,1),ucase(left(Session.companyid,1)))#  </strong><br>
Welcome, <strong>#GetAuthUser()#. </strong></font>
<font size="-2" color="##FFFFFF">Login On: #DayOfWeekAsString(DayOfWeek(Session.loginTime))#,  #DateFormat(Session.loginTime, "dd-mm-yyyy")#, #TimeFormat(Session.loginTime, "HH:MM:SS")# (IP Add: <strong>#cgi.REMOTE_ADDR#</strong>)</font>
</div> </td>
 </tr></table>
      </td>
<td style="vertical-align:top; text-align:right;"  width="400px" align="right">
       <div class="header_corner" style="height:10%;">
              
    
                  
                 <!---  <div class="block"> <a target="_blank" href="/securelinktoims.cfm">IMS</a> </div>
                  <div class="block"> <a target="_blank" href="/securelinktoams.cfm">AMS</a> </div>
                  <div class="block"> <a target="_blank" href="/securelinktopay.cfm">PAY</a> </div>
                  <div class="block"> <a target="_blank" href="/securelinktocrm.cfm">CRM</a> </div>
                  <div class="block"> <a href="##"><img src="/images/support.png" height="30" alt="Support" border="0"></a> </div>
                  <div class="block"> <a href="##"><img src="/images/uv_favicon.png" alt="Feedback" height="30"  border="0"></a> </div> --->
                  <div class="block" style="height:10%;"> <a href="/changepass/" target="mainFrame">CHANGE PASSWORD</a></div>
                  <div class="block" style="height:10%;"> <a href="/member/index.cfm?logout=1">LOGOUT</a> </div>
                  <div class="block" style="height:10%;"> <a href="/member/index.cfm">HOME</a> </div>
               
      
            </div><br>
<img height="50px" width="240px"  src="/images/crmlogo.png" />
        </td>
       </tr>
       <tr>
        <td width="400px" style="vertical-align:top; text-align:right" align="right">

<table width="100%" align="right" cellspacing="0" cellpadding="0">
         <tr <!---  style="	background: white;
		background: -moz-linear-gradient(top, ##a5def8 0%, white100%);
    	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,white), color-stop(100%,##a5def8));
    	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='white', endColorstr='##a5def8',GradientType=0 );" --->>
         <td style="text-align:right;float:right; border:0px; background-color:transparent; margin:0px 0px 0 0;">
</td></tr></table>
         </td>
         </tr>
         
         </table>
</div>

<h2>Sorry! This function is not available in the means time, please try again later!</h2>
<p style="color:##999">
The above problem may occured as the following reason:
<ul>
<li><font size="+1">The server is busy at the moment</font></li>
<li><font size="+1">System is under upgrading process</font></li>
<li><font size="+1">Incompatible browser settings toward the system</font></li>
<li><font size="+1">Wrong data type input or usage of the system</font></li>
</ul>
Please try again later! If the problem persist, please dont hesistate to contact us at #error.mailTo#.
</p>
</body>

<cfmail from="noreply@mynetiquette.com" to="#error.mailTo#" subject="Error detect on the Scheduling System" type="html">
<table border="1">
<tr>
<td width="100px">Username</td>
<td width="5px">:</td>
<td width="300px">#getAuthUser()#</td>
</tr>
<tr>
<td>Company Id</td>
<td>:</td>
<td><!--- #get_comId.comID# ---></td>
</tr>
<tr>
<td>Diagnostics</td>
<td>:</td>
<td>#error.diagnostics# -#error.template#</td>
</tr>
<tr>
<td>Date Occured</td>
<td>:</td>
<td>#error.dateTime#</td>
</tr>
<tr>
<td>Browser used</td>
<td>:</td>
<td>#error.browser#</td>
</tr>
<tr>
<td>IP address</td>
<td>:</td>
<td>#error.remoteAddress#</td>
</tr>
<tr>
<td>Http Refferer</td>
<td>:</td>
<td><!--- #error.HTTPReferer# ---></td>
</tr>
</table></cfmail>
<br>
<br>

<font color="##999999">Click <a href="/member/index.cfm" >HERE</a> to go back the Home Page</font>

<cfabort>
<!--- <form name="error_submit" id="error_submit" action="/defaultErrorMail.cfm" method="post">
<input type="hidden" name="diag" value="#error.diagnostics#" />
<input type="hidden" name="mailto" value="#error.mailTo#" />
<input type="hidden" name="date" value="#error.dateTime#" />
<input type="hidden" name="browser" value="#error.browser#" />
<input type="hidden" name="ipadd" value="#error.remoteAddress#"  />
<input type="hidden" name="httpRefferer" value="#error.HTTPReferer#" />
<input type="hidden" name="generated" value="#error.generatedContent#" />
<input type="hidden" name="query" value="#error.template#" />
</form> --->

<cfmail from="noreply@mynetiquette.com" to="#error.mailTo#" subject="Error detect on the Scheduling System" type="html">
<p>Dear Sir,</p>
<p>Error below has occur while Scheduling System is operate by the personal below</p>
<table border="1">
<tr>
<td width="100px">Username</td>
<td width="5px">:</td>
<td width="300px">#getAuthUser()#</td>
</tr>
<tr>
<td>Company Id</td>
<td>:</td>
<td>#get_comId.comID#</td>
</tr>
<tr>
<td>Diagnostics</td>
<td>:</td>
<td>#error.diagnostics# -#error.template#</td>
</tr>
<tr>
<td>Date Occured</td>
<td>:</td>
<td>#error.dateTime#</td>
</tr>
<tr>
<td>Browser used</td>
<td>:</td>
<td>#error.browser#</td>
</tr>
<tr>
<td>IP address</td>
<td>:</td>
<td>#error.remoteAddress#</td>
</tr>
<tr>
<td>Http Refferer</td>
<td>:</td>
<td>#error.HTTPReferer#</td>
</tr>
<!--- <tr>
<td>Generated Page</td>
<td>:</td>
 <td>#error.generatedContent#</td> 
</tr>
<tr>
<td>Query String</td>
<td>:</td>
<td></td>
</tr> --->

</table>
<br />
<br />

From: Netiquette Scheduling System<br />
Company ID: #get_comId.comID#
</p>
<p style="font-size:smaller">This email is auto generated by system. Please do not reply to this email.</p>
</cfmail>
<cfabort></cfoutput>