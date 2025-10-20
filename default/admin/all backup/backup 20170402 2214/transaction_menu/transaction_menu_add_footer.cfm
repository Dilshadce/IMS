<cfoutput>
<table align="center" class="data" width="50%">
	<tr bgcolor="999900">
		<td align="center"><strong>Add Footer</strong></td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="compulsory_footer" type="checkbox" value="Y" #iif(get_transaction_menu_setting.compulsory_footer eq "Y",DE("checked"),DE(""))# disabled>
			Compulsory Footer
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="exchange_rate_on_invoice_total" type="checkbox" value="Y" #iif(get_transaction_menu_setting.exchange_rate_on_invoice_total eq "Y",DE("checked"),DE(""))# disabled>
			Exchange Rate On Invoice Total
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="dis2_discount_on_invoice_net_discount" type="checkbox" value="Y" #iif(get_transaction_menu_setting.dis2_discount_on_invoice_net_discount eq "Y",DE("checked"),DE(""))# disabled>
			Dis 2 : Discount on Invoice Net + Discount
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="tax2_tax_on_invoice_net_tax" type="checkbox" value="Y" #iif(get_transaction_menu_setting.tax2_tax_on_invoice_net_tax eq "Y",DE("checked"),DE(""))# disabled>
			Tax 2 : Tax On Invoice Net + Tax
		</td>
	</tr>
</table>
</cfoutput>