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

<cfset empno=form.empno>
<cfset empno1=form.empno1>
<cfset lineno=form.lineno>
<cfset lineno1=form.lineno1>
<cfset brcode=form.brcode>
<cfset brcode1=form.brcode1>
<cfset deptcode = form.deptcode>
<cfset deptcode1 = form.deptcode1>
<cfset category = form.category>
<cfset category1 = form.category1>
<cfset emp_code = form.emp_code>
<cfset emp_code1 = form.emp_code1>
<cfset name="Under Construction">

<cfif empno neq "" AND empno1 neq "">
<!--- 	<cfwindow name="error" title="Under Progress!" modal="true" closable="false" width="250" height="160" center="true" initShow="true" >
	<p>Under Process, Please Wait!</p>
	<br />
	</cfwindow> --->
	<cfquery name="selectList" datasource="#dts#">
	Select empno from pmast where empno between #empno# AND #empno1# and confid >= #hpin#
	</cfquery>
	<cfloop query="selectList">
	<cfinvoke component="cfc.processPay" method="updatePay" empno="#selectList.empno#" db="#dts#" db1="#dts_main#" returnvariable="name" />
	</cfloop>
	<cfif name eq "success">
	<!--- <cfwindow name="success" title="Progress Complete" modal="true" closable="false" width="250" height="160" center="true" initShow="true" >
	<p>Progess Completed! </p><p><cfoutput>#selectList.recordcount#</cfoutput> Employees pay have been process</p>
	<form name="success" action="processpaymain.cfm"><input type="submit" onClick="ColdFusion.Window.hide('error')" value="Ok"></form>
	<br />
	</cfwindow> --->
	</cfif>


