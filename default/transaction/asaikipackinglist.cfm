<cfsetting showdebugoutput="no">
<cfoutput>
<select name="brem6" id="brem6">
<option value="">Choose an Item</option>
<cfquery name="getasaikisampleitem" datasource="#dts#">
select trancode,itemno,price_bil from ictran where type="SAM" and (void="" or void is null) and (toinv="" or toinv is null) and fperiod <> "99" and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemno)#"> and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.refno)#"> order by trancode
</cfquery>
<cfloop query="getasaikisampleitem">
<option value="#getasaikisampleitem.trancode#">#getasaikisampleitem.trancode# - #getasaikisampleitem.itemno# @ #numberformat(getasaikisampleitem.price_bil,',.__')#</option>
</cfloop>
</select> 
</cfoutput>