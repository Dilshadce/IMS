<cfset currentDirectory2 = "C:\POSFILE\importingdbf">
<cfif DirectoryExists(currentDirectory2) eq true>
<cfdirectory action="delete" recurse="yes" directory = "#currentDirectory2#" >
</cfif>

<cfset currentDirectory = "C:\POSFILE\importingdbf\importdbf\">
<cfif DirectoryExists(currentDirectory) eq false>
<cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>

<!---<cfif right(form.geticitem,4) eq ".zip">--->
<cftry>
		<CFFILE DESTINATION="C:\POSFILE\importingdbf\#dts#.zip" ACTION="UPLOAD" FILEFIELD="form.geticitem" attributes="normal" >
	<cfcatch type="any">

	
	</cfcatch>
	</cftry>
    
    <cfset zipdirectory =  currentDirectory>
    <cfif DirectoryExists(zipdirectory) eq false>
    <cfdirectory action = "create" directory = "#zipdirectory#" >
    </cfif>
    <cfzip action="unzip" destination="#currentDirectory2#" file="C:\POSFILE\importingdbf\#dts#.zip" overwrite="yes">
    <form name="form" action="getimportlist.cfm" method="post">
    
    </form>
    
    <script type="text/javascript">
	form.submit();
	</script>
    
    <!--- ---->

    
    <!---- 
<cfelse>

<cfoutput>
<script type="text/javascript">
alert('File is uploaded is not zip.');
history.go(-1);
</script>
</cfoutput>

</cfif>

---->
