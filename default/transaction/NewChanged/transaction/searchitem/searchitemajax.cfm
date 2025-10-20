	<cfquery name="getitem1" datasource="#dts#">
    select itemno,desp from icitem WHERE <cfif url.itemname eq 'all'>(itemno like "%#url.itemno#%" or desp like "%#url.itemno#%" or wos_group like "%#url.itemno#%" or category like "%#url.itemno#%" or aitemno like "%#url.itemno#%" or brand like "%#url.itemno#%" or barcode like "%#url.itemno#%" or sizeid like "%#url.itemno#%" or costcode like "%#url.itemno#%" or colorid like "%#url.itemno#%" or shelf like "%#url.itemno#%")<cfelse>#url.itemname# like "%#url.itemno#%"</cfif>
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
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectitem('#URLEncodedFormat(getitem1.itemno)#');ColdFusion.Window.hide('searchitem');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>