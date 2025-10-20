
<html>
<body>
<cfset tran = url.tran>
<cfset custno = url.custno>
<cfset tranno = url.tranno>
<cfset trannolen = len(tranno)>
<cfset tranno = right(tranno,trannolen - 2)>

<cfoutput>
<form action="" method="post" name="submit3" id="submit3">
<input type="hidden" name="tran" value="#url.tran#" >
</form>
<cfform name="expressTrans" id="expressTrans" action="" method="">
<table>
<tr>
<th>Choose a Product</th>
<td colspan="3">
<cfinput type="text" name="expressservicelist" id="expressservicelist" size="50" onBlur="this.value = this.value.split('___', 1);ajaxFunction(window.document.getElementById('itemDetail'),'/default/transaction/advanceProduct/addItemAjax.cfm?itemno='+this.value+'&custno=#url.custno#&tran=#url.tran#');setTimeout('updateVal();',1000);setTimeout('calamtadvance();',1000);" onKeyUp="nextIndex('expressservicelist','desp');" autosuggest="cfc:itemno.findItem({cfautosuggestvalue},'#dts#')" autosuggestminlength="1">
<input type="button" align="right" value="CLOSE" onClick="submitinvoice();"></td>
<td rowspan="6"><div id="itemDetail">
</div></td>
</tr>
<tr>
<th>Description</th>
<td colspan="3"><input type="text" name="desp2" id="desp" size="60" onKeyUp="nextIndex('desp','expcomment');" readonly ></td>
</tr>
<th>Comment</th>
<td colspan="3"><textarea name="expcomment" id="expcomment" cols="60" rows="2" onKeyUp="nextIndex('expcomment','expqty');" ></textarea></td>
</tr>
<tr>
<th>Quantity</th>
<td><input type="text" name="expqty" id="expqty" size="10" maxlength="10" value="1" onKeyUp="calamtadvance();nextIndex('expqty','expunit');document.getElementById('expqtycount').value = this.value;" ></td>
<th>Unit</th>
<td>
<cfselect name="expunit" id="expunit"  onKeyUp="nextIndex('expunit','expprice');"></cfselect>
</td>
</tr>
<tr>
<th>Price</th>
<td><input type="text" name="expprice" id="expprice" size="15" maxlength="15" value="0.00" onKeyUp="calamtadvance();nextIndex('expprice','expqtycount')" ></td>
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
</div>
</body>
</html>
	