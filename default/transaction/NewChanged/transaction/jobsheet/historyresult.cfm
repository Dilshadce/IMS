<html>
<head>
<title>VIEW JOB SHEET HISTORY REPORT</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>
<body>
<h1 align="center">VIEW JOB SHEET HISTORY REPORT</h1>
<cfoutput>
<h3 align="center">INVOICE NO : #refno#</h3>

	<cfquery name="getservice_tran" datasource="#dts#">
				select * from service_tran where refno = "#refno#"
				
	</cfquery>

	<table cellspacing="0" class="data" width="100%">
		<tr>
        	<th nowrap>Service ID</th>
            <th nowrap>Date of Service</th>
            <th nowrap>Time</th>
			<th nowrap>Service Type</th>
			<th nowrap>CSO</th>
            <th nowrap>Assign By</th>
			<th nowrap>Job Description</th>
            <th nowrap>Comment</th>
		</tr>
		
			
			<cfloop query="getservice_tran">
				
				<tr>
					<td align="left">#getservice_tran.serviceid#</td>
                    <td align="left">#dateformat(getservice_tran.servicedate,"dd-mm-yyyy")#</td>
                    <td align="left">#getservice_tran.apptime#</td>
                    <td align="left">#getservice_tran.servicetype#</td>
					<td align="left">#getservice_tran.csoid#</td>
                    <td align="left">#getservice_tran.assby#</td>
					<td align="justify">#tostring(getservice_tran.instruction)#</td>
					<td align="justify">#tostring(getservice_tran.comments)#</td>
				</tr>
			</cfloop>
	</table>

</cfoutput>

<cfif getservice_tran.recordcount eq 0>
	<h3>Sorry,No Records Found !</h3>
</cfif>

</body>
</html>