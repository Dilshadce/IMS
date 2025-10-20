<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "58,120,65,482,1121,1096,1097,10,1082,805">
<cfinclude template="/latest/words.cfm">
<cfsetting showdebugoutput="no">
<cfoutput>

<cfquery datasource="#dts#" name="getlocation">
	SELECT location, desp 
	FROM iclocation 
    WHERE 0=0
    <cfif (lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i" or lcase(hcomid) eq "kjctrial_i") and (HUserGrpID neq 'Cust Svr' and HUserGrpID neq 'Van Sales')>
    <cfelse>
		<cfif Huserloc neq "All_loc">
            AND location='#Huserloc#'
        </cfif>
    </cfif>
	ORDER BY location;
</cfquery>

<cfset uuid = url.uuid>
<table>
    <tr>
        <th>#words[58]#</th>
        <th>#words[120]#</th>
        <th>#words[65]#</th>
        <th>#words[482]#</th>
        <th>#words[1121]#</th>
        <th>#words[1096]#</th>
        <th>#words[1097]#</th>
        <th nowrap="nowrap">#words[10]#</th>
    </tr>
    <cfquery name="getissuetemp" datasource="#dts#">
        SELECT * 
        FROM issuetemp 
        WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> 
        ORDER BY trancode DESC
    </cfquery>
    <cfloop query="getissuetemp">
        <tr <cfif (getissuetemp.currentrow mod 2) eq 0>style="background-color:##33FFFF"</cfif> onMouseOut="javascript:this.style.backgroundColor='<cfif (getissuetemp.currentrow mod 2) eq 0>33FFFF</cfif>';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
            <td nowrap>#getissuetemp.currentrow#</td>
            <td nowrap>#getissuetemp.itemno#</td>
            <td nowrap>#getissuetemp.desp#</td>
            <td>
            <select name="coltypelist#getissuetemp.trancode#" id="coltypelist#getissuetemp.trancode#" onChange="updaterow('#getissuetemp.trancode#');">
                <option value="">#words[1082]#</option>
                <cfloop query="getlocation">
                    <option value="#getlocation.location#" <cfif getissuetemp.location eq getlocation.location>selected</cfif>>#getlocation.location#</option>
                </cfloop>
            </select>
            </td>
            <td nowrap><input type="text" name="qtylist#getissuetemp.trancode#" id="qtylist#getissuetemp.trancode#" value="#val(getissuetemp.qty_bil)#" size="5" onBlur="updaterow('#getissuetemp.trancode#');" onKeyup="if(this.value != '#val(getissuetemp.qty_bil)#'){document.getElementById('updatebtn#getissuetemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getissuetemp.trancode#').style.display='none';}"><input type="button" name="issbatchbtn" id="issbatchbtn" value="B" onClick="document.getElementById('issbatchtrancode').value='#getissuetemp.trancode#';ColdFusion.Window.show('issbatch');" ></td>
            <td nowrap><input type="text" name="pricelist#getissuetemp.trancode#" id="pricelist#getissuetemp.trancode#" value="#val(getissuetemp.price_bil)#" size="10" onBlur="updaterow('#getissuetemp.trancode#');" onKeyup="if(this.value != '#val(getissuetemp.price_bil)#'){document.getElementById('updatebtn#getissuetemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getissuetemp.trancode#').style.display='none';}"></td>
            <td nowrap>#getissuetemp.amt#</td>
            <td><input type="button" name="deletebtn#getissuetemp.trancode#" id="deletebtn#getissuetemp.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){deleterow('#getissuetemp.trancode#')}" value="#words[805]#"/><img id="updatebtn#getissuetemp.trancode#" name="updatebtn#getissuetemp.trancode#" src="/images/tick.gif" width="15" height="15" style="cursor:pointer; display:none;"></td>
        </tr>
    </cfloop>
</table>
</cfoutput>
