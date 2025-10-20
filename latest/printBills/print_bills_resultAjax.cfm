<cfset tran=url.tran>
<cfset nexttranno = url.nexttranno>
<cfset BillName = url.BillName>
<cfset doption = url.doption>
<cfset billFormatLocation = url.billFormatLocation>

<cfquery name="getgsetup" datasource="#dts#">
	SELECT bcurr,gstno
    FROM gsetup;
</cfquery>

<cfoutput>
	<cfif getgsetup.gstno eq "">
    <iframe width="840" height="840" src="#billFormatLocation#?tran=#tran#&nexttranno=#nexttranno#&BillName=#BillName#&doption=#doption#&tax=#url.tax#&GST=N">
    </iframe>
    <cfelse>
    <iframe width="840" height="840" src="#billFormatLocation#?tran=#tran#&nexttranno=#nexttranno#&BillName=#BillName#&doption=#doption#&tax=#url.tax#&GST=Y">
    </iframe>
    </cfif>
</cfoutput>