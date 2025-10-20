<cfsetting showdebugoutput="no">
<cfset custno = URLDecode(url.custno)>

<cfquery name="getvehicle2" datasource="#dts#">
select c.rem5 from ictran as a
left join (select sum(qty) as updatedqty,trancode,frrefno,frtype from servicededuct where type='SAM' and frtype='INV' group by itemno)as b on a.trancode=b.trancode and a.type=b.frtype and a.refno=b.frrefno
left join (select rem5,refno,type from artran)as c on a.refno=c.refno and a.type=c.type
where a.type='INV' and a.qty-ifnull(b.updatedqty,0) > 0 and a.deductableitem = 'Y' and a.custno='#custno#' group by c.rem5
</cfquery>
<cfoutput>
<select name="vehicleno" id="vehicleno" onChange="ajaxFunction(document.getElementById('refnoajax'),'/default/transaction/getserdeduct_refnoajax.cfm?custno='+escape(document.getElementById('custno').value)+'&vehino='+escape(document.getElementById('vehicleno').value));">
<option value="">Choose a Vehicle No</option>
<cfloop query="getvehicle2">
<option value="#getvehicle2.rem5#">#getvehicle2.rem5#</option>
</cfloop>
</select>
</cfoutput>