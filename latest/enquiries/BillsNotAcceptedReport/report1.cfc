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
				<cfset sWhere=sWhere&"a."&Evaluate('form.mDataProp_'&i)&" LIKE ""%"&trim(form.sSearch)&"%"" OR ">
			</cfif>
		</cfloop>
		<cfset sWhere=Left(sWhere,Len(sWhere)-4)>
		<cfset sWhere=sWhere&")">    
	</cfif>
	
	<cfquery name="getFilteredDataSet" datasource="#dts#">
		SELECT SQL_CALC_FOUND_ROWS a.*,a.net_bil,a.gross_bil,b.totalamt 
        FROM artran AS a 
        LEFT JOIN (SELECT sum(amt_bil) AS totalamt,refno,type 
                   FROM ictran 
                   WHERE type in ('CS','INV','DO','PO','RC','PR','SO','QUO','DN','CN','SAM') 
        GROUP BY type,refno)AS b on a.refno=b.refno AND a.type=b.type
        WHERE a.net+a.discount <> b.totalamt
        AND  a.type in ('CS','INV','DO','PO','RC','PR','SO','QUO','DN','CN','SAM')
        AND (a.taxincl='' OR a.taxincl is null OR a.taxincl='F')
        AND a.fperiod <> '99'
        #sWhere#        
        #sOrder#
        #sLimit#
	</cfquery>

	<cfquery name="getFilteredDataSetLength" datasource="#dts#">
		SELECT FOUND_ROWS() AS iFilteredTotal
	</cfquery>
	<cfquery name="getTotalDataSetLength" datasource="#dts#">
		SELECT COUNT(type) AS iTotal
		FROM artran
	</cfquery>
    
		<cfset aaData=ArrayNew(1)>
		<cfloop query="getFilteredDataSet">	
			<cfset data=StructNew()>
			<cfset data["type"]=type>
   			<cfset data["refno"]=refno>
            <cfset data["wos_date"]=dateformat(wos_date,"dd/mm/yyyy")>
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