<cfsetting enablecfoutputonly="no"> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Testing</title>
<link rel="shortcut icon"
 href="/IMS.ico" />
<link rel="stylesheet" type="text/css" href="css1.css" />

</head>

<body class="netiquette">
<cfquery name="getgeneral" datasource="#dts#">
		select * from gsetup
	</cfquery>
    <cfquery name="getlanguage" datasource="main">
        select * from menulang
</cfquery>
<cfset date1 = dateadd('d',1,getgeneral.lastaccyear)>
    <cfset date2 = dateadd('m',getgeneral.period,getgeneral.lastaccyear)>
<cfset menutitle=StructNew()>
<cfloop query="getlanguage">
<cfif getgeneral.dflanguage eq 'english'>
<cfset menutitle['#getlanguage.no#']=getlanguage.eng>
<cfelseif getgeneral.dflanguage eq 'sim_ch'>
<cfset menutitle['#getlanguage.no#']=getlanguage.sim_ch>
<cfelseif getgeneral.dflanguage eq 'tra_ch'>
<cfset menutitle['#getlanguage.no#']=getlanguage.tra_ch>
<cfelseif getgeneral.dflanguage eq 'Indonesian'>
<cfset menutitle['#getlanguage.no#']=getlanguage.Indonesian>
</cfif>
</cfloop>
<table class="header" style="height:130px; width:100%" >
<tr>
<td align="center" valign="top" width="20%">
    <img src="Netiqutte-01.png" style="margin-top:15px; width:auto; height:auto"/>
</td>
<td width="70%" nowrap="nowrap" style='font-size: 100%;
    padding: 5px;
	padding-left: 30px;
	color:#333333;
	font-weight:bolder;
	font-size:18px;
	font-family:"Times New Roman", Times, serif;
	alignment-adjust:middle;
	text-shadow: 0 1px 0 #111111;
    line-height:22px;' valign="top">
