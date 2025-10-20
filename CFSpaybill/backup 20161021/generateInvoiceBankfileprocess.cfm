<cfoutput>

<cfif HcomID eq "manpower">
<cfelse>
<cfset HcomID = "kwangmingtest">
</cfif>

<cfquery name="gs_qry" datasource="payroll_main">
SELECT mmonth, myear FROM gsetup WHERE comp_id = "#HcomID#"
</cfquery>

<cfquery name="getprofilelist" datasource="#dts#">
SELECT * FROM paybillprofile
WHERE id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.profileid#">
</cfquery>

<cfquery name="getCFSEmpProfile" datasource="#dts#">
SELECT * FROM cfsempinprofile 
WHERE profileid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.profileid#">
</cfquery>

<cfquery name="getemplist" datasource="#dts#">
SELECT * FROM cfsemp
WHERE icno IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#valuelist(getCFSEmpProfile.icno)#">)
</cfquery>

<cfloop query="getemplist">
<cfset workdaystag = #evaluate('form.workdays#getemplist.icno#')#>
<cfset workdays = workdaystag>


<cfset payamt = val(workdays) * val(getprofilelist.payrate)>
<cfset billamt = val(workdays) * val(getprofilelist.billrate)>
<cfset adminfeeamt = val(billamt) * (val(getprofilelist.adminfee)/100)>



<cfquery name="insertinfo" datasource="#dts#">
INSERT INTO geninvbankfile
(
workdays,
payamt,
billamt,
adminfeeamt,
paybillprofileid,
icno,
created_by,
created_on
)
VALUES
(

<cfqueryparam cfsqltype="cf_sql_integer" value="#workdays#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#payamt#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#billamt#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#adminfeeamt#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.profileid#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getemplist.icno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
now()
)
</cfquery>
</cfloop>


<cfinclude template="/CFSpaybill/generateBankFile.cfm">



</cfoutput>