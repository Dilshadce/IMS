<cfif isdefined('url.grandtotal')>

<cfquery name="getCreditCard" datasource='#dts#'>
  	SELECT cardName
    FROM creditCard;
</cfquery>

<cfoutput>
<cfset url.grandtotal = numberformat((numberformat(val(url.grandtotal)* 2,'._')/2),'.__')>
<form action="processprint.cfm" method="post" onsubmit="if(document.getElementById('change5').value*1 < 0){alert('Payment is not Enough');return false;}else if(document.getElementById('cheq5').value*1 >document.getElementById('accumpoints').value*1){alert('Points is Over');return false;}else{submitpay();document.getElementById('sub_btn').disabled=true;return false;}" name="ccform5"  id="ccform5">
<table width="570px" >
<tr>
<td width="250px" style="font-size:24px;" height="30px">TOTAL</td>
<td width="20px" style="font-size:24px;">:</td>
<td width="300px" align="right" style="font-size:24px;">#numberformat(url.grandtotal,',.__')#<input type="hidden" name="hidgt5" id="hidgt5" value="#numberformat(url.grandtotal,'.__')#"  /><input type="hidden" name="payamt5" id="payamt5" value="0"  /></td>
</tr>
<tr>
<td colspan="3">&nbsp;</td>
</tr>
<tr>
<td style="font-size:24px; color:##000;">Cash</td>
<td style="font-size:24px;">:</td>
<td style="font-size:24px;" align="right">
<input type="text" name="paycash5" id="paycash5" style="font: large bolder; text-align:right" value="0.00" onkeyup="calculatetotal(event,'cc15','')"/>
</td>
</tr>
<tr>
<td colspan="3">&nbsp;</td>
</tr>
<tr>
<td style="font-size:24px;">Balance</td>
<td style="font-size:24px;">:</td>
<td style="font-size:24px;" align="right">
<input type="text" name="balanceamt5" id="balanceamt5" value="#numberformat(url.grandtotal,'.__')#" style="font: large bolder; text-align:right" readonly="readonly"/>
</td>
</tr>
</tr>
<tr>
<th colspan="100%"><div align="center">Multi Payment</div></th>
</tr>
<tr>
<td style="font-size:16px;">Credit Card 1</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="cc15" id="cc15" value="0.00" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'cc25','paycash5')" />
</td>
</tr>
<tr>
<td colspan="3">

<cfloop query="getCreditCard">
	<input type="radio" name="cctype15" id="cctype15" value="#getCreditCard.cardName#" />#getCreditCard.cardName#&nbsp;&nbsp;
</cfloop>

<!---<input type="radio" name="cctype15" id="cctype15" value="VISA" checked="checked"/>Visa&nbsp;&nbsp;&nbsp;
<input type="radio" name="cctype15" id="cctype15" value="MASTER" />Mastercard&nbsp;&nbsp;&nbsp;
<input type="radio" name="cctype15" id="cctype15" value="AMEX" />American Express&nbsp;&nbsp;
<input type="radio" name="cctype15" id="cctype15" value="DINERS" />Diners Club--->
</td>
</tr>
<tr>
<td style="font-size:16px;">Credit Card 2</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="cc25" id="cc25" value="0.00" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'dbc5','cc15')" />
</td>
</tr>
<tr>
<td colspan="3">

<cfloop query="getCreditCard">
	<input type="radio" name="cctype25" id="cctype25" value="#getCreditCard.cardName#" />#getCreditCard.cardName#&nbsp;&nbsp;
</cfloop>

<!---<input type="radio" name="cctype25" id="cctype25" value="VISA" checked="checked"/>Visa&nbsp;&nbsp;&nbsp;
<input type="radio" name="cctype25" id="cctype25" value="MASTER"/>Mastercard&nbsp;&nbsp;&nbsp;
<input type="radio" name="cctype25" id="cctype25" value="AMEX" />American Express&nbsp;&nbsp;
<input type="radio" name="cctype25" id="cctype25" value="DINERS" />Diners Club--->
</td>
</tr>
<tr>
<td style="font-size:16px;">NETS</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="dbc5" id="dbc5" value="0.00" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'cheq5','cc25')" />
</td>
</tr>
<tr>
<td style="font-size:16px;">Points</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="cheq5" id="cheq5" value="0.00" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'voucheramt5','dbc5')"/>
</td>
</tr>
<cftry>
<tr>
<cfquery name="getpoints" datasource="#dts#">
select ifnull(pointsbf+points-pointsredeem,0) as points from driver where driverno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.driverno#">
</cfquery>
<td>Accumulated Point</td>
<td style="font-size:16px;">:</td>
<td align="right" style="font-size:16px;"><b>#numberformat(getpoints.points,'.__')#</b><input type="hidden" name="text" id="accumpoints" value="#getpoints.points#" readonly style="font-size:16px; text-align:right"/>
</td>
</tr>
<input type="hidden" name="chequeno5" id="chequeno5" value="" />
<cfcatch>
<tr>
<td colspan="3">
Cheque No. <input type="text" name="chequeno5" id="chequeno5" value="" />
<input type="hidden" name="accumpoints" id="accumpoints" value="9999999999" readonly style="font-size:16px; text-align:right"/>
</td>
</tr>
</cfcatch>
</cftry>
<tr>
<td style="font-size:16px;">Voucher</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="voucheramt5" id="voucheramt5" value="0.00" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'depositamt5','cheq5')"/>
</td>
</tr>
<tr>
<td style="font-size:16px;">Deposit</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="depositamt5" id="depositamt5" value="0.00" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'cashc5','voucheramt5')"/>
</td>
</tr>
<tr>
<td style="font-size:16px;">Cash Card</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="cashc5" id="cashc5" value="0.00" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'','depositamt5')"/>
</td>
</tr>
<tr>
<td style="font-size:16px;"><cfif lcase(hcomid) eq "amgworld_i">Trade In<cfelse>TTamt</cfif></td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="tt5" id="tt5" value="#numberformat(val(url.TT),'.__')#" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'','tt5')"/>
</td>
</tr>
<tr>
<td style="font-size:16px;">Changes</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="change5" id="change5" style="font-size:16px; text-align:right" value="#numberformat((val(url.grandtotal)-val(url.TT))*-1,'.__')#" readonly="readonly" />
</td>
</tr>
<!--- <tr>
<td style="font-size:16px;">Remark</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<textarea name="rem9desp5" id="rem9desp5" rows="3" cols="25">
</textarea>
</td>
</tr> --->
<tr>
<td align="center" colspan="3"><input type="submit" name="sub_btn" id="sub_btn" value="Accept" style="font: large bolder;" /></td>
</tr>
</table>
</form>
<script type="text/javascript">
setTimeout("document.getElementById('paycash5').focus();document.getElementById('paycash5').select();",250);
</script>
</cfoutput>
</cfif> 