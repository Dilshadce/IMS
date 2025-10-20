<cfset url.filtertext = trim(urldecode(url.filtertext))>

<cfquery name="getitem" datasource="#dts#">
	SELECT * FROM(
    SELECT itemno,desp,unit,qtybf,ucost,avcost,avcost2 
	FROM icitem 
    WHERE 1=1
    <cfif filtertype neq "">
    AND #url.filtertype# like "%#url.filtertext#%"
    </cfif>
    order by itemno)as a
    limit <cfif page eq 1>10<cfelse>#((page-1)*10)#,10</cfif>
    ;
</cfquery>


<cfquery name="getpage" datasource="#dts#">
	SELECT itemno
	FROM icitem 
    WHERE 1=1
    <cfif filtertype neq "">
    AND #url.filtertype# like "%#url.filtertext#%"
    </cfif>
    order by itemno;
</cfquery>

<cfset totalpagenumber=ceiling(getpage.recordcount/10)>

<cfoutput>
<table align="center" width="100%">
<tr>
<th width="25%"><div align="left">Item No</div></th>
<th width="40%"><div align="left">Description</div></th>
<th width="5%"><div align="left">Unit Of Measurement</div></th>
<th width="5%"><div align="left">Qty B/F</div></th>
<th width="5%"><div align="left">Fixed Cost</div></th>
<th width="5%"><div align="left">Mth. Av. Cost</div></th>
<th width="5%"><div align="left">Mov/Weg Av. Cost</div></th>
<th width="10%"><div align="center">Fifo Tab</div></th>
</tr>
<cfloop query="getitem">
<tr>
<td>#itemno#</td>
<td>#desp#</td>
<td>#unit#</td>
<td><input type="text" name="qtybf" id="qtybf" value="#qtybf#" size="4" onChange="updatevalue('qtybf','#getitem.itemno#',this.value)"></td>
<td><input type="text" name="ucost" id="ucost" value="#ucost#" size="4" onChange="updatevalue('ucost','#getitem.itemno#',this.value)"></td>
<td><input type="text" name="avcost" id="avcost" value="#avcost#" size="4" onChange="updatevalue('avcost','#getitem.itemno#',this.value)"></td>
<td><input type="text" name="avcost2" id="avcost2" value="#avcost2#" size="4" onChange="updatevalue('avcost2','#getitem.itemno#',this.value)"></td>
<td align="center"><input type="button" name="fifotab" id="fifotab" value="FIFO Tab" onClick="window.open('fifoopqnew1.cfm?itemno=#URLEncodedFormat(itemno)#','','','_blank')"></td>

</tr>
</cfloop>
<tr>
<td colspan="100%"><hr></td>
</tr>
<tr>
<td><input type="button" name="backbutton" id="backbutton" value="Back" id="filterbutton" onClick="document.getElementById('pagenumber').value=(document.getElementById('pagenumber').value*1)-1;changepagefilter(document.getElementById('pagenumber').value);"></td>
<td align="center" colspan="6">Page <input type="text" name="pagenumber" id="pagenumber" value="#val(url.page)#" size="3" onBlur="changepagefilter(this.value);"> of #totalpagenumber# <input type="button" name="filterbutton" value="Go" id="filterbutton" onClick=""></td>
<td align="right"><input type="button" name="backbutton" id="backbutton" value="Next" id="filterbutton" onClick="document.getElementById('pagenumber').value=(document.getElementById('pagenumber').value*1)+1;changepagefilter(document.getElementById('pagenumber').value);"></td>
</tr>

</table>
</cfoutput>
