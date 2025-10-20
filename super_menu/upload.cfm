<cffunction name="getType" output="true">
	<cfargument name="inputName" required="yes">
	<cfset nLen=ListLen(arguments.inputName,"_")>
	<cfset n=getToken(arguments.inputName,nLen,"_")>
	<cfif n eq "">
		<cfreturn "EMPTY">
	<cfelse>
		<cfreturn n>
	</cfif>
</cffunction>

<cfset oldlocale = SetLocale("English (UK)")>
<cfset thisPath = ExpandPath("/billformat/#dts#/*.*")>
<cfset thisDirectory = GetDirectoryFromPath(thisPath)>
<cfset allBillList="NONTAX,TAXINV,DO,PLIST,CN,PR,RC,CS,CN,DN,PO,QUO,SO,SAM">
<cfset alldefaultBillList="DO,INV,CN,PR,RC,CS,CN,DN,PO,QUO,SO,SAM,ISS,OAI,OAR">
<cfset nameList="">
<cfset billList="">
<cfset sizeList="">
<cfset dateList="">
<cfset uploadedByList="">

<cfif DirectoryExists(thisDirectory) eq 'NO'>
	<cfdirectory action="create" directory="#thisDirectory#">
	<cffile action="copy" source="#ExpandPath("/billformat/empty_i/preprintedformat.cfm")#" destination="#thisDirectory#">
	<cffile action="copy" source="#ExpandPath("/billformat/empty_i/transactionformat.cfm")#" destination="#thisDirectory#">
	
	<cfdirectory action="create" directory="#GetDirectoryFromPath(ExpandPath("/Download/#dts#/ver9.0/*.*"))#">
	<cfdirectory action="create" directory="#GetDirectoryFromPath(ExpandPath("/Download/#dts#/ver9.1/*.*"))#">
	<cffile action="copy" source="#ExpandPath("/Download/ver9.0/glpost9.csv")#" destination="#GetDirectoryFromPath(ExpandPath("/Download/#dts#/ver9.0/*.*"))#">
	<cffile action="copy" source="#ExpandPath("/Download/ver9.1/glpost9.csv")#" destination="#GetDirectoryFromPath(ExpandPath("/Download/#dts#/ver9.1/*.*"))#">
	<cfoutput><p>Company directory has been created.</p></cfoutput>
</cfif>

<cfif isDefined("form.uploadfile")>
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
		<cflocation url="upload.cfm?s='#cffile.clientfile# has been backup to #BackupDirectory#'" addtoken="no">
	</cfif>
	
	<cflocation url="upload.cfm" addtoken="no">
</cfif>

<cfdirectory directory="#thisDirectory#" name="dirQuery" action="LIST">
<!--- Get all directory information in a query of queries.--->
<cfquery dbtype="query" name="cfrsOnly">
	SELECT * FROM dirQuery where name like '%.cfr'
</cfquery>
<cfquery dbtype="query" name="picOnly">
	select * from dirQuery where name like '%.jpg' or name like '%.png' or name like '%.JPG'
</cfquery>
<cfquery dbtype="query" name="CFMOnly">
	select * from dirQuery where name like '%.cfm'
</cfquery>
<cfloop query="cfrsOnly">
	<cfinvoke method="getType" inputName="#cfrsOnly.name#" returnvariable="billType"/>
	<cfset nameList=listappend(nameList,cfrsOnly.name)>
	<cfset billList=listappend(billList,billType)>
	<cfset sizeList=listappend(sizeList,"#cfrsOnly.size/1000#kb")>
	<cfset dateList=listappend(dateList,LSDateFormat(cfrsOnly.DateLastModified,"dd-mm-yyyy"))>
