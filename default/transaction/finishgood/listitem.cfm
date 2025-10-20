<cfif url.refno eq "">
<cfabort />
</cfif>
<cfsetting showdebugoutput="no">
<cfoutput>
<cfquery name="getgeneral" datasource="#dts#">
	select filterall,displayaitemno from gsetup
</cfquery>

<table width="90%">
<tr>
<th width="200px">Item No</th>
<th width="200px">Product Code</th>
<th width="100px">Job No</th>
<th width="100px">Heat No</th>
<th width="100px">Status</th>
<th width="120px">SI Quantity</th>
<th width="100px">Used Quantity</th>
<th width="120px">Reject Quantity</th>
<th width="120px">Reject Code</th>
<th width="120px">Return Quantity</th>
<th width="120px">Write Off Quantity</th>
</tr>
<cfquery name="getictran" datasource="#dts#">
select a.qty-coalesce(b.usedqty,0)-coalesce(b.writeoffqty,0) as qty,a.itemno,a.refno,a.type,a.batchcode,a.job,a.brem1,a.trancode from (
select itemno,batchcode,job,brem1,trancode,refno,type,sum(qty) as qty from ictran where 
source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDecode(url.refno)#"> 
and fperiod<>'99'
and (void = '' or void is null)
and (linecode <> 'SV' or linecode is null)
and type = "inv"
<cfif url.itemno neq ''>and itemno in (select bmitemno from billmat where itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDecode(url.itemno)#"> and project=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDecode(url.refno)#">)</cfif>
group by itemno,batchcode
) as a
left join (select sum(usedqty) as usedqty,sum(writeoffqty) as writeoffqty,trancode,batchcode,itemno,refno,type from finishedgoodic where 
project = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDecode(url.refno)#"> group by itemno,batchcode ) as b
on a.itemno = b.itemno and a.batchcode=b.batchcode
</cfquery>
<cfloop query="getictran">
<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td>#getictran.itemno#</td>
<cfquery name="getitemproductcode" datasource="#dts#">
select aitemno from icitem where itemno='#getictran.itemno#'
</cfquery>
<td>#getitemproductcode.aitemno#</td>
<td>#getictran.job#</td>
<td>#getictran.brem1#</td>
<td>
<cfset fieldname = "_#trim(getictran.itemno)#_#getictran.batchcode#">
<cfset fieldname = replace(fieldname,'-','_','all')>
<cfset fieldname = replace(fieldname,'+','_','all')>
<select name="status#fieldname#" id="status#fieldname#" onchange="if(this.value == 'partial'){document.getElementById('returnqty#fieldname#').disabled=true;document.getElementById('returnqty#fieldname#').style.display='none';}else{document.getElementById('returnqty#fieldname#').disabled=false;document.getElementById('returnqty#fieldname#').style.display='block';}">
<option value="partial" selected="selected">Partial</option>
<option value="finish">Finish</option>
</select>
</td>
<td>#getictran.qty#<input type="hidden" name="maxqty#fieldname#" id="maxqty#fieldname#" value="#getictran.qty#" /></td>
<td><input type="text" name="usedqty#fieldname#" id="usedqty#fieldname#" value="0" onblur="validateqty(this.id)" /></td> 
<td><input type="text" name="rejectqty#fieldname#" id="rejectqty#fieldname#" value="0" /></td>
<cfif getgeneral.displayaitemno eq 'Y'>
<cfquery name="getitem" datasource="#dts#">
SELECT "" as itemno, "Choose an Item" as desp
union all
select itemno, aitemno as desp from icitem order by itemno
</cfquery>
<cfelse>
<cfquery name="getitem" datasource="#dts#">
SELECT "" as itemno, "Choose an Item" as desp
union all
select itemno, itemno as desp from icitem order by itemno
</cfquery>
</cfif>
<td><select name="rejectcode#fieldname#" id="rejectcode#fieldname#">
<cfloop query="getitem">
<option value="#getitem.itemno#">#getitem.desp#</option>
</cfloop>
</select></td>
<td><input type="text" name="returnqty#fieldname#" id="returnqty#fieldname#" value="0" /></td>
<td><input type="text" name="writeoffqty#fieldname#" id="writeoffqty#fieldname#" value="0" /></td>
</tr>
</cfloop>
</table>
</cfoutput>