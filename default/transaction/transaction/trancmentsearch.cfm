<html>
<head>
	<title>Search Comment</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevTwenty" default="0">
<cfparam name="nextTwenty" default="0">

<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<body>
<h1>Comment Selection Page</h1>

<cfoutput>
	<cftry>
	<cfcatch type="any">
		<cfoutput>#cfcatch.Message#:::#cfcatch.Detail#</cfoutput><cfabort>
	</cfcatch>
	</cftry>
	<cfif type1 eq "Add">
		<form action="trancmentsearch.cfm?stype=#stype#" method="post">
	<cfelse>
		<form action="trancmentsearch.cfm?stype=#stype#" method="post">
	</cfif>

	<cfif isdefined("form.updunitcost")>
		<input type='hidden' name='updunitcost' value='#form.updunitcost#'>
	</cfif>

	<h1>Search By :
		<select name="searchType">
			<option value="code">Code</option>
			<option value="desp">Description</option>
		</select>
        Search for Comment :
		<input type="text" name="searchStr" value="">
		<cfif husergrpid eq "Muser">
			<input type="submit" name="submit" value="Search">
		</cfif>
	</h1>
	<cfif checkcustom.customcompany eq "Y">
		<cfset remark5=remark5>
		<cfset remark6=remark6>
	<cfelse>
		<cfset remark5="">
		<cfset remark6="">
	</cfif>
	<div align="right">
		<a href="transaction4.cfm?stype=#stype#&code=&adtcost1=#URLEncodedFormat(listfirst(adtcost1))#&adtcost2=#URLEncodedFormat(listfirst(adtcost2))#&
			agenno=#URLEncodedFormat(listfirst(agenno))#&balance=#URLEncodedFormat(listfirst(balance))#&batchqty=#URLEncodedFormat(listfirst(batchqty))#&
			brem3=#URLEncodedFormat(listfirst(brem3))#&brem4=#URLEncodedFormat(listfirst(brem4))#&comment=#URLEncodedFormat(comment)#&
			compareqty=#URLEncodedFormat(listfirst(compareqty))#&crequestdate=#URLEncodedFormat(listfirst(crequestdate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&
			custno=#URLEncodedFormat(listfirst(custno))#&defective=#URLEncodedFormat(listfirst(defective))#&desp=#URLEncodedFormat(desp)#&
			despa=#URLEncodedFormat(despa)#&dispec1=#URLEncodedFormat(listfirst(dispec1))#&dispec2=#URLEncodedFormat(listfirst(dispec2))#&
			dispec3=#URLEncodedFormat(listfirst(dispec3))#&dodate=#URLEncodedFormat(listfirst(dodate))#&enterbatch=#URLEncodedFormat(listfirst(enterbatch))#&
			enterbatch1=#URLEncodedFormat(listfirst(enterbatch1))#&expdate=#URLEncodedFormat(listfirst(expdate))#&gltradac=#URLEncodedFormat(listfirst(gltradac))#&
			hmode=#URLEncodedFormat(listfirst(hmode))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&itemcount=#URLEncodedFormat(listfirst(itemcount))#&
			itemno=#URLEncodedFormat(listfirst(itemno))#&items=#URLEncodedFormat(listfirst(items))#&location=#URLEncodedFormat(listfirst(location))#&
			mc1bil=#URLEncodedFormat(listfirst(mc1bil))#&mc2bil=#URLEncodedFormat(listfirst(mc2bil))#&mode=#URLEncodedFormat(listfirst(mode))#&
			ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&nexttranno=#URLEncodedFormat(listfirst(nexttranno))#&oldenterbatch=#URLEncodedFormat(listfirst(oldenterbatch))#&
			oldlocation=#URLEncodedFormat(listfirst(oldlocation))#&oldqty=#URLEncodedFormat(listfirst(oldqty))#&price=#URLEncodedFormat(listfirst(price))#&
			qty=#URLEncodedFormat(listfirst(qty))#&readperiod=#URLEncodedFormat(listfirst(readperiod))#&refno3=#URLEncodedFormat(listfirst(refno3))#&
			requestdate=#URLEncodedFormat(listfirst(requestdate))#&sercost=#URLEncodedFormat(listfirst(sercost))#&service=#URLEncodedFormat(listfirst(service))#&
			sodate=#URLEncodedFormat(listfirst(sodate))#&sv_part=#URLEncodedFormat(listfirst(sv_part))#&tran=#URLEncodedFormat(listfirst(tran))#&
			type1=#URLEncodedFormat(listfirst(type1))#&unit=#URLEncodedFormat(listfirst(unit))#&newtrancode=#newtrancode#&multilocation=#multilocation#&remark5=#remark5#&remark6=#remark6#">
			<h2>Exit</h2>
		</a>
	</div>
	
	<input type="hidden" name="adtcost1" value="#listfirst(adtcost1)#">			<input type="hidden" name="expdate" value="#listfirst(expdate)#">
	<input type="hidden" name="adtcost2" value="#listfirst(adtcost2)#">			<input type="hidden" name="gltradac" value="#listfirst(gltradac)#">
	<input type="hidden" name="agenno" value="#listfirst(agenno)#">				<input type="hidden" name="hmode" value="#listfirst(hmode)#">
	<input type="hidden" name="balance" value="#listfirst(balance)#">			<input type="hidden" name="invoicedate" value="#listfirst(invoicedate)#">
	<input type="hidden" name="batchqty" value="#listfirst(batchqty)#">			<input type="hidden" name="itemcount" value="#listfirst(itemcount)#">
	<input type="hidden" name="brem3" value="#listfirst(brem3)#">				<input type="hidden" name="itemno" value="#listfirst(itemno)#">
	<input type="hidden" name="brem4" value="#listfirst(brem4)#">				<input type="hidden" name="items" value="#listfirst(items)#">
	<input type="hidden" name="comment" value="#comment#">						<input type="hidden" name="location" value="#listfirst(location)#">
	<input type="hidden" name="compareqty" value="#listfirst(compareqty)#">		<input type="hidden" name="mc1bil" value="#listfirst(mc1bil)#">
	<input type="hidden" name="crequestdate" value="#listfirst(crequestdate)#">	<input type="hidden" name="mc2bil" value="#listfirst(mc2bil)#">
	<input type="hidden" name="currrate" value="#listfirst(currrate)#">			<input type="hidden" name="mode" value="#listfirst(mode)#">
	<input type="hidden" name="custno" value="#listfirst(custno)#">				<input type="hidden" name="ndatecreate" value="#listfirst(ndatecreate)#">
	<input type="hidden" name="defective" value="#listfirst(defective)#">		<input type="hidden" name="nexttranno" value="#listfirst(nexttranno)#">
	<input type="hidden" name="desp" value="#desp#">					<input type="hidden" name="oldenterbatch" value="#listfirst(oldenterbatch)#">
	<input type="hidden" name="despa" value="#despa#">				<input type="hidden" name="oldlocation" value="#listfirst(oldlocation)#">
	<input type="hidden" name="dispec1" value="#listfirst(dispec1)#">			<input type="hidden" name="oldqty" value="#listfirst(oldqty)#">
	<input type="hidden" name="dispec2" value="#listfirst(dispec2)#">			<input type="hidden" name="price" value="#listfirst(price)#">
	<input type="hidden" name="dispec3" value="#listfirst(dispec3)#">			<input type="hidden" name="qty" value="#listfirst(qty)#">
	<input type="hidden" name="dodate" value="#listfirst(dodate)#">				<input type="hidden" name="readperiod" value="#listfirst(readperiod)#">
	<input type="hidden" name="enterbatch" value="#listfirst(enterbatch)#">		<input type="hidden" name="refno3" value="#listfirst(refno3)#">
	<input type="hidden" name="enterbatch1" value="#listfirst(enterbatch1)#">	<input type="hidden" name="requestdate" value="#listfirst(requestdate)#">
	<input type="hidden" name="sercost" value="#listfirst(sercost)#">			<input type="hidden" name="service" value="#listfirst(service)#">
	<input type="hidden" name="sodate" value="#listfirst(sodate)#">				<input type="hidden" name="sv_part" value="#listfirst(sv_part)#">
	<input type="hidden" name="taxpec1" value="#listfirst(taxpec1)#">			<input type="hidden" name="tran" value="#listfirst(tran)#">
	<input type="hidden" name="type" value="#listfirst(type)#">					<input type="hidden" name="type1" value="#listfirst(type1)#">
	<input type="hidden" name="unit" value="#listfirst(unit)#">					<input type="hidden" name="newtrancode" value="#newtrancode#">
	<input type="hidden" name="multilocation" value="#listfirst(multilocation)#">	
	<input type="hidden" name="remark5" value="#listfirst(remark5)#">			<input type="hidden" name="remark6" value="#listfirst(remark6)#">	
