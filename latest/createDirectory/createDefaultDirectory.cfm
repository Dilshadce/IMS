
<!--- Create 1: Bill Format Directory [START] --->
<cfoutput>

<cftry>
	<cfset thisPath = ExpandPath("/billformat/#LCASE(dts)#/*.*")>
    <cfset thisDirectory = GetDirectoryFromPath(thisPath)>
 
    <cfdirectory 
                action = "create" 
                directory = "#thisDirectory#" >
<cfcatch>
	<script type="text/javascript">
		alert('Bill Format folder has already been created!');
	</script>
</cfcatch>
</cftry>

</cfoutput>
<!--- Create 1: Bill Format Directory [END] --->


<!--- Create 2: Excel Report Directory [START] --->
<cfoutput>

<cftry>
	<cfset thisPath = ExpandPath("/Excel_Report/#LCASE(dts)#/*.*")>
    <cfset thisDirectory = GetDirectoryFromPath(thisPath)>
 
    <cfdirectory 
                action = "create" 
                directory = "#thisDirectory#" >
<cfcatch>
	<script type="text/javascript">
		alert('Excel Report folder has already been created!');
	</script>
</cfcatch>
</cftry>

</cfoutput>
<!--- Create 2: Excel Report Directory [END] --->