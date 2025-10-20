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

<cfwindow name="errors" title="Under Progress!" modal="true" closable="false" width="350" height="260" center="true" initShow="true" >
<p align="center">Under Process, Please Wait!</p>
<p align="center"><img src="/images/loading.gif" name="Cash Sales" width="30" height="30"></p>
<br />
</cfwindow>
<cfset name="">
<cfflush>
<cfquery name="selectList" datasource="#dts#">
SELECT p.empno,pm.epfcat FROM paytran p, pmast pm
WHERE p.empno = pm.empno AND p.payyes="Y" AND paystatus="A" and confid >= #hpin#
<cfif #form.empno# neq "">
	AND pm.empno >= "#form.empno#"
</cfif>
<cfif #form.empno1# neq "">
	AND pm.empno <= "#form.empno1#"
</cfif>
<cfif #form.lineno# neq "">
	AND pm.plineno >= "#form.lineno#"
</cfif>
<cfif #form.lineno1# neq "">
	AND pm.plineno <= "#form.lineno1#"
</cfif>
<cfif #form.brcode# neq "">
	AND pm.brcode >= "#form.brcode#"
</cfif>
<cfif #form.brcode1# neq "">
	AND pm.brcode <= "#form.brcode1#"
</cfif>
<cfif #form.deptcode# neq "">
	AND pm.deptcode >= "#form.deptcode#"
</cfif>
<cfif #form.deptcode1# neq "">
	AND pm.deptcode <= "#form.deptcode1#"
</cfif>
<cfif #form.category# neq "">
	AND pm.category >= "#form.category#"
</cfif>
<cfif #form.category1# neq "">
	AND pm.category <= "#form.category1#"
</cfif>
<cfif #form.emp_code# neq "">
	AND pm.emp_code >= "#form.emp_code#"
</cfif>
<cfif #form.emp_code1# neq "">
	AND pm.emp_code <= "#form.emp_code1#"
</cfif>
</cfquery>

<cfquery name="get_now_month" datasource="#dts_main#">
    SELECT * FROM gsetup WHERE comp_id = "#HcomID#"
</cfquery> 
<cfif get_now_month.MMONTH gte 13>
<script type="text/javascript">
alert('You have come to the end of the year. Please kindly run year end processing to go to next year.');
</script>
<cfabort />
</cfif>

<cfloop query="selectList">
	<cfinvoke component="cfc.processPay" method="updatePay" empno="#selectList.empno#" db="#dts#" 
	db1="#dts_main#" compid= "#HcomID#" returnvariable="name" compccode="#HuserCcode#"/>
</cfloop>

<cfquery name="getempnoall" datasource="#dts#">
SELECT empno FROM pmast WHERE confid >= #hpin# and paystatus="A"
</cfquery>
<cfloop query="getempnoall">
	<cfinvoke component="cfc.sum_pay_tm" method="sum_pay" empno="#getempnoall.empno#" 
	db="#dts#"  db1="#dts_main#" compid= "#HcomID#" returnvariable="update" />
</cfloop>

<!--- Empty Pay --->
<cfinvoke component="cfc.emptypay" method="empty_pay" db="#dts#" confid= "#hpin#" returnvariable="updateno" />
            
<cfloop query="selectList">	
	<cfinvoke component="cfc.fwl_process" method="sum_fwl" returnvariable="fwl_cfc" empno="#selectList.empno#"
					db="#dts#" compid="#HcomID#" db_main="#dts_main#"	/>	
		
	<cfinvoke component="cfc.project_job_costing" method="cal_project" empno="#empno#" db="#dts#" 
			CPFCC_ADD_PRJ ="#get_now_month.CPFCC_ADD_PRJ#" CPFWW_ADD_PRJ ="#get_now_month.CPFWW_ADD_PRJ#"
				qry_tbl_pay="paytran" proj_pay_qry="proj_rcd" compid="#HcomID#" db_main="#dts_main#"
					returnvariable="update_proj" />
	<cfif HuserCcode eq "SG">
	<cfif get_now_month.nosdl eq "Y" and selectList.epfcat eq "X">
    <cfquery name="update_sdl" datasource="#dts#">
       		UPDATE comm SET levy_sd = 0  
			where empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#selectList.empno#">
   </cfquery>
   <cfset sdl_cfc="success">
	<cfelse>
		<cfinvoke component="cfc.sdl" method="cal_HRD_SDL" returnvariable="sdl_cfc" empno="#selectList.empno#"
					db="#dts#"/>
    </cfif>	
	<cfelse>
    <cfquery name="update_sdl" datasource="#dts#">
       		UPDATE comm SET levy_sd = 0  
			where empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#selectList.empno#">
       </cfquery>
		<cfset sdl_cfc="success">
	</cfif>	
	
	
					
</cfloop>

	
<cfif name eq "success" and update eq "update" and sdl_cfc eq "success" and fwl_cfc eq "fwl" and update_proj eq "success" >
<cfwindow name="success" title="Progress Complete" modal="true" closable="false" width="350" height="260" center="true" initShow="true" >
		<p>Progess Completed! </p><p><cfoutput>#selectList.recordcount#</cfoutput> Employees pay have been process</p>
		<form name="success" action="processpaymain.cfm?done=1&empno="><input type="submit" onClick="ColdFusion.Window.hide('error')" value="   OK   "></form>
		<br />
	</cfwindow>

<cfelse>
<cfwindow name="success" title="Progress Complete" modal="true" closable="false" width="350" height="260" center="true" initShow="true" >
		<p>Progess Completed! </p><p><cfoutput>#selectList.recordcount#</cfoutput> Employees pay have been process</p>
		<form name="success" action="processpaymain.cfm?done=1&empno="><input type="submit" onClick="ColdFusion.Window.hide('error')" value="   OK   "></form>
		<br />
	</cfwindow>
</cfif> 