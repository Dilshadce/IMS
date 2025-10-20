<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
<!--- 	<cfset dd = dateformat(form.datefrom,"DD")>		
	
	<cfif dd greater than "12">
		<cfset ndatefrom = dateformat(form.datefrom,"YYYY-MM-DD")>
	<cfelse>
		<cfset ndatefrom = dateformat(form.datefrom,"YYYY-DD-MM")>
	</cfif>
	
	<cfset dd = dateformat(form.dateto,"DD")>		
	
	<cfif dd greater than 12>
		<cfset ndateto = dateformat(form.dateto,"YYYY-MM-DD")>
	<cfelse>
		<cfset ndateto = dateformat(form.dateto,"YYYY-DD-MM")>
	</cfif> --->
    <cfset ndatefrom = createdate(right(trim(form.datefrom),4),mid(trim(form.datefrom),4,2),left(trim(form.datefrom),2))>
    <cfset ndateto = createdate(right(trim(form.dateto),4),mid(trim(form.dateto),4,2),left(trim(form.dateto),2))>
    <cfset ndatefrom = dateformat(ndatefrom,'YYYY-MM-DD')>
    <cfset ndateto = dateformat(ndateto,'YYYY-MM-DD')>
    
	
	<cfif isdefined ("form.posttype")>
		<cfif status eq "unposted">
			<cfquery datasource="#dts#" name="gettran">
				select 
				* 
				from artran 
				where wos_date between '#ndatefrom#' and '#ndateto#' 
                <cfif form.custnofrom neq "" and form.custnoto neq "">
            	and custno between '#form.custnofrom#' and '#form.custnoto#'
            	</cfif>
                <cfif isdefined('url.ubs') eq false>
				and posted='' 
                <cfelse>
                and (postedubs = '' or postedubs is null)
                </cfif>
				and type='#form.posttype#' 
				and custno<>'ASSM/999' 
				and fperiod <> '99'
				and (void='' or void is null)
				group by refno 
				<cfif lcase(hcomid) eq "leadbuilders_i">order by type,refno2;<cfelse>order by type,refno;</cfif>
			</cfquery>
		<cfelse>
			<cfquery datasource="#dts#" name="gettran">
				select 
				* 
				from artran 
				where wos_date between '#ndatefrom#' and '#ndateto#' 
                <cfif form.custnofrom neq "" and form.custnoto neq "">
            	and custno between '#form.custnofrom#' and '#form.custnoto#'
            	</cfif>
				and posted<cfif isdefined('url.ubs')>ubs</cfif>='P' 
				and type='#form.posttype#' 
				and custno<>'ASSM/999' 
				and (void='' or void is null)
				group by refno 
				<cfif lcase(hcomid) eq "leadbuilders_i">order by type,refno2;<cfelse>order by type,refno;</cfif>
			</cfquery>
		</cfif>	
	</cfif>
<cfelseif isdefined("form.billnofrom") and isdefined("form.billnoto") and form.custnofrom neq "" and form.custnoto neq "">
	<cfif isdefined ("form.posttype")>
		<cfif status eq "unposted">
			<cfquery datasource="#dts#" name="gettran">
				select 
				* 
				from artran 
				where refno between '#form.billnofrom#' and '#form.billnoto#' 
				and custno between '#form.custnofrom#' and '#form.custnoto#' 
				<cfif isdefined('url.ubs') eq false>
				and posted='' 
                <cfelse>
                and (postedubs = '' or postedubs is null)
                </cfif>
				and type='#form.posttype#' 
				and custno<>'ASSM/999'
				and fperiod <> '99'
				and (void='' or void is null)
				group by refno 
				<cfif lcase(hcomid) eq "leadbuilders_i">order by type,refno2;<cfelse>order by type,refno;</cfif>
			</cfquery>
		<cfelse>
			<cfquery datasource="#dts#" name="gettran">
				select 
				* 
				from artran 
				where refno between '#form.billnofrom#' and '#form.billnoto#' 
				and custno between '#form.custnofrom#' and '#form.custnoto#'
				and posted<cfif isdefined('url.ubs')>ubs</cfif>='P' 
				and type='#form.posttype#' 
				and custno<>'ASSM/999' 
				and (void='' or void is null)
				group by refno 
				<cfif lcase(hcomid) eq "leadbuilders_i">order by type,refno2;<cfelse>order by type,refno;</cfif>
			</cfquery>
		</cfif>	
	</cfif>
