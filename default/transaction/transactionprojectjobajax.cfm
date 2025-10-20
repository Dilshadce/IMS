<cfsetting showdebugoutput="no">
<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfquery name="getmodule" datasource="#dts#">
select * from modulecontrol
</cfquery>

<cfquery name="getProject" datasource="#dts#">
            	select source,(select project from #target_project# where porj = "P" and source=a.source)as project from artran as a where agenno="#url.agenno#" and (void='' or void is null) group by source
              order by source
            </cfquery>

<cfquery name="getagentidjob" datasource="#dts#">
	select agentid from #target_icagent# where agent="#url.agenno#"
</cfquery>

<cfquery name="getuserjob" datasource="main">
	select job from users where userid='#getagentidjob.agentid#'
</cfquery>

<cfquery name="getProject2" datasource="#dts#">
              select * from #target_project# where porj = "J" and  source='#getuserjob.job#' order by source
</cfquery>


<cfoutput>

<select name="Source" id="Source" <cfif lcase(HcomID) eq "ascend_i">onChange="document.getElementById('desp').value=document.getElementById('source').options[selectedIndex].title"</cfif>>
					<option value="">Choose a <!--- Project --->#getGsetup.lPROJECT#</option>
					<cfloop query="getProject">
						<option title="#getproject.project#" value="#getProject.source#"><cfif (lcase(hcomid) eq "weikeninv_i" or lcase(hcomid) eq "weikenint_i" or lcase(hcomid) eq "weikenid_i" or lcase(hcomid) eq "futurehome_i" or lcase(hcomid) eq "weikenbuilder_i" or lcase(hcomid) eq "weikendecor_i")>#getproject.project#<cfelse>#getProject.source#<cfif lcase(HcomID) eq "ascend_i" or lcase(HcomID) eq "atc2005_i">-#getproject.project#</cfif></cfif></option>
					</cfloop>
				</select>
                <a onMouseOver="JavaScript:this.style.cursor='hand';" ><img src="/images/find.jpg" width="20" height="14.5" onClick="javascript:ColdFusion.Window.show('findproject');" /></a>
                <cfif lcase(HcomID) eq "ascend_i" or getmodule.job neq "1" or getpin2.h1ZA0 neq "T"> <div style="visibility:hidden"></cfif>
               
				<select name="Job" id="Job">
                	<cfif getProject2.recordcount eq 0>
					<option value="">Choose a <!--- Job --->#getGsetup.lJOB#</option>
                    </cfif>
					<cfloop query="getProject2">
						<option value="#getProject2.source#" >#getProject2.source#</option>
					</cfloop>
                    
				</select><cfif lcase(HcomID) eq "ascend_i" or getmodule.job neq "1" or getpin2.h1ZA0 neq "T"> </div></cfif> </div>

</cfoutput>