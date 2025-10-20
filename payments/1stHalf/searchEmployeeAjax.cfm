

<cfset keyword = url.keyword >

<cfquery name="searchKey" datasource="#dts#">
select * from ( SELECT * FROM pmast as a left join (select empno as empno1,payyes from paytra1) as b on a.empno = b.empno1 WHERE a.paystatus = "A"  and a.confid >= #hpin# and b.payyes = "Y")as pm 
where empno LIKE "%#keyword#%" or name LIKE "%#keyword#%"
order by length(pm.empno), pm.empno
</cfquery>

<cfoutput>
<table>
<cfloop query="searchKey">
<tr>
<td>#searchKey.empno#</td>
<td>#searchKey.name#</td>
<td><a href="viewPaySlipForm.cfm?empno=#searchKey.empno#">SELECT</a></td>
</tr>
</cfloop>
</table>
</cfoutput>
