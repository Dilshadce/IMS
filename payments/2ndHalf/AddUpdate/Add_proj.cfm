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

<cfif isdefined ("url.type")>
	
	<cfif url.type eq "add">
		<cfquery name="select_emp_list" datasource="#dts#">
			select empno from paytran <cfif isdefined("form.allEMP") eq false>WHERE empno = "#form.empno#"</cfif>
		</cfquery>
	
		<cfloop query="select_emp_list" >
			<cfset ndate = createdate(right(form.date_p1,4),mid(form.date_p1,4,2),left(form.date_p1,2))>
			<cfquery name="add_pj_qry" datasource="#dts#">
				Insert into proj_rcd
				(empno,project_code,date_p,dw_p,mc_p,npl_p,ot1_p,ot2_p,ot3_p,ot4_p,ot5_p,ot6_p)
				values
				(<cfqueryparam cfsqltype="cf_sql_varchar" value="#select_emp_list.empno#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(ndate,'yyyymmdd')#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dw_p#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mc_p#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.npl_p#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ot1_p#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ot2_p#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ot3_p#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ot4_p#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ot5_p#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ot6_p#">)
			</cfquery>
		</cfloop>
		
		<cflocation url="/payments/2ndHalf/AddUpdate/normalPayEditForm.cfm?empno=#URLEncodedFormat(empno)#">
		
	
	<cfelseif url.type eq "update">
		<cfset qString="select * FROM proj_rcd where entryno = #form.entryno_u# and empno='#form.empno#'">
	
		<cfinvoke component="cfc.auditTrail" method="toArray" dts="#dts#" qStr="#qString#" returnvariable="array_ov">	
		
		<cfset ndate = createdate(right(form.date_p1,4),mid(form.date_p1,4,2),left(form.date_p1,2))>
		<cfquery name="update_pj_qry" datasource="#dts#">
			update proj_rcd 
			set project_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.project#">,
				date_p = <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(ndate,'yyyymmdd')#">,
				dw_p = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dw_p#">,
				mc_p = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mc_p#">,
				npl_p = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.npl_p#">,
				ot1_p = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ot1_p#">,
				ot2_p = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ot2_p#">,
				ot3_p = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ot3_p#">,
				ot4_p = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ot4_p#">,
				ot5_p = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ot5_p#">,
				ot6_p = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ot6_p#">
			where entryno = #form.entryno_u#
			and empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
		</cfquery>
		
		<cfinvoke component="cfc.auditTrail" method="createAuditFrmUpdate" dts="#dts#" act="update" 
			user="#Huserid#" module="PYM" pointer="proj_rcd[entryno = #form.entryno_u#
				and empno ='#form.empno#']" oldArray="#array_ov#" 
			qStr="#qString#"  comment="2nd half project site 1">
		
		<cflocation url="/payments/2ndHalf/AddUpdate/normalPayEditForm.cfm?empno=#URLEncodedFormat(form.empno)#">
		
	<cfelseif url.type eq "del">
		<cfset delentryno= url.entryno>
		<cfset empno= url.empno>
		
		<cfquery datasource="#dts#" name="getAudit1">
			select * FROM proj_rcd
			where entryno = #delentryno# and empno='#empno#'
		</cfquery>
		<cfset qString="select * FROM proj_rcd where entryno = #delentryno# and empno='#empno#'">
		<cfinvoke component="cfc.auditTrail" method="toArray" dts="#dts#" qStr="#variables.qString#" returnvariable="array_ov">	
		
		<cfquery name="del_prj_qry" datasource="#dts#">
			Delete FROM proj_rcd where entryno=#delentryno#
		</cfquery>
		
		<cfinvoke component="cfc.auditTrail" method="createAuditFrmDelete" dts="#dts#" act="delete" user="#huserid#" module="PYM" pointer="proj_rcd_1[entryno='#delentryno#']" 
					dataQr="#getAudit1#" comment="2nd half project site 1">
					
		<cflocation url="/payments/2ndHalf/AddUpdate/normalPayEditForm.cfm?empno=#URLEncodedFormat(empno)#">
		
	</cfif>
</cfif>

<html>
<head>
	<title>2nd Half - Add Daily Record</title>
</head>
<body>

<cfquery name="emp_qry" datasource="#dts#">
SELECT empno, name FROM pmast where empno="#URLDecode(url.empno)#" 
</cfquery>
<cfquery name="prj_qry" datasource="#dts#">
SELECT * FROM project
</cfquery>

