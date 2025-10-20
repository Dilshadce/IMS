	<cfquery name="getitem1" datasource="#dts#">
    select itemno,desp from icitem WHERE itemno like "%#url.itemno#%" and desp like "%#url.itemname#%"
    <cfif Hitemgroup neq ''>
            and wos_group='#Hitemgroup#'
    </cfif>
     order by itemno limit 500
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
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('itm6').value='#getitem1.itemno#';ColdFusion.Window.hide('searchitem');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>