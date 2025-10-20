<script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script type='text/javascript' src='/ajax/core/shortcut.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script language="javascript" type="text/javascript">
	function calculatetotal()
	{
	var gtamt = parseFloat(document.getElementById('hidgt').value);
	var cashamt = parseFloat(document.getElementById('paycash').value);
		if(document.getElementById('paycash').value == ""){cashamt = 0;}
		var cc1amt = parseFloat(document.getElementById('cc1').value);
		if(document.getElementById('cc1').value == ""){cc1amt = 0;}
		var cc2amt = parseFloat(document.getElementById('cc2').value);
		if(document.getElementById('cc2').value == ""){cc2amt = 0;}
		var dbcamt = parseFloat(document.getElementById('dbcd').value);
		if(document.getElementById('dbcd').value == ""){dbcamt = 0;}
		var cheqamt = parseFloat(document.getElementById('cheq').value);
		if(document.getElementById('cheq').value == ""){cheqamt = 0;}
		var voucheramt = parseFloat(document.getElementById('vouc').value);
		if(document.getElementById('vouc').value == ""){voucheramt = 0;}
		var depositamt = parseFloat(document.getElementById('deposit').value);
		if(document.getElementById('deposit').value == ""){depositamt = 0;}
		var cashcamt = parseFloat(document.getElementById('cashc').value);
		if(document.getElementById('cashc').value == ""){cashcamt = 0;}
		var payamt = cashamt + cc1amt + cc2amt + dbcamt + cheqamt + voucheramt + depositamt + cashcamt;
		if(gtamt-payamt > 0)
		{
		document.getElementById('balanceamt').value=(gtamt-payamt).toFixed(2);
		}
		else{
		document.getElementById('balanceamt').value='0.00';	
		}
		document.getElementById('change').value=(payamt-gtamt).toFixed(2);
	}
	
	function getdeposit()
	{
	<cfoutput>
	var depositurl = '/default/transaction/shelltran/getdepositajax.cfm?depositno='+document.getElementById("depositno").value;
	ajaxFunction(document.getElementById('getdepositajax'),depositurl);
	</cfoutput>
	setTimeout("updatedeposit();",300);
	setTimeout("calculatetotal();",300);
	
	}
	
	function addnewdeposit(deposit){
			myoption = document.createElement("OPTION");
			myoption.text = deposit;
			myoption.value = deposit;
			document.getElementById("depositno").options.add(myoption);
			var indexvalue = document.getElementById("depositno").length-1;
			document.getElementById("depositno").selectedIndex=indexvalue;
			setTimeout("getdeposit();",200);
		}
	
	function updatedeposit()
	{
	
	document.getElementById('deposit').value=((document.getElementById('hidcash').value*1)+(document.getElementById('hidcheq').value*1)+(document.getElementById('hidcrcd').value*1)+(document.getElementById('hidcrc2').value*1)+(document.getElementById('hiddbcd').value*1)+(document.getElementById('hidvouc').value*1)).toFixed(2);
	}
</script>
<cfquery name="gettran" datasource="#dts#">
SELECT * FROM artran where refno='#url.refno#' and type='#url.type#'
</cfquery>
<cfoutput>

<cfform action="paybillprocess.cfm" method="post" name="paybill"  id="paybill">
<h1>Payment</h1>
<table width="570px" align="center">
<tr>
<td width="250px" style="font-size:16px;" height="30px">Customer<input type="hidden" name="refno" id="refno" value="#listfirst(url.refno)#" /><input type="hidden" name="billtype" id="billtype" value="#listfirst(url.type)#" /></td>
<td width="20px" style="font-size:16px;">:</td>
<td width="300px" align="right" style="font-size:16px;">

