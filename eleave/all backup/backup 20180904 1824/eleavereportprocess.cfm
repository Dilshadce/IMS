<cfsetting showdebugoutput="true" requesttimeout="0">
<cfoutput>
    <cfset timenow = dateformat(now(), 'yyyymmdd_hhmmss')>
        <cfset dsname = "#Replace(dts, '_i', '_p')#">
    
    <cfset headerlist = "Placement No,Employee Name,Leave Type,Days Taken,Leave Start Date,Leave Start Time,Leave End Date,Leave End Time,Leave Status,Employee Remarks,Manager Remarks,Document Name,Updated On,Updated By,Submitted On,Employee No,Client No,Client Name">
    
	<cfquery name="getleavetype" datasource="#dts#">
	    SELECT * FROM iccostcode ORDER BY costcode
	</cfquery>

    <cfloop query = "getleavetype">
        <cfset headerlist = ListAppend(headerlist, '#UCase(getleavetype.costcode)# (#UCase(getleavetype.desp)#) Entitle', ',')>
        <cfset headerlist = ListAppend(headerlist, '#UCase(getleavetype.costcode)# (#UCase(getleavetype.desp)#) Days Entitled', ',')>
    </cfloop>
    
    <!---<cfset headerlist = ListAppend(headerlist, '#headerlist2#', ',')>--->
    
    <cfquery name="getleave" datasource="#dts#">                                                                    <!---main query--->
        SELECT 
        ll.placementno,
        pl.empname,
        ll.leavetype,
        ll.days,
        ll.startdate,
        ll.startampm,
        ll.enddate,
        ll.endampm,
        ll.status,
        ll.remarks, 
        ll.mgmtremarks,
        ll.signdoc,
        ll.updated_on,
        ll.updated_by,
        ll.submited_on,
        pl.empno,
        pl.custno,
        pl.custname
        <cfloop query="getleavetype">
            ,pl.#getleavetype.costcode#entitle, COALESCE(pl.#getleavetype.costcode#totaldays, 0) AS "#getleavetype.costcode#totaldays"
        </cfloop>
        FROM leavelist ll
        LEFT JOIN placement pl ON ll.placementno = pl.placementno
        WHERE 1=1
        
        <cfif (#IsDefined('form.customerFrom')# AND "#form.customerFrom#" NEQ "") AND (#IsDefined('form.customerTo')# AND "#form.customerTo#" NEQ "")>
            AND pl.custno BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerFrom#"> 
            AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerTo#">
        <cfelse>
            <cfif "#form.customerFrom#" NEQ "">
                AND pl.custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerFrom#">
            <cfelseif "#form.customerTo#" NEQ "">
                AND pl.custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.customerTo#">
            </cfif>
        </cfif>

        <cfif (#IsDefined('form.empFrom')# AND "#form.empFrom#" NEQ "") AND (#IsDefined('form.empTo')# AND "#form.empTo#" NEQ "")>
            AND pl.empno BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empFrom#"> 
            AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empTo#">
        <cfelse>
            <cfif "#form.empFrom#" NEQ "">
                AND pl.empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empFrom#">
            <cfelseif "#form.empTo#" NEQ "">
                AND pl.empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empTo#">
            </cfif>
        </cfif>
                
        <cfif (#IsDefined('form.PONOFrom')# AND "#form.PONOFrom#" NEQ "") AND (#IsDefined('form.PONOTo')# AND "#form.PONOTo#" NEQ "")>
            AND pl.po_no BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PONOFrom#"> 
            AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PONOTo#">
        <cfelse>
            <cfif "#form.PONOFrom#" NEQ "">
                AND pl.po_no = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PONOFrom#">
            <cfelseif "#form.PONOTo#" NEQ "">
                AND pl.po_no = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PONOTo#">
            </cfif>
        </cfif>
                
        <cfif #IsDefined('form.custlist')# AND "#form.custlist#" NEQ "">
            AND custno IN (<cfqueryparam list="Yes" separator="," value="#Replace(form.custlist, ' ', '', 'ALL')#">)
        </cfif>
            
        <cfif #IsDefined('form.emplist')# AND "#form.emplist#" NEQ "">
            AND empno IN (<cfqueryparam list="Yes" separator="," value="#Replace(form.emplist, ' ', '', 'ALL')#">)
        </cfif>
            
        <cfif #IsDefined('form.filteremplist')# AND "#form.filteremplist#" NEQ "">
            AND empno NOT IN (<cfqueryparam list="Yes" separator="," value="#Replace(form.filteremplist, ' ', '', 'ALL')#">)
        </cfif>
        
        ORDER BY pl.empname, ll.placementno ASC, ll.startdate ASC
    </cfquery>
                
    <cfquery name="groupPno" dbtype="query">
       SELECT placementno, empname FROM getleave GROUP BY placementno, empname ORDER BY empname, placementno ASC
    </cfquery>
                
    <cfset s23 = StructNew()>                                                                                       <!---header formatting--->
    <cfset s23.font="Arial">
    <cfset s23.fontsize="11">
    <cfset s23.bold="true">
    <cfset s23.alignment="center">
    <cfset s23.verticalalignment="vertical_bottom">
        
    <cfset balancelist = "">                                                                                        <!---leave balance header--->
    <cfloop query = "getleavetype">
        <cfif ListFind("EL,NPL,PPH", "#getleavetype.costcode#" , ",") NEQ 0>
            <cfcontinue>
        </cfif>
        <cfset balancelist = ListAppend(balancelist, '#UCase(getleavetype.costcode)# Balance', ',')>
    </cfloop>
            
    <cfset excel = SpreadSheetNew(true)>                                                                            <!---write leave balance header--->
    <cfset rowcount = 1>
    <cfset SpreadSheetAddRow(excel,"Placementno,Employee No,Name,#balancelist#")>
    <cfset SpreadSheetFormatRow(excel, s23, rowcount)>
    <cfset rowcount += 1>
    
    
    <cfloop query="groupPno">                                                                                       <!---calculate leave balance and write it--->
        <cfset realbalancelist = "">
        <cfloop query="getleavetype">
            <cfif ListFind("EL,NPL,PPH", "#getleavetype.costcode#" , ",") NEQ 0>
                <cfcontinue>
            </cfif>
            <cfquery name="getbalance" dbtype="query">
                SELECT SUM(days) AS taken FROM getleave
                WHERE placementno = '#groupPno.placementno#' AND leavetype = '#getleavetype.costcode#' AND status = 'APPROVED'
            </cfquery>
            <cfquery name="getdays" dbtype="query">
                SELECT * FROM getleave WHERE placementno = '#groupPno.placementno#'
            </cfquery>
            <cfset newbalance = #Val(Evaluate('getdays.#getleavetype.costcode#totaldays'))# - #Val(getbalance.taken)#>
            <cfset realbalancelist = ListAppend(realbalancelist,  '#newbalance#', ',')>
        </cfloop>
        
        <cfset SpreadSheetAddRow(excel,"#getdays.placementno#,#getdays.empno#,#getdays.empname#,#realbalancelist#")>
        <cfset rowcount += 1>
    </cfloop>
    
    <cfset SpreadSheetAddRow(excel," ")>
    <cfset rowcount += 1>
    
    <cfset SpreadSheetAddRow(excel,"#headerlist#")>                                                                  <!---Write leave record header--->
    <cfset SpreadSheetFormatRow(excel, s23, rowcount)>
    <cfset rowcount += 1>
    
    <cfset SpreadSheetAddRows(excel, getleave)>                                                                      <!---Write the leave record--->

    <cfspreadsheet action="write" filename="#HRootPath#\Excel_Report\LeaveReport_#timenow#.xlsx" name="excel" overwrite="true">
    
    <!---<cfspreadsheet action="write" filename="#HRootPath#\Excel_Report\LeaveReport_#timenow#.xlsx" query="getleave" overwrite="true">--->
    <cfif #IsDefined('Leave_Report')# AND "#form.Leave_Report#" EQ "Leave Report with attachment">
        <cfquery name="checkAttachment" dbtype="query">
            SELECT placementno, empno, signdoc FROM getleave
            WHERE signdoc != ''
        </cfquery>
        
        <cfset attachmentfound = false>            
        <cfloop query="checkAttachment">
            <cfif #FileExists("#Replace(HRootPath, 'IMS', 'PAY-Associate')#/upload/#dsname#/leave/#checkAttachment.empno#/#checkAttachment.placementno#/#checkAttachment.signdoc#")# EQ "YES">
                
                <cfset attachmentfound = true>
                <cfbreak>
            </cfif>        
        </cfloop>
        
        <cfif #attachmentfound# EQ true>
            <cfzip file = "#HRootPath#\Excel_Report\LeaveReport_#timenow#.zip" action="zip">
                <cfloop query="groupPno">
                    <cfquery name="getAttachment" dbtype="query">
                        SELECT placementno, empno, signdoc FROM getleave
                        WHERE placementno = '#groupPno.placementno#' AND signdoc != ''
                    </cfquery>

                    <cfloop query="getAttachment">
                        <cfset filepath = "#Replace(HRootPath, 'IMS', 'PAY-Associate')#/upload/#dsname#/leave/#getAttachment.empno#/#getAttachment.placementno#/#getAttachment.signdoc#">
                        <cfif #FileExists("#filepath#")#>
                            <cfzipparam source="#filepath#" prefix="#getAttachment.placementno#">
                        </cfif>
                    </cfloop>
                </cfloop>
                <cfzipparam source="#HRootPath#\Excel_Report\LeaveReport_#timenow#.xlsx">
            </cfzip>
            
            <cfset headervalue = "zip">
            <cfset filename = "LeaveReport_#timenow#.zip">
            <cfset contenttype = "application/x-zip-compressed">
        <cfelse>
            <cfset headervalue = "xlsx">
            <cfset filename = "LeaveReport_#timenow#.xlsx">
            <cfset contenttype = "application/vnd.ms-excel">	
        </cfif>
    <cfelse>
        <cfset headervalue = "xlsx">
        <cfset filename = "LeaveReport_#timenow#.xlsx">  
        <cfset contenttype = "application/vnd.ms-excel">
    </cfif>
    
    <cfheader name="Content-Type" value="#headervalue#">

    <cfheader name="Content-Disposition" value="inline; filename=#filename#">		
    <cfcontent type="#contenttype#" deletefile="yes" file="#HRootPath#\Excel_Report\LeaveReport_#timenow#.#headervalue#"> 
        
</cfoutput>