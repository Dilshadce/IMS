<cfset batchno=0>
<cfsetting showdebugoutput="no">
<cfif isDefined("form.action")>
	<cfset action=form.action>
	<cfif action EQ "">
	
	<!--- getTargetDetail [START] --->
	<cfelseif action EQ "getTargetDetail">
		<cfset targetTable=form.targetTable>
		<cfset custno=form.custno>
        <cfquery name="getgsetup" datasource="#dts#">
			SELECT ctycode
			FROM gsetup;
		</cfquery>
		<cfquery name="getTargetDetail" datasource="#replace(LCASE(dts),'_i','_a','ALL')#">
			SELECT  add1,add2,add3,add4,country,postalCode,attn,
            		daddr1,daddr2,daddr3,daddr4,d_country,d_postalCode,dattn,
                    currcode,term
			FROM #target_apvend#
			WHERE custno="#custno#";
		</cfquery>
		<cfquery name="getCurrencyRate" datasource="#dts#">
			SELECT currrate
			FROM currency
			WHERE currcode="#getTargetDetail.currcode#";
		</cfquery>
		<cfset target={
			ADD1="#getTargetDetail.add1#",
			ADD2="#getTargetDetail.add2#",
			ADD3="#getTargetDetail.add3#",
			ADD4="#getTargetDetail.add4#",
			COUNTRY="#getTargetDetail.country# #getTargetDetail.postalCode#",
			ATTN="#getTargetDetail.attn#",
			DADDR1="#getTargetDetail.daddr1#",
			DADDR2="#getTargetDetail.daddr2#",
			DADDR3="#getTargetDetail.daddr3#",
			DADDR4="#getTargetDetail.daddr4#",
			DCOUNTRY="#getTargetDetail.d_country# #getTargetDetail.d_postalCode#",
			DATTN="#getTargetDetail.dattn#",
			TERM="#getTargetDetail.term#",
			CURRCODE="#getTargetDetail.currcode#",
			CURRRATE="#getCurrencyRate.currrate#"
		}>
		<cfset target=SerializeJSON(target)>
		<cfset target=cleanXmlString(target)>
		<cfoutput>#target#</cfoutput>
	<!--- getTargetDetail [END] --->
	
	<!--- getItemInfo [START] --->
	<cfelseif action EQ "getItemInfo">
    
		<cfset itemPriceType=form.itemPriceType>
		<cfset itemno_input=form.itemno_input>
		<cfquery name="getItemInfo" datasource="#dts#">
			SELECT itemno,desp
			FROM icitem 
			WHERE itemno="#itemno_input#";
		</cfquery>
		<cfset item={
			ITEMNO="#getItemInfo.itemno#",
			DESP="#getItemInfo.desp#",
			ITEMPRICE=""
		}>
		<cfset item=SerializeJSON(item)>
		<cfset item=cleanXmlString(item)>
		<cfoutput>#item#</cfoutput>
	<!--- getItemInfo [END] --->
	</cfif>
</cfif>

<!--- cleanXmlString [START] --->
<cffunction name="cleanXmlString" access="public" returntype="any" output="false" hint="Replace non-valid XML characters">
    <cfargument name="dirty" type="string" required="true" hint="Input string">
    <cfset var cleaned = "" />
    <cfset var patterns = "" />
    <cfset var replaces = "" />
    <cfset patterns = chr(8216) & "," & chr(8217) & "," & chr(8220) & "," & chr(8221) & "," & chr(8212) & "," & chr(8213) & "," & chr(8230) />
    <cfset patterns = patterns & "," & chr(1) & "," & chr(2) & "," & chr(3) & "," & chr(4) & "," & chr(5) & "," & chr(6) & "," & chr(7) & "," & chr(8) />
    <cfset patterns = patterns & "," & chr(14) & "," & chr(15) & "," & chr(16) & "," & chr(17) & "," & chr(18) & "," & chr(19) />
    <cfset patterns = patterns & "," & chr(20) & "," & chr(21) & "," & chr(22) & "," & chr(23) & "," & chr(24) & "," & chr(25) />
    <cfset patterns = patterns & "," & chr(26) & "," & chr(27) & "," & chr(28) & "," & chr(29) & "," & chr(30) & "," & chr(31) />
	<cfset replaces = replaces & "',',"","",--,--,..." />
    <cfset replaces = replaces & ",-, , , , , , , " />
    <cfset replaces = replaces & ", , , , , , " />
    <cfset replaces = replaces & ", , , , , , " />
    <cfset replaces = replaces & ", , , , , , " />
	<cfset cleaned = ReplaceList(arguments.dirty, patterns, replaces) />
	<cfreturn cleaned />
</cffunction>
<!--- cleanXmlString [END] --->