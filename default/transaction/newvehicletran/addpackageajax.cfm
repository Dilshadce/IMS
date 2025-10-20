    <cfquery name="getitem1" datasource="#dts#">
   	Select * from package where
    1=1
    <cfif URLDECODE(url.packno) neq "">
    and packcode like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.packno)#%" /> 
    </cfif>
    <cfif URLDECODE(url.packdesp) neq "">
    and packdesp like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.packdesp)#%" />
    </cfif>
    order by packcode
	</cfquery>
    
	<cfoutput>  
	<cfset reftype= url.reftype>
    <input name="hidpackagecode" id="hidpackagecode" type="text" value=""/>
    <table width="650px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">Pack NO</font></th>
    <th width="100px"><font style="text-transform:uppercase">Description</font></th>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitem1" >
    <tr id="tr#getitem1.currentrow#" onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    <td>#getitem1.packcode#</td>
    <td>#getitem1.packdesp#</td>

    <td><input name="btn#getitem1.currentrow#" id="btn#getitem1.currentrow#" type="button" style="background:none; border:none; cursor:pointer;"  onClick="document.getElementById('hidpackagecode').value = unescape(decodeURI('#URLENCODEDFORMAT(getitem1.packcode)#'));addpackagefunc();ColdFusion.Window.hide('addpackage');" value="SELECT" /></td>
    
    </tr>
    </cfloop>
    </table>
    </div>
    </cfoutput>