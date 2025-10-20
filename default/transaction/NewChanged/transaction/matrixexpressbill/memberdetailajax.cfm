<cfsetting showdebugoutput="no">

<cfquery datasource="#dts#" name="getmodule">
	select * from modulecontrol
</cfquery>

<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy,transactionSortBy,tran_edit_name from dealer_menu limit 1
</cfquery>

<cfif url.type eq 'PO' or url.type eq 'PR' or url.type eq 'RC'>
<cfset dbname='Supplier'>
<cfset dbtype=target_apvend>
<cfelse>
<cfset dbname='Customer'>
<cfset dbtype=target_arcust>
</cfif>
<cfquery name="getcustdetail" datasource="#dts#">
select * from #dbtype# where custno='#url.member#'
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfset dname=getcustdetail.name>

<cfif (lcase(hcomid) eq "bnbm_i" or lcase(hcomid) eq "bnbp_i") and (url.type eq 'PO' or url.type eq 'PR' or url.type eq 'RC')>
<cfquery name="getcurrentadd" datasource="#dts#">
select * from gsetup
</cfquery>
<cfset dname=getcurrentadd.compro>
<cfset getcustdetail.daddr1=getcurrentadd.compro2>
<cfset getcustdetail.daddr2=getcurrentadd.compro3>
<cfset getcustdetail.daddr3=getcurrentadd.compro4>
<cfset getcustdetail.daddr4="">
<cfset getcustdetail.dphone=left(getcurrentadd.compro5,19)>
<cfset getcustdetail.dfax=right(getcurrentadd.compro5,19)>
<cfset getcustdetail.contact="">
<cfset getcustdetail.dattn="">
<cfset getcustdetail.e_mail="">

</cfif>

<cfoutput>
<table align="left">
<tr>
<th>#dbname# Name</th>
<td><input type="text" name="b_name" id="b_name" value="#getcustdetail.name#" maxlength="35" size="40" <cfif getdealer_menu.tran_edit_name neq 'Y'>readonly</cfif>/></td>

</tr>
<tr>
<th><input type="text" name="bcode" id="bcode" value=<cfif getgsetup.ASACTP eq 'Y'>"Profile"<cfelse>""</cfif> /></th>
<td><input type="text" name="b_name2" id="b_name2" value="#getcustdetail.name2#" maxlength="35" size="40" <cfif getdealer_menu.tran_edit_name neq 'Y'>readonly</cfif>/></td>
</tr>
<tr>
<th>Address</th>
<td>
<input type="text" name="b_add1" id="b_add1" value="#getcustdetail.add1#" maxlength="35" size="40"></td>

</tr>
<tr>
<th></th>
<td>
<input type="text" name="b_add2" id="b_add2" value="#getcustdetail.add2#" maxlength="35" size="40"></td>

</tr>
<tr>
<th></th>
<td>
<input type="text" name="b_add3" id="b_add3" value="#getcustdetail.add3#" maxlength="35" size="40"></td>

</tr>
<tr>
<th></th>
<td>
<input type="text" name="b_add4" id="b_add4" value="#getcustdetail.add4#" maxlength="35" size="40"></td>

</tr>

<tr>
<th>Attention</th>
<td>
<input type="text" name="b_attn" id="b_attn" value="#getcustdetail.attn#" maxlength="35" size="40"><cfif (lcase(hcomid) neq "bnbm_i" and lcase(hcomid) neq "bnbp_i")><input type="button" name="Sattn1" value="Ajax Search" onClick="javascript:ColdFusion.Window.show('findattention');"></cfif></td>


</tr>
<tr>
<th>Tel</th>
<td>
<input type="text" name="b_phone" id="b_phone" value="#getcustdetail.phone#" maxlength="25" size="40"></td>
<tr>
<th>Fax</th>
<td>
<input type="text" name="b_fax" id="b_fax" value="#getcustdetail.fax#" maxlength="25" size="40"></td>
</tr>


</table>
<cfquery name="getcurrratecust" datasource="#dts#">
    SELECT currrate FROM #target_currency# where currcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustdetail.currcode#" >
    </cfquery>
    
    <cfif getcurrratecust.currrate neq "">
    <cfset currratecust = getcurrratecust.currrate>
    <cfelse>
    <cfset currratecust = 1>
	</cfif>
<input type="hidden" name="driverajaxhid" id="driverajaxhid" value="#getcustdetail.end_user#" />
<input type="hidden" name="agentajaxhid" id="agentajaxhid" value="#getcustdetail.agent#" />
<input type="hidden" name="termajaxhid" id="termajaxhid" value="#getcustdetail.term#" />
<input type="hidden" name="currcodeajaxhid" id="currcodeajaxhid" value="#getcustdetail.currcode#" />
<input type="hidden" name="currrateajaxhid" id="currrateajaxhid" value="#getcurrratecust.currrate#" />
<input type="hidden" name="ngstcusthid" id="ngstcusthid" value="#getcustdetail.NGST_CUST#" />

</cfoutput>
