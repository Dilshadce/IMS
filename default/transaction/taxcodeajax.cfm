<cfsetting showdebugoutput="no">
<cfquery name="getcusttaxcode" datasource="#dts#">
select taxcode from #target_arcust# where custno='#url.custno#'
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery>

<cfset xtaxcode=getcusttaxcode.taxcode>
<cfif getcusttaxcode.recordcount eq 0 or getcusttaxcode.taxcode eq ''>
<cfset xtaxcode=getgsetup.df_salestaxzero>
</cfif>

<cfquery name="gettaxcode" datasource="#dts#">
			select * from #target_taxtable# where tax_type in ('T','ST') and rate1=0
			</cfquery>
            <cfoutput>
            <cfif url.ngst_cust eq 'true'>
            
            <select name="taxcode" id="taxcode">
              <cfloop query="gettaxcode">
                <option value="#gettaxcode.code#" <cfif gettaxcode.code eq xtaxcode>selected</cfif>>#gettaxcode.code#</option>
              </cfloop>
            </select>
            
            <cfelse>
            <input type="hidden" name="taxcode" id="taxcode" value="taxcode">
            </cfif>
            </cfoutput>