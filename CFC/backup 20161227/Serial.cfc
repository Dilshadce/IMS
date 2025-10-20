<cfcomponent>
    
    <cffunction name="RemoveRecord_In" output="true" returntype="string">
    
    <cfargument name="dts" required="yes">
	<cfargument name="tran" required="yes">
    <cfargument name="nexttranno" required="yes">
    <cfargument name="itemno" required="yes">
    <cfargument name="itemcount" required="yes">
    
	<cfset statusMsg="">
	<cfquery name="getLocation" datasource="#dts#">
		select serialno, location from iserial where type='#tran#' and refno='#nexttranno#' and 
		itemno='#itemno#' and trancode='#itemcount#'
	</cfquery>
	<cfif getLocation.recordcount gt 0>
		<cfif getLocation.location[1] neq location>
			<cfquery name="getOldRecord" datasource="#dts#">
				select type,refno,serialno from iserial where itemno='#itemno#' and location='#getLocation.location[1]#' and sign=-1 
				and serialno in ('#valuelist(getLocation.serialno,"','")#')
			</cfquery>
			<cfif getOldRecord.recordcount gt 0>
				<cfquery name="deleteRecord" datasource="#dts#">
					delete from iserial where itemno='#itemno#' and location='#getLocation.location[1]#' and sign=-1 and 
					serialno in ('#valuelist(getOldRecord.serialno,"','")#')
				</cfquery>
				<cfset statusMsg="Location has been Change. Below serial No have been removed.">
				<cfloop query="getOldRecord">
					<cfset statusMsg=listappend(statusMsg,"Type: #type#,Refno: #refno#,Serial No: #serialno#")>
				</cfloop>
			</cfif>
			<cftry>
				<cfquery name="updateRecord" datasource="#dts#">
					update iserial set location='#location#' 
					where type='#tran#' and refno='#nexttranno#' and itemno='#itemno#' and 
					trancode='#itemcount#' and location='#getLocation.location#'
				</cfquery>
				<cfset statusMsg=listappend(statusMsg,"Successfully Change Location.")>
				<cfcatch type="database">
					<cfset statusMsg=listappend(statusMsg,"Failed to Change Location.Please check with Administrator.")>
				</cfcatch>
			</cftry>
		</cfif>
	</cfif>
	<cfreturn statusMsg>
</cffunction>
<cffunction name="RemoveRecord_Out" output="false">
	<cfquery name="getLocation" datasource="#dts#">
		select location from iserial where type='#tran#' and refno='#nexttranno#' and 
		itemno='#itemno#' and trancode='#itemcount#' limit 1
	</cfquery>
	<cfif getLocation.recordcount gt 0>
		<cfif getLocation.location neq location>
			<cfquery name="deleteRecord" datasource="#dts#">
				delete from iserial where type='#tran#' and refno='#nexttranno#' and 
				itemno='#itemno#' and trancode='#itemcount#'
			</cfquery>
		</cfif>
	</cfif>
</cffunction>
    
</cfcomponent>	