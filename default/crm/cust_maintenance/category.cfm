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
	onkeyup="ajaxFunction(window.document.getElementById('ajaxFAField'),'searchResult.cfm?type=custname&c='+this.value);">

<cfelseif c eq "custno">
	<input type="text" value="" name="searchtext" id="searchtext"
	onkeyup="ajaxFunction(window.document.getElementById('ajaxFAField'),'searchResult.cfm?type=custno&c='+this.value);">
</cfif>
</cfoutput>

<cfsetting showdebugoutput="no">

</body>

</html>