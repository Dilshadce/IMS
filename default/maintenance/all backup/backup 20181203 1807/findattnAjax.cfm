<cfquery name="getitemformat" datasource="#dts#">
select itemformat from dealer_menu
</cfquery>



	<cfquery name="getattn" datasource="#dts#">
   		select attentionno,name from attention WHERE attentionno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.itemno#%"> and name like <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.custname#%"> and name like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.leftcustname#%"> order by attentionno limit 500
	</cfquery>
    


	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(url.nametype)# NO</font></th>
    <th width="300px">DESP</th>
    <th width="80px">ACTION</th>
    </tr>
    
    <cfloop query="getattn" >
    
    <tr>
    <td>#getattn.attentionno#</td>
    <td>#getattn.name#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getattn.attentionno#','#url.nametype#');ColdFusion.Window.hide('findattn');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>