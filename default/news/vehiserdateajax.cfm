<cfsetting showdebugoutput="no">


<cfset ndatefrom=URLDecode(url.serdatefrom)>
<cfset ndateto=URLDecode(url.serdatefrom)>

<cfif isdate(ndatefrom) and isdate(ndateto)>
<cfset ndatefrom1=dateformat(createdate(right(ndatefrom,4),mid(ndatefrom,4,2),left(ndatefrom,2)),'yyyy-mm-dd')>
<cfset ndateto1=dateformat(createdate(right(ndateto,4),mid(ndateto,4,2),left(ndateto,2)),'yyyy-mm-dd')>
<cfelse>
<cfset ndatefrom1=''>
<cfset ndateto1=''>
</cfif>
<cfquery name="getnewitem" datasource="#dts#">
    select *
    from vehicles
    where nextserdate between <cfqueryparam cfsqltype="cf_sql_varchar" value="%#ndatefrom1#%"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="%#ndateto1#%">
    order by nextserdate
    limit 10
</cfquery>

<cfoutput>


<table class="tcontent" width="600">
<tr>
<td class="tabletitle1">Next Vehicle Service Date</td>
<td class="tabletitle1" >Vehicle No</td>
<td class="tabletitle1" >Contact</td>
<td class="tabletitle1" >Phone No 1</td>
<td class="tabletitle1" >Phone No 2</td>
<td class="tabletitle1" >Next Service Mil</td>
<td class="tabletitle1" >Last Service Date</td>
<td class="tabletitle1" >Next Service Date</td>
</tr>

    <cfloop query="getnewitem">
    	<tr class="tablecontentrow1">
        <td class="tablecontent1" nowarp><cfif isdate(nextserdate)>#dateformat(nextserdate,'DD/MM/YYYY')#</cfif></td>
        <td class="tablecontent1" nowarp>#entryno#</td>
        <td class="tablecontent1" nowarp>#contactperson#</td>
        <td class="tablecontent1" nowarp>#phone#</td>
        <td class="tablecontent1" nowarp>#hp#</td>
        <td class="tablecontent1" nowarp>#nextmileage#</td>
        <td class="tablecontent1" nowarp><cfif isdate(lastserdate)>#dateformat(lastserdate,"dd/mm/yyyy")#</cfif></td>
        <td class="tablecontent1" nowarp><cfif isdate(nextserdate)>#dateformat(nextserdate,"dd/mm/yyyy")#</cfif></td>
        </tr>
    </cfloop>
    
</table>

</cfoutput>

