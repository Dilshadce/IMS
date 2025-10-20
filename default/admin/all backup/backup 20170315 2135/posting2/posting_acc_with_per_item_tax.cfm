<cfset thistype=getartran.type>
<cfset thisrefno=getartran.refno>
<cfquery name="getitemtax" datasource="#dts#">
	select sum(TAXAMT) as taxamt,sum(TAXAMT_BIL) as taxamt_bil,sum(amt) as taxable,note_a
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
                <td><div align="right">#numberformat(getitemtax.taxamt,".__")#</div><cfset totdebit = totdebit +numberformat(getitemtax.taxamt,".__")></td>
                <td></td>
            <cfelse>
                <cfset acctype = "Cr">
                <cfset xaccno = getaccno.gstsales>
                <td></td>
                <td><div align="right">#numberformat(getitemtax.taxamt,".__")#</div><cfset totcredit = totcredit + numberformat(getitemtax.taxamt,".__")></td>
            </cfif>
            
            <td><div align="center">GST</div></td>
            <td>#ceiling(getartran.fperiod)#</td>
            <td>#xaccno#</td>				
            <td>#acctype#</td>		
        	<td nowrap>#getartran.name#</td>
        </tr>
	</cfif>
</cfoutput>
		
<cfif post eq "post">
	<cfloop query="getitemtax">
    	<cfif val(getitemtax.taxamt) neq 0>
			<cfif thistype eq "RC" or thistype eq "CN">
                <cfquery name="insertpost3" datasource="#dts#">
                    insert into glpost9<cfif isdefined('url.ubs')>ubs</cfif> 
                    (
                        acc_code,
                        accno,
                        fperiod,date,
                        reference,
                        refno,
                        desp,
                        debitamt,
                        fcamt,
                        exc_rate,
                        rem4,
                        rem5,
						taxpur,
                        bdate,userid,agent
                    )
                    values 
                    (
                        '#thistype#',
                        '#xaccno#',
                        '#ceiling(getartran.fperiod)#',
                        #getartran.wos_date#,
                        '#billno#',
                        '#getartran.refno2#',
                        '#getartran.name#',
                        '#numberformat(getitemtax.taxamt,".__")#',
                        '#numberformat(getitemtax.taxamt_bil,".__")#',
                        '#getartran.currrate#',
                        '#getitemtax.note_a#',
                        '#getartran.rem6#',
						'#val(getitemtax.taxable)#',
                        #getartran.wos_date#,'#HUserID#','#getartran.agenno#'
                    )
                </cfquery>
                
                <cfquery name="insertpost3" datasource="#dts#">
                    insert into glpost91<cfif isdefined('url.ubs')>ubs</cfif> 
                    (
                        acc_code,
                        accno,
                        fperiod,date,
                        reference,
                        refno,
                        desp,
                        debitamt,
                        fcamt,
                        exc_rate,
                        rem4,
                        rem5,
						taxpur,
                        bdate,userid,agent
                    )
                    values 
                    (
                        '#thistype#',
                        '#xaccno#',
                        '#ceiling(getartran.fperiod)#',
                        #getartran.wos_date#,
                        '#billno#',
                        '#getartran.refno2#',
                        '#getartran.name#',
                        '#numberformat(getitemtax.taxamt,".__")#',
                        '#numberformat(getitemtax.taxamt_bil,".__")#',
                        '#getartran.currrate#',
                        '#getitemtax.note_a#',
                        '#getartran.rem6#',
						'#val(getitemtax.taxable)#',
                        #getartran.wos_date#,'#HUserID#','#getartran.agenno#'
                    )
                </cfquery>
            <cfelse>
                <cfquery name="insertpost3" datasource="#dts#">
                    insert into glpost9<cfif isdefined('url.ubs')>ubs</cfif> 
                    (
                        acc_code,
                        accno,
                        fperiod,
                        date,
                        reference,
                        refno,
                        desp,
                        creditamt,
                        fcamt,
                        exc_rate,
                        rem4,
                        rem5,
						taxpur,
                        bdate,userid,agent
                    )
                    values 
                    (
                        '#thistype#',
                        '#xaccno#',
                        '#ceiling(getartran.fperiod)#',
                        #getartran.wos_date#,
                        '#billno#',
                        '#getartran.refno2#',
                        '#getartran.name#',
                        '#numberformat(getitemtax.taxamt,".__")#',
                        '-#numberformat(getitemtax.taxamt_bil,".__")#',
                        '#getartran.currrate#',
                        '#getitemtax.note_a#',
                        '#getartran.rem6#',
						'#val(getitemtax.taxable)#',
                        #getartran.wos_date#,'#HUserID#','#getartran.agenno#'
                    )
                </cfquery>
                
                <cfquery name="insertpost3" datasource="#dts#">
                    insert into glpost91<cfif isdefined('url.ubs')>ubs</cfif> 
                    (
                        acc_code,
                        accno,
                        fperiod,
                        date,
                        reference,
                        refno,
                        desp,
                        creditamt,
                        fcamt,
                        exc_rate,
                        rem4,
                        rem5,
						taxpur,
                        bdate,userid,agent
                    )
                    values 
                    (
                        '#thistype#',
                        '#xaccno#',
                        '#ceiling(getartran.fperiod)#',
                        #getartran.wos_date#,
                        '#billno#',
                        '#getartran.refno2#',
                        '#getartran.name#',
                        '#numberformat(getitemtax.taxamt,".__")#',
                        '-#numberformat(getitemtax.taxamt_bil,".__")#',
                        '#getartran.currrate#',
                        '#getitemtax.note_a#',
                        '#getartran.rem6#',
						'#val(getitemtax.taxable)#',
                        #getartran.wos_date#,'#HUserID#','#getartran.agenno#'
                    )
                </cfquery>
            </cfif>
		</cfif>
    </cfloop>
</cfif>