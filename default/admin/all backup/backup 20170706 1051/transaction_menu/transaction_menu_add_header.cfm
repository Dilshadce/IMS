<cfoutput>
<table align="center" class="data" width="50%">
	<tr bgcolor="999900">
		<td align="center"><strong>Add Header</strong></td>
	</tr>
	<tr bgcolor="999999">
		<td>
			Increase Period By One On After Day ->
			<cfinput name="increase_period_by_one_on_after_day" type="text" value="#get_transaction_menu_setting.increase_period_by_one_on_after_day#" disabled>
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="use_only_1_set_invoice_no" type="checkbox" value="Y" #iif(get_transaction_menu_setting.use_only_1_set_invoice_no eq "Y",DE("checked"),DE(""))# disabled>
			Use only 1 Set Invoice No
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="use_only_1_set_do_no" type="checkbox" value="Y" #iif(get_transaction_menu_setting.use_only_1_set_do_no eq "Y",DE("checked"),DE(""))# disabled>
			Use Only 1 Set DO No
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="allowed_edit_exported_bill" type="checkbox" value="Y" #iif(get_transaction_menu_setting.allowed_edit_exported_bill eq "Y",DE("checked"),DE(""))# disabled>
			Allowed Edit Exported Bill
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="standard_auto_running" type="checkbox" value="Y" #iif(get_transaction_menu_setting.standard_auto_running eq "Y",DE("checked"),DE(""))# disabled>
			Standard Auto Running
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="project_by_bill" type="checkbox" value="Y" #iif(get_transaction_menu_setting.project_by_bill eq "Y",DE("checked"),DE(""))# disabled>
			Project By Bill
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="with_bill_agent" type="checkbox" value="Y" #iif(get_transaction_menu_setting.with_bill_agent eq "Y",DE("checked"),DE(""))# disabled>
			With Bill Agent
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="with_site" type="checkbox" value="Y" #iif(get_transaction_menu_setting.with_site eq "Y",DE("checked"),DE(""))# disabled>
			With Site
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="search_transaction_date" type="checkbox" value="Y" #iif(get_transaction_menu_setting.search_transaction_date eq "Y",DE("checked"),DE(""))# disabled>
			Search Transaction Date
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="allow_edit_name" type="checkbox" value="Y" #iif(get_transaction_menu_setting.allow_edit_name eq "Y",DE("checked"),DE(""))# disabled>
			Allow Edit Name
		</td>
	</tr>
	<tr bgcolor="999999">
		<td>
			<input name="so_has_to_be_verify" type="checkbox" value="Y" #iif(get_transaction_menu_setting.so_has_to_be_verify eq "Y",DE("checked"),DE(""))# disabled>
			SO Has To Be Verify
		</td>
	</tr>
</table>
</cfoutput>