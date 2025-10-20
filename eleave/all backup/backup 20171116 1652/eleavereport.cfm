<cfoutput>
<cfset uuid = createuuid()>
<cfset timenow = dateformat(now(), 'yyyymmdd_hhmmss')>
<cfset payrollmain = "payroll_main">
<cfif IsDefined('form.Leave_Report')>
	<cfset recordtype = 'leavelist'>
	<cfset nametype = 'LeaveReport'>
    <cfset typeapplied = 'Leave'>
<cfelse>
	<cfset recordtype = 'claimlist'>		<!---else claim report is requested--->
	<cfset nametype = 'ClaimReport'>
    <cfset typeapplied = 'Claim'>
</cfif>

<cfsetting showdebugoutput="yes">

	<cfquery name="getClientNo" datasource="#payrollmain#">
    	SELECT custno FROM hmusers
        <cfif IsDefined('form.custno') AND "#form.custno#" neq "">
        	WHERE custno = "#form.custno#"
        </cfif>
        GROUP by custno
    </cfquery>

	<!---BEGIN WRITING CSV--->
    
    <cffile action="WRITE" file="#HRootPath#\eleave\#nametype#_#timenow#.csv"
    	output="E-Leave Report" 
        addnewline="yes">
        
    <cfloop query="getClientNo">
    
    	<cfquery name="getHrmgr" datasource="#payrollmain#">
        	SELECT * FROM hmusers
            WHERE custno = "#getClientNo.custno#"
        </cfquery>

        <cfloop query="getHrmgr">
        
        	<cffile action="APPEND" file="#HRootPath#\eleave\#nametype#_#timenow#.csv"
            output="Hiring Manager:,""#getHrmgr.username#"",,,Login ID:,""#getHrmgr.userID#(ID: #getHrmgr.entryid#)"",,,Client No:,""#getHrmgr.custno#""" 
            addnewline="yes">
        	
            <cfquery name="getPlacement" datasource="#dts#">
            	SELECT * FROM placement as pmt
                LEFT JOIN #replace(dts,'_i','_p')#.emp_users as emp
                ON pmt.empno = emp.empno
                WHERE pmt.hrmgr = "#getHrmgr.entryid#"
                AND pmt.jobstatus != '4'						<!---4 is closed placement--->
            </cfquery>
            
            <cfif #getPlacement.recordcount# neq 0>
            	
                <cfif IsDefined('form.Leave_Report')>
                    <cffile action="APPEND" file="#HRootPath#\eleave\#nametype#_#timenow#.csv"
                    output=",Placementno,Leave_Type,Days,Status,Startdate,Enddate,Start_time,End_time,Submitted_on,Updated_on,Updated_by,Associate_remarks,HR_remarks" 
                    addnewline="yes">
                <cfelse>
                    <cffile action="APPEND" file="#HRootPath#\eleave\#nametype#_#timenow#.csv"
                    output=",Placementno,Claim_type,Claim_amount,Status,Claim_date,Submitted_On,Claim_remarks,HR_remarks,Updated_on,Updated_by" 
                    addnewline="yes">
                </cfif>
            
            
                <cfloop query="getPlacement">
                    
                    <cfquery name="getRecord" datasource="#dts#">
                        SELECT * FROM #recordtype#
                        WHERE placementno = "#getPlacement.placementno#"
                    </cfquery>
                    
                    <cfif #getRecord.recordcount# neq 0>
                    
                        <cfloop query="getRecord">
                        
                            <cfif IsDefined('form.Leave_Report')>
                                <cffile action="APPEND" file="#HRootPath#\eleave\#nametype#_#timenow#.csv"
                                output=",""#getRecord.placementno#"",""#getRecord.leavetype#"",""#getRecord.days#"",""#getRecord.status#"",""#dateformat(getRecord.startdate, 'yyyy-mm-dd')#"",""#dateformat(getRecord.enddate, 'yyyy-mm-dd')#"",""#getRecord.startampm#"",""#getRecord.endampm#"",""#dateformat(getRecord.submited_on,'yyyy-mm-dd hh:mm:ss')#"",""#dateformat(getRecord.updated_on, 'yyyy-mm-dd HH:MM:SS')#"",""#getRecord.updated_by#"",""#getRecord.remarks#"",""#getRecord.mgmtremarks#""" 
                                addnewline="yes">
                            <cfelse>
                                <cffile action="APPEND" file="#HRootPath#\eleave\#nametype#_#timenow#.csv"
                                output=",""#getRecord.placementno#"",""#getRecord.claimtype#"",""#getRecord.claimamount#"",""#getRecord.status#"",""#dateformat(getRecord.submit_date, 'yyyy-mm-dd')#"",""#dateformat(getRecord.submited_on, 'yyyy-mm-dd')#"",""#getRecord.claimremark#"",""#getRecord.mgmtremarks#"",""#dateformat(getRecord.updated_on,'yyyy-mm-dd hh:mm:ss')#"",""#getRecord.updated_by#""" 
                                addnewline="yes">
                            </cfif>
                            
                        </cfloop>
                        
                    <cfelse>
                    
                        <cffile action="APPEND" file="#HRootPath#\eleave\#nametype#_#timenow#.csv"
                        output=",""#getPlacement.placementno#"",No #typeapplied# record" 
                        addnewline="yes">
                    
                    </cfif>
                                    
                </cfloop>
                
        	<cfelse>
            
            	<cffile action="APPEND" file="#HRootPath#\eleave\#nametype#_#timenow#.csv"
                output=",No Placement Found" 
                addnewline="yes">
            
            </cfif>
            
        </cfloop>
        
    </cfloop>
    

	<!---FINISHED WRITING CSV--->
    
    <cfheader name="Content-Type" value="csv">
    <cfset filename = "#nametype#_#timenow#.csv">

    <cfheader name="Content-Disposition" value="inline; filename=#filename#">		
    <cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\eleave\#nametype#_#timenow#.csv">
      
        
</cfoutput>