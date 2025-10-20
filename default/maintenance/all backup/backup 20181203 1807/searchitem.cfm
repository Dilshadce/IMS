<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">

<cfquery name="getdisplay" datasource="#dts#">
select * from displaysetup
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfoutput>
<cfset reftype= ''>
	<cfquery name="getitem" datasource="#dts#">
   		select itemno,aitemno,desp,ucost,price from icitem where 0=0
         <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">
		<cfif Huserloc neq "All_loc">
        and itemno in (select itemno from locqdbf where location='#Huserloc#')
        </cfif>
        </cfif> 
        and itemno like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#URLDECODE(url.itemno)#%" />
        and (nonstkitem<>'T' or nonstkitem is null)
         order by itemno limit 160
	</cfquery>
    <cfquery name="getgroup" datasource="#dts#">
   	select wos_group from icgroup
	</cfquery>
    <cfquery name="getbrand" datasource="#dts#">
   	select brand from brand
	</cfquery>
    <font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:16px;">ITEM NO.</font>&nbsp;<input type="text" name="itemno1" id="itemno1" size="10" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('itemname1').focus();}} else if (event.keyCode==40){document.getElementById('btn1').focus()}" />&nbsp;
    <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">
    <font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:16px;">LEFT NAME:&nbsp;</font><input type="text" size="12" name="itemname2" id="itemname2" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('aitemno').focus();}}  else if (event.keyCode==40){document.getElementById('btn1').focus()}" />&nbsp;<font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:16px;">MID NAME:&nbsp;</font><input type="text" size="12" name="itemname1" id="itemname1" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('itemname2').focus();}} else if (event.keyCode==40){document.getElementById('btn1').focus()}" />
    
    <cfelse>
    <font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:16px;">MID NAME:&nbsp;</font><input type="text" size="12" name="itemname1" id="itemname1" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('itemname2').focus();}} else if (event.keyCode==40){document.getElementById('btn1').focus()}" /><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:16px;">&nbsp;LEFT NAME:&nbsp;</font><input type="text" size="12" name="itemname2" id="itemname2" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('aitemno').focus();}}  else if (event.keyCode==40){document.getElementById('btn1').focus()}" />
	
	</cfif>
    
    &nbsp;&nbsp;<input type="button" name="gobtn1" id="gobtn1" value="Go" onclick="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));" onkeyup="if(event.keyCode==40){document.getElementById('btn1').focus()}"  />
    <br />
    <font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:16px;">#getgsetup.lgroup#:&nbsp;&nbsp;</font><input type="text" size="12" name="group1" id="group1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));">
    <font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:16px;">&nbsp;PRODUCT CODE:&nbsp;</font><input type="text" size="12" name="aitemno" id="aitemno" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('gobtn1').focus();}}  else if (event.keyCode==40){document.getElementById('btn1').focus()}" />
    <font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:16px;">&nbsp;Brand:&nbsp;&nbsp;</font><select name="brand1" id="brand1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));">
    <option value="">Choose a brand</option>
    <cfloop query="getbrand">
    <option value="#getbrand.brand#">#getbrand.brand#</option>
    </cfloop>
    </select>
    <br />
    <font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:16px;">#getgsetup.lcategory#:&nbsp;&nbsp;</font><input type="text" size="12" name="cate1" id="cate1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));">
    <font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:16px;">#getgsetup.lmaterial#:&nbsp;&nbsp;</font><input type="text" size="12" name="colorid1" id="colorid1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));">
    <font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:16px;">#getgsetup.lsize#:&nbsp;&nbsp;</font><input type="text" size="12" name="sizeid1" id="sizeid1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));">
    <div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div>
    <div id="ajaxFielditm" name="ajaxFielditm">
    
    <table width="850px">
    <tr>
    <td colspan="100%" align="right">
    
    </td>
    </tr>
    <tr>
    <cfif getdisplay.itemsearch_itemno eq 'Y'>
    <th width="100px"><font style="text-transform:uppercase">ITEM NO</font></th>
    </cfif>
    <cfif getdisplay.itemsearch_aitemno eq 'Y'><th width="100px">PRODUCT CODE</th></cfif>
    <cfif getdisplay.itemsearch_desp eq 'Y'>
    <th width="300px">NAME</th>
    </cfif>
     
   <cfif getpin2.h1360 eq 'T'> 
   <cfif getdisplay.itemsearch_ucost eq 'Y'>
   <th width="50px">UCOST</th>
   </cfif>
   <cfif getdisplay.itemsearch_price eq 'Y'>
    <th width="50px">PRICE</th>
    </cfif>
    
    </cfif>
    <cfif lcase(hcomid) neq "acht_i">
    <th width="80px">ACTION</th>
    </cfif>
    </tr>
    <cfloop query="getitem" >
   
    
    <tr id="tr#getitem.currentrow#" onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';" <cfif lcase(hcomid) eq "acht_i">onClick="document.getElementById('expressservicelist').value = unescape(decodeURI('#URLENCODEDFORMAT(getitem.itemno)#'));getitemdetail('#URLENCODEDFORMAT(getitem.itemno)#');<!--- document.getElementById('desp2').focus(); --->ColdFusion.Window.hide('searchitem');"</cfif>>
    <cfif getdisplay.itemsearch_itemno eq 'Y'>
    <td style="font:'Times New Roman', Times, serif; font-size:16px">#getitem.itemno#</td>
    </cfif>
    <cfif getdisplay.itemsearch_aitemno eq 'Y'><td style="font:'Times New Roman', Times, serif; font-size:16px">#getitem.aitemno#</td></cfif>
    <cfif getdisplay.itemsearch_desp eq 'Y'><td style="font:'Times New Roman', Times, serif; font-size:16px">#getitem.desp#</td></cfif>
    <cfif getpin2.h1360 eq 'T'>
    <cfif getdisplay.itemsearch_ucost eq 'Y'>
    <td style="font:'Times New Roman', Times, serif; font-size:16px">#lsnumberformat(getitem.ucost,',_.__')#</td>
    </cfif>
    <cfif getdisplay.itemsearch_price eq 'Y'>
    <td style="font:'Times New Roman', Times, serif; font-size:16px">#lsnumberformat(getitem.price,',_.__')#</td>
    </cfif>
    
    </cfif>
    <cfif lcase(hcomid) neq "acht_i">
    <td style="font:'Times New Roman', Times, serif; font-size:16px"><input name="btn#getitem.currentrow#" id="btn#getitem.currentrow#" type="button" style="background:none; border:none; cursor:pointer;" onClick="document.getElementById('productfrom').value =unescape(decodeURI('#URLENCODEDFORMAT(getitem.itemno)#'));ajaxFunction(document.getElementById('itemajax'),'/default/maintenance/itemlocationenquireajax.cfm?itemno='+document.getElementById('productfrom').value);<!--- document.getElementById('desp2').focus(); --->ColdFusion.Window.hide('finditem');" value="SELECT" onfocus="document.getElementById('tr#getitem.currentrow#').bgColor='##CCCCCC'" onblur="document.getElementById('tr#getitem.currentrow#').bgColor='##FFFFFF'" onkeyup="<cfif getitem.currentrow neq getitem.recordcount>if(event.keyCode==40){document.getElementById('btn#val(getitem.currentrow)+1#').focus()}</cfif> <cfif getitem.currentrow neq 1>if(event.keyCode==38){document.getElementById('btn#val(getitem.currentrow)-1#').focus()}<cfelse>if(event.keyCode==38){document.getElementById('itemno1').focus()}</cfif> " /></td>
    
    </cfif>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>
<!--- 	<script type="text/javascript">
	getfocus2()
    </script> --->