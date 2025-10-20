<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "58,121,65,1332,227,1096,592,1097,10,805">
<cfinclude template="/latest/words.cfm">
<cfsetting showdebugoutput="no">
<cfset uuid = url.uuid>
<cfoutput>
<table width="100%">
    <tr>
        <th width="2%" nowrap="nowrap">#words[58]#</th>
        <th width="15%"><div align="left">#words[121]#</div></th>
        <th width="30%"><div align="left">#words[65]#</div></th>
        <th width="10%"><div align="left">#words[1332]#</div></th>
        <th width="10%">#words[227]#</th>
        <th width="8%">#words[1096]#</th>
        <th width="8%">#words[592]#</th>
        <th width="8%">#words[1097]#</th>
        <th width="10%">#words[10]#</th>
    </tr>
    <cfquery name="getictrantemp" datasource="#dts#">
        SELECT * 
        FROM ictrantemp 
        WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> 
        ORDER BY trancode 
    </cfquery>
    <cfloop query="getictrantemp">
        <tr <cfif (getictrantemp.currentrow mod 2) eq 0>style="background-color:##33FFFF"</cfif> onMouseOut="javascript:this.style.backgroundColor='<cfif (getictrantemp.currentrow mod 2) eq 0>33FFFF</cfif>';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
            <td nowrap>#getictrantemp.currentrow#</td>
            <cfquery name="getaitemnoictran" datasource="#dts#">
                SELECT aitemno 
                FROM icitem 
                WHERE itemno='#getictrantemp.itemno#'
            </cfquery>
            <td nowrap>#getictrantemp.itemno#<cfif wserialno eq "T">&nbsp;&nbsp;<input type="button" name="addserial" id="addserial" value="S" onClick="PopupCenter('serial.cfm?tran=#type#&nexttranno=#refno#&itemno=#URLEncodedFormat(itemno)#&itemcount=#trancode#&uuid=#uuid#&qty=#qty#&custno=#custno#&price=#price#&location=#URLEncodedFormat(location)#','Add Serial','300','200');"></cfif></td>
            <td nowrap>#getictrantemp.desp#</td>
            <td nowrap>
            <!--- <select name="coltypelist#getictrantemp.trancode#" id="coltypelist#getictrantemp.trancode#" onChange="if(this.value != '#getictrantemp.brem1#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}">
            <option value="Cash n Carry" <cfif getictrantemp.brem1 eq "Cash n Carry">Selected</cfif>>Cash & Carry</option>
            <option value="Cash n Delivery" <cfif getictrantemp.brem1 eq "Cash n Delivery">Selected</cfif>>Cash & Delivery</option> 
            </select> ---><input type="text" name="coltypelist#getictrantemp.trancode#" id="coltypelist#getictrantemp.trancode#" value="#getictrantemp.brem1#" onClick="if(this.value=='Collection'){this.value = 'Delivery';updaterow('#getictrantemp.trancode#');} else {this.value = 'Collection';updaterow('#getictrantemp.trancode#');}" readonly="readonly"></td>
            <td nowrap align="right">
            <input type="text" name="qtylist#getictrantemp.trancode#" id="qtylist#getictrantemp.trancode#" value="#val(getictrantemp.qty_bil)#" size="5"  onBlur="updaterow('#getictrantemp.trancode#');" onKeyup="if(this.value != '#val(getictrantemp.qty_bil)#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}" <cfif dts EQ "mika_i">readonly="true"</cfif>>
            </td>
            <td nowrap align="right"><cfif getpin2.h2F00 neq "T">#numberformat(val(getictrantemp.price_bil),',.___')#<cfelse><a style="cursor:pointer" onClick="document.getElementById('hidtrancode').value='#getictrantemp.trancode#';ColdFusion.Window.show('changeprice');getfocus4();">#numberformat(val(getictrantemp.price_bil),',.___')#</a></cfif></td>
            <td nowrap align="right">
            <a  style="cursor:pointer;" onClick="document.getElementById('hidtrancode').value='#getictrantemp.trancode#';ColdFusion.Window.show('changediscount');getfocus6();">#numberformat(val(getictrantemp.disamt_bil),'.__')#</a>
            <input type="hidden" name="brem4#getictrantemp.trancode#" id="brem4#getictrantemp.trancode#" value="#getictrantemp.brem4#" size="5"  onBlur="updaterow('#getictrantemp.trancode#');" onKeyup="if(this.value != '#getictrantemp.brem4#'){document.getElementById('updatebtn#getictrantemp.trancode#').style.display='block';}else{document.getElementById('updatebtn#getictrantemp.trancode#').style.display='none';}" ></td>
            <td nowrap align="right">#numberformat(val(getictrantemp.amt_bil),',.___')#</td>
            <td nowrap><input type="button" name="deletebtn#getictrantemp.trancode#" id="deletebtn#getictrantemp.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){deleterow('#getictrantemp.trancode#')}" value="#words[805]#"/>&nbsp;<img id="updatebtn#getictrantemp.trancode#" name="updatebtn#getictrantemp.trancode#" src="/images/tick.gif" width="15" height="15" style="cursor:pointer; display:none;"><!--- &nbsp;&nbsp;<input type="button" name="Updatebtn#getictrantemp.trancode#" id="updatebtn#getictrantemp.trancode#" onClick="updaterow('#getictrantemp.trancode#')" value="UPDATE" style="display:none"/> ---></td>
        </tr>
    </cfloop>
</table>
</cfoutput>
