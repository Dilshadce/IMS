<cfsetting showdebugoutput="no">
<!---
	<cfargument name="itemno" required="yes" type="string">
	<cfargument name="trancode" required="yes" type="string">
    <cfargument name="type" required="yes" type="string">
    <cfargument name="refno" required="yes" type="string">
	<cfargument name="location" required="no" type="string">--->
	
	<cfset itemno = URLDecode(url.itemno)>
    <cfset trancode = URLDecode(url.trancode)>
    <cfset type = URLDecode(url.type)>
    <cfset refno = URLDecode(url.refno)>
    <cfset location = URLDecode(url.location)>
    
    <cfquery name="checkdeductso" datasource="#dts#">
    	SELECT deductso from gsetup
    </cfquery>
	
	<cfif location neq "">
		<cfquery name="getlocitembal" datasource="#dts#">
			select LOCQFIELD as locqtybf from locqdbf
			where itemno = '#itemno#' 
			and location = '#location#'
		</cfquery>
		<cfif getlocitembal.recordcount neq 0>
			<cfset itembal = val(getlocitembal.locqtybf)>
		<cfelse>
			<cfset itembal = 0>
		</cfif>
		
	<cfelse>
		<cfquery name="getitembal" datasource="#dts#">
			select qtybf from icitem
			where itemno = '#itemno#'
		</cfquery>
		<cfif getitembal.recordcount neq 0>
			<cfset itembal = val(getitembal.qtybf)>
        <cfelse>
        	<cfset itembal = 0>
		</cfif>
	</cfif>
	
	<cfquery name="getin" datasource="#dts#">
		select 
		sum(qty)as sumqty 
		from ictran 
		where type in ('RC','CN','OAI','TRIN') 
		and itemno='#itemno#'
		and (linecode <> 'SV' or linecode is null)
		<cfif location neq "">
			and location = '#location#' 
		</cfif> 
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
		and itemno='#itemno#'
		and (linecode <> 'SV' or linecode is null)
		<cfif location neq "">
			and location = '#location#' 
		</cfif>  
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
		where <cfif checkdeductso.deductso eq "Y">type in ('DO','SO')<cfelse>type='DO'</cfif> 
		and (toinv='' or toinv is null) 
		and itemno='#itemno#' 
		and (linecode <> 'SV' or linecode is null)
		<cfif location neq "">
			and location = '#location#' 
		</cfif> 
		and fperiod <> '99' 
		and (void='' or void is null);
	</cfquery>

	<cfif getdo.sumqty neq "">
		<cfset DOqty = getdo.sumqty>
	<cfelse>
		<cfset DOqty = 0>
	</cfif>
    
   <cfquery name="getthisbill" datasource="#dts#">
		select qty
		from ictran 
		where type='#type#' 
        and refno='#refno#'
        and trancode='#trancode#'
		and (toinv='' or toinv is null) 
		and itemno='#itemno#' 
		and (linecode <> 'SV' or linecode is null)
		<cfif location neq "">
			and location = '#location#' 
		</cfif> 
		and fperiod <> '99' 
		and (void='' or void is null);
	</cfquery>
    
	
	<cfif lcase(hcomid) eq "remo_i">
		<cfquery name="getso" datasource="#dts#">
			select 
			ifnull(sum(qty),0) as sumqty 
			from ictran 
			where type='SO' 
			and itemno='#itemno#' 
			and (linecode <> 'SV' or linecode is null)
			and fperiod <> '99' 
			<cfif location neq "">
				and location = '#location#' 
			</cfif> 
			and (void='' or void is null) 
			and (toinv='' or toinv is null);
		</cfquery>
		
		<cfset balonhand = itembal + inqty - outqty - doqty - getso.sumqty>
	<cfelseif lcase(hcomid) eq "ecraft_i" or lcase(hcomid) eq "ovas_i">
		<cfquery name="getpo" datasource="#dts#">
			select 
			ifnull(sum(qty),0) as sumqty 
			from ictran 
			where type='PO' 
			and itemno='#itemno#' 
			and (linecode <> 'SV' or linecode is null)
			and fperiod <> '99' 
			<cfif location neq "">
				and location = '#location#' 
			</cfif> 
			and (void='' or void is null) 
			and (toinv='' or toinv is null)
		</cfquery>
		
		<cfset balonhand = itembal + inqty - outqty - doqty + getpo.sumqty>
	<cfelse>
    	<cfif type eq 'RC' or type eq 'CN' or type eq 'PO' or type eq 'QUO' or type eq 'SO' or type eq 'SAM' or type eq 'ISS'>
        <cfset balonhand = itembal + inqty - outqty - doqty>
        <cfelse>
        <cfset balonhand = itembal + inqty - outqty - doqty + val(getthisbill.qty)>
        </cfif>
	</cfif>
	
    <cfoutput>
		<input type="hidden" name="hidBalance" id="hidBalance" value = "#balonhand#">
    </cfoutput>
