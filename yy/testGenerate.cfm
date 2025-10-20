<cfquery name="getAssignment" datasource="manpower_p">
	SELECT empno,EPFCC,EPFWW,SOCSOCC,SOCSOWW FROM pay1_12m_fig where tmonth =2 and epfCC > 0;
</cfquery>

<cfscript>
	// init variables
	filename = "EPF_REPORT";
	excelData = [];

	headerFields = [
		"empno","epfcc","Epfww","SOCSOCC","SOCSOWW"
	];

	for(i = 1; i <= getAssignment.recordCount; i++){
		ArrayAppend(excelData,[
			getAssignment['empno'][i],
			getAssignment['epfcc'][i],
			getAssignment['epfww'][i],
			getAssignment['socsocc'][i],
			getAssignment['socsoww'][i]
		]);
	}

</cfscript>

<cfinclude template="excel/excel_generator.cfm">