#gettran.custno# - #gettran.name#
</td>
</tr>
<tr <cfif lcase(hcomid) neq 'ltm_i'>style="display:none"</cfif>>
<td width="250px" style="font-size:16px;" height="30px">Ref No 2</td>
<td>:</td>
<td width="300px" align="right" style="font-size:16px;">
<input type="text" name="refno2" id="refno2" value="#gettran.refno2#" style="font-size:16px;" maxlength="30" />
</td>
</tr>
<tr>
<td width="250px" style="font-size:16px;" height="30px">TOTAL</td>
<td width="20px" style="font-size:16px;">:</td>
<td width="300px" align="right" style="font-size:16px;">#numberformat(gettran.grand_bil,',.__')#<input type="hidden" name="hidgt" id="hidgt" value="#numberformat(gettran.grand_bil,'.__')#" /></td>
</tr>
<tr>
<td style="font-size:16px; color:##000;">Cash</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="paycash" id="paycash" style="font-size:16px; text-align:right" value="#numberformat(gettran.cs_pm_cash,'.__')#" onkeyup="calculatetotal()"/>
</td>
</tr>
<tr>
<td style="font-size:16px;">Credit Card 1</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="cc1" id="cc1" value="#numberformat(gettran.cs_pm_crcd,'.__')#" style="font-size:16px; text-align:right" onkeyup="calculatetotal()" />
</td>
</tr>
<tr>
<td colspan="3">
<input type="radio" name="cctype1" id="cctype1MASTER" value="MASTER" <cfif gettran.creditcardtype1 eq '' or gettran.creditcardtype1 eq 'MASTER'>checked="checked"</cfif>/>Mastercard&nbsp;&nbsp;&nbsp;
<input type="radio" name="cctype1" id="cctype1VISA" value="VISA" <cfif gettran.creditcardtype1 eq 'VISA'>checked="checked"</cfif>/>Visa&nbsp;&nbsp;&nbsp;
<input type="radio" name="cctype1" id="cctype1AMEX" value="AMEX" <cfif gettran.creditcardtype1 eq 'AMEX'>checked="checked"</cfif>/>American Express&nbsp;&nbsp;
<input type="radio" name="cctype1" id="cctype1DINERS" value="DINERS" <cfif gettran.creditcardtype1 eq 'DINERS'>checked="checked"</cfif>/>Diners Club
</td>
</tr>
<tr>
<td style="font-size:16px;">Credit Card 2</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="cc2" id="cc2" value="#numberformat(gettran.cs_pm_crc2,'.__')#" style="font-size:16px; text-align:right" onkeyup="calculatetotal()" />
</td>
</tr>
<tr>
<td colspan="3">
<input type="radio" name="cctype2" id="cctype2MASTER" value="MASTER" <cfif gettran.creditcardtype2 eq '' or gettran.creditcardtype2 eq 'MASTER'>checked="checked"</cfif>/>Mastercard&nbsp;&nbsp;&nbsp;
<input type="radio" name="cctype2" id="cctype2VISA" value="VISA" <cfif gettran.creditcardtype2 eq 'VISA'>checked="checked"</cfif>/>Visa&nbsp;&nbsp;&nbsp;
<input type="radio" name="cctype2" id="cctype2AMEX" value="AMEX" <cfif gettran.creditcardtype2 eq 'AMEX'>checked="checked"</cfif>/>American Express&nbsp;&nbsp;
<input type="radio" name="cctype2" id="cctype2DINERS" value="DINERS" <cfif gettran.creditcardtype2 eq 'DINERS'>checked="checked"</cfif>/>Diners Club
</td>
</tr>
<tr>
<td style="font-size:16px;">NETS</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="dbcd" id="dbcd" value="#numberformat(gettran.cs_pm_dbcd,'.__')#" style="font-size:16px; text-align:right" onkeyup="calculatetotal()" />
</td>
</tr>
<tr>
<td style="font-size:16px;">Cheque</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="cheq" id="cheq" value="#numberformat(gettran.cs_pm_cheq,'.__')#" style="font-size:16px; text-align:right" onkeyup="calculatetotal()"/>
</td>
</tr>
<tr>
<td colspan="3">
Cheque No. <input type="text" name="chequeno" id="chequeno" value="#gettran.checkno#" />
</td>
</tr>
<tr>
<td style="font-size:16px;"><cfif lcase(hcomid) eq "guankeat_i">Discount<cfelse>Voucher</cfif></td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="vouc" id="vouc" value="#numberformat(gettran.cs_pm_vouc,'.__')#" style="font-size:16px; text-align:right" onkeyup="calculatetotal()"/>
</td>
</tr>
<tr>
<td style="font-size:16px;">Deposit</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="deposit" id="deposit" value="#numberformat(gettran.deposit,'.__')#" style="font-size:16px; text-align:right" onkeyup="calculatetotal(event,'cashc6','voucheramt6')"/>
</td>
</tr>
<tr>
<td colspan="3">
<div id="getdepositajax"></div>
Deposit No :&nbsp;
<cfquery name="checkdeposit" datasource="#dts#">
SELECT * from deposit where billno='#gettran.refno#'
</cfquery>
<cfset xdepositno=''>
<cfif checkdeposit.recordcount neq 0>
<cfset xdepositno=checkdeposit.depositno>
</cfif>
<cfquery name="getdepositno" datasource="#dts#">
SELECT * from deposit where billno='' or billno is null or billno='#gettran.refno#' order by depositno
</cfquery>
<select name="depositno" id="depositno" onchange="getdeposit();" style="width:500;">
<option value="">Choose a Deposit No</option>
<cfloop query="getdepositno">
<option value="#getdepositno.depositno#" <cfif xdepositno eq getdepositno.depositno>selected</cfif>>#getdepositno.depositno# - #getdepositno.desp#</option>
</cfloop>
</select>

</td>
</tr>
<tr>
<td style="font-size:16px;">Cash Card</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="cashc" id="cashc" value="#numberformat(gettran.cs_pm_cashcd,'.__')#" style="font-size:16px; text-align:right" onkeyup="calculatetotal()"/>
</td>
</tr>
<tr>
<td style="font-size:16px;">Balance</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="balanceamt" id="balanceamt" value="#numberformat(val(gettran.grand_bil)-val(gettran.cs_pm_cash),'.__')#" style="font-size:16px; text-align:right" readonly="readonly"/>
</td>
</tr>
<tr>
<td style="font-size:16px;">Changes</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="change" id="change" style="font-size:16px; text-align:right" value="#numberformat(gettran.cs_pm_debt*-1,'.__')#" readonly="readonly" />
</td>
</tr>

<tr>
<td align="center" colspan="3"><input type="button" name="cancelbtn" id="cancelbtn" value="Cancel" style="font: large bolder;" onclick="window.close();"/>&nbsp;&nbsp;&nbsp;<input type="submit" name="sub_btn" id="sub_btn" value="Accept" style="font: large bolder;" /></td>
</tr>
</table>
</cfform>

</cfoutput>

