<cfcomponent>
    <cffunction name="listAccount" access="remote" returntype="struct"> 
        <!---<cfset dts=form.dts>--->
        <!---<cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>
        <cfset dts = trim(getdts.dts)>--->
        
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
            
        <cfquery name="getFilteredDataSet" datasource="#dts#">
            SELECT SQL_CALC_FOUND_ROWS *
            FROM 
            (
                SELECT pm.placementno, pm.empno, pm.empname, pm.custno, 
                pm.custname, tm.start, tm.end,
                tm.tmonth, tm.created_on, tm.updated_on, tm.mgmtremarks,
                tm.mpremarks, tm.validated_on
                FROM placement AS pm
                LEFT JOIN
                (
                    SELECT placementno, tmonth, MIN(pdate) AS start, 
                    MAX(pdate) AS end, created_on, updated_on, mgmtremarks,
                    mpremarks, validated_on
                    FROM #dsname#.#targetTable#
                    WHERE status IN ("PROCESSED")
                    GROUP BY placementno, tmonth
                )            
                AS tm ON pm.placementno = tm.placementno
                WHERE (pm.mppic = "#huserid#" OR pm.mppic2 = "#huserid#" OR pm.mppicsp = "#huserid#")
                AND tm.start IS NOT NULL
                    
            ) AS aa
            
            #sWhere#
            #sOrder#
            #sLimit#
        </cfquery>
    
        <cfquery name="getFilteredDataSetLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS iFilteredTotal
        </cfquery>
        <cfquery name="getTotalDataSetLength" datasource="#dsname#">
            SELECT COUNT(placementno) AS iTotal
            FROM
            (
                SELECT placementno
                FROM timesheet
                WHERE status IN ("PROCESSED")
                GROUP BY placementno, tmonth
            ) counter
        </cfquery>      
    
		<cfset aaData=ArrayNew(1)>
        <cfloop query="getFilteredDataSet">	
            <cfset data=StructNew()>
            <cfset data["CurrentRow"]=CurrentRow>
			<cfset data["empno"]=empno>
			<cfset data["empname"]=empname>
            <cfset data["placementno"]=placementno>
            <cfset data["custno"]=custno>
            <cfset data["custname"]=custname>
            <cfset data["created_on"]=dateformat(created_on,'dd/mm/yyyy')>
            <cfset data["updated_on"]=dateformat(updated_on,'dd/mm/yyyy')>
            <cfset data["validated_on"]=dateformat(validated_on,'dd/mm/yyyy')>
            <cfset data["tmonth"]=monthasstring(tmonth)>
            <cfset data["start"]=dateformat(start, 'yyyy-mm-dd')>
            <cfset data["end"]=dateformat(end, 'yyyy-mm-dd')>
            <cfset data["tmonth1"]=tmonth>
            <cfset data["MGMTREMARKS"]=mgmtremarks>
            <cfset data["mpremarks"]=mpremarks>
            <cfset data["textbox_id"]="management_#tmonth#_#placementno#">
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