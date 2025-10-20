<cfsetting showdebugoutput="no">

<cfif url.type eq "PO" or url.type eq "PR" or url.type eq "RC">
<cfset targettable=target_apvend>
<cfelse>
<cfset targettable=target_arcust>
</cfif>

<cfquery name="getcustdetail" datasource="#dts#">
select * from #targettable# where custno='#url.custno#'
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>
<cfoutput>

<input type="hidden" name="nameajaxhid" id="nameajaxhid" value="#getcustdetail.name#" />
<input type="hidden" name="name2ajaxhid" id="name2ajaxhid" value="#getcustdetail.name2#" />
<input type="hidden" name="add1ajaxhid" id="add1ajaxhid" value="#getcustdetail.add1#" />
<input type="hidden" name="add2ajaxhid" id="add2ajaxhid" value="#getcustdetail.add2#" />
<input type="hidden" name="add3ajaxhid" id="add3ajaxhid" value="#getcustdetail.add3#" />
<input type="hidden" name="add4ajaxhid" id="add4ajaxhid" value="#getcustdetail.add4#" />
<input type="hidden" name="attnajaxhid" id="attnajaxhid" value="#getcustdetail.attn#" />
<input type="hidden" name="phoneajaxhid" id="phoneajaxhid" value="#getcustdetail.phone#" />
<input type="hidden" name="phoneaajaxhid" id="phoneaajaxhid" value="#getcustdetail.phonea#" />
<input type="hidden" name="faxajaxhid" id="faxajaxhid" value="#getcustdetail.fax#" />

<input type="hidden" name="agentajaxhid" id="agentajaxhid" value="#getcustdetail.agent#" />
<input type="hidden" name="termajaxhid" id="termajaxhid" value="#getcustdetail.term#" />
<input type="hidden" name="currcodeajaxhid" id="currcodeajaxhid" value="#getcustdetail.currcode#" />
<input type="hidden" name="currrateajaxhid" id="currrateajaxhid" value="1" />
<input type="hidden" name="ngstcusthid" id="ngstcusthid" value="#getcustdetail.ngst_cust#" />

</cfoutput>
