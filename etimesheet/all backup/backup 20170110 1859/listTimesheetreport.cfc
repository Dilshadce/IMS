<cfcomponent>
    <cffunction name="listTime" access="remote" returntype="struct"> 
        <cfset dts=form.dts>
        
        <!---<cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>--->
        
        <!---<cfset dts = trim(getdts.dts)>--->
        
        <cfset clientfrom=trim(clientfrom)>
        <cfset clientto=trim(clientto)>
        <cfset empfrom=trim(empfrom)>
        <cfset empto=trim(empto)>
        <cfset targetTable=form.targetTable>
            
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
        
        <cfquery name="getFilteredDataSet" datasource="manpower_i">
            SELECT SQL_CALC_FOUND_ROWS  *
            FROM 
            ( 	SELECT custno, custname, count(placementno) as placementcount, placementno, empno
                FROM #targetTable#
            	WHERE completedate >= now()
				
                <cfif #clientfrom# eq "" and #clientto# eq "" and #empto# eq "" and #empfrom# eq "">
                       
                    <cfelse>
                    	<cfif (isdefined('#clientfrom#') and #clientfrom# neq "") and (isdefined('#clientto#') and #clientto# neq "")>
                            AND custno BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#clientfrom#"> 
                            AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#clientto#">
                        <cfelse>
                        <cfif #clientfrom# neq "">
                            AND custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#clientfrom#">
                            <cfelseif #clientto# neq "">
                                AND custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#clientto#">
                            </cfif>
                        </cfif>
                    
                        <cfif (isdefined('#empfrom#') and #empfrom# neq "") and (isdefined('#empto#') and #empto# neq "")>
                            AND empno BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#empfrom#"> 
                            AND <cfqueryparam cfsqltype="cf_sql_varchar" value="#empto#">
                        <cfelse>
                        <cfif #empfrom# neq "">
                            AND empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#empfrom#">
                            <cfelseif #empto# neq "">
                                AND empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#empto#">
                            </cfif>
                        </cfif>
						
				</cfif>
                
				Group by custname
                
			) AS aa
            
            #sWhere#
            #sOrder#
            #sLimit#
          
        </cfquery>

        <cfquery name="getFilteredDataSetLength" datasource="manpower_i">
            SELECT FOUND_ROWS() AS iFilteredTotal
        </cfquery>
        <cfquery name="getTotalDataSetLength" datasource="manpower_i">
            SELECT COUNT(custno) AS iTotal
            FROM #targetTable#
        </cfquery>      
    
		<cfset aaData=ArrayNew(1)>
        <cfloop query="getFilteredDataSet">	
        
        	<!---custom query--->
            <cfquery name ="getplacementno" datasource="manpower_i">
                select GROUP_CONCAT(placementno) as placementno from manpower_i.placement where custname = '#custname#'
                and completedate >= now() 
            </cfquery>
                        
            <cfquery name='getvalidatedcount' datasource="manpower_p">
                select placementno 
                from manpower_p.timesheet 
                where placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementno.placementno#" list="yes" separator=",">) 
                group by placementno
            </cfquery>
                    
            <cfquery name='getapprovedcount' datasource="manpower_p">
                select placementno 
                from manpower_p.timesheet 
                where placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getplacementno.placementno#" list="yes" separator=",">) and status = "Approved" 
                group by placementno
            </cfquery>
            <!---end of custom query--->
        
            <cfset data=StructNew()>
			<cfset data["custno"]=custno>
            <cfset data["custname"]=custname>
            <cfset data["placementcount"]=placementcount>
            <cfset data["validatecount"]=#getvalidatedcount.recordCount#>
            <cfset data["approvecount"]=#getapprovedcount.recordCount#>
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