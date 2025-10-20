<cfsetting showdebugoutput="no">

<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfif url.sort eq 'wos_date'>
<cfif url.datefrom eq ''>
<cfset url.datefrom='01/01/1990'>
</cfif>
<cfif url.dateto eq ''>
<cfset url.dateto='01/01/1990'>
</cfif>
</cfif>

<cfif url.sort eq 'wos_date'>
<cfset ndatefrom=createdate(right(url.datefrom,4),mid(url.datefrom,4,2),left(url.datefrom,2))>
<cfset ndateto=createdate(right(url.dateto,4),mid(url.dateto,4,2),left(url.dateto,2))>
</cfif>


<cfquery name="getdeposit" datasource="#dts#">
select * from deposit where (posted='' or posted is null)
<cfif url.sort eq 'wos_date'>
and wos_date between '#dateformat(ndatefrom,'yyyy-mm-dd')#' and '#dateformat(ndateto,'yyyy-mm-dd')#'
<cfelseif url.sort eq 'fperiod'>
and fperiod='#url.fperiod#'
<cfelseif url.sort eq 'sono'>
and sono between '#url.sonofrom#' and '#url.sonoto#'
<cfelseif url.sort eq 'depositno'>
and depositno between '#url.depositfrom#' and '#url.depositto#'
</cfif>

</cfquery>
<cfoutput>

<table width="100%">
<tr><td colspan="100%" align="center"><input type="button" name="sub_btn" id="sub_btn" value="Post" onclick="postdepositform.submit();" /></td></tr>
<tr>
<th><div align="left">Reference No</div></th>
<th><div align="left">Date</th>
<th>Debit Amount</th>
<th>Credit Amount</th>
<th>GST/Disc</th>
<th><div align="left">Period</div></th>
<th><div align="left">Account</div></th>
<th><div align="left">Column</div></th>
<th><div align="left">Customer</div></th>
</tr>
<cfloop query="getdeposit">
<cfquery name="checkinvposted" datasource="#dts#">
	SELECT posted,refno from artran where depositno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getdeposit.depositno#"> and type="INV"
</cfquery>

<cfif checkinvposted.posted neq "">
<tr><td>Invoice No : #checkinvposted.refno# For Deposit :#getdeposit.depositno# is already posted.</td></tr>
<cfelse>

<cfif getdeposit.cs_pm_cash neq 0>
<tr>
<td>#getdeposit.depositno#</td>
<td>#dateformat(getdeposit.wos_date,'dd/mm/yyyy')#</td>
<td align="right">#numberformat(getdeposit.cs_pm_cash,'.__')#</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>#getdeposit.fperiod#</td>
<td>#getgsetup.cashaccount#</td>
<td>D</td>
<td>#getdeposit.custno#</td>
</tr>
</cfif>

<cfif getdeposit.cs_pm_crcd neq 0>
<tr>
<td>#getdeposit.depositno#</td>
<td>#dateformat(getdeposit.wos_date,'dd/mm/yyyy')#</td>
<td align="right">#numberformat(getdeposit.cs_pm_crcd,'.__')#</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>#getdeposit.fperiod#</td>
<td>#getgsetup.creditcardaccount1#</td>
<td>D</td>
<td>#getdeposit.custno#</td>
</tr>
</cfif>

<cfif getdeposit.cs_pm_crc2 neq 0>
<tr>
<td>#getdeposit.depositno#</td>
<td>#dateformat(getdeposit.wos_date,'dd/mm/yyyy')#</td>
<td align="right">#numberformat(getdeposit.cs_pm_crc2,".__")#</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>#getdeposit.fperiod#</td>
<td>#getgsetup.creditcardaccount2#</td>
<td>D</td>
<td>#getdeposit.custno#</td>
</tr>
</cfif>

<cfif getdeposit.cs_pm_dbcd neq 0>
<tr>
<td>#getdeposit.depositno#</td>
<td>#dateformat(getdeposit.wos_date,'dd/mm/yyyy')#</td>
<td align="right">#numberformat(getdeposit.cs_pm_dbcd,".__")#</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>#getdeposit.fperiod#</td>
<td>#getgsetup.debitcardaccount#</td>
<td>D</td>
<td>#getdeposit.custno#</td>
</tr>
</cfif>

<cfif getdeposit.cs_pm_cheq neq 0>
<tr>
<td>#getdeposit.depositno#</td>
<td>#dateformat(getdeposit.wos_date,'dd/mm/yyyy')#</td>
<td align="right">#numberformat(getdeposit.cs_pm_cheq,".__")#</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>#getdeposit.fperiod#</td>
<td>#getgsetup.chequeaccount#</td>
<td>D</td>
<td>#getdeposit.custno#</td>
</tr>
</cfif>

<cfif getdeposit.cs_pm_vouc neq 0>
<tr>
<td>#getdeposit.depositno#</td>
<td>#dateformat(getdeposit.wos_date,'dd/mm/yyyy')#</td>
<td align="right">#numberformat(getdeposit.cs_pm_vouc,".__")#</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>#getdeposit.fperiod#</td>
<td>#getgsetup.cashvoucheraccount#</td>
<td>D</td>
<td>#getdeposit.custno#</td>
</tr>
</cfif>

<tr>
<td>#getdeposit.depositno#</td>
<td>#dateformat(getdeposit.wos_date,'dd/mm/yyyy')#</td>
<td>&nbsp;</td>
<td align="right">#numberformat((((getdeposit.cs_pm_cash+getdeposit.cs_pm_cheq+getdeposit.cs_pm_crcd+getdeposit.cs_pm_crc2+getdeposit.cs_pm_dbcd+getdeposit.cs_pm_vouc)*getdeposit.ptax)/(100+val(getdeposit.ptax))),".__")#</td>
<td>&nbsp;</td>
<td>#getdeposit.fperiod#</td>
<td>#getgsetup.gstsales#</td>
<td>Cr</td>
<td>#getdeposit.custno#</td>
</tr>

<tr>
<td>#getdeposit.depositno#</td>
<td>#dateformat(getdeposit.wos_date,'dd/mm/yyyy')#</td>
<td>&nbsp;</td>
<td align="right">#numberformat((((getdeposit.cs_pm_cash+getdeposit.cs_pm_cheq+getdeposit.cs_pm_crcd+getdeposit.cs_pm_crc2+getdeposit.cs_pm_dbcd+getdeposit.cs_pm_vouc)*100)/(100+val(getdeposit.ptax))),".__")#</td>
<td>&nbsp;</td>
<td>#getdeposit.fperiod#</td>
<td>#getgsetup.bankaccount#</td>
<td>Cr</td>
<td>#getdeposit.custno#</td>
</tr>
</cfif>
</cfloop>
</table>
</cfoutput>

