
<cfsetting requesttimeout="0" >
<cfquery datasource="manpower_p" name="getEPFItem">
	SELECT shelf as aw_cou FROM #dts#.icshelf a
                LEFT JOIN awtable b on a.allowance = b.aw_cou
                WHERE b.aw_cou < 18 and aw_epf = 1
                ORDER BY shelf
</cfquery>

<cfscript>
	epfItems = [];
	for(i = 1; i <= getEPFItem.recordCount; i++){
		ArrayAppend(epfItems,getEPFItem['aw_cou'][i]);
	}
</cfscript>

<cfquery datasource="manpower_i" name="getEmp">
SELECT empno from manpower_i.assignmentslip where payrollperiod = 2 and batches!='' group by empno;
</cfquery>

<cfloop query="getEmp">
<cfset epf_pay = 0>
	<cfquery name="getAssignment" datasource="manpower_i">
		SELECT selfsalary, lvltotalee1,
		<cfloop from="1" to="6" index="i">
			<cfoutput>fixawee#i#,fixawcode#i#,</cfoutput>
			</cfloop>
			<cfloop from="1" to="18" index="i">
				<cfoutput>awee#i#,allowance#i#,</cfoutput>
			</cfloop>empname
			from assignmentslip where empno = "#getEmp.empno#" and batches != '' and payrollperiod = 2
	</cfquery>

	<cfloop query="getAssignment">
		<cfscript>
			epf_pay += val(selfsalary);
			epf_pay += val(lvltotalee1);

			for(i=1; i <= 6;i++){
				if(ArrayContains(epfItems,getAssignment['fixawcode'&i][currentRow])){
					epf_pay += val(getAssignment['fixawee'&i][currentRow]);
				}
			}

			for(i=1; i <= 18;i++){
				if(ArrayContains(epfItems,getAssignment['allowance'&i][currentRow])){
					epf_pay += val(getAssignment['awee'&i][currentRow]);
				}
			}
		</cfscript>
		</cfloop>
		<cfquery datasource="manpower_p">
			UPDATE pay1_12m_fig set epf_pay_a = #epf_pay# WHERE tmonth = 2 and empno = "#getEmp.empno#"
		</cfquery>
		<cfquery datasource="manpower_p">
			UPDATE pay2_12m_fig set epf_pay_a = 0 WHERE tmonth = 2 and empno = "#getEmp.empno#"
		</cfquery>
</cfloop>