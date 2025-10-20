<cfscript>
	function convertquote(str)
	{
		var converted_double_quote = replace(str,'"','&##x0022;','all');
		return converted_double_quote;
	}
</cfscript>