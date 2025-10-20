<!--- update artran RC --->
<cfif form.totaldisc neq "">
	<cfset xtotaldisc = form.totaldisc>
<cfelse>
	<cfset xtotaldisc = 0>
</cfif>

<cfif form.totalamtdisc neq "">
	<cfset xtotalamtdisc = form.totalamtdisc>
<cfelse>
	<cfset xtotalamtdisc = 0>
</cfif>

<cfif form.subtotal neq "">
	<cfset xsubtotal = form.subtotal>
<cfelse>
	<cfset xsubtotal = 0>
</cfif>

<cfif form.totaltax neq "">
	<cfset xtotaltax = form.totaltax>
<cfelse>
	<cfset xtotaltax = 0>
</cfif>

<cfif xtotaldisc neq 0 and xtotalamtdisc eq 0>
	<cfset disc1_bil = xsubtotal * xtotaldisc / 100>
	<cfset tax1_bil =  xsubtotal * xtotaltax / 100>
	<cfset xgrand = xsubtotal - disc1_bil - tax1_bil>
	
	<cfquery datasource="#dts#" name="updateartran">
		Update artran set invgross ='#xsubtotal#', disp1 = '#xtotaldisc#', taxp1 = '#xtotaltax#', disc1_bil = '#disc1_bil#', 
		tax1_bil='#tax1_bil#', grand = '#xgrand#', note = '#form.selecttax#'
		where refno = "#nexttranno#" and type = 'RC'
	</cfquery>	
<cfelseif xtotalamtdisc neq 0 and xtotaldisc eq 0>
	<cfset disc1_bil = xtotalamtdisc>
	<cfset tax1_bil =  xsubtotal * xtotaltax / 100>
	<cfset xgrand = xsubtotal - disc1_bil - tax1_bil>
	
	<cfquery datasource="#dts#" name="updateartran">
		Update artran set invgross ='#xsubtotal#', taxp1 = '#xtotaltax#', disc1_bil = '#disc1_bil#', 
		tax1_bil='#tax1_bil#', grand = '#xgrand#', note = '#form.selecttax#'
		where refno = "#nexttranno#" and type = 'RC'
	</cfquery>	
<cfelse>
	<cfset disc1_bil = xsubtotal * xtotaldisc / 100>
	<cfset tax1_bil =  xsubtotal * xtotaltax / 100>
	<cfset xgrand = xsubtotal - disc1_bil - tax1_bil>
	
	<cfquery datasource="#dts#" name="updateartran">
		Update artran set invgross ='#val(xsubtotal)#', disp1 = '#val(xtotaldisc)#', taxp1 = '#val(xtotaltax)#', disc1_bil = '#val(disc1_bil)#', 
		tax1_bil='#val(tax1_bil)#', grand = '#val(xgrand)#', note = '#form.selecttax#'
		where refno = "#nexttranno#" and type = 'RC'
	</cfquery>
</cfif>

<!--- update artran ISS --->
<cfquery name="getictran" datasource="#dts#">
	select sum(amt_bil) as subtotal from ictran where refno = '#nexttranno#' and type = "ISS"
</cfquery>

<cfif getictran.subtotal neq "">
	<cfset xsubtotal = #getictran.subtotal#>
<cfelse>
	<cfset xsubtotal = 0>
</cfif>

<cfif xtotaldisc neq 0 and xtotalamtdisc eq 0>
		<cfset disc1_bil = xsubtotal * xtotaldisc / 100>
		<cfset tax1_bil =  xsubtotal * xtotaltax / 100>
		<cfset xgrand = xsubtotal - disc1_bil - tax1_bil>
		
		<cfquery datasource="#dts#" name="updateartran">
			Update artran set invgross ='#xsubtotal#', disp1 = '#xtotaldisc#', taxp1 = '#xtotaltax#', disc1_bil = '#disc1_bil#', 
			tax1_bil='#tax1_bil#', grand = '#xgrand#', note = '#form.selecttax#'
			where refno = "#nexttranno#" and type = 'ISS'
		</cfquery>	
<cfelseif xtotalamtdisc neq 0 and xtotaldisc eq 0>
	<cfset disc1_bil = #xtotalamtdisc#>
	<cfset tax1_bil =  #xsubtotal# * #xtotaltax# / 100>
	<cfset xgrand = #xsubtotal# - #disc1_bil# - #tax1_bil#>
	
	<cfquery datasource="#dts#" name="updateartran">
		Update artran set invgross ='#xsubtotal#', taxp1 = '#xtotaltax#', disc1_bil = '#disc1_bil#', 
		tax1_bil='#tax1_bil#', grand = '#xgrand#', note = '#form.selecttax#'
		where refno = "#nexttranno#" and type = 'ISS'
	</cfquery>	
<cfelse>
	<cfset disc1_bil = xsubtotal * xtotaldisc / 100>
	<cfset tax1_bil =  xsubtotal * xtotaltax / 100>
	<cfset xgrand = xsubtotal - disc1_bil - tax1_bil>
	
	<cfquery datasource="#dts#" name="updateartran">
		Update artran set invgross ='#xsubtotal#', disp1 = '#xtotaldisc#', taxp1 = '#xtotaltax#', disc1_bil = '#disc1_bil#', 
		tax1_bil='#tax1_bil#', grand = '#xgrand#', note = '#form.selecttax#'
		where refno = "#nexttranno#" and type = 'ISS'
	</cfquery>	
</cfif>

<cflocation url="transaction.cfm?tran=RC"> 