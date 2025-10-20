<cfsetting showdebugoutput="true">
<cfquery datasource="#dts#">
    SET SESSION binlog_format = 'MIXED';
</cfquery>
    
<cfoutput>
    <cfset updatelist = "">
    <cfset checkboxlist = "entitle,payable1,billable1,earndays">
    <cfset mandatorylist = "days,date,remarks">
    <cfset leaveupdate = "">
    <cfset picupdate = "">
        
    <cfloop list="#form.fieldnames#" index="a">
        <cfif #a# CONTAINS "update">
            <cfquery name="updateleave" datasource="#dts#" result="leave_result">
                UPDATE placement
                SET placementno = placementno
            
                    <cfloop list="#mandatorylist#" index="b">
                            
                        <cfif "#Evaluate('form.#Evaluate('form.#a#')##b#')#" NEQ ''>
                            , #Evaluate('form.#a#')##b# = "#Evaluate('form.#Evaluate('form.#a#')##b#')#"
                        <cfelse>
                            <cfcontinue>
                        </cfif>
                            
                    </cfloop>
                    
                    <cfloop list="#checkboxlist#" index="c">
                        <cfif IsDefined('#Evaluate('form.#a#')##c#') AND #Evaluate('form.#Evaluate('form.#a#')##c#')# EQ 'ON'>
                            , #Evaluate('form.#a#')##c# = "Y"
                        <cfelse>
                            , #Evaluate('form.#a#')##c# = "N"
                        </cfif>
                    </cfloop>
                        
                    <cfif #Evaluate('form.#a#')# EQ 'AL'>
                        
                        <cfif "#form.albfdays#" NEQ "">
                        , ALbfdays = "#form.albfdays#"
                        </cfif>
                        
                        , altype = "#form.altype#"
                        
                        <cfif #IsDefined('form.albfable')# AND #form.albfable# EQ 'ON'>
                            , albfable = "Y"
                        <cfelse>
                            , albfable = "N"
                        </cfif>
                        
                            , Altotaldays = albfdays + aldays
                    <cfelse>
                        
                        , #Evaluate('form.#a#')#totaldays = #Evaluate('form.#a#')#days
                        
                    </cfif>
                            
                WHERE placementno IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" separator="," value="#form.placementlist#">)
            </cfquery>
                        
            <cfset leaveupdate = #ListAppend(leaveupdate, "#Evaluate('form.#a#')#:#leave_result.recordcount#", ' ')#>
                
        <cfelseif #a# CONTAINS "change" AND (#Evaluate('form.#a#')# NEQ "" AND #Evaluate('form.#Evaluate('form.#a#')#Email')# NEQ "")>
            <cfquery name="updatepic" datasource="#dts#" result="pic_result">
                UPDATE placement 
                SET placementno = placementno
                , #Evaluate('form.#a#')# = "#Evaluate('#Evaluate('form.#a#')#')#"
                <cfif #Evaluate('form.#a#')# EQ "MPPIC2">
                    , mppicemail2 = "#Evaluate('form.#Evaluate('form.#a#')#Email')#"
                <cfelse>
                    , #Evaluate('form.#a#')#Email = "#Evaluate('form.#Evaluate('form.#a#')#Email')#"
                </cfif>
                WHERE placementno IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="true" separator="," value="#form.placementlist#">)
            </cfquery>
                
            <cfset picupdate = #ListAppend(picupdate, "#Evaluate('form.#a#')#:#pic_result.recordcount#", ' ')#>
                
        </cfif>
    </cfloop>
    
    <script>
        alert('#leaveupdate#\n#picupdate#');
        window.location.href='massupdate.cfm';
    </script>
</cfoutput>