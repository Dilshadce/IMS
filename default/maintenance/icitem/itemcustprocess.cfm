<cfparam name="status" default="">

<cfset xremprice = form.price>
<cfset xdis1 = form.dis1>
<cfset xdis2 = form.dis2>
<cfset xdis3 = form.dis3>
<cfset xfirst = xremprice - (xdis1/100 * xremprice)>
<cfset xsecond = xfirst - (xdis2/100 * xfirst)>
<cfset xthird = xsecond - (xdis3/100 * xsecond)>
<cfset xunit = form.unit>

<cfif form.mode1 eq "Add">
<cfif hcomid eq "pohsiangpl_i">
<cfquery name="checkexist" datasource="#dts#">
SELECT itemno FROM icl3p2 WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and custno ='#custno#' and unit =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#xunit#">
</cfquery>

<cfif checkexist.recordcount neq 0>
<div align="center"><h3>You have added this item already.</h3>
		<input type="button" name="back" value="back" onClick="history.go(-1)"></div>
		<cfabort>
        
</cfif>
</cfif>
	<cfquery datasource="#dts#" name="inserticl3p2">
		insert into icl3p2 (itemno,custno,price,dispec,dispec2,dispec3,netprice,ci_note,desp,altitemno,unit)
		values (<cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#">, '#custno#', '#form.price#',
		'#form.dis1#', '#form.dis2#', '#form.dis3#', '#xthird#','#form.note#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#altitemno#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#xunit#">)
	</cfquery>		
	
	<form name="done" action="itemcustprice3.cfm?complete=complete" method="post">
		<cfoutput>
		<input type="hidden" name="mode" value="#mode#">
		<input type="hidden" name="custno" value="#custno#">		  
		<input type="hidden" name="itemno" value="#itemno#">
		<input name="status" value="#status#" type="hidden">
		</cfoutput>	 
	</form>
</cfif>

<cfif form.mode1 eq "Edit">
	<cfquery datasource="#dts#" name="updateicl3p">
		Update icl3p2 set ci_note = '#form.note#', price = '#form.price#', dispec = '#form.dis1#', 
		dispec2 = '#form.dis2#', dispec3 = '#form.dis3#', netprice = '#xthird#' ,desp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#"> ,altitemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#altitemno#">,unit =<cfqueryparam cfsqltype="cf_sql_varchar" value="#xunit#"> where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and custno = '#custno#'
	</cfquery>
	
	<form name="done" action="itemcustprice3.cfm?complete=complete" method="post">
		<cfoutput>
		<input type="hidden" name="mode" value="#mode#">
		<input type="hidden" name="custno" value="#custno#">		  
	  	<input type="hidden" name="itemno" value="#itemno#">
		<input name="status" value="#status#" type="hidden">
		</cfoutput>	
	</form>
</cfif>

<cfif form.mode1 eq "Delete">
	<cfquery datasource='#dts#' name="deleteitem">
		delete from icl3p2 where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#itemno#"> and custno = '#custno#'
	</cfquery>

	<form name="done" action="itemcustprice3.cfm?complete=complete" method="post">
		<cfoutput>
		<input type="hidden" name="mode" value="#mode#">
		<input name="status" type="hidden" value="#status#">
		<input type="hidden" name="custno" value="#custno#">		  
		<input type="hidden" name="itemno" value="#itemno#">
		</cfoutput>
	</form>
</cfif>

<script>
	done.submit();
</script>