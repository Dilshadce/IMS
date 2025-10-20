<cfcomponent>
    <cffunction name="listAccount" access="remote" returntype="struct">         
        <cfset targetTable=form.targetTable>
        <cfset dsname=form.dsname>
        <cfset dts=form.dts>
        <cfset hrootpath=form.hrootpath>
            
        <cfset sLimit="">
        <cfif IsDefined("form.iDisplayStart") AND form.iDisplayLength NEQ "-1">
            <cfset sLimit="LIMIT "&form.iDisplayStart&","&form.iDisplayLength>
        </cfif>		
        
        <cfset sOrder="">
        <cfif IsDefined("form.iSortCol_0")>
            <cfset sOrder="ORDER BY `">
            <cfloop from="0" to="#form.iSortingCols-1#" index="i" step="1">
                <cfif Evaluate('form.bSortable_'&Evaluate('form.iSortCol_'&i)) EQ "true">
                    <cfset sOrder=sOrder&Evaluate('form.mDataProp_'&Evaluate('form.iSortCol_'&i))>
                        <cfif Evaluate('form.sSortDir_'&i) EQ "asc">
                            <cfset sOrder=sOrder&"` ASC,`">
                        <cfelse>
                            <cfset sOrder=sOrder&"` DESC,`">
                        </cfif>
                </cfif>
            </cfloop>
            <cfset sOrder=Left(sOrder,Len(sOrder)-2)>
            <cfif sOrder EQ "ORDER BY `">
                <cfset sOrder="">
            </cfif>  
        </cfif>
                
        <cfset sWhere="">
        <cfif IsDefined("form.sSearch") AND form.sSearch NEQ "">
            <cfset sWhere=" WHERE (">
            <cfloop from="0" to="#form.iColumns-1#" index="i" step="1">	
                <cfif Evaluate('form.bSearchable_'&i) EQ "true">
                    <cfset sWhere=sWhere&'aa.'&Evaluate('form.mDataProp_'&i)&" LIKE ""%"&form.sSearch&"%"" OR ">
                </cfif>
            </cfloop>
            <cfset sWhere=Left(sWhere,Len(sWhere)-4)>
            <cfset sWhere=sWhere&")">
        </cfif>
            
        <cfquery name="getFilteredDataSet" datasource="#dts#">
            SELECT SQL_CALC_FOUND_ROWS *
            FROM 
            (
                SELECT a.placementno, b.empname, a.leavetype, a.days, a.startdate, a.startampm, a.enddate, a.endampm, a.status, a.remarks, a.mgmtremarks, a.signdoc,
                b.empno
                FROM leavelist a
                LEFT JOIN placement b ON a.placementno = b.placementno
                ORDER BY created_on DESC                    
            ) AS aa
            
            #sWhere#
            #sOrder#
            #sLimit#
        </cfquery>
    
        <cfquery name="getFilteredDataSetLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS iFilteredTotal
        </cfquery>
        <cfquery name="getTotalDataSetLength" dbtype="query">
            SELECT COUNT(placementno) AS iTotal
            FROM getFilteredDataSet
        </cfquery>      
    
		<cfset aaData=ArrayNew(1)>
        <cfloop query="getFilteredDataSet">	
            <cfset data=StructNew()>
            <cfset data["CurrentRow"]=CurrentRow>
			<cfset data["placementno"]=placementno>
			<cfset data["empname"]=empname>
            <cfset data["leavetype"]=leavetype>
            <cfset data["days"]=days>
            <cfset data["startdate"]=dateformat(startdate,'yyyy-mm-dd')>
            <cfset data["startampm"]=startampm>
            <cfset data["enddate"]=dateformat(enddate,'yyyy-mm-dd')>
            <cfset data["endampm"]=endampm>
            <cfset data["status"]=status>
            <cfset data["remarks"]=remarks>
            <cfset data["mgmtremarks"]=mgmtremarks>
            <cfif #FileExists("#Replace(HRootPath, 'IMS', 'PAY-Associate')#/upload/#dsname#/leave/#empno#/#placementno#/#signdoc#")# EQ "YES">
                <cfset data["signdoc"]="/#dsname#/leave/#empno#/#placementno#/#signdoc#">
            <cfelse>
                <cfset data["signdoc"]="">
            </cfif> 
            <cfset ArrayAppend(aaData,data)>
        </cfloop>
        
        <cfset output=StructNew()>
        <cfset output["sEcho"]=form.sEcho>
        <cfset output["iTotalRecords"]=getTotalDataSetLength.iTotal>
        <cfset output["iTotalDisplayRecords"]=getFilteredDataSetLength.iFilteredTotal>
        <cfset output["aaData"]=aaData>
        <cfreturn output>
    </cffunction>
</cfcomponent>