<cfelseif isdefined("form.billnofrom") and isdefined("form.billnoto")>
	<cfif isdefined ("form.posttype")>
		<cfif status eq "unposted">
			<cfquery datasource="#dts#" name="gettran">
				select 
				* 
				from artran 
				where refno between '#form.billnofrom#' and '#form.billnoto#' 
				 <cfif isdefined('url.ubs') eq false>
				and posted='' 
                <cfelse>
                and (postedubs = '' or postedubs is null)
                </cfif>
				and type='#form.posttype#' 
				and custno<>'ASSM/999' 
				and fperiod <> '99'
				and (void='' or void is null)
				group by refno 
				<cfif lcase(hcomid) eq "leadbuilders_i">order by type,refno2;<cfelse>order by type,refno;</cfif>
			</cfquery>
		<cfelse>
			<cfquery datasource="#dts#" name="gettran">
				select 
				* 
				from artran 
				where refno between '#form.billnofrom#' and '#form.billnoto#' 
				and posted<cfif isdefined('url.ubs')>ubs</cfif>='P' 
				and type='#form.posttype#' 
				and custno<>'ASSM/999' 
				and (void='' or void is null)
				group by refno 
				<cfif lcase(hcomid) eq "leadbuilders_i">order by type,refno2;<cfelse>order by type,refno;</cfif>
			</cfquery>
		</cfif>
	</cfif>
<cfelseif isdefined("form.billno2from") and isdefined("form.billno2to")>
	<cfif isdefined ("form.posttype")>
		<cfif status eq "unposted">
			<cfquery datasource="#dts#" name="gettran">
				select 
				* 
				from artran 
				where refno2 between '#form.billno2from#' and '#form.billno2to#' 
				 <cfif isdefined('url.ubs') eq false>
				and posted='' 
                <cfelse>
                and (postedubs = '' or postedubs is null)
                </cfif>
				and type='#form.posttype#' 
				and custno<>'ASSM/999' 
				and fperiod <> '99'
				and (void='' or void is null)
				group by refno 
				<cfif lcase(hcomid) eq "leadbuilders_i">order by type,refno2;<cfelse>order by type,refno;</cfif>
			</cfquery>
		<cfelse>
			<cfquery datasource="#dts#" name="gettran">
				select 
				* 
				from artran 
				where refno2 between '#form.billno2from#' and '#form.billno2to#' 
				and posted<cfif isdefined('url.ubs')>ubs</cfif>='P' 
				and type='#form.posttype#' 
				and custno<>'ASSM/999' 
				and (void='' or void is null)
				group by refno 
				<cfif lcase(hcomid) eq "leadbuilders_i">order by type,refno2;<cfelse>order by type,refno;</cfif>
			</cfquery>
		</cfif>
	</cfif>

<cfelseif isdefined("form.custnofrom") and isdefined("form.custnoto")>
	<cfif isdefined ("form.posttype")>
		<cfif status eq "unposted">
			<cfquery datasource="#dts#" name="gettran">
				select 
				* 
				from artran 
				where custno between '#form.custnofrom#' and '#form.custnoto#' 
                <cfif trim(form.period) neq "">
                and fperiod='#form.period#'
                </cfif>
				 <cfif isdefined('url.ubs') eq false>
				and posted='' 
                <cfelse>
                and (postedubs = '' or postedubs is null)
                </cfif>
				and type='#form.posttype#' 
				and custno<>'ASSM/999' 
				and fperiod <> '99'
				and (void='' or void is null)
				group by refno 
				<cfif lcase(hcomid) eq "leadbuilders_i">order by type,refno2;<cfelse>order by type,refno;</cfif>
			</cfquery>	
		<cfelse>
			<cfquery datasource="#dts#" name="gettran">
				select 
				* 
				from artran 
				where custno between '#form.custnofrom#' and '#form.custnoto#' 
                <cfif trim(form.period) neq "">
                and fperiod='#form.period#'
                </cfif>
				and posted<cfif isdefined('url.ubs')>ubs</cfif>='P' 
				and type='#form.posttype#' 
				and custno<>'ASSM/999' 
				and fperiod <> '99'
				and (void='' or void is null)
				group by refno 
				<cfif lcase(hcomid) eq "leadbuilders_i">order by type,refno2;<cfelse>order by type,refno;</cfif>
			</cfquery>	
		</cfif>	
	</cfif>

