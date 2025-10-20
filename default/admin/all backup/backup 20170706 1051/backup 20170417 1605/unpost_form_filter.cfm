<cfoutput>
<script type="text/javascript">
function submitform()
{
document.form1.submit()
}
</script>
<cfform action="" method="post" name="form1">  
    <input type="radio" name="posttype" value="INV"<cfif posttype eq "INV">checked</cfif>> Invoice 
    <input type="radio" name="posttype" value="CN"<cfif posttype eq "CN">checked</cfif>> Credit Note 
    <input type="radio" name="posttype" value="DN"<cfif posttype eq "DN">checked</cfif>> Debit Note 
    <input type="radio" name="posttype" value="RC"<cfif posttype eq "RC">checked</cfif>> Purchase Receive 
    <input type="radio" name="posttype" value="CS"<cfif posttype eq "CS">checked</cfif>> Cash Sales 
    <input type="radio" name="posttype" value="PR"<cfif posttype eq "PR">checked</cfif>> Purchase Return
  	
	<p><strong>Sort by</strong> : 
	
	<cfif isdefined("form.sort") and form.sort neq "">
		<cfset xsort = form.sort>
	<cfelse>
		<cfset xsort = "">
    </cfif>
	
    <select name="Sort" onchange="ajaxFunction(document.getElementById('ajaxField'),'postingacc_form_filter_Ajax.cfm?sort='+document.getElementById('sort').value);">
		<option value="-">-</option>
      	<option value="trxdate"<cfif xsort eq "trxdate">selected</cfif>>Date</option>
      	<option value="period"<cfif xsort eq "period">selected</cfif>>Period</option>
      	<option value="trxbillno"<cfif xsort eq "trxbillno">selected</cfif>>Billno</option>
      	<option value="custno"<cfif xsort eq "custno">selected</cfif>>Customer No</option>
    </select>
    &nbsp; 
    <input type="submit" name="typesubmit" value="Sort">
  	</p>
  	<div id="ajaxField" name="ajaxField">
	<cfif isdefined("form.sort")>
  		<cfif not isdefined("form.posttype")>
			<h3>Error: Please select one type of document to unpost.</h3>
			<cfabort>
		</cfif>
		
		<cfif form.sort eq "trxdate">
			<cfif isdefined("form.datefrom") and isdefined("form.dateto")>
				<cfset xdatefrom = form.datefrom>
				<cfset xdateto = form.dateto>
			<cfelse>
				<cfset xdatefrom = "">
				<cfset xdateto = "">
			</cfif>
			
			Date From 	<cfinput type="text" name="datefrom" size="10" maxlength="10" value="#xdatefrom#" required="no" validate="eurodate">
			Date To		<cfinput type="text" name="dateto" size="10" maxlength="10"  value="#xdateto#"required="no" validate="eurodate">
            
            <cfif isdefined("form.custnofrom") and isdefined("form.custnoto")>
				<cfset xcustnofrom = form.custnofrom>
        		<cfset xcustnoto = form.custnoto>
      		<cfelse>
        		<cfset xcustnofrom = "">
        		<cfset xcustnoto = "">
      		</cfif>
			
			Customer No From 	<cfinput type="text" name="custnofrom" size="10" value="#xcustnofrom#" maxlength="8">
      		Customer No To		<cfinput type="text" name="custnoto" size="10" value="#xcustnoto#" maxlength="8" >
			<input type="submit" name="submit" value="Go">
    	<cfelseif form.sort eq "period">
			<cfif isdefined("form.period")>
				<cfset xperiod = form.period>
			<cfelse>
				<cfset xperiod = "">
			</cfif>
			
			Period <cfinput type="text" name="period" size="10" maxlength="2" value="#xperiod#" validate="integer">
			<input type="submit" name="submit2" value="Go">
    	<cfelseif form.sort eq "trxbillno">
			<cfif isdefined("form.billnofrom") and isdefined("form.billnoto")>
				<cfset xbillnofrom = form.billnofrom>
				<cfset xbillnoto = form.billnoto>
			<cfelse>
				<cfset xbillnofrom = "">
				<cfset xbillnoto = "">
			</cfif>
      		<cfif isdefined("form.custnofrom") and isdefined("form.custnoto")>
        		<cfset xcustnofrom = form.custnofrom>
       			<cfset xcustnoto = form.custnoto>
        	<cfelse>
        		<cfset xcustnofrom = "">
        		<cfset xcustnoto = "">
     		</cfif>
			
			Bill No From	<cfinput type="text" name="billnofrom" size="10" maxlength="20"  value="#xbillnofrom#">
			Bill No To		<cfinput type="text" name="billnoto" size="10" maxlength="20" value="#xbillnoto#" >
			
			<br>
			<cfif posttype eq "RC">
				<cfquery name="getcust" datasource="#dts#">
					select custno, name from #target_apvend# order by custno
				</cfquery>
			<cfelse>
				<cfquery name="getcust" datasource="#dts#">
					select custno, name from #target_arcust# order by custno
				</cfquery>
			</cfif>
			
			Customer No From 
			<select name="custnofrom">
				<option value="">Choose a customer</option>
				<cfloop query="getcust"> 
		  			<option value="#custno#"<cfif custno eq xcustnofrom>selected</cfif>>#custno# - #name#</option>
				</cfloop>
			</select>
			
			<br>
			Customer No To &nbsp;&nbsp; 
			<select name="custnoto">
				<option value="">Choose a customer</option>
				<cfloop query="getcust"> 
		 			<option value="#custno#"<cfif custno eq #xcustnoto#>selected</cfif>>#custno# - #name#</option>
				</cfloop> 
			</select>
			<input type="submit" name="submit3" value="Go">
   		<cfelseif form.sort eq "Custno">
			<cfif isdefined("form.custnofrom") and isdefined("form.custnoto")>
				<cfset xcustnofrom = form.custnofrom>
        		<cfset xcustnoto = form.custnoto>
      		<cfelse>
        		<cfset xcustnofrom = "">
        		<cfset xcustnoto = "">
      		</cfif>
			
			Customer No From 	<cfinput type="text" name="custnofrom" size="10" value="#xcustnofrom#" maxlength="8">
      		Customer No To		<cfinput type="text" name="custnoto" size="10" value="#xcustnoto#" maxlength="8" >
			<input type="submit" name="submit4" value="Go">
    	</cfif>
  	</cfif>
    </div>
	<br><br><div align="center"><input type="submit" name="unpost" id="unpost" value="Unpost"></div>
</cfform>
</cfoutput>