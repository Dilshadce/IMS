<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "58,120,65,482,1121,1096,1097,10,1082,805">
<cfinclude template="/latest/words.cfm">
<cfsetting showdebugoutput="no">

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

<cfoutput>
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
        <cfquery name="getreceivetemp" datasource="#dts#">
            SELECT * 
            FROM receivetemp 
            WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> 
            ORDER BY trancode DESC
        </cfquery>
    <cfloop query="getreceivetemp">
        <tr <cfif (getreceivetemp.currentrow mod 2) eq 0>style="background-color:##33FFFF"</cfif> onMouseOut="javascript:this.style.backgroundColor='<cfif (getreceivetemp.currentrow mod 2) eq 0>33FFFF</cfif>';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
            <td nowrap>#getreceivetemp.currentrow#</td>
            <td nowrap>#getreceivetemp.itemno#</td>
            <td nowrap>#getreceivetemp.desp#</td>
            <td>
            <select name="coltypelist2#getreceivetemp.trancode#" id="coltypelist2#getreceivetemp.trancode#" onChange="updaterow2('#getreceivetemp.trancode#');">
                <option value="">#words[1082]#</option>
                <cfloop query="getlocation">
                    <option value="#getlocation.location#" <cfif getreceivetemp.location eq getlocation.location>selected</cfif>>#getlocation.location#</option>
                </cfloop>
            </select>
            </td>
            <td nowrap><input type="text" name="qtylist2#getreceivetemp.trancode#" id="qtylist2#getreceivetemp.trancode#" value="#val(getreceivetemp.qty_bil)#" size="5" onBlur="updaterow2('#getreceivetemp.trancode#');" onKeyup="if(this.value != '#val(getreceivetemp.qty_bil)#'){document.getElementById('updatebtn2#getreceivetemp.trancode#').style.display='block';}else{document.getElementById('updatebtn2#getreceivetemp.trancode#').style.display='none';}">
            <input type="button" name="rcbatchbtn" id="rcbatchbtn" value="B" onClick="document.getElementById('rcbatchtrancode').value='#getreceivetemp.trancode#';ColdFusion.Window.show('rcbatch');" >
            <input type="button" name="rcserialbtn" id="rcserialbtn" value="S" onClick="document.getElementById('rcserialtrancode').value='#getreceivetemp.trancode#';ColdFusion.Window.show('rcserial');" >
            </td>
            <td nowrap><input type="text" name="pricelist2#getreceivetemp.trancode#" id="pricelist2#getreceivetemp.trancode#" value="#val(getreceivetemp.price_bil)#" size="10" onBlur="updaterow2('#getreceivetemp.trancode#');" onKeyup="if(this.value != '#val(getreceivetemp.price_bil)#'){document.getElementById('updatebtn2#getreceivetemp.trancode#').style.display='block';}else{document.getElementById('updatebtn2#getreceivetemp.trancode#').style.display='none';}"></td>
            <td nowrap>#getreceivetemp.amt#</td>
            <td><input type="button" name="deletebtn2#getreceivetemp.trancode#" id="deletebtn2#getreceivetemp.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){deleterow2('#getreceivetemp.trancode#')}" value="#words[805]#"/><img id="updatebtn2#getreceivetemp.trancode#" name="updatebtn2#getreceivetemp.trancode#" src="/images/tick.gif" width="15" height="15" style="cursor:pointer; display:none;"></td>
        </tr>
    </cfloop>
        
</table>
</cfoutput>
