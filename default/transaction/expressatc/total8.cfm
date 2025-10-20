<cfif isdefined('url.grandtotal')>
<cfoutput>
<cfset url.grandtotal = numberformat(val(url.grandtotal),'.__')>
<form action="process.cfm" method="post" onsubmit="submitpay();return false;">
<table width="570px" >
<tr>
<td width="250px" style="font-size:24px;" height="30px">TOTAL</td>
<td width="20px" style="font-size:24px;">:</td>
<td width="300px" align="right" style="font-size:24px;">#numberformat(url.grandtotal,',.__')#<input type="hidden" name="hidgt8" id="hidgt8" value="#numberformat(url.grandtotal,'.__')#"  /><input type="hidden" name="payamt8" id="payamt8" value="0"  /></td>
</tr>
<tr style="display:none;">
<td colspan="3">&nbsp;</td>
</tr>
<tr style="display:none;">
<td style="font-size:24px; color:##000;">NETS</td>
<td style="font-size:24px;">:</td>
<td style="font-size:24px;" align="right">
<input type="text" name="dbc8" id="dbc8" style="font: large bolder; text-align:right" value="#numberformat(url.grandtotal,'.__')#" onkeyup="calculatetotal(event,'cc18','')" readonly="readonly"/>
</td>
</tr>
<tr>
<td colspan="3">&nbsp;</td>
</tr>
<tr  style="display:none;">
<td style="font-size:24px;">Change</td>
<td style="font-size:24px;">:</td>
<td style="font-size:24px;" align="right">
<input type="text" name="change8" id="change8" value="0.00" style="font: large bolder; text-align:right" readonly="readonly"/>
</td>
</tr>
</tr>
<tr style="display:none;">
<th colspan="100%"><div align="center">Multi Payment</div></th>
</tr>
<tr  style="display:none;">
<td style="font-size:16px;">Credit Card 1</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="cc18" id="cc18" value="0.00" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'cc28','dbc8')" />
</td>
</tr>
<tr  style="display:none;">
<td style="font-size:16px;">Credit Card 2</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="cc28" id="cc28" value="0.00" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'paycash8','cc18')" />
</td>
</tr>
<tr style="display:none;">
<td style="font-size:16px;">Cash</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="paycash8" id="paycash8" value="0.00" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'cheq8','cc28')" />
</td>
</tr>
<tr style="display:none;">
<td style="font-size:16px;">Cheque</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="che8" id="cheq8" value="0.00" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'voucheramt8','paycash8')"/>
</td>
</tr>
<tr style="display:none;">
<td style="font-size:16px;">Voucher</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="voucheramt8" id="voucheramt8" value="0.00" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'depositamt8','cheq8')"/>
</td>
</tr>
<tr style="display:none;">
<td style="font-size:16px;">Deposit</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="depositamt8" id="depositamt8" value="0.00" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'cashc8','voucheramt8')"/>
</td>
</tr>
<tr style="display:none;">
<td style="font-size:16px;">Cash Card</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="cashc8" id="cashc8" value="0.00" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'','depositamt8')"/>
</td>
</tr>
<tr style="display:none;">
<td style="font-size:16px;">Balance</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="balanceamt8" id="balanceamt8" style="font-size:16px; text-align:right" value="#numberformat(val(url.grandtotal),'.__')#" readonly="readonly" />
</td>
</tr>
<!--- <tr>
<td style="font-size:16px;">Remark</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<textarea name="rem9desp1" id="rem9desp1" rows="3" cols="25">
</textarea>
</td>
</tr> --->
<tr>
<td align="center" colspan="3"><input type="submit" name="sub_btn" id="sub_btn" value="Accept" style="font: large bolder;" /></td>
</tr>
</table>
</form>
</cfoutput>
</cfif> 