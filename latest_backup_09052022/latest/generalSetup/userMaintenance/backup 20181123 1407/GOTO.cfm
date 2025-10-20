<cfif IsDefined('url.comid')>
	<cfset URLcompanyID = lcase(trim(urldecode(url.comid)))>
</cfif>
    
<cfquery name="getMasterUser" datasource="main">
    SELECT userID
    FROM masterUser
</cfquery>

<cfloop query="getMasterUser">
    <cfset masterUserList = ValueList(getMasterUser.userID,",")>
</cfloop>

<cfif ListFind(masterUserList,HuserID)>
	<!---ultra user --->
    <cfif IsDefined('url.comid')>
    <cfoutput>
        <!---<cfquery name="checkLinkAMS" datasource="main">
            SELECT linktoams 
            FROM users 
            WHERE userbranch = <cfqueryparam cfsqltype="cf_sql_char" value="#URLcompanyID#">
        </cfquery>
        <cfif checkLinkAMS.recordcount NEQ 0>--->
            <cfquery name="updateUser" datasource="main">
                Update users 
                SET 
                	userbranch = <cfqueryparam cfsqltype="cf_sql_char" value="#URLcompanyID#">, 
                    userdept = <cfqueryparam cfsqltype="cf_sql_char" value="#URLcompanyID#"><!---,
                    linktoams = "#checkLinkAMS.linktoams#"--->
                WHERE USERID = <cfqueryparam cfsqltype="cf_sql_char" value="#trim(huserid)#">;
            </cfquery>
            <script type="text/javascript">
                top.location.href=top.location.href;
            </script>
        <!---</cfif>--->
    </cfoutput>
    </cfif><!---
<cfelse>
	-Not ultra user -
    <cfif IsDefined('url.comid')>
        <cfquery datasource='main' name="getmulticompany">
            select * 
            from multicomusers 
            where userid='#huserid#' 
        </cfquery>
        
        <cfset multicomlist=valuelist(getmulticompany.comlist)>
        <cfif ListFindNoCase(multicomlist,'#URLcompanyID#') GT 0>
            <cfoutput>
            <cfquery name="checkLinkAMS" datasource="main">
                SELECT linktoams from users where userbranch=<cfqueryparam cfsqltype="cf_sql_char" value="#URLcompanyID#">
            </cfquery>
                <cfif checkLinkAMS.recordcount neq 0>
                    <cfquery name="updateUser" datasource="main">
                        Update users SET 
                        userbranch = <cfqueryparam cfsqltype="cf_sql_char" value="#URLcompanyID#">, 
                        userdept = <cfqueryparam cfsqltype="cf_sql_char" value="#URLcompanyID#">,
                        linktoams = "#checkLinkAMS.linktoams#"
                        WHERE
                        USERID = <cfqueryparam cfsqltype="cf_sql_char" value="#huserid#">
                    </cfquery>
                <script type="text/javascript">
                    top.location.href='/index.cfm';
                </script>
                </cfif>
            </cfoutput>
        </cfif>
    <cfelse>
    	<cfabort/>
    </cfif>--->
<!--- --->
</cfif>

