
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#date#" returnvariable="cfc_date" />

<cfquery name="add_leave" datasource="#dts#">
INSERT INTO pwork
(EMPNO,WORK_TYPE,WORK_DATE,WORK_DAY)
VALUES
(<cfqueryparam value="#form.empno#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#form.leaveType#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#cfc_date#" cfsqltype="cf_sql_varchar">,
<cfqueryparam value="#form.numDay#" cfsqltype="cf_sql_varchar">)
</cfquery>

<cflocation url="/payments/2ndHalf/AddUpdate/RestdayAndHolidayWorked/maintainMain_add.cfm?empno=#form.empno#">

