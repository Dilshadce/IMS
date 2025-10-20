<cftry> 
<cfset totalfeedline = 0>
<cfset totalhashvalue = 0>

<cfquery name="getGeneral" datasource="#dts#">
SELECT externalthirdparty,invoiceDataFile,comuen,gstno from gsetup
</cfquery>

<!--- Control Header Record --->
<cfset row_identifier = "999">
<cfset transaction_id = "RCTV"&"           ">
<cfset filler = "    "> <!--- 4 x Blank --->

<cfset file_origin = #getGeneral.externalthirdparty#>

<!--- file_origin size is 16 so need to fill in the rest with space --->

<cfset len_file_origin = len(file_origin)>
<cfset space_file_origin = 16-len_file_origin>
<cfset extra_space_file_origin = "">
<cfloop from="1" to="#space_file_origin#" index="i">
<cfset extra_space_file_origin = extra_space_file_origin & " ">
</cfloop>

<cfset filler_2 = "                    "> <!--- 20 x Blank --->
<cfset creation_date_time = "#dateformat(now(),'dd/mm/yyyy')#"&" "&"#timeformat(now(),'HH:MM:SS')#" >

<cfset control_header_record = "#row_identifier#"&"#transaction_id#"&"#filler#"&"#file_origin#"&"#extra_space_file_origin#"&"#filler_2#"&"#creation_date_time#">

<cffile action = "write" file = "#HRootPath#\eInvoicing\#dts#\iv3600#getGeneral.invoiceDataFile#.dat"
output = "#control_header_record#">

<cfset totalfeedline = totalfeedline + 1>
<!--- End Control Header Record --->

<cfset invoicelist = form.einvoicelist>
<!--- Invoice Header --->
<cfset inv_row_identifier = "000">
<cfloop list="#form.einvoicelist#" index="i">

<cfquery name="updateartran" datasource="#dts#">
update artran set eInvoice_generated='Y' where refno = "#i#" 
</cfquery>

<cfquery name="getheader" datasource="#dts#">
SELECT * FROM artran as a left join #target_arcust# as ar on a.custno = ar.custno where a.refno = "#i#" 
</cfquery>

<!---<cfset business_unit = getheader.comuen>--->
<cfinvoke component="cfc.fillspace" method="addspace" inputdata="#getheader.comuen#" fieldsize="5"  returnvariable="business_unit"/>
<cfinvoke component="cfc.fillspace" method="addspace" inputdata="#getheader.refno#" fieldsize="30"  returnvariable="Invoice_No"/>
<cfif form.submitdate eq ''>
<cfset invoice_date = dateformat(getheader.wos_date,'dd/mm/yyyy')>
<cfelse>
<cfset invoice_date = dateformat(createdate(right(form.submitdate,4),mid(form.submitdate,4,2),left(form.submitdate,2)),'dd/mm/yyyy')>
</cfif>
<cfinvoke component="cfc.fillspace" method="addspace" inputdata="#getheader.pono#" fieldsize="17"  returnvariable="po_no"/>
<cfif getheader.ponodate neq "" and getheader.ponodate neq "0000-00-00">
<cfset po_date = dateformat(getheader.ponodate,'dd/mm/yyyy')>
<cfelse>
<cfset po_date = "          ">
</cfif>
<cfinvoke component="cfc.fillspace" method="addspace" inputdata="#getheader.dono#" fieldsize="30"  returnvariable="do_no"/>
<cfinvoke component="cfc.fillspace" method="addspace" inputdata="#getheader.refno2#" fieldsize="30"  returnvariable="related_invoice_no"/>
<cfinvoke component="cfc.fillspace" method="addspace" inputdata="#getgeneral.comuen#" fieldsize="10"  returnvariable="vendor_ID"/>

<cfif getheader.currcode neq "">
<cfset currency_code = getheader.currcode>
<cfelse>
<cfset currency_code = "   ">
</cfif>

<cfset freightamount = #numberformat(getheader.m_charge1,'.__')# >
<cfinvoke component="cfc.fillspace" method="addspace1" inputdata="#freightamount#" fieldsize="27"  returnvariable="freight_amount"/>

<cfset gstamount = #numberformat(getheader.tax,'.__')# >
<cfinvoke component="cfc.fillspace" method="addspace1" inputdata="#gstamount#" fieldsize="27"  returnvariable="GST_amount"/>

<cfset grossamount = #numberformat(getheader.grand,'.__')# >
<cfinvoke component="cfc.fillspace" method="addspace1" inputdata="#grossamount#" fieldsize="27"  returnvariable="gross_amount"/>

<cfif lcase(hcomid) eq "beps_i">
<cfquery name="getplacementno" datasource="#dts#">
select placementno from assignmentslip where refno='#getheader.refno#'
</cfquery>

<cfif getplacementno.recordcount eq 0>
<cfquery name="getplacementno" datasource="#dts#">
SELECT placementno from assignmentslip where refno='#listfirst(getheader.dono)#'
</cfquery>
</cfif>

