<cfform name="account_ledge" action="accountno.cfm?type=save" method="post">
	<table width="30%" align="center" class="data">
		<tr> 
		  	<td colspan="2" align="center">
				<input name="submit" type="submit" value="Save">
			  	<input name="reset" type="reset" value="Reset">
			</td>
		</tr>
	</table>
	<br/>
	<table width="30%" align="center" class="data">
		
		<tr onClick="javascript:shoh('sales_acc');">
			<th style="background-color:99CC00">Sales Related Account<img src="../../images/d.gif" name="imgsales_acc" align="center"></th>
		</tr>
		<tr>
			<table id="sales_acc" width="30%" align="center" class="data">
				<tr> 
		  			<th>Credit Sales Account</th>
		  			<td><cfinput name="creditsales" type="text" maxlength="8" size="9" value="#creditsales#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
		 			<th>Cash Sales Account</th>
		  			<td><cfinput name="cashsales" type="text" maxlength="8" size="9" value="#cashsales#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
		  			<th>Sales Return</th>
		  			<td><cfinput name="salesreturn" type="text" maxlength="8" size="9" value="#salesreturn#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
		  			<th>Sales Discount</th>
		  			<td><cfinput name="discsales" type="text" maxlength="8" size="9" value="#discsales#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
		  			<th>Sales TAX Account (GST)</th>
		  			<td><cfinput name="gstsales" type="text" maxlength="8" size="9" value="#gstsales#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
		  			<th>Misc Charges 1</th>
		  			<td><cfinput name="custmisc1" type="text" maxlength="8" size="9" value="#custmisc1#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
		  			<th>Misc Charges 2</th>
		  			<td><cfinput name="custmisc2" type="text" maxlength="8" size="9" value="#custmisc2#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
		  			<th>Misc Charges 3</th>
		  			<td><cfinput name="custmisc3" type="text" maxlength="8" size="9" value="#custmisc3#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
		  			<th>Misc Charges 4</th>
		  			<td><cfinput name="custmisc4" type="text" maxlength="8" size="9" value="#custmisc4#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
		  			<th>Misc Charges 5</th>
		  			<td><cfinput name="custmisc5" type="text" maxlength="8" size="9" value="#custmisc5#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
		  			<th>Misc Charges 6</th>
		  			<td><cfinput name="custmisc6" type="text" maxlength="8" size="9" value="#custmisc6#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
		  			<th>Misc Charges 7</th>
		  			<td><cfinput name="custmisc7" type="text" maxlength="8" size="9" value="#custmisc7#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
			</table>
		</tr>
	</table>
	<br/>
	<table width="30%" align="center" class="data">
		<tr onClick="javascript:shoh('purchase_acc');">
			<th style="background-color:99CC00">Purchase Related Account<img src="../../images/d.gif" name="imgpurchase_acc" align="center"></th>
		</tr>
		<tr>
			<table id="purchase_acc" width="30%" align="center" class="data">
				<tr> 
					<th>Purchase Account</th>
					<td><cfinput name="purchaseReceive" type="text" maxlength="8" size="9" value="#purchaseReceive#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
					<th>Purchase Return Account</th>
					<td><cfinput name="purchasereturn" type="text" maxlength="8" size="9" value="#purchasereturn#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
		  			<th>Purchase Discount Account</th>
		  			<td><cfinput name="discpur" type="text" maxlength="8" size="9" value="#discpur#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
		  			<th>Purchase TAX Account (GST)</th>
		  			<td><cfinput name="gstpurchase" type="text" maxlength="8" size="9" value="#gstpurchase#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
                <!--- ADD ON 27-07-2009 --->
        		<cfif lcase(hcomid) eq "mhsl_i">
					<tr> 
                        <th>NBT Account</th>
                        <td><cfinput name="nbt" type="text" maxlength="8" size="9" value="#nbt#" mask="????/???" onClick="javascript:this.select();"></td>
                    </tr>
				</cfif>
				<tr> 
		  			<th>Misc Charges 1</th>
		  			<td><cfinput name="suppmisc1" type="text" maxlength="8" size="9" value="#suppmisc1#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
		  			<th>Misc Charges 2</th>
		  			<td><cfinput name="suppmisc2" type="text" maxlength="8" size="9" value="#suppmisc2#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
		  			<th>Misc Charges 3</th>
		  			<td><cfinput name="suppmisc3" type="text" maxlength="8" size="9" value="#suppmisc3#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
		  			<th>Misc Charges 4</th>
		  			<td><cfinput name="suppmisc4" type="text" maxlength="8" size="9" value="#suppmisc4#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
		  			<th>Misc Charges 5</th>
		  			<td><cfinput name="suppmisc5" type="text" maxlength="8" size="9" value="#suppmisc5#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
		  			<th>Misc Charges 6</th>
		  			<td><cfinput name="suppmisc6" type="text" maxlength="8" size="9" value="#suppmisc6#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
				<tr> 
		  			<th>Misc Charges 7</th>
		  			<td><cfinput name="suppmisc7" type="text" maxlength="8" size="9" value="#suppmisc7#" mask="????/???" onClick="javascript:this.select();"></td>
				</tr>
			</table>
		</tr>
	</table>
	<br/>
	<table width="30%" align="center" class="data">
		<tr onClick="javascript:shoh('cash_acc');">
			<th style="background-color:99CC00">Sales Payment Mode<img src="../../images/d.gif" name="imgcash_acc" align="center"></th>
		</tr>
		<tr>
			<table id="cash_acc" width="30%" align="center" class="data">
			<tr> 
				<th>Cash Account</th>
				<td><cfinput name="cashaccount" type="text" maxlength="8" size="9" value="#cashaccount#" mask="????/???" onClick="javascript:this.select();"></td>
			</tr>
			<tr> 
				<th>Deposit Account</th>
				<td><cfinput name="depositaccount" type="text" maxlength="8" size="9" value="#depositaccount#" mask="????/???" onClick="javascript:this.select();"></td>
			</tr>
			<tr> 
				<th>Cheque Account</th>
				<td><cfinput name="chequeaccount" type="text" maxlength="8" size="9" value="#chequeaccount#" mask="????/???" onClick="javascript:this.select();"></td>
			</tr>
			<tr> 
				<th>Credit Card Account 1</th>
				<td><cfinput name="creditcardaccount1" type="text" maxlength="8" size="9" value="#creditcardaccount1#" mask="????/???" onClick="javascript:this.select();"></td>
			</tr>
			<tr> 
				<th>Credit Card Account 2</th>
				<td><cfinput name="creditcardaccount2" type="text" maxlength="8" size="9" value="#creditcardaccount2#" mask="????/???" onClick="javascript:this.select();"></td>
			</tr>
            <tr> 
				<th>Debit Card Account</th>
				<td><cfinput name="debitcardaccount" type="text" maxlength="8" size="9" value="#debitcardaccount#" mask="????/???" onClick="javascript:this.select();"></td>
			</tr>
			<tr> 
				<th>Cash Voucher Account</th>
				<td><cfinput name="cashvoucheraccount" type="text" maxlength="8" size="9" value="#cashvoucheraccount#" mask="????/???" onClick="javascript:this.select();"></td>
			</tr>
			<tr>
				<th style="background-color:CCCCCC">Withholding TAX Account</th>
				<td><cfinput name="withholdingtaxaccount" type="text" maxlength="8" size="9" value="#withholdingtaxaccount#" mask="????/???"  onClick="javascript:this.select();" readonly></td>
			</tr>
			</table>
		</tr>
	</table>
	<br/>
	<table width="30%" align="center" class="data">
		<tr> 
		  	<td colspan="2" align="center">
				<input name="submit" type="submit" value="Save">
			  	<input name="reset" type="reset" value="Reset">
			</td>
		</tr>
	</table>
</cfform>