<cfsetting showdebugoutput="no">
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

<cfoutput>
<table align="center">
<tr>
<th>#dbname# Name</th>
<td><input type="text" name="b_name" id="b_name" value="#getcustdetail.name#" maxlength="35" size="40"/></td>
<th>Recipient Name</th>
<td><input type="text" name="d_name" id="d_name" value="#getcustdetail.name#" maxlength="35" size="40"/></td>

</tr>
<tr>
<th></th>
<td><input type="text" name="b_name2" id="b_name2" value="#getcustdetail.name2#" maxlength="35" size="40"/></td>
<th></th>
<td><input type="text" name="d_name2" id="d_name2" value="#getcustdetail.name2#" maxlength="35" size="40"/></td>

</tr>
<tr>
<th>Address 1 (Block/House No,Street)</th>
<td>
<input type="text" name="b_add1" id="b_add1" value="#getcustdetail.add1#" maxlength="35" size="40"></td>
<th>Address 1 (Block/House No,Street)</th>
<td><input type="text" name="d_add1" id="d_add1" value="#getcustdetail.daddr1#" maxlength="35" size="40"/></td>
</tr>
<tr>
<th>Address 2 (Unit )</th>
<td>
<input type="text" name="b_add2" id="b_add2" value="#getcustdetail.add2#" maxlength="35" size="40"></td>
<th>Address 2 (Unit )</th>
<td><input type="text" name="d_add2" id="d_add2" value="#getcustdetail.daddr2#" maxlength="35" size="40"/></td>
</tr>
<tr>
<th>Address 3:</th>
<td>
<input type="text" name="b_add3" id="b_add3" value="#getcustdetail.add3#" maxlength="35" size="40"></td>
<th>Address 3:</th>
<td><input type="text" name="d_add3" id="d_add3" value="#getcustdetail.daddr3#" maxlength="35" size="40"/></td>
</tr>
<tr>
<th>Address 4:</th>
<td>
<input type="text" name="b_add4" id="b_add4" value="#getcustdetail.add4#" maxlength="35" size="40"></td>
<th>Address 4:</th>
<td><input type="text" name="d_add4" id="d_add4" value="#getcustdetail.daddr4#" maxlength="35" size="40"/></td>
</tr>
<tr>
<th>Postal Code</th>
<td>
<input type="text" name="b_postalcode" id="b_postalcode" value="#getcustdetail.postalcode#" maxlength="35" size="40"></td>
<th>Postal Code</th>
<td><input type="text" name="d_postalcode" id="d_postalcode" value="#getcustdetail.d_postalcode#" maxlength="35" size="40"/></td>
</tr>
<tr>
<th>Tel</th>
<td>
<input type="text" name="b_phone" id="b_phone" value="#getcustdetail.phone#" maxlength="35" size="40"></td>
<th>Tel</th>
<td><input type="text" name="d_phone" id="d_phone" value="#getcustdetail.dphone#" maxlength="35" size="40"/><input type="hidden" name="d_fax" id="d_fax" value=""></td>
</tr>

<tr>
<th>Hp</th>
<td>
<input type="text" name="b_phone2" id="b_phone2" value="#getcustdetail.phonea#" maxlength="35" size="40"></td>
<th>Hp</th><td><input type="text" name="d_phone2" id="d_phone2" value="#getcustdetail.contact#" maxlength="35" size="40"></td>
</tr>

<tr>
<th>Attention</th>
<td>
<input type="text" name="b_attn" id="b_attn" value="#getcustdetail.attn#" maxlength="35" size="40"></td>
<th>Attention</th><td><input type="text" name="d_attn" id="d_attn" value="#getcustdetail.dattn#" maxlength="35" size="40"></td>
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
