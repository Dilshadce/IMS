<cfoutput>

<cfset totalamt=val(url.qty)*val(url.price)>
<cfset qty=val(url.qty)>
<cfset price = val(url.price)>
<cfset dispec1=val(url.dispec1)>
<cfset dispec2=val(url.dispec2)>
<cfset dispec3=val(url.dispec3)>

<cfset disamt1 = (val(dispec1) / 100) * totalamt>
<cfset netamttemp = totalamt - disamt1>
<cfset disamt2 = (val(dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt2>
<cfset disamt3 = (val(dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt3>
<cfset disamt = numberformat(disamt1 + disamt2 + disamt3,',_.__')>

<cfset totalamt=totalamt-disamt>

<cfquery name="edititem" datasource="#dts#">
update ictrantemp set qty="#qty#",qty_bil="#qty#", price_bil="#price#",price="#price#",amt1_bil="#totalamt#",amt_bil="#totalamt#",amt1="#totalamt#",amt="#totalamt#",dispec1="#dispec1#",dispec2="#dispec2#",dispec3="#dispec3#",disamt="#disamt#",disamt_bil="#disamt#" where uuid="#uuid#" and itemno = "#url.itemno#"
</cfquery>


</cfoutput>