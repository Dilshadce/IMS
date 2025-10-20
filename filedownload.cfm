<cfset thisPath = ExpandPath("/super_menu/startupwarning/#url.f#")>

<cfheader name="Content-Disposition" value="attachment; filename=#url.f#">
<cfcontent type="Multipart/Report" file="#thisPath#">
