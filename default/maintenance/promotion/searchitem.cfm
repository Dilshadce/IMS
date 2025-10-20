<cfinclude template = "../../../CFC/convert_single_double_quote_script.cfm">

<cfquery name="getdisplay" datasource="#dts#">
select * from displaysetup
</cfquery>
<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfquery name="getpromo" datasource="#dts#">
    select periodfrom,periodto from promotion where promoid='#url.promoid#'
    </cfquery>
    
    <cfquery name="getpromo2" datasource="#dts#">
    select promoid from promotion where periodfrom='#getpromo.periodfrom#' and periodto='#getpromo.periodto#'
    </cfquery>
    
    <cfset promolist=valuelist(getpromo2.promoid)>
	
    <cfquery name="getpromo3" datasource="#dts#">
    select itemno from promoitem where promoid in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#promolist#">)
    </cfquery>

	<cfset itemlist=valuelist(getpromo3.itemno)>
<cfoutput>


<cfset reftype= ''>
	<cfquery name="getitem" datasource="#dts#">
    <cfif lcase(hcomid) eq "aipl_i" or lcase(hcomid) eq "kjpe_i" or lcase(hcomid) eq "gramas_i">
    select substring_index(itemno,'-',1) as itemno,aitemno,desp,ucost,price from icitem
    where itemno not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#itemlist#">)    
    group by substring_index(itemno,'-',1)
    order by substring_index(itemno,'-',1)
    <cfelse>
    select itemno,aitemno,desp,ucost,price from icitem
    where itemno not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#itemlist#">)    
    order by itemno
    limit 50
    </cfif>     
	</cfquery>
    <cfquery name="getgroup" datasource="#dts#">
   	select wos_group from icgroup
	</cfquery>
    <cfquery name="getbrand" datasource="#dts#">
   	select brand from brand
	</cfquery>
    <font style="text-transform:uppercase">ITEM NO.</font>&nbsp;<input type="text" name="itemno1" id="itemno1" size="10" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?promoid=#url.promoid#&reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('itemname1').focus();}} else if (event.keyCode==40){document.getElementById('btn1').focus()}" />&nbsp;
    <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">
    LEFT NAME:&nbsp;<input type="text" size="12" name="itemname2" id="itemname2" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?promoid=#url.promoid#&reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('aitemno').focus();}}  else if (event.keyCode==40){document.getElementById('btn1').focus()}" />&nbsp;MID NAME:&nbsp;<input type="text" size="12" name="itemname1" id="itemname1" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?promoid=#url.promoid#&reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('itemname2').focus();}} else if (event.keyCode==40){document.getElementById('btn1').focus()}" />
    
    <cfelse>
    MID NAME:&nbsp;<input type="text" size="12" name="itemname1" id="itemname1" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?promoid=#url.promoid#&reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('itemname2').focus();}} else if (event.keyCode==40){document.getElementById('btn1').focus()}" />&nbsp;LEFT NAME:&nbsp;<input type="text" size="12" name="itemname2" id="itemname2" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?promoid=#url.promoid#&reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('aitemno').focus();}}  else if (event.keyCode==40){document.getElementById('btn1').focus()}" />
	
	</cfif>
    
    &nbsp;&nbsp;<input type="button" name="gobtn1" id="gobtn1" value="Go" onclick="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?promoid=#url.promoid#&reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));" onkeyup="if(event.keyCode==40){document.getElementById('btn1').focus()}"  />
    <br />
    GROUP:&nbsp;&nbsp;<select name="group1" id="group1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?promoid=#url.promoid#&reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));">
    <option value="">Choose a group</option>
    <cfloop query="getgroup">
    <option value="#getgroup.wos_group#">#getgroup.wos_group#</option>
    </cfloop>
    </select>
    &nbsp;PRODUCT CODE:&nbsp;<input type="text" size="12" name="aitemno" id="aitemno" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?promoid=#url.promoid#&reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('gobtn1').focus();}}  else if (event.keyCode==40){document.getElementById('btn1').focus()}" />
    &nbsp;Brand:&nbsp;&nbsp;<select name="brand1" id="brand1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?promoid=#url.promoid#&reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));">
    <option value="">Choose a brand</option>
    <cfloop query="getbrand">
    <option value="#getbrand.brand#">#getbrand.brand#</option>
    </cfloop>
    </select>
    
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxFielditm" name="ajaxFielditm">
    
    <table width="650px">
    <tr>
    <td colspan="100%" align="right">
    <input name="selectallbtn" id="selectallbtn" type="button" style="cursor:pointer;" onClick="for (k=1;k<=50;k=k+1)
	{	
	document.getElementById('additem_'+k).checked = true
	}" value="Check All Item"/>&nbsp;&nbsp;&nbsp;
    <input name="Additembtn" id="Additembtn" type="button" style="cursor:pointer;" onClick="addmultiitem();ColdFusion.Window.hide('searchitem');" value="Add Selected Item"/>
    </td>
    </tr>
    <tr>
    <cfif getdisplay.itemsearch_itemno eq 'Y'>
    <th width="100px"><font style="text-transform:uppercase">ITEM NO #promolist#</font></th>
    </cfif>
    <cfif getdisplay.itemsearch_aitemno eq 'Y'><th width="100px">PRODUCT CODE</th></cfif>
    <cfif getdisplay.itemsearch_desp eq 'Y'>
    <th width="300px">NAME</th>
    </cfif>
     

    <cfif lcase(hcomid) neq "acht_i">
    <th width="80px">ACTION</th>
    </cfif>
    </tr>
    <cfloop query="getitem" >
    
    
    <tr id="tr#getitem.currentrow#" onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';" <cfif lcase(hcomid) eq "acht_i">onClick="document.getElementById('expressservicelist').value = unescape(decodeURI('#URLENCODEDFORMAT(getitem.itemno)#'));getitemdetail('#URLENCODEDFORMAT(getitem.itemno)#');<!--- document.getElementById('desp2').focus(); --->ColdFusion.Window.hide('searchitem');"</cfif>>
    <cfif getdisplay.itemsearch_itemno eq 'Y'>
    <td>#getitem.itemno#</td>
    </cfif>
    <cfif getdisplay.itemsearch_aitemno eq 'Y'><td>#getitem.aitemno#</td></cfif>
    <cfif getdisplay.itemsearch_desp eq 'Y'><td>#getitem.desp#</td></cfif>
   
	<!---
    <td><input name="btn#getitem.currentrow#" id="btn#getitem.currentrow#" type="button" style="background:none; border:none; cursor:pointer;" onClick="selectlist('#getitem.itemno#','itemno');ColdFusion.Window.hide('searchitem');" value="SELECT" onfocus="document.getElementById('tr#getitem.currentrow#').bgColor='##CCCCCC'" onblur="document.getElementById('tr#getitem.currentrow#').bgColor='##FFFFFF'" onkeyup="<cfif getitem.currentrow neq getitem.recordcount>if(event.keyCode==40){document.getElementById('btn#val(getitem.currentrow)+1#').focus()}</cfif> <cfif getitem.currentrow neq 1>if(event.keyCode==38){document.getElementById('btn#val(getitem.currentrow)-1#').focus()}<cfelse>if(event.keyCode==38){document.getElementById('itemno1').focus()}</cfif> " /></td>
	--->
    <td><input name="additem_#getitem.currentrow#" id="additem_#getitem.currentrow#" type="checkbox" value="#getitem.itemno#" onclick="
    for (m=1;m<=200;m=m+1)
	{
	if (document.getElementById('btn'+m) == null)
	{
	}
	else
	{	
	document.getElementById('btn'+m).style.visibility='hidden';
	}
	}"/></td>

    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>
<!--- 	<script type="text/javascript">
	getfocus2()
    </script> --->