<cfsetting showdebugoutput="no">
<cfset custno = URLDecode(url.custno)>
<cfset vehino = URLDecode(url.vehino)>

<cfquery name="getrefno2" datasource="#dts#">
select a.refno from ictran as a
left join (select sum(qty) as updatedqty,trancode,frrefno,frtype from servicededuct where type='SAM' and frtype='INV' group by itemno)as b on a.trancode=b.trancode and a.type=b.frtype and a.refno=b.frrefno
left join (select rem5,refno,type from artran)as c on a.refno=c.refno and a.type=c.type
where a.type='INV' and a.qty-ifnull(b.updatedqty,0) > 0 and a.deductableitem = 'Y' and a.custno='#custno#' and c.rem5='#vehino#' group by a.refno
</cfquery>
<cfoutput>
<select name="refno" id="refno" onChange="ajaxFunction(document.getElementById('itemajax'),'/default/transaction/getserdeduct_itemajax.cfm?custno='+escape(document.getElementById('custno').value)+'&vehino='+escape(document.getElementById('vehicleno').value)+'&refno='+escape(document.getElementById('refno').value));">
<option value="">Choose a Ref No</option>
<cfloop query="getrefno2">
<option value="#getrefno2.refno#">#getrefno2.refno#</option>
</cfloop>
</select>
</cfoutput>