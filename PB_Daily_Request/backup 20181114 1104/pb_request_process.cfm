<cfset dsname = #replace(dts, '_i', '_p')#>
<cfset timenow = dateformat(now(), 'hhmmss')>
<cfif "#form.startdate#" NEQ "#form.enddate#">
    <cfset requestdate = "#form.startdate#_to_#form.enddate#">
<cfelse>
    <cfset requestdate = "#form.startdate#">
</cfif>
    
<cfquery name="getPB" datASource="#dsname#">
	SELECT a.empno, a.pbdata, a.mp4u, a.requested_on, b.name, c.desp
	FROM pbupdated a
	LEFT JOIN pmast b
	ON a.empno = b.empno
	LEFT JOIN fieldcontent c
	ON a.datafield = c.datafield
	WHERE date_format(a.requested_on, '%Y-%m-%d') >= "#DateFormat(form.startdate, 'yyyy-mm-dd')#"
	AND date_format(a.requested_on, '%Y-%m-%d') <= "#DateFormat(form.enddate, 'yyyy-mm-dd')#"
	ORDER BY a.requested_on DESC
</cfquery>
    
<!---Excel Format--->
<cfset s23 = StructNew()>                                    <!---header--->
<cfset s23.font="Arial">
<cfset s23.fontsize="11">
<cfset s23.bold="true">
<cfset s23.alignment="center">
<cfset s23.verticalalignment="vertical_bottom">
    
<cfset excel = SpreadSheetNew(true)>
<cfset SpreadSheetAddRow(excel, "Employee No,Employee Name,Client No,Client Name,Field_update,PB Data,MP4U Data,Requested_On,Hiring Manager,Hiring Manager Email")>
<cfset SpreadSheetFormatRow(excel, s23, 1)>
        
<cfloop query="getPB">
    <cfset holderstruct = #getdetails('#getPB.empno#', '#getPB.requested_on#', '#dts#')#>
        
    <cfif "#Right(getPB.pbdata, 1)#" EQ ",">
        <cfset finalpbdata = "#Left(getPB.pbdata, Len(getPB.pbdata)-1)#"&", ">
    <cfelse>
        <cfset finalpbdata = #getPB.pbdata#>
    </cfif>
        
    <cfif "#Right(getPB.mp4u, 1)#" EQ ",">
        <cfset finalmp4udata = "#Left(getPB.mp4u, Len(getPB.mp4u)-1)#"&", ">
    <cfelse>
        <cfset finalmp4udata = #getPB.mp4u#>
    </cfif>
        
    <cfset SpreadSheetAddRow(excel, "'#getPB.empno#','#getPB.name#','#holderstruct.custno#','#holderstruct.custname#','#getPB.desp#','#finalpbdata#','#finalmp4udata#','#getPB.requested_on#','#holderstruct.hmname#','#holderstruct.hmemail#'")>     
</cfloop>
    
<cfspreadsheet action="write" filename="#ExpandPath('/Report/PB_Request_#requestdate#_#timenow#.xlsx')#" name="excel" overwrite="true">
    
<cfheader name="Content-Disposition" value="inline; filename=PB_Request_#requestdate#_#timenow#.xlsx">
<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#ExpandPath('/Report/PB_Request_#requestdate#_#timenow#.xlsx')#">    
    
<cffunction name="getdetails" access="public" returntype="struct">
    <cfargument name="empnopassed">
    <cfargument name="requestedDate">
    <cfargument name="dts">
      
      <cfquery name="getcust" datasource="#dts#">
        SELECT pm.custname, pm.custno, pm.empname, hm.username, hm.useremail
        FROM placement pm
        LEFT JOIN payroll_main.hmusers hm
        ON pm.hrmgr = hm.entryid
        WHERE pm.empno = '#empnopassed#' AND "#DateFormat(requestedDate, 'yyyy-mm-dd')#" BETWEEN pm.startdate AND pm.completedate;
      </cfquery>
      
    <cfset data=StructNew()>
    <cfset data.custname=getcust.custname>
    <cfset data.custno=getcust.custno>
    <cfset data.empname=getcust.empname>
    <cfset data.hmname=getcust.username>
    <cfset data.hmemail=getcust.useremail> 
    
  <cfreturn data>
</cffunction>