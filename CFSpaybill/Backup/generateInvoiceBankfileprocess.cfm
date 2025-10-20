<cfoutput>

<!---<cfset cfsprofile = form.cfsprofile>--->

<cfquery name="gs_qry" datasource="payroll_main">
SELECT mmonth, myear FROM gsetup WHERE comp_id = "kwangmingtest"
</cfquery>

<cfquery name="getprofilelist" datasource="#dts#">
SELECT * FROM paybillprofile
WHERE profilename = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.profilename#">
</cfquery>

<cfquery name="getemplist" datasource="#dts#">
SELECT * FROM cfsemp
WHERE icno IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#valuelist(getprofilelist.icno)#">)
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
paybillprofileid
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#workdays#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#payamt#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#billamt#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#adminfeeamt#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getprofilelist.id#">
)
</cfquery>
</cfloop>


<cfinclude template="/CFSpaybill/generateBankFile.cfm">
<!---<cflocation url = "http://ims.asia/nieo/generateInvoiceBankfile.cfm">--->



</cfoutput>