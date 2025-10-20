<cfsetting showdebugoutput="no">

<cfquery name="getdepositdetail" datasource="#dts#">
select * from deposit where depositno='#url.depositno#'
</cfquery>

<cfoutput>
<input type="hidden" name="hidcash" id="hidcash" value="#getdepositdetail.cs_pm_cash#" maxlength="35" size="40"/>
<input type="hidden" name="hidcheq" id="hidcheq" value="#getdepositdetail.cs_pm_cheq#" maxlength="35" size="40"/>
<input type="hidden" name="hidcrcd" id="hidcrcd" value="#getdepositdetail.cs_pm_crcd#" maxlength="35" size="40"/>
<input type="hidden" name="hidcrc2" id="hidcrc2" value="#getdepositdetail.cs_pm_crc2#" maxlength="35" size="40"/>
<input type="hidden" name="hiddbcd" id="hiddbcd" value="#getdepositdetail.cs_pm_dbcd#" maxlength="35" size="40"/>
<input type="hidden" name="hidvouc" id="hidvouc" value="#getdepositdetail.cs_pm_vouc#" maxlength="35" size="40"/>
<input type="hidden" name="hidcctype1" id="hidcctype1" value="#getdepositdetail.cctype1#" maxlength="35" size="40"/>
<input type="hidden" name="hidcctype2" id="hidcctype2" value="#getdepositdetail.cctype2#" maxlength="35" size="40"/>
<input type="hidden" name="hidchequeno" id="hidchequeno" value="#getdepositdetail.chequeno#" maxlength="35" size="40"/>

</cfoutput>