</form>

	<cfquery datasource='#dts#' name="type3">
		Select code,desp as cdesp,details from comments order by code desc  <!--- order by code, desp, details --->
	</cfquery>

	<cfif isdefined("form.searchStr")>
		<cfquery dbtype="query" name="exactResult">
			Select * from type3 where #form.searchType# = '#form.searchStr#' order by #form.searchType#
		</cfquery>

		<cfquery dbtype="query" name="similarResult">
			Select * from type3 where #form.searchType# LIKE '#form.searchStr#' order by #form.searchType#
		</cfquery>

		<h2>Exact Result</h2>

		<cfif exactResult.recordCount neq 0>
			<table align="center" class="data" width="700px">
				<tr>
					<th>Code</th>
					<th>Description</th>
					<th>Details</th>
					<th>Action</th>
				</tr>

				<form name="select" action="transaction4.cfm" method="post">
					<cfloop query="exactResult">
						<cfset det = ToString(exactResult.details)>
						<tr>
							<td nowrap>#exactResult.code#</a></td>
							<td>#exactResult.cdesp#</td>
							<td>#det#</td>
							<td>
							<!--- <cfif type1 eq "Add">
								<a href="transaction4.cfm?tran=#tran#&hmode=#hmode#&type1=#type1#&nexttranno=#nexttranno#&code=#exactResult.code#&itemno=#urlencodedformat(itemno)#&service=#url.service#&ndatecreate=#ndatecreate#&currrate=#currrate#&refno3=#refno3#&agenno=#agenno#">Select</a>
							<cfelse>
								<a href="transaction4.cfm?tran=#tran#&hmode=#hmode#&type1=#type1#&nexttranno=#nexttranno#&code=#exactResult.code#&itemno=#urlencodedformat(itemno)#&service=#url.service#&ndatecreate=#ndatecreate#&currrate=#currrate#&refno3=#refno3#&agenno=#agenno#&itemcount=#itemcount#">Select</a>&nbsp;
							</cfif> --->
							<a href="transaction4.cfm?stype=#stype#&code=#URLEncodedFormat(exactResult.code)#&adtcost1=#URLEncodedFormat(listfirst(adtcost1))#&adtcost2=#URLEncodedFormat(listfirst(adtcost2))#&
							agenno=#URLEncodedFormat(listfirst(agenno))#&balance=#URLEncodedFormat(listfirst(balance))#&batchqty=#URLEncodedFormat(listfirst(batchqty))#&
							brem3=#URLEncodedFormat(listfirst(brem3))#&brem4=#URLEncodedFormat(listfirst(brem4))#&comment=#URLEncodedFormat(comment)#&
							compareqty=#URLEncodedFormat(listfirst(compareqty))#&crequestdate=#URLEncodedFormat(listfirst(crequestdate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&
							custno=#URLEncodedFormat(listfirst(custno))#&defective=#URLEncodedFormat(listfirst(defective))#&desp=#URLEncodedFormat(form.desp)#&
							despa=#URLEncodedFormat(form.despa)#&dispec1=#URLEncodedFormat(listfirst(dispec1))#&dispec2=#URLEncodedFormat(listfirst(dispec2))#&
							dispec3=#URLEncodedFormat(listfirst(dispec3))#&dodate=#URLEncodedFormat(listfirst(dodate))#&enterbatch=#URLEncodedFormat(listfirst(enterbatch))#&
							enterbatch1=#URLEncodedFormat(listfirst(enterbatch1))#&expdate=#URLEncodedFormat(listfirst(expdate))#&gltradac=#URLEncodedFormat(listfirst(gltradac))#&
							hmode=#URLEncodedFormat(listfirst(hmode))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&itemcount=#URLEncodedFormat(listfirst(itemcount))#&
							itemno=#URLEncodedFormat(listfirst(itemno))#&items=#URLEncodedFormat(listfirst(items))#&location=#URLEncodedFormat(listfirst(location))#&
							mc1bil=#URLEncodedFormat(listfirst(mc1bil))#&mc2bil=#URLEncodedFormat(listfirst(mc2bil))#&mode=#URLEncodedFormat(listfirst(mode))#&
							ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&nexttranno=#URLEncodedFormat(listfirst(nexttranno))#&oldenterbatch=#URLEncodedFormat(listfirst(oldenterbatch))#&
							oldlocation=#URLEncodedFormat(listfirst(oldlocation))#&oldqty=#URLEncodedFormat(listfirst(oldqty))#&price=#URLEncodedFormat(listfirst(price))#&
							qty=#URLEncodedFormat(listfirst(qty))#&readperiod=#URLEncodedFormat(listfirst(readperiod))#&refno3=#URLEncodedFormat(listfirst(refno3))#&
							requestdate=#URLEncodedFormat(listfirst(requestdate))#&sercost=#URLEncodedFormat(listfirst(sercost))#&service=#URLEncodedFormat(listfirst(service))#&
							sodate=#URLEncodedFormat(listfirst(sodate))#&sv_part=#URLEncodedFormat(listfirst(sv_part))#&tran=#URLEncodedFormat(listfirst(tran))#&
							type1=#URLEncodedFormat(listfirst(type1))#&unit=#URLEncodedFormat(listfirst(unit))#&newtrancode=#newtrancode#&multilocation=#multilocation#&remark5=#remark5#&remark6=#remark6#">Select</a>
							<!--- <input type="radio" name="code" style="background:inherit;border:inherit;border-style:none" value="#exactResult.code#" onClick="javascript:document.select.submit();">Select --->
							</td>
						</tr>
					</cfloop>
				</form>
			</table>
		<cfelse>
			<h3>No Exact Records were found.</h3>
		</cfif>

		<h2>Similar Result</h2>

		<cfif similarResult.recordCount neq 0>
			<table align="center" class="data" width="700px">
				<tr>
					<th>Code</th>
					<th>Description</th>
					<th>Details</th>
					<th>Action</th>
				</tr>

				<cfloop query="similarResult">
					<cfset det = ToString(similarResult.details)>
					<tr>
						<td nowrap>#similarResult.code#</a></td>
						<td>#similarResult.cdesp#</td>
						<td>#det#</td>
						<td>
							<!--- <cfif type1 eq "Add">
				  				<a href="transaction4.cfm?tran=#tran#&hmode=#hmode#&type1=#type1#&nexttranno=#nexttranno#&code=#similarResult.code#&itemno=#urlencodedformat(itemno)#&service=#url.service#&ndatecreate=#ndatecreate#&currrate=#currrate#&refno3=#refno3#&agenno=#agenno#">Select</a>
							<cfelse>
								<a href="transaction4.cfm?tran=#tran#&hmode=#hmode#&type1=#type1#&nexttranno=#nexttranno#&code=#similarResult.code#&itemno=#urlencodedformat(itemno)#&service=#url.service#&ndatecreate=#ndatecreate#&currrate=#currrate#&refno3=#refno3#&agenno=#agenno#&itemcount=#itemcount#">Select</a>&nbsp;
								<!--- <a href="transaction4.cfm?ap=ap&tran=#tran#&type1=#type1#&nexttranno=#nexttranno#&code=#similarResult.code#&itemno=#itemno#&service=#url.service#&ndatecreate=#ndatecreate#&currrate=#currrate#&refno3=#refno3#&agenno=#agenno#&itemcount=#itemcount#">Append</a> --->
				 			</cfif> --->
							<a href="transaction4.cfm?stype=#stype#&code=#URLEncodedFormat(similarResult.code)#&adtcost1=#URLEncodedFormat(listfirst(adtcost1))#&adtcost2=#URLEncodedFormat(listfirst(adtcost2))#&
							agenno=#URLEncodedFormat(listfirst(agenno))#&balance=#URLEncodedFormat(listfirst(balance))#&batchqty=#URLEncodedFormat(listfirst(batchqty))#&
							brem3=#URLEncodedFormat(listfirst(brem3))#&brem4=#URLEncodedFormat(listfirst(brem4))#&comment=#URLEncodedFormat(comment)#&
							compareqty=#URLEncodedFormat(listfirst(compareqty))#&crequestdate=#URLEncodedFormat(listfirst(crequestdate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&
							custno=#URLEncodedFormat(listfirst(custno))#&defective=#URLEncodedFormat(listfirst(defective))#&desp=#URLEncodedFormat(form.desp)#&
							despa=#URLEncodedFormat(form.despa)#&dispec1=#URLEncodedFormat(listfirst(dispec1))#&dispec2=#URLEncodedFormat(listfirst(dispec2))#&
							dispec3=#URLEncodedFormat(listfirst(dispec3))#&dodate=#URLEncodedFormat(listfirst(dodate))#&enterbatch=#URLEncodedFormat(listfirst(enterbatch))#&
							enterbatch1=#URLEncodedFormat(listfirst(enterbatch1))#&expdate=#URLEncodedFormat(listfirst(expdate))#&gltradac=#URLEncodedFormat(listfirst(gltradac))#&
							hmode=#URLEncodedFormat(listfirst(hmode))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&itemcount=#URLEncodedFormat(listfirst(itemcount))#&
							itemno=#URLEncodedFormat(listfirst(itemno))#&items=#URLEncodedFormat(listfirst(items))#&location=#URLEncodedFormat(listfirst(location))#&
							mc1bil=#URLEncodedFormat(listfirst(mc1bil))#&mc2bil=#URLEncodedFormat(listfirst(mc2bil))#&mode=#URLEncodedFormat(listfirst(mode))#&
							ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&nexttranno=#URLEncodedFormat(listfirst(nexttranno))#&oldenterbatch=#URLEncodedFormat(listfirst(oldenterbatch))#&
							oldlocation=#URLEncodedFormat(listfirst(oldlocation))#&oldqty=#URLEncodedFormat(listfirst(oldqty))#&price=#URLEncodedFormat(listfirst(price))#&
							qty=#URLEncodedFormat(listfirst(qty))#&readperiod=#URLEncodedFormat(listfirst(readperiod))#&refno3=#URLEncodedFormat(listfirst(refno3))#&
							requestdate=#URLEncodedFormat(listfirst(requestdate))#&sercost=#URLEncodedFormat(listfirst(sercost))#&service=#URLEncodedFormat(listfirst(service))#&
							sodate=#URLEncodedFormat(listfirst(sodate))#&sv_part=#URLEncodedFormat(listfirst(sv_part))#&tran=#URLEncodedFormat(listfirst(tran))#&
							type1=#URLEncodedFormat(listfirst(type1))#&unit=#URLEncodedFormat(listfirst(unit))#&newtrancode=#newtrancode#&multilocation=#multilocation#&remark5=#remark5#&remark6=#remark6#">Select</a>
						</td>
					</tr>
				</cfloop>
			</table>

		<cfelse>
			<h3>No Similar Records were found.</h3>
		</cfif>
	</cfif>
	</cfoutput>
	<hr><fieldset><legend style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;font-style:italic;line-height:normal;font-weight:bold;text-transform:capitalize;color:##0066FF;">20 Newest Comments:</legend></fieldset><br>

	<cfif type3.recordCount neq 0>
		<cfform action="trancmentsearch.cfm?stype=#stype#" method="post">
			<!--- <cfif type1 eq "Edit" or type1 eq "delete">
				<cfoutput><input type="hidden" name="itemcount" value="#itemcount#"></cfoutput>
			</cfif> --->

			<div align="right">Page <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">

			<cfset noOfPage = round(type3.recordcount/20)>

			<cfif type3.recordcount mod 20 LT 10 and type3.recordcount mod 20 neq 0>
				<cfset noOfPage = noOfPage + 1>
			</cfif>

			<cfif isdefined("start")>
				<cfset start = start>
			</cfif>

			<cfif isdefined("form.skeypage")>
				<cfset start = form.skeypage * 20 + 1 - 20>

				<cfif form.skeypage eq "1">
					<cfset start = "1">
				</cfif>
			</cfif>

			<cfparam name="i" default="#start#" type="numeric">
			<cfset prevTwenty = start -20>
			<cfset nextTwenty = start +20>
			<cfset page = round(nextTwenty/20)>

			<cfoutput>
			<cfif start neq 1>
			  	<cfif type1 eq "Add">
					||
							<a href="trancmentsearch.cfm?start=#prevTwenty#&stype=#stype#&adtcost1=#URLEncodedFormat(listfirst(adtcost1))#&adtcost2=#URLEncodedFormat(listfirst(adtcost2))#&
							agenno=#URLEncodedFormat(listfirst(agenno))#&balance=#URLEncodedFormat(listfirst(balance))#&batchqty=#URLEncodedFormat(listfirst(batchqty))#&
							brem3=#URLEncodedFormat(listfirst(brem3))#&brem4=#URLEncodedFormat(listfirst(brem4))#&comment=#URLEncodedFormat(comment)#&
							compareqty=#URLEncodedFormat(listfirst(compareqty))#&crequestdate=#URLEncodedFormat(listfirst(crequestdate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&
							custno=#URLEncodedFormat(listfirst(custno))#&defective=#URLEncodedFormat(listfirst(defective))#&desp=#URLEncodedFormat(form.desp)#&
							despa=#URLEncodedFormat(form.despa)#&dispec1=#URLEncodedFormat(listfirst(dispec1))#&dispec2=#URLEncodedFormat(listfirst(dispec2))#&
							dispec3=#URLEncodedFormat(listfirst(dispec3))#&dodate=#URLEncodedFormat(listfirst(dodate))#&enterbatch=#URLEncodedFormat(listfirst(enterbatch))#&
							enterbatch1=#URLEncodedFormat(listfirst(enterbatch1))#&expdate=#URLEncodedFormat(listfirst(expdate))#&gltradac=#URLEncodedFormat(listfirst(gltradac))#&
							hmode=#URLEncodedFormat(listfirst(hmode))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&itemcount=#URLEncodedFormat(listfirst(itemcount))#&
							itemno=#URLEncodedFormat(listfirst(itemno))#&items=#URLEncodedFormat(listfirst(items))#&location=#URLEncodedFormat(listfirst(location))#&
							mc1bil=#URLEncodedFormat(listfirst(mc1bil))#&mc2bil=#URLEncodedFormat(listfirst(mc2bil))#&mode=#URLEncodedFormat(listfirst(mode))#&
							ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&nexttranno=#URLEncodedFormat(listfirst(nexttranno))#&oldenterbatch=#URLEncodedFormat(listfirst(oldenterbatch))#&
							oldlocation=#URLEncodedFormat(listfirst(oldlocation))#&oldqty=#URLEncodedFormat(listfirst(oldqty))#&price=#URLEncodedFormat(listfirst(price))#&
							qty=#URLEncodedFormat(listfirst(qty))#&readperiod=#URLEncodedFormat(listfirst(readperiod))#&refno3=#URLEncodedFormat(listfirst(refno3))#&
							requestdate=#URLEncodedFormat(listfirst(requestdate))#&sercost=#URLEncodedFormat(listfirst(sercost))#&service=#URLEncodedFormat(listfirst(service))#&
							sodate=#URLEncodedFormat(listfirst(sodate))#&sv_part=#URLEncodedFormat(listfirst(sv_part))#&tran=#URLEncodedFormat(listfirst(tran))#&
							type1=#URLEncodedFormat(listfirst(type1))#&unit=#URLEncodedFormat(listfirst(unit))#&newtrancode=#newtrancode#&multilocation=#multilocation#&remark5=#remark5#&remark6=#remark6#&taxpec1=#taxpec1#&type=#type#">Previous</a>
							||

			  <cfelse>
					||
							<a href="trancmentsearch.cfm?start=#prevTwenty#&stype=#stype#&adtcost1=#URLEncodedFormat(listfirst(adtcost1))#&adtcost2=#URLEncodedFormat(listfirst(adtcost2))#&
							agenno=#URLEncodedFormat(listfirst(agenno))#&balance=#URLEncodedFormat(listfirst(balance))#&batchqty=#URLEncodedFormat(listfirst(batchqty))#&
							brem3=#URLEncodedFormat(listfirst(brem3))#&brem4=#URLEncodedFormat(listfirst(brem4))#&comment=#URLEncodedFormat(comment)#&
							compareqty=#URLEncodedFormat(listfirst(compareqty))#&crequestdate=#URLEncodedFormat(listfirst(crequestdate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&
							custno=#URLEncodedFormat(listfirst(custno))#&defective=#URLEncodedFormat(listfirst(defective))#&desp=#URLEncodedFormat(desp)#&
							despa=#URLEncodedFormat(despa)#&dispec1=#URLEncodedFormat(listfirst(dispec1))#&dispec2=#URLEncodedFormat(listfirst(dispec2))#&
							dispec3=#URLEncodedFormat(listfirst(dispec3))#&dodate=#URLEncodedFormat(listfirst(dodate))#&enterbatch=#URLEncodedFormat(listfirst(enterbatch))#&
							enterbatch1=#URLEncodedFormat(listfirst(enterbatch1))#&expdate=#URLEncodedFormat(listfirst(expdate))#&gltradac=#URLEncodedFormat(listfirst(gltradac))#&
							hmode=#URLEncodedFormat(listfirst(hmode))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&itemcount=#URLEncodedFormat(listfirst(itemcount))#&
							itemno=#URLEncodedFormat(listfirst(itemno))#&items=#URLEncodedFormat(listfirst(items))#&location=#URLEncodedFormat(listfirst(location))#&
							mc1bil=#URLEncodedFormat(listfirst(mc1bil))#&mc2bil=#URLEncodedFormat(listfirst(mc2bil))#&mode=#URLEncodedFormat(listfirst(mode))#&
							ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&nexttranno=#URLEncodedFormat(listfirst(nexttranno))#&oldenterbatch=#URLEncodedFormat(listfirst(oldenterbatch))#&
							oldlocation=#URLEncodedFormat(listfirst(oldlocation))#&oldqty=#URLEncodedFormat(listfirst(oldqty))#&price=#URLEncodedFormat(listfirst(price))#&
							qty=#URLEncodedFormat(listfirst(qty))#&readperiod=#URLEncodedFormat(listfirst(readperiod))#&refno3=#URLEncodedFormat(listfirst(refno3))#&
							requestdate=#URLEncodedFormat(listfirst(requestdate))#&sercost=#URLEncodedFormat(listfirst(sercost))#&service=#URLEncodedFormat(listfirst(service))#&
							sodate=#URLEncodedFormat(listfirst(sodate))#&sv_part=#URLEncodedFormat(listfirst(sv_part))#&tran=#URLEncodedFormat(listfirst(tran))#&
							type1=#URLEncodedFormat(listfirst(type1))#&unit=#URLEncodedFormat(listfirst(unit))#&newtrancode=#newtrancode#&multilocation=#multilocation#&remark5=#remark5#&remark6=#remark6#&taxpec1=#taxpec1#&type=#type#">Previous</a>
							||

			  	</cfif>
			</cfif>

		    <cfif page neq noOfPage>
				<cfif type1 eq "Add">

						<a href="trancmentsearch.cfm?start=#evaluate(nextTwenty)#&stype=#stype#&adtcost1=#URLEncodedFormat(listfirst(adtcost1))#&adtcost2=#URLEncodedFormat(listfirst(adtcost2))#&
						agenno=#URLEncodedFormat(listfirst(agenno))#&balance=#URLEncodedFormat(listfirst(balance))#&batchqty=#URLEncodedFormat(listfirst(batchqty))#&
						brem3=#URLEncodedFormat(listfirst(brem3))#&brem4=#URLEncodedFormat(listfirst(brem4))#&comment=#URLEncodedFormat(comment)#&
						compareqty=#URLEncodedFormat(listfirst(compareqty))#&crequestdate=#URLEncodedFormat(listfirst(crequestdate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&
						custno=#URLEncodedFormat(listfirst(custno))#&defective=#URLEncodedFormat(listfirst(defective))#&desp=#URLEncodedFormat(desp)#&
						despa=#URLEncodedFormat(despa)#&dispec1=#URLEncodedFormat(listfirst(dispec1))#&dispec2=#URLEncodedFormat(listfirst(dispec2))#&
						dispec3=#URLEncodedFormat(listfirst(dispec3))#&dodate=#URLEncodedFormat(listfirst(dodate))#&enterbatch=#URLEncodedFormat(listfirst(enterbatch))#&
						enterbatch1=#URLEncodedFormat(listfirst(enterbatch1))#&expdate=#URLEncodedFormat(listfirst(expdate))#&gltradac=#URLEncodedFormat(listfirst(gltradac))#&
						hmode=#URLEncodedFormat(listfirst(hmode))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&itemcount=#URLEncodedFormat(listfirst(itemcount))#&
						itemno=#URLEncodedFormat(listfirst(itemno))#&items=#URLEncodedFormat(listfirst(items))#&location=#URLEncodedFormat(listfirst(location))#&
						mc1bil=#URLEncodedFormat(listfirst(mc1bil))#&mc2bil=#URLEncodedFormat(listfirst(mc2bil))#&mode=#URLEncodedFormat(listfirst(mode))#&
						ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&nexttranno=#URLEncodedFormat(listfirst(nexttranno))#&oldenterbatch=#URLEncodedFormat(listfirst(oldenterbatch))#&
						oldlocation=#URLEncodedFormat(listfirst(oldlocation))#&oldqty=#URLEncodedFormat(listfirst(oldqty))#&price=#URLEncodedFormat(listfirst(price))#&
						qty=#URLEncodedFormat(listfirst(qty))#&readperiod=#URLEncodedFormat(listfirst(readperiod))#&refno3=#URLEncodedFormat(listfirst(refno3))#&
						requestdate=#URLEncodedFormat(listfirst(requestdate))#&sercost=#URLEncodedFormat(listfirst(sercost))#&service=#URLEncodedFormat(listfirst(service))#&
						sodate=#URLEncodedFormat(listfirst(sodate))#&sv_part=#URLEncodedFormat(listfirst(sv_part))#&tran=#URLEncodedFormat(listfirst(tran))#&
						type1=#URLEncodedFormat(listfirst(type1))#&unit=#URLEncodedFormat(listfirst(unit))#&newtrancode=#newtrancode#&multilocation=#multilocation#&remark5=#remark5#&remark6=#remark6#&taxpec1=#taxpec1#&type=#type#">Next</a> ||

			  	<cfelse>

						<a href="trancmentsearch.cfm?start=#evaluate(nextTwenty)#&stype=#stype#&adtcost1=#URLEncodedFormat(listfirst(adtcost1))#&adtcost2=#URLEncodedFormat(listfirst(adtcost2))#&
						agenno=#URLEncodedFormat(listfirst(agenno))#&balance=#URLEncodedFormat(listfirst(balance))#&batchqty=#URLEncodedFormat(listfirst(batchqty))#&
						brem3=#URLEncodedFormat(listfirst(brem3))#&brem4=#URLEncodedFormat(listfirst(brem4))#&comment=#URLEncodedFormat(comment)#&
						compareqty=#URLEncodedFormat(listfirst(compareqty))#&crequestdate=#URLEncodedFormat(listfirst(crequestdate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&
						custno=#URLEncodedFormat(listfirst(custno))#&defective=#URLEncodedFormat(listfirst(defective))#&desp=#URLEncodedFormat(desp)#&
						despa=#URLEncodedFormat(despa)#&dispec1=#URLEncodedFormat(listfirst(dispec1))#&dispec2=#URLEncodedFormat(listfirst(dispec2))#&
						dispec3=#URLEncodedFormat(listfirst(dispec3))#&dodate=#URLEncodedFormat(listfirst(dodate))#&enterbatch=#URLEncodedFormat(listfirst(enterbatch))#&
						enterbatch1=#URLEncodedFormat(listfirst(enterbatch1))#&expdate=#URLEncodedFormat(listfirst(expdate))#&gltradac=#URLEncodedFormat(listfirst(gltradac))#&
						hmode=#URLEncodedFormat(listfirst(hmode))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&itemcount=#URLEncodedFormat(listfirst(itemcount))#&
						itemno=#URLEncodedFormat(listfirst(itemno))#&items=#URLEncodedFormat(listfirst(items))#&location=#URLEncodedFormat(listfirst(location))#&
						mc1bil=#URLEncodedFormat(listfirst(mc1bil))#&mc2bil=#URLEncodedFormat(listfirst(mc2bil))#&mode=#URLEncodedFormat(listfirst(mode))#&
						ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&nexttranno=#URLEncodedFormat(listfirst(nexttranno))#&oldenterbatch=#URLEncodedFormat(listfirst(oldenterbatch))#&
						oldlocation=#URLEncodedFormat(listfirst(oldlocation))#&oldqty=#URLEncodedFormat(listfirst(oldqty))#&price=#URLEncodedFormat(listfirst(price))#&
						qty=#URLEncodedFormat(listfirst(qty))#&readperiod=#URLEncodedFormat(listfirst(readperiod))#&refno3=#URLEncodedFormat(listfirst(refno3))#&
						requestdate=#URLEncodedFormat(listfirst(requestdate))#&sercost=#URLEncodedFormat(listfirst(sercost))#&service=#URLEncodedFormat(listfirst(service))#&
						sodate=#URLEncodedFormat(listfirst(sodate))#&sv_part=#URLEncodedFormat(listfirst(sv_part))#&tran=#URLEncodedFormat(listfirst(tran))#&
						type1=#URLEncodedFormat(listfirst(type1))#&unit=#URLEncodedFormat(listfirst(unit))#&newtrancode=#newtrancode#&multilocation=#multilocation#&remark5=#remark5#&remark6=#remark6#&taxpec1=#taxpec1#&type=#type#">Next</a> ||

			  	</cfif>
			</cfif>
			</cfoutput>
			<cfoutput>
				<input type="hidden" name="adtcost1" value="#listfirst(adtcost1)#">			<input type="hidden" name="expdate" value="#listfirst(expdate)#">
				<input type="hidden" name="adtcost2" value="#listfirst(adtcost2)#">			<input type="hidden" name="gltradac" value="#listfirst(gltradac)#">
				<input type="hidden" name="agenno" value="#listfirst(agenno)#">				<input type="hidden" name="hmode" value="#listfirst(hmode)#">
				<input type="hidden" name="balance" value="#listfirst(balance)#">			<input type="hidden" name="invoicedate" value="#listfirst(invoicedate)#">
				<input type="hidden" name="batchqty" value="#listfirst(batchqty)#">			<input type="hidden" name="itemcount" value="#listfirst(itemcount)#">
				<input type="hidden" name="brem3" value="#listfirst(brem3)#">				<input type="hidden" name="itemno" value="#listfirst(itemno)#">
				<input type="hidden" name="brem4" value="#listfirst(brem4)#">				<input type="hidden" name="items" value="#listfirst(items)#">
				<input type="hidden" name="comment" value="#comment#">						<input type="hidden" name="location" value="#listfirst(location)#">
				<input type="hidden" name="compareqty" value="#listfirst(compareqty)#">		<input type="hidden" name="mc1bil" value="#listfirst(mc1bil)#">
				<input type="hidden" name="crequestdate" value="#listfirst(crequestdate)#">	<input type="hidden" name="mc2bil" value="#listfirst(mc2bil)#">
				<input type="hidden" name="currrate" value="#listfirst(currrate)#">			<input type="hidden" name="mode" value="#listfirst(mode)#">
				<input type="hidden" name="custno" value="#listfirst(custno)#">				<input type="hidden" name="ndatecreate" value="#listfirst(ndatecreate)#">
				<input type="hidden" name="defective" value="#listfirst(defective)#">		<input type="hidden" name="nexttranno" value="#listfirst(nexttranno)#">
				<input type="hidden" name="desp" value="#desp#">					<input type="hidden" name="oldenterbatch" value="#listfirst(oldenterbatch)#">
				<input type="hidden" name="despa" value="#despa#">				<input type="hidden" name="oldlocation" value="#listfirst(oldlocation)#">
				<input type="hidden" name="dispec1" value="#listfirst(dispec1)#">			<input type="hidden" name="oldqty" value="#listfirst(oldqty)#">
				<input type="hidden" name="dispec2" value="#listfirst(dispec2)#">			<input type="hidden" name="price" value="#listfirst(price)#">
				<input type="hidden" name="dispec3" value="#listfirst(dispec3)#">			<input type="hidden" name="qty" value="#listfirst(qty)#">
				<input type="hidden" name="dodate" value="#listfirst(dodate)#">				<input type="hidden" name="readperiod" value="#listfirst(readperiod)#">
				<input type="hidden" name="enterbatch" value="#listfirst(enterbatch)#">		<input type="hidden" name="refno3" value="#listfirst(refno3)#">
				<input type="hidden" name="enterbatch1" value="#listfirst(enterbatch1)#">	<input type="hidden" name="requestdate" value="#listfirst(requestdate)#">
				<input type="hidden" name="sercost" value="#listfirst(sercost)#">			<input type="hidden" name="service" value="#listfirst(service)#">
				<input type="hidden" name="sodate" value="#listfirst(sodate)#">				<input type="hidden" name="sv_part" value="#listfirst(sv_part)#">
				<input type="hidden" name="taxpec1" value="#listfirst(taxpec1)#">			<input type="hidden" name="tran" value="#listfirst(tran)#">
				<input type="hidden" name="type" value="#listfirst(type)#">					<input type="hidden" name="type1" value="#listfirst(type1)#">
				<input type="hidden" name="unit" value="#listfirst(unit)#">					<input type="hidden" name="newtrancode" value="#newtrancode#">
				<input type="hidden" name="multilocation" value="#listfirst(multilocation)#">	
				<input type="hidden" name="remark5" value="#listfirst(remark5)#">			<input type="hidden" name="remark6" value="#listfirst(remark6)#">
				Page #page# Of #noOfPage#</cfoutput>
		</cfform>
		</div>

		<table align="center" class="data" width="700px">
			<tr>
				<th>No.</th>
				<th>Code</th>
				<th>Description</th>
				<th>Details</th>
				<th>Action</th>
			</tr>

			<cfoutput query="type3" maxrows="20" startrow="#start#">
				<cfset det = ToString(type3.details)>
				<tr>
					<td>#i#</td>
        			<td nowrap>#type3.code#</a></td>
					<td>#type3.cdesp#</td>
					<td>#det#</td>
					<td>
						<!--- <cfif type1 eq "Add">
				  			<a href="transaction4.cfm?tran=#tran#&hmode=#hmode#&type1=#type1#&nexttranno=#nexttranno#&code=#type.code#&itemno=#urlencodedformat(itemno)#&service=#url.service#&ndatecreate=#ndatecreate#&currrate=#currrate#&refno3=#refno3#&agenno=#agenno#">Select</a>
						<cfelse>
							<a href="transaction4.cfm?tran=#tran#&hmode=#hmode#&type1=#type1#&nexttranno=#nexttranno#&code=#type.code#&itemno=#urlencodedformat(itemno)#&service=#url.service#&ndatecreate=#ndatecreate#&currrate=#currrate#&refno3=#refno3#&agenno=#agenno#&itemcount=#itemcount#">Select</a>&nbsp;
							<!--- <a href="transaction4.cfm?ap=ap&tran=#tran#&type1=#type1#&nexttranno=#nexttranno#&code=#type.code#&itemno=#itemno#&service=#url.service#&ndatecreate=#ndatecreate#&currrate=#currrate#&refno3=#refno3#&agenno=#agenno#&itemcount=#itemcount#">Append</a> --->
				 		</cfif> --->
						<a href="transaction4.cfm?stype=#stype#&code=#URLEncodedFormat(type3.code)#&adtcost1=#URLEncodedFormat(listfirst(adtcost1))#&adtcost2=#URLEncodedFormat(listfirst(adtcost2))#&
						agenno=#URLEncodedFormat(listfirst(agenno))#&balance=#URLEncodedFormat(listfirst(balance))#&batchqty=#URLEncodedFormat(listfirst(batchqty))#&
						brem3=#URLEncodedFormat(listfirst(brem3))#&brem4=#URLEncodedFormat(listfirst(brem4))#&comment=#URLEncodedFormat(comment)#&
						compareqty=#URLEncodedFormat(listfirst(compareqty))#&crequestdate=#URLEncodedFormat(listfirst(crequestdate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&
						custno=#URLEncodedFormat(listfirst(custno))#&defective=#URLEncodedFormat(listfirst(defective))#&desp=#URLEncodedFormat(desp)#&
						despa=#URLEncodedFormat(despa)#&dispec1=#URLEncodedFormat(listfirst(dispec1))#&dispec2=#URLEncodedFormat(listfirst(dispec2))#&
						dispec3=#URLEncodedFormat(listfirst(dispec3))#&dodate=#URLEncodedFormat(listfirst(dodate))#&enterbatch=#URLEncodedFormat(listfirst(enterbatch))#&
						enterbatch1=#URLEncodedFormat(listfirst(enterbatch1))#&expdate=#URLEncodedFormat(listfirst(expdate))#&gltradac=#URLEncodedFormat(listfirst(gltradac))#&
						hmode=#URLEncodedFormat(listfirst(hmode))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&itemcount=#URLEncodedFormat(listfirst(itemcount))#&
						itemno=#URLEncodedFormat(listfirst(itemno))#&items=#URLEncodedFormat(listfirst(items))#&location=#URLEncodedFormat(listfirst(location))#&
						mc1bil=#URLEncodedFormat(listfirst(mc1bil))#&mc2bil=#URLEncodedFormat(listfirst(mc2bil))#&mode=#URLEncodedFormat(listfirst(mode))#&
						ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&nexttranno=#URLEncodedFormat(listfirst(nexttranno))#&oldenterbatch=#URLEncodedFormat(listfirst(oldenterbatch))#&
						oldlocation=#URLEncodedFormat(listfirst(oldlocation))#&oldqty=#URLEncodedFormat(listfirst(oldqty))#&price=#URLEncodedFormat(listfirst(price))#&
						qty=#URLEncodedFormat(listfirst(qty))#&readperiod=#URLEncodedFormat(listfirst(readperiod))#&refno3=#URLEncodedFormat(listfirst(refno3))#&
						requestdate=#URLEncodedFormat(listfirst(requestdate))#&sercost=#URLEncodedFormat(listfirst(sercost))#&service=#URLEncodedFormat(listfirst(service))#&
						sodate=#URLEncodedFormat(listfirst(sodate))#&sv_part=#URLEncodedFormat(listfirst(sv_part))#&tran=#URLEncodedFormat(listfirst(tran))#&
						type1=#URLEncodedFormat(listfirst(type1))#&unit=#URLEncodedFormat(listfirst(unit))#&newtrancode=#newtrancode#&multilocation=#multilocation#&remark5=#remark5#&remark6=#remark6#">Select</a>
					</td>
				</tr>
				<cfset i = incrementvalue(i)>
			</cfoutput>
		</table>

		<hr>
		<div align="right">

		<cfif start neq 1>
			<cfif type1 eq "Add">
				||
						<a href="trancmentsearch.cfm?start=#prevTwenty#&stype=#stype#&adtcost1=#URLEncodedFormat(listfirst(adtcost1))#&adtcost2=#URLEncodedFormat(listfirst(adtcost2))#&
						agenno=#URLEncodedFormat(listfirst(agenno))#&balance=#URLEncodedFormat(listfirst(balance))#&batchqty=#URLEncodedFormat(listfirst(batchqty))#&
						brem3=#URLEncodedFormat(listfirst(brem3))#&brem4=#URLEncodedFormat(listfirst(brem4))#&comment=#URLEncodedFormat(comment)#&
						compareqty=#URLEncodedFormat(listfirst(compareqty))#&crequestdate=#URLEncodedFormat(listfirst(crequestdate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&
						custno=#URLEncodedFormat(listfirst(custno))#&defective=#URLEncodedFormat(listfirst(defective))#&desp=#URLEncodedFormat(desp)#&
						despa=#URLEncodedFormat(despa)#&dispec1=#URLEncodedFormat(listfirst(dispec1))#&dispec2=#URLEncodedFormat(listfirst(dispec2))#&
						dispec3=#URLEncodedFormat(listfirst(dispec3))#&dodate=#URLEncodedFormat(listfirst(dodate))#&enterbatch=#URLEncodedFormat(listfirst(enterbatch))#&
						enterbatch1=#URLEncodedFormat(listfirst(enterbatch1))#&expdate=#URLEncodedFormat(listfirst(expdate))#&gltradac=#URLEncodedFormat(listfirst(gltradac))#&
						hmode=#URLEncodedFormat(listfirst(hmode))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&itemcount=#URLEncodedFormat(listfirst(itemcount))#&
						itemno=#URLEncodedFormat(listfirst(itemno))#&items=#URLEncodedFormat(listfirst(items))#&location=#URLEncodedFormat(listfirst(location))#&
						mc1bil=#URLEncodedFormat(listfirst(mc1bil))#&mc2bil=#URLEncodedFormat(listfirst(mc2bil))#&mode=#URLEncodedFormat(listfirst(mode))#&
						ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&nexttranno=#URLEncodedFormat(listfirst(nexttranno))#&oldenterbatch=#URLEncodedFormat(listfirst(oldenterbatch))#&
						oldlocation=#URLEncodedFormat(listfirst(oldlocation))#&oldqty=#URLEncodedFormat(listfirst(oldqty))#&price=#URLEncodedFormat(listfirst(price))#&
						qty=#URLEncodedFormat(listfirst(qty))#&readperiod=#URLEncodedFormat(listfirst(readperiod))#&refno3=#URLEncodedFormat(listfirst(refno3))#&
						requestdate=#URLEncodedFormat(listfirst(requestdate))#&sercost=#URLEncodedFormat(listfirst(sercost))#&service=#URLEncodedFormat(listfirst(service))#&
						sodate=#URLEncodedFormat(listfirst(sodate))#&sv_part=#URLEncodedFormat(listfirst(sv_part))#&tran=#URLEncodedFormat(listfirst(tran))#&
						type1=#URLEncodedFormat(listfirst(type1))#&unit=#URLEncodedFormat(listfirst(unit))#&newtrancode=#newtrancode#&multilocation=#multilocation#&remark5=#remark5#&remark6=#remark6#&taxpec1=#taxpec1#&type=#type#">Previous</a>
						||

			<cfelse>
				||
						<a href="trancmentsearch.cfm?start=#prevTwenty#&stype=#stype#&adtcost1=#URLEncodedFormat(listfirst(adtcost1))#&adtcost2=#URLEncodedFormat(listfirst(adtcost2))#&
						agenno=#URLEncodedFormat(listfirst(agenno))#&balance=#URLEncodedFormat(listfirst(balance))#&batchqty=#URLEncodedFormat(listfirst(batchqty))#&
						brem3=#URLEncodedFormat(listfirst(brem3))#&brem4=#URLEncodedFormat(listfirst(brem4))#&comment=#URLEncodedFormat(comment)#&
						compareqty=#URLEncodedFormat(listfirst(compareqty))#&crequestdate=#URLEncodedFormat(listfirst(crequestdate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&
						custno=#URLEncodedFormat(listfirst(custno))#&defective=#URLEncodedFormat(listfirst(defective))#&desp=#URLEncodedFormat(desp)#&
						despa=#URLEncodedFormat(despa)#&dispec1=#URLEncodedFormat(listfirst(dispec1))#&dispec2=#URLEncodedFormat(listfirst(dispec2))#&
						dispec3=#URLEncodedFormat(listfirst(dispec3))#&dodate=#URLEncodedFormat(listfirst(dodate))#&enterbatch=#URLEncodedFormat(listfirst(enterbatch))#&
						enterbatch1=#URLEncodedFormat(listfirst(enterbatch1))#&expdate=#URLEncodedFormat(listfirst(expdate))#&gltradac=#URLEncodedFormat(listfirst(gltradac))#&
						hmode=#URLEncodedFormat(listfirst(hmode))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&itemcount=#URLEncodedFormat(listfirst(itemcount))#&
						itemno=#URLEncodedFormat(listfirst(itemno))#&items=#URLEncodedFormat(listfirst(items))#&location=#URLEncodedFormat(listfirst(location))#&
						mc1bil=#URLEncodedFormat(listfirst(mc1bil))#&mc2bil=#URLEncodedFormat(listfirst(mc2bil))#&mode=#URLEncodedFormat(listfirst(mode))#&
						ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&nexttranno=#URLEncodedFormat(listfirst(nexttranno))#&oldenterbatch=#URLEncodedFormat(listfirst(oldenterbatch))#&
						oldlocation=#URLEncodedFormat(listfirst(oldlocation))#&oldqty=#URLEncodedFormat(listfirst(oldqty))#&price=#URLEncodedFormat(listfirst(price))#&
						qty=#URLEncodedFormat(listfirst(qty))#&readperiod=#URLEncodedFormat(listfirst(readperiod))#&refno3=#URLEncodedFormat(listfirst(refno3))#&
						requestdate=#URLEncodedFormat(listfirst(requestdate))#&sercost=#URLEncodedFormat(listfirst(sercost))#&service=#URLEncodedFormat(listfirst(service))#&
						sodate=#URLEncodedFormat(listfirst(sodate))#&sv_part=#URLEncodedFormat(listfirst(sv_part))#&tran=#URLEncodedFormat(listfirst(tran))#&
						type1=#URLEncodedFormat(listfirst(type1))#&unit=#URLEncodedFormat(listfirst(unit))#&newtrancode=#newtrancode#&multilocation=#multilocation#&remark5=#remark5#&remark6=#remark6#&taxpec1=#taxpec1#&type=#type#">Previous</a>
						||

			</cfif>
		</cfif>

		<cfif page neq noOfPage>
			<cfif type1 eq "Add">

					<a href="trancmentsearch.cfm?start=#evaluate(nextTwenty)#&stype=#stype#&adtcost1=#URLEncodedFormat(listfirst(adtcost1))#&adtcost2=#URLEncodedFormat(listfirst(adtcost2))#&
					agenno=#URLEncodedFormat(listfirst(agenno))#&balance=#URLEncodedFormat(listfirst(balance))#&batchqty=#URLEncodedFormat(listfirst(batchqty))#&
					brem3=#URLEncodedFormat(listfirst(brem3))#&brem4=#URLEncodedFormat(listfirst(brem4))#&comment=#URLEncodedFormat(comment)#&
					compareqty=#URLEncodedFormat(listfirst(compareqty))#&crequestdate=#URLEncodedFormat(listfirst(crequestdate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&
					custno=#URLEncodedFormat(listfirst(custno))#&defective=#URLEncodedFormat(listfirst(defective))#&desp=#URLEncodedFormat(desp)#&
					despa=#URLEncodedFormat(despa)#&dispec1=#URLEncodedFormat(listfirst(dispec1))#&dispec2=#URLEncodedFormat(listfirst(dispec2))#&
					dispec3=#URLEncodedFormat(listfirst(dispec3))#&dodate=#URLEncodedFormat(listfirst(dodate))#&enterbatch=#URLEncodedFormat(listfirst(enterbatch))#&
					enterbatch1=#URLEncodedFormat(listfirst(enterbatch1))#&expdate=#URLEncodedFormat(listfirst(expdate))#&gltradac=#URLEncodedFormat(listfirst(gltradac))#&
					hmode=#URLEncodedFormat(listfirst(hmode))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&itemcount=#URLEncodedFormat(listfirst(itemcount))#&
					itemno=#URLEncodedFormat(listfirst(itemno))#&items=#URLEncodedFormat(listfirst(items))#&location=#URLEncodedFormat(listfirst(location))#&
					mc1bil=#URLEncodedFormat(listfirst(mc1bil))#&mc2bil=#URLEncodedFormat(listfirst(mc2bil))#&mode=#URLEncodedFormat(listfirst(mode))#&
					ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&nexttranno=#URLEncodedFormat(listfirst(nexttranno))#&oldenterbatch=#URLEncodedFormat(listfirst(oldenterbatch))#&
					oldlocation=#URLEncodedFormat(listfirst(oldlocation))#&oldqty=#URLEncodedFormat(listfirst(oldqty))#&price=#URLEncodedFormat(listfirst(price))#&
					qty=#URLEncodedFormat(listfirst(qty))#&readperiod=#URLEncodedFormat(listfirst(readperiod))#&refno3=#URLEncodedFormat(listfirst(refno3))#&
					requestdate=#URLEncodedFormat(listfirst(requestdate))#&sercost=#URLEncodedFormat(listfirst(sercost))#&service=#URLEncodedFormat(listfirst(service))#&
					sodate=#URLEncodedFormat(listfirst(sodate))#&sv_part=#URLEncodedFormat(listfirst(sv_part))#&tran=#URLEncodedFormat(listfirst(tran))#&
					type1=#URLEncodedFormat(listfirst(type1))#&unit=#URLEncodedFormat(listfirst(unit))#&newtrancode=#newtrancode#&multilocation=#multilocation#&remark5=#remark5#&remark6=#remark6#&taxpec1=#taxpec1#&type=#type#">Next</a> ||

			<cfelse>

					<a href="trancmentsearch.cfm?start=#evaluate(nextTwenty)#&stype=#stype#&adtcost1=#URLEncodedFormat(listfirst(adtcost1))#&adtcost2=#URLEncodedFormat(listfirst(adtcost2))#&
					agenno=#URLEncodedFormat(listfirst(agenno))#&balance=#URLEncodedFormat(listfirst(balance))#&batchqty=#URLEncodedFormat(listfirst(batchqty))#&
					brem3=#URLEncodedFormat(listfirst(brem3))#&brem4=#URLEncodedFormat(listfirst(brem4))#&comment=#URLEncodedFormat(comment)#&
					compareqty=#URLEncodedFormat(listfirst(compareqty))#&crequestdate=#URLEncodedFormat(listfirst(crequestdate))#&currrate=#URLEncodedFormat(listfirst(currrate))#&
					custno=#URLEncodedFormat(listfirst(custno))#&defective=#URLEncodedFormat(listfirst(defective))#&desp=#URLEncodedFormat(desp)#&
					despa=#URLEncodedFormat(despa)#&dispec1=#URLEncodedFormat(listfirst(dispec1))#&dispec2=#URLEncodedFormat(listfirst(dispec2))#&
					dispec3=#URLEncodedFormat(listfirst(dispec3))#&dodate=#URLEncodedFormat(listfirst(dodate))#&enterbatch=#URLEncodedFormat(listfirst(enterbatch))#&
					enterbatch1=#URLEncodedFormat(listfirst(enterbatch1))#&expdate=#URLEncodedFormat(listfirst(expdate))#&gltradac=#URLEncodedFormat(listfirst(gltradac))#&
					hmode=#URLEncodedFormat(listfirst(hmode))#&invoicedate=#URLEncodedFormat(listfirst(invoicedate))#&itemcount=#URLEncodedFormat(listfirst(itemcount))#&
					itemno=#URLEncodedFormat(listfirst(itemno))#&items=#URLEncodedFormat(listfirst(items))#&location=#URLEncodedFormat(listfirst(location))#&
					mc1bil=#URLEncodedFormat(listfirst(mc1bil))#&mc2bil=#URLEncodedFormat(listfirst(mc2bil))#&mode=#URLEncodedFormat(listfirst(mode))#&
					ndatecreate=#URLEncodedFormat(listfirst(ndatecreate))#&nexttranno=#URLEncodedFormat(listfirst(nexttranno))#&oldenterbatch=#URLEncodedFormat(listfirst(oldenterbatch))#&
					oldlocation=#URLEncodedFormat(listfirst(oldlocation))#&oldqty=#URLEncodedFormat(listfirst(oldqty))#&price=#URLEncodedFormat(listfirst(price))#&
					qty=#URLEncodedFormat(listfirst(qty))#&readperiod=#URLEncodedFormat(listfirst(readperiod))#&refno3=#URLEncodedFormat(listfirst(refno3))#&
					requestdate=#URLEncodedFormat(listfirst(requestdate))#&sercost=#URLEncodedFormat(listfirst(sercost))#&service=#URLEncodedFormat(listfirst(service))#&
					sodate=#URLEncodedFormat(listfirst(sodate))#&sv_part=#URLEncodedFormat(listfirst(sv_part))#&tran=#URLEncodedFormat(listfirst(tran))#&
					type1=#URLEncodedFormat(listfirst(type1))#&unit=#URLEncodedFormat(listfirst(unit))#&newtrancode=#newtrancode#&multilocation=#multilocation#&remark5=#remark5#&remark6=#remark6#&taxpec1=#taxpec1#&type=#type#">Next</a> ||

			</cfif>
		</cfif>

		<cfoutput>Page #page# Of #noOfPage#</cfoutput></div>
	<cfelse>
		<h3>No Records were found.</h3>
	</cfif>

<br>
</fieldset>
</body>
</html>