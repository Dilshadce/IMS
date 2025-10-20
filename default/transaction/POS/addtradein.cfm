
<html>
<body>
<cfquery name='getproduct' datasource='#dts#'>
	select itemno, desp,despa from icitem where (nonstkitem<>'T' or nonstkitem is null) 
    		<cfif Hitemgroup neq ''>
            and wos_group='#Hitemgroup#'
            </cfif>
		order by itemno
</cfquery>

<cfoutput>
<cfform name="tradeinTrans" id="tradeinTrans" action="" method="">
<table>
<tr>
<th width="77">Choose a Product</th>
<td colspan="4">
<input name="tradeinitemno" id="tradeinitemno" value="" onblur="ajaxFunction(window.document.getElementById('tradeinitemDetail'),'/default/transaction/POS/tradeinaddItemAjax.cfm?itemno='+escape(this.value));setTimeout('tradeinupdateVal();',1000);setTimeout('tradeincalamtadvance();',500);">
<!---<select name='tradeinitemno' id="tradeinitemno" onChange="ajaxFunction(window.document.getElementById('tradeinitemDetail'),'/default/transaction/POS/tradeinaddItemAjax.cfm?itemno='+escape(this.value));setTimeout('tradeinupdateVal();',1000);setTimeout('tradeincalamtadvance();',500);" onBlur="tradeincalamtadvance();">
        	<option value=''>Choose a Product</option>
          	<cfloop query='getproduct'>
				<cfif getproduct.desp eq ""><option value='Unnamed'>Unnamed - #desp#</option>
				<cfelse><option value='#URLEncodedFormat(itemno)#' id="#desp#">#itemno# - #desp#</option>
				</cfif>
          	</cfloop>
</select>--->
<br>
<input type="button" id="searchitemtradeinbtn" onClick="ColdFusion.Window.show('searchitemtradein');" value="Search" align="right" />
<!---<input type="text" name="tradeinsearchitemnew" id="tradeinsearchitemnew" size="10" onKeyUp="searchSel('tradeinitemno','tradeinsearchitemnew')" onBlur="ajaxFunction(window.document.getElementById('tradeinitemDetail'),'/default/transaction/POS/tradeinaddItemAjax.cfm?itemno='+escape(document.getElementById('tradeinitemno').value));setTimeout('tradeinupdateVal();',500);setTimeout('tradeincalamtadvance();',500);" >&nbsp;
--->
<input type="button" align="right" value="CLOSE" onClick="ColdFusion.Window.hide('addtradein');"></td>
<td width="0" rowspan="6"><div id="tradeinitemDetail">
</div></td>
</tr>
<tr>
<th>Description</th>
<td colspan="3"><input type="text" name="tradeindesp" id="tradeindesp" size="60" onKeyUp="nextIndex('tradeindesp','tradeindespa');" ></td>
</tr>
<tr>
<th></th>
<td colspan="3"><input type="text" name="tradeindespa" id="tradeindespa" size="60" onKeyUp="nextIndex('tradeindespa','tradeincomment');" ></td>
</tr>
<th>Comment</th>
<td colspan="3"><textarea name="tradeincomment" id="tradeincomment" cols="60" rows="2" onKeyUp="nextIndex('tradeincomment','tradeinqty');" ></textarea></td>
</tr>
<tr>
<th>Quantity</th>
<td ><input type="text" name="tradeinqty" id="tradeinqty" size="10" maxlength="10" value="1" onKeyUp="tradeincalamtadvance();nextIndex('tradeinqty','tradeinunit');document.getElementById('tradeinqtycount').value = this.value;" ></td>
<th >Unit</th>
<td >
<cfselect name="tradeinunit" id="tradeinunit"  onKeyUp="nextIndex('tradeinunit','tradeinprice');"></cfselect>
</td>
</tr>
<tr>
<th>Price</th>
<td><input type="text" name="tradeinprice" id="tradeinprice" size="15" maxlength="15" value="0.00" <cfif getpin2.h2F00 neq 'T'>readonly</cfif> onKeyUp="tradeincalamtadvance();nextIndex('tradeinprice','tradeinbtn_add')" ></td>
<th style="display:none;">Discount</th>
<td style="display:none;"><input type="text" name="tradeinqtycount" id="tradeinqtycount" size="3" value="1" onKeyUp="caldisamt();tradeincalamtadvance();nextIndex('tradeinqtycount','tradeinunitdis')" >
&nbsp;&nbsp;
<input type="text" name="tradeinunitdis" id="tradeinunitdis" size="5" value="0.00" onKeyUp="caldisamt();tradeincalamtadvance();nextIndex('tradeindis','btn_add')" />
&nbsp;&nbsp;
<input type="text" name="tradeindis" id="tradeindis" size="10" maxlength="10" value="0.00" onKeyUp="tradeincalamtadvance();nextIndex('tradeindis','btn_add')" onBlur="tradeincalamtadvance();">
</td>
</tr>
<tr>
<th>Amount</th>
<td colspan="3"><input type="text" name="tradeinamt" id="tradeinamt" size="10" value="0.00" readonly >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input name="tradeinbtn_add" id="tradeinbtn_add" type="button" value="Add" onClick="tradeinaddItemAdvance();"></td>
</tr>
</table>
</cfform>
</cfoutput>
<div id="tradeinAjaxField" name="tradeinAjaxField">
<cfquery name="selectproducts" datasource="#dts#">
SELECT * FROM tradeintemp where uuid = "#url.uuid#" order by trancode
</cfquery>
<cfoutput>
<table width="750">
<tr>
<th width="50">No</th>
<th width="100">Item Code</th><th width="200">Description</th><th width="50">Quantity</th><th width="50">Unit</th><th width="100">Price</th>
<th width="100" align="right">Amount</th>
<th>Action</th>
</tr>
<cfset total = 0>
<cfloop query="selectproducts">
<tr>
<td>#selectproducts.trancode#</td>
<td>#selectproducts.itemno# <input type="button" name="addserial" id="addserial" value="S" onClick="PopupCenter('serial.cfm?tran=RC&nexttranno=&itemno=#URLEncodedFormat(itemno)#&itemcount=#trancode#&uuid=#uuid#&qty=#qty_bil#&custno=#custno#&price=#price#&location=#URLEncodedFormat(location)#','Add Serial','400','400');"></td>
<td>#selectproducts.desp#</td>
<td>#numberformat(selectproducts.qty_bil,'.__')#</td>
<td>#selectproducts.unit_bil#</td>
<td>#numberformat(selectproducts.price,'.__')#</td>
<td align="right">#numberformat(selectproducts.amt,'.__')#</td>
<td><input type="button" name="tradeindeletebtn#selectproducts.trancode#" id="tradeindeletebtn#selectproducts.trancode#" onClick="if(confirm('Are You Sure You Want To Delete?')){tradeindeleterow('#selectproducts.trancode#')}" value="Delete"/></td>
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
</div>
</body>
</html>
	