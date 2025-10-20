<cfsetting showdebugoutput="no">

<cfquery datasource="#dts#" name="getmodule">
	select * from modulecontrol
</cfquery>

<cfquery name="getdealer_menu" datasource="#dts#">
	select custSuppSortBy,productSortBy,transactionSortBy,tran_edit_name from dealer_menu limit 1
</cfquery>

<cfquery name="getcustdetail" datasource="#dts#">
select * from driver where driverno='#url.member#'
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

<cfset dname=getcustdetail.name>

<cfoutput>
<table align="left" width="100%">
<tr>
<th width="20%">Customer Name</th>
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

<input type="hidden" name="agentajaxhid" id="agentajaxhid" value="" />
<input type="hidden" name="termajaxhid" id="termajaxhid" value="" />
<input type="hidden" name="currcodeajaxhid" id="currcodeajaxhid" value="" />
<input type="hidden" name="currrateajaxhid" id="currrateajaxhid" value="1" />
<input type="hidden" name="ngstcusthid" id="ngstcusthid" value="" />

</cfoutput>
