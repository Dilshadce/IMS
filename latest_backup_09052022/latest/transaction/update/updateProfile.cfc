<cfcomponent>
<cffunction name="listAccount" access="remote" returntype="struct">
	<!--- <cfset dts=form.dts> --->
    <cfquery name="getdts" datasource="main">
     SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    </cfquery>
    <cfset dts = trim(getdts.dts)>
    <cfset t1=form.t1>
    <cfset t2=form.t2>
	<cfset targetTable=form.targetTable>
		
	<cfset sLimit="">
	<cfif IsDefined("form.iDisplayStart") AND form.iDisplayLength NEQ "-1">
		<cfset sLimit="LIMIT "&form.iDisplayStart&","&form.iDisplayLength>
	</cfif>		
	
	<cfset sOrder="">
	<cfif IsDefined("form.iSortCol_0")>
		<cfset sOrder="ORDER BY ">
		<cfloop FROM="0" to="#form.iSortingCols-1#" index="i" step="1">
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
		<cfloop FROM="0" to="#form.iColumns-1#" index="i" step="1">	
			<cfif Evaluate('form.bSearchable_'&i) EQ "true">
				<cfset sWhere=sWhere&Evaluate('form.mDataProp_'&i)&" LIKE ""%"&trim(form.sSearch)&"%"" OR ">
			</cfif>
		</cfloop>
		<cfset sWhere=Left(sWhere,Len(sWhere)-4)>
		<cfset sWhere=sWhere&")">    
	</cfif>
    
    
    <cfquery name="getGsetup" datasource="#dts#">
        SELECT updatetopo
        FROm gsetup;
    </cfquery>
	
	<cfquery name="getFilteredDataSet" datasource="#dts#">
    
    	<cfif t2 EQ "PO" AND t1 EQ "SO">
            SELECT COUNT(refno) as noOfBill, lower(custno) as custno,lower(name) as name, userid,refno,source,lower(rem5) as rem5,permitno 
            FROM artran 
            WHERE type = '#t1#'
            AND exported = '' AND (void = '' OR void IS NULL) 
            <cfif getgeneral.updatetopo NEQ 'Y'>
                AND order_cl = ""
            </cfif>
	
		<cfelseif t2 EQ "RC" AND t1 EQ "SO">
	
            SELECT COUNT(refno) as noOfBill, lower(custno) as custno, lower(name) as name, userid,refno,source,lower(rem5) as rem5,permitno 
            FROM artran 
            WHERE type = '#t1#'
            AND exported = '' 
            AND (void = '' OR void IS NULL) 
            <cfif getgeneral.updatetopo NEQ 'Y'>
            	AND order_cl = ""
            </cfif>
        
        <cfelseif t2 EQ "RC" AND t1 EQ "PO">
        
            SELECT COUNT(a.refno) as noOfBill, lower(custno) as custno,lower(b.rem5) as rem5,lower(name) as name,b.permitno as permitno,userid,a.refno,source 
            FROM ictran AS a 
            LEFT JOIN (	SELECT rem5,permitno,printstatus,refno,type 
                        FROM artran 
                        WHERE type='#t1#'
                      ) as b on a.refno=b.refno AND a.type=b.type 
            WHERE a.type = '#t1#'
            AND a.toinv = '' AND (a.void = '' OR a.void IS NULL) 
        
        <cfelseif t1 EQ "DO">
        
            SELECT COUNT(refno) as noOfBill, lower(custno) as custno, lower(name) as name, userid,refno,source,lower(rem5) as rem5,permitno 
            FROM artran 
            WHERE type = '#t1#'
            AND toinv = '' 
            AND (void = '' OR void IS NULL)
        
        <cfelseif t2 EQ "INV" AND t1 EQ "PO">
        
            SELECT COUNT(refno) as noOfBill, lower(custno) as custno, lower(name) as name, userid,refno,source,lower(rem5) as rem5,permitno 
            FROM artran 
            WHERE type = '#t1#'
            AND exported = '' 
            AND order_cl = '' 
            AND (void = '' OR void IS NULL)
        
        <cfelseif (t2 EQ "INV" OR t2 EQ "DO" OR t2 EQ "SO" OR t2 EQ "CS") AND t1 EQ "QUO">
            SELECT COUNT(refno) as noOfBill,lower(rem5) as rem5, lower(custno) as custno, lower(name) as name, userid,refno,source,permitno 
            FROM artran 
            WHERE type = '#t1#'
            AND toinv = ''  
            AND (void = '' OR void IS NULL) 
            AND order_cl='' 
        
        <cfelseif t2 EQ "PO" AND t1 EQ "QUO">
            SELECT COUNT(refno) as noOfBill, lower(custno) as custno,lower(rem5) as rem5, lower(name) as name, userid,refno,source,permitno 
            FROM artran WHERE type = '#t1#'
            <cfif getgeneral.updatetopo NEQ 'Y'>
            	AND order_cl = ""
            </cfif> 
            AND exported = '' 
            AND (void = '' OR void IS NULL) 
            
        <cfelse>
            SELECT COUNT(refno) as noOfBill, lower(custno) as custno,lower(rem5) as rem5, lower(name) as name, userid,refno,source,permitno 
            FROM artran 
            WHERE type = '#t1#'
            AND order_cl = '' 
            AND (void = '' OR void IS NULL) 
        </cfif>
	</cfquery>

	<cfquery name="getFilteredDataSetLength" datasource="#dts#">
		SELECT FOUND_ROWS() AS iFilteredTotal
	</cfquery>
	<cfquery name="getTotalDataSetLength" datasource="#dts#">
		SELECT COUNT(refno) AS iTotal
		FROM #targetTable#;
	</cfquery>

	<cfset aaData=ArrayNew(1)>
    <cfloop query="getFilteredDataSet">	
        <cfset data=StructNew()>
        <cfset data["noOfBill"]=" "&noOfBill>
        <cfset data["custno"]=custno>
        <cfset data["userid"]=userid>          
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