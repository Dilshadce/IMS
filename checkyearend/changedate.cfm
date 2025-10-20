<cfsetting showdebugoutput="no">
<cfquery name="get_gsetup" datasource="#dts#">
	select lastaccyear,period from gsetup
</cfquery>
<cfoutput>
#dateformat(dateadd('m',url.period,dateadd('d',1,get_gsetup.lastaccyear)),'YYYY-MMMM-DD')#
</cfoutput>