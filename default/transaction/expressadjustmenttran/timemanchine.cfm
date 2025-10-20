<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
    <script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script type='text/javascript' src='/ajax/core/shortcut.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    <link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
    <script type="text/javascript" src="/scripts/prototypenew.js" ></script>
    
<h2>Auto Save</h2>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfquery name="getlast" datasource="#dts#">
SELECT uuid,created_on,refno from locadjtran_temp where onhold='Y' group by uuid order by created_on desc limit 30 
</cfquery>
<cfoutput>
<table>
<tr>
<td>
<select name="oldlist" id="oldlist">
<cfloop query="getlast">
<option value="#getlast.uuid#">#getlast.refno#-#dateformat(getlast.created_on,'YYYY-MM-DD')# #timeformat(getlast.created_on,'HH:MM:SS')#</option>
</cfloop>
</select>
</td>
</tr>
<tr>
<td>
<input type="button" name="btngo" value="Recover" onclick="revertback()" />
</td>
</tr>
</table>
</cfoutput>


<cfoutput>
<script type="text/javascript">
	function revertback()
	{
	var answer = confirm('Are you sure you want to proceed?')
	if(answer)
	{
	var newuuid = document.getElementById('oldlist').value;
	opener.releaseDirtyFlag();
	opener.window.location.href="index2.cfm?type=create&uuid="+newuuid;
	window.close();
	}
	}
</script>
</cfoutput>