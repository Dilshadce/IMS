
	<cfquery name="getitemno" datasource="#dts#">
   		select voucherno from voucher WHERE voucherno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.voucher#%"> order by voucherno limit 500
	</cfquery>
	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">#UCASE(url.nametype)# NO</font></th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitemno" >
    
    <tr>
    <td>#getitemno.voucherno#</td>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="selectlist('#getitemno.voucherno#','voucher#url.fromto#');ColdFusion.Window.hide('findvoucher');" >SELECT</a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>