<cfcomponent>
	<cfsetting showdebugoutput="no">
	<!---CUSTOMER/SUPPLIER SEARCH start--->
    <cffunction name="listMatchedTargets" access="remote" returntype="struct">
        <!--- <cfset dts=form.dts> --->
        <cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>
        <cfset dts = trim(getdts.dts)>
        <cfset HlinkAMS=form.HlinkAMS>
        <cfset target=form.target>
        <cfset targetTable=form.targetTable>
        <cfset term=form.term>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset viewownagent=form.viewownagent>
        <cfset huserid=form.huserid>
        <cfset target_icagent=form.target_icagent>
        <cfset Hitemgroup=form.Hitemgroup>
        <cfset start=page*limit>    
        <cfset matchedTargetsList=ArrayNew(1)>
        
        <cfif HlinkAMS EQ 'Y'>
        	<cfset dts2 = #replace(LCASE(dts),'_i','_a','ALL')#>
        <cfelse>
        	<cfset dts2 = dts>
        </cfif>
        
        <cfquery name="listMatchedTargets" datasource="#dts2#">
            SELECT custno,CONCAT(name," ",name2) AS name 
            FROM #targetTable#
            WHERE (custno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            OR CONCAT(name," ",name2) LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />)
            
            <cfif viewownagent eq 'T'>
            		<cfif LCASE(dts) eq "showcase_i">
                    and name=<cfqueryparam cfsqltype="cf_sql_varchar" value="#Hitemgroup#" />
                    <cfelse>
           			and (ucase(created_by)='#ucase(huserid)#' or ucase(agent)='#ucase(huserid)#' or (ucase(agent) in (SELECT agent FROM #target_icagent# WHERE ucase(agentid) like "%#ucase(huserid)#%")))
					</cfif>
            </cfif>
            
            ORDER BY custno
            LIMIT #start#,#limit#
        </cfquery>
        <cfquery name="getMatchedAccountLength" datasource="#dts2#">
            SELECT FOUND_ROWS() AS matchedAccountLength
        </cfquery>  
        <cfset createNewTarget=StructNew()>
        <!---<cfset createNewTarget["id"]="createNewTarget">
        <cfset createNewTarget["text"]="[New "&target&"]">
        <cfset ArrayAppend(matchedTargetsList,createNewTarget)>  --->    
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
        <!--- <cfset dts=form.dts> --->
        <cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>
        <cfset dts = trim(getdts.dts)>
        <cfset HlinkAMS=form.HlinkAMS>
        <cfset custno=form.custno>
        <cfset targetTable=form.targetTable>
        <cfset viewownagent=form.viewownagent>
        
        <cfif HlinkAMS EQ 'Y'>
        	<cfset dts2 = #replace(LCASE(dts),'_i','_a','ALL')#>
        <cfelse>
        	<cfset dts2 = dts>
        </cfif>
        
        <cfquery name="getSelectedTarget" datasource="#dts2#">
            SELECT custno,CONCAT(name," ",name2) AS name 
            FROM #targetTable#
            WHERE custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(custno)#" />
            
        </cfquery>
        <cfset selectedTarget=StructNew()>
        <cfset selectedTarget["id"]=getSelectedTarget.custno>
        <cfset selectedTarget["text"]=getSelectedTarget.name>
        <cfreturn selectedTarget>
    </cffunction>
    <!---CUSTOMER/SUPPLIER SEARCH end--->
    
    <!---ITEM SEARCH start--->
    <cffunction name="listMatchedItems" access="remote" returntype="struct">
        <!--- <cfset dts=form.dts> --->
        <cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>
        <cfset dts = trim(getdts.dts)>
        <cfset Hitemgroup=form.Hitemgroup>
        <cfset term=form.term>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset start=page*limit> 
        <cfset matchedItemsList=ArrayNew(1)>
        <cfquery name="listMatchedItems" datasource="#dts#">
            SELECT * FROM (
                SELECT itemno,CONCAT(desp," ",despa) AS desp
                FROM icitem
                WHERE ((nonstkitem<>'T' OR nonstkitem IS null)
                AND itemno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />	
                OR CONCAT(desp," ",despa) LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
                OR barcode LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
                )
                <cfif Hitemgroup neq ''>
                AND wos_group='#Hitemgroup#'
                </cfif>
                UNION ALL
                    SELECT servi ,CONCAT(desp," ",despa) AS desp
                    FROM icservi
                    WHERE servi LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />	
                    OR CONCAT(desp," ",despa) LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />    
            ) AS aa
            <!---ORDER BY itemno--->
            LIMIT #start#,#limit#
        </cfquery>
        <cfquery name="getMatchedItemsLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS matchedItemsLength
        </cfquery>     
        <cfset createNewItem=StructNew()>
        <cfset createNewItem["id"]="createNewItem">
        <cfset createNewItem["text"]="[New Item]"> 
        <!---<cfset ArrayAppend(matchedItemsList,createNewItem)>--->       
        <cfloop query="listMatchedItems">
            <cfset matchedItem=StructNew()>
            <cfset matchedItem["id"]=listMatchedItems.itemno>
            <cfset matchedItem["text"]=listMatchedItems.itemno &" - "& listMatchedItems.desp>
            <cfset ArrayAppend(matchedItemsList,matchedItem)>
        </cfloop>
    
        <cfset outputmatchedItemsList=StructNew()>
        <cfset outputmatchedItemsList["total"]=getMatchedItemsLength.matchedItemsLength>
        <cfset outputmatchedItemsList["result"]=matchedItemsList> 
        <cfreturn outputmatchedItemsList>
    </cffunction>
    <cffunction name="getSelectedItem" access="remote" returntype="struct">
        <!--- <cfset dts=form.dts> --->
        <cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>
        <cfset dts = trim(getdts.dts)>
        <cfset Hitemgroup=form.Hitemgroup>
        <cfset itemno=form.itemno>
        <cfquery name="getSelectedItem" datasource="#dts#">
            SELECT itemno
            FROM icitem
            WHERE itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(itemno)#" />
            <cfif Hitemgroup neq ''>
                AND wos_group='#Hitemgroup#'
            </cfif>
            UNION ALL
                SELECT servi
                FROM icservi
                WHERE servi=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(itemno)#" />
        </cfquery>
        <cfset selectedItem=StructNew()>
        <cfset selectedItem["id"]=getSelectedItem.itemno>
        <cfset selectedItem["text"]=getSelectedItem.itemno>
        <cfreturn selectedItem>
    </cffunction>
    <!---ITEM SEARCH end--->
    
	<!---TAX INVOICE NO start--->
    <cffunction name="listMatchedINV" access="remote" returntype="struct">
        <!--- <cfset dts=form.dts> --->
        <cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>
        <cfset dts = trim(getdts.dts)>
        <cfset term=form.term>
        <cfset limit=form.limit>
        <cfset page=form.page>
        <cfset start=page*limit> 
        <cfset matchedINVList=ArrayNew(1)>
        
        <cfquery name="listMatchedINV" datasource="#dts#">
            SELECT refno,CONCAT(frem0," ",frem1) AS customerName
            FROM artran
            WHERE type = 'INV'
            AND (refno LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />
            OR CONCAT(frem0," ",frem1) LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#term#%" />)
			ORDER BY refno 
            LIMIT #start#,#limit#;
        </cfquery>
        <cfquery name="getMatchedINVLength" datasource="#dts#">
            SELECT FOUND_ROWS() AS matchedINVLength
        </cfquery>         
        <cfloop query="listMatchedINV">
            <cfset matchedINV=StructNew()>
            <cfset matchedINV["id"]=listMatchedINV.refno>
            <cfset matchedINV["text"]=listMatchedINV.refno &" - "& listMatchedINV.customerName>
            <cfset ArrayAppend(matchedINVList,matchedINV)>
        </cfloop>
            
        <cfset outputmatchedINVList=StructNew()>
        <cfset outputmatchedINVList["total"]=getMatchedINVLength.matchedINVLength>
        <cfset outputmatchedINVList["result"]=matchedINVList> 
        <cfreturn outputmatchedINVList>
    </cffunction>
    <cffunction name="getSelectedINV" access="remote" returntype="struct">
        <!--- <cfset dts=form.dts> --->
        <cfquery name="getdts" datasource="main">
         SELECT userbranch AS dts FROM users WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#GetAuthUser()#">
        </cfquery>
        <cfset dts = trim(getdts.dts)>
        <cfset INVno=form.INVno>
        <cfquery name="getSelectedINV" datasource="#dts#">
            SELECT refno
            FROM artran
            WHERE type='INV' 
            AND refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(INVno)#" />   
        </cfquery>
        <cfset selectedINV=StructNew()>
        <cfset selectedINV["id"]=getSelectedINV.refno>
        <cfset selectedINV["text"]=getSelectedINV.refno>
        <cfreturn selectedINV>
    </cffunction>
    <!---TAX INVOICE NO SEARCH end--->
</cfcomponent>