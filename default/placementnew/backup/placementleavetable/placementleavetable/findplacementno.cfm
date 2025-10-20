
<cfoutput>
<cfset nametype = url.type>

	<cfquery name="getitemno" datasource="#dts#">
   		select placementno as xplacementno, claimdate as xclaimdate from placementleave limit 15
	</cfquery>
    <div id="ajaxField" name="ajaxField">
    <table width="380px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(nametype)# NO</font></th>
    <th width="100px"><font style="text-transform:uppercase">LEAVE DATE</font></th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno">
    <tr>
    <td>#getitemno.xplacementno#</td>
    <td>#dateformat(getitemno.xclaimdate,'DD/MM/YYYY')#</td>
    <td><a style="cursor:pointer" onClick="document.getElementById('placementno').value='#getitemno.xplacementno#';document.getElementById('claimdate').value='#dateformat(getitemno.xclaimdate,'DD/MM/YYYY')#';ColdFusion.Window.hide('findplacementno');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>    
    </table>
    </div>
    </cfoutput>