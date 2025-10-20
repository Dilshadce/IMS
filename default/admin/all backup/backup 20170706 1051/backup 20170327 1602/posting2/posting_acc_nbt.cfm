<cfoutput>
<cfset xaccno = getaccno.nbt>
<!---
<tr>
	<td>#getartran.type#</td>
	<td>#getartran.refno#</td>
	<td>#dateformat(getartran.wos_date,"dd/mm/yyyy")#</td>
	<cfset acctype = "D">	
	
	<td><div align="right">#numberformat(getartran.taxnbt,".__")#</div><cfset totdebit = totdebit + numberformat(getartran.taxnbt,".__")></td>
	<td></td>
	<td><div align="center">NBT</div></td>
	<td>#ceiling(getartran.fperiod)#</td>
	<td>#xaccno#</td>				
	<td>#acctype#</td>		
	<td nowrap>#getartran.name#</td>
    <td nowrap>#getartran.agenno#</td>
</tr>--->
</cfoutput>
		

    <cfquery name="insertpost3" datasource="#dts#">
        insert into glposttemp
        (
            acc_code,
            accno,
            fperiod,date,
            reference,
            desp,
            debitamt,
            fcamt,
            exc_rate,
            rem4,
            rem5,
            bdate,userid,agent,uuid
        )
        values 
        (
            '#getartran.type#',
            '#xaccno#',
            '#ceiling(getartran.fperiod)#',
            #getartran.wos_date#,
            '#billno#',
            '#getartran.name#',
            '#numberformat(getartran.taxnbt,".__")#',
            '#numberformat(getartran.taxnbt_bil,".__")#',
            '#getartran.currrate#',
            'NBT',
            '#getartran.rem6#',
            #getartran.wos_date#,'#HUserID#','#getartran.agenno#','#uuid#'
        )
    </cfquery>
    
		