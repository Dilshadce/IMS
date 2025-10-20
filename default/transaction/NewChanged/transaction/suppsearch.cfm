<html>
<head>
<title>Create Or Edit Or View</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>

<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevTwenty" default="0">
<cfparam name="nextTwenty" default="0">
<cfset typeNo="supplierno">
<cfset link = "suppsearch.cfm">

<h1>Supplier Selection Page</h1>

<cfoutput>
	<cfif url.ttype eq "Create">
		<form action="suppsearch.cfm?ttype=#url.ttype#" method="post">
	<cfelse>
		<form action="suppsearch.cfm?ttype=#url.ttype#&refno=#url.refno#" method="post">
	</cfif>
</cfoutput>

<cfoutput>
	<h1>Search By :
		<select name="searchType">
			<option value="name">Supplier Name</option>
			<option value="#typeNo#">Supplier ID</option>
			<option value="phone">Supplier Tel</option>
		</select>
      	Search for Supplier :
      	<input type="text" name="searchStr" value="">
	</h1>
	</form>
</cfoutput>

<cfquery datasource='#dts#' name="type">
	select * from #target_apvend# order by Date desc, Name
</cfquery>

<cfif isdefined("form.searchStr")>
	<cfquery dbtype="query" name="exactResult">
		select * from TYPE where #form.searchType# = '#form.searchStr#'
	</cfquery>
	
	<cfquery dbtype="query" name="similarResult">
		select * from TYPE where #form.searchType# LIKE '%#form.searchStr#%'
	</cfquery>
	
	<h2>Exact Result</h2>
	
	<cfif exactResult.recordCount neq 0>
		<table width="600" align="center" class="data">
      		<tr>
				<th>Name</th>
 			   	<th>Address</th>
  			  	<th>Telephone</th>
  			  	<th>Attention</th>
  			  	<th>Action</th>
			</tr>
			
			<input type="hidden" name="ttype" value="#url.ttype#">
			
			<cfoutput query="exactresult">
				<tr>
			 		<td nowrap>#exactresult.name#</td>
   			   		<td nowrap>#exactResult.Add1#<br>#exactResult.Add2#<br>#exactResult.Add3#<br>#exactResult.Add4#</td>
   			   		<td nowrap>(1) #exactResult.phone#<br>(2) #exactResult.phonea#</td>
    			  	<td nowrap>#exactResult.attn#<br/><font style="background-color:FFFFFF">#exactResult.e_mail#</font></td>
    			  	<td nowrap>
				  	<cfif url.ttype eq "Create">
						<a href="otransaction_po2.cfm?ttype=#url.ttype#&supp1=#URLEncodedFormat(exactResult.supplierno)#">Select</a>
					<cfelse>
						<a href="otransaction_po2.cfm?ttype=#url.ttype#&refno=#url.refno#&supp1=#URLEncodedFormat(exactResult.supplierno)#">Select</a>
				  	</cfif>
					</td>
				</tr>
			</cfoutput>
		</table>
	<cfelse>
		<h3>No Exact Records were found.</h3>
	</cfif>

	<h2>Similar Result</h2>
	<cfif similarResult.recordCount neq 0>
		<cfform action="suppsearch.cfm" method="post">
			<input type="hidden" name="ttype" value="#url.ttype#">
			<div align="right">Page <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">
			
			<cfset noOfPage=round(Type.recordcount/20)>
			
			<cfif type.recordcount mod 20 LT 10 and type.recordcount mod 20 neq 0>
				<cfset noOfPage=noOfPage+1>
			</cfif>

			<cfif isdefined("url.start")>
				<cfset start=url.start>
			</cfif>

			<cfif isdefined("form.skeypage")>
				<cfset start = form.skeypage * 20 + 1 - 20>
				
				<cfif form.skeypage eq "1">
					<cfset start = "1">
				</cfif>
			</cfif>
			
			<cfset prevTwenty=start -20>
			<cfset nextTwenty=start +20>
			<cfset page=round(nextTwenty/20)>
			
			<cfif start neq 1>
				<cfoutput>|| <a href="suppsearch.cfm?start=#prevTwenty#">Previous</a> ||</cfoutput>
			</cfif>
			
			<cfif page neq noOfPage>
				<cfoutput> <a href="suppsearch.cfm?start=#evaluate(nextTwenty)#">Next</a> ||</cfoutput>
			</cfif>
			
			<cfoutput>Page #page# Of #noOfPage#</cfoutput>
			</div>
			
			<table width="600" align="center" class="data">
        		<tr>
					<th>Name</th>
 			  		<th>Address</th>
					<th>Telephone</th>
					<th>Attention</th>
					<th>Action</th>
				</tr>
  				
				<cfoutput query="similarResult" startrow="#start#" maxrows="20">
   			 		<tr>
   			   			<td nowrap>#similarResult.name#</td>
						<td nowrap>#similarResult.Add1#<br>#similarResult.Add2#<br>#similarResult.Add3#<br>#similarResult.Add4#</td>
   			   			<td nowrap>(1) #similarResult.phone#<br>(2) #similarResult.phonea#</td>
    		   			<td nowrap>#similarResult.attn#<br/><font style="background-color:FFFFFF">#similarResult.e_mail#</font></td>
						<td nowrap>
							<cfif url.ttype eq "Create">
								<a href="otransaction_po2.cfm?ttype=#url.ttype#&supp1=#URLEncodedFormat(similarResult.supplierno)#">Select</a>
				  			<cfelse>
								<a href="otransaction_po2.cfm?ttype=#url.ttype#&refno=#url.refno#&supp1=#URLEncodedFormat(similarResult.supplierno)#">Select</a>
				  			</cfif>
						</td>
  			  		</tr>
 			 	</cfoutput>
			</table>
			
			<div align="right">
			
			<cfif start neq 1>
        		<cfoutput><a href="suppsearch.cfm?start=#prevTwenty#">Previous</a> || </cfoutput>
      		</cfif>
      		
			<cfif page neq noOfPage>
        		<cfoutput> <a href="suppsearch.cfm?start=#evaluate(nextTwenty)#">Next</a> || </cfoutput>
      		</cfif>
      		
			<cfoutput>Page #page# Of #noOfPage#</cfoutput> </div>
		</cfform>
	<cfelse>
		<h3>No Similar Records were found.</h3>
	</cfif>