<cfelseif isdefined("form.billstatus")>
	<cfif isdefined ("form.posttype")>
		<cfif status eq "unposted">
			<cfquery datasource="#dts#" name="gettran">
				select 
				* 
				from artran 
				where 
                <cfif billstatus eq "fullypaid">
                cs_pm_debt=0
                <cfelse>
				cs_pm_debt!=0
                </cfif>
				 <cfif isdefined('url.ubs') eq false>
				and posted='' 
                <cfelse>
                and (postedubs = '' or postedubs is null)
                </cfif>
				and type='#form.posttype#' 
				and custno<>'ASSM/999' 
				and fperiod <> '99'
				and (void='' or void is null)
				group by refno 
				<cfif lcase(hcomid) eq "leadbuilders_i">order by type,refno2;<cfelse>order by type,refno;</cfif>
			</cfquery>	
		<cfelse>
			<cfquery datasource="#dts#" name="gettran">
				select 
				* 
				from artran 
				where custno between '1' and '1' 
				and posted<cfif isdefined('url.ubs')>ubs</cfif>='P' 
				and type='#form.posttype#' 
				and custno<>'ASSM/999' 
				and fperiod <> '99'
				and (void='' or void is null)
				group by refno 
				<cfif lcase(hcomid) eq "leadbuilders_i">order by type,refno2;<cfelse>order by type,refno;</cfif>
			</cfquery>	
		</cfif>	
	</cfif>    

<cfelseif isdefined("form.period")>
	<cfif isdefined ("form.posttype")>
		<cfif status eq "unposted">
			<cfquery datasource="#dts#" name="gettran">
				select 
				* 
				from artran 
				where fperiod='#form.period#' 
				<cfif isdefined('url.ubs') eq false>
				and posted='' 
                <cfelse>
                and (postedubs = '' or postedubs is null)
                </cfif>
				and type='#form.posttype#' 
				and custno<>'ASSM/999' 
				and fperiod <> '99'
				and (void='' or void is null)
				group by refno 
				<cfif lcase(hcomid) eq "leadbuilders_i">order by type,refno2;<cfelse>order by type,refno;</cfif>
			</cfquery>
		<cfelse>
			<cfquery datasource="#dts#" name="gettran">
				select 
				* 
				from artran 
				where fperiod='#form.period#' 
				and posted<cfif isdefined('url.ubs')>ubs</cfif>='P' 
				and type='#form.posttype#' 
				and custno<>'ASSM/999' 
				and (void='' or void is null)
				group by refno 
				<cfif lcase(hcomid) eq "leadbuilders_i">order by type,refno2;<cfelse>order by type,refno;</cfif>
			</cfquery>
		</cfif>
	<cfelse>
		<h3>Please select one type of document to post.</h3>
		<cfabort>
	</cfif>    

<cfelse>
	<cfquery datasource="#dts#" name="gettran">
		select 
		* 
		from artran 
		where posted='S'
		and (void='' or void is null); 
	</cfquery>
</cfif>

<cfif sort eq '-'>
	<cfquery datasource="#dts#" name="gettran">
		select 
		* 
		from artran 
		where type='#form.posttype#' 
		 <cfif isdefined('url.ubs') eq false>
        and posted='' 
        <cfelse>
        and (postedubs = '' or postedubs is null)
        </cfif> 
		and custno<>'ASSM/999' 
		and fperiod <> '99'
		and (void='' or void is null)
		group by refno 
		<cfif lcase(hcomid) eq "leadbuilders_i">order by type,refno2;<cfelse>order by type,refno;</cfif>
	</cfquery>
</cfif>