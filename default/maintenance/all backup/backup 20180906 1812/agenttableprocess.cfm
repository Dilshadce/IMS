<cfparam name="status" default="">
<!--- ADD ON 15-07-2009 --->
<cfquery name="getGsetup" datasource="#dts#">
  Select lAGENT from GSetup
</cfquery>
<cfif form.mode eq "Create">
	<cfquery name="checkagentExist" datasource="#dts#">
 		SELECT agent 
		FROM #target_icagent# 
        WHERE agent='#form.agent#';
	</cfquery>
	
	<cfif checkagentExist.recordcount gt 0>
		<h3>
			<cfoutput><font color="FF0000">Error, This #getGsetup.lAGENT# has been created already.</font></cfoutput>
		</h3>
		<cfabort>
	</cfif>

	
    
    <cfquery name="insert" datasource="#dts#">
        INSERT INTO #target_icagent#(agent,desp,commsion1,hp,agentID,agentlist,team,email,designation)
        VALUES
        	(<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.agent)#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.commsion1)#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hp#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agentID#">,
            <cfif isdefined('form.agentlist')> <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agentlist#"><cfelse>""</cfif>,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.team#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.designation#">)
    </cfquery>
	
    <cfquery name="insertpicture" datasource="#dts#">
    UPDATE #target_icagent# set photo=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.picture_available#">  <cfif left(dts,4) eq "beps">
					,location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.location#">
                    </cfif> where agent='#form.agent#'
    </cfquery>
    
    <cfif isdefined('form.discontinueagent')>
        <cfquery name="insertdiscountinueagent" datasource="#dts#">
       		UPDATE #target_icagent# SET discontinueagent='Y' where agent='#form.agent#'
        </cfquery>
	<cfelse>
        <cfquery name="insertdiscountinueagent" datasource="#dts#">
        	UPDATE #target_icagent# SET discontinueagent='' where agent='#form.agent#'
        </cfquery>
    </cfif>
    
    
	<cfset status="The #getGsetup.lAGENT#, #form.agent# had been successfully created.">
<cfelse>
	<cfquery datasource="#dts#" name="checkitemExist">
		select 
		agent 
		FROM #target_icagent# 
		where agent='#form.agent#';
	</cfquery>
	
	<cfif checkitemExist.recordcount gt 0>
		<cfif form.mode eq "Delete">
			<cfquery name="checktranexist" datasource="#dts#">
				select 
				agenno 
				from artran 
				where agenno='#form.agent#';
			</cfquery>
			
			<cfif checktranexist.recordcount gt 0>
				<h3>You have created transaction for this agent. You are not allowed to delete this agent.</h3>					
				<cfabort>
			</cfif>
			
			<cfquery datasource="#dts#" name="deleteitem">
				delete FROM #target_icagent# 
				where agent='#form.agent#';
			</cfquery>
			
			<cfset status="The #getGsetup.lAGENT#, #form.agent# had been successfully deleted.">
		</cfif>
		
		<cfif form.mode eq "Edit">
			<cfif lcase(HcomID) eq "avt_i" or lcase(HcomID) eq "net_i" or lcase(HcomID) eq "netm_i" or lcase(HcomID) eq "ideal_i" or lcase(HcomID) eq "idealb_i">
				<cfquery name="update" datasource="#dts#">
					UPDATE #target_icagent#
					Set desp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,
					commsion1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.commsion1#">,
					hp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hp#">,
                    email=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#">,
                    team=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.team#">,
                    agentlist =<cfif isdefined('form.agentlist')> <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agentlist#">
                    <cfelse>
                    ""
                    </cfif>,
                    photo=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.picture_available#">
                    <cfif isdefined('form.discontinueagent')>
                    ,discontinueagent='Y'
                    <cfelse>
        			,discontinueagent=''
                    </cfif>
                   
					Where agent=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agent#">
				</cfquery>
			<cfelse>
				<cfquery name="update" datasource="#dts#">
					UPDATE #target_icagent#
					Set desp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,
					commsion1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.commsion1#">,
					hp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hp#">,
                    email=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.email#">,
                    team=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.team#">,
                    agentID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agentID#">,
                    photo=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.picture_available#">
                    ,
                    agentlist =<cfif isdefined('form.agentlist')> <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agentlist#">
                    <cfelse>
                    ""
                    </cfif>
                    ,designation=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.designation#">
                    <cfif isdefined('form.discontinueagent')>
                    ,discontinueagent='Y'
                    <cfelse>
        			,discontinueagent=''
                    </cfif>
                      <cfif left(dts,4) eq "beps">
					,location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.location#">
                    </cfif>
					Where agent=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agent#">
				</cfquery>
			</cfif>
			<cfset status="The #getGsetup.lAGENT#, #form.agent# had been successfully edited.">
		</cfif>
	<cfelse>
		<cfset status="Sorry, the #getGsetup.lAGENT#, #form.agent# was ALREADY removed from the system. Process unsuccessful.">
	</cfif>
</cfif>


<form name="done" action="s_agenttable.cfm?type=icagent&process=done" method="post">
	<input name="status" value="<cfoutput>#status#</cfoutput>" type="hidden">
</form>

<script>
	done.submit();
</script>