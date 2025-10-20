<cfquery name="getgldata" datasource="#replace(dts,'_i','_a','all')#">
	select accno,desp,desp2 
	from gldata 
	where accno not in (select custno from arcust order by custno) 
	and accno not in (select custno from apvend order by custno)
	order by accno;
</cfquery>

<cfform name="account_ledge" action="accountno.cfm?type=save" method="post">
	<table width="50%" align="center" class="data">
		<tr> 
		  	<td colspan="2" align="center">
				<input name="submit" type="submit" value="Save">
			  	<input name="reset" type="reset" value="Reset">
			</td>
		</tr>
	</table>
	<br/>
	<table width="50%" align="center" class="data">
		<tr onClick="javascript:shoh('sales_acc');">
			<th style="background-color:99CC00">Sales Related Account<img src="../../images/d.gif" name="imgsales_acc" align="center"></th>
		</tr>
		<tr>
			<cfoutput>
			<table id="sales_acc" width="50%" align="center" class="data">
				<tr> 
		  			<th>Credit Sales Account</th>
		  			<td>
						<select name="creditsales">
							<option value="0000/000" #iif((creditsales eq "" or creditsales eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((creditsales eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
		 			<th>Cash Sales Account</th>
		  			<td>
						<select name="cashsales">
							<option value="0000/000" #iif((cashsales eq "" or cashsales eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((cashsales eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
		  			<th>Sales Return</th>
		  			<td>
						<select name="salesreturn">
							<option value="0000/000" #iif((salesreturn eq "" or salesreturn eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((salesreturn eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
		  			<th>Sales Discount</th>
		  			<td>
						<select name="discsales">
							<option value="0000/000" #iif((discsales eq "" or discsales eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((discsales eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
		  			<th>Sales TAX Account (GST)</th>
		  			<td>
						<select name="gstsales">
							<option value="0000/000" #iif((gstsales eq "" or gstsales eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((gstsales eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
		  			<th>Misc Charges 1</th>
		  			<td>
						<select name="custmisc1">
							<option value="0000/000" #iif((custmisc1 eq "" or custmisc1 eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((custmisc1 eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
		  			<th>Misc Charges 2</th>
		  			<td>
						<select name="custmisc2">
							<option value="0000/000" #iif((custmisc2 eq "" or custmisc2 eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((custmisc2 eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
		  			<th>Misc Charges 3</th>
		  			<td>
						<select name="custmisc3">
							<option value="0000/000" #iif((custmisc3 eq "" or custmisc3 eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((custmisc3 eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
		  			<th>Misc Charges 4</th>
		  			<td>
						<select name="custmisc4">
							<option value="0000/000" #iif((custmisc4 eq "" or custmisc4 eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((custmisc4 eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
		  			<th>Misc Charges 5</th>
		  			<td>
						<select name="custmisc5">
							<option value="0000/000" #iif((custmisc5 eq "" or custmisc5 eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((custmisc5 eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
		  			<th>Misc Charges 6</th>
		  			<td>
						<select name="custmisc6">
							<option value="0000/000" #iif((custmisc6 eq "" or custmisc6 eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((custmisc6 eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
		  			<th>Misc Charges 7</th>
		  			<td>
						<select name="custmisc7">
							<option value="0000/000" #iif((custmisc7 eq "" or custmisc7 eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((custmisc7 eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
			</table>
		</tr>
	</table>
	<br/>
	<table width="50%" align="center" class="data">
		<tr onClick="javascript:shoh('purchase_acc');">
			<th style="background-color:99CC00">Purchase Related Account<img src="../../images/d.gif" name="imgpurchase_acc" align="center"></th>
		</tr>
		<tr>
			<table id="purchase_acc" width="50%" align="center" class="data">
				<tr> 
					<th>Purchase Account</th>
					<td>
						<select name="purchaseReceive">
							<option value="0000/000" #iif((purchaseReceive eq "" or purchaseReceive eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((purchaseReceive eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
					<th>Purchase Return Account</th>
					<td>
						<select name="purchasereturn">
							<option value="0000/000" #iif((purchasereturn eq "" or purchasereturn eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((purchasereturn eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
		  			<th>Purchase Discount Account</th>
		  			<td>
						<select name="discpur">
							<option value="0000/000" #iif((discpur eq "" or discpur eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((discpur eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
		  			<th>Purchase TAX Account (GST)</th>
		  			<td>
						<select name="gstpurchase">
							<option value="0000/000" #iif((gstpurchase eq "" or gstpurchase eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((gstpurchase eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
                <!--- ADD ON 27-07-2009 --->
        		<cfif lcase(hcomid) eq "mhsl_i">
					<tr> 
                        <th>NBT Account</th>
                        <td>
                            <select name="nbt">
                                <option value="0000/000" #iif((nbt eq "" or nbt eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
                                <cfloop query="getgldata">
                                    <option value="#getgldata.accno#" #iif((nbt eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
                                </cfloop>
                            </select>
                        </td>
                    </tr>
				</cfif>
				<tr> 
		  			<th>Misc Charges 1</th>
		  			<td>
						<select name="suppmisc1">
							<option value="0000/000" #iif((suppmisc1 eq "" or suppmisc1 eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((suppmisc1 eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
		  			<th>Misc Charges 2</th>
		  			<td>
						<select name="suppmisc2">
							<option value="0000/000" #iif((suppmisc2 eq "" or suppmisc2 eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((suppmisc2 eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
		  			<th>Misc Charges 3</th>
		  			<td>
						<select name="suppmisc3">
							<option value="0000/000" #iif((suppmisc3 eq "" or suppmisc3 eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((suppmisc3 eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
		  			<th>Misc Charges 4</th>
		  			<td>
						<select name="suppmisc4">
							<option value="0000/000" #iif((suppmisc4 eq "" or suppmisc4 eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((suppmisc4 eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
		  			<th>Misc Charges 5</th>
		  			<td>
						<select name="suppmisc5">
							<option value="0000/000" #iif((suppmisc5 eq "" or suppmisc5 eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((suppmisc5 eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
		  			<th>Misc Charges 6</th>
		  			<td>
						<select name="suppmisc6">
							<option value="0000/000" #iif((suppmisc6 eq "" or suppmisc6 eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((suppmisc6 eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr> 
		  			<th>Misc Charges 7</th>
		  			<td>
						<select name="suppmisc7">
							<option value="0000/000" #iif((suppmisc7 eq "" or suppmisc7 eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
							<cfloop query="getgldata">
								<option value="#getgldata.accno#" #iif((suppmisc7 eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
							</cfloop>
						</select>
					</td>
				</tr>
			</table>
		</tr>
	</table>
	<br/>
	<table width="50%" align="center" class="data">
		<tr onClick="javascript:shoh('cash_acc');">
			<th style="background-color:99CC00">Sales Payment Mode<img src="../../images/d.gif" name="imgcash_acc" align="center"></th>
		</tr>
		<tr>
			<table id="cash_acc" width="50%" align="center" class="data">
			<tr> 
				<th>Cash Account</th>
				<td>
					<select name="cashaccount">
						<option value="0000/000" #iif((cashaccount eq "" or cashaccount eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
						<cfloop query="getgldata">
							<option value="#getgldata.accno#" #iif((cashaccount eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
						</cfloop>
					</select>
				</td>
			</tr>
			<tr> 
				<th>Deposit Account</th>
				<td>
					<select name="depositaccount">
						<option value="0000/000" #iif((depositaccount eq "" or depositaccount eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
						<cfloop query="getgldata">
							<option value="#getgldata.accno#" #iif((depositaccount eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
						</cfloop>
					</select>
				</td>
			</tr>
			<tr> 
				<th>Cheque Account</th>
				<td>
					<select name="chequeaccount">
						<option value="0000/000" #iif((chequeaccount eq "" or chequeaccount eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
						<cfloop query="getgldata">
							<option value="#getgldata.accno#" #iif((chequeaccount eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
						</cfloop>
					</select>
				</td>
			</tr>
			<tr> 
				<th>Credit Card Account 1</th>
				<td>
					<select name="creditcardaccount1">
						<option value="0000/000" #iif((creditcardaccount1 eq "" or creditcardaccount1 eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
						<cfloop query="getgldata">
							<option value="#getgldata.accno#" #iif((creditcardaccount1 eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
						</cfloop>
					</select>
				</td>
			</tr>
			<tr> 
				<th>Credit Card Account 2</th>
				<td>
					<select name="creditcardaccount2">
						<option value="0000/000" #iif((creditcardaccount2 eq "" or creditcardaccount2 eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
						<cfloop query="getgldata">
							<option value="#getgldata.accno#" #iif((creditcardaccount2 eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
						</cfloop>
					</select>
				</td>
			</tr>
            <tr> 
				<th>Debit Card Account</th>
				<td>
					<select name="debitcardaccount">
						<option value="0000/000" #iif((debitcardaccount eq "" or debitcardaccount eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
						<cfloop query="getgldata">
							<option value="#getgldata.accno#" #iif((debitcardaccount eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
						</cfloop>
					</select>
				</td>
			</tr>
			<tr> 
				<th>Cash Voucher Account</th>
				<td>
					<select name="cashvoucheraccount">
						<option value="0000/000" #iif((cashvoucheraccount eq "" or cashvoucheraccount eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
						<cfloop query="getgldata">
							<option value="#getgldata.accno#" #iif((cashvoucheraccount eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
						</cfloop>
					</select>
				</td>
			</tr>
			<tr>
				<th style="background-color:CCCCCC">Withholding TAX Account</th>
				<td>
					<select name="withholdingtaxaccount">
						<option value="0000/000" #iif((withholdingtaxaccount eq "" or withholdingtaxaccount eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
						<!--- <cfloop query="getgldata">
							<option value="#getgldata.accno#" #iif((withholdingtaxaccount eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
						</cfloop> --->
					</select>
				</td>
			</tr>
            <tr> 
				<th>Bank Account (For Deposit Function)</th>
				<td>
					<select name="bankaccount">
						<option value="0000/000" #iif((bankaccount eq "" or bankaccount eq "0000/000"),DE("selected"),DE(""))#>0000/000</option>
						<cfloop query="getgldata">
							<option value="#getgldata.accno#" #iif((bankaccount eq getgldata.accno),DE("selected"),DE(""))#>#getgldata.accno# - #getgldata.desp# - #getgldata.desp2#</option>
						</cfloop>
					</select>
				</td>
			</tr>
            
			</table>
			</cfoutput>
		</tr>
	</table>
	<br/>
	<table width="50%" align="center" class="data">
		<tr> 
		  	<td colspan="2" align="center">
				<input name="submit" type="submit" value="Save">
			  	<input name="reset" type="reset" value="Reset">
			</td>
		</tr>
	</table>
</cfform>