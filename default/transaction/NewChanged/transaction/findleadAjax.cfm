<cfset crmdts=replace(dts,'_i','_c','all')>

<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">

<cfquery name="getdummycust" datasource="#dts#">
   		select dummycust from gsetup
</cfquery>
	<cfquery name="getlead" datasource="#crmdts#">
   		select * from lead 
        WHERE accountno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custno#%"> and leadname like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#url.custname#%"> and leadname like <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.leftcustname#%">
        order by id
		limit 15
	</cfquery>
   		
	<cfoutput>  
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">Lead ID</font></th>
    <th><font style="text-transform:uppercase">Lead Name</font></th>
    <th width="100px"><font style="text-transform:uppercase">Account No</font></th>
    <!---<th width="200px">LEAD STATUS</th>--->
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getlead" >
    
    <tr>
    <td>#getlead.id#</td>
    <td nowrap>#getlead.leadname#</td>
    <td>#getlead.accountno#</td>
    <!---<td>#getlead.leadstatus#</td>--->
    <input type="hidden" name="hidleadname" id="hidleadname" value="#convertquote(getlead.leadname)#" />
    <cfif getlead.accountno eq ''>
    <cfset getlead.accountno='#getdummycust.dummycust#'>
    
    </cfif>
     <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('custno').value='#convertquote(getlead.accountno)#';document.getElementById('leadno').value='#convertquote(getlead.id)#';document.getElementById('name').value=document.getElementById('hidleadname').value;document.getElementById('BCode').value='';document.getElementById('DCode').value='';document.getElementById('b_name').value=document.getElementById('hidleadname').value;document.getElementById('d_name').value=document.getElementById('hidleadname').value;document.getElementById('b_add1').value='#convertquote(getlead.add1)#';document.getElementById('b_add2').value='#convertquote(getlead.add2)#';document.getElementById('b_add3').value='#convertquote(getlead.add3)#';document.getElementById('b_add4').value='#convertquote(getlead.add4)#';document.getElementById('d_add1').value='#convertquote(getlead.daddr1)#';document.getElementById('d_add2').value='#convertquote(getlead.daddr2)#';document.getElementById('d_add3').value='#convertquote(getlead.daddr3)#';document.getElementById('d_add4').value='#convertquote(getlead.daddr4)#';document.getElementById('b_attn').value='#convertquote(getlead.attn)#';document.getElementById('d_attn').value='#convertquote(getlead.d_attn)#';document.getElementById('b_phone').value='#getlead.phone#';document.getElementById('b_phone2').value='#getlead.phonea#';document.getElementById('d_phone').value='#getlead.d_phone#';document.getElementById('d_phone2').value='#getlead.d_phonea#';document.getElementById('b_email').value='#getlead.email#';document.getElementById('d_email').value='#getlead.d_email#';document.getElementById('b_fax').value='#getlead.fax#';document.getElementById('d_fax').value='#getlead.d_fax#';ColdFusion.Window.hide('findlead');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>