<cfif isdefined ("url.type")>

<cfquery name="delete_qry" datasource="#dts#">
DELETE FROM pwork WHERE entryno = "#url.entryno#"
</cfquery>

<cflocation url="/payments/2ndHalf/AddUpdate/RestdayAndHolidayWorked/maintainMain_add.cfm?empno=#url.empno#">

<cfelse>

<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#date#" returnvariable="cfc_date" />

<cfif isdefined("form.allEMP")>

<cfquery name="select_emp_list" datasource="#dts#">
select empno from paytran
</cfquery>

<cfloop query="select_emp_list">

<cfquery name="add_dwork" datasource="#dts#">
INSERT INTO pwork
(EMPNO,WORK_TYPE,WORK_DATE,WORK_DAY)
VALUES
(<cfqueryparam value="#select_emp_list.empno#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#form.leaveType#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#cfc_date#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#form.numDay#" cfsqltype="cf_sql_varchar">)
</cfquery>


</cfloop>

<cfelse>

<cfquery name="add_dwork" datasource="#dts#">
INSERT INTO pwork
(EMPNO,WORK_TYPE,WORK_DATE,WORK_DAY)
VALUES
(<cfqueryparam value="#form.empno#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#form.leaveType#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#cfc_date#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#form.numDay#" cfsqltype="cf_sql_varchar">)
</cfquery>
</cfif>

</cfif>

<cflocation url="/payments/2ndHalf/AddUpdate/RestdayAndHolidayWorked/maintainMain_add.cfm?empno=#form.empno#">

