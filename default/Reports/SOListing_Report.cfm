<html>
<head>
<title>View Sales Order Listing Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<cfif url.type eq "1">
	<cfset trantype = "Sales Order">
	<cfset trancode = "SO">
</cfif>

<cfif trancode eq "INV" or trancode eq "CN" or trancode eq "DN" or trancode eq "CS" or trancode eq "QUO" or trancode eq "SO" or trancode eq "DO">
	<cfquery datasource="#dts#" name="getsupp">
		select customerno,name from customer order by customerno
	</cfquery>

	<cfset title = "Customer">
<cfelse>
	<cfquery datasource="#dts#" name="getsupp">
		select customerno,name from supplier order by customerno
	</cfquery>

	<cfset title = "Supplier">
</cfif>

<cfquery datasource="#dts#" name="getagent">
	select agent from icagent order by agent
</cfquery>

<body>

<!--- <cfform action= "..\reports\solisting_Report_b.cfm?type=#trantype#&trancode=#trancode#" method="post" name="form123"> --->
<cfform action= "..\reports\solisting_report_b.cfm?trantype=#trantype#&trancode=#trancode#" method="post" name="form123">
	<cfoutput>
    	<h2>Print #trantype# Listing Report</h2>
	</cfoutput>
	<br>
	<br>
  	<table border="0" align="center" width="80%" class="data">
		<cfoutput>
      		<input type="hidden" name="title" value="#title#">
    	</cfoutput>
    	<tr>
			<th width="19%"><cfoutput>Report Type</cfoutput></th>
      		<td width="8%">&nbsp;</td>
  		    <td>
 				<select name="reporttype">
				  <cfoutput><option value="">Choose a report type</option></cfoutput>
				  <cfoutput><option value="1">Detail</option></cfoutput>
				  <cfoutput><option value="2">Summary</option></cfoutput>
				  <cfoutput><option value="3">Outstanding</option></cfoutput>
				  <cfoutput><option value="4">Completed</option></cfoutput>
				</select>
			</td>
    	</tr>

		<tr>
      		<td colspan="4"><hr></td>
    	</tr>

		<tr>
			<th width="19%"><cfoutput>#title#</cfoutput></th>
			<td width="8%"> <div align="center">From</div></td>
			<td>
				<select name="getfrom">
					<cfoutput> <option value="">Choose a #title#</option></cfoutput>
					<cfoutput query="getsupp">
						<option value="#customerno#">#customerno# - #name#</option>
					</cfoutput>
			  	</select>
			</td>
    	</tr>

		<tr>
			<th width="19%"><cfoutput>#title#</cfoutput></th>
			<td width="8%"> <div align="center">To</div></td>
			<td>
				<select name="getto">
					<cfoutput><option value="">Choose a #title#</option></cfoutput>
					<cfoutput query="getsupp">
						<option value="#customerno#">#customerno# - #name#</option>
					</cfoutput>
				</select>
			</td>
		</tr>

		<tr>
      		<td colspan="4"><hr></td>
    	</tr>

	    <tr>
			<th width="19%">Agent</th>
			<td width="8%"> <div align="center">From</div></td>
			<td>
				<select name="agentfrom">
					<option value="">Choose a Agent</option>
					<cfoutput query="getagent">
						<option value="#agent#">#agent#</option>
					</cfoutput>
				</select>
			</td>
		</tr>

	    <tr>
    		<th width="19%">Agent</th>
			<td width="8%"> <div align="center">To</div></td>
			<td>
				<select name="agentto">
					<option value="">Choose a Agent</option>
				    <cfoutput query="getagent">
            			<option value="#agent#">#agent#</option>
			        </cfoutput>
				</select>
			</td>
	    </tr>

		<tr>
      		<td colspan="4"><hr></td>
	    </tr>

		<tr>
			<th width="19%">Period</th>
			<td width="8%"> <div align="center">From</div></td>
			<td>
				<select name="periodfrom">
					<option value="">Choose a period</option>
					<option value="01">1</option>
					<option value="02">2</option>
					<option value="03">3</option>
					<option value="04">4</option>
					<option value="05">5</option>
					<option value="06">6</option>
					<option value="07">7</option>
					<option value="08">8</option>
					<option value="09">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
					<option value="14">14</option>
					<option value="15">15</option>
					<option value="16">16</option>
					<option value="17">17</option>
					<option value="18">18</option>
				</select>
			</td>
	    </tr>

		<tr>
			<th width="19%">Period</th>
			<td width="8%"> <div align="center">To</div></td>
			<td>
				<select name="periodto">
					<option value="">Choose a period</option>
					<option value="01">1</option>
					<option value="02">2</option>
					<option value="03">3</option>
					<option value="04">4</option>
					<option value="05">5</option>
					<option value="06">6</option>
					<option value="07">7</option>
					<option value="08">8</option>
					<option value="09">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
					<option value="14">14</option>
					<option value="15">15</option>
					<option value="16">16</option>
					<option value="17">17</option>
					<option value="18">18</option>
				</select>
		  	</td>
		</tr>

		<tr>
      		<td colspan="4"><hr></td>
    	</tr>

		<tr>
			<th width="19%">Date</th>
			<td width="8%"> <div align="center">From</div></td>
			<td><cfinput type="text" name="datefrom" maxlength="10" validate="eurodate" size="10">
			(DD/MM/YYYY)</td>
		</tr>

		<tr>
			<th width="19%">Date</th>
			<td width="8%"> <div align="center">To</div></td>
			<td> <cfinput type="text" name="dateto" maxlength="10" validate="eurodate" size="10">
			(DD/MM/YYYY)</td>
		</tr>

		<tr>
			<td colspan="4"><hr></td>
		</tr>

		<tr>
			<th>Sort by</th>
			<td>&nbsp;</td>
			<td>
				<table width="433">
					<tr>
						<td width="425"><label>
							<input name="rgSort" type="radio" value="Contract No" checked>
							Contract No.</label>
						</td>
					</tr>
					<tr>
						<td><label>
							<input type="radio" name="rgSort" value="Client Name">
								Client Name</label>
						</td>
					</tr>
					<tr>
						<td><label>
							<input type="radio" name="rgSort" value="Client Code">
								Client Code</label>
						</td>
					</tr>
					<tr>
						<td>
							<label><input type="radio" name="rgSort" value="Month"> Month</label>
						</td>
<!--- 	 					<cfif url.type eq "1A" or url.type eq "1B" or url.type eq "1C">
							<td>
								<label><input type="radio" name="rgSort" value="Month"> Month</label>
							</td>
						<cfelse>
							<td>
								<label> <input type="radio" name="rgSort" value="Date"> Date</label>
							</td>
						</cfif> --->
					</tr>
<!---  					<cfif from.reporttype eq "1D"> --->
<!--- 					<tr>
	 					<cfif url.type eq "1D">
							<td>
								<label><input type="radio" name="rgSort" value="GRN No"> GRN No.</label>
							</td>
						</cfif>
					</tr> --->
				</table>
			</td>
		</tr>

		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>
				<div align="right">
					<input type="Submit" name="Submit" value="Submit">
				</div>
			</td>
    	</tr>
	</table>
</cfform>
</body>
</html>