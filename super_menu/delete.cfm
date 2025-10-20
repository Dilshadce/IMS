<cfset thisPath = ExpandPath("/billformat/#url.d#/#url.f#")>
<cfset thisDirectory = GetDirectoryFromPath(thisPath)>
<cfset newDirectory = "Backup">

<cfset BackupDirectory = thisDirectory&"#newDirectory#\">
<cffile action="move" source="#thisPath#" destination="#BackupDirectory#" attributes="Archive">
<cflocation url="upload.cfm">
