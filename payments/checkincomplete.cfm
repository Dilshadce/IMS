<cfset dts = replace(dts,'_i','_p')>
<cfif url.paytype eq "1">
<cfset datatbl = "paytra1">
<cfelse>
<cfset datatbl = "paytran">
</cfif>
<cfquery name="getlist" datasource="#dts#">
SELECT * FROM #datatbl# as c left join pmast as p on c.empno = p.empno where c.netpay <> "0" 
and p.bankaccno <> "" and paymeth ="B" and p.bankcat = "#url.bankcat#" 
and c.payyes = "y"
and (c.netpay = 0 or p.bankcode = "" or p.brancode = "" or p.bankaccno = "" and p.name = "")
order by p.empno
</cfquery>
<cfoutput>
<table border="1">
<tr>
<th width="100px">Empno</th>
<th width="200px">Name</th>
<th width="100px" align="right">Netpay</th>
<th width="100px" align="right">Bank Code</th>
<th width="100px" align="right">Branch Code</th>
<th width="100px" align="right">Bank Accno</th>
</tr>
<cfloop query="getlist">
<tr>
<td>#getlist.empno#</td>
<td <cfif getlist.name eq "">bgcolor="##FF0000" </cfif>>#getlist.name#</td>
<td align="right" <cfif val(getlist.netpay) eq 0>bgcolor="##FF0000" </cfif>>#numberformat(val(getlist.netpay),'.__')#</td>
<td align="right" <cfif getlist.bankcode eq "">bgcolor="##FF0000" </cfif>>#getlist.bankcode#</td>
<td align="right" <cfif getlist.brancode eq "">bgcolor="##FF0000" </cfif>>#getlist.brancode#</td>
<td align="right" <cfif getlist.bankaccno eq "">bgcolor="##FF0000" </cfif>>#getlist.bankaccno#</td>
</tr>
</cfloop>
</table>
</cfoutput>