<html>
<head>
<title>Create Or Edit Or View</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevTwenty" default="0">
<cfparam name="nextTwenty" default="0">
<cfset typeNo="custno">
<cfset link = "custsearch.cfm">

<body>

<h1>Customer Selection Page</h1>
<cfoutput>
	<cfif url.ttype eq "Create">
		<form action="custsearch.cfm?stype=#url.stype#&ttype=#url.ttype#" method="post">
	<cfelse>
		<form action="custsearch.cfm?stype=#url.stype#&ttype=#url.ttype#&refno=#url.refno#" method="post">
	</cfif>
	
	<h1>Search By :
	<select name="searchType">
		<option value="name">Customer Name</option>
		<option value="#typeNo#">Customer ID</option>
		<option value="phone">Customer Tel</option>
	</select>
	Search for Customer : <input type="text" name="searchStr" value=""> </h1>
	</form>
</cfoutput>

<cfquery datasource='#dts#' name="type">
	select * from #target_arcust# order by Date desc, Name
</cfquery>

<cfif isdefined("form.searchStr")>
	<cfquery dbtype="query" name="exactResult">
		Select * from TYPE where #form.searchType# = '#form.searchStr#'
	</cfquery>

	<cfquery dbtype="query" name="similarResult">
		Select * from TYPE where #form.searchType# LIKE '%#form.searchStr#%'
	</cfquery>
	
	<h2>Exact Result</h2>
	<cfif exactResult.recordCount neq 0>
		<table width="600" align="center" class="data">
			<tr>
				<th>Name</th>
 				<th>Address</th>
  				<th>Telephone</th>
  				<th>Attention</th>
				<th>Status</th>
  				<th>Action</th>
			</tr>
  			<input type="hidden" name="ttype" value="#url.ttype#">
			<input type="hidden" name="stype" value="#url.stype#">
			
			<cfoutput query="exactresult">
				<tr>
					<td nowrap>#exactresult.name#</td>
   			   		<td nowrap>#exactResult.Add1#<br>#exactResult.Add2#<br>#exactResult.Add3#<br>#exactResult.Add4#</td>
   			   		<td nowrap>(1) #exactResult.phone#<br>(2) #exactResult.phonea#</td>
    				<td nowrap>#exactResult.attn#<br/><font style="background-color:FFFFFF">#exactResult.e_mail#</font></td>
					<td nowrap>#exactResult.status#</td>
    				<td nowrap>
						<cfif exactResult.status neq "B">
							<cfif url.ttype eq "Create">
								<cfif url.stype eq "Invoice">
									<a href="invoice1.cfm?stype=Invoice&ttype=#url.ttype#&custno=#URLEncodedFormat(exactResult.custno)#">Select</a>
								<cfelseif url.stype eq "DO">
									<a href="deliveryorder2.cfm?stype=DO&ttype=#url.ttype#&custno=#URLEncodedFormat(exactResult.custno)#">Select</a>
								<cfelseif url.stype eq "PR">
									<a href="preturn2.cfm?stype=PR&ttype=#url.ttype#&custno=#URLEncodedFormat(exactResult.custno)#">Select</a>
								<cfelseif url.stype eq "RC">
									<a href="purchase2.cfm?stype=RC&ttype=#url.ttype#&custno=#URLEncodedFormat(exactResult.custno)#">Select</a>
								<cfelseif url.stype eq "CN">
									<a href="creditnote2.cfm?stype=CN&ttype=#url.ttype#&custno=#URLEncodedFormat(exactResult.custno)#">Select</a>
								<cfelseif url.stype eq "DN">
									<a href="debitnote2.cfm?stype=DN&ttype=#url.ttype#&custno=#URLEncodedFormat(exactResult.custno)#">Select</a>
								<cfelseif url.stype eq "SO">
									<a href="otransaction_so2.cfm?stype=so&ttype=#url.ttype#&custno=#URLEncodedFormat(exactResult.custno)#">Select</a>
								<cfelseif url.stype eq "QUO">
									<a href="otransaction_quo2.cfm?stype=quo&ttype=#url.ttype#&custno=#URLEncodedFormat(exactResult.custno)#">Select</a>
								</cfif>
					  		<cfelse>
								<cfif url.stype eq "Invoice">
									<a href="invoice1.cfm?stype=Invoice&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(exactResult.custno)#">Select</a>
								<cfelseif url.stype eq "DO">
									<a href="deliveryorder2.cfm?stype=DO&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(exactResult.custno)#">Select</a>
								<cfelseif url.stype eq "PR">
									<a href="preturn2.cfm?stype=PR&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(exactResult.custno)#">Select</a>
								<cfelseif url.stype eq "RC">
									<a href="purchase2.cfm?stype=RC&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(exactResult.custno)#">Select</a>
								<cfelseif url.stype eq "CN">
									<a href="creditnote2.cfm?stype=CN&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(exactResult.custno)#">Select</a>
								<cfelseif url.stype eq "DN">
									<a href="debitnote2.cfm?stype=DN&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(exactResult.custno)#">Select</a>
								<cfelseif url.stype eq "SO">
									<a href="otransaction_so2.cfm?stype=so&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(exactResult.custno)#">Select</a>
								<cfelseif url.stype eq "QUO">
									<a href="otransaction_quo2.cfm?stype=quo&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(exactResult.custno)#">Select</a>
								</cfif>
					  		</cfif>
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
		<cfform action="custsearch.cfm" method="post">
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
				<cfoutput>|| <a href="custsearch.cfm?start=#prevTwenty#">Previous</a> ||</cfoutput>
			</cfif>
			
			<cfif page neq noOfPage>
				<cfoutput> <a href="custsearch.cfm?start=#evaluate(nextTwenty)#">Next</a> ||</cfoutput>
			</cfif>
			
			<cfoutput>Page #page# Of #noOfPage#</cfoutput>
			</div>
			
			<table width="600" align="center" class="data">
				<tr>
					<th>Name</th>
					<th>Address</th>
					<th>Telephone</th>
					<th>Attention</th>
					<th>Status</th>
					<th>Action</th>
				</tr>
				
				<cfoutput query="similarResult" startrow="#start#" maxrows="20">
					<tr>
						<td nowrap>#similarResult.name#</td>
						<td nowrap>#similarResult.Add1#<br>#similarResult.Add2#<br>#similarResult.Add3#<br>#similarResult.Add4#</td>
						<td nowrap>(1) #similarResult.phone#<br>(2) #similarResult.phonea#</td>
						<td nowrap>#similarResult.attn#<br/><font style="background-color:FFFFFF">#similarResult.e_mail#</font></td>
						<td nowrap>#similarResult.status#</td>
						<td nowrap>
							<cfif similarResult.status neq "B">
								<cfif url.ttype eq "Create">
									<cfif url.stype eq "Invoice">
										<a href="invoice1.cfm?stype=Invoice&ttype=#url.ttype#&custno=#URLEncodedFormat(similarResult.custno)#">Select</a>
									<cfelseif url.stype eq "DO">
										<a href="deliveryorder2.cfm?stype=DO&ttype=#url.ttype#&custno=#URLEncodedFormat(similarResult.custno)#">Select</a>
									<cfelseif url.stype eq "PR">
										<a href="preturn2.cfm?stype=PR&ttype=#url.ttype#&custno=#URLEncodedFormat(similarResult.custno)#">Select</a>
									<cfelseif url.stype eq "RC">
										<a href="purchase2.cfm?stype=RC&ttype=#url.ttype#&custno=#URLEncodedFormat(similarResult.custno)#">Select</a>
									<cfelseif url.stype eq "CN">
										<a href="creditnote2.cfm?stype=CN&ttype=#url.ttype#&custno=#URLEncodedFormat(similarResult.custno)#">Select</a>
									<cfelseif url.stype eq "DN">
										<a href="debitnote2.cfm?stype=DN&ttype=#url.ttype#&custno=#URLEncodedFormat(similarResult.custno)#">Select</a>
									<cfelseif url.stype eq "SO">
										<a href="otransaction_so2.cfm?stype=so&ttype=#url.ttype#&custno=#URLEncodedFormat(similarResult.custno)#">Select</a>
									<cfelseif url.stype eq "QUO">
										<a href="otransaction_quo2.cfm?stype=quo&ttype=#url.ttype#&custno=#URLEncodedFormat(similarResult.custno)#">Select</a>
									</cfif>
								<cfelse>
									<cfif url.stype eq "Invoice">
										<a href="invoice1.cfm?stype=Invoice&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(similarResult.custno)#">Select</a>
									<cfelseif url.stype eq "DO">
										<a href="deliveryorder2.cfm?stype=DO&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(similarResult.custno)#">Select</a>
									<cfelseif url.stype eq "PR">
										<a href="preturn2.cfm?stype=PR&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(similarResult.custno)#">Select</a>
									<cfelseif url.stype eq "RC">
										<a href="purchase2.cfm?stype=RC&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(similarResult.custno)#">Select</a>
									<cfelseif url.stype eq "CN">
										<a href="creditnote2.cfm?stype=CN&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(similarResult.custno)#">Select</a>
									<cfelseif url.stype eq "DN">
										<a href="debitnote2.cfm?stype=DN&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(similarResult.custno)#">Select</a>
									<cfelseif url.stype eq "SO">
										<a href="otransaction_so2.cfm?stype=so&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(similarResult.custno)#">Select</a>
									<cfelseif url.stype eq "QUO">
										<a href="otransaction_quo2.cfm?stype=quo&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(similarResult.custno)#">Select</a>
									</cfif>
								</cfif>
							</cfif>
						</td>
					</tr>
				</cfoutput>
			</table>
			
			<div align="right">
				<cfif start neq 1>
					<cfoutput><a href="custsearch.cfm?start=#prevTwenty#">Previous</a>||</cfoutput>
				</cfif>
				
				<cfif page neq noOfPage>
					<cfoutput> <a href="custsearch.cfm?start=#evaluate(nextTwenty)#">Next</a>||</cfoutput>
				 </cfif>
				
				<cfoutput>Page #page# Of #noOfPage#</cfoutput>
			</div>
		</cfform>
	<cfelse>
		<h3>No Similar Records were found.</h3>
	</cfif>
