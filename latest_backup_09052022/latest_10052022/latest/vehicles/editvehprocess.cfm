<cfif isdate(form.dob)>
<cfset ndate = createdate(right(form.dob,4),mid(form.dob,4,2),left(form.dob,2))>
<cfset form.dob = dateformat(ndate,'yyyy-mm-dd')>
<cfelse>
<cfset form.dob = "0000-00-00">
</cfif>
<cfif isdate(form.licdate)>
<cfset ndate = createdate(right(form.licdate,4),mid(form.licdate,4,2),left(form.licdate,2))>
<cfset form.licdate =dateformat(ndate,'yyyy-mm-dd')>
<cfelse>
<cfset form.licdate = "0000-00-00">
</cfif>
<cfif isdate(form.oriregdate)>
<cfset ndate = createdate(right(form.oriregdate,4),mid(form.oriregdate,4,2),left(form.oriregdate,2))>
<cfset form.oriregdate = dateformat(ndate,'yyyy-mm-dd')>
<cfelse>
<cfset form.oriregdate = "0000-00-00">
</cfif>
<cfif isdate(form.inexpdate)>
<cfset ndate = createdate(right(form.inexpdate,4),mid(form.inexpdate,4,2),left(form.inexpdate,2))>
<cfset form.inexpdate = dateformat(ndate,'yyyy-mm-dd')>
<cfelse>
<cfset form.inexpdate = "0000-00-00">
</cfif>

<cfquery name="insertvehicles" datasource="#dts#">
Update vehicles set 
    custname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custname#"> ,
    custic = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custic#"> ,
    custadd = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custadd#"> ,
    custemail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custemail#"> ,
    gender = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.gender#"> ,
    marstatus = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.marital#"> ,
    dob = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.dob#"> ,
    licdate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.licdate#"> ,
  ncd = '#form.ncd#',
  <cfif isdefined('form.com')>
  com = '#form.com#' ,
<cfelse>
  com = 'false' ,
</cfif>

  scheme = '#form.scheme#',
  make = '#form.make#' ,
  model = '#form.model#' ,
  chasisno = '#form.chasis#' ,
  yearmade = '#form.yearofmade#' ,
 oriregdate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.oriregdate#">,
  capacity = '#form.capacity#' ,
  coveragetype = '#form.coverage#' ,
  excess = '#form.excess#' ,
  marketvalue = '#form.marketvalue#' ,
  <cfif #form.suminsured# neq 2>suminsured = '#form.suminsured#'<cfelse> suminsured = '#form.suminsured2#' </cfif>,
  insurance = '#form.insurance#' ,
  premium = '#form.premium#',
  financecom = '#form.financecom#',
  <cfif #form.commission# neq 2>commission= '#form.commission#'<cfelse> commission = '#form.commission2#' </cfif> ,
  contract = '#form.contract#', 
  payment = '#form.payment#',
  custrefer = '#form.referred#', 
  inexpdate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.inexpdate#">
  WHERE
  carno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.carno#">
  
</cfquery>

			<cfset status="#form.carno# had been successfully edited.">

<form name="done" action="vehicles.cfm" method="post">
	<input name="status" value="<cfoutput>#status#</cfoutput>" type="hidden">
</form>
<script>
	done.submit();
</script>
