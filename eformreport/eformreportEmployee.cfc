<!---<cfcomponent>
	<cffunction name="myFunction" access="public" returntype="string">
		<cfargument name="myArgument" type="string" required="yes">
		<cfset myResult="foo">
		<cfreturn myResult>
	</cffunction>
</cfcomponent>--->

<cfcomponent>
    <cffunction name="listClient" access="remote" returntype="struct"> 
    	
        <cfset dts=#replace(form.dts,'_i','_p')#>
        
        <!---<cfset custnoform=trim(custnoform)>--->
        <cfset customerFrom = trim(customerFrom)>
        <cfset customerTo = trim(customerTo)>
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
        
        <!---<cfquery name="getFilteredDataSet" datasource="#dts#">
            SELECT SQL_CALC_FOUND_ROWS *
            FROM
            (
                SELECT pmast.name, pmast.empno, emp_users.emailsent, ftcandidate.dbcandupdate, pbupdated.requested_on
                FROM emp_users emp_users
                LEFT JOIN pmast pmast
                ON emp_users.empno = pmast.empno
                LEFT JOIN manpower_i.ftcandidate ftcandidate
                ON emp_users.empno = ftcandidate.dbcandno
                LEFT JOIN manpower_p.pbupdated pbupdated
                ON pbupdated.empno = emp_users.empno
                WHERE emp_users.emailsent <> '0000-00-00 00:00:00'
                <cfif #empnoform# neq "">
                    AND pmast.empno = "#empnoform#"
                </cfif>
                
                GROUP BY emp_users.empno

            ) as aa
            
            #sWhere#
            #sOrder#
            #sLimit#
     
        </cfquery>--->
        
        <cfquery name="getFilteredDataSet" datasource="#dts#">
            SELECT SQL_CALC_FOUND_ROWS *
            FROM
            (
                SELECT pmt.custno, pmt.custname
                FROM emp_users as emp
                LEFT JOIN #replace(dts,'_p','_i')#.#targetTable# as pmt ON emp.empno = pmt.empno
                WHERE emp.emailsent <> '0000-00-00 00:00:00'
          		<cfif #customerFrom# neq "" AND #customerTo# neq "">
                    AND pmt.custno BETWEEN "#customerFrom#" AND "#customerTo#"
                <cfelseif #customerFrom# neq "">
                	AND pmt.custno = "#customerFrom#"
                <cfelseif #customerTo# neq "">
                	AND pmt.custno = "#customerTo#"
                </cfif>
                
                GROUP BY pmt.custno
                
                
               <!--- SELECT pmast.name, pmast.empno, emp_users.emailsent, ftcandidate.dbcandupdate, pbupdated.requested_on
                FROM emp_users emp_users
                LEFT JOIN pmast pmast
                ON emp_users.empno = pmast.empno
                LEFT JOIN manpower_i.ftcandidate ftcandidate
                ON emp_users.empno = ftcandidate.dbcandno
                LEFT JOIN manpower_p.pbupdated pbupdated
                ON pbupdated.empno = emp_users.empno
                WHERE emp_users.emailsent <> '0000-00-00 00:00:00'
                <cfif #empnoform# neq "">
                    AND pmast.empno = "#empnoform#"
                </cfif>
                
                GROUP BY emp_users.empno--->

            ) as aa
            
            #sWhere#
            #sOrder#
            #sLimit#
     
        </cfquery>

        <cfquery name="getFilteredDataSetLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS iFilteredTotal
        </cfquery>
        <cfquery name="getTotalDataSetLength" datasource="#dts#">
            SELECT COUNT(custno) AS iTotal
            FROM #replace(dts,'_p','_i')#.#targetTable#
        </cfquery>   
    
		<cfset aaData=ArrayNew(1)>
        <cfloop query="getFilteredDataSet">	 
              
            <cfset data=StructNew()>
			<cfset data["custno"]=custno>
            <cfset data["custname"]=custname>
            <!---<cfset data["emailsent"]=#dateformat(emailsent, 'dd/mm/yyyy - hh:mm:ss')#>
            <cfset data["requested_on"]=#dateformat(requested_on, 'dd/mm/yyyy - hh:mm:ss')#>
            <cfset data["dbcandupdate"]=#dateformat(dbcandupdate, 'dd/mm/yyyy - hh:mm:ss')#>--->
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