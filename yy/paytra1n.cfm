<cfsetting requesttimeout="0" >
<cfquery name="getAssignment" datasource="#dts#">
	SELECT * from manpower_i.assignmentslip where payrollperiod = 2 and batches != "" ;
</cfquery>

<cfloop from='1' to="#getAssignment.recordCount#" index='j'>
	<cfquery datasource="manpower_p">
		UPDATE paytran set EPFCC = 0,EPFWW = 0, EPF_pay_a = 0,SOCSOCC = 0, SOCSOWW = 0

		 WHERE empno = '#getAssignment["empno"][j]#';
	</cfquery>
	<cfquery datasource="manpower_p">
		UPDATE paytra1 set EPFCC = 0,EPFWW = 0, EPF_pay_a = 0,SOCSOCC = 0, SOCSOWW = 0
		 WHERE empno = "#getAssignment['empno'][j]#";
	</cfquery>
	<cfquery datasource="manpower_p">
		UPDATE pay1_12m_fig set EPFCC = 0,EPFWW = 0, EPF_pay_a = 0,SOCSOCC = 0, SOCSOWW = 0
		 WHERE empno = "#getAssignment['empno'][j]#" and tmonth = 2;
	</cfquery>
	<cfquery datasource="manpower_p">
		UPDATE pay2_12m_fig set EPFCC = 0,EPFWW = 0, EPF_pay_a = 0,SOCSOCC = 0, SOCSOWW = 0
		 WHERE empno = "#getAssignment['empno'][j]#" and tmonth = 2;
	</cfquery>
</cfloop>

<cfloop from="1" to="#getAssignment.recordCount#" index="i">
	<cfquery name="getPayWeek" datasource="manpower_p">
		SELECT EPFCC,EPFWW,EPF_PAY_A,SOCSOCC,SOCSOWW from #getAssignment.emppaymenttype# WHERE empno = "#getAssignment['empno'][i]#"
	</cfquery>

		<cfif #getAssignment.paydate# eq "paytran">
			<cfquery datasource="manpower_p">
				UPDATE pay2_12m_fig set
				EPFCC = EPFCC + '#getPayWeek.EPFCC#',
					EPFWW = EPFWW + '#getPayWeek.EPFWW#',
					EPF_PAY_A = EPF_PAY_A + '#getPayWeek.EPF_PAY_A#',
					SOCSOCC = SOCSOCC + "#getPayWeek.SOCSOCC#",
					SOCSOWW = SOCSOWW + "#getPayWeek.SOCSOWW#"
					WHERE empno = '#getAssignment["empno"][i]#' AND TMONTH = '2';
			</cfquery>

			<cfquery datasource="manpower_p">
				UPDATE paytran set
				EPFCC = EPFCC + '#getPayWeek.EPFCC#',
					EPFWW = EPFWW + '#getPayWeek.EPFWW#',
					EPF_PAY_A = EPF_PAY_A + '#getPayWeek.EPF_PAY_A#',
					SOCSOCC = SOCSOCC + "#getPayWeek.SOCSOCC#",
					SOCSOWW = SOCSOWW + "#getPayWeek.SOCSOWW#"
					WHERE empno = '#getAssignment["empno"][i]#';
			</cfquery>
		<cfelse>
			<cfquery datasource="manpower_p">
				UPDATE pay1_12m_fig set
				EPFCC = EPFCC + '#getPayWeek.EPFCC#',
					EPFWW = EPFWW + '#getPayWeek.EPFWW#',
					EPF_PAY_A = EPF_PAY_A + '#getPayWeek.EPF_PAY_A#',
					SOCSOCC = SOCSOCC + "#getPayWeek.SOCSOCC#",
					SOCSOWW = SOCSOWW + "#getPayWeek.SOCSOWW#"
					WHERE empno = '#getAssignment["empno"][i]#' and TMONTH = '2';
			</cfquery>

			<cfquery datasource="manpower_p">
				UPDATE paytra1 set
				EPFCC = EPFCC + '#getPayWeek.EPFCC#',
					EPFWW = EPFWW + '#getPayWeek.EPFWW#',
					EPF_PAY_A = EPF_PAY_A + '#getPayWeek.EPF_PAY_A#',
					SOCSOCC = SOCSOCC + "#getPayWeek.SOCSOCC#",
					SOCSOWW = SOCSOWW + "#getPayWeek.SOCSOWW#"
					WHERE empno = '#getAssignment["empno"][i]#';
			</cfquery>
		</cfif>
</cfloop>