	<cfquery name="getitem1" datasource="#dts#">
    select a.itemno,a.desp,a.despa,a.brand,a.wos_group,a.category,a.price,a.nonstkitem from icitem a,ictran b where a.itemno=b.itemno and b.custno = '#url.custno#' and a.itemno like "%#url.itemno#%" and a.desp like "%#url.itemname#%" group by b.itemno order by b.wos_date desc,b.itemno desc limit 30
   
	</cfquery>
    
	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">ITEM NO</font></th>
    <th width="300px">NAME</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitem1" >
    <tr>
    <td>#getitem1.itemno#</td>
    <td>#getitem1.desp#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectitem('#URLEncodedFormat(getitem1.itemno)#');ColdFusion.Window.hide('historyitem');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>