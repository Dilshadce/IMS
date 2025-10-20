<html>
	
<head>
	<title>Choose Category</title>
</head>

<body>
<cfoutput>
<!-- run the text field of category choosen -->
<cfif c eq "default">
	<input type="text" value="" name="searchtext" id="searchtext" disabled="true">
<cfelseif c eq "custname">
	<input type="text" value="" name="searchtext" id="searchtext"
	onkeyup="ajaxFunction(window.document.getElementById('ajaxFAField'),'searchCompany.cfm?type=custname&c='+this.value);">
<cfelseif c eq "comid">
	<input type="text" value="" name="searchtext" id="searchtext"
	onkeyup="ajaxFunction(document.getElementById('ajaxFAField'),'searchCompany.cfm?type=comid&c='+this.value);">
<cfelseif c eq "comname">
	<input type="text" value="" name="searchtext" id="searchtext"
	onkeyup="ajaxFunction(window.document.getElementById('ajaxFAField'),'searchCompany.cfm?type=comname&c='+this.value);">
<cfelseif c eq "status">
	<select name="status" onChange="ajaxFunction(window.document.getElementById('ajaxFAField'),'searchCompany.cfm?type=status&c='+this.value);">
		<option value="Yes">Yes</option>
		<option value="No">No</option>
    </select>
</cfif>
</cfoutput>

<cfsetting showdebugoutput="no">

</body>

</html>