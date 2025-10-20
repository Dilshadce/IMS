
<html>
<body>
<cfset tran = url.tran>
<cfset custno = url.custno>
<cfset tranno = url.tranno>

<cfquery name='getproduct' datasource='#dts#'>
	select itemno, desp,despa from icitem where (nonstkitem<>'T' or nonstkitem is null) 
    		<cfif Hitemgroup neq ''>
            and wos_group='#Hitemgroup#'
            </cfif>
            <cfif lcase(hcomid) eq "swisspost_i"  or lcase(hcomid) eq "swisspostdemo_i">
             and wos_group = (SELECT coalesce(agent,'') from <cfif tran eq 'rc' or tran eq 'pr' or tran eq 'po'>#target_apvend#<cfelse>#target_arcust#</cfif> WHERE custno = "#custno#")
					</cfif>
            <cfif tran eq 'rc' or tran eq 'pr' or tran eq 'po' or tran eq 'rq'>
                    and (itemtype = "P" or itemtype = "" or itemtype is null or itemtype = "SV")
					<cfelse>
                    and (itemtype = "S" or itemtype = "" or itemtype is null or itemtype = "SV")
					</cfif>
		order by <cfif lcase(hcomid) eq "glenn_i">desp<cfelse>itemno</cfif>
</cfquery>

<cfoutput>
<form action="" method="post" name="submit3" id="submit3">
<input type="hidden" name="tran" value="#url.tran#" >
</form>
<cfform name="expressTrans" id="expressTrans" action="" method="">
<table>
<tr>
<th width="77">Choose a Product</th>
<td colspan="4">

<cfif lcase(HcomID) eq "agape_i" or lcase(HcomID) eq "aecoz_i">

    <select name='expressservicelist' id="expressservicelist" onChange="document.getElementById('desp').value = this.options[this.selectedIndex].id;ajaxFunction(window.document.getElementById('itemDetail'),'/default/transaction/advanceProduct/addItemAjax.cfm?itemno='+escape(encodeURIComponent(this.value))+'&custno=#url.custno#&tran=#url.tran#');setTimeout('updateVal();',1000);setTimeout('calamtadvance();',500);" onBlur="calamtadvance();">
                <option value=''>Choose a Product</option>
                <cfloop query='getproduct'>
                    <cfif getproduct.desp eq ""><option value='Unnamed'>Unnamed - #desp#</option>
                    <cfelse><option value='#URLEncodedFormat(itemno)#' id="#desp#">#itemno# - #desp#</option>
                    </cfif>
                </cfloop>
    </select>
<br>

<input type="text" name="searchitemnew" id="searchitemnew" size="10" onKeyUp="searchSel('expressservicelist','searchitemnew')" onBlur="ajaxFunction(window.document.getElementById('itemDetail'),'/default/transaction/advanceProduct/addItemAjax.cfm?itemno='+escape(encodeURIComponent(document.getElementById('expressservicelist').value))+'&custno=#url.custno#&tran=#url.tran#');setTimeout('updateVal();',500);setTimeout('calamtadvance();',500);" >&nbsp;<input type="button" id="searchitembtn" onClick="ColdFusion.Window.show('multiaddsearchitem');" value="Search" align="right" />&nbsp;

<cfelse>

<cfinput type="text" name="expressservicelist" id="expressservicelist" size="50" onBlur="this.value = this.value.split('___', 1);ajaxFunction(window.document.getElementById('itemDetail'),'/default/transaction/advanceProduct/addItemAjax.cfm?itemno='+escape(encodeURIComponent(this.value))+'&custno=#url.custno#&tran=#url.tran#');setTimeout('updateVal();',1000);calamtadvance();" onKeyUp="nextIndex('expressservicelist','desp');" autosuggest="cfc:itemno.findItem({cfautosuggestvalue},'#dts#')" autosuggestminlength="1">

</cfif>

<input type="button" align="right" value="CLOSE" onClick="releaseDirtyFlag();submitinvoice();">

</td>
<td width="0" rowspan="6"><div id="itemDetail">
</div></td>
</tr>
<tr>
<th>Description</th>
<td colspan="3"><input type="text" name="desp2" id="desp" size="60" onKeyUp="nextIndex('desp','expdespa');" ></td>
</tr>
<tr>
<th></th>
<td colspan="3"><input type="text" name="expdespa" id="expdespa" size="60" onKeyUp="nextIndex('expdespa','expcomment');" ></td>
</tr>
<th>Comment</th>
<td colspan="3"><textarea name="expcomment" id="expcomment" cols="60" rows="2"></textarea><input type="hidden" name="expcomment2" id="expcomment2" value=""><input type="button" name="SearchComment" style="width: 100px; height: 20px; font-size:9px" value="Search Comment" onClick="javascript:ColdFusion.Window.show('findComment');"></td>
</tr>
<tr>
<th>Quantity</th>
<td ><input type="text" name="expqty" id="expqty" size="10" maxlength="10" value="1" onKeyUp="calamtadvance();nextIndex('expqty','expunit');document.getElementById('expqtycount').value = this.value;" ></td>
<th >Unit</th>
<td >
<cfselect name="expunit" id="expunit"  onKeyUp="nextIndex('expunit','expprice');"></cfselect>
</td>
</tr>
<tr>
<th>Price</th>
<td><input type="text" name="expprice" id="expprice" size="15" maxlength="15" value="0.00" <cfif getpin2.h2F00 neq 'T'>readonly</cfif> onKeyUp="calamtadvance();nextIndex('expprice','expqtycount')" ></td>
<th>Discount</th>
<td><input type="text" name="expqtycount" id="expqtycount" size="3" value="1" onKeyUp="caldisamt();calamtadvance();nextIndex('expqtycount','expunitdis')" >
&nbsp;&nbsp;
<input type="text" name="expunitdis" id="expunitdis" size="5" value="0.00" onKeyUp="caldisamt();calamtadvance();nextIndex('expdis','btn_add')" />
&nbsp;&nbsp;
<input type="text" name="expdis" id="expdis" size="10" maxlength="10" value="0.00" onKeyUp="calamtadvance();nextIndex('expdis','btn_add')" onBlur="calamtadvance();">
</td>
</tr>
<tr>
<th>Amount</th>
<td colspan="3"><input type="text" name="expressamt" id="expressamt" size="10" value="0.00" readonly >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input name="btn_add" id="btn_add" type="button" value="Add" onClick="addItemAdvance();"></td>
</tr>
</table>
</cfform>
</cfoutput>
<div id="ajaxFieldPro" name="ajaxFieldPro">
<cfquery name="selectproducts" datasource="#dts#">
SELECT itemno, desp, amt,qty_bil,price,trancode,unit_bil,disamt_bil FROM ictran where refno = "#url.tranno#" and custno = "#url.custno#" and type = "#url.tran#" and (linecode <> "SV" or linecode is null) order by trancode
</cfquery>
<cfoutput>
<table width="750">
<tr>
<th width="50">No</th>
<th width="100">Item Code</th><th width="200">Description</th><th width="50">Quantity</th><th width="50">Unit</th><th width="100">Price</th>
<th width="100">Discount</th><th width="100" align="right">Amount</th>
</tr>
<cfset total = 0>
<cfloop query="selectproducts">
<tr>
<td>#selectproducts.trancode#</td>
<td>#selectproducts.itemno#</td>
<td>#selectproducts.desp#</td>
<td>#numberformat(selectproducts.qty_bil,'.__')#</td>
<td>#selectproducts.unit_bil#</td>
<td>#numberformat(selectproducts.price,'.__')#</td>
<td>#numberformat(selectproducts.qty_bil,'.__')# x #numberformat(selectproducts.disamt_bil/selectproducts.qty_bil,'.__')# = #numberformat(selectproducts.disamt_bil,'.__')#</td>
<td align="right">#numberformat(selectproducts.amt,'.__')#</td>
</tr>
<cfset total = total + #numberformat(selectproducts.amt,'.__')# >
</cfloop>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <th>Total :</th>
  <td align="right"><b>#numberformat(total,'.__')#</b></td>
</tr>
</table>
</cfoutput>
</div>

<div style="width:1px; height:1px; overflow:scroll">
<cfset url.tran = #tran#>
<cfset url.ttype = "Edit">
<cfset url.refno = #tranno#>
<cfset url.custno = #custno#>
<cfset url.first = 0>
<cfset url.jsoff = "true">
<cfinclude template="/default/transaction/tran_edit2.cfm">
</div>
</body>
</html>
	