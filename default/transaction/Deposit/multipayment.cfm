
<cfoutput>
<form action="" method="post" name="ccform20"  id="ccform20">
<table width="570px" >
<tr>
<th colspan="100%"><div align="center">Multi Payment</div></th>
</tr>
<tr>
<td style="font-size:16px; color:##000;">Cash</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="multipaycash" id="multipaycash" style="font-size:16px; text-align:right" value="0.00" onkeyup="calculatetotal(event,'cc15','')"/>
</td>
</tr>
<tr>
<td style="font-size:16px;">Credit Card 1</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="multipaycc" id="multipaycc" value="0.00" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'cc25','paycash5')" />
</td>
</tr>
<tr>
<td colspan="3">
<input type="radio" name="multipaycctype" id="multipaycctype" value="MASTER" checked="checked"/>Mastercard&nbsp;&nbsp;&nbsp;
<input type="radio" name="multipaycctype" id="multipaycctype" value="VISA" />Visa&nbsp;&nbsp;&nbsp;
<input type="radio" name="multipaycctype" id="multipaycctype" value="AMEX" />American Express&nbsp;&nbsp;
<input type="radio" name="multipaycctype" id="multipaycctype" value="DINERS" />Diners Club
</td>
</tr>
<tr>
<td style="font-size:16px;">Credit Card 2</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="multipaycc2" id="multipaycc2" value="0.00" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'dbc5','cc15')" />
</td>
</tr>
<tr>
<td colspan="3">
<input type="radio" name="multipaycctype2" id="multipaycctype2" value="MASTER" checked="checked"/>Mastercard&nbsp;&nbsp;&nbsp;
<input type="radio" name="multipaycctype2" id="multipaycctype2" value="VISA" />Visa&nbsp;&nbsp;&nbsp;
<input type="radio" name="multipaycctype2" id="multipaycctype2" value="AMEX" />American Express&nbsp;&nbsp;
<input type="radio" name="multipaycctype2" id="multipaycctype2" value="DINERS" />Diners Club
</td>
</tr>
<tr>
<td style="font-size:16px;">NETS</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="multipaydbcd" id="multipaydbcd" value="0.00" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'cheq5','cc25')" />
</td>
</tr>
<tr>
<td style="font-size:16px;">Cheque</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="multipaycheq" id="multipaycheq" value="0.00" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'voucheramt5','dbc5')"/>
</td>
</tr>
<tr>
<td colspan="3">
Cheque No. <input type="text" name="multipaycheqno" id="multipaycheqno" value="" />
</td>
</tr>
<tr>
<td style="font-size:16px;">Voucher</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="multipayvouc" id="multipayvouc" value="0.00" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'depositamt5','cheq5')"/>
</td>
</tr>

<tr>
<td style="font-size:16px;">Total</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="multipaytotal" id="multipaytotal" style="font-size:16px; text-align:right" value="#numberformat(val(url.grandtotal)*-1,'.__')#" readonly="readonly" />
</td>
</tr>

<tr>
<td align="center" colspan="3"><input type="button" name="sub_btn" id="sub_btn" value="Accept" style="font: large bolder;" onclick="multipay();" /></td>
</tr>
</table>
</form>
<script type="text/javascript">
setTimeout("document.getElementById('multipaycash').focus();document.getElementById('multipaycash').select();",250);
</script>
</cfoutput>
