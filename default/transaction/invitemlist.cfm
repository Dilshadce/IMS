<cfsetting showdebugoutput="no">
<cfoutput>
<select name="invcnitem" id="invcnitem">
<option value="">Choose an Item</option>
<cfquery name="getinvitem" datasource="#dts#">
SELECT trancode,desp,price_bil FROM ictran WHERE (void = "" or void is null)
and fperiod <> "99" and custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.custno)#"> and type = "INV" and itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemno)#"> and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.refno)#"> order by trancode
</cfquery>
<cfloop query="getinvitem">
<option value="#getinvitem.trancode#">#getinvitem.trancode# - #getinvitem.desp# @ #numberformat(getinvitem.price_bil,',.__')#</option>
</cfloop>
</select> 
</cfoutput>