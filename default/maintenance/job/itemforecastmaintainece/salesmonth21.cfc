<cfcomponent>
	<cffunction name="getmonthcust">
		<cfargument name="dts" required="yes">
		<cfargument name="lastaccyear" required="yes">
		<cfargument name="productfrom" required="yes">
		<cfargument name="productto" required="yes">
		<cfargument name="include" required="yes">
		<cfargument name="include0" required="yes">
		
        <cfset intrantype="'RC','CN','OAI','TRIN'">

	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU'">
        
		<cfswitch expression="#arguments.include#">
			<cfcase value="yes">
				<cfset msg1 = 'and (type="INV" or type="CS" or type="DN")'>
				<cfset msg2 = 'and type="CN"'>
			</cfcase>
			<cfdefaultcase>
				<cfset msg1 = 'and (type="INV" or type="CS")'>
				<cfset msg2 = 'and type=""'>
			</cfdefaultcase>
		</cfswitch>		
		
		<cfif arguments.productfrom neq "" and arguments.productto neq "">
			<cfset critirial1 = 'and agenno between "#arguments.productfrom#" and "#arguments.productto#"'>
		<cfelse>
			<cfset critirial1 = "">
		</cfif>
		
		
        <cfquery name="getitem" datasource="#dts#">
			select 
			a.itemno,
			a.desp,
			a.unit,
            a.fprice,
            p1.period1 as p1_period1,
            p2.period2 as p2_period2,
            p3.period3 as p3_period3,
            p4.period4 as p4_period4,
            p5.period5 as p5_period5,
            p6.period6 as p6_period6,
			ifnull(d.qout,0) as qoutperiod1,
            ifnull(g.qout,0) as qoutperiod2,
            ifnull(j.qout,0) as qoutperiod3,
            ifnull(m.qout,0) as qoutperiod4,
            ifnull(p.qout,0) as qoutperiod5,
            ifnull(s.qout,0) as qoutperiod6,


			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybfperiod1,
            (ifnull(a.qtybf,0)+ifnull(e.getlastin,0)-ifnull(f.getlastout,0)) as qtybfperiod2,
            
            (ifnull(a.qtybf,0)+ifnull(h.getlastin,0)-ifnull(i.getlastout,0)) as qtybfperiod3,
            
            (ifnull(a.qtybf,0)+ifnull(k.getlastin,0)-ifnull(l.getlastout,0)) as qtybfperiod4,
            
            (ifnull(a.qtybf,0)+ifnull(n.getlastin,0)-ifnull(o.getlastout,0)) as qtybfperiod5,
            
            (ifnull(a.qtybf,0)+ifnull(q.getlastin,0)-ifnull(r.getlastout,0)) as qtybfperiod6
		
			from icitem as a
	<!---period 1---->
			left join
			(
				select itemno,sum(qty) as getlastin 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) 
				and fperiod+0 < '01' 
				and fperiod<>'99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				group by itemno
			) as b on a.itemno = b.itemno
	
			left join
			(
				select itemno,sum(qty) as getlastout 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#)
				and fperiod+0 < '01' 
				and fperiod<>'99'
				and (toinv='' or toinv is null)
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				group by itemno
			) as c on a.itemno = c.itemno
	
	
			left join
			(
				select itemno,sum(qty) as qout 
				from ictran 
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) 
				and fperiod<>'99' 
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and (toinv='' or toinv is null) 
                and fperiod+0 = '01' 
				group by itemno
			) as d on a.itemno=d.itemno
            
            
            left join
			(
				select itemno,period1
				from icitemforecast 
				
			) as p1 on a.itemno=p1.itemno
		<!---End period 1---->
	
    	<!---period 2---->
			left join
			(
				select itemno,sum(qty) as getlastin 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) 
				and fperiod+0 < '02' 
				and fperiod<>'99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				group by itemno
			) as e on a.itemno = e.itemno
	
			left join
			(
				select itemno,sum(qty) as getlastout 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#)
				and fperiod+0 < '02' 
				and fperiod<>'99'
				and (toinv='' or toinv is null)
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				group by itemno
			) as f on a.itemno = f.itemno
	
	
			left join
			(
				select itemno,sum(qty) as qout 
				from ictran 
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) 
				and fperiod<>'99' 
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and (toinv='' or toinv is null) 
                and fperiod+0 = '02' 
				group by itemno
			) as g on a.itemno=g.itemno
            
                        left join
			(
				select itemno,period2
				from icitemforecast 
				
			) as p2 on a.itemno=p2.itemno
		<!---End period 2---->
    
        	<!---period 3---->
			left join
			(
				select itemno,sum(qty) as getlastin 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) 
				and fperiod+0 < '03' 
				and fperiod<>'99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				group by itemno
			) as h on a.itemno = h.itemno
	
			left join
			(
				select itemno,sum(qty) as getlastout 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#)
				and fperiod+0 < '03' 
				and fperiod<>'99'
				and (toinv='' or toinv is null)
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				group by itemno
			) as i on a.itemno = i.itemno
	
	
			left join
			(
				select itemno,sum(qty) as qout 
				from ictran 
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) 
				and fperiod<>'99' 
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and (toinv='' or toinv is null) 
                and fperiod+0 = '03' 
				group by itemno
			) as j on a.itemno=j.itemno
            
                        left join
			(
				select itemno,period3
				from icitemforecast 
				
			) as p3 on a.itemno=p3.itemno
		<!---End period 3---->
        
        <!---period 4---->
			left join
			(
				select itemno,sum(qty) as getlastin 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) 
				and fperiod+0 < '04' 
				and fperiod<>'99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				group by itemno
			) as k on a.itemno = k.itemno
	
			left join
			(
				select itemno,sum(qty) as getlastout 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#)
				and fperiod+0 < '04' 
				and fperiod<>'99'
				and (toinv='' or toinv is null)
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				group by itemno
			) as l on a.itemno = l.itemno
	
	
			left join
			(
				select itemno,sum(qty) as qout 
				from ictran 
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) 
				and fperiod<>'99' 
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and (toinv='' or toinv is null) 
                and fperiod+0 = '04' 
				group by itemno
			) as m on a.itemno=m.itemno
            
                        left join
			(
				select itemno,period4
				from icitemforecast 
				
			) as p4 on a.itemno=p4.itemno
		<!---End period 4---->
    
            <!---period 5---->
			left join
			(
				select itemno,sum(qty) as getlastin 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) 
				and fperiod+0 < '05' 
				and fperiod<>'99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				group by itemno
			) as n on a.itemno = n.itemno
	
			left join
			(
				select itemno,sum(qty) as getlastout 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#)
				and fperiod+0 < '05' 
				and fperiod<>'99'
				and (toinv='' or toinv is null)
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				group by itemno
			) as o on a.itemno = o.itemno
	
	
			left join
			(
				select itemno,sum(qty) as qout 
				from ictran 
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) 
				and fperiod<>'99' 
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and (toinv='' or toinv is null) 
                and fperiod+0 = '05' 
				group by itemno
			) as p on a.itemno=p.itemno
            
                        left join
			(
				select itemno,period5
				from icitemforecast 
				
			) as p5 on a.itemno=p5.itemno
		<!---End period 5---->
        
                <!---period 6---->
			left join
			(
				select itemno,sum(qty) as getlastin 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) 
				and fperiod+0 < '06' 
				and fperiod<>'99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				group by itemno
			) as q on a.itemno = q.itemno
	
			left join
			(
				select itemno,sum(qty) as getlastout 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#)
				and fperiod+0 < '06' 
				and fperiod<>'99'
				and (toinv='' or toinv is null)
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				group by itemno
			) as r on a.itemno = r.itemno
	
	
			left join
			(
				select itemno,sum(qty) as qout 
				from ictran 
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) 
				and fperiod<>'99' 
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and (toinv='' or toinv is null) 
                and fperiod+0 = '06' 
				group by itemno
			) as s on a.itemno=s.itemno
            
                        left join
			(
				select itemno,period6
				from icitemforecast 
				
			) as p6 on a.itemno=p6.itemno
		<!---End period 6---->
			where a.itemno=p6.itemno 
            
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			group by a.itemno 
			order by a.itemno 
		</cfquery>
        
        
		
		<cfreturn getitem>
	</cffunction>
</cfcomponent>	