<cfquery name="getbilltoperson" datasource="#dts#">
select billto from placement where placementno='#getplacementno.placementno#'
</cfquery>
<cfset attentionto = #getbilltoperson.billto#>
<cfif attentionto eq "">
<cfset attentionto = #getheader.attn#>
</cfif>
<cfelse>
<cfset attentionto = #getheader.attn#>
</cfif>
<cfinvoke component="cfc.fillspace" method="addspace" inputdata="#attentionto#" fieldsize="20"  returnvariable="attention_to"/>

<cfset description1 = "#getheader.desp#"&"#getheader.despa#">
<cfinvoke component="cfc.fillspace" method="addspace" inputdata="#description1#" fieldsize="254"  returnvariable="description"/>

<cfset creditterm = #getheader.term#>
<cfset credit_term = "">

<cfloop list="7,6,14,21,30,40,50,60" index="i">
<cfset day1 = #i#&"days">
<cfset day2 = #i#&" days">
<cfset day3 = #i#&"D">
<cfif lcase("#creditterm#") eq "#day1#" or lcase("#creditterm#") eq "#day2#" or creditterm eq i>
<cfset credit_term = "#day3#">
</cfif>
</cfloop>
<cfif credit_term eq "">
<cfset credit_term = "00">
</cfif>

<cfinvoke component="cfc.fillspace" method="addspace" inputdata="#credit_term#" fieldsize="5"  returnvariable="final_credit_term"/>


<cfset gst_applicability = "">
<cfset gst_registration = "">
<cfset gst_percentage ="">
<cfif getheader.tax gt 0>
<cfset gst_applicability = "Y">
<cfset gstregistration = "#getGeneral.gstno#">
<cfinvoke component="cfc.fillspace" method="addspace" inputdata="#gstregistration#" fieldsize="12"  returnvariable="gst_registration"/>

<!--- <cfset gst_percentage = (getheader.tax / (getheader.grand - getheader.tax)) * 100> --->
<cfset gst_percentage = 7 >
<!--- <cfset gstpercentage = "#numberformat(getheader.taxp1,'.__')#"> --->
</cfif>
<cfset invoice_header = "#inv_row_identifier#"&"#business_unit#"&"#invoice_no#"&"#invoice_date#"&"#po_no#"&"#po_date#"&"#do_no#"&"#related_invoice_no#"&"#vendor_id#"&"#currency_code#"&"#freight_amount#"&"#gst_amount#"&"#gross_amount#"&"#attention_to#"&"#description#"&"#final_credit_term#"&"#gst_applicability#"&"#gst_registration#"&"#numberformat(gst_percentage,'.__')#">


<cffile action="append" addnewline="yes" 
   file = "#HRootPath#\eInvoicing\#dts#\iv3600#getGeneral.invoiceDataFile#.dat"
   output = "#invoice_header#">

<cfset A = 0>
<cfset B = 0>
<cfset C = 0>
<cfset D = 0>
<cfloop from="1" to="15" index="i">
<cfset inputvalue = mid('#invoice_no#','#i#','1')>
<cfinvoke component="cfc.eInvMapTable" method="maptable" inputchar="#inputvalue#"   returnvariable="Avalue"/>
<cfset A=A+Avalue>
</cfloop>
<cfloop from="16" to="30" index="i">
<cfset inputvalue = mid('#invoice_no#','#i#','1')>
<cfinvoke component="cfc.eInvMapTable" method="maptable" inputchar="#inputvalue#"   returnvariable="bvalue"/>
<cfset b=b+bvalue>
</cfloop>
<cfloop from="1" to="15" index="i">
<cfset inputvalue = mid('#gross_amount#','#i#','1')>
<cfinvoke component="cfc.eInvMapTable" method="maptable" inputchar="#inputvalue#"   returnvariable="cvalue"/>
<cfset c=c+cvalue>
</cfloop>
<cfloop from="16" to="27" index="i">
<cfset inputvalue = mid('#gross_amount#','#i#','1')>
<cfinvoke component="cfc.eInvMapTable" method="maptable" inputchar="#inputvalue#"   returnvariable="dvalue"/>
<cfset d=d+dvalue>
</cfloop>

<cfset formodvalue = abs((B+D)-(A+C)) >
<cfset remainder = ( formodvalue mod 13) >



<cfset totalhashvalue = totalhashvalue + remainder>
<cfset totalfeedline = totalfeedline + 1>
<cfoutput>
#invoice_no#,#gross_amount#,#A#,#B#,#C#,#D#,#remainder#,#totalhashvalue#<br/>
</cfoutput>
<!--- End Invoice Header --->


<!--- Invoice Line --->
<cfset line_row_identifier = "001">
<cfquery name="getDetails" datasource="#dts#">
SELECT * FROM ictran where refno = "#getheader.refno#" and type = "INV"
</cfquery>


<cfloop query="getDetails">

<cfinvoke component="cfc.fillspace" method="addspace1" inputdata="#getDetails.trancode#" fieldsize="5"  returnvariable="invoice_line_no"/>
<cfset pricebill = getDetails.price_bil>
<cfif getheader.taxincl eq "T" or getDetails.taxincl eq "T">

<cfif getheader.taxincl eq "T">

