
<cfset custno = URLDecode(url.custno)>
<cfset vehino = URLDecode(url.vehino)>
<cfset refno = URLDecode(url.refno)>

<cfquery name="getitem" datasource="#dts#">
select a.qty-ifnull(b.updatedqty,0) as qty,a.itemno,a.trancode,a.price,a.unit,a.desp,a.despa from ictran as a
left join(select sum(qty) as updatedqty,trancode,frrefno,frtype from servicededuct where type='SAM' and frtype='INV' and frrefno='#url.refno#' group by itemno)as b on a.trancode=b.trancode and a.type=b.frtype and a.refno=b.frrefno
where a.refno='#url.refno#' and a.type='INV' and a.qty-ifnull(b.updatedqty,0) > 0 and a.deductableitem = 'Y'
</cfquery>
<cfoutput>
<table align="center" class="data" width="80%">
<tr>
				<th>Date</th>
				<td colspan="4">
					  <cfoutput><input style="background-color:##FFFF99" type="text" name="f_cdate" size="10" value="#dateformat(now(),"dd/mm/yyyy")#" maxlength="10"> </cfoutput>
					<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(f_cdate);">(DD/MM/YYYY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				</td>
			</tr>
<tr>
<th><div align="left">Item No</div></th>
<th><div align="left">Description</div></th>
<th><div align="left">Remaining Qty</div></th>
<th><div align="left">Qty</div></th>
<th><div align="left">Unit</div></th>
<th align="right">Price</th>

</tr>
<cfloop query="getitem">
<tr>
<td>#getitem.itemno#</td>
<td>#getitem.desp# #getitem.despa#</td>
<td>#getitem.qty#<input type="hidden" name="remainqty_#trancode#" id="remainqty_#trancode#" value="#getitem.qty#" /></td>
<td><input type="text" name="fulfillqty_#trancode#" id="fulfillqty_#trancode#" value="0" onblur="if((document.getElementById('fulfillqty_#trancode#').value*1) > (document.getElementById('remainqty_#trancode#').value*1)){alert('Qty key in is more than Remaining Qty');document.getElementById('fulfillqty_#trancode#').value=0;}" /></td>
<td>#getitem.unit#</td>
<td align="right">#numberformat(getitem.price,',_.__')#</td>
</tr>
</cfloop>

</table>
</cfoutput>