<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<cfquery name="getexistbillformat" datasource="#dts#">
	SELECT file_name, type
    FROM customized_format
</cfquery>

<cfset existfilename=StructNew()>
<cfloop query="getexistbillformat"> 
	<cfset StructInsert(existfilename, getexistbillformat.file_name,  getexistbillformat.type)>
</cfloop>


<cfset oldlocale = SetLocale("English (UK)")>
<cfset thisPath = ExpandPath("/billformat/#dts#/*.*")>
<cfset thisDirectory = GetDirectoryFromPath(thisPath)>

<cfset newDirectory = "Backup">
<cfset BackupDirectory = thisDirectory&"#newDirectory#\">
<!--- Check to see if the Directory exists. --->
<cfif DirectoryExists(BackupDirectory) eq 'NO'>
   <!--- If FALSE, create the directory. --->
   <cfdirectory action = "create" directory = "#BackupDirectory#">
   <cfoutput><p>Backup directory has been created.</p></cfoutput>
</cfif>

<cffile action = "upload" fileField = "uploadfile" destination = "#thisDirectory#" nameconflict="makeunique"> 
<cflog file="uploadFormatActivity" type="information" 
	text="File:#cffile.clientfile# Uploaded on #now()# From (#HcomID#-#HUserID#)">  
 
<cfif cffile.fileexisted eq 'YES'>
	<cfset newFile = "#thisDirectory#" & "#cffile.serverfile#">
	<cfset orgFile = "#thisDirectory#" & "#cffile.clientfile#">

	<cffile action="move" source="#orgFile#" destination="#BackupDirectory#" attributes="Archive">	  
	<cffile action = "rename" source = "#newfile#" destination = "#orgFile#">
	<cfquery name="updatetime" datasource="#dts#">
	update customized_format set updated_on=now() where file_name = '#listgetat(cffile.clientfile,1,'.')#'
	</cfquery>
	<cflocation url="addbillformat.cfm?s='#cffile.clientfile# has been backup to #BackupDirectory#'" addtoken="no">
</cfif>

<cfquery name="updatetime" datasource="#dts#">
update customized_format set updated_on=now() where file_name like '#cffile.clientfile#' 
</cfquery>

<cflocation url="addbillformat.cfm" addtoken="no">

<body>
</body>
</html>