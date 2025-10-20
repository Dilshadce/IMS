<cfcomponent>
<cffunction name="listAccount" access="remote" returntype="struct">
	<!--- <cfset dts=form.dts> --->
    <cfquery name="getdts" datasource="main">
     SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    </cfquery>
    <cfset dts = trim(getdts.dts)>
    <cfset tran=form.tran>
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
				<cfset sOrder=sOrder&Evaluate('form.mDataProp_'&Evaluate('form.iSortCol_'&i))>
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
				<cfset sWhere=sWhere&Evaluate('form.mDataProp_'&i)&" LIKE ""%"&trim(form.sSearch)&"%"" OR ">
			</cfif>
		</cfloop>
		<cfset sWhere=Left(sWhere,Len(sWhere)-4)>
		<cfset sWhere=sWhere&")">    
	</cfif>
	
	<cfquery name="getFilteredDataSet" datasource="#dts#">
		SELECT SQL_CALC_FOUND_ROWS 
        	   type,agenno,userid,rem49,refno,desp,toinv,refno2,sono,pono,van,source,job,wos_date,
               fperiod,custno,name,frem1,frem7,frem8,rem2,created_by,currcode,term,grand_bil,permitno,
               rem1,rem3,rem4,rem5,rem6,rem7,rem8,rem9,rem10,rem11,rem30,rem31,rem32,rem45,rem46,
               updated_by,posted,void,rem45,printstatus,order_cl
		FROM #targetTable#
        WHERE type = '#tran#'
		#sWhere#
		#sOrder#
		#sLimit#
	</cfquery>

	<cfquery name="getFilteredDataSetLength" datasource="#dts#">
		SELECT FOUND_ROWS() AS iFilteredTotal
	</cfquery>
	<cfquery name="getTotalDataSetLength" datasource="#dts#">
		SELECT COUNT(refno) AS iTotal
		FROM #targetTable#
        WHERE type = '#tran#';
	</cfquery>
    

		<cfset aaData=ArrayNew(1)>
		<cfloop query="getFilteredDataSet">	
			<cfset data=StructNew()>
			<cfset data["refno"]=" "&refno>
			<cfset data["wos_date"]=wos_date>  
            <cfset data["fperiod"]=fperiod>        
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