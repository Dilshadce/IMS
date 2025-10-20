<cfsetting requesttimeout="72000">
<cfquery name="gettable" datasource="#dts#">
show tables in empty_p
</cfquery>

<cfquery name="getctble" datasource="#dts#">
show tables in empty_c where tables_in_empty_c in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(gettable.tables_in_empty_p)#" list="yes" separator=",">)
and tables_in_empty_c not in ("userpin","project","event","event_exception")
</cfquery>


<cfquery name="backupdb" datasource="main">
SELECT schema_name FROm information_schema.SCHEMATA where schema_name <> "information_schema" and schema_name <> "mysql" and right(schema_name,2) = "_c"
</cfquery>
<cfloop query="backupdb" >
<cfset dts = backupdb.schema_name>
<cfset currentDirectory = "E:\DAILYBACKUP\"& dts>
<cfif DirectoryExists(currentDirectory) eq false>
<cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>
<cfset filename=dts&"_"&dateformat(now(),'YYYYMMDD')&"_"&timeformat(now(),'HHMMSS')&"_"&GetAuthUser()&"_DAILY.sql">
<cfset currentdirfile=currentDirectory&"\"&filename>
<cfexecute name = "C:\Program Files\MySQL\MySQL Server 5.1\bin\mysqldump"
    arguments = "--user=root --password=Toapayoh831 #dts#" outputfile="#currentdirfile#" timeout="3600">
</cfexecute>
</cfloop>

<cfzip source="E:\Dailybackup" action="zip" file="E:\DAILY_BACKUP_#dateformat(now(),'YYYYMMDD')#_#timeformat(now(),'HHMMSS')#.zip" overwrite="yes">

<cfdirectory action="delete" directory="E:\Dailybackup\" recurse="yes">

<cfloop query="backupdb" >
<cfset dts = backupdb.schema_name>
    <cfloop query="getctble">
    	<cftry>
        <cfquery name="droptable" datasource="#dts#">
        DROP TABLE #getctble.tables_in_empty_c#
        </cfquery>
        <cfcatch type="any">
        <cfoutput>
        #dts#-#cfcatch.Detail#<br>

        </cfoutput>
        </cfcatch>
        </cftry>
    </cfloop>
</cfloop>