<cfoutput>
<h1>Item #URLDECODE(url.itemno)# Location Balance</h1>
<table>
<tr>
<th>Location</th>
<th>Balance</th>
</tr>
<cfquery name="getlocation" datasource="#dts#">
SELECT location FROM iclocation order by location
</cfquery>
<cfloop query="getlocation">
<tr>
<td>#getlocation.location#</td>
        <cfquery name="getlocitembal" datasource="#dts#">
            select LOCQFIELD as locqtybf from locqdbf
            where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#URLDECODE(url.itemno)#"> 
            and location = '#getlocation.location#'
        </cfquery>
        <cfif getlocitembal.recordcount neq 0>
            <cfset itembal = getlocitembal.locqtybf>
        <cfelse>
            <cfset itembal = 0>
        </cfif>
    
        <cfquery name="getin" datasource="#dts#">
            select 
            sum(qty)as sumqty 
            from ictran 
            where type in ('RC','CN','OAI','TRIN') 
            and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#URLDECODE(url.itemno)#"> 
            and location = '#getlocation.location#'
            and fperiod <> '99' 
            and (void = '' or void is null)
        </cfquery>

        <cfif getin.sumqty neq "">
            <cfset inqty = getin.sumqty>
        <cfelse>
            <cfset inqty = 0>
        </cfif>

        <cfquery name="getout" datasource="#dts#">
            select 
            sum(qty)as sumqty 
            from ictran 
            where type in ('INV','DN','PR','CS','ISS','OAR','TROU') 
            and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#URLDECODE(url.itemno)#"> 
            and location = '#getlocation.location#'
            and fperiod <> '99' 
            and (void = '' or void is null)
        </cfquery>

        <cfif getout.sumqty neq "">
            <cfset outqty = getout.sumqty>
        <cfelse>
            <cfset outqty = 0>
        </cfif>

        <cfquery name="getdo" datasource="#dts#">
            select 
            sum(qty)as sumqty 
            from ictran 
            where type='DO' 
            and (toinv='' or toinv is null) 
            and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#URLDECODE(url.itemno)#"> 
            and location = '#getlocation.location#'
            and fperiod <> '99' 
            and (void = '' or void is null)
        </cfquery>

        <cfif getdo.sumqty neq "">
            <cfset DOqty = getdo.sumqty>
        <cfelse>
            <cfset DOqty = 0>
        </cfif>
    
        <cfquery name="getpo" datasource="#dts#">
            select 
            ifnull(sum(qty),0) as sumqty 
            from ictran 
            where type='PO' 
            and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#URLDECODE(url.itemno)#"> 
            and fperiod <> '99' 
            and location = '#getlocation.location#'
            and (void = '' or void is null) and (toinv='' or toinv is null) 
        </cfquery>		
    
        <cfset locbalonhand = itembal + inqty - outqty - doqty >
<td>#locbalonhand#</td>
</tr>
</cfloop>
</table>
</cfoutput>