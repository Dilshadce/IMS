<cfoutput>
<cfset dts_main = "payroll_main">
<cfif find('_i',dts)>
	<cfset dtspay = replace(dts,'_i','_p')>
<cfelseif find('_p',dts)>
	<cfset dtspay = dts>
</cfif>

<cfquery name="getallemp" datasource="#dtspay#">
SELECT empno FROM paytran where netpay is not null <!---payyes = 'y'--->
</cfquery>

<cfloop query="getallemp">
<cfinvoke component="cfc.sum_pay_tm" method="sum_pay" empno="#getallemp.empno#" db="#dtspay#"  
db1="#dts_main#" compid= "#HcomID#" returnvariable="update" />
</cfloop>

<script type="text/javascript">
alert('Done!');
</script>

Updated Employees: #getallemp.recordcount#
</cfoutput>