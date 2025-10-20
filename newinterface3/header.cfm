<cfsetting enablecfoutputonly="no"> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Testing</title>
<link rel="stylesheet" type="text/css" href="css1.css" />
</head>

<body class="openerp">
<cfquery name="getgeneral" datasource="#dts#">
		select * from gsetup
	</cfquery>
<div class="header">
    <div class="company_logo_link"> 
    <div class="company_logo">
    </div>
    </div>
        <div class="header_title"><cfoutput>Welcome, #HUserName#.Login On: #DayOfWeekAsString(DayOfWeek(Session.loginTime))#,  #DateFormat(Session.loginTime, "dd-mm-yyyy")#, #TimeFormat(Session.loginTime, "HH:MM:SS")#, IP Add: #cgi.REMOTE_ADDR#</cfoutput><br /><small><cfoutput>#getgeneral.compro# &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Company ID : #listgetat(dts,'1','_')#</cfoutput></small> </div>
        <div class="header_corner">
        <div class="block">
        <table>
        <td><a href="/newBody.cfm" target="mainFrame">HOME</a></td>
        <td><a href="/contact.cfm" target="mainFrame">CONTACT US</a></td>
        <td><a href="/feedback/feedback.cfm" target="mainFrame">FEEDBACK</a></td>
        <td><a href="/ext/docs/" target="mainFrame">HELP</a></td>
         <td><a href="/logout.cfm" target="_parent">LOGOUT</a></td>
        </table>
        </div>
        </div>
</div>

<div class="menu">
<table align="center">
<cfif getpin2.h1000 eq "T"><td><a href="/menunew/maintenance.cfm" target="leftFrame">Maintenance</a></td></cfif>
<cfif getpin2.h2000 eq "T">
<td><a href="/menunew/transaction.cfm" target="leftFrame">Transaction</a></td></cfif>
<cfif getpin2.h6000 eq "T">
<td><a href="/menunew/print_bills.cfm" target="leftFrame">Print Bills</a></td></cfif>
<cfif getpin2.h3000 eq "T">
<td><a href="/menunew/enquire.cfm" target="leftFrame">Enquires</a></td></cfif>
<cfif getpin2.h4000 eq "T">
<td><a href="/menunew/report.cfm" target="leftFrame">Reports</a></td></cfif>
<cfif getpin2.h5000 eq "T">
<td><a href="/menunew/setup.cfm" target="leftFrame">General Setup</a></td></cfif>
<cfif husergrpid eq "Super">
<td><a href="/menunew/super_menu.cfm" target="leftFrame">Super Menu</a></td></cfif>
</table>
</div>
<div>
  
    </td>
    </table>
    











</body>
</html>
