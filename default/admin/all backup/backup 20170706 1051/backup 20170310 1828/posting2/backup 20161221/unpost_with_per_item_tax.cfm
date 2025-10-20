<cfset thistype=getartran.type>
<cfset thisrefno=getartran.refno>
<cfquery name="getitemtax" datasource="#dts#">
	select sum(TAXAMT) as taxamt,sum(TAXAMT_BIL) as taxamt_bil,note_a
    from ictran 
    where type='#thistype#'
    and refno='#thisrefno#'
    group by note_a
</cfquery>
<cfoutput query="getitemtax">
	<cfif val(getitemtax.taxamt) neq 0>
        <tr>
            <td>#thistype#</td>
            <td>#thisrefno#</td>
            <td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>
            
            <cfif getartran.type eq "RC" or getartran.type eq "CN" or getartran.type eq "PR">
                <cfset acctype = "D">			
                
                <cfif getartran.type eq "RC" or getartran.type eq "PR">
                    <cfset xaccno = getaccno.gstpurchase>				
                <cfelse>
                    <cfset xaccno = getaccno.gstsales>
                </cfif>
                <td><div align="right">#numberformat(getitemtax.taxamt,".__")#</div></td>
                <td></td>
            <cfelse>
                <cfset acctype = "Cr">
                <cfset xaccno = getaccno.gstsales>
                <td></td>
                <td><div align="right">#numberformat(getitemtax.taxamt,".__")#</div></td>
            </cfif>
            
            <td><div align="center">GST</div></td>
            <td>#ceiling(getartran.fperiod)#</td>
            <td>#xaccno#</td>				
            <td>#acctype#</td>		
        	<td nowrap>#getartran.name#</td>
        </tr>
	</cfif>
</cfoutput>