</cfif>

<cfparam name="i" default="1" type="numeric">

<hr>
<fieldset>
<legend style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;font-style:italic;line-height:normal;font-weight:bold;text-transform:capitalize;color:#0066FF;">
	10 Newest Customer:
</legend>
<br>

<cfif type.recordCount neq 0>
	<table align="center" class="data" width="600px">
		<tr>
			<th>No.</th>
			<th>Name</th>
			<th>Address</th>
			<th>Telephone</th>
			<th>Attention</th>
			<th>Action</th>
		</tr>
		
		<cfoutput query="type" maxrows="10">
			<tr>
				<td nowrap>#i#</td>
				<td nowrap>#type.Name#</td>
				<td nowrap>#type.Add1#<br>#type.Add2#<br>#type.Add3#<br>#type.Add4#</td>
				<td nowrap>(1) #type.phone#<br>(2) #type.phonea#</td>
				<td nowrap>#type.attn#<br/><font style="background-color:FFFFFF">#type.e_mail#</font></td>
				<td nowrap>
					<cfif url.ttype eq "Create">
						<a href="otransaction_po2.cfm?ttype=#url.ttype#&supp1=#URLEncodedFormat(type.supplierno)#">Select</a>
					<cfelse>
						<a href="otransaction_po2.cfm?ttype=#url.ttype#&refno=#url.refno#&supp1=#URLEncodedFormat(type.supplierno)#">Select</a>
				  	</cfif>
				</td>
			</tr>			
			<cfset i = incrementvalue(i)>
		</cfoutput>
	</table>
<cfelse>
	<h3>No Records were found.</h3>
</cfif>

<br>
</fieldset>

</body>
</html>