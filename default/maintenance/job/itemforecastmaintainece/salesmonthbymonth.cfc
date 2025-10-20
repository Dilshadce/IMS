<cfcomponent>
	<cffunction name="getmonthcust">
		<cfargument name="dts" required="yes">
		<cfargument name="lastaccyear" required="yes">
		<cfargument name="productfrom" required="yes">
		<cfargument name="productto" required="yes">
		<cfargument name="include" required="yes">
		<cfargument name="include0" required="yes">
		<cfargument name="period" required="yes">
        
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
		<cfif #arguments.period# eq "01">
        <cfset p1='period1'>
        <cfelseif #arguments.period# eq "02">
        <cfset p1='period2'>
        <cfelseif #arguments.period# eq "03">
        <cfset p1='period3'>
        <cfelseif #arguments.period# eq "04">
        <cfset p1='period4'>
        <cfelseif #arguments.period# eq "05">
        <cfset p1='period5'>
        <cfelseif #arguments.period# eq "06">
        <cfset p1='period6'>
        <cfelseif #arguments.period# eq "07">
        <cfset p1='period7'>
        <cfelseif #arguments.period# eq "08">
        <cfset p1='period8'>
        <cfelseif #arguments.period# eq "09">
        <cfset p1='period9'>
        <cfelseif #arguments.period# eq "10">
        <cfset p1='period10'>
        <cfelseif #arguments.period# eq "11">
        <cfset p1='period11'>
        <cfelseif #arguments.period# eq "12">
        <cfset p1='period12'>
        <cfelseif #arguments.period# eq "13">
        <cfset p1='period13'>
        <cfelseif #arguments.period# eq "14">
        <cfset p1='period14'>
        <cfelseif #arguments.period# eq "15">
        <cfset p1='period15'>
        <cfelseif #arguments.period# eq "16">
        <cfset p1='period16'>
        <cfelseif #arguments.period# eq "17">
        <cfset p1='period17'>
        <cfelseif #arguments.period# eq "18">
        <cfset p1='period18'>
        </cfif>
        
        
		   <cfquery name="getitem" datasource="#dts#">
			select 
			a.itemno,
			a.desp,
			a.unit,
            a.fprice,
            p1.#p1# as p1_period1,
			ifnull(d.qout,0) as qoutperiod1,

			(ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)) as qtybfperiod1

		
			from icitem as a
	<!---period 1---->
			left join
			(
				select itemno,sum(qty) as getlastin 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) 
				and fperiod+0 < '#arguments.period#' 
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
				and fperiod+0 < '#arguments.period#' 
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
                and fperiod+0 = '#arguments.period#' 
				group by itemno
			) as d on a.itemno=d.itemno
            
            
            left join
			(
				select itemno,#p1#
				from icitemforecast 
				
			) as p1 on a.itemno=p1.itemno
		<!---End period 1---->
	
			where a.itemno=p1.itemno 
            
			<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
				and a.itemno between '#form.productfrom#' and '#form.productto#'
			</cfif>
			group by a.itemno 
			order by a.itemno 
		</cfquery>
        
        
		
		<cfreturn getitem>
	</cffunction>
</cfcomponent>	