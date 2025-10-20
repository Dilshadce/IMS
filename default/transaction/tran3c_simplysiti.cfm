
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
<cfif isdefined('url.save')>
<cfquery name="updateremark" datasource="#dts#">
update artran set rem8='#form.rem8#',rem9='#form.rem9#',rem10='#form.rem10#',rem11='#form.rem11#' where refno='#url.nexttranno#' and type='#url.tran#'
</cfquery>
</cfif>

<cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery>

<cfquery name="getremark" datasource="#dts#">
	select rem8,rem9,rem10,rem11 from artran where refno='#url.nexttranno#' and type='#url.tran#'
</cfquery>
<cfform name="remarkform" action="tran3c_simplysiti.cfm?save=1&nexttranno=#url.nexttranno#&tran=#url.tran#" method="post">
<cfoutput>
  	<table align="left" class="data" width="770">
    <tr>
    <th>#getgsetup.rem8#</th>
    <td>
    <input type="text" name="rem8" value="#getremark.rem8#" size="40" maxlength="80">
    </td>
     <th>#getgsetup.rem9#</th>
    <td>
    <input type="text" name="rem9" value="#getremark.rem9#" size="40" maxlength="80">
    </td>
    </tr>
    <tr>
    <th>#getgsetup.rem10#</th>
    <td>
    <input type="text" name="rem10" value="#getremark.rem10#" size="40" maxlength="80">
    </td>
     <th>#getgsetup.rem11#</th>
    <td>
    
    <cfinput type="text" name="rem11" value="#getremark.rem11#" size="40" maxlength="80">
    <br />
    <img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(rem11);">
    (DD/MM/YYYY)    </td>
    </tr>
    <tr>
    <td colspan="4" align="center"><input type="submit" name="submit" value="Save" /></td>
    </tr>

  	</table>
    </cfoutput>
    
    </cfform>
