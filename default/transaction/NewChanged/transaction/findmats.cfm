<cfoutput>

	<cfquery name="getbomcomment" datasource="#dts#">
   		Select bomno,itemno from billmat where itemno='#url.itemno#' group by bomno
	</cfquery>
    
    <table width="680px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">Bomno</font></th>
    <th width="100px">BOM ITEMS</th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getbomcomment" >
    <cfset bomcomment=''>
    <cfquery name="getbomcomment2" datasource="#dts#">
   		Select bmitemno from billmat where itemno='#getbomcomment.itemno#' and bomno='#getbomcomment.bomno#'
	</cfquery>
    <tr>
    <td>#getbomcomment.bomno#</td>
    <td><cfloop query="getbomcomment2"><cfif bomcomment eq ''><cfset bomcomment=getbomcomment2.bmitemno><cfelse><cfset bomcomment=bomcomment&','&getbomcomment2.bmitemno></cfif></cfloop>#bomcomment#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('comm5').value = '#bomcomment#';ColdFusion.Window.hide('findmats');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </cfoutput>