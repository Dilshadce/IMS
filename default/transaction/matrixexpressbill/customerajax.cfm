<cfsetting showdebugoutput="no">
 <cfoutput>
 
<cfset xcustno="">

<cfif isdefined('url.refno')>
<cfquery name="getbillcust" datasource="#dts#">
	select custno from artran where type="#url.type#" and refno="#url.refno#"
</cfquery>
<cfset xcustno=getbillcust.custno>

</cfif> 

 
  <cfif url.type eq "TR">
  
				<input name="custno" id="custno" value="#xcustno#" maxlength="10" />
				
				
<cfelse>

<cfif url.type eq "rc" or url.type eq "pr" or url.type eq "po" or url.type eq "rq">
    <cfquery name="getcust" datasource="#dts#">
        Select "Please Select a Supplier" as custname, "" as custno
        union all
        Select concat(custno,'--',name) as custname,custno from #target_apvend# order by custno
    </cfquery>
<cfelse>
    <cfquery name="getcust" datasource="#dts#">
        Select "Please Select a Customer" as custname,"" as custno
        union all
        Select concat(custno,'--',name) as custname,custno from #target_arcust# order by custno
    </cfquery>
</cfif>


				<select name="custno" id="custno" onChange="updateDetails(this.value);" onKeyUp="nextIndex('custno','wos_date');">
                <cfloop query="getcust">
                <option value="#custno#" <cfif getcust.custno eq xcustno>selected</cfif>>#custname#</option>
                </cfloop>
                </select>
				<cfif url.type eq 'PO' or url.type eq 'RC' or url.type eq 'PR' or url.type eq 'RQ'>
                <input type="hidden" name="title" id="title" value="Supplier">
                <cfelse>
				<input type="hidden" name="title" id="title" value="Customer">
                </cfif>
				<input type="text" name="searchsuppfr" onKeyUp="getSupp('custno',document.getElementById('title').value);">



</cfif>

</cfoutput>