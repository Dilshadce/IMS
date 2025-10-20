<cfcomponent>
<cffunction name="listAccount" access="remote" returntype="struct">
	<!---<cfset dts=form.dts>--->
	<cfquery name="getdts" datasource="main">
     	SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    </cfquery>
    <cfset dts = trim(getdts.dts)>	
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
        a.itemno, a.relitemno,b.desp,b.despa,b.price,
        ifnull(ifnull(b.qtybf,0)+ifnull(c.sumtotalin,0)-ifnull(d.sumtotalout,0),0) AS balance
        FROM (relitem a,icitem b)
        LEFT JOIN (
            SELECT itemno,sum(qty) AS sumtotalin 
            FROM ictran 
            WHERE type IN ('RC','CN','OAI','TRIN') 
            AND itemno IN (
            	SELECT relitemno 
                FROM relitem)
            AND fperiod<>'99'
            AND (void = '' OR void IS NULL)
            GROUP BY itemno
        ) AS c 
        ON a.relitemno=c.itemno
        LEFT JOIN (
            SELECT itemno,sum(qty) AS sumtotalout 
            FROM ictran 
            WHERE type IN ('INV','DO','DN','CS','OAR','PR','ISS','TROU') 
            AND itemno IN (
            	SELECT relitemno 
                FROM relitem)
            AND fperiod<>'99'
            AND (void = '' or void is null)
            AND (toinv='' or toinv is null) 
            GROUP BY itemno
        ) AS d 
        ON a.relitemno=d.itemno
        WHERE a.relitemno=b.itemno
        #sWhere#
        #sOrder#
        #sLimit#
	</cfquery>

	<cfquery name="getFilteredDataSetLength" datasource="#dts#">
		SELECT FOUND_ROWS() AS iFilteredTotal
	</cfquery>
	<cfquery name="getTotalDataSetLength" datasource="#dts#">
		SELECT COUNT(itemno) AS iTotal
		FROM relitem
	</cfquery>
    
		<cfset aaData=ArrayNew(1)>
		<cfloop query="getFilteredDataSet">	
			<cfset data=StructNew()>
			<cfset data["itemno"]=itemno>
   			<cfset data["relitemno"]=relitemno>
            <cfset data["desp"]=desp>
            <cfset data["price"]=price>
            <cfset data["balance"]=balance>
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