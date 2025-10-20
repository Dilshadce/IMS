<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
	<cfset dd = dateformat(form.datefrom, "DD")>
		
	<cfif dd greater than "12">
		<cfset ndatefrom = dateformat(form.datefrom,"YYYY-MM-DD")>
	<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYY-DD-MM")>
	</cfif>
	
	<cfset dd = dateformat(form.dateto, "DD")>		
	
	<cfif dd greater than "12">
		<cfset ndateto = dateformat(form.dateto,"YYYY-MM-DD")>
	<cfelse>
		<cfset ndateto = dateformat(form.dateto,"YYYY-DD-MM")>
	</cfif>
	
	<cfif isdefined ("form.posttype")>		
		<cfquery datasource="#dts#" name="gettran">
			select * 
			from artran 
			where type='#form.posttype#' 
			and wos_date between '#ndatefrom#' and '#ndateto#' 
            <cfif form.custnofrom neq "" and form.custnoto neq "">
            and custno between '#form.custnofrom#' and '#form.custnoto#'
            </cfif>
			and posted='P' 
			group by refno 
			order by type,refno;
		</cfquery>
	</cfif>	
<cfelseif isdefined("form.period")>
	<cfif isdefined ("form.posttype")>
		<cfquery datasource="#dts#" name="gettran">
			select * 
			from artran 
			where fperiod='#form.period#' and posted='P' and type='#form.posttype#' 
			group by refno 
			order by type,refno
		</cfquery>	
	<cfelse>
		<h3>Please select one type of documents to unpost.</h3>
		<cfabort>
	</cfif>
<cfelseif isdefined("form.billnofrom") and isdefined("form.billnoto") and form.custnofrom neq "" and form.custnoto neq "">
	<cfif isdefined ("form.posttype")>		
		<cfquery datasource="#dts#" name="gettran">
			select * 
			from artran 
			where refno between '#form.billnofrom#' and '#form.billnoto#' and custno between '#form.custnofrom#' and '#form.custnoto#' and posted='P' and type='#form.posttype#' 
			group by refno 
			order by type,refno
		</cfquery>
	</cfif>
<cfelseif isdefined("form.billnofrom") and isdefined("form.billnoto")>
	<cfif isdefined ("form.posttype")>			
		<cfquery datasource="#dts#" name="gettran">
			select * 
			from artran 
			where refno between '#form.billnofrom#' and '#form.billnoto#' and posted='P' and type='#form.posttype#' 
			group by refno 
			order by type,refno
		</cfquery>
	</cfif>
<cfelseif isdefined("form.custnofrom") and isdefined("form.custnoto")>
	<cfif isdefined ("form.posttype")>			
		<cfquery datasource="#dts#" name="gettran">
			select * 
			from artran 
			where custno between '#form.custnofrom#' and '#form.custnoto#' and posted='P' and type='#form.posttype#' 
			group by refno 
			order by type,refno
		</cfquery>	
	</cfif>
<cfelse>	
	<cfquery datasource="#dts#" name="gettran">
		select * 
		from artran 
		where posted='S'
	</cfquery>
</cfif>

<cfif sort eq "-">
	<cfquery datasource="#dts#" name="gettran">
		select * 
		from artran 
		where posted='P' and type='#form.posttype#' 
		group by refno 
		order by type,refno
	</cfquery>
</cfif>