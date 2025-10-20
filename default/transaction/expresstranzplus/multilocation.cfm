<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">

<cfquery name="getlocation" datasource="#dts#">
	select '' as location,'No Location' as desp 
    union all
	select location,desp from iclocation where (noactivelocation ='' or noactivelocation is null)
	order by location
</cfquery>
<cfquery name='getgsetup2' datasource='#dts#'>
  	select concat('.',repeat('_',Decl_Uprice)) as Decl_Uprice,Decl_Uprice as Decl_Uprice1, concat('.',repeat('_',DECL_DISCOUNT)) as DECL_DISCOUNT1, DECL_DISCOUNT from gsetup2
</cfquery>

<cfquery name="getgrouplocationdetail" datasource="#dts#">
select * FROM ictrantemp where uuid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.uuid#">
and trancode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.trancode#">
</cfquery>

<cfoutput>
<h1 align="center">Multi Location</h1>
<cfform name="form1" action="multilocationprocess.cfm" method="post">

	<input type="hidden" name="multilocationitemno" id="multilocationitemno" value="#convertquote(getgrouplocationdetail.itemno)#">
	<input type="hidden" name="multilocationprice_bil" id="multilocationprice_bil" value="#getgrouplocationdetail.price_bil#">
    <input type="hidden" name="multilocationdiscount" id="multilocationdiscount" value="#getgrouplocationdetail.brem4#">
    <input type="hidden" name="multilocationlocationlist" id="multilocationlocationlist" value="#ValueList(getlocation.location,';')#">
    <input type="hidden" name="multilocationtotallocation" id="multilocationtotallocation" value="#getlocation.recordcount#">
    <input type="hidden" name="multilocationuuid" id="multilocationuuid" value="#url.uuid#">

<table border="0" cellpadding="2" align="center" width="90%">
	<tr>
		<th>Location</th>
		<th>Qty On Hand</th>
		<th><div align="center">Qty</div></th>
	</tr>
	<cfset totqty = 0>
	<cfloop query="getlocation">
		<cfset xlocation = getlocation.location>
		<cfquery name="getinfo" datasource="#dts#">
			select * from ictrantemp
			where uuid='#getgrouplocationdetail.uuid#'
			and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getgrouplocationdetail.itemno#"> 
			and location = <cfqueryparam cfsqltype="cf_sql_char" value="#xlocation#"> 
			and price_bil = <cfqueryparam cfsqltype="cf_sql_char" value="#getgrouplocationdetail.price_bil#"> 
		</cfquery>
        
		<cfif getinfo.recordcount neq 0>
			<cfset xqty_bil = getinfo.qty_bil>
			<cfset xtrancode = getinfo.trancode>
		<cfelse>
			<cfset xqty_bil = 0>
			<cfset xtrancode = "">
		</cfif>
		
		<cfquery name="getlocitembal" datasource="#dts#">
			select LOCQFIELD as locqtybf from locqdbf
			where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#getgrouplocationdetail.itemno#"> 
			and location = <cfqueryparam cfsqltype="cf_sql_char" value="#xlocation#">  
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
			and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#getgrouplocationdetail.itemno#"> 
			and location = <cfqueryparam cfsqltype="cf_sql_char" value="#xlocation#">  
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
			and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#getgrouplocationdetail.itemno#"> 
			and location = <cfqueryparam cfsqltype="cf_sql_char" value="#xlocation#">  
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
			and toinv='' 
			and itemno=<cfqueryparam cfsqltype="cf_sql_char" value="#getgrouplocationdetail.itemno#"> 
			and location = <cfqueryparam cfsqltype="cf_sql_char" value="#xlocation#">  
			and fperiod <> '99' 
			and (void = '' or void is null)
		</cfquery>

		<cfif getdo.sumqty neq "">
			<cfset DOqty = getdo.sumqty>
		<cfelse>
			<cfset DOqty = 0>
		</cfif>
							
		<cfset locbalonhand = itembal + inqty - outqty - doqty>	
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td>#getlocation.location#</td>
			<td><div align="center">#locbalonhand#</div></td>
			<cfset totqty = totqty + val(xqty_bil)>
			<td>
				<div align="center">
                		<input type="hidden" name="multilocation_location_#getlocation.currentrow#" id="multilocation_location_#getlocation.currentrow#" value="#xlocation#">
						<input type="text" name="multilocation_qty_#getlocation.currentrow#" id="multilocation_qty_#getlocation.currentrow#" value="#val(xqty_bil)#" size="10" onKeyUp="checknum(this);" onBlur="UpdateTotalQty();">		
						<input type="hidden" name="multilocation_oldqty_#getlocation.currentrow#" id="oldqty_#getlocation.currentrow#" value="#val(xqty_bil)#">			
			
				</div>
			</td>
		</tr>
	</cfloop>
	<tr>
		<td colspan="2">
			<div align="right"><font size="2" face="Times New Roman,Times,serif"><strong>Total:</strong></font></div>
		</td>
		<td>
			<div align="center"><input type="text" name="multilocation_totqty" id="multilocation_totqty" value="#totqty#" size="10" style="background-color: ##FFFAFA;"></div>
		</td>
	</tr>
	<tr><td colspan="100%" align="center" height="10"></td></tr>
	<tr>
		<td colspan="100%" align="center">
			<input type="submit" name="multilocationsubmit" id="multilocationsubmit" value="Ok">&nbsp;&nbsp;<input type="button" value="Cancel" onClick="ColdFusion.Window.hide('multilocationwindow');">
		</td>
	</tr>
</table>
</cfform>
</cfoutput>