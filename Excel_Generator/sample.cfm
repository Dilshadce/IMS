<!--- MINIMAL example --->

<cfquery name="getAssignment" datasource="manpower_i">
	SELECT empno,empname,custno,custname from manpower_i.assignmentslip limit 20
</cfquery>

<cfscript>
	Builder = createObject("component","Excel_builder").init();

	Builder.setFilename("myFile");
	headerFields = [
		"empno",'empname','custno','custname'
	];

	Builder.setHeader(headerFields);

	for(i = 1; i <= getAssignment.recordCount; i++){
		line = [
			getAssignment['empno'][i],
			getAssignment['empname'][i],
			getAssignment['custno'][i],
			getAssignment['custname'][i]
		];
		Builder.addLine(line);
	}

	Builder.output();

</cfscript>
