<cfsetting showdebugoutput="no">
<cfquery name="getprojectitem" datasource="#dts#">
select a.source,a.itemno,a.desp,a.qty,a.exceedqty,b.usedqty from projectdetail as a
left join (select sum(qty) as usedqty,itemno,source from ictran where source="#url.project#" and type="RQ" and (void="" or void is null) group by itemno)as b on a.itemno=b.itemno and a.source=b.source
where a.source="#url.project#"
</cfquery>

<cfoutput>
<table width="100%">
<tr>
<th width="20%">Item No</th>
<th width="40%">Description</th>
<th ><div align="center">Qty</div></th>
<th ><div align="center">Exceed Qty</div></th>
<th ><div align="center">Used Qty</div></th>
<th ><div align="center">Balance Qty</div></th>
</tr>

<cfloop query="getprojectitem">
<tr>
<td width="20%">#getprojectitem.itemno#</td>
<td >#getprojectitem.desp#</td>
<td ><div align="center">#getprojectitem.qty#</div></td>
<td ><div align="center">#getprojectitem.exceedqty#</div></td>
<td ><div align="center">#getprojectitem.usedqty#</div></td>
<td ><div align="center">#val(getprojectitem.qty)+val(getprojectitem.exceedqty)-val(getprojectitem.usedqty)#</div></td>
</tr>
</cfloop>
</table>
</cfoutput>
