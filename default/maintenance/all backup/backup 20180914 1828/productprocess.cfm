
<cfif form.submit eq'Create'>
<cfquery name="insertproduct" datasource="#dts#">
INSERT INTO productplanning
(itemno,fperiod,qty)
values
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#">,"#form.period#","#val(form.qty)#")
</cfquery>

<cfelseif form.submit eq'Delete'>
<cfquery name="deleteprodcutplanning" datasource='#dts#'>
				Delete from productplanning where itemno='#form.itemno#'
			</cfquery>
            
<cfelseif form.submit eq 'Edit'>
 
<cfquery name="updateicitem" datasource="#dts#">
				UPDATE productplanning
				SET
                qty="#val(form.qty)#"
                where itemno= '#form.itemno#'
                and fperiod='#form.period#'
</cfquery>
</cfif>

<script type="text/javascript">
window.close();
window.opener.location.href="productionlist_newest.cfm";
</script>
