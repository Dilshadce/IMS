<cfset thisPath = ExpandPath("/billformat/#url.d#/#url.f#")>
<cfheader name="Content-Disposition" value="inline; filename=#url.f#">
<cfcontent type="image/jpeg" file="#thisPath#"> 
