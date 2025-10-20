<cfsetting showDebugOutput="No">
<cfif form.refno neq ''>
	<cfquery name="fillSelection" datasource="manpower_i">
		SELECT *,'' as blank FROM manpower_i.assignmentslip WHERE 1=1 and
		refno in (
			<cfloop list="#form.refno#" index="ref">
				'#ref#',
			</cfloop>''
		)
		ORDER BY empno
		;

	</cfquery>
	<cfscript>

			fieldLabel = [
				"refno","custname",'custno','empname','empno','payrollperiod',
				'basic','npl'
			];
			commonFields = ["refno","custname","custno","empname","empno","payrollperiod"];
			payFields = [
				"selfsalary","lvltotaler1"
			];
			billFields = [
				"custsalary","lvltotalee1"
			];
			for(i = 1; i<8; i++){
				ArrayAppend(payFields,"selfOT"&i);
				ArrayAppend(billFields,"custOT"&i);
				ArrayAppend(fieldLabel,"OT"&i);
			}
			for(i=1; i<6;i++){
				ArrayAppend(payFields,"fixawee"&i);
				ArrayAppend(billFields,"fixawer"&i);
				ArrayAppend(fieldLabel,"fix aw "&i);
			}
			for(i=1; i<18;i++){
				ArrayAppend(payFields,"awee"&i);
				ArrayAppend(billFields,"awer"&i);

				ArrayAppend(fieldLabel,"var aw "&i);
			}


				ArrayAppend(fieldLabel,"EPF");
				ArrayAppend(fieldLabel,"SOCSO");
				ArrayAppend(fieldLabel,"admin fee");

			ArrayAppend(payFields,"selfcpf");
			ArrayAppend(payFields,"selfsdf");
			ArrayAppend(payFields,"blank");

			ArrayAppend(billFields,"custcpf");
			ArrayAppend(billFields,"custsdf");
			ArrayAppend(billFields,"adminfee");

			for(i=1; i<6;i++){
				ArrayAppend(payFields,"blank");
				ArrayAppend(billFields,"billitemamt"&i);
				ArrayAppend(fieldLabel,"bill item "&i);
			}

			ArrayAppend(payFields,"addchargeself");
			ArrayAppend(payFields,"addchargeself2");
			ArrayAppend(payFields,"addchargeself3");


			ArrayAppend(billFields,"addchargecust");
			ArrayAppend(billFields,"addchargecust2");
			ArrayAppend(billFields,"addchargecust3");

				ArrayAppend(fieldLabel,"charge1");
				ArrayAppend(fieldLabel,"charge2");
				ArrayAppend(fieldLabel,"charge3");

			for(i = 1; i<=3; i++){
				ArrayAppend(payFields,"ded"&i);
				ArrayAppend(billFields,"dedcust"&i);

				ArrayAppend(fieldLabel,"ded"&i);
			}


			ArrayAppend(payFields,"selftotal");
			ArrayAppend(payFields,"blank");

			ArrayAppend(billFields,"blank");
			ArrayAppend(billFields,"custtotalgross");
				ArrayAppend(fieldLabel,"nett cust");
				ArrayAppend(fieldLabel,"gross");

	</cfscript>
	<table class="table table-hover">
		<cfloop from="1" to='#ArrayLen(fieldLabel)#' index="i">
			<tr>
				<th class="colField">
					<cfoutput>
						#fieldLabel[i]#
					</cfoutput>
				</th>
				<cfloop query="#fillSelection#" >
					<cfif i lte ArrayLen(commonFields)>
						<cfoutput>
							<td colspan='2' class='border-right'>
								#fillSelection[commonFields[i]][fillSelection.currentRow]#
							</td>
						</cfoutput>
					<cfelse>
						<cfoutput>
							<td class="coldata colee
								<cfif #fillSelection[payFields[i-ArrayLen(commonFields)]][fillSelection.currentRow]# GT 0 >
								yellow
								</cfif>
							">
								#fillSelection[payFields[i-ArrayLen(commonFields)]][fillSelection.currentRow]#
							</td>
							<td class="coldata coler border-right
							<cfif #fillSelection[billFields[i-ArrayLen(commonFields)]][fillSelection.currentRow]# GT 0 >
								yellow
								</cfif>
							">
								#fillSelection[billFields[i-ArrayLen(commonFields)]][fillSelection.currentRow]#
							</td>
						</cfoutput>
					</cfif>
				</cfloop>
			</tr>
		</cfloop>
	</table>
</cfif>
