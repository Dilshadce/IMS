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
			<cfset critirial5 = 'and desp between "#arguments.itemfrom#" and "#arguments.itemto#"'>
		<cfelse>
			<cfset critirial5 = "">
		</cfif> --->
		
		<cfquery name="getitem" datasource="#arguments.dts#">
			select a.desp,a.servi,ifnull(b.sump1,0) as sump1,ifnull(c.sump2,0) as sump2,ifnull(d.sump3,0) as sump3,ifnull(e.sump4,0) as sump4,ifnull(f.sump5,0) as sump5,ifnull(g.sump6,0) as sump6,
			ifnull(h.sump7,0) as sump7,ifnull(i.sump8,0) as sump8,ifnull(j.sump9,0) as sump9,ifnull(k.sump10,0) as sump10,ifnull(l.sump11,0) as sump11,ifnull(m.sump12,0) as sump12,
			ifnull(n.sump13,0) as sump13,ifnull(o.sump14,0) as sump14,ifnull(p.sump15,0) as sump15,ifnull(q.sump16,0) as sump16,ifnull(r.sump17,0) as sump17,ifnull(s.sump18,0) as sump18,
			(ifnull(b.sump1,0)+ifnull(c.sump2,0)+ifnull(d.sump3,0)+ifnull(e.sump4,0)+ifnull(f.sump5,0)+ifnull(g.sump6,0)+
			ifnull(h.sump7,0)+ifnull(i.sump8,0)+ifnull(j.sump9,0)+ifnull(k.sump10,0)+ifnull(l.sump11,0)+ifnull(m.sump12,0)+
			ifnull(n.sump13,0)+ifnull(o.sump14,0)+ifnull(p.sump15,0)+ifnull(q.sump16,0)+ifnull(r.sump17,0)+ifnull(s.sump18,0)) as total 
			from icservi as a 
			<!--- Period 01 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='01' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1#  
			 group by itemno),0)
             <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='01' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1#  

			group by itemno),0)
            </cfif>
            ) as sump1 from icservi as a 
			) as b on a.servi=b.servi
			<!--- Period 02 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='02' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1#  

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='02' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1# 

			group by itemno),0)
            </cfif>
            ) as sump2 from icservi as a 
			) as c on a.servi=c.servi
			<!--- Period 03 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='03' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1#   

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='03' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1#  

			group by itemno),0)
            </cfif>
            ) as sump3 from icservi as a
			) as d on a.servi=d.servi
			<!--- Period 04 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='04' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1#  

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='04' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1# 

			group by itemno),0)
            </cfif>
            ) as sump4 from icservi as a
			) as e on a.servi=e.servi
			<!--- Period 05 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='05' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1# 

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='05' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1# 

			group by itemno),0)
            </cfif>
            ) as sump5 from icservi as a
			) as f on a.servi=f.servi
			<!--- Period 06 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='06' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1# 

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='06' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1# 

			group by itemno),0)
            </cfif>
            ) as sump6 from icservi as a
			) as g on a.servi=g.servi
			<!--- Period 07 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='07' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1#  
			 group by itemno),0)
             <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='07' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1#  

			group by itemno),0)
            </cfif>
            ) as sump7 from icservi as a 
			) as h on a.servi=h.servi
			<!--- Period 08 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='08' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1#  

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='08' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1# 

			group by itemno),0)
            </cfif>
            ) as sump8 from icservi as a 
			) as i on a.servi=i.servi
			<!--- Period 09 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='09' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1#   

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='09' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1#  

			group by itemno),0)
            </cfif>
            ) as sump9 from icservi as a
			) as j on a.servi=j.servi
			<!--- Period 10 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='10' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1#  

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='10' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1# 

			group by itemno),0)
            </cfif>
            ) as sump10 from icservi as a
			) as k on a.servi=k.servi
			<!--- Period 11 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='11' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1# 

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='11' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1# 

			group by itemno),0)
            </cfif>
            ) as sump11 from icservi as a
			) as l on a.servi=l.servi
			<!--- Period 12 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='12' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1# 

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='12' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1# 

			group by itemno),0)
            </cfif>
            ) as sump12 from icservi as a
			) as m on a.servi=m.servi
			<!--- Period 13 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='13' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1#  
			 group by itemno),0)
             <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='13' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1#  

			group by itemno),0)
            </cfif>
            ) as sump13 from icservi as a 
			) as n on a.servi=n.servi
			<!--- Period 14 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='14' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1#  

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='14' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1# 

			group by itemno),0)
            </cfif>
            ) as sump14 from icservi as a 
			) as o on a.servi=o.servi
			<!--- Period 15 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='15' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1#   

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='15' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1#  

			group by itemno),0)
            </cfif>
            ) as sump15 from icservi as a
			) as p on a.servi=p.servi
			<!--- Period 16 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='16' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1#  

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='16' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1# 

			group by itemno),0)
            </cfif>
            ) as sump16 from icservi as a
			) as q on a.servi=q.servi
			<!--- Period 17 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='17' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1# 

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='17' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1# 

			group by itemno),0)
            </cfif>
            ) as sump17 from icservi as a
			) as r on a.servi=r.servi
			<!--- Period 18 --->
			left join 
			(select a.desp,a.servi,(ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='18' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg3# #critirial1# 

			group by itemno),0)
            <cfif msg4 neq 'and type=""'>
			-ifnull((select #msg1# from ictran where linecode = "SV" and itemno=a.servi and fperiod='18' and (void = '' or void is null) and wos_date > "#arguments.lastaccyear#" #msg4# #critirial1# 

			group by itemno),0)
            </cfif>
            ) as sump18 from icservi as a
			) as s on a.servi=s.servi
			
			where
			<cfswitch expression="#arguments.include0#">
				<cfcase value="yes">a.servi=a.servi</cfcase>
				<cfdefaultcase>
					(ifnull(b.sump1,0)+ifnull(c.sump2,0)+ifnull(d.sump3,0)+ifnull(e.sump4,0)+ifnull(f.sump5,0)+ifnull(g.sump6,0)+
					ifnull(h.sump7,0)+ifnull(i.sump8,0)+ifnull(j.sump9,0)+ifnull(k.sump10,0)+ifnull(l.sump11,0)+ifnull(m.sump12,0)+
					ifnull(n.sump13,0)+ifnull(o.sump14,0)+ifnull(p.sump15,0)+ifnull(q.sump16,0)+ifnull(r.sump17,0)+ifnull(s.sump18,0)) >0
				</cfdefaultcase>
			</cfswitch>
		
			group by a.servi order by a.servi
		</cfquery>
		<cfreturn getitem>
	</cffunction>
</cfcomponent>	