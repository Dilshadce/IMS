<cfset dts2=replace(dts,'_i','_a','all')>
<cfquery name="getglacc" datasource="#dts2#">
   		select accno,desp,desp2 ,acc_code
	from gldata 
	where accno not in (select custno from arcust order by custno) 
	and accno not in (select custno from apvend order by custno)
    and accno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custno#%"> 
    and desp like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.desp#%">
    and acc_code like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.desp2#%">
    
    order by accno
		limit 15
	</cfquery>
   		
	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">Gl Account</font></th>
    <th><font style="text-transform:uppercase">Description</font></th>
    <th><font style="text-transform:uppercase">Old Account No</font></th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getglacc" >
    
    <tr>
    <td>#getglacc.accno#</td>
    <td nowrap>#getglacc.desp# #getglacc.desp2#</td>
   	<td nowrap>#getglacc.acc_code#</td>
     <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('SALECNC').value='#getglacc.accno#';ColdFusion.Window.hide('findcateglacc3');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>