<cfcomponent>
<cffunction name="listAccount" access="remote" returntype="struct">
	<!---<cfset dts=form.dts>--->
    <cfquery name="getdts" datasource="main">
     	SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    </cfquery>
    <cfset dts = trim(getdts.dts)>
	<cfset targetTable=form.targetTable>
		
	<cfset sLimit="">
	<cfif IsDefined("form.iDisplayStart") AND form.iDisplayLength NEQ "-1">
		<cfset sLimit="LIMIT "&form.iDisplayStart&","&form.iDisplayLength>
	</cfif>		
	
	<cfset sOrder="">
	<cfif IsDefined("form.iSortCol_0")>
		<cfset sOrder="ORDER BY ">
		<cfloop from="0" to="#form.iSortingCols-1#" index="i" step="1">
			<cfif Evaluate('form.bSortable_'&Evaluate('form.iSortCol_'&i)) EQ "true">
				<cfset sOrder=sOrder&"a."&Evaluate('form.mDataProp_'&Evaluate('form.iSortCol_'&i))>
				<cfif Evaluate('form.sSortDir_'&i) EQ "asc">
					<cfset sOrder=sOrder&" ASC,">
				<cfelse>
					<cfset sOrder=sOrder&" DESC,">
				</cfif>
			</cfif>
		</cfloop>
		<cfset sOrder=Left(sOrder,Len(sOrder)-1)>
		<cfif sOrder EQ "ORDER BY">
			<cfset sOrder="">
		</cfif>		
	</cfif>

	<cfset sWhere="">
	<cfif IsDefined("form.sSearch") AND form.sSearch NEQ "">
		<cfset sWhere=" AND (">
		<cfloop from="0" to="#form.iColumns-1#" index="i" step="1">	
			<cfif Evaluate('form.bSearchable_'&i) EQ "true">
				<cfset sWhere=sWhere&"a."&Evaluate('form.mDataProp_'&i)&" LIKE ""%"&trim(form.sSearch)&"%"" OR ">
			</cfif>
		</cfloop>
		<cfset sWhere=Left(sWhere,Len(sWhere)-4)>
		<cfset sWhere=sWhere&")">    
	</cfif>
	
	<cfquery name="getFilteredDataSet" datasource="#dts#">
		SELECT SQL_CALC_FOUND_ROWS 
         a.*,b.* 
        FROM artran AS a 
			LEFT JOIN (SELECT refno,refno2,wos_date,custno,name 
					   FROM artran 
					   WHERE type = 'RC'
					   AND (void = '' OR void IS NULL) 
					   AND fperiod <> '99' 
					   ) 
			AS b 
            ON a.refno2 = b.refno2 
            AND a.custno = b.custno
            AND a.refno <> b.refno
        WHERE a.type = 'RC'
        AND	(a.void = '' OR a.void IS NULL)
        AND a.fperiod <> '99'
        AND a.refno2 <> ''
        AND a.refno2=b.refno2
        #sWhere#
        #sOrder#
        #sLimit#
	</cfquery>

	<cfquery name="getFilteredDataSetLength" datasource="#dts#">
		SELECT FOUND_ROWS() AS iFilteredTotal
	</cfquery>
	<cfquery name="getTotalDataSetLength" datasource="#dts#">
		SELECT COUNT(refno) AS iTotal
		FROM artran
	</cfquery>
    
		<cfset aaData=ArrayNew(1)>
		<cfloop query="getFilteredDataSet">	
			<cfset data=StructNew()>
			<cfset data["refno"]=refno>
   			<cfset data["refno2"]=refno2>
            <cfset data["custno"]=custno>
            <cfset data["wos_date"]=dateformat(wos_date,"dd/mm/yyyy")>
            <cfset data["name"]=name>
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