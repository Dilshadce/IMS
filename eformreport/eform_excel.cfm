<cfset dts_p = #replace(dts, '_i', '_p')#>
<cfset timenow = dateformat(now(), 'yyyymmdd_hhmmss')>

<cfquery name="getEform" datASource="#dts#">
	SELECT
	a.empno, a.username, a.emailsent, b.logdt, c.add1, c.add2 , c.dbirth , c.sex, c.race,
	c.country_code_address, c.phone, c.email, c.workemail, c.mstatus, c.nricn, 
	c.passprt_to, c.passport, c.edu, c.national, c.etelno, c.econtact, c.eadd1,
	c.eadd2,c.itaxno, c.itaxbran, c.sname, numchild, c.num_child, c.child_edu_m,
	c.child_edu_f, c.child_disable,	c.child_edu_disable, c.epfno, c.pbholiday, c.countryserve, c.wpermit, c.wp_FROM, c.wp_to, c.bankcode, c.bankaccno,
	c.bankbefname, d.hrmgr,	d.hrmgremail, e.username as hmname, d.department,	d.position, 
	d.custno, d.custname

	FROM #dts_p#.emp_users AS a
	LEFT JOIN
	(SELECT user_id, logdt FROM #dts_p#.emp_users_log ORDER BY logdt desc) AS b
	on a.username = b.user_id

	LEFT JOIN #dts_p#.pmast c
	on a.empno = c.empno

	LEFT JOIN
	(SELECT placementno, empno, hrmgr, hrmgremail, department, position, custno, custname
	FROM placement
	WHERE completedate >= now()) AS d
	on a.empno = d.empno

	LEFT JOIN payroll_main.hmusers e
	on d.hrmgr = e.entryid

	WHERE a.emailsent != '0000-00-00 00:00:00'
	<cfif #customerFrom# neq "" AND #customerTo# neq "">
		AND d.custno BETWEEN "#customerFrom#" AND "#customerTo#"
	<cfelseif #customerFrom# neq "">
		AND d.custno = "#customerFrom#"
	<cfelseif #customerTo# neq "">
		AND d.custno = "#customerTo#"
	</cfif>
	GROUP BY a.empno;
</cfquery>

<cfscript>
	Builder = createObject("component","/Excel_Generator/Excel_builder").init();

	Builder.setFilename("E-Form_"&timenow);
	headerFields = [
		"Employee No", "Username", "Email Sent", "Last Login", "*Address 1", "Address 2",
		"*D.O.B", "Gender", "Race", "Country of Origin", "*Contact No", "*Personal Email",
		"*Work Email", "Marital Status", "*IC/Passport", "Passport Expiry", "Second Passport", 
		"Highest Education", "Nationality", "*Emergency Contact", "*Emergency Contact Person", 
		"Original_Country_Address 1", "Original_Country_Address 2", "*Tax No",
		"Tax Branch", "Spouse Name", "Number of Child", "Child Below 18", 
		"Child Study", "Child Study Diploma", "Disabled Child", "Disabled Child Study",
		"*EPF No", "Country Public Holiday", "Country Serve", "Employment Pass No",
		"Employment Valid From", "Employment Valid To", "Bank Name", "Bank Account No",
		"Bank Beneficial Name", "*Hiring Manager ID", "*Hiring Manager Email", 
		"Hiring Manager Name", "Workplace Department", "Designation", "Customer No", 
		"Customer Name"		
	];

	Builder.setHeader(headerFields);

	for(i = 1; i <= getEform.recordCount; i++){
		line = [ 
			getEform.empno[i],
			getEform.username[i],
			getEform.emailsent[i],
			getEform.logdt[i],
			getEform.add1[i],
			getEform.add2[i],
			dateformat(getEform.dbirth[i], 'YYYY-MM-DD'),
			getEform.sex[i],
			getEform.race[i],
			getEform.country_code_address[i],
			getEform.phone[i],
			getEform.email[i],
			getEform.workemail[i],
			getEform.mstatus[i],
			getEform.nricn[i],
			getEform.passprt_to[i],
			getEform.passport[i],
			getEform.edu[i],
			getEform.national[i],
			getEform.etelno[i],
			getEform.econtact[i],
			getEform.eadd1[i],
			getEform.eadd2[i],
			getEform.itaxno[i],
			getEform.itaxbran[i],
			getEform.sname[i],
			getEform.numchild[i],
			getEform.num_child[i],
			getEform.child_edu_m[i],
			getEform.child_edu_f[i],
			getEform.child_disable[i],
			getEform.child_edu_disable[i],
			getEform.epfno[i],
			getEform.pbholiday[i],
			getEform.countryserve[i],
			getEform.wpermit[i],
			getEform.wp_FROM[i],
			getEform.wp_to[i],
			getEform.bankcode[i],
			getEform.bankaccno[i],
			getEform.bankbefname[i],
			getEform.hrmgr[i],
			getEform.hrmgremail[i],
			getEform.hmname[i],
			getEform.department[i],
			getEform.position[i],
			getEform.custno[i],
			getEform.custname[i]
		];
		
		lineType = [ 
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"Number",
			"Number",
			"Number",
			"Number",
			"Number",
			"Number",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String",
			"String"
		];

		Builder.addLine(line);
		Builder.addLineType(lineType);
	}

	Builder.setTypeFlag(True);
	
	Builder.output();

</cfscript>
