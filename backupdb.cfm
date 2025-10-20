<cfif isdefined('form.companyname')>
<cfset currentURL =  CGI.SERVER_NAME>
<cfif mid(currentURL,'4','1') eq "2">
<cfset servername = "appserver2">
<cfelse>
<cfset servername = "appserver1">
</cfif>
<cfset currentDirectory = "C:\BACKUP\"& form.companyname>
<cfif DirectoryExists(currentDirectory) eq false>
<cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>
<cfset filename=form.companyname&"_"&dateformat(now(),'YYYYMMDD')&"_"&timeformat(now(),'HHMMSS')&"_"&GetAuthUser()&"_DAILY.sql">
<cfset currentdirfile=currentDirectory&"\"&filename>
<cfexecute name = "C:\inetpub\wwwroot\IMS\mysqldump"
    arguments = "--host=localhost --user=root --password=Nickel266( #form.companyname#" outputfile="#currentdirfile#" timeout="120">
</cfexecute>
</cfif>
<form name="1" action="" method="post">
<input type="text" name="companyname" id="companyname" value="" />
<input type="submit" name="subbtn" value="Backup" />
</form>