<cfoutput>#getgeneral.compro# &nbsp;&nbsp;
        (Company ID : #listgetat(dts,'1','_')#)<br />
        <font style='font-size: 90%;
	color:##FFFFFF;
	font-weight:bolder;
	font-family:"Times New Roman", Times, serif;
	alignment-adjust:middle;
	text-shadow: 0 1px 0 ##111111;
	line-height:16px;'>
		<cfoutput><font style="font-weight:bolder;">Welcome, #HUserName#. </font><br />
		<font size="-4" style="letter-spacing:0px">Login On: #DayOfWeekAsString(DayOfWeek(Session.loginTime))#,
		#DateFormat(Session.loginTime, "dd-mm-yyyy")#, #TimeFormat(Session.loginTime, "HH:MM:SS")#&nbsp;
		(IP Add:#cgi.REMOTE_ADDR#)&nbsp; &nbsp;Account Year #dateformat(date1,'DD-MM-YYYY')# to #dateformat(date2,'DD-MM-YYYY')#</font></cfoutput>
		</font></cfoutput>
        <br />
        <div style='text-align:left;font-size:16px;font:"Times New Roman", Times, serif;color:#FFF;background-color:transparent;
	/*background-color:#00ABCC;*/
	/*background: url(headermenu.png) repeat-x;*/
	font-weight:bolder;
    height: 30px;'>
<cfif getpin2.h1000 eq "T"><a style="
    width: 120px;
    height: 20px;
    margin: 3px 2px;
    padding: 0 8px;
	border:1px solid #FFFFFF;
	background-color:transparent;
    border-radius: 4px;
    -moz-border-radius: 4px;
    -webkit-border-radius: 4px;

    color:#000;
    text-shadow: #222 0 1px 0;
    text-decoration: none;
    text-transform: uppercase;
    line-height: 20px;
    font-weight: bold;
    font-size: 85%;
	text-align:center;" href="/menunew2/maintenance.cfm" target="leftFrame"><img src="maintenance2.ico" style="vertical-align:middle; border:none" /><cfoutput>#menutitle[1]#</cfoutput></a></cfif>
<cfif getpin2.h2000 eq "T">
<a style="
    width: 120px;
    height: 20px;
    margin: 3px 2px;
    padding: 0 8px;
	border:1px solid #FFFFFF;
	background-color:transparent;
    border-radius: 4px;
    -moz-border-radius: 4px;
    -webkit-border-radius: 4px;

    color:#000;
    text-shadow: #222 0 1px 0;
    text-decoration: none;
    text-transform: uppercase;
    line-height: 20px;
    font-weight: bold;
    font-size: 85%;
	text-align:center;" href="/menunew2/transaction.cfm" target="leftFrame"><img src="transaction.ico" style="vertical-align:middle; border:none" /><cfoutput>#menutitle[41]#</cfoutput></a></cfif>
<cfif getpin2.h6000 eq "T">
<a style="
    width: 120px;
    height: 20px;
    margin: 3px 2px;
    padding: 0 8px;
	border:1px solid #FFFFFF;
	background-color:transparent;
    border-radius: 4px;
    -moz-border-radius: 4px;
    -webkit-border-radius: 4px;

    color:#000;
    text-shadow: #222 0 1px 0;
    text-decoration: none;
    text-transform: uppercase;
    line-height: 20px;
    font-weight: bold;
    font-size: 85%;
	text-align:center;" href="/menunew2/print_bills.cfm" target="leftFrame"><img src="printreceipt.ico" style="vertical-align:middle; border:none" /><cfoutput>#menutitle[59]#</cfoutput></a></cfif>
<cfif getpin2.h3000 eq "T"><a style="
    width: 120px;
    height: 20px;
    margin: 3px 2px;
    padding: 0 8px;
	border:1px solid #FFFFFF;
	background-color:transparent;
    border-radius: 4px;
    -moz-border-radius: 4px;
    -webkit-border-radius: 4px;

    color:#000;
    text-shadow: #222 0 1px 0;
    text-decoration: none;
    text-transform: uppercase;
    line-height: 20px;
    font-weight: bold;
    font-size: 85%;
	text-align:center;" href="/menunew2/enquire.cfm" target="leftFrame"><img src="enquire.ico" style="vertical-align:middle; border:none" /><cfoutput>#menutitle[78]#</cfoutput></a></cfif>
<cfif getpin2.h4000 eq "T">
<a style="
    width: 120px;
    height: 20px;
    margin: 3px 2px;
    padding: 0 8px;
	border:1px solid #FFFFFF;
	background-color:transparent;
    border-radius: 4px;
    -moz-border-radius: 4px;
    -webkit-border-radius: 4px;

    color:#000;
    text-shadow: #222 0 1px 0;
    text-decoration: none;
    text-transform: uppercase;
    line-height: 20px;
    font-weight: bold;
    font-size: 85%;
	text-align:center;" href="/menunew2/report.cfm" target="leftFrame"><img src="report.ico" style="vertical-align:middle; border:none" /><cfoutput>#menutitle[88]#</cfoutput></a></cfif>
<cfif getpin2.h5000 eq "T">
<a style="
    width: 120px;
    height: 20px;
    margin: 3px 2px;
    padding: 0 8px;
	border:1px solid #FFFFFF;
	background-color:transparent;
    border-radius: 4px;
    -moz-border-radius: 4px;
    -webkit-border-radius: 4px;

    color:#000;
    text-shadow: #222 0 1px 0;
    text-decoration: none;
    text-transform: uppercase;
    line-height: 20px;
    font-weight: bold;
    font-size: 85%;
	text-align:center;" href="/menunew2/setup.cfm" target="leftFrame"><img src="setup.ico" style="vertical-align:middle; border:none" /><cfoutput>#menutitle[104]#</cfoutput></a></cfif>
<cfif husergrpid eq "Super">
<a style="
    width: 120px;
    height: 20px;
    margin: 3px 2px;
    padding: 0 8px;
	border:1px solid #FFFFFF;
	background-color:transparent;
    border-radius: 4px;
    -moz-border-radius: 4px;
    -webkit-border-radius: 4px;

    color:#000;
    text-shadow: #222 0 1px 0;
    text-decoration: none;
    text-transform: uppercase;
    line-height: 20px;
    font-weight: bold;
    font-size: 85%;
	text-align:center;" href="/menunew2/super_menu.cfm" target="leftFrame">Super Menu</a></cfif>

</div>
</td>

<td  width="10%" align="right" valign="top">
<table class="block" width="100%">
        <tr style="	background: #828282;
		background: -moz-linear-gradient(top, #828282 0%, #4D4D4D 100%);
    	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#828282), color-stop(100%,#4D4D4D));
    	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#828282', endColorstr='#4D4D4D',GradientType=0 );">
        
        
    	<td style="border-collapse:collapse;border: 2px solid #666666;moz-border-radius: 4px;-webkit-border-radius: 4px; border-radius: 4px;"><a href="/newBody2.cfm" target="mainFrame" style="display: block;color: white;text-decoration: none;font-size:11px;">HOME</a></td>
        <td style="border-collapse:collapse;border: 2px solid #666666;moz-border-radius: 4px;-webkit-border-radius: 4px; border-radius: 4px;" nowrap><a href="/contact.cfm" target="mainFrame" style="display: block;color: white;text-decoration: none;font-size:11px;">CONTACT US</a></td>
        <td style="border-collapse:collapse;border: 2px solid #666666;moz-border-radius: 4px;-webkit-border-radius: 4px; border-radius: 4px;"><a href="/feedback/feedback.cfm" target="mainFrame" style="display: block;color: white;text-decoration: none;font-size:11px;">FEEDBACK</a></td>
        <td style="border-collapse:collapse;border: 2px solid #666666;moz-border-radius: 4px;-webkit-border-radius: 4px; border-radius: 4px;"><a href="/ext/docs/" target="mainFrame" style="display: block;color: white;text-decoration: none;font-size:11px;">HELP</a></td>
         <td style="border-collapse:collapse;border: 2px solid #666666;moz-border-radius: 4px;-webkit-border-radius: 4px; border-radius: 4px;"><a href="/logout.cfm" target="_parent" style="display: block;color: white;text-decoration: none;font-size:11px;">LOGOUT</a></td></tr>
        
        <tr>
        <td></td><td></td>
         <td colspan="3">
         <img src="imslogo2.png" width="176" height="45" />
         </td></tr>
         </table>
</td>
</tr>

</table>


</body>
</html>
<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>
<cfif getgsetup.autooutstandingreport eq 'Y'>
<script language="JavaScript">
<!---
window.open('default/enquires/outreport1.cfm?type=6&submit=1');--->
window.open('/default/enquires/soduedate.cfm');
</script>
</cfif>

