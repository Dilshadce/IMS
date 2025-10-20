<cftry>
<cfquery name="getdate" datasource="#dts_main#">
SELECT * FROM gsetup WHERE comp_id = "#HcomID#"
</cfquery>

<cfset mon = #numberformat(getdate.mmonth,'00')# >
<cfset yrs = getdate.myear>

<cfquery name="select_emp_list" datasource="#dts#">
SELECT * FROM paytra1
</cfquery>

<cfquery name="num_pc_code" datasource="#dts#">
SELECT * FROM PCtab2
</cfquery>

<cfloop query="select_emp_list">

<cfquery name="update_count_pcwork" datasource="#dts#">
SELECT * FROM pcwork WHERE empno = "#select_emp_list.empno#"
</cfquery>
<cfset i = 1>
<cfloop query="update_count_pcwork">

<cfquery name="update_count" datasource="#dts#">
UPDATE pcwork SET pc_count=#i# WHERE entryno = #update_count_pcwork.entryno#
</cfquery>
<cfset i=i+1>
</cfloop>

<cfset grand_total = 0>
<cfquery name="num_piece" datasource="#dts#">
SELECT SUM(PC_WORK) as pcwork , SUM(PC_YWORK) as pcywork , pc_code FROM pcwork WHERE empno = "#select_emp_list.empno#" and substr(work_date,1,4)='#yrs#' and substr(work_date,6,2)='#mon#' GROUP BY pc_code
</cfquery>

<cfloop query="num_piece">
<cfquery name="get_pc_rate" datasource="#dts#">
SELECT pc_xrate, pc_yrate from pctab2 where pc_code = #num_piece.pc_code#
</cfquery>

<cfquery name="update_pc_T" datasource="#dts#">
Update pcwork SET PC_WORK_T = #num_piece.pcwork#, PC_YWORK_T = #val(num_piece.pcywork)# , PC_XRATE =#get_pc_rate.pc_xrate#, PC_YRATE = #get_pc_rate.pc_yrate#, HALF12 = 2 WHERE empno="#select_emp_list.empno#"
</cfquery>


<cfset total_w = #val(num_piece.pcwork)# * #val(get_pc_rate.pc_xrate)#>
<cfset total_y = #val(num_piece.pcywork)# * #val(get_pc_rate.pc_yrate)#>
<cfset total_piecepay = total_w + total_y >
<cfset grand_total = grand_total + total_piecepay >
</cfloop>




<cfquery name="update_piecepay" datasource="#dts#">
UPDATE paytra1 SET Piecepay = #grand_total# WHERE empno = "#select_emp_list.empno#"
</cfquery>
</cfloop>
<cfset status_msg="Success Update Piece Work Into Payroll">
<cfcatch type="database">
<cfset status_msg="Fail To Update Piece Work Into Payroll. Error Message : #cfcatch.Detail#">
</cfcatch>
</cftry>

<cfoutput><form name="pc"  action="/payments/1stHalf/AddUpdate/TipAndPieceWorkedMaintenance/prwMain.cfm" method="post"></cfoutput>
<cfoutput><input type="hidden" name="status" value="#status_msg#" /></cfoutput>
<cfoutput></form></cfoutput>
<script>
	pc.submit();
</script>
