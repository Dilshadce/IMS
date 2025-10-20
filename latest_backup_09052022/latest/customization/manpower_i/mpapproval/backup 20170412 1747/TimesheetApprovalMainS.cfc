<cfcomponent>
<cffunction name="listAccount" access="remote" returntype="struct">
    <cfset dts=form.dts>
    <cfset dts2=form.dts2>
    <cfset targetTable=form.targetTable>
    <cfset huserid=form.huserid>
    	
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
	
    <cfquery name="getempno" datasource="#dts#">
        SELECT placementno 
        FROM placement 
        WHERE (mppic = "#huserid#" or mpPIC2 = "#huserid#" or mpPicSp = "#huserid#")
	</cfquery>
    
	<cfquery name="getFilteredDataSet" datasource="#dts#">
    
		SELECT SQL_CALC_FOUND_ROWS *
        FROM 
        ( 
            SELECT * FROM(
            SELECT * FROM #dts2#.timesheet WHERE 
            status = "Validated" 
            AND placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getempno.placementno)#" separator="," list="yes">)
            GROUP BY empno, placementno, tmonth
            ORDER BY empno ) as a
            LEFT JOIN
            (
            SELECT empname,custname,custno,placementno as pno FROM placement
            ) as b
            on a.placementno = b.pno
        ) AS aa
        
		#sWhere#
		#sOrder#
		#sLimit#
	</cfquery>
	<cfquery name="getFilteredDataSetLength" datasource="#dts#">
		SELECT FOUND_ROWS() AS iFilteredTotal
	</cfquery>
	<cfquery name="getTotalDataSetLength" datasource="#dts#">
		SELECT COUNT(id) AS iTotal
		FROM #dts2#.timesheet
	</cfquery>
	
	<cfset aaData=ArrayNew(1)>
	<cfloop query="getFilteredDataSet">
        
        <cfquery name="getflday" datasource="#dts#">
            <!---SELECT min(pdate) as first,max(pdate) as last,tmonth 
            FROM placement a 
            INNER JOIN #dts2#.timesheet b 
            on a.placementno = b.placementno 
            LEFT JOIN #dts2#.pmast c 
            on b.empno = c.empno
            WHERE status IN ('Validated') and a.empno = '#getFilteredDataSet.empno#' and a.placementno = '#getFilteredDataSet.placementno#'
            AND tmonth = '#getFilteredDataSet.tmonth#'--->
            SELECT * 
            FROM #dts2#.timesheet a            
            WHERE status IN ('Validated') and a.empno = '#getFilteredDataSet.empno#' and a.placementno = '#getFilteredDataSet.placementno#'
            AND pdate >= '#dateformat(getFilteredDataSet.pdate, 'yyyy-mm-dd')#'
        	ORDER by pdate   
        </cfquery>
        
        <cfset firstZero = TRUE>						<!---starting zero flag--->
        <cfset startingDate = #getFilteredDataSet.pdate#> <!---to get starting date of the month timesheet--->
        
        <cfloop query="getflday">
        	<cfif (firstZero eq FALSE) AND (#getflday.tsrowcount# eq '0')>	<!---this will skip first tsrowcount = 0 from being skipped--->
            	<cfbreak>															<!---stops when tsrowcount reach 0(another timesheet)--->
            <cfelse>
            	<cfset endingDate = #getflday.pdate#>	<!---set end date as current pdate, as it loops over all the pdate--->
                <cfset firstZero = FALSE>							<!---timesheet ran flag set to false to--->
            </cfif>
        </cfloop>
                	
		<cfset data=StructNew()>
		<cfset data["CurrentRow"]=CurrentRow>
        <cfset data["id"]=id>
		<cfset data["empno"]=empno>
        <cfset data["empname"]=empname>
		<cfset data["placementno"]=placementno>
		<cfset data["custno"]=custno>
		<cfset data["custname"]=custname>
		<cfset data["created_on"]=dateformat(created_on,'dd/mm/yyyy')>
		<cfset data["updated_on"]=dateformat(updated_on,'dd/mm/yyyy')>
        <cfset data["validated_on"]=dateformat(validated_on,'dd/mm/yyyy')>
        <cfset data["tmonth"]=monthasstring(month(endingDate))>
        <cfset data["first"]=dateformat(startingDate,'dd/mm/yyyy')>
        <cfset data["last"]=dateformat(endingDate,'dd/mm/yyyy')>
        <cfset data["first1"]=dateformat(startingDate,'yyyy-mm-dd')>
        <cfset data["last1"]=dateformat(endingDate,'yyyy-mm-dd')>
        <cfset data["MGMTREMARKS"]=mgmtremarks>
        <cfset data["mpremarks"]=mpremarks>
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