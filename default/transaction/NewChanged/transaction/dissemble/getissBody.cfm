<cfsetting showdebugoutput="no">
<cfoutput>

<cfquery datasource="#dts#" name="getlocation">
	select 
	location,
	desp 
	from iclocation 
    where 0=0
    <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Cust Svr' and HUserGrpID neq 'Van Sales')>
    <cfelse>
    <cfif Huserloc neq "All_loc">
	and location='#Huserloc#'
	</cfif>
    </cfif>
	order by location;
</cfquery>

<cfset uuid = url.uuid>
<table>
        <tr>
        <th>No</th>
        <th >Item No</th>
        <th >Description</th>
        <th >Location</th>
        <th >Qty</th>
        <th >Price</th>
        <th>Amount</th>
        
        <th width="10%">Action</th>
        </tr>
        <cfquery name="getissuetemp" datasource="#dts#">
        SELECT * FROM issuetemp WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> order by trancode desc
        </cfquery>
        <cfloop query="getissuetemp">
        <tr <cfif (getissuetemp.currentrow mod 2) eq 0>style="background-color:##33FFFF"</cfif> onMouseOut="javascript:this.style.backgroundColor='<cfif (getissuetemp.currentrow mod 2) eq 0>33FFFF</cfif>';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        <td nowrap>#getissuetemp.currentrow#</td>
        <td nowrap>#getissuetemp.itemno#</td>
        <td nowrap>#getissuetemp.desp#</td>
        <td>
        <select name="coltypelist#getissuetemp.trancode#" id="coltypelist#getissuetemp.trancode#" onChange="updaterow('#getissuetemp.trancode#');">
<option value="">Choose a location</option>
<cfloop query="getlocation">
<option value="#getlocation.location#" <cfif getissuetemp.location eq getlocation.location>selected</cfif>>#getlocation.location#</option>
</cfloop>
</select>
        </td>
        <td nowrap><input type="text" name="qtylist#getissuetemp.trancode#" id="qtylist#getissuetemp.trancode#" value="#val(getissuetemp.qty_bil)#" size="5" onBlur="updaterow('#getissuetemp.trancode#');" onKeyup="if(this.value != '#val(getissuetemp.qty_bil)#'){document.getElementById('updatebtn#getissuetemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getissuetemp.trancode#').style.display='none';}"><input type="button" name="issbatchbtn" id="issbatchbtn" value="B" onClick="document.getElementById('issbatchtrancode').value='#getissuetemp.trancode#';ColdFusion.Window.show('issbatch');" ></td>
        <td nowrap><input type="text" name="pricelist#getissuetemp.trancode#" id="pricelist#getissuetemp.trancode#" value="#val(getissuetemp.price_bil)#" size="10" onBlur="updaterow('#getissuetemp.trancode#');" onKeyup="if(this.value != '#val(getissuetemp.price_bil)#'){document.getElementById('updatebtn#getissuetemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getissuetemp.trancode#').style.display='none';}"></td>
        <td nowrap>#getissuetemp.amt#</td>
        <td><input type="button" name="deletebtn#getissuetemp.trancode#" id="deletebtn#getissuetemp.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){deleterow('#getissuetemp.trancode#')}" value="DELETE"/><img id="updatebtn#getissuetemp.trancode#" name="updatebtn#getissuetemp.trancode#" src="/images/tick.gif" width="15" height="15" style="cursor:pointer; display:none;"></td>
        </tr>
        </cfloop>
        
        </table>
</cfoutput>
