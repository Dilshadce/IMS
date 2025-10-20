<cfquery name="backupdb" datasource="main">
SELECT schema_name FROm information_schema.SCHEMATA where schema_name <> "information_schema" and schema_name <> "mysql" and (right(schema_name,2) = "_p" or right(schema_name,2) = "_i")
</cfquery>
<cfloop query="backupdb" >
<cfset dts = backupdb.schema_name>
<cfset currentDirectory = "C:\DAILYBACKUP\"& dts>
<cfif DirectoryExists(currentDirectory) eq false>
<cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>
<cfset filename=dts&"_"&dateformat(now(),'YYYYMMDD')&"_"&timeformat(now(),'HHMMSS')&"_"&GetAuthUser()&"_DAILY.sql">
<cfset currentdirfile=currentDirectory&"\"&filename>
<cfexecute name = "C:\Program Files\MySQL\MySQL Server 5.1\bin\mysqldump"
    arguments = "--user=root --password=654321 #dts#" outputfile="#currentdirfile#" timeout="120">
</cfexecute>
</cfloop>