<cfoutput>


<cfset defaultfontsize = "12px">

<cfquery name="getdisplay" datasource="#dts#">
select * from displaysetup
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfquery name="getgroup" datasource="#dts#">
   	select wos_group from icgroup
	</cfquery>
    <cfquery name="getbrand" datasource="#dts#">
   	select brand from brand
	</cfquery>

	<cfquery name="getitem" datasource="#dts#">
   		select itemno,desp,ucost,price,fcurrcode,fprice,fucost<cfloop from="2" to="10" index="i">,fcurrcode#i#,fprice#i#,fucost#i#</cfloop> from icitem
        <cfif Hitemgroup neq ''>
            where wos_group='#Hitemgroup#'
        </cfif>
	</cfquery>
    
    <table>
    <tr>
    <td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">ITEM NO.</font></td>
    <td><input type="text" name="itemno1" id="itemno1" size="12" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.display='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitem/searchitemajax.cfm?currcode=#currcode#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('itemname1').focus();}} else if (event.keyCode==40){document.getElementById('btn1').focus()}" /></td>
    <td>&nbsp;</td>
    <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">
    <td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">LEFT NAME:&nbsp;</font></td>
    <td> <input type="text" size="12" name="itemname2" id="itemname2" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitem/searchitemajax.cfm?currcode=#currcode#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('aitemno').focus();}}  else if (event.keyCode==40){document.getElementById('btn1').focus()}" /></td>
     <td>&nbsp;</td>
    <td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">MID NAME:&nbsp;</font></td>
    <td><input type="text" size="12" name="itemname1" id="itemname1" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitem/searchitemajax.cfm?currcode=#currcode#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('itemname2').focus();}} else if (event.keyCode==40){document.getElementById('btn1').focus()}" /></td><cfelse>
    <td>
    <font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">MID NAME:&nbsp;</font></td>
    <td><input type="text" size="12" name="itemname1" id="itemname1" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitem/searchitemajax.cfm?currcode=#currcode#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('itemname2').focus();}} else if (event.keyCode==40){document.getElementById('btn1').focus()}" /></td>
    <td>&nbsp;</td><td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">LEFT NAME:&nbsp;</font></td><td><input type="text" size="12" name="itemname2" id="itemname2" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitem/searchitemajax.cfm?currcode=#currcode#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('aitemno').focus();}}  else if (event.keyCode==40){document.getElementById('btn1').focus()}" /></td>
	
	</cfif>
    <td> &nbsp;&nbsp;<input type="button" name="gobtn1" id="gobtn1" value="Go" onclick="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitem/searchitemajax.cfm?currcode=#currcode#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));" onkeyup="if(event.keyCode==40){document.getElementById('btn1').focus()}"  /></td>
    </tr>
    <tr>
    <td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">#getgsetup.lgroup#:&nbsp;&nbsp;</font></td>
    <td>

    <select name="group1" id="group1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitem/searchitemajax.cfm?currcode=#currcode#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));">
    <option value="">Choose a group</option>
    <cfloop query="getgroup">
    <option value="#getgroup.wos_group#">#getgroup.wos_group#</option>
    </cfloop>
    </select>
    
    </td>
    <td>&nbsp;</td>
    <td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">PRODUCT CODE:&nbsp;</font></td>
    <td><input type="text" size="12" name="aitemno" id="aitemno" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitem/searchitemajax.cfm?currcode=#currcode#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('gobtn1').focus();}}  else if (event.keyCode==40){document.getElementById('btn1').focus()}" /></td>
    <td>&nbsp;</td>
    <TD><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">Brand:&nbsp;&nbsp;</font></TD>
    <td><select name="brand1" id="brand1" style="width:100px" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitem/searchitemajax.cfm?currcode=#currcode#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));">
    <option value="">Choose a brand</option>
    <cfloop query="getbrand">
    <option value="#getbrand.brand#">#getbrand.brand#</option>
    </cfloop>
    </select></td>
    </tr>
    <tr>
      <td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">#getgsetup.lcategory#:&nbsp;&nbsp;</font></td>
     <td><input type="text" size="12" name="cate1" id="cate1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitem/searchitemajax.cfm?currcode=#currcode#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));"></td>
     <td>&nbsp;</td>
      <td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">#getgsetup.lmaterial#:&nbsp;&nbsp;</font></td>
     <td><input type="text" size="12" name="colorid1" id="colorid1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitem/searchitemajax.cfm?currcode=#currcode#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));"></td>
     <td>&nbsp;</td>
      <td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">#getgsetup.lsize#:&nbsp;&nbsp;</font></td>
     <td> <input type="text" size="12" name="sizeid1" id="sizeid1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitem/searchitemajax.cfm?currcode=#currcode#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname1').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));"></td>
     <tr>
     <td colspan="6"><div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div></td>
     </tr>
  
    </table>
    <div id="ajaxFielditm" name="ajaxFielditm">
    <table width="480px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">ITEM NO</font></th>
    <th width="300px">NAME</th>
    <cfif getpin2.h1360 eq 'T'> 
   	<cfif getdisplay.itemsearch_ucost eq 'Y'>
   	<th width="50px"><font style="text-transform:uppercase; font-size:#defaultfontsize#">UCOST</font></th>
   	</cfif>
   	<cfif getdisplay.itemsearch_price eq 'Y'>
    <th width="50px"><font style="text-transform:uppercase; font-size:#defaultfontsize#">PRICE</font></th>
    </cfif>
    </cfif>
    <th width="80px">ACTION</th>
    </tr>
    <cfloop query="getitem" >
    
    <cfif getpin2.h1360 eq 'T'>
    <cfif trim(url.currcode) neq "">
    <cfif url.currcode eq getitem.fcurrcode>
	<cfset getitem.price=getitem.fprice>
    <cfset getitem.ucost=getitem.fucost>
    </cfif>
    
    <cfloop from="2" to="10" index="i">
    <cfif url.currcode eq evaluate('getitem.fcurrcode#i#')>
    <cfset getitem.price= evaluate('getitem.fprice#i#')>
    <cfset getitem.ucost= evaluate('getitem.fucost#i#')>
    </cfif>
    </cfloop>
    </cfif>
    
    </cfif>
    
    <tr>
    <td>#getitem.itemno#</td>
    <td>#getitem.desp#</td>
    <cfif getpin2.h1360 eq 'T'> 
   	<cfif getdisplay.itemsearch_ucost eq 'Y'>
   	<td>#getitem.ucost#</td>
    </cfif>
   	<cfif getdisplay.itemsearch_price eq 'Y'>
    <td>#getitem.price#</td>
    </cfif>
    </cfif>
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="JavaScript:selectitem('#URLEncodedFormat(getitem.itemno)#');ColdFusion.Window.hide('searchitem');"><u>SELECT</u></a></td>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>