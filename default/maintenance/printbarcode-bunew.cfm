<cfquery name="getGsetup" datasource="#dts#">
	select bcurr 
    from gsetup;
</cfquery>

<cfset currencyCode = getGsetup.bcurr>

<cfquery datasource="#dts#" name="getsettingrecord">
		select * from print_barcode_setting
</cfquery>
<cfif getsettingrecord.recordcount eq 0>

<cfquery datasource="#dts#" name="insertdisplaysetup">

	insert into print_barcode_setting (id)
    values (1)            

</cfquery>

</cfif>

<cfif val(form.barcodewidth) eq 0>
<cfset form.barcodewidth=2>
</cfif>

<cfquery datasource="#dts#" name="SaveGeneralInfo">
		update print_barcode_setting set 
        no_copies='#form.noofcopy#', spacing="#val(form.spacing)#", top_spacing="#val(form.topspacing)#", left_spacing="#form.leftspacing#", font_size="#form.fontsize#",barcodewidth="#form.barcodewidth#"
        
        <cfif isdefined("form.hdwide")>
        	,wide_version = '1'
        <cfelse>
         	,wide_version = '0'
		</cfif>
        
        <cfif isdefined("form.barcode")>
        	,bar_code = '1'
        <cfelse>
         	,bar_code = '0'
		</cfif>
        
        <cfif isdefined("form.format2")>
        	,format_2 = '1'
        <cfelse>
         	,format_2 = '0'
		</cfif>
        
        <cfif isdefined("form.format3")>
        	,format_3 = '1'
        <cfelse>
         	,format_3 = '0'
		</cfif>
        
        <cfif isdefined("form.format4")>
        	,format_4 = '1'
        <cfelse>
         	,format_4 = '0'
		</cfif>
        
        <cfif isdefined("form.format5")>
        	,format_5 = '1'
        <cfelse>
         	,format_5 = '0'
		</cfif>
        
        <cfif isdefined("form.format6")>
        	,format_6 = '1'
        <cfelse>
         	,format_6 = '0'
		</cfif>
        <cfif isdefined("form.format7")>
        	,format_7 = '1'
        <cfelse>
         	,format_7 = '0'
		</cfif>
</cfquery>
<cfif form.rcno neq ''>
<cfquery name="MyQuery" datasource="#dts#">
	select itemno,qty,desp,despa,price,unit,(select sizeid from icitem where itemno=a.itemno) as sizeid,(select packing from icitem where itemno=a.itemno) as packing,despa,category,(select barcode from icitem where itemno=a.itemno) as barcode,(select aitemno from icitem where itemno=a.itemno) as aitemno from ictran as a
	
    <cfif trim(form.rcno) neq "">
				where refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rcno#">
	</cfif>
	order by itemno
</cfquery>
<cfelse>
<cfquery name="MyQuery" datasource="#dts#">
	select itemno,desp,despa,price,unit,sizeid,despa,category,barcode,packing,aitemno,1 as qty from icitem
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		where itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemto#">
	</cfif>
	<cfif val(form.noofcopy) gt 1>
		<cfloop from="2" to="#val(form.noofcopy)#" index="i">
			union all
			select itemno,desp,despa,price,despa,unit,sizeid,packing,category,barcode,aitemno,qty from icitem
			<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
				where itemno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemto#">
			</cfif>
		</cfloop>
	</cfif>
	order by itemno
</cfquery>
</cfif>

<cfloop from="1" to="#val(form.topspacing)#" index="i">
<br />
</cfloop>

<cfloop query="MyQuery" >
<cfoutput>
<cfloop from="1" to="#MyQuery.qty#" index="z">
<div style="page-break-after:always;<cfif myquery.currentrow eq 1>margin-top:-8px;</cfif>">
<table>
<tr><td width="#val(form.leftspacing)#"></td><td style="font-size:#fontsize#px;line-height:#fontsize-2#px;" align="center">#MyQuery.desp#</td><td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td></tr>
<tr><td width="#val(form.leftspacing)#"></td><td style="font-size:#fontsize#px;line-height:#fontsize-2#px;" align="center"><cfif getGsetup.bcurr eq "MYR">RM<cfelse>$</cfif>#numberformat(MyQuery.price,',.__')#</td><td align="right" style="font-size:#fontsize#px;line-height:#fontsize-2#px;"></td></tr>

	<cfif isdefined('form.barcode')>
        <tr><td width="#val(form.leftspacing)#"></td><td height="13px"  align="center"><img src="barcode.cfc?method=getCode128&data=#MyQuery.barcode#&width=1" width="70" />
</td></tr>
        <tr><td width="#val(form.leftspacing)#"></td><td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.barcode#</td></tr>
    <cfelse>
    	<tr><td width="#val(form.leftspacing)#"></td><td height="13px"  align="center"><img src="barcode.cfc?method=getCode128&data=#MyQuery.itemno#&width=1" width="70" />
</td></tr>
        <tr><td width="#val(form.leftspacing)#"></td><td colspan="2" align="center" style="font-size:#fontsize#px;line-height:#fontsize-2#px;">#MyQuery.itemno#</td></tr>
    </cfif>
</table>
<cfloop from="1" to="#val(form.spacing)#" index="i">
<br />
</cfloop>
</div>
</cfloop>
</cfoutput>
</cfloop>





