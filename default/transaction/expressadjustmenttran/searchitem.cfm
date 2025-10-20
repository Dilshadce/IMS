<cfinclude template = "../../../CFC/convert_single_double_quote_script.cfm">

<cfset defaultfontsize = "16px">
<cfif dts eq "tcds_i">
<cfset defaultfontsize = "12px">
</cfif>
<cfset reftype="">

<cfquery name="getdisplay" datasource="#dts#">
select * from displaysetup
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfoutput>
	<cfquery name="getitem" datasource="#dts#">
   		select itemno,desp,ucost,price,category,sizeid from icitem order by itemno limit 100
	</cfquery>
    <cfquery name="getgroup" datasource="#dts#">
   	select wos_group from icgroup
	</cfquery>
    <cfquery name="getbrand" datasource="#dts#">
   	select brand from brand
	</cfquery>
   <table>
    <tr>
    <td valign="top" width="1000px">
    <table>
    <tr>
    <td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">ITEM NO.</font></td>
    <td><input type="text" name="itemno1" id="itemno1" value="" size="12" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname3').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('itemname3').focus();}} else if (event.keyCode==40){document.getElementById('btn1').focus()}" /></td>
    <td>&nbsp;</td>
    <cfif lcase(hcomid) eq "kjcpl_i" or lcase(hcomid) eq "kjctrial_i" or lcase(hcomid) eq "mlpl_i" or lcase(hcomid) eq "viva_i">
    <td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">LEFT NAME:&nbsp;</font></td>
    <td> <input type="text" size="12" name="itemname2" id="itemname2" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname3').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('aitemno').focus();}}  else if (event.keyCode==40){document.getElementById('btn1').focus()}" /></td>
     <td>&nbsp;</td>
    <td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">MID NAME:&nbsp;</font></td>
    <td><input type="text" size="12" name="itemname3" id="itemname3" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname3').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('itemname2').focus();}} else if (event.keyCode==40){document.getElementById('btn1').focus()}" /></td><cfelse>
    <td>
    <font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">MID NAME:&nbsp;</font></td>
    <td><input type="text" size="12" name="itemname3" id="itemname3" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname3').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('itemname2').focus();}} else if (event.keyCode==40){document.getElementById('btn1').focus()}" /></td>
    <td>&nbsp;</td><td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">LEFT NAME:&nbsp;</font></td><td><input type="text" size="12" name="itemname2" id="itemname2" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname3').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('aitemno').focus();}}  else if (event.keyCode==40){document.getElementById('btn1').focus()}" /></td>
	
	</cfif>
    <td> &nbsp;&nbsp;<input type="button" name="gobtn1" id="gobtn1" value="Go" onclick="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname3').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));" onkeyup="if(event.keyCode==40){document.getElementById('btn1').focus()}"  /></td>
    </tr>
    <tr>
    <td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">#getgsetup.lgroup#:&nbsp;&nbsp;</font></td>
    <td>
    <cfif lcase(hcomid) eq "ssuni_i">
    <select name="group1" id="group1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname3').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));">
    <option value="">Choose a group</option>
    <cfloop query="getgroup">
    <option value="#getgroup.wos_group#">#getgroup.wos_group#</option>
    </cfloop>
    </select>
    <cfelse>
    <input type="text" size="12" name="group1" id="group1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname3').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));">
    </cfif>
    </td>
    <td>&nbsp;</td>
    <td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">#getgsetup.lmaterial#:&nbsp;&nbsp;</font></td>
     <td><input type="text" size="12" name="colorid1" id="colorid1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname3').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));"></td>
    
    <td>&nbsp;</td>
    <TD><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">Brand:&nbsp;&nbsp;</font></TD>
    <td><select name="brand1" id="brand1" style="width:100px" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname3').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));">
    <option value="">Choose a brand</option>
    <cfloop query="getbrand">
    <option value="#getbrand.brand#">#getbrand.brand#</option>
    </cfloop>
    </select></td>
    </tr>
    <tr>
      <td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">#getgsetup.lcategory#:&nbsp;&nbsp;</font></td>
     <td><input type="text" size="12" name="cate1" id="cate1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname3').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));"></td>
     <td>&nbsp;</td>
      
     
      <td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;"><cfif lcase(hcomid) eq 'tcds_i'>Asian</cfif> #getgsetup.lsize#:&nbsp;&nbsp;</font></td>
     <td> <input type="text" size="12" name="sizeid1" id="sizeid1" onblur="document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname3').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));"></td>
     <td>&nbsp;</td>
     <cfif lcase(hcomid) eq 'tcds_i'>
     <td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">#getgsetup.lsize#:&nbsp;</font></td>
     <cfelse>
      <td><font style="text-transform:uppercase;font:'Times New Roman', Times, serif; font-size:#defaultfontsize#;">PRODUCT CODE:&nbsp;</font></td>
     </cfif>
    <td><input type="text" size="12" name="aitemno" id="aitemno" onfocus="clearTimeout(t2);" onkeyup="if(event.keyCode==9 || event.keyCode==13){document.getElementById('loading').style.visibility='visible';ajaxFunction1(document.getElementById('ajaxFielditm'),'searchitemajax.cfm?reftype=#reftype#&itemno='+escape(document.getElementById('itemno1').value)+'&itemname='+escape(document.getElementById('itemname3').value)+'&leftitemname='+escape(document.getElementById('itemname2').value)+'&groupname='+escape(document.getElementById('group1').value)+'&catename='+escape(document.getElementById('cate1').value)+'&colorname='+escape(document.getElementById('colorid1').value)+'&sizename='+escape(document.getElementById('sizeid1').value)+'&brandname='+escape(document.getElementById('brand1').value)+'&aitemno='+escape(document.getElementById('aitemno').value));if(event.keyCode==13){document.getElementById('gobtn1').focus();}}  else if (event.keyCode==40){document.getElementById('btn1').focus()}" /></td>
     
     <tr>
     <td colspan="6"><div id="loading" style="visibility:hidden">
    <div class="loading-indicator">
    Loading....
    </div>
    </div></td>
     <td colspan="3" align="right"> <input name="Additembtn" id="Additembtn" type="button" style="cursor:pointer;" onClick="addmultiitem();ColdFusion.Window.hide('searchitem');" value="Add Selected Item"/></td>
     </tr>
  
    </table>
    <div id="ajaxFielditm" name="ajaxFielditm">
    <table width="1000px">
    <tr>
    <th width="100px"><font style="text-transform:uppercase">ITEM NO</font></th>
    <cfif lcase(hcomid) eq "tcds_i">
    <th width="80px">CATEGORY</th>
    <th width="80px">ARTIST</th>
    </cfif>
    <th width="300px">NAME</th>
    <th width="50px">UCOST</th>
    <th width="50px">PRICE</th>
    <th width="50px">QTY ON HAND</th>
    <cfif lcase(hcomid) neq "acht_i">
    <th width="80px">ACTION</th>
    </cfif>
    </tr>
    <cfloop query="getitem" >
    <cfquery name="getitembalance" datasource="#dts#">
    select 
	a.itemno,
	ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance
	
	from icitem as a
	
	left join 
	(
		select itemno,sum(qty) as sumtotalin 
		from ictran 
		where type in ('RC','CN','OAI','TRIN') 
		and itemno='#getitem.itemno#' 
		and fperiod<>'99'
		and (void = '' or void is null)
		group by itemno
	) as b on a.itemno=b.itemno
	
	left join 
	(
		select itemno,sum(qty) as sumtotalout 
		from ictran 
		where type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) 
		and itemno='#getitem.itemno#' 
		and fperiod<>'99'
		and (void = '' or void is null)
		and toinv='' 
		group by itemno
	) as c on a.itemno=c.itemno
	
	where a.itemno='#getitem.itemno#' 
    </cfquery>
    
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';" <cfif lcase(hcomid) eq "acht_i">onClick="document.getElementById('expressservicelist').value = unescape('#URLENCODEDFORMAT(getitem.itemno)#');updateitemdetail('#URLENCODEDFORMAT(getitem.itemno)#');document.getElementById('expressservicelist').focus();ColdFusion.Window.hide('searchitem');"</cfif>>
    <td>#getitem.itemno#</td>
    <cfif lcase(hcomid) eq "tcds_i">
    <td style="font:'Times New Roman', Times, serif; font-size:#defaultfontsize#px">#getitem.category#</td>
    <td style="font:'Times New Roman', Times, serif; font-size:#defaultfontsize#px">#getitem.sizeid#</td>
    </cfif>
    <td>#getitem.desp#</td>
    <td>#lsnumberformat(getitem.ucost,',_.__')#</td>
    <td>#lsnumberformat(getitem.price,',_.__')#</td>
    <td>#getitembalance.balance#</td>
    <cfif lcase(hcomid) neq "acht_i">
    <td><a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="document.getElementById('expressservicelist').value =unescape('#URLENCODEDFORMAT(getitem.itemno)#');updateitemdetail('#URLENCODEDFORMAT(getitem.itemno)#');document.getElementById('expressservicelist').focus();ColdFusion.Window.hide('searchitem');"><u>SELECT</u></a></td>
    </cfif>
    </tr>
    </cfloop>
    
    </table>
    </div>
    </cfoutput>