<cfsetting showdebugoutput="no">

<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy,transactionSortBy,tran_edit_name from dealer_menu limit 1
</cfquery>

<cfset dbtype=target_arcust>

<cfquery name="getcustdetail" datasource="#dts#">
select * from #dbtype# where custno='#url.member#'
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>


<cfoutput>

<input type="text" name="name" id="name" value="#getcustdetail.name#" maxlength="35" size="40" />

<input type="hidden" name="hidname2" id="hidname2" value="#getcustdetail.name2#" maxlength="35" size="40" />
<input type="hidden" name="hidadd1" id="hidadd1" value="#getcustdetail.add1#" maxlength="35" size="40">
<input type="hidden" name="hidadd2" id="hidadd2" value="#getcustdetail.add2#" maxlength="35" size="40">
<input type="hidden" name="hidadd3" id="hidadd3" value="#getcustdetail.add3#" maxlength="35" size="40">
<input type="hidden" name="hidadd4" id="hidadd4" value="#getcustdetail.add4#" maxlength="35" size="40">
<input type="hidden" name="hidphone" id="hidphone" value="#getcustdetail.phone#" maxlength="25" size="40">
<input type="hidden" name="hidphone2" id="hidphone2" value="#getcustdetail.phonea#" maxlength="25" size="40">
<input type="hidden" name="hidfax" id="hidfax" value="#getcustdetail.fax#" maxlength="25" size="40">

</cfoutput>
