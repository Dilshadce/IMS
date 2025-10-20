<cfsetting enablecfoutputonly="no"> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Header</title>
<link rel="stylesheet" type="text/css" href="css1.css" />
</head>
<body class="openerp">
<div class="header">
    <div class="company_logo_link"> 
    <div class="company_logo">
    </div>
    </div>
        <div class="header_title"><cfoutput>Welcome, #getauthuser()#.Login On: #DayOfWeekAsString(DayOfWeek(Session.loginTime))#,  #DateFormat(Session.loginTime, "dd-mm-yyyy")#, #TimeFormat(Session.loginTime, "HH:MM:SS")#, IP Add: #cgi.REMOTE_ADDR#</cfoutput><br /><small><cfoutput>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Company ID : #listgetat(dts,'1','_')#</cfoutput></small> </div>
        <div class="header_corner">
        <div class="block">
        <table>
        <tr>
        <td><a href="/erpinterface/backtoerp.cfm?type=sales" target="mainFrame">HOME</a></td>
        <td><a href="http://www.netiquette.com.sg/contact.php" target="_blank">CONTACT US</a></td>
        <td><a href="mailto:enquiry@netiquette.com.sg">FEEDBACK</a></td>
         <cfoutput><td><a href="/logout.cfm?goerp=<cfif mid(CGI.SERVER_NAME,'4','1') eq 2>2</cfif>" target="_parent">LOGOUT</a></td></cfoutput>
         </tr>
        </table>
        </div>
        </div>
</div>

<div class="menu">
<cfquery name="getmenu" datasource="#dts#">
SELECT * FROM #replace(dts,'_i','_c')#.managemenu WHERE menulevel = 1
</cfquery>
<cfquery name="getroleid" datasource="#dts#">
select * from (select id,username from #replace(dts,'_i','_c')#.security where username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getauthuser()#">) as a
left join
(select securityid,role from #replace(dts,'_i','_c')#.securitylink) as b
on a.id = b.securityid
left join
(select role as roleid,id as rid from #replace(dts,'_i','_c')#.role) as c
on b.role = c.roleid
</cfquery>
<cfset rolelist = "">
<cfloop query="getmenu">
<cfset rolelist = rolelist&evaluate('getmenu.r_#getroleid.rid#')>
<cfif getmenu.recordcount neq getmenu.currentrow>
<cfset rolelist = rolelist&",">
</cfif>
</cfloop>
<table align="center">
<tr>
<cfif listgetat(rolelist,'1') eq "T">
<td><a href="/menunew2/quotation.cfm?type=crm" target="leftFrame"><cfoutput>QUO</cfoutput></a></td>
</cfif>
<cfif listgetat(rolelist,'2') eq "T">
<td><a href="/erpinterface/backtoerp.cfm?type=2" target="leftFrame"><cfoutput>CRM</cfoutput></a></td>
</cfif>
<cfif listgetat(rolelist,'3') eq "T">
<td><a href="/erpinterface/backtoerp.cfm?type=3" target="leftFrame"><cfoutput>SALES</cfoutput></a></td>
</cfif>
<cfif listgetat(rolelist,'4') eq "T">
<td><a href="/erpinterface/backtoerp.cfm?type=4" target="leftFrame"><cfoutput>TECH SERVICES</cfoutput></a></td>
</cfif>
<cfif listgetat(rolelist,'5') eq "T">
<td><a href="/erpinterface/index.cfm" target="_parent"><cfoutput>INVENTORY</cfoutput></a></td>
</cfif>
<cfif listgetat(rolelist,'6') eq "T">
<td><a href="/erpinterface/backtoerp.cfm?type=6" target="leftFrame"><cfoutput>CUSTOMER SERVICES</cfoutput></a></td>
</cfif>
<cfif listgetat(rolelist,'7') eq "T">
<td><a href="/erpinterface/backtoacc.cfm" target="leftFrame"><cfoutput>ACCOUNT</cfoutput></a></td>
</cfif>
<cfif listgetat(rolelist,'8') eq "T">
<td><a href="/erpinterface/backtoerp.cfm?type=8" target="leftFrame"><cfoutput>USER ACCOUNT</cfoutput></a></td>
</cfif>
<cfif listgetat(rolelist,'9') eq "T">
<td><a href="/erpinterface/backtoerp.cfm?type=9" target="leftFrame"><cfoutput>ADMINISTRATION</cfoutput></a></td>
</cfif>
</tr>
</table>
</div>
<div class="menu2">
<table align="center">
<tr>
<cfif getpin2.h1000 eq "T"><td><a href="/menunew2/maintenance.cfm" target="leftFrame"><cfoutput>Maintenance</cfoutput></a></td></cfif>
<cfif getpin2.h2000 eq "T">
<td><a href="/menunew2/transaction.cfm" target="leftFrame"><cfoutput>Transaction</cfoutput></a></td></cfif>
<cfif getpin2.h6000 eq "T">
<td><a href="/menunew2/print_bills.cfm" target="leftFrame"><cfoutput>Print Bills</cfoutput></a></td></cfif>
<cfif getpin2.h3000 eq "T"><td><a href="/menunew2/enquire.cfm" target="leftFrame"><cfoutput>Enquires</cfoutput></a></td></cfif>
<cfif getpin2.h4000 eq "T">
<td><a href="/menunew2/report.cfm" target="leftFrame"><cfoutput>Reports</cfoutput></a></td></cfif>
<cfif getpin2.h5000 eq "T">
<td><a href="/menunew2/setup.cfm" target="leftFrame"><cfoutput>General Setup</cfoutput></a></td></cfif>
<cfif husergrpid eq "Super">
<td><a href="/menunew2/super_menu.cfm" target="leftFrame">Super Menu</a></td></cfif>
<td width="14%"><a href="/ext/docs/" target="mainFrame">HELP</a></td>

</tr>
</table>
</div>
</body>
</html>
