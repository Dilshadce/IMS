<cfsetting showdebugoutput="no">

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
<cfoutput>
<cfset uuid = url.uuid>
<table>
        <tr>
        <th>No</th>
        <th >Item No</th>
        <th >Description</th>
        <th>Location</th>
        <th >Qty</th>
        <th >Price</th>
        <th>Amount</th>
        
        <th width="10%">Action</th>
        </tr>
        <cfquery name="getreceivetemp" datasource="#dts#">
        SELECT * FROM receivetemp WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> order by trancode desc
        </cfquery>
        <cfloop query="getreceivetemp">
        <tr <cfif (getreceivetemp.currentrow mod 2) eq 0>style="background-color:##33FFFF"</cfif> onMouseOut="javascript:this.style.backgroundColor='<cfif (getreceivetemp.currentrow mod 2) eq 0>33FFFF</cfif>';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        <td nowrap>#getreceivetemp.currentrow#</td>
        <td nowrap>#getreceivetemp.itemno#</td>
        <td nowrap>#getreceivetemp.desp#</td>
        <td><select name="coltypelist2#getreceivetemp.trancode#" id="coltypelist2#getreceivetemp.trancode#" onChange="updaterow2('#getreceivetemp.trancode#');">
<option value="">Choose a location</option>
<cfloop query="getlocation">
<option value="#getlocation.location#" <cfif getreceivetemp.location eq getlocation.location>selected</cfif>>#getlocation.location#</option>
</cfloop>
</select></td>
        <td nowrap><input type="text" name="qtylist2#getreceivetemp.trancode#" id="qtylist2#getreceivetemp.trancode#" value="#val(getreceivetemp.qty_bil)#" size="5" onBlur="updaterow2('#getreceivetemp.trancode#');" onKeyup="if(this.value != '#val(getreceivetemp.qty_bil)#'){document.getElementById('updatebtn2#getreceivetemp.trancode#').style.display='block';}else{document.getElementById('updatebtn2#getreceivetemp.trancode#').style.display='none';}">
        <input type="button" name="rcbatchbtn" id="rcbatchbtn" value="B" onClick="document.getElementById('rcbatchtrancode').value='#getreceivetemp.trancode#';ColdFusion.Window.show('rcbatch');" >
        <input type="button" name="rcserialbtn" id="rcserialbtn" value="S" onClick="document.getElementById('rcserialtrancode').value='#getreceivetemp.trancode#';ColdFusion.Window.show('rcserial');" >
        </td>
        <td nowrap><input type="text" name="pricelist2#getreceivetemp.trancode#" id="pricelist2#getreceivetemp.trancode#" value="#val(getreceivetemp.price_bil)#" size="10" onBlur="updaterow2('#getreceivetemp.trancode#');" onKeyup="if(this.value != '#val(getreceivetemp.price_bil)#'){document.getElementById('updatebtn2#getreceivetemp.trancode#').style.display='block';}else{document.getElementById('updatebtn2#getreceivetemp.trancode#').style.display='none';}"></td>
        <td nowrap>#getreceivetemp.amt#</td>
        <td><input type="button" name="deletebtn2#getreceivetemp.trancode#" id="deletebtn2#getreceivetemp.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){deleterow2('#getreceivetemp.trancode#')}" value="DELETE"/><img id="updatebtn2#getreceivetemp.trancode#" name="updatebtn2#getreceivetemp.trancode#" src="/images/tick.gif" width="15" height="15" style="cursor:pointer; display:none;"></td>
        </tr>
        </cfloop>
        
        </table>
</cfoutput>
