<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/stylesheet/jquery-ui.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/scripts/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/scripts/jquery-ui.js"></script>
<script>

  $( document ).tooltip({ position: { my: "left top+5", at: "left bottom", collision: "flipfit" } });

</script>
<cfquery name="getgsetup" datasource="#dts#">
SELECT * from gsetup
</cfquery>


<cfquery name="getCurrency" datasource="#dts#">
	select * from #target_currency#
	order by CurrCode 
</cfquery>
<cfquery name="getGeneralInfo" datasource="#dts#">
	select * 
	from modulecontrol;
</cfquery>

<cfset cost = getgsetup.cost>
<cfset negstk = getgsetup.negstk>
<cfset gpricemin = getgsetup.gpricemin>
<cfset priceminctrl = getgsetup.priceminctrl>
<cfset priceminpass = getgsetup.priceminpass>


<cfoutput>
<cfform name="wizard2form" id="wizard5form" method="post" action="wizard7.cfm?type=w7">
<cfinclude template="header_wizard.cfm">
<!---
<div align="Center"><h3>*Below is a <strong>6 step</strong> simple wizard to help you set up your Inventory Management System</h3></div>
<br />
<div align="center">
<font size="+5" style="vertical-align:middle"><strong>User Setup<img src="/images/setupwizard/help.png" height="50" width="50" /></strong></font>
</div>--->
<table width="1100" height="1100" cellpadding="0" cellspacing="0" style="border: 1px solid black ;" align="center">

<tr><td height="1000">

<iframe name="wizard4body" src="/default/admin/vUser1.cfm?comid=#hcomid#" height="1000" width="1100" scrolling="yes" frameborder="0"></iframe>
</td></tr>
<tr><td><div align="center">
<!--- <p align="right">
<input type="button" name="skip_this" id="skip_this" value="Skip This" onclick="window.location.href='wizard7.cfm?type=w7'" />
</p> --->
<input type="button" name="back_btn" id="back_btn" value="Back" onclick="window.location.href='wizard5.cfm?type=w5'" />&nbsp;&nbsp;&nbsp;
<input type="button" name="skip_btn" id="skip_btn" value="Skip Wizard Setup" onclick="window.location.href='skipwizard.cfm'" />&nbsp;&nbsp;&nbsp;
<input type="submit" name="sub_btn" id="sub_btn" value="Next" />
</div></td></tr>
</table>


</cfform>
</cfoutput>
