<cfoutput>
<cfquery name="getdetails" datasource="#dts#">
select refno,payrollperiod,empno,selfsalary,
    lvltotalee1,
    lvltotalee2,
    <cfloop index='a' from='1' to='8'>
    selfot#a#,
    </cfloop>
    <cfloop index='a' from='1' to='6'>
    fixawee#a#,
    </cfloop>
    <cfloop index='a' from='1' to='18'>
    awee#a#,
    </cfloop>
    <cfloop index='a' from='1' to='3'>
        addchargeself<cfif a neq 1>#a#</cfif>,
    </cfloop>
    <cfloop index='a' from='1' to='3'>
    ded#a#,
    </cfloop>
    selfcpf,
    selfsdf,
    selftotal,
    (
    ifnull(selfsalary,0.00)
    +ifnull(lvltotalee1,0.00)
    +ifnull(lvltotalee2,0.00)
    <cfloop index='a' from='1' to='8'>
    +ifnull(selfot#a#,0.00)
    </cfloop>
    <cfloop index='a' from='1' to='6'>
    +ifnull(fixawee#a#,0.00)
    </cfloop>
    <cfloop index='a' from='1' to='18'>
    +ifnull(awee#a#,0.00)
    </cfloop>
    <cfloop index='a' from='1' to='3'>
        +ifnull(addchargeself<cfif a neq 1>#a#</cfif>,0.00)
    </cfloop>
    )
    gross,
    replace(format((
    ifnull(selfsalary,0.00)
    +ifnull(lvltotalee1,0.00)
    +ifnull(lvltotalee2,0.00)
    <cfloop index='a' from='1' to='8'>
    +ifnull(selfot#a#,0.00)
    </cfloop>
    <cfloop index='a' from='1' to='6'>
    +ifnull(fixawee#a#,0.00)
    </cfloop>
    <cfloop index='a' from='1' to='18'>
    +ifnull(awee#a#,0.00)
    </cfloop>
    <cfloop index='a' from='1' to='3'>
        +ifnull(addchargeself<cfif a neq 1>#a#</cfif>,0.00)
    </cfloop>
    <cfloop index='a' from='1' to='3'>
    -ifnull(ded#a#,0.00)
    </cfloop>
    -ifnull(selfcpf,0.00)
    -ifnull(selfsdf,0.00)
    ),2),',','')
    checkselftotal
from assignmentslip
    where year(assignmentslipdate)=2017 and payrollperiod<10
having selftotal<>checkselftotal
</cfquery>

<h1>selftotal<>checkselftotal</h1>
<h1>#CGI.SERVER_NAME#</h1>
    
<h2>records found: #getdetails.recordcount#</h2>

<br>
<table  border="0" align="center" width="80%" class="data">
    <tr>
        <th>refno</th>
        <th>empno</th>
        <th>payrollperiod</th>
        <th>gross</th>
        <th>EPFWW</th>
        <th>SOCSOWW</th>
        <th>selfsalary</th>
        <th>selftotal</th>
        <th>checkselftotal</th>
    </tr>
    <cfloop query='getdetails'>
    <tr>
        <td>#refno#</td>
        <td>| #empno#</td>
        <td>| #payrollperiod#</td>
        <td>| #gross#</td>
        <td>| #selfcpf#</td>
        <td>| #selfsdf#</td>
        <td>| #selfsalary#</td>
        <td>| #selftotal#</td>
        <td>| #checkselftotal#</td>
    </tr>
    </cfloop>
</table>
    
</cfoutput>