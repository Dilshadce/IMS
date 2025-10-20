<cfoutput>

<cfset totalamt=val(url.qty)*val(url.price)>
<cfset qty=val(url.qty)>
<cfset price = val(url.price)>
<cfset dispec1=val(url.dispec1)>
<cfset dispec2=val(url.dispec2)>
<cfset dispec3=val(url.dispec3)>

<cfquery datasource="#dts#" name="getgsetup2">
	select * from gsetup2
</cfquery>

<cfquery datasource="#dts#" name="getGeneralInfo">
	select * from gsetup
</cfquery>

<cfif getGeneralInfo.itemdiscmethod eq 'byprice'>

		<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
		<cfset stDecl_UPrice = ".">

		<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
			<cfset stDecl_UPrice = stDecl_UPrice & "_">
		</cfloop>

        <cfset realamt1 = numberformat(((100-val(dispec1)) / 100)*val(price),stDecl_UPrice)* val(qty)>
		<cfset disamt_bil1 = numberformat((val(price)*val(qty))-realamt1,stDecl_UPrice)>
        <cfset netamttemp = totalamt - disamt_bil1>
        
        <cfset realamt2 = numberformat(((100-val(dispec2)) / 100)*(netamttemp/val(qty)),stDecl_UPrice)* val(qty)>
        <cfset disamt_bil2 = numberformat(netamttemp-realamt2,stDecl_UPrice)>
        <cfset netamttemp = netamttemp - disamt_bil2>
        
        <cfset realamt3 = numberformat(((100-val(dispec3)) / 100)*(netamttemp/val(qty)),stDecl_UPrice)* val(qty)>
        <cfset disamt_bil3 = numberformat(netamttemp-realamt3,stDecl_UPrice)>
        <cfset netamttemp = netamttemp - disamt_bil3>
        
        <cfset disamt = numberformat(disamt_bil1 + disamt_bil2 + disamt_bil3,',_.__')>

        <cfelse>

<cfset disamt1 = (val(dispec1) / 100) * totalamt>
<cfset netamttemp = totalamt - disamt1>
<cfset disamt2 = (val(dispec2) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt2>
<cfset disamt3 = (val(dispec3) / 100) * netamttemp>
<cfset netamttemp = netamttemp - disamt3>
<cfset disamt = numberformat(disamt1 + disamt2 + disamt3,',_.__')>
</cfif>

<cfset totalamt=totalamt-disamt>

<cfquery name="edititem" datasource="#dts#">
update ictrantemp set qty="#qty#",qty_bil="#qty#", price_bil="#price#",price="#price#",amt1_bil="#totalamt#",amt_bil="#totalamt#",amt1="#totalamt#",amt="#totalamt#",dispec1="#dispec1#",dispec2="#dispec2#",dispec3="#dispec3#",disamt="#disamt#",disamt_bil="#disamt#" where uuid="#uuid#" and itemno = "#url.itemno#"
</cfquery>


</cfoutput>