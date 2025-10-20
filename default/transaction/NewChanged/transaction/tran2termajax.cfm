<cfsetting showdebugoutput="no">
<cfquery name="gettermdetail" datasource="#dts#">
SELECT * from #target_icterm# where term=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDecode(url.term)#" />
</cfquery>

<cfquery name="gettermdetail2" datasource="#dts#">
SELECT l#URLDecode(url.tran)# as termcondition from ictermandcondition 
</cfquery>



<cfoutput>
<div style="display:none">
<input type="hidden" name="hidtermvalidity" id="hidtermvalidity" value="#gettermdetail.validity#" />
<input type="hidden" name="hidtermleadtime" id="hidtermleadtime" value="#gettermdetail.leadtime#" />
<textarea name="hidtermremarks" id="hidtermremarks">#gettermdetail2.termcondition#</textarea>
</div>
</cfoutput>