<cfif isdefined ("url.act")>
	<cfset entry_no= url.entryno>
	<cfquery name="prj_rcd_qry" datasource="#dts#">
		SELECT * FROM proj_rcd where entryno=#entry_no#
	</cfquery>
	<cfset project_c = prj_rcd_qry.project_code>
	<cfset date_p = dateformat(prj_rcd_qry.date_p,'dd-mm-yyyy')>
	<cfset dw_p = prj_rcd_qry.dw_p>
	<cfset mc_p = prj_rcd_qry.mc_p>
	<cfset npl_p = prj_rcd_qry.npl_p>
	<cfset ot1_p = prj_rcd_qry.ot1_p>
	<cfset ot2_p = prj_rcd_qry.ot2_p>
	<cfset ot3_p = prj_rcd_qry.ot3_p>
	<cfset ot4_p = prj_rcd_qry.ot4_p>
	<cfset ot5_p = prj_rcd_qry.ot5_p>
	<cfset ot6_p = prj_rcd_qry.ot6_p>

<cfelse>
	<cfset date_p = dateformat(now(),'dd/mm/yyyy')>
	<cfset dw_p = "">
	<cfset mc_p = "">
	<cfset npl_p = "">
	<cfset ot1_p = "">
	<cfset ot2_p = "">
	<cfset ot3_p = "">
	<cfset ot4_p = "">
	<cfset ot5_p = "">
	<cfset ot6_p = "">
</cfif>

<cfoutput>
	<cfif isdefined ("url.act")>
		<form name="aform" method="post" action="add_proj.cfm?type=update">
		<input type="hidden" id="entryno_u" name="entryno_u" value="#url.entryno#">
	<cfelse>
		<form name="aform" method="post" action="add_proj.cfm?type=add">
	</cfif>
	<table class="form">
	<tr>
		<th>Employee Number</th>
		<td><input type="text" name="empno" id="empno" value="#URLDecode(url.empno)#" readonly/></td>
	</tr>
	<tr>
		<th>Employee Name</th>
		<td><input type="text" name="name" id="name" value="#emp_qry.name#" size="50" readonly/></td>
	</tr>
	
	<cfif isdefined ("url.act")>
	<tr>
		<th>Project</th>
		<td><select name="project">
				<cfloop query="prj_qry">
				<option  value="#prj_qry.project#" #IIF(prj_qry.project eq project_c,DE('selected'),DE(''))# >#prj_qry.project# - #prj_qry.desp#</option>
				</cfloop>
			</select>
		</td>
	</tr>
	<cfelse>
	<tr>
		<th>Project</th>
		<td>
			<select name="project">
				<option value="">Please Select a project</option>
				<cfloop query="prj_qry">
				<option value="#prj_qry.project#">#prj_qry.project# - #prj_qry.desp#</option>
				</cfloop>
			</select>
		</td>
	</tr>
	</cfif>
	<tr>
		<th>Date</th>
		<td><input type="text" size="10" maxlength="10" name="date_p1" id="date_p1" value="#date_p#" />
			<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(document.getElementById('date_p1'));">(dd/mm/yyyy)
		</td>
	</tr>
	<tr>
		<th>DW</th>
		<td><input type="text" name="dw_p" value="#dw_p#" size="10" maxlength="10" /></td>
	</tr>
	<tr>
		<th>MC</th>
		<td><input type="text" name="mc_p" value="#mc_p#" size="10" maxlength="10" /></td>
	</tr>
	<tr>
		<th>NPL</th>
		<td><input type="text" name="npl_p" value="#npl_p#" size="10" maxlength="10" /></td>
	</tr>
	<tr>
		<th>OT1</th>
		<td><input type="text" name="ot1_p" value="#ot1_p#" size="10" maxlength="10" /></td>
	</tr>
	<tr>
		<th>OT2</th>
		<td><input type="text" name="ot2_p" value="#ot2_p#" size="10" maxlength="10" /></td>
	</tr>
	<tr>
		<th>OT3</th>
		<td><input type="text" name="ot3_p" value="#ot3_p#" size="10" maxlength="10" /></td>
	</tr>
	<tr>
		<th>OT4</th>
		<td><input type="text" name="ot4_p" value="#ot4_p#" size="10" maxlength="10" /></td>
	</tr>
	<tr>
		<th>OT5</th>
		<td><input type="text" name="ot5_p" value="#ot5_p#" size="10" maxlength="10" /></td>
	</tr>
	<tr>
		<th>OT6</th>
		<td><input type="text" name="ot6_p" value="#ot6_p#" size="10" maxlength="10" /></td>
	</tr>
	
	<cfif isdefined ("url.act")>
		</tr>
			<tr>
			<td>&nbsp</td>
			<td><input type="submit" name="submit" value="Update"/></td>
		</tr>
	
	<cfelse>
		<tr>
			<td>&nbsp</td>
			<td><input name="allEmp" type="checkbox" value="allEmp" />For All Employee</td>
		</tr>
			<tr>
			<td>&nbsp</td>
			<td><input type="submit" name="submit" value="Save"></td>
		</tr>
		</table>
	</cfif>
</form>
</cfoutput>
</body>
</html>