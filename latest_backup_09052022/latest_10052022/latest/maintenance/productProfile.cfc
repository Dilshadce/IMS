<cfcomponent>
<cffunction name="listAccount" access="remote" returntype="struct">
	<!---<cfset dts=form.dts>--->
    <cfquery name="getdts" datasource="main">
     SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
    </cfquery>
    <cfset dts = trim(getdts.dts)>
    <cfset hitemgroup=form.hitemgroup>
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

	<!---<cfset sWhere="">
	<cfif IsDefined("form.sSearch") AND form.sSearch NEQ "">
		<cfset sWhere=" WHERE (">
		<cfloop from="0" to="#form.iColumns-1#" index="i" step="1">	
			<cfif Evaluate('form.bSearchable_'&i) EQ "true">
				<cfset sWhere=sWhere&Evaluate('form.mDataProp_'&i)&" LIKE ""%"&trim(form.sSearch)&"%"" OR ">
			</cfif>
		</cfloop>
		<cfset sWhere=Left(sWhere,Len(sWhere)-4)>
		<cfset sWhere=sWhere&")">    
	</cfif>--->
	
	<cfquery name="getFilteredDataSet" datasource="#dts#">
		SELECT SQL_CALC_FOUND_ROWS itemno,aitemno,desp,comment,brand,shelf,category,wos_group,colorid,costcode,sizeid,ucost,price,unit,qtybf,price2,supp,nonstkitem,packing,fcurrcode,fprice,fucost,despa
		FROM #targetTable# WHERE 1=1
		<cfif IsDefined("form.sSearch") AND form.sSearch NEQ "">
            AND (
                <cfloop from="0" to="#form.iColumns-1#" index="i" step="1"> 
                <cfif Evaluate('form.mDataProp_#i#') neq "onhand">
                    <cfif Evaluate('form.bSearchable_'&i) EQ "true">
                        `#Evaluate('form.mDataProp_#i#')#` LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#trim(form.sSearch)#%">
                    </cfif>
                    <cfif i neq form.iColumns-1>
                        OR 
                    </cfif>  
                    <cfif i eq form.iColumns-1>
                        )
                    </cfif>  
                </cfif>
                </cfloop>
        </cfif>
        <cfif hitemgroup neq ''>
                    AND wos_group='#hitemgroup#'
        </cfif>
		#sOrder#
		#sLimit#
	</cfquery>

	<cfquery name="getFilteredDataSetLength" datasource="#dts#">
		SELECT FOUND_ROWS() AS iFilteredTotal
	</cfquery>
	<cfquery name="getTotalDataSetLength" datasource="#dts#">
		SELECT COUNT(itemno) AS iTotal
		FROM #targetTable#
	</cfquery>
    <cfif getTotalDataSetLength.iTotal lt 10000>
    <cfquery name="getdoupdated" datasource="#dts#">
    SELECT frrefno FROM iclink WHERE frtype = "DO" 
    group by frrefno
    </cfquery>
    <cfset billupdated=valuelist(getdoupdated.frrefno)>
	</cfif>
		<cfset aaData=ArrayNew(1)>
		<cfloop query="getFilteredDataSet">	
        <cfif getTotalDataSetLength.iTotal lt 10000>
		<cfquery name="getitembalance" datasource="#dts#">
            select 
            ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
            
            from icitem as a
            
            left join 
            (
                select itemno,sum(qty) as sumtotalin 
                from ictran 
                where type in ('RC','CN','OAI','TRIN') 
                and itemno='#getFilteredDataSet.itemno#' 
                and fperiod<>'99'
                and (void = '' or void is null)
                and (linecode='' or linecode is null)
                group by itemno
            ) as b on a.itemno=b.itemno
            
            left join 
            (
                select itemno,sum(qty) as sumtotalout 
                from ictran 
                where
                (type in ('DO','DN','CS','OAR','PR','ISS','TROU') or 
                        (type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
                and itemno='#getFilteredDataSet.itemno#' 
                and fperiod<>'99'
                and (void = '' or void is null)
                and (linecode='' or linecode is null)
                group by itemno
            ) as c on a.itemno=c.itemno
            
            
            where a.itemno='#getFilteredDataSet.itemno#' 
        </cfquery>        
        </cfif>
			<cfset data=StructNew()>
			<cfset data["itemno"]=" "&itemno>
            <cfset data["aitemno"]=" "&aitemno>
            <cfset data["desp"]=desp&" "&despa>
            <cfset data["comment"]=comment>
            <cfset data["brand"]=brand>
            <cfset data["shelf"]=shelf>
            <cfset data["category"]=category>
            <cfset data["wos_group"]=wos_group>
            <cfset data["colorid"]=colorid>
			<cfset data["costcode"]=costcode> 
            <cfset data["sizeid"]=sizeid>   
            <cfset data["ucost"]=ucost>
            <cfset data["price"]=price>
            <cfset data["unit"]=unit>  
            <cfset data["qtybf"]=qtybf>  
            <cfset data["price2"]=price2>  
            <cfset data["supp"]=supp>  
            <cfset data["nonstkitem"]=nonstkitem>  
            <cfset data["packing"]=packing>  
            <cfset data["fcurrcode"]=fcurrcode>  
            <cfset data["fprice"]=fprice>  
            <cfset data["fucost"]=fucost>  
            <cfif getTotalDataSetLength.iTotal lt 10000>
            <cfset data["onhand"]=getitembalance.balance> 
            <cfelse>
            <cfset data["onhand"]=" "> 
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