<cfoutput>

<cfset totalamt=val(url.qty)*val(url.price)>
<cfset qty=val(url.qty)>
<cfset price = val(url.price)>
<cfquery name="edititem" datasource="#dts#">
update ictrantemp set qty="#qty#",qty_bil="#qty#", price_bil="#price#",price="#price#",amt1_bil="#totalamt#",amt_bil="#totalamt#",amt1="#totalamt#",amt="#totalamt#" where uuid="#uuid#" and itemno = "#url.itemno#"
</cfquery>


</cfoutput>