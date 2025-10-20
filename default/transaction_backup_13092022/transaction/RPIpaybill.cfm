<cfajaximport tags="cfform">
<script type='text/javascript' src='/ajax/core/engine.js'></script>
	<script type='text/javascript' src='/ajax/core/util.js'></script>
	<script type='text/javascript' src='/ajax/core/settings.js'></script>
    <script type='text/javascript' src='/ajax/core/shortcut.js'></script>
    <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
<script language="javascript" type="text/javascript">
	function getDepositCount()
	{
	var gtamt = parseFloat(document.getElementById('hidgt').value);
		var depositamt = parseFloat(document.getElementById('deposit').value);
		if(document.getElementById('deposit').value == ""){depositamt = 0;}
		
		var payamt = depositamt;
		document.getElementById('change').value=(payamt-gtamt).toFixed(2);
	}
</script>
<cfquery name="gettran" datasource="#dts#">
SELECT * FROM artran where refno='#url.refno#' and type='#url.type#'
</cfquery>
<cfoutput>

<cfform action="RPIpaybillprocess.cfm" method="post" name="paybill"  id="paybill">
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
<td style="font-size:16px;">Deposit</td>
<td style="font-size:16px;">:</td>
<td style="font-size:16px;" align="right">
<input type="text" name="deposit" id="deposit" value="#numberformat(gettran.deposit,'.__')#" style="font-size:16px; text-align:right" onkeyup="getDepositCount()"/>
<input type="button" name="rpiaddbtn" id="rpiaddbtn" value="+" onClick="javascript:ColdFusion.Window.show('rpipaymentwindow');">
            
            
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
<cfwindow center="true" width="600" height="400" name="rpipaymentwindow" refreshOnShow="true" closable="false" modal="true" title="Add Deposit" initshow="false" source="/default/transaction/rpipayment.cfm?type=#type#&refno=#refno#" />
</cfoutput>