<cfelseif lineno neq "" AND lineno1 neq "">
	<!--- <cfwindow name="error" title="Under Progress!" modal="true" closable="false" width="250" height="160" center="true" initShow="true" >
	<p>Under Process, Please Wait!</p>
	<br />
	</cfwindow> --->
	<cfquery name="selectList" datasource="#dts#">
	Select empno from pmast where plineno between "#lineno#" AND "#lineno1#"
	</cfquery>
	<cfloop query="selectList">
	<cfoutput>
	<cfinvoke component="cfc.processPay" method="updatePay" empno="#selectList.empno#" db="#dts#" db1="#dts_main#" returnvariable="name" />
	</cfoutput>
	</cfloop>
	<cfif name eq "success">
	<cfwindow name="success" title="Progress Complete" modal="true" closable="false" width="250" height="160" center="true" initShow="true" >
	<p>Progess Completed! </p><p><cfoutput>#selectList.recordcount#</cfoutput> Employees pay have been process</p>
	<form name="success" action="processpaymain.cfm"><input type="submit" onClick="ColdFusion.Window.hide('error')" value="Ok"></form>
	<br />
	</cfwindow>
	</cfif>


	<cfelseif brcode neq "" AND brcode1 neq "">
		<cfwindow name="error" title="Under Progress!" modal="true" closable="false" width="250" height="160" center="true" initShow="true" >
		<p>Under Process, Please Wait!</p>
		<br />
		</cfwindow>
		<cfquery name="selectList" datasource="#dts#">
		Select empno from pmast where brcode between "#brcode#" AND "#brcode1#"
		</cfquery>
		<cfloop query="selectList">
			<cfoutput>
				<cfinvoke component="cfc.processPay" method="updatePay" empno="#selectList.empno#" db="#dts#" db1="#dts_main#" returnvariable="name" />
			</cfoutput>
		</cfloop>
		<cfif name eq "success">
		<cfwindow name="success" title="Progress Complete" modal="true" closable="false" width="250" height="160" center="true" initShow="true" >
			<p>Progess Completed! </p><p><cfoutput>#selectList.recordcount#</cfoutput> Employees pay have been process</p>
				<form name="success" action="processpaymain.cfm"><input type="submit" onClick="ColdFusion.Window.hide('error')" value="Ok"></form>
			<br />
		</cfwindow>
		</cfif>


	<cfelseif deptcode neq "" AND deptcode1 neq "">
		<cfwindow name="error" title="Under Progress!" modal="true" closable="false" width="250" height="160" center="true" initShow="true" >
		<p>Under Process, Please Wait!</p>
		<br />
		</cfwindow>
		<cfquery name="selectList" datasource="#dts#">
		Select empno from pmast where deptcode between "#deptcode#" AND "#deptcode1#"
		</cfquery>
		<cfloop query="selectList">
		<cfoutput>
		<cfinvoke component="cfc.processPay" method="updatePay" empno="#selectList.empno#" db="#dts#" db1="#dts_main#" returnvariable="name" />
		</cfoutput>
		</cfloop>
		<cfif name eq "success">
		<cfwindow name="success" title="Progress Complete" modal="true" closable="false" width="250" height="160" center="true" initShow="true" >
		<p>Progess Completed! </p><p><cfoutput>#selectList.recordcount#</cfoutput> Employees pay have been process</p>
		<form name="success" action="processpaymain.cfm"><input type="submit" onClick="ColdFusion.Window.hide('error')" value="Ok"></form>
		<br />
		</cfwindow>
		</cfif>

	<cfelseif category neq "" AND category1 neq "">
		<cfwindow name="error" title="Under Progress!" modal="true" closable="false" width="250" height="160" center="true" initShow="true" >
		<p>Under Process, Please Wait!</p>
		<br />
		</cfwindow>
		<cfquery name="selectList" datasource="#dts#">
		Select empno from pmast where category between "#category#" AND "#category1#"
		</cfquery>
		<cfloop query="selectList">
		<cfoutput>
		<cfinvoke component="cfc.processPay" method="updatePay" empno="#selectList.empno#" db="#dts#" db1="#dts_main#" returnvariable="name" />
		</cfoutput>
		</cfloop>
		<cfif name eq "success">
		<cfwindow name="success" title="Progress Complete" modal="true" closable="false" width="250" height="160" center="true" initShow="true" >
		<p>Progess Completed! </p><p><cfoutput>#selectList.recordcount#</cfoutput> Employees pay have been process</p>
		<form name="success" action="processpaymain.cfm"><input type="submit" onClick="ColdFusion.Window.hide('error')" value="Ok"></form>
		<br />
		</cfwindow>
		</cfif>

	<cfelseif emp_code neq "" AND emp_code1 neq "">
		<cfwindow name="error" title="Under Progress!" modal="true" closable="false" width="250" height="160" center="true" initShow="true" >
		<p>Under Process, Please Wait!</p>
		<br />
		</cfwindow>
		<cfquery name="selectList" datasource="#dts#">
		Select empno from pmast where emp_code between "#emp_code#" AND "#emp_code1#"
		</cfquery>
		<cfloop query="selectList">
			<cfoutput>
				<cfinvoke component="cfc.processPay" method="updatePay" empno="#selectList.empno#" db="#dts#" db1="#dts_main#" returnvariable="name" />
			</cfoutput>
		</cfloop>
		<cfif name eq "success">
		<cfwindow name="success" title="Progress Complete" modal="true" closable="false" width="250" height="160" center="true" initShow="true" >
		<p>Progess Completed! </p><p><cfoutput>#selectList.recordcount#</cfoutput> Employees pay have been process</p>
		<form name="success" action="processpaymain.cfm"><input type="submit" onClick="ColdFusion.Window.hide('error')" value="Ok"></form>
		<br />
		</cfwindow>
	</cfif>

<cfelse>
<cfwindow name="error" title="Under Progress!" modal="true" closable="false" width="250" height="160" center="true" initShow="true" >
<p>Under Process, Please Wait!</p>
<br />
</cfwindow>
<cfquery name="selectList" datasource="#dts#">
Select empno from pmast
</cfquery>
<cfloop query="selectList">
<cfoutput>
<cfinvoke component="cfc.processPay" method="updatePay" empno="#selectList.empno#" db="#dts#" db1="#dts_main#" returnvariable="name" />
</cfoutput>
</cfloop>
<cfif name eq "success">
<cfwindow name="success" title="Progress Complete" modal="true" closable="false" width="250" height="160" center="true" initShow="true" >
<p>Progess Completed! </p><p><cfoutput>#selectList.recordcount#</cfoutput> Employees pay have been process</p>
<form name="success" action="processpaymain.cfm?done=1&empno="><input type="submit" onClick="ColdFusion.Window.hide('error')" value="Ok"></form>
<br />
</cfwindow>
</cfif>

</cfif>
