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
<table align="left" width="100%">
<tr>
<th width="20%">#dbname# Name</th>
<td width="30%"><input type="text" name="b_name" id="b_name" value="#getcustdetail.name#" maxlength="35" size="40" <cfif getdealer_menu.tran_edit_name neq 'Y'>readonly</cfif>/></td>
<th width="20%">Tel</th>
<td width="30%">
<input type="text" name="b_phone" id="b_phone" value="#getcustdetail.phone#" maxlength="25" size="40"></td>

</tr>
<tr>
<th>&nbsp;</th>
<td><input type="text" name="b_name2" id="b_name2" value="#getcustdetail.name2#" maxlength="35" size="40" <cfif getdealer_menu.tran_edit_name neq 'Y'>readonly</cfif>/></td>
<th>Hp</th>
<td>
<input type="text" name="b_phone2" id="b_phone2" value="#getcustdetail.phonea#" maxlength="25" size="40"></td>

<tr>
<th>E-mail</th>
<td>
<input type="text" name="b_email" id="b_email" value="#getcustdetail.e_mail#" maxlength="35" size="40"></td>

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
