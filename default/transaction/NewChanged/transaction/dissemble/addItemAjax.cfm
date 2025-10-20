<cfsetting showdebugoutput="no">
<cfquery name="checkenable" datasource="#dts#">
select enabledetectrem1,itempriceprior from gsetup
</cfquery>
<cfset url.itemno = URLDECODE(URLDECODE(url.itemno))>

<cfquery name="getItemDetails" datasource="#dts#">
SELECT desp,despa,unit,unit2,unit3,unit4,unit5,unit6,price,price2,price3,price4,ucost,costformula,"0" as isservi from icitem where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(url.itemno)#">
</cfquery>


<cfset desp = getItemDetails.desp>
<cfset despa = getItemDetails.despa>
<cfif getItemDetails.recordcount neq 1 and url.itemno neq "">
<cfset desp = "itemisnoexisted" >
<cfset despa = "">
</cfif> 
<cfset allunit = "">

<cfoutput>  
<input type="hidden" name="desphid" id="desphid" value="#URLENCODEDFORMAT(desp)#" />
<input type="hidden" name="despahid" id="despahid" value="#URLENCODEDFORMAT(despa)#" />
<input type="hidden" name="unithid" id="unithid" value="#allunit#" />
<input type="hidden" name="pricehid" id="pricehid" value="#numberformat(val(getItemDetails.ucost),'.__')#" />

<input type="hidden" name="costformulaid" id="costformulaid" value="#getItemDetails.costformula#" />
<input type="hidden" name="iservi" id="isservi" value="#getItemDetails.isservi#" />
</cfoutput>
