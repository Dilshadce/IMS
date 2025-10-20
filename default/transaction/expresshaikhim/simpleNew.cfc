<cfcomponent>
	<!---CUSTOMER/SUPPLIER SEARCH start--->
    <cffunction name="listMatchedTargets" access="remote" returntype="struct">
        <cfset dts=form.dts>
        <cfset target=form.target>
        <cfset targetTable=form.targetTable>
        <cfset term=form.term>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset start=page*limit>    
        <cfset matchedTargetsList=ArrayNew(1)>
        
        <cfquery name="listMatchedTargets" datasource="#replace(LCASE(dts),'_i','_a','ALL')#">
            SELECT custno,CONCAT(name," ",name2) AS name 
            FROM #targetTable#
            WHERE custno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            OR CONCAT(name," ",name2) LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            ORDER BY custno
            LIMIT #start#,#limit#
        </cfquery>
        <cfquery name="getMatchedAccountLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS matchedAccountLength
        </cfquery>  
        <cfset createNewTarget=StructNew()>
        <cfset createNewTarget["id"]="createNewTarget">
        <cfset createNewTarget["text"]="[New "&target&"]">
        <cfset ArrayAppend(matchedTargetsList,createNewTarget)>      
        <cfloop query="listMatchedTargets">
            <cfset matchedTarget=StructNew()>
            <cfset matchedTarget["id"]=listMatchedTargets.custno>
            <cfset matchedTarget["text"]=listMatchedTargets.custno&" - "&listMatchedTargets.name>
            <cfset ArrayAppend(matchedTargetsList,matchedTarget)>
        </cfloop>
    
        <cfset outputMatchedTargetsList=StructNew()>
        <cfset outputMatchedTargetsList["total"]=getMatchedAccountLength.matchedAccountLength>
        <cfset outputMatchedTargetsList["result"]=matchedTargetsList>    
        <cfreturn outputMatchedTargetsList>
    </cffunction>
    <cffunction name="getSelectedTarget" access="remote" returntype="struct">
        <cfset dts=form.dts>
        <cfset custno=form.custno>
        <cfset targetTable=form.targetTable>
        <cfquery name="getSelectedTarget" datasource="#replace(LCASE(dts),'_i','_a','ALL')#">
            SELECT custno,CONCAT(name," ",name2) AS name 
            FROM #targetTable#
            WHERE custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#custno#" />
        </cfquery>
        <cfset selectedTarget=StructNew()>
        <cfset selectedTarget["id"]=getSelectedTarget.custno>
        <cfset selectedTarget["text"]=getSelectedTarget.name>
        <cfreturn selectedTarget>
    </cffunction>
    <!---CUSTOMER/SUPPLIER SEARCH end--->
    
    <!---ITEM SEARCH start--->
    <cffunction name="listitem" access="remote" returntype="struct">
	<cfset dts=form.dts>
	<cfset term=form.term>
	<cfset limit=form.limit>
	<cfset page=form.page>
	<cfset start=page*limit>
	<cfset matcheditemList=ArrayNew(1)>
	<cfquery name="listMatcheditem" datasource="#dts#">
    			Select servi as itemno , Servi as desp from icservi
                     WHERE 
                    Servi like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
                    or desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
                    union all
        			select itemno, desp from icitem
                    WHERE 
                    itemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
                   or desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
                    order by itemno limit #start#,#limit#
	</cfquery>

	<cfloop query="listMatcheditem">
		<cfset matcheditem=StructNew()>
        <cfset matcheditem["id"]=listMatcheditem.itemno>
		<cfset matcheditem["itemno"]=listMatcheditem.itemno>
		<cfset matcheditem["desp"]=listMatcheditem.desp>
		<cfset ArrayAppend(matcheditemList,matcheditem)>
	</cfloop>
	<cfset output=StructNew()>
	<cfset output["total"]=listMatcheditem.recordcount>
	<cfset output["result"]=matcheditemList>
	<cfreturn output>
</cffunction>

<cffunction name="getSelecteditem" access="remote" returntype="struct">
	<cfset dts=form.dts>
	<cfset value=form.value>
	<cfquery name="getSelecteditem" datasource="#dts#">
		SELECT itemno, desp from icitem
		WHERE itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />
	</cfquery>
    
    <cfif getSelecteditem.recordcount eq 0>
    <cfquery name="getSelecteditem" datasource="#dts#">
		SELECT servi as itemno , Servi as desp from icservi
		WHERE servi=<cfqueryparam cfsqltype="cf_sql_varchar" value="#value#" />
	</cfquery>
	</cfif>
    
	<cfset selecteditem=StructNew()>
    <cfset selecteditem["id"]=getSelecteditem.itemno>
	<cfset selecteditem["itemno"]=getSelecteditem.itemno>
	<cfset selecteditem["desp"]=getSelecteditem.desp>
	<cfreturn selecteditem>
</cffunction>
    <!---ITEM SEARCH end--->
</cfcomponent>