	<cfquery name="getfilename" datasource="#dts#">
    select tenantno from POSFTP
    </cfquery>
	
	<cfset dd = dateformat(form.billdate, "DD")>
	<cfif dd greater than '12'>
		<cfset ndatefrom = dateformat(form.billdate,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom = dateformat(form.billdate,"YYYYDDMM")>
	</cfif>
    <cfquery name="getbillamount" datasource="#dts#">
    select sum(grand_bil) as grand,sum(net_bil) as net,sum(tax_bil) as tax,count(refno) as refno from artran where type='CS' and wos_date='#ndatefrom#' and (void ='' or void is null)
    
    </cfquery>
<cfset control_header_record = "#getbillamount.grand#"&"|"&"#getbillamount.net#"&"|"&"#getbillamount.tax#"&"|"&"#getbillamount.refno#"&"|"&"#dateformat(ndatefrom,'DD-MM-YYYY')#">

<cfset currentDirectory = "C:\possubmission\"& form.companyname>
<cfif DirectoryExists(currentDirectory) eq false>
<cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>

<cffile action = "write" file = "C:\possubmission\#getfilename.tenantno##ndatefrom#.txt"
output = "#control_header_record#">
   
   <cfoutput>
   <form name="form1" id="form1" method="post" action="/default/transaction/POSSubmission/POSPost.cfm">
   <input type="hidden" name="billdate" id="billdate" value="#ndatefrom#" />
   <input type="hidden" name="errorvalid" id="errorvalid" value="" />
   </form>
   </cfoutput>
   
 <script>
	form1.submit();
	</script>



