<cfparam name="form.company_id" 									default="IMS" 												type="any">
<cfparam name="form.increase_period_by_one_on_after_day"			default="0" 												type="any">
<cfparam name="form.use_only_1_set_invoice_no" 						default="Y" 												type="any">
<cfparam name="form.use_only_1_set_do_no" 							default="Y" 												type="any">
<cfparam name="form.allowed_edit_exported_bill" 					default="" 													type="any">
<cfparam name="form.standard_auto_running" 							default="Y" 												type="any">
<cfparam name="form.project_by_bill" 								default="" 													type="any">
<cfparam name="form.with_bill_agent" 								default="" 													type="any">
<cfparam name="form.with_site" 										default="" 													type="any">
<cfparam name="form.search_transaction_date" 						default="" 													type="any">
<cfparam name="form.allow_edit_name" 								default="Y" 												type="any">
<cfparam name="form.so_has_to_be_verify" 							default="" 													type="any">
<cfparam name="form.with_per_item_tax" 								default="" 													type="any">
<cfparam name="form.with_per_item_tax_formula" 						default="" 													type="any">
<cfparam name="form.with_per_item_discount" 						default="" 													type="any">
<cfparam name="form.with_price_in_do" 								default="" 													type="any">
<cfparam name="form.compulsory_location" 							default="" 													type="any">
<cfparam name="form.compulsory_location2" 							default="" 													type="any">
<cfparam name="form.allow_edit_amount" 								default="" 													type="any">
<cfparam name="form.batch_code_other_charges" 						default=""													type="any">
<cfparam name="form.allow_change_in_2nd_unit_factor"				default="Y" 												type="any">
<cfparam name="form.allow_create_code_during_transaction"			default="Y" 												type="any">
<cfparam name="form.display_cost_code_during_transaction"			default="" 													type="any">
<cfparam name="form.transfer_note_based_on_selling_price"			default="" 													type="any">
<cfparam name="form.compulsory_serial_no"							default="" 													type="any">
<cfparam name="form.allow_qty_rc_exceed_qty_outstand_po"			default="Y" 												type="any">
<cfparam name="form.3_level_discount" 								default="" 													type="any">
<cfparam name="form.default_service" 								default="" 													type="any">
<cfparam name="form.default_change_unit" 							default="" 													type="any">
<cfparam name="form.round_off_on_item_discount" 					default="Y" 												type="any">
<cfparam name="form.round_down_on_item_amount" 						default="" 													type="any">
<cfparam name="form.update_latest_prices" 							default="" 													type="any">
<cfparam name="form.update_latest_prices_formula" 					default="RC DN DO INV" 										type="any">
<cfparam name="form.category_of_discount" 							default="" 													type="any">
<cfparam name="form.compulsory_footer" 								default="" 													type="any">
<cfparam name="form.exchange_rate_on_invoice_total" 				default="" 													type="any">
<cfparam name="form.dis2_discount_on_invoice_net_discount" 			default="" 													type="any">
<cfparam name="form.tax2_tax_on_invoice_net_tax" 					default="" 													type="any">
<cfparam name="form.condition_for_updating_stock_balance_formula"	default="TYPE ='INV' AND (GENERATED ='Y' OR UD_QTY ='N')" 	type="any">

<cftry>
	<cfupdate 
	datasource="#dts#" 
	tablename="transaction_menu" 
	formfields="
	company_id,
	increase_period_by_one_on_after_day,
	use_only_1_set_invoice_no,
	use_only_1_set_do_no,
	allowed_edit_exported_bill,
	standard_auto_running,
	project_by_bill,
	with_bill_agent,
	with_site,
	search_transaction_date,
	allow_edit_name,
	so_has_to_be_verify,
	with_per_item_tax,
	with_per_item_tax_formula,
	with_per_item_discount,
	with_price_in_do,
	compulsory_location,
    compulsory_location2,
	allow_edit_amount,
	batch_code_other_charges,
	allow_change_in_2nd_unit_factor,
	allow_create_code_during_transaction,
	display_cost_code_during_transaction,
	transfer_note_based_on_selling_price,
	compulsory_serial_no,
	allow_qty_rc_exceed_qty_outstand_po,
	3_level_discount,
	default_service,
	default_change_unit,
	round_off_on_item_discount,
	round_down_on_item_amount,
	update_latest_prices,
	update_latest_prices_formula,
	category_of_discount,
	compulsory_footer,
	exchange_rate_on_invoice_total,
	dis2_discount_on_invoice_net_discount,
	tax2_tax_on_invoice_net_tax,
	condition_for_updating_stock_balance_formula
	">
	
	<cfcatch type="any">
		<cfdump var="#cfcatch#">
		<cfabort>
	</cfcatch>
</cftry>

<script language="javascript" type="text/javascript">
	alert("Update Process Done !");
	window.location="transaction_menu.cfm";
</script>