</cfloop>
	
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Upload CFR</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfoutput>
	<cfif isdefined("url.s")><h3>#url.s#</h3></cfif>
	<h2>CFRs files in #dts#</h2>
	<table width="50%">
		<tr>
			<th>TYPE</th>
			<th>FILE NAME</th>
			<th>SIZE</th>
			<th>DATE</th>
            <th>LAST UPLOADED BY</th>
			<cfif husergrpid eq "Super"><th>ACTION</th></cfif>
		</tr>
		<cfloop index="item" list="#allBillList#">
			<cfset indexList=ListContainsNoCase(billList,"#item#.cfr")>
			<cfif indexList neq 0>
				<tr bgcolor="##FFCC66">
					<td>#item#</td>
					<td><a href='download.cfm?d=#dts#&f=#listgetat(nameList,indexList)#'>#listgetat(nameList,indexList)#</a></td>
					<td>#listgetat(sizeList,indexList)#</td>
					<td>#listgetat(dateList,indexList)#</td>
                        
                        <cfquery name="getUpdatedBy" datasource="#dts#">
                            SELECT *
                            FROM customized_format
                            WHERE file_name = '#listgetat(listgetat(nameList,indexList),1,".")#'
                        </cfquery>
                    	
                        <td>#getUpdatedBy.updated_by#</td>	
                    
					<cfif husergrpid eq "Super">
						<td><a href="delete.cfm?d=#dts#&f=#listgetat(nameList,indexList)#">Delete</a></td>	
					</cfif>  
				</tr>
				<cfset billList=ListDeleteAt(billList, indexList)>
				<cfset nameList=ListDeleteAt(nameList, indexList)>
				<cfset sizeList=ListDeleteAt(sizeList, indexList)>
				<cfset dateList=ListDeleteAt(dateList, indexList)>
			<cfelse>
				<tr bgcolor="##779FBD">
					<td>#item#</td>
					<td>NOT EXIST (#dts#CBIL_#item#.cfr)</td>
					<td></td>
                    <td></td>
					<td></td>
					<cfif husergrpid eq "Super"><td></td></cfif>					  
				</tr>
			</cfif> 
		</cfloop>
        
        <cfloop index="item" list="#alldefaultBillList#">
		
				<tr bgcolor="##FFCC66">
					<td>#item#</td>
					<td><a href='download.cfm?d=default&f=#item#.cfr'>#item#</a></td>
					<td></td>
					<td></td>
                    <td></td>	
					<cfif husergrpid eq "Super">
						<td><a href="delete.cfm?d=default&f=#item#.cfr">Delete</a></td>	
					</cfif>  
				</tr>
				
		</cfloop>
        
        <cfif husergrpid eq "super" or huserid contains "ultra">
		<cfloop from="1" to="#listlen(nameList)#" index="i">
		<tr bgcolor="silver">
			<td>Unknown</td>
			<td><a href="download.cfm?d=#dts#&f=#listgetat(nameList,i)#">#listgetat(nameList,i)#</a></td>
			<td>#listgetat(sizeList,i)#</td>
			<td>#listgetat(dateList,i)#</td>
            <td></td>
			<cfif husergrpid eq "Super" or huserid contains "ultra">
				<td><a href="delete.cfm?d=#dts#&f=#listgetat(nameList,i)#">Delete</a></td>	
			</cfif>
		</tr>
		</cfloop>
		<cfloop query="picOnly">
		<tr>
			<td>Picture</td>
			<td><a href="download1.cfm?d=#dts#&f=#name#">#name#</a></td>
			<td>#size/1000#kb</td>
			<td>#LSDateFormat(DateLastModified,"dd-mm-yyyy")#</td>
            <td></td>	 
			<cfif husergrpid eq "Super">
				<td><a href="delete.cfm?d=#dts#&f=#name#">Delete</a></td>	
			</cfif>
		</tr>
		</cfloop>
        
        <cfloop query="CFMOnly">
		<tr>
			<td>CFM</td>
			<td><a href="download1.cfm?d=#dts#&f=#name#">#name#</a></td>
			<td>#size/1000#kb</td>
			<td>#LSDateFormat(DateLastModified,"dd-mm-yyyy")#</td>	 
			<td></td> 
            <td></td>
		</tr>
		</cfloop>
        </cfif>
	</table>
</cfoutput>
<br>
	
<form name="uploadform" action="Upload.cfm" method="POST" enctype="multipart/form-data">
	<input type="file" name="uploadfile">
	<input type="submit" name="uploadsubmit" value="Upload">
</form>
<cfif husergrpid eq "super" or huserid contains "ultra">
<h3>General Format</h3>
CFM :&nbsp;<a href="download.cfm?d=general&f=preprintedformat.cfm">Preprintformat</a></td><br>
CFR :&nbsp;<a href="download.cfm?d=general&f=default.cfr">Report Builder Format</a><br>
TXT :&nbsp;<a href="download.cfm?d=general&f=format_manual.txt">REMARK INFO</a>
</cfif>
</body>
</html>