</cfif>

<cfparam name="i" default="1" type="numeric">
<hr>

<fieldset>
<legend style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;font-style:italic;line-height:normal;font-weight:bold;text-transform:capitalize;color:##0066FF;">
	<cfoutput>10 Newest Customer:</cfoutput>
</legend>
<br>

<cfif type.recordCount neq 0>
	<table align="center" class="data" width="600px">
		<tr>
			<th width>No.</th>
			<th width>Name</th>
			<th width>Address</th>
			<th width>Telephone</th>
			<th width>Attention</th>
			<th>Status</th>
			<th width>Action</th>
		</tr>
		<cfoutput query="type" maxrows="10">
			<tr>
				<td nowrap>#i#</td>
				<td nowrap>#type.Name#</td>
				<td nowrap>#type.Add1#<br>#type.Add2#<br>#type.Add3#<br>#type.Add4#</td>
				<td nowrap>(1) #type.phone#<br>(2) #type.phonea#</td>
				<td nowrap>#type.attn#<br/><font style="background-color:FFFFFF">#type.e_mail#</font></td>
				<td nowrap>#type.status#</td>
				<td nowrap><cfif type.status neq "B">
						<cfif url.ttype eq "Create">
							<cfif url.stype eq "Invoice">
								<a href="invoice1.cfm?stype=Invoice&ttype=#url.ttype#&custno=#URLEncodedFormat(type.custno)#">Select</a>
							<cfelseif url.stype eq "DO">
								<a href="deliveryorder2.cfm?stype=DO&ttype=#url.ttype#&custno=#URLEncodedFormat(type.custno)#">Select</a>
							<cfelseif url.stype eq "PR">
								<a href="preturn2.cfm?stype=PR&ttype=#url.ttype#&custno=#URLEncodedFormat(type.custno)#">Select</a>
							<cfelseif url.stype eq "RC">
								<a href="purchase2.cfm?stype=RC&ttype=#url.ttype#&custno=#URLEncodedFormat(type.custno)#">Select</a>
							<cfelseif url.stype eq "CN">
								<a href="creditnote2.cfm?stype=CN&ttype=#url.ttype#&custno=#URLEncodedFormat(type.custno)#">Select</a>
							<cfelseif url.stype eq "DN">
								<a href="debitnote2.cfm?stype=DN&ttype=#url.ttype#&custno=#URLEncodedFormat(type.custno)#">Select</a>
							<cfelseif url.stype eq "SO">
								<a href="otransaction_so2.cfm?stype=so&ttype=#url.ttype#&custno=#URLEncodedFormat(type.custno)#">Select</a>
							<cfelseif url.stype eq "QUO">
								<a href="otransaction_quo2.cfm?stype=quo&ttype=#url.ttype#&custno=#URLEncodedFormat(type.custno)#">Select</a>
							</cfif>
						<cfelse>
							<cfif url.stype eq "Invoice">
								<a href="invoice1.cfm?stype=Invoice&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(type.custno)#">Select</a>
							<cfelseif url.stype eq "DO">
								<a href="deliveryorder2.cfm?stype=DO&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(type.custno)#">Select</a>
							<cfelseif url.stype eq "PR">
								<a href="preturn2.cfm?stype=PR&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(type.custno)#">Select</a>
							<cfelseif url.stype eq "RC">
								<a href="purchase2.cfm?stype=RC&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(type.custno)#">Select</a>
							<cfelseif url.stype eq "CN">
								<a href="creditnote2.cfm?stype=CN&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(type.custno)#">Select</a>
							<cfelseif url.stype eq "DN">
								<a href="debitnote2.cfm?stype=DN&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(type.custno)#">Select</a>
							<cfelseif url.stype eq "SO">
								<a href="otransaction_so2.cfm?stype=so&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(type.custno)#">Select</a>
							<cfelseif url.stype eq "QUO">
								<a href="otransaction_quo2.cfm?stype=quo&ttype=#url.ttype#&refno=#url.refno#&custno=#URLEncodedFormat(type.custno)#">Select</a>
							</cfif>
						</cfif>
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