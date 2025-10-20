<cfoutput>
<h3>Item Balance</h3>
<table>
<tr>
<th>LOCATION</th>
<th>QUANTITY BALANCE</th>
</tr>
<cfquery name="getlocation" datasource="#dts#">
SELECT LOCATION FROM ICLOCATION
</cfquery>
<cfloop query="getlocation">
		<cfquery name="getlocitembal" datasource="#dts#">
			select LOCQFIELD as locqtybf from locqdbf
			where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemno)#">
			and location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocation.location#">
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
		and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemno)#">
		and (linecode <> 'SV' or linecode is null)
		and location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocation.location#">
		and fperiod <> '99' 
		and (void='' or void is null);
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
		and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemno)#">
		and (linecode <> 'SV' or linecode is null)
		and location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocation.location#">
		and fperiod <> '99' 
		and (void='' or void is null);
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
		and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemno)#">
		and (linecode <> 'SV' or linecode is null)
		and location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocation.location#">
		and fperiod <> '99' 
		and (void='' or void is null);
	</cfquery>
    

	<cfif getdo.sumqty neq "">
		<cfset DOqty = getdo.sumqty>
	<cfelse>
		<cfset DOqty = 0>
	</cfif>
    
    <cfquery name="getsamm" datasource="#dts#">
		select 
		sum(qty)-sum(shipped) as sumqty 
		from ictran 
		where type='SAMM' 
		and (toinv='' or toinv is null) 
		and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemno)#"> 
		and (linecode <> 'SV' or linecode is null)
		and location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocation.location#">
		and fperiod <> '99' 
		and (void='' or void is null);
	</cfquery>
    
    <cfif getsamm.sumqty neq "">
		<cfset sammqty = val(getsamm.sumqty)>
	<cfelse>
		<cfset sammqty = 0>
	</cfif>
    
     <cfquery name="getso" datasource="#dts#">
		select 
		sum(qty) sumqty 
		from ictran 
		where type='SO' 
		and (toinv='' or toinv is null) 
		and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemno)#"> 
		and (linecode <> 'SV' or linecode is null)
		and location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getlocation.location#">
		and fperiod <> '99' 
		and (void='' or void is null);
	</cfquery>
    
    <cfif getso.sumqty neq "">
		<cfset soqty = val(getso.sumqty)>
	<cfelse>
		<cfset soqty = 0>
	</cfif>
<tr>
<td>#getlocation.location#</td>
<td><cfset stkall = val(itembal) + val(inqty) - val(outqty) - val(doqty)>#stkall#</td>
</tr>
</cfloop>
		<cfquery name="getitembal" datasource="#dts#">
			select qtybf from icitem
			where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemno)#">
		</cfquery>
        <cfset itembal = 0>
		<cfif getitembal.qtybf neq "">
			<cfset itembal = getitembal.qtybf>
		</cfif>
        
        <cfquery name="getin" datasource="#dts#">
		select 
		sum(qty)as sumqty 
		from ictran 
		where type in ('RC','CN','OAI','TRIN') 
		and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemno)#">
		and (linecode <> 'SV' or linecode is null)
		and fperiod <> '99' 
		and (void='' or void is null);
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
		and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemno)#">
		and (linecode <> 'SV' or linecode is null)
		and fperiod <> '99' 
		and (void='' or void is null);
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
		and itemno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLDECODE(url.itemno)#">
		and (linecode <> 'SV' or linecode is null)
		and fperiod <> '99' 
		and (void='' or void is null);
	</cfquery>
    

	<cfif getdo.sumqty neq "">
		<cfset DOqty = getdo.sumqty>
	<cfelse>
		<cfset DOqty = 0>
	</cfif>

<tr>
<td><strong>STOCK ALL</strong></td>
<td><cfset stkall = val(itembal) + val(inqty) - val(outqty) - val(doqty)><strong>#stkall#</strong></td>

</tr>
</table>
<br />

</cfoutput>