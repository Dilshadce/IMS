<cfoutput>
        <cftry>
            <cfquery name="updatePassword" datasource="main">
                UPDATE users
                SET
                    lang = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.lang#">
                WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getauthuser()#">
            </cfquery>
        <cfcatch type="any">

        </cfcatch>
        </cftry>
		<script type="text/javascript">
				alert('Updated Language successfully!');
            	window.open('/latest/body/bodymenu.cfm?id=60200','_self');
				top.frames['leftFrame'].location.href = '/latest/side/sidemenu.cfm'; 
				top.frames['topFrame'].location.href = '/latest/header/header.cfm';
        </script>	
</cfoutput>