<cfset linegstamount = (pricebill * getheader.taxp1 / (100+getheader.taxp1))>
<cfset unitprice = numberformat(pricebill - linegstamount,'.__')>

</cfif>

<cfif getDetails.taxincl eq "T">

<cfset linegstamount = (pricebill * getDetails.taxpec1 / (100+getDetails.taxpec1))>
<cfset unitprice = numberformat(pricebill - linegstamount,'.__')>

</cfif>
<cfelse>
<cfset unitprice = pricebill >
</cfif>
<cfinvoke component="cfc.fillspace" method="addspace1" inputdata="#numberformat(unitprice,'._____')#" fieldsize="17"  returnvariable="unit_price"/>
<cfset linequantity = getDetails.Qty_bil>
<cfinvoke component="cfc.fillspace" method="addspace1" inputdata="#numberformat(linequantity,'.____')#" fieldsize="17"  returnvariable="quantity"/>

<cfif getheader.taxincl eq "T" or getDetails.taxincl eq "T">
<cfinvoke component="cfc.fillspace" method="addspace1" inputdata="#numberformat(linegstamount * linequantity,'.__')#" fieldsize="27"  returnvariable="line_gst_amount"/>
<cfelse>
<cfset linegstamount = getdetails.taxamt>
<cfinvoke component="cfc.fillspace" method="addspace1" inputdata="#numberformat(getdetails.taxamt,'.__')#" fieldsize="27"  returnvariable="line_gst_amount"/>
</cfif>

<cfset merchandiseamount = numberformat((val(unitprice) * val(linequantity))+0.000000000001,'.__') + (linegstamount)>
<cfif getheader.taxincl eq "T" or getDetails.taxincl eq "T">
<cfset lineamount = getDetails.amt>
<cfelse>
<cfset lineamount = getDetails.amt + getdetails.taxamt>
</cfif>
<!--- <cfoutput>
#linequantity#-#numberformat((unitprice * linequantity),'.__')# - #linegstamount# - #unitprice# - #getDetails.amt# - #getdetails.taxamt# -#numberformat(lineamount,'.__')# - #numberformat(merchandiseamount,'.__')#<br/>
</cfoutput> --->
<cfif numberformat(lineamount,'.__') eq numberformat(merchandiseamount,'.__')>
<cfinvoke component="cfc.fillspace" method="addspace1" inputdata="#numberformat(merchandiseamount,'.__')#" fieldsize="27"  returnvariable="merchandise_amount"/>
</cfif>

<cfset line_description = "#getDetails.DESP#"&"#getDetails.DESPA#">
<cfset invoice_line = "#line_row_identifier#"&"#invoice_line_no#"&"#unit_price#"&"#quantity#"&"#line_gst_amount#"&"#merchandise_amount#"&"#trim(line_description)#">
<cffile action="append" addnewline="yes" 
   file = "#HRootPath#\eInvoicing\#dts#\iv3600#getGeneral.invoiceDataFile#.dat"
   output = "#invoice_line#">
<cfset totalfeedline = totalfeedline + 1>
</cfloop>


</cfloop>

<!--- End Invoice Line --->

<!--- Trailer Record --->
<cfset trailer_row_identifier = "TRL">
<cfset trailer_transaction_ID = "RCTV"&"           ">
<cfset totalfeedline = totalfeedline + 1 >
<cfinvoke component="cfc.fillspace" method="addspace1" inputdata="#totalfeedline#" fieldsize="9"  returnvariable="total_feed_line"/>

<cfif form.hashcode neq ''>
<cfinvoke component="cfc.fillspace" method="addspace1" inputdata="#numberformat(val(hashcode),'.__')#" fieldsize="17"  returnvariable="total_hash_value"/>
<cfelse>
<cfinvoke component="cfc.fillspace" method="addspace1" inputdata="#numberformat(totalhashvalue,'.__')#" fieldsize="17"  returnvariable="total_hash_value"/>
</cfif>
<cfset trailer_record = "#trailer_row_identifier#"&"#trailer_transaction_ID#"&"#total_feed_line#"&"#total_hash_value#" >
<cffile action="append" addnewline="yes" 
   file = "#HRootPath#\eInvoicing\#dts#\iv3600#getGeneral.invoiceDataFile#.dat"
   output = "#trailer_record#">
   <cfset msg = invoicelist>
   <cfset error = 0>
   
   <cfcatch type="any">
   <cfset msg = "#cfcatch.Detail#">
   <cfset error = 1>
   <cfoutput>
   #msg#
   </cfoutput>
   <cfabort>
   </cfcatch>
   </cftry>
   <!---<cfif huserid eq 'ultralung'>
   <cfabort>
   </cfif>--->
   <cfoutput>
   <form name="form1" id="form1" method="post" action="/default/eInvoicing/eInvoicePost.cfm">
   <input type="hidden" name="msg1" id="msg1" value="#msg#" />
   <input type="hidden" name="errorvalid" id="errorvalid" value="#error#" />
   </form>
   </cfoutput>
<!---    <cfif getauthuser() neq "ultracai"> --->
 <script>
	form1.submit();
	</script>
   <!---  </cfif> --->



