<html>
<head>
<title>View Sales Order Listing Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="custfrom" default="">
<cfparam name="custto" default="">
<cfparam name="submit" default="">

<cfoutput>
<cfif custfrom neq "">
	<form action= "custsearch.cfm?type=#type#&get=from<cfif form.reporttype neq "">&rtype=#reporttype#</cfif><cfif form.getto neq "">&getto=#getto#</cfif>" method="post" name="form123">
	</form>
	<script>
		form123.submit();
	</script>
	<cfabort>
<cfelseif custto neq "">
	<form action= "custsearch.cfm?type=#type#&get=to<cfif form.reporttype neq "">&rtype=#reporttype#</cfif><cfif form.getfrom neq "">&getfrom=#getfrom#</cfif>" method="post" name="form123">
	</form>
	<script>
		form123.submit();
	</script>
	<cfabort>
<cfelseif submit eq "submit">
	<form action= "listing_report_b.cfm?trantype=#trantype#&trancode=#trancode#" method="post" name="form123" target="_blank">
			<input type="hidden" name="reporttype" value="#reporttype#">
			<input type="hidden" name="getfrom" value="#getfrom#">
			<input type="hidden" name="getto" value="#getto#">
			<input type="hidden" name="billfrom" value="#billfrom#">
			<input type="hidden" name="billto" value="#billto#">
			<input type="hidden" name="agentfrom" value="#agentfrom#">
			<input type="hidden" name="agentto" value="#agentto#">
			<input type="hidden" name="periodfrom" value="#periodfrom#">
			<input type="hidden" name="periodto" value="#periodto#">
			<input type="hidden" name="datefrom" value="#datefrom#">
			<input type="hidden" name="dateto" value="#dateto#">
			<input type="hidden" name="periodto" value="#periodto#">
			<input type="hidden" name="rgsort" value="#rgsort#">
	</form>
	<script>
		form123.submit();
	</script>

</cfif>
</cfoutput>
<cfif type eq "1">
  <cfset trantype = "Sales Order">
  <cfset trancode = "SO">
</cfif>

<cfif type eq "2">
  <cfset trantype = "Vendor Purchases">
  <cfset trancode = "PO">
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
<cfquery name="getbill" datasource="#dts#">
  	select refno from artran where type = '#trancode#' and (void = '' or void is null) and fperiod <> '99' order by refno
</cfquery>

