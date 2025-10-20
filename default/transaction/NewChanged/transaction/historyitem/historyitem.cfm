<cfoutput>
	<cfquery name="getitem" datasource="#dts#">
   			select a.itemno,a.desp,a.despa,a.brand,a.wos_group,a.category,a.price,a.nonstkitem from icitem a,ictran b where a.itemno=b.itemno and b.custno = '#url.custno#' group by b.itemno order by b.wos_date desc,b.itemno desc limit 30
	</cfquery>
    <font style="text-transform:uppercase">ITEM NO.</font>&nbsp;<input type="text" name="itemno1" id="itemno1" onKeyUp="ajaxFunction(document.getElementById('ajaxFieldHis'),'/default/transaction/historyitem/historyitemajax.cfm?itemno='+document.getElementById('itemno1').value+'&itemname='+document.getElementById('itemname1').value+'&custno=#url.custno#');"  />&nbsp;&nbsp;NAME:&nbsp;<input type="text" name="itemname1" id="itemname1" onKeyUp="ajaxFunction(document.getElementById('ajaxFieldHis'),'/default/transaction/historyitem/historyitemajax.cfm?itemno='+document.getElementById('itemno1').value+'&itemname='+document.getElementById('itemname1').value+'&custno=#url.custno#');" />
    <div id="ajaxFieldHis" name="ajaxFieldHis">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">ITEM NO</font></th>
    <th width="300px">NAME</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitem" >
    <tr>
    <td>#getitem.itemno#</td>
    <td>#getitem.desp#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="JavaScript:selectitem('#URLEncodedFormat(getitem.itemno)#');ColdFusion.Window.hide('historyitem');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>