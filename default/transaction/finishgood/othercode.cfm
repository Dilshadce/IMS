<cfoutput>
<cfform action="processothercode.cfm" method="post" name="othercode">
<cfset othercodeuuid = createuuid()>
<input type="hidden" name="othercodeuuid" id="othercodeuuid" value="#othercodeuuid#" > 
<h1>Add Other Code</h1>
<table width="800">
<tr>
<th width="100px">Itemno</th>
<td width="20px">:</td>
<td >
<cfquery name="getitem" datasource="#dts#">
select itemno, concat(itemno,' - ',desp) as desp from icitem order by itemno
</cfquery>
<cfselect name="othercodeitemno" id="othercodeitemno" query="getitem" value="itemno" display="desp"></cfselect>
</td>
</tr>
<tr>
<th>Quantity</th>
<td>:</td>
<td w><input type="text" name="qtyothercode" id="qtyothercode" value="0" />&nbsp;&nbsp;&nbsp;<input type="button" name="addbtn" id="addbtn" value="Add" onClick="ajaxFunction(document.getElementById('othercodefield'),'othercodeprocess.cfm?type=add&id=#url.id#&otheruuid=#othercodeuuid#&itemno='+escape(document.getElementById('othercodeitemno').value)+'&qty='+document.getElementById('qtyothercode').value);" /></td>
</tr> 
</table>
<div id="othercodefield">

</div>
<br/>
<br/>
<br/>
<h1>Previous Generated Other Code Receive</h1>
<cfquery name="getlist" datasource="#dts#">
SELECT * FROM finishedgoodothercode where fgic = "#url.id#" order by wos_date,refno
</cfquery>
<table>
<tr>
<th>Receive No</th>
<th>Date</th>
</tr>
<cfloop query="getlist">
<tr>
<td>#getlist.refno#</td>
<td>#dateformat(getlist.wos_date,'YYYY-MM-DD')#</td>
</tr>
</cfloop>
</table>
</cfform>
</cfoutput>