<body>
<cfoutput>
<form action= "listing_report.cfm?trantype=#trantype#&trancode=#trancode#" method="post" name="form123">
  <h2>Print #trantype# Listing Report</h2></cfoutput>

  <table border="0" align="center" width="80%" class="data" cellspacing="0">
    <cfoutput><input type="hidden" name="type" value="#type#">
			  <input type="hidden" name="title" value="#title#"></cfoutput>
    <tr>
      <th width="20%"><cfoutput>Report Type</cfoutput></th>
      <td width="8%">&nbsp;</td>
      <td width="60%">
	  <cfif isdefined("rtype")>
	  	<cfset xrtype = #rtype#>
	  <cfelse>
	  	<cfset xrtype = "">
	  </cfif>
        <select name="reporttype">
          <cfoutput><option value="">Choose a report type</option></cfoutput>
          <cfoutput><option value="1"<cfif xrtype eq 1>selected</cfif>>#trantype# - Detail</option></cfoutput>
          <cfoutput><option value="2"<cfif xrtype eq 2>selected</cfif>>#trantype# - Summary</option></cfoutput>
          <cfoutput><option value="3"<cfif xrtype eq 3>selected</cfif>>Outstanding #trantype# - Detail</option></cfoutput>
          <cfoutput><option value="4"<cfif xrtype eq 4>selected</cfif>>Outstanding #trantype# - Summary</option></cfoutput>
          <cfoutput><option value="5"<cfif xrtype eq 5>selected</cfif>>Completed #trantype#</option></cfoutput>
        </select>
      </td>
    </tr>

    <tr>
      <td colspan="4"><hr></td>
    </tr>

    <tr>
      <th width="20%"><cfoutput>#title#</cfoutput></th>
      <td width="8%"> <div align="center">From</div></td>
      <td width="60%" nowrap>
        <cfif isdefined("get") and get eq "from">
	  		<cfset xcustfrom = custno>
		<cfelse>
			<cfset xcustfrom = "">
	 	</cfif>
		<cfif isdefined("url.getfrom")>
	  	<cfset xcustfrom = #url.getfrom#>
	  </cfif>
        <select name="getfrom">
          <cfoutput> <option value="">Choose a #title#</option></cfoutput>
          <cfloop query="getsupp">
            <cfoutput><option value="#customerno#"<cfif customerno eq xcustfrom>selected</cfif>>#customerno# - #name#</option></cfoutput>
          </cfloop>
        </select>
		<cfoutput>
		<input type="submit" name="custfrom" value="Search">
          <!--- <a href="custsearch.cfm?type=#type#&title=#title#&get=from">Search</a> --->
        </cfoutput> </td>
    </tr>

    <tr>
      <th width="20%"><cfoutput>#title#</cfoutput></th>
      <td width="8%"> <div align="center">To</div></td>
      <td width="60%" nowrap>
        <cfif isdefined("get") and get eq "to">
	  	<cfset xcustto = custno>
	  <cfelse>
	  	<cfset xcustto = "">
	  </cfif>
	  <cfif isdefined("url.getto")>
	  	<cfset xcustto = #url.getto#>
	  </cfif>
        <select name="getto">
          <cfoutput><option value="">Choose a #title#</option></cfoutput>
          <cfloop query="getsupp">
            <cfoutput><option value="#customerno#"<cfif customerno eq xcustto>selected</cfif>>#customerno# - #name#</option></cfoutput>
          </cfloop>
        </select>
		<cfoutput><input type="submit" name="custto" value="Search">
          <!--- <a href="custsearch.cfm?type=#type#&title=#title#&get=to">Search</a> --->
        </cfoutput> </td>
    </tr>
	<tr>
      <td colspan="4"><hr></td>
    </tr>

    <tr>
      <th width="20%">Refno</th>
      <td width="8%"> <div align="center">From</div></td>
      <td width="60%">
        <select name="billfrom">
          <option value="">Choose a Refno</option>
          <cfloop query="getbill">
            <cfoutput><option value="#refno#">#refno#</option></cfoutput>
          </cfloop>
        </select>
      </td>
    </tr>

    <tr>
      <th width="20%">Refno</th>
      <td width="8%"> <div align="center">To</div></td>
      <td width="60%">
        <select name="billto">
          <option value="">Choose a Refno</option>
          <cfloop query="getbill">
            <cfoutput><option value="#refno#">#refno#</option></cfoutput>
	      </cfloop>
        </select>
      </td>
    </tr>

    <tr>
      <td colspan="4"><hr></td>
    </tr>

    <tr>
      <th width="20%">Agent</th>
      <td width="8%"> <div align="center">From</div></td>
      <td width="60%">
        <select name="agentfrom">
          <option value="">Choose a Agent</option>
          <cfloop query="getagent">
            <cfoutput><option value="#agent#">#agent#</option></cfoutput>
          </cfloop>
        </select>
      </td>
    </tr>

    <tr>
      <th width="20%">Agent</th>
      <td width="8%"> <div align="center">To</div></td>
      <td width="60%">
        <select name="agentto">
          <option value="">Choose a Agent</option>
          <cfloop query="getagent">
            <cfoutput><option value="#agent#">#agent#</option></cfoutput>
	      </cfloop>
        </select>
      </td>
    </tr>

    <tr>
      <td colspan="4"><hr></td>
    </tr>

    <tr>
      <th width="20%">Period</th>
      <td width="8%"> <div align="center">From</div></td>
      <td width="60%">
        <select name="periodfrom">
	      <option value="">Choose a period</option>
          <option value="01"selected>1</option>
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
      <th width="20%">Period</th>
      <td width="8%"> <div align="center">To</div></td>
      <td width="60%">
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
	      <option value="12"selected>12</option>
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
      <th width="20%">Date</th>
      <td width="8%"> <div align="center">From</div></td>
      <td width="60%"><input type="text" name="datefrom" maxlength="10" validate="eurodate" size="10"> (DD/MM/YYYY)</td>
    </tr>

    <tr>
      <th width="20%">Date</th>
      <td width="8%"> <div align="center">To</div></td>
      <td width="60%"><input type="text" name="dateto" maxlength="10" validate="eurodate" size="10"> (DD/MM/YYYY)</td>
    </tr>

    <tr>
      <td colspan="4"><hr></td>
    </tr>

    <tr>
      <th width="20%">Sort by</th>
      <td width="8%">&nbsp;</td>
      <td width="60%">
        <cfswitch expression = "#trancode#">
          <cfcase value="SO">

          <table width="365">
            <tr>
	            <td width="357"><label><input name="rgSort" type="radio" value="Contract No" checked>Contract No.</label></td>
              </tr>
              <tr>
                <td><label><input type="radio" name="rgSort" value="Client Name">Client Name</label></td>
              </tr>
              <tr>
	            <td><label><input type="radio" name="rgSort" value="Client Code">Client Code</label></td>
              </tr>
              <tr>
	            <td><label><input type="radio" name="rgSort" value="Month"> Month</label></td>
              </tr>
            </table>
 		  </cfcase>

          <cfcase value="PO">

          <table width="366">
            <tr>
	            <td width="343"><label><input name="rgSort" type="radio" value="Purchase Order No" checked>Purchase Order No.</label></td>
              </tr>
              <tr>
	            <td><label><input type="radio" name="rgSort" value="Supplier Name">Supplier Name</label></td>
              </tr>
              <tr>
	            <td><label><input type="radio" name="rgSort" value="Supplier Code">Supplier Code</label></td>
              </tr>
              <tr>
	            <td><label><input type="radio" name="rgSort" value="Month">Month</label></td>
              </tr>
<!---               <tr>
	            <td><label>
                <input type="radio" name="rgSort" value="GRN No">GRN No. (Only for Completed)</label></td>
              </tr>
              <tr>
	            <td><label><input type="radio" name="rgSort" value="Contract No">Contract No. (Only for Outstanding)</label></td>
              </tr> --->
            </table>
		  </cfcase>
		</cfswitch>
      </td>
    </tr>

	<tr>
	  <td width="20%">&nbsp;</td>
	  <td width="8%">&nbsp;</td>
	  <td width="60%">
		<div align="right">
		  <input type="Submit" name="Submit" value="Submit">
		</div>
	  </td>
    </tr>
  </table>
</form>
</body>
</html>