<cfoutput>

<cfif HcomID eq "manpower">
<cfelse>
<cfset HcomID = "kwangmingtest">
</cfif>

<cfif isdefined('url.type') and isdefined('url.id')>
	<cfif lcase(url.type) eq 'delete'>
    	<cfquery name="deletetran" datasource="#dts#">
        DELETE FROM geninvbankfile
        WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
        </cfquery>
        
        <script type="text/javascript">
		alert('Deleted successfully!');
		window.location="/CFSpaybill/listcfstran.cfm";
		</script>
    </cfif>
<cfelse>

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
<cfset workdaystag = #evaluate('form.workdays#getemplist.id#')#>
<cfset workdays = workdaystag>

<cfset totalpaytag = #evaluate('form.totalpayamt#getemplist.id#')#>
<cfset totalpayamt = totalpaytag>

<cfset totalbilltag = #evaluate('form.totalbillamt#getemplist.id#')#>
<cfset totalbillamt = totalbilltag>

<cfset adminfeetag = #evaluate('form.adminfeeamt#getemplist.id#')#>
<cfset adminfeeamt = adminfeetag>


<cfset misc1 = #evaluate('form.misc1#getemplist.id#')#>
<cfset misc11 = misc1>
<cfset misc2 = #evaluate('form.misc2#getemplist.id#')#>
<cfset misc22 = misc2>
<cfset misc3 = #evaluate('form.misc3#getemplist.id#')#>
<cfset misc33 = misc3>
<cfset misc4 = #evaluate('form.misc4#getemplist.id#')#>
<cfset misc44 = misc4>
<cfset misc5 = #evaluate('form.misc5#getemplist.id#')#>
<cfset misc55 = misc5>
<cfset miscrem1 = #evaluate('form.miscrem1#getemplist.id#')#>
<cfset miscrem11 = miscrem1>
<cfset miscrem2 = #evaluate('form.miscrem2#getemplist.id#')#>
<cfset miscrem22 = miscrem2>
<cfset miscrem3 = #evaluate('form.miscrem3#getemplist.id#')#>
<cfset miscrem33 = miscrem3>
<cfset miscrem4 = #evaluate('form.miscrem4#getemplist.id#')#>
<cfset miscrem44 = miscrem4>
<cfset miscrem5 = #evaluate('form.miscrem5#getemplist.id#')#>
<cfset miscrem55 = miscrem5>


<cfset currentdate = createdate(year(now()),month(now()),day(now()))>

<cfquery name="insertinfo" datasource="#dts#">
INSERT INTO geninvbankfile
(
workdays,
payamt,
billamt,
adminfeeamt,
paybillprofileid,
icno,
wos_date,
rem1,
rem2,
rem3,
rem4,
rem5,
misc1,
misc2,
misc3,
misc4,
misc5,
created_by,
created_on
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_integer" value="#workdays#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#totalpayamt#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#totalbillamt#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#adminfeeamt#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.profileid#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getemplist.icno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(currentdate,'yyyy-mm-dd')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#miscrem11#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#miscrem22#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#miscrem33#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#miscrem44#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#miscrem55#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#misc11#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#misc22#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#misc33#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#misc44#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#misc55#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
now()
)
</cfquery>
</cfloop>

<cfif trim(form.submit) eq "Generate Bankfile Now">
	<cfinclude template="/CFSpaybill/generateBankFile.cfm">
<cfelse>
	<script type="text/javascript">
    alert("Transaction Saved");
	window.location="/CFSpaybill/generateInvoiceBankfiledata.cfm?profileid=#url.profileid#";
    </script>    
</cfif>

</cfif>
</cfoutput>