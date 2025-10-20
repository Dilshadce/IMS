<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfquery datasource="#dts#" name="getGeneralInfo1">
	Select *

	from GSetup
</cfquery>

<html>
<head>
	<title>Voucher Approve</title>
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

	<cfquery datasource='#dts#' name="gettransaction">
	select * from vouchertrantemp where approved !='Y'
	</cfquery>


<body>
	<h1>Voucher Approve</h1>
	<cfoutput>
    <h4>
<a href="voucher.cfm">Create Voucher</a>|<a href="p_voucher.cfm">Voucher Listing</a>|<a href="vouchermaintenance.cfm">Voucher Maintenance</a><cfif getpin2.h1R10 eq "T">|<a href="voucherapprove.cfm">Voucher Approval</a></cfif>|<a href="voucherusage.cfm">Voucher Usage Report</a>|<a href="voucherprefix.cfm">Voucher Prefix</a></h4>
  </cfoutput>


<table align="center" class="data">
  	<tr>
    	<th>Voucher From</th>
		<th>Voucher Balance</th>
		<th>Transfer Amount</th>
    	<th>Voucher To</th>
    	<th>Voucher To Balance</th>
    	<th>Action</th>
  	</tr>

	<cfoutput query="gettransaction">
    
    <cfquery name="getvoucherfrom" datasource="#dts#">
SELECT a.voucherno,coalesce(a.value,0)-coalesce(b.usagevalue,0) as value,a.type,a.used from voucher as a
            left join
            (
            SELECT sum(usagevalue) as usagevalue,voucherno FROM vouchertran
            group by voucherno
            )
            as b on a.voucherno = b.voucherno
            where a.type = "Value" 
            and a.voucherno='#gettransaction.vouchernofrom#'
            order by a.voucherno
</cfquery>

<cfquery name="getvoucherto" datasource="#dts#">
SELECT a.voucherno,coalesce(a.value,0)-coalesce(b.usagevalue,0) as value,a.type,a.used from voucher as a
            left join
            (
            SELECT sum(usagevalue) as usagevalue,voucherno FROM vouchertran
            group by voucherno
            )
            as b on a.voucherno = b.voucherno
            where a.type = "Value" 
            and a.voucherno='#gettransaction.vouchernoto#'
            order by a.voucherno
</cfquery>
    
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
      	<td nowrap>#gettransaction.vouchernofrom#</td>
		<td nowrap>#getvoucherfrom.value#</td>
	  	<td nowrap>#gettransaction.usagevaluefrom#</td>
      	<td nowrap>#gettransaction.vouchernoto#</td>
      	<td nowrap>#getvoucherto.value#</td>
		<td>
			<img height="18px" width="18px" src="/images/tick.gif" alt="Edit" border="0"><a href="voucherappprocess.cfm?approve=1&id=#id#">Approve</a>
			<img height="18px" width="18px" src="../../../images/PNG-48/Delete.png" alt="Delete" border="0"><a href="voucherappprocess.cfm?delete=1&id=#id#">Delete</a>
			</td>

    </tr>
  	</cfoutput>
</table>

</body>
</html>