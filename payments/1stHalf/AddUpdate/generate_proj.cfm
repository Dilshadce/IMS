<cfset dts=replace(dts,'_i','_p','all')>

<cfquery name="userpin_qry" datasource="#dts#">
		SELECT pin from userpin where usergroup = "#getHQstatus.userGrpID#"
	</cfquery>
	<cfset Hpin = userpin_qry.pin >
	<cfif getHQstatus.userGrpID eq "super">
		<cfset Hpin = 0>
	</cfif>
<cfset HcomID=replace(HcomID,'_i','','all')>
<cfset DTS_MAIN = "payroll_main">
<cfquery name="gsetup_qry" datasource="payroll_main">
		SELECT ccode from gsetup where comp_id = '#HcomID#'
	</cfquery>
	<cfset HuserCcode = gsetup_qry.ccode>

<cfif isdefined("url.type")>
	<cfquery name="emp_list" datasource="#dts#">
		SELECT empno FROM proj_rcd_1 where 0=0
		<cfif form.empno neq "" > and empno >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#"></cfif>
		<cfif form.empno2 neq "" > and empno <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno2#"></cfif>
	</cfquery>
	
	<cfloop query="emp_list">
		<cfquery name="prj_rcd_qry" datasource ="#dts#">
		SELECT sum(coalesce(dw_p,0)) as DW_P, sum(coalesce(MC_P,0)) as mc_p, sum(coalesce(npl_p,0)) as npl_p,
				sum(coalesce(ot1_p,0)) as ot_1, sum(coalesce(ot2_P)) as ot_2,
				sum(coalesce(ot3_p,0)) as ot_3, sum(coalesce(ot4_P)) as ot_4,
				sum(coalesce(ot5_p,0)) as ot_5, sum(coalesce(ot6_P)) as ot_6
 		FROM proj_rcd_1 WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#emp_list.empno#">
		</cfquery>
        <cfquery name="update_proj_rcd" datasource="#dts#">
			Update proj_rcd_1 set payyes = "Y", userid="#HUserName#" 
			WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#emp_list.empno#">
		</cfquery>
		<cfquery name="update_paytran_qry" datasource="#dts#">
			UPDATE paytra1 
			SET wday = #val(prj_rcd_qry.DW_P)#,
            	DW = #val(prj_rcd_qry.DW_P)#,
				mc = #val(prj_rcd_qry.MC_P)#,
				npl = #val(prj_rcd_qry.npl_p)#,
				hr1 = #val(prj_rcd_qry.ot_1)#,
				hr2 = #val(prj_rcd_qry.ot_2)#,
				hr3 = #val(prj_rcd_qry.ot_3)#,
				hr4 = #val(prj_rcd_qry.ot_4)#,
				hr5 = #val(prj_rcd_qry.ot_5)#,
				hr6 = #val(prj_rcd_qry.ot_6)#
			WHERE empno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#emp_list.empno#"> 
		</cfquery>
		
	</cfloop>
	<cflocation url="/payments/1stHalf/AddUpdate/normalPayEditForm.cfm?empno=#URLEncodedFormat(form.empno_ori)#">
</cfif>

<html>
<head>
	<title>1st Half - Generate Record</title>
</head>
<body>
<cfquery name="proj_tbl_qry" datasource="#dts#">
	SELECT p.empno, name FROM proj_rcd_1 as p left join pmast as pm on pm.empno=p.empno group by p.empno ;
</cfquery>
<cfoutput>
<form name="aform" method="post" action="generate_proj.cfm?type=generate">
<table>
	<input type="hidden" name="empno_ori" value="#url.empno#">
	<tr><th>Employee From</th>
		<td>
			<select name="empno">
				<option value="" size="30"></option>
				<cfloop query ="proj_tbl_qry">
				<option value="#proj_tbl_qry.empno#" >#proj_tbl_qry.empno#-#proj_tbl_qry.name#</option>
				</cfloop>
			</select>
			
		</td>
		</tr>
		<tr>
			<th>Employee To</th>
		<td><select name="empno2">
			<option value="">zzzzzzzzzzzz</option>
			<cfloop query ="proj_tbl_qry">
			<option value="#proj_tbl_qry.empno#" >#proj_tbl_qry.empno#-#proj_tbl_qry.name#</option>
			</cfloop>
			</select>
		</td>
	</tr>
	<tr><td colspan="2" align="center">&nbsp</td></tr>
	<tr><td colspan="2" align="center"> <input type="submit" name="submit" value="ok" ></td></tr>
</table>
</form>
</cfoutput>
</body>
</html>