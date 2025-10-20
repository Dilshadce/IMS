<cfif isdefined ("url.type")>
<cfquery name="del_qry" datasource="#dts#">
DELETE FROM holtable WHERE entryno = "#url.entryno#"
</cfquery>

<cfelse>

<!---cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#form.dbirth#" returnvariable="cfc_dbirth" /---->


<cfif form.count gt "0">

<cfloop from="1" to="#form.count#" index="i">
	
	<cfif #evaluate('form.ndate__r#i#')# neq "">
	 
	<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#evaluate('form.ndate__r#i#')#" 	returnvariable="cfc_holdate" />
    
	
    
<cfquery name="add_qry" datasource="#dts#">
INSERT INTO holtable (HOL_DATE, HOL_DESP)
VALUES (#cfc_holdate#,
		<cfqueryparam value="#evaluate('form.ndesp__r#i#')#" cfsqltype="cf_sql_varchar">)
</cfquery>
</cfif>
</cfloop>

<cfelse>

<cfloop list="#form.entryno#" index="i">

   
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#evaluate('form.hol_date__r#i#')#" returnvariable="cfc_hdate" />
<cfquery name="update_qry" datasource="#dts#">
UPDATE holtable
SET HOL_DATE = #cfc_hdate#,
	HOL_DESP ="#evaluate('form.hol_desp__r#i#')#"
WHERE entryno = #i#
</cfquery>
</cfloop>

</cfif>

</cfif>
 <cflocation url="/payments/2ndHalf/AddUpdate/HolidayAndLeaveMaintenance/holidayLeaveMaintenanceHoliday.cfm">
