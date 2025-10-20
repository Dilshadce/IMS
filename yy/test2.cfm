<cfscript>

		StatCalculator.setEmpno("100127652");
	writeoutput(StatCalculator.getEpfWage());
</cfscript>
<cfquery name='getEmp' datasource="manpower_p">

	select empno from manpower_p.pay1_12m_fig group by empno limit 100;
</cfquery>

<cfloop query="getEmp">
	<cfoutput>
		#StatCalculator.setEmpno(getEmp.empno)#
		#getEmp.empno# : #StatCalculator.getEpfWage()#
		<br />

	</cfoutput>
</cfloop>