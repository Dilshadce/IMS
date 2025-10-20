<cfquery name="getgeneral" datasource="#dts#">
	select invoicedatafile from gsetup
</cfquery>
<cfif isdefined('url.file') eq false>

<cfheader name="Content-Type" value="dat">
<cfheader name="Content-Disposition" value="attachment; filename=iv3600#getgeneral.invoicedatafile#.dat">
<cfcontent type="application/x-zip-compressed" file="#HRootPath#\eInvoicing\#dts#\iv3600#getgeneral.invoicedatafile#.dat">

<cfelse>

<cfheader name="Content-Type" value="dat">
<cfheader name="Content-Disposition" value="attachment; filename=#url.file#">
<cfcontent type="application/x-zip-compressed" file="#HRootPath#\eInvoicing\#dts#\history\#url.file#">

</cfif>