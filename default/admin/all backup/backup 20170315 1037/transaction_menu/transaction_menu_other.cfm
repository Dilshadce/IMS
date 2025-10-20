<cfoutput>
<table align="center" class="data" width="50%">
	<tr bgcolor="999900">
		<td align="center"><strong>Condition For Updating Stock Balance</strong></td>
	</tr>
	<tr align="center">
		<td colspan="2">
			<cftextarea 
			name="condition_for_updating_stock_balance_formula" 
			value="#trim(get_transaction_menu_setting.condition_for_updating_stock_balance_formula)#"
			maxlength="500" 
			rows="10" 
			cols="80"
			readonly
			></cftextarea>
		</td>
	</tr>
</table>
</cfoutput>