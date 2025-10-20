<cfsetting showdebugoutput="no">

<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>
<cfif getgsetup.comboard eq 'Y'>
<cftry>
<div style="display:none">
<cfinvoke component="cfc.comboard" method="display" firstline="Discount #url.discount#" secondlineleft="Total" secondlineright="#numberformat(val(url.value),',_.__')#" comchannel="#getgsetup.comboardport#" returnvariable="test"/></div>
<cfoutput>
<input type=hidden name='displayitem8' id='displayitem8' value='#test#'>
</cfoutput>
<cfcatch></cfcatch></cftry>
</cfif>