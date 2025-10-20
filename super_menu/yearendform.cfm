<cfset currentURL =  CGI.SERVER_NAME>
<cfif mid(currentURL,'4','1') eq "2">
<cfset servername = "appserver2">
<cfelse>
<cfset servername = "appserver1">
</cfif>
<html>
<head>
<title>Year End Processing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="submit" default="">
<cfset intrantype="'RC','CN','OAI','TRIN'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU','CT'">
<cfelse>
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU'">
</cfif>

<cfquery name="getgsetup" datasource="#dts#">
select period from gsetup
</cfquery>
    
<body>
<form action="yearend.cfm" method="post" onSubmit="if(confirm('Are you sure want to Year End?')){ColdFusion.Window.show('processing');return true;} else {return false;}">
<H1>Year End Processing <cfoutput>(Year End Period :#getgsetup.period#)</cfoutput></H1>

<h3>Caution: Please make sure that you really want to do year end processing.</h3>
Click this button to do year end processing --><input type="submit" name="submit" value="Year End">
</form>
</body>
<cfwindow name="processing" width="300" height="300" initshow="false" center="true" closable="false" draggable="false" title="Processing....Please Wait" modal="true" resizable="false" >
<h1>Processing....Please Wait</h1>
<img src="/images/loading.gif" align="middle" />
</cfwindow>
</html>