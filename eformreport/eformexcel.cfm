<cfsetting requestTimeOut = "9000" />
<cfoutput>
<cfset uuid = createuuid()>

<cfsetting showdebugoutput="yes">
<cfinclude template="/object/dateobject.cfm">
<cfinclude template="/object/stringobject.cfm">

<cfquery name="getpayroll" datasource="#dts#">
SELECT mmonth,myear FROM payroll_main.gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
<cfset payrollmonth = getpayroll.mmonth>
<cfset payrollyear = getpayroll.myear>
<cfset currentdate = createdate(val(payrollyear),val(payrollmonth),1)>

	<cffile action="WRITE" file="#HRootPath#\Excel_Report\eformexcel#dateformat(now(),'ddmmyyyy')#.csv"
    	output="Company,Client No,Client Name" 
        addnewline="yes">
        
    <cffile action="APPEND" file="#HRootPath#\Excel_Report\eformexcel#dateformat(now(),'ddmmyyyy')#.csv" 
   		output="Associate,Employee No,Employee Name,Address1,Address2,D.O.B,Gender,Race,Country of Origin,Contact No,Personal Email,Work Email,Marital Status, Passport No/IC No, Passport Expiring Date, Second Passport, Highest Education, Nationality, Emergency Contact Person, Emergency Contact No, Address of Original Country, Address of Orignal Country 2, Tax No, Tax Branch, Spouse Working, Spouse Name, Number Of Child, Child Below 18, Child Study, Child Study Diploma Above, Disabled Child, Disabled Child Study, EPF NO, Country Public Holiday Observe, Country Serve, Hiring Manager, Hiring Manager Email, Employement Pass No, Employment Pass Valid From, Employment Pass Valid To, Bank Name, Bank Account, Bank Beneficial Name, Work Place Department, Designation"
  		addnewline="Yes">
        
	<cfquery name="getClient" datasource="#dts#">
    	SELECT pmt.custno, pmt.custname, pmt.empname from manpower_p.emp_users as emp
        LEFT JOIN manpower_i.placement as pmt ON pmt.empno = emp.empno
        WHERE emp.emailsent <> '0000-00-00 00:00:00'
        GROUP by pmt.custno;
    </cfquery>
    
    <cfloop query="getClient">
    
    <cfquery name="getItem" datasource="#dts#">
    	SELECT pmt.empno, pmt.empname, pmt.department, pmt.position
        , pmast.add1, pmast.add2, pmast.dbirth, pmast.sex, pmast.race, pmast.country_code_address, pmast.sex, pmast.race, pmast.country_code_address, pmast.phone, pmast.email, pmast.workemail, pmast.mstatus, pmast.nricn, pmast.passprt_to, pmast.passport, pmast.edu, pmast.national, pmast.econtact, pmast.etelno, pmast.eadd1, pmast.eadd2
        , pmast.itaxno, pmast.itaxbran, pmast.sname, pmast.sdisble, pmast.numchild, pmast.num_child, pmast.child_edu_m, pmast.child_edu_f, pmast.child_disable, pmast.child_edu_disable
        , pmast.epfno, pmast.pbholiday, pmast.countryserve, pmast.wpermit, pmast.wp_from, pmast.wp_to, pmast.bankcode, pmast.bankaccno, pmast.bankbefname
        , emp.emailsent
        , pb.requested_on
        , ft.dbcandupdate
        , hm.username, hm.userid
        FROM manpower_p.emp_users as emp
        LEFT JOIN manpower_i.placement as pmt ON pmt.empno = emp.empno
        LEFT JOIN manpower_i.ftcandidate as ft ON emp.empno = ft.dbcandno
        LEFT JOIN manpower_p.pbupdated pb ON pb.empno = emp.empno
        LEFT JOIN manpower_p.pmast as pmast ON emp.empno = pmast.empno
        LEFT JOIN payroll_main.hmusers hm ON pmt.hrmgr = hm.entryid
        WHERE emp.emailsent <> '0000-00-00 00:00:00'
        AND pmt.custno = '#getClient.custno#'
        GROUP by emp.empno
    </cfquery>
        
        <cffile action="APPEND" file="#HRootPath#\Excel_Report\eformexcel#dateformat(now(),'ddmmyyyy')#.csv" 
            output="Company,""#getClient.custno#"",""#getClient.custname#"""
            addnewline="Yes">
		
        <cfloop query="getItem">
        	
            <cffile action="APPEND" file="#HRootPath#\Excel_Report\eformexcel#dateformat(now(),'ddmmyyyy')#.csv" 
                output="Associate,""#getItem.empno#"",""#getItem.empname#"",""#getItem.add1#"",""#getItem.add1#"",""#getItem.add2#"",""#dateformat(getItem.dbirth, 'dd/mm/yyyy')#"",""#getItem.sex#"",""#getItem.race#"",""#getItem.phone#"",""#getItem.email#"",""#getItem.workemail#"",""#getItem.mstatus#"",""#getItem.nricn#"",""#dateformat(getItem.passprt_to, 'dd/mm/yyyy')#"",""#getItem.passport#"",""#getItem.edu#"",""#getItem.national#"",""#getItem.econtact#"",""#getItem.etelno#"",""#getItem.eadd1#"",""#getItem.eadd2#"",""#getItem.itaxno#"",""#getItem.itaxbran#"",""#getItem.sname#"",""#getItem.sdisble#"",""#getItem.numchild#"",""#getItem.num_child#"",""#getItem.child_edu_m#"",""#getItem.child_edu_f#"",""#getItem.child_disable#"",""#getItem.child_edu_disable#"",""#getItem.epfno#"",""#getItem.pbholiday#"",""#getItem.countryserve#"",""#getItem.username#"",""#getItem.userid#"",""#getItem.wpermit#"",""#getItem.wp_from#"",""#getItem.wp_to#"",""#getItem.bankcode#"",""#getItem.bankaccno#"",""#getItem.bankbefname#"",""#getItem.department#"",""#getItem.position#"""
                addnewline="Yes">
            
        </cfloop>
  
        
    </cfloop>
		
        
		<!---FINISHED WRITING CSV--->
		
        <cfheader name="Content-Type" value="csv">
		<cfset filename = "eformexcel#dateformat(now(),'ddmmyyyy')#.csv">

		<cfheader name="Content-Disposition" value="inline; filename=#filename#">		
		<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\eformexcel#dateformat(now(),'ddmmyyyy')#.csv">
</cfoutput>