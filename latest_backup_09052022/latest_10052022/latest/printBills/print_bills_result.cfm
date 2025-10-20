<cfif tran eq 'PO' or tran eq 'PR' or tran eq 'RC'>
    <cfset ptypename = "Supplier">
<cfelse>
    <cfset ptypename = "Customer">
</cfif>

<cfquery name="getCustomizedFormat" datasource="#dts#">
    SELECT * 
    FROM customized_format
    WHERE type='#tran#'
    AND file_name <>"receipt_non_editable"
    ORDER BY counter;
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
	SELECT bcurr,gstno
    FROM gsetup;
</cfquery>


<cfif getCustomizedFormat.recordCount EQ 0>
	<cfif getgsetup.bcurr EQ 'MYR'>
		<cfset billFormatLocation = '/billformat/default/newDefault/MYR/preprintedformat.cfm'>	
    <cfelse>
    	<cfset billFormatLocation = '/billformat/default/newDefault/preprintedformat.cfm'>
    </cfif>
<cfelse>
	<cfset billFormatLocation = '/billformat/#dts#/preprintedformat.cfm'>
</cfif>

<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
        <script type="text/javascript">
			var selectedrow = "tr1";
			function highlight(rowval){		
				document.getElementById(selectedrow).style.backgroundColor='FFFFFF';
				document.getElementById(rowval).style.backgroundColor='99FF00';
				selectedrow = rowval;
			}
        </script>
        <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    </head>

<noscript>
Javascript has been disabled or not supported in this browser. Please enable Javascript supported before continue.
</noscript>

<cfquery datasource='#dts#' name="getHeaderInfo">
	select * 
    from artran 
	where type = '#tran#'
	<cfif form.billFrom neq "" and form.billTo neq "">
		and	refno between '#form.billFrom#' and '#form.billTo#' 
	<cfelse>
		and fperiod <> '99'
	</cfif>
	<cfif form.periodfrom neq "" and form.periodto neq "">
		and fperiod between '#form.periodfrom#' and '#form.periodto#'
	</cfif>
    <cfif form.datefrom neq "" and form.dateto neq "">
    <cfinvoke component="cfc.date" method="getDbDate" inputDate="#form.datefrom#" returnvariable="datefrom1"/>
    <cfinvoke component="cfc.date" method="getDbDate" inputDate="#form.dateto#" returnvariable="dateto1"/>
    	and wos_date between '#datefrom1#' and '#dateto1#'
    </cfif>
      <cfif form.customerFrom neq "" and form.customerTo neq "">
    	and custno between '#form.customerFrom#' and '#form.customerTo#'
    </cfif>
      <cfif form.driverFrom neq "" and form.driverTo neq "">
    	and van between '#form.driverFrom#' and '#form.driverTo#'
    </cfif>
	order by refno
</cfquery>

<cfoutput>
Condition:<br/>
<cfif form.billFrom neq "" and form.billTo neq "">
		INV between '#form.billFrom#' and '#form.billTo#' <br />
	<cfelse>
		Period  not equal to 99<br />
	</cfif>
	<cfif form.periodfrom neq "" and form.periodto neq "">
		Period between '#form.periodfrom#' and '#form.periodto#' <br />
	</cfif>
    <cfif form.datefrom neq "" and form.dateto neq "">
    
    	Bill date between '#datefrom1#' and '#dateto1#'<br />
    </cfif>
      <cfif form.customerFrom neq "" and form.customerTo neq "">
    	 #ptypename# no between '#form.customerFrom#' and '#form.customerTo#'<br />
    </cfif>
      <cfif form.driverFrom neq "" and form.driverTo neq "">
    	End user between '#form.driverFrom#' and '#form.driverTo#'<br />
    </cfif>

<hr />
<div style="width:350px; max-height:650px; float:left; position:fixed; overflow:scroll;">
    <table id="table1">
        <tr>
        	<th>No</th>
            <th>Bill No</th>
            <th>date</th>
        </tr>
        <cfloop query="getHeaderInfo">
       		<tr id="tr#getHeaderInfo.currentrow#" onClick="highlight('tr#getHeaderInfo.currentrow#');ajaxFunction(document.getElementById('ajaxField'),'print_bills_resultAjax.cfm?tran=#tran#&nexttranno=#getHeaderInfo.refno#&BillName=#getCustomizedFormat.file_name#&doption=#getCustomizedFormat.d_option#&billFormatLocation=#billFormatLocation#&tax=#url.tax#&GST=Y');" onMouseOver="style.cursor='hand';" >
            	<td>#getHeaderInfo.currentrow#</td>
                <td>#getHeaderInfo.refno#</td>
                <td>#dateformat(getHeaderInfo.wos_date,'yyyy/mm/dd')#</td>
           	</tr>
        </cfloop>
    </table>

</div>
<div id="ajaxField" name="ajaxField" style="width:840px; margin: 0 20px 0 360px;">
	<cftry>
    <cfif getgsetup.gstno eq "">
    <iframe 
    	width="840" 
        height="840" 
        src="#billFormatLocation#?tran=#tran#&nexttranno=#getHeaderInfo.refno#&BillName=#getCustomizedFormat.file_name#&doption=#getCustomizedFormat.d_option#&tax=#url.tax#&GST=N" >
    </iframe>
    <cfelse>
    <iframe 
    	width="840" 
        height="840" 
        src="#billFormatLocation#?tran=#tran#&nexttranno=#getHeaderInfo.refno#&BillName=#getCustomizedFormat.file_name#&doption=#getCustomizedFormat.d_option#&tax=#url.tax#&GST=Y" >
    </iframe>
    </cfif>
    <cfcatch>
    </cfcatch>
    </cftry>
    
</div>
</cfoutput>
</body>
</html>