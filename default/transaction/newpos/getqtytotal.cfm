<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "789">
<cfinclude template="/latest/words.cfm">

<cfsetting showdebugoutput="no">
<cfset uuid = url.uuid>
<cfquery name="getsumictrantemp" datasource="#dts#">
SELECT sum(qty_bil)as sumqty FROM ictrantemp WHERE uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#"> order by trancode desc
</cfquery>

<cfoutput>
<label for="totalitem" id="ttlItem">#words[789]#:</label>    
<label for="totalitemamonut" id="ttlItmAmt">#getsumictrantemp.sumqty#</label>     
</cfoutput>
