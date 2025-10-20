<cfoutput>
<table align="center" class="data" width="50%">
	<tr bgcolor="999900">
		<td align="center"><strong>Add Body</strong></td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="with_per_item_tax" type="checkbox" value="Y" #iif(get_transaction_menu_setting.with_per_item_tax eq "Y",DE("checked"),DE(""))# disabled>
			With Per Item Tax ->
			<cfinput name="with_per_item_tax_formula" type="text" value="#get_transaction_menu_setting.with_per_item_tax_formula#" maxlength="2" size="5" readonly>
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="with_per_item_discount" type="checkbox" value="Y" #iif(get_transaction_menu_setting.with_per_item_discount eq "Y",DE("checked"),DE(""))# disabled>
			With Per Item Discount
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="with_price_in_do" type="checkbox" value="Y" #iif(get_transaction_menu_setting.with_price_in_do eq "Y",DE("checked"),DE(""))# disabled>
			With Price In DO
		</td>
	</tr>
	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
		<td>
			<input name="compulsory_location" type="checkbox" value="Y" #iif(get_transaction_menu_setting.compulsory_location eq "Y",DE("checked"),DE(""))#>
			Compulsory Location
            <input name="compulsory_location2" type="text" value="#get_transaction_menu_setting.compulsory_location2#">
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="allow_edit_amount" type="checkbox" value="Y" #iif(get_transaction_menu_setting.allow_edit_amount eq "Y",DE("checked"),DE(""))# disabled>
			Allow Edit Amount
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="batch_code_other_charges" type="checkbox" value="Y" #iif(get_transaction_menu_setting.batch_code_other_charges eq "Y",DE("checked"),DE(""))# disabled>
			Batch Code Other Charges
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="allow_change_in_2nd_unit_factor" type="checkbox" value="Y" #iif(get_transaction_menu_setting.allow_change_in_2nd_unit_factor eq "Y",DE("checked"),DE(""))# disabled>
			Allow Change In 2nd Unit Factor
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="allow_create_code_during_transaction" type="checkbox" value="Y" #iif(get_transaction_menu_setting.allow_create_code_during_transaction eq "Y",DE("checked"),DE(""))# disabled>
			Allow Create Code During Transaction
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="display_cost_code_during_transaction" type="checkbox" value="Y" #iif(get_transaction_menu_setting.display_cost_code_during_transaction eq "Y",DE("checked"),DE(""))# disabled>
			Display Cost Code During Transaction
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="transfer_note_based_on_selling_price" type="checkbox" value="Y" #iif(get_transaction_menu_setting.transfer_note_based_on_selling_price eq "Y",DE("checked"),DE(""))# disabled>
			Transfer Note Based On Selling Price
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="compulsory_serial_no" type="checkbox" value="Y" #iif(get_transaction_menu_setting.compulsory_serial_no eq "Y",DE("checked"),DE(""))# disabled>
			Compulsory Serial No
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="allow_qty_rc_exceed_qty_outstand_po" type="checkbox" value="Y" #iif(get_transaction_menu_setting.allow_qty_rc_exceed_qty_outstand_po eq "Y",DE("checked"),DE(""))# disabled>
			Allow Qty RC Exceed qty Outstand PO
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="3_level_discount" type="checkbox" value="Y" #iif(get_transaction_menu_setting.3_level_discount eq "Y",DE("checked"),DE(""))# disabled>
			3 Level Discount
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="default_service" type="checkbox" value="Y" #iif(get_transaction_menu_setting.default_service eq "Y",DE("checked"),DE(""))# disabled>
			Default Service
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="default_change_unit" type="checkbox" value="Y" #iif(get_transaction_menu_setting.default_change_unit eq "Y",DE("checked"),DE(""))# disabled>
			Default Change Unit
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="round_off_on_item_discount" type="checkbox" value="Y" #iif(get_transaction_menu_setting.round_off_on_item_discount eq "Y",DE("checked"),DE(""))# disabled>
			Round Off On Item Discount
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="round_down_on_item_amount" type="checkbox" value="Y" #iif(get_transaction_menu_setting.round_down_on_item_amount eq "Y",DE("checked"),DE(""))# disabled>
			Round Down On Item Amount
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="update_latest_prices" type="checkbox" value="Y" #iif(get_transaction_menu_setting.update_latest_prices eq "Y",DE("checked"),DE(""))# disabled>
			Update Latest Prices ->
			<cfinput name="update_latest_prices_formula" type="text" value="#get_transaction_menu_setting.update_latest_prices_formula#" maxlength="100" size="50" readonly>
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="category_of_discount" type="radio" value="1" #iif(get_transaction_menu_setting.category_of_discount eq "1",DE("checked"),DE(""))# disabled>
			1. Get Category Discount Percentage From Customer.<br/>
			<input name="category_of_discount" type="radio" value="2" #iif(get_transaction_menu_setting.category_of_discount eq "2",DE("checked"),DE(""))# disabled>
			2. Get Category Price & Discount Percentage From Item.<br/>
			<input name="category_of_discount" type="radio" value="3" #iif(get_transaction_menu_setting.category_of_discount eq "3",DE("checked"),DE(""))# disabled>
			3. Get Discount Percentage From Transaction.
		</td>
	</tr>
</table>
</cfoutput>