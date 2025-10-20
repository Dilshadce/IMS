<cfcomponent>
	<cffunction name="getmonthitem">
		<cfargument name="dts" required="yes">
		<cfargument name="lastaccyear" required="yes">
		<cfargument name="agentfrom" required="yes">
		<cfargument name="agentto" required="yes">
		<cfargument name="include" required="yes">
		<cfargument name="include0" required="yes">
		
				<cfset msg1 = "sum(amt)">
		
		<cfswitch expression="#arguments.include#">
			<cfcase value="yes">
				<cfset msg3 = 'and (type="INV" or type="CS" or type="DN")'>
				<cfset msg4 = 'and type="CN"'>
			</cfcase>
			<cfdefaultcase>
				<cfset msg3 = 'and (type="INV" or type="CS")'>
				<cfset msg4 = 'and type=""'>
			</cfdefaultcase>
		</cfswitch>		
		
		<cfif arguments.agentfrom neq "" and arguments.agentto neq "">
			<cfset critirial1 = 'and agenno between "#arguments.agentfrom#" and "#arguments.agentto#"'>
		<cfelse>
			<cfset critirial1 = "">
		</cfif>
		
		<!--- REMARK ON 190908 --->
		<!--- <cfif arguments.itemfrom neq "" and arguments.itemto neq "">
			<cfset critirial5 = 'and itemno between "#arguments.itemfrom#" and "#arguments.itemto#"'>
		<cfelse>
			<cfset critirial5 = "">
		</cfif> --->
		
		<cfquery name="getitem" datasource="#arguments.dts#">
			select a.desp, a.servi, ifnull(b.sump1,0) as sump1,ifnull(c.sump2,0) as sump2,ifnull(d.sump3,0) as sump3,ifnull(e.sump4,0) as sump4,ifnull(f.sump5,0) as sump5,ifnull(g.sump6,0) as sump6,
			(ifnull(b.sump1,0)+ifnull(c.sump2,0)+ifnull(d.sump3,0)+ifnull(e.sump4,0)+ifnull(f.sump5,0)+ifnull(g.sump6,0)) as total 
			from icservi as a 
			<!--- Period 13 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='13' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1#  
			 group by itemno),0)
             <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='13' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1#  

			group by itemno),0)
            </cfif>
            ) as sump1 from icservi as a 
			) as b on a.servi=b.servi
			<!--- Period 14 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='14' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1#  

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='14' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1# 

			group by itemno),0)
            </cfif>
            ) as sump2 from icservi as a 
			) as c on a.servi=c.servi
			<!--- Period 15 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='15' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1#   

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='15' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1#  

			group by itemno),0)
            </cfif>
            ) as sump3 from icservi as a
			) as d on a.servi=d.servi
			<!--- Period 16 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='16' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1#  

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='16' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1# 

			group by itemno),0)
            </cfif>
            ) as sump4 from icservi as a
			) as e on a.servi=e.servi
			<!--- Period 17 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='17' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1# 

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='17' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1# 

			group by itemno),0)
            </cfif>
            ) as sump5 from icservi as a
			) as f on a.servi=f.servi
			<!--- Period 18 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='18' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1# 

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='18' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1# 

			group by itemno),0)
            </cfif>
            ) as sump6 from icservi as a
			) as g on a.servi=g.servi
			
			where
			<cfswitch expression="#arguments.include0#">
				<cfcase value="yes">a.servi=a.servi</cfcase>
				<cfdefaultcase>(ifnull(b.sump1,0)+ifnull(c.sump2,0)+ifnull(d.sump3,0)+ifnull(e.sump4,0)+ifnull(f.sump5,0)+ifnull(g.sump6,0)) >0</cfdefaultcase>
			</cfswitch>
			
			group by a.desp order by a.desp
		</cfquery>
		<cfreturn getitem>
	</cffunction>
</cfcomponent>	