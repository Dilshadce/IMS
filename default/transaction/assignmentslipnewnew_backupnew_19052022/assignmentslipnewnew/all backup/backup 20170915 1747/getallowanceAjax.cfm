<cfsetting showdebugoutput="no">
<cfset url.placementno = URLDECODE(URLDECODE(url.placementno))>

<cfquery name="getallowance" datasource="#dts#">
select allowance1,allowance2,allowance3,allowance4,newrate,usualpayrate,clientrate from placement where placementno='#url.placementno#'
</cfquery>
<cfoutput>
<input type="hidden" name="hdallowance1" id="hdallowance1" value="#getallowance.allowance1#" />
<input type="hidden" name="hdallowance2" id="hdallowance2" value="#getallowance.allowance2#" />
<input type="hidden" name="hdallowance3" id="hdallowance3" value="#getallowance.allowance3#" />
<input type="hidden" name="hdallowance4" id="hdallowance4" value="#getallowance.allowance4#" />

<input type="hidden" name="husualpayrate" id="husualpayrate" value="#getallowance.newrate#" />
<input type="hidden" name="hclientrate" id="hclientrate" value="#getallowance.clientrate#" />
</cfoutput>