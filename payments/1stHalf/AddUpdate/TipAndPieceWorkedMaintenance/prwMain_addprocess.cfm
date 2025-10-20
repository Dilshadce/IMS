<cfif isdefined ("url.type")>
<cfquery name="delete_qry" datasource="#dts#">
DELETE FROM pcwork WHERE entryno = '#url.entryno#'
</cfquery>
<cflocation url="/payments/1stHalf/AddUpdate/TipAndPieceWorkedMaintenance/prwMain_add.cfm?empno=#url.empno#">

<cfelse>


<cfif form.count gt "0">

<cfloop from="1" to="#form.count#" index="i">
	
	<cfif #evaluate('form.ndate__r#i#')# neq "">
	 
	<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#evaluate('form.ndate__r#i#')#" 	returnvariable="cfc_pcdate" />
    
	
    
<cfquery name="add_qry" datasource="#dts#">
INSERT INTO pcwork (EMPNO, PC_CODE, WORK_DATE, PC_WORK, PC_YWORK)
VALUES ('#url.empno#',"#evaluate('form.ncode__r#i#')#","#cfc_pcdate#","#val(evaluate('form.nwork__r#i#'))#","#val(evaluate('form.nywork__r#i#'))#")
</cfquery>
</cfif>
</cfloop>

<cfelse>

<cfloop list="#url.empno#" index="i">

   
<cfinvoke component="cfc.dateformat" method="dbDateFormat" inputDate="#evaluate('form.pc_date__r#i#')#" returnvariable="cfc_hdate" />
<cfquery name="update_qry" datasource="#dts#">
UPDATE pcwork
SET WORK_DATE = #cfc_hdate#,
	PC_CODE ="#evaluate('form.pc_code__r#i#')#",
    PC_WORK ="#evaluate('form.pc_work__r#i#')#",
    PC_YWORK ="#evaluate('form.pc_ywork__r#i#')#"
WHERE entryno = "#i#"
</cfquery>
</cfloop>

</cfif>

</cfif>
 <cflocation url="/payments/1stHalf/AddUpdate/TipAndPieceWorkedMaintenance/prwMain_add.cfm?empno=#url.empno#">
