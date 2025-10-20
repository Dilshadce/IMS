<cfif isdefined('form.location')>
<cfif location eq "GWC">
<cfset fieldtype = "remark6">
<cfelseif location eq "RF">
<cfset fieldtype = "remark7">
<cfelseif location eq "pp">
<cfset fieldtype = "remark8">
<cfelseif location eq "mbs">
<cfset fieldtype = "remark9">
<cfelseif location eq "stock">
<cfset fieldtype = "remark10">
<cfelse>
<cfset fieldtype = "remark11">
</cfif>

<cfquery name="getitem" datasource="#dts#">
SELECT a.itemno,coalesce(a.qtybf,0) + coalesce(b.inqty,0) - coalesce(c.sqty,0) as posqty,a.serverval FROM (
SELECT itemno,#fieldtype# as serverval,qtybf FROM icitem order by itemno) as a

left join
(
select itemno,sum(qty) as inqty
				from ictran
				where type in ('INV','DO','DN','PR','CS','ISS','OAR','TROU','CT')
				and fperiod <> '99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
group by itemno
)
as b
on a.itemno = b.itemno
LEFT JOIN
(
select itemno,sum(qty) as sqty
				from ictran
				where type in ('INV','CS','DN')
				and fperiod <> '99'
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
group by itemno) as c
on a.itemno = c.itemno
WHERE
coalesce(a.qtybf,0) + coalesce(b.inqty,0) - coalesce(c.sqty,0) <> coalesce(a.serverval,0)
</cfquery>
<h1>Not Tally Item</h1>
<table>
<tr>
<th>Itemno</th>
<th>POS Qty</th>
<th>Server Qty</th>
</tr>
<cfloop query="getitem">
<tr>
<td>#getitem.itemno#</td>
<td>#getitem.posqty#</td>
<td>#getitem.serverval#</td>
</tr>
</cfloop>
</table>

</cfif>

<cfform name="form1" id="form1" action="" method="post">
<input type="text" name="location" id="location" value="">
<input type="submit" name="sub_btn" id="sub_btn" value="Check">
</cfform>