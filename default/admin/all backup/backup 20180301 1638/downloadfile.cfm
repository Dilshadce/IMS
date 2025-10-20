<cfif isdefined('url.filename')>
<cfset filename = urldecode(url.filename)>
<cfcontent type="application/unknown">
<cfheader name="Content-Disposition" value="attachement;filename=#filename#">>
<cfcontent type="application/unknown" file="#HRootPath#\download\#dts#\#URLDECODE(url.filename)#">
</cfif>