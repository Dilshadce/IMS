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
<body>

	<cfset typeNo="custno"> 
	<cfset link = "custsearch.cfm">
	
		<cfif husergrpid eq "Muser"><a href="../home2.cfm"><u>Home</u></a></cfif>
		<h1><cfoutput>Customer Selection Page</cfoutput></h1>
		
				
		<cfoutput>
		
			<form action="ctsearch.cfm?type=#url.type#" method="post">
		
			
		
		</cfoutput>
		
		<cfoutput>
			<h1>Search By :
			
			<select name="searchType">
				<option value="name">Customer Name</option>
				<option value="#typeNo#">Customer ID</option>
				<option value="phone">Customer Tel</option>
			</select>
        Search for Customer : <input type="text" name="searchStr" value=""> 
		<cfif husergrpid eq "Muser"><input type="submit" name="submit" value="Search"></cfif></h1>
			
			</cfoutput>
			
		</form>
	
		<cfquery datasource='#dts#' name="type">
			Select * from #target_arcust# order by Date desc, Name
		</cfquery>
		
		<cfif isdefined("form.searchStr")>
			<cfquery dbtype="query" name="exactResult">
				Select * from TYPE where #form.searchType# = '#form.searchStr#'
			</cfquery>
			
			<cfquery dbtype="query" name="similarResult">
				Select * from TYPE where #form.searchType# LIKE '%#form.searchStr#%'
			</cfquery>
			
			<h2>Exact Result</h2>
			<cfif #exactResult.recordCount# neq 0>
				
    <table width="600" align="center" class="data">
      <tr> 
 			   <th>Agent</th>
			   <th>CustNo</th>
			   <th>Name</th>
 			   <th>Address</th>
  			  <th>Telephone</th>
  			  <th>Attention</th>
  			  <th>Action</th>
	
	
 			 </tr>
  			<cfoutput query="exactresult"> 
   			 <tr> 
   			<td>#exactresult.agent#</td>
			<td>#exactresult.custno#</td>			   
          <td>#exactresult.name#</td>
   			   <td>#exactResult.Add1#<br>#exactResult.Add2#<br>#exactResult.Add3#<br>#exactResult.Add4#</td>
   			   <td>(1) #exactResult.phone#<br>(2) #exactResult.phonea#</td>
    			  <td>#exactResult.attn#</td>
    			  <td>
				  
					<cfif url.type eq "chkcnt">
						<a href="chkcntct.cfm?custno=#exactResult.custno#">Select</a>
					<cfelseif url.type eq "custhistory">
						<a href="customerhistory.cfm?custno=#exactResult.custno#">Select</a>
					<cfelse>
						<a href="createjob.cfm?custno=#exactResult.custno#">Select</a>
					</cfif> 
				  </td>
  			  </tr>
 			 </cfoutput> 
			</table>			
			<cfelse>
				<h3>No Exact Records were found.</h3>
			</cfif>
			
			<h2>Similar Result</h2>
			<cfif #similarResult.recordCount# neq 0>	
			
			 
      <table width="600" align="center" class="data">
        <tr> 
				<th>Agent</th>
				<th>CustNo</th>
				<th>Name</th>
 			  	<th>Address</th>
				<th>Telephone</th>
				<th>Attention</th>
				<th>Action</th>
				
 			 </tr>
  			<cfoutput query="similarResult" startrow="#start#" maxrows="20"> 
   			 <tr> 
			 	<td>#similarResult.agent#</td>
				<td>#similarResult.custno#</td>
   			   <td>#similarResult.name#</td>
   			   <td>#similarResult.Add1#<br>#similarResult.Add2#<br>#similarResult.Add3#<br>#similarResult.Add4#</td>
   			   <td>(1) #similarResult.phone#<br>(2) #similarResult.phonea#</td>
    		   <td>#similarResult.attn#</td>
			   
  			   <td>
			   		
					<cfif #url.type# eq "chkcnt">
						<a href="chkcntct.cfm?custno=#similarResult.custno#">Select</a>
					<cfelseif url.type eq "custhistory">
						<a href="customerhistory.cfm?custno=#exactResult.custno#">Select</a>
					<cfelse>
						<a href="createjob.cfm?custno=#similarResult.custno#">Select</a>
					</cfif> 	
						
					
				</td>
  			  </tr>
 			 </cfoutput> 
			</table>
							
			<cfelse>
				<h3>No Similar Records were found.</h3>
			</cfif>
</cfif>
<cfparam name="i" default="1" type="numeric">
		<hr>
		
		<fieldset><legend style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;
		font-style: italic;line-height: normal;font-weight: bold;text-transform: capitalize;color: #0066FF;">
		<cfoutput>10 Newest Customer:</cfoutput></legend><br>
		<cfif #type.recordCount# neq 0>
			<cfform action="ctsearch.cfm?type=#url.type#" method="post">
			
				<div align="right">Page <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">
			
			<cfset noOfPage=round(#Type.recordcount#/20)>
			
			<cfif #type.recordcount# mod 20 LT 10 and #type.recordcount# mod 20 neq 0>
				<cfset noOfPage=#noOfPage#+1>
			</cfif>
			
			<cfif isdefined("start")> 
				<cfset start=#start#>
			</cfif> 
			
			<cfif isdefined("form.skeypage")>				
				<cfset start = #form.skeypage# * 20 + 1 - 20>				
				<cfif form.skeypage eq "1">
					<cfset start = "1">					
				</cfif>  				
			</cfif>
			
			<cfset prevTwenty=#start# -20>
			<cfset nextTwenty=#start# +20>
			<cfset page=round(#nextTwenty#/20)>
				
			<cfif #start# neq 1>
				<cfoutput>|| <a href="ctsearch.cfm?start=#prevTwenty#&type=#url.type#">Previous</a> ||</cfoutput>
			</cfif>
				
		    <cfif #page# neq #noOfPage#>
				<cfoutput> <a href="ctsearch.cfm?start=#evaluate(nextTwenty)#&type=#url.type#">Next</a> ||</cfoutput>
			</cfif>
				
			<cfoutput>Page #page# Of #noOfPage#</cfoutput>		
			
			</cfform>
			</div>
		<table align="center" class="data" width="600px">					
				
				<tr>
						<th width>No.</th>
						<th width>Agent</th>
						<th width>CustNo</th>
						<th width>Name</th>
						<th width>Address</th>
						<th width>Telephone</th>
						<th width>Attention</th>
						<th width>Action</th>
				</tr>
				<cfoutput query="type" startrow="#start#" maxrows="10">
				<tr>
						
						<td>#i#</td>
						<td>#type.agent#</td>
						<td>#type.custno#</td>
						<td>#type.Name#</td>
						<td>#type.Add1#<br>#type.Add2#<br>#type.Add3#<br>#type.Add4#</td>
						<td>(1) #type.phone#<br>(2) #type.phonea#</td>
						<td>#type.attn#</td>
						<td>
							<cfif url.type eq "chkcnt">
								<a href="chkcntct.cfm?custno=#type.custno#">Select</a>
							<cfelseif url.type eq "custhistory">
								<a href="customerhistory.cfm?custno=#type.custno#">Select</a>
							<cfelse>
								<a href="createjob.cfm?custno=#type.custno#">Select</a>
							</cfif> 							
						</td>
				</tr>
				<cfset i = incrementvalue(#i#)>
				</cfoutput>
		</table>
		<div align="right">
   			<cfif #start# neq 1>
       		<cfoutput><a href="ctsearch.cfm?start=#prevTwenty#&type=#url.type#">Previous</a> ||</cfoutput> 
    	  	</cfif>
      		<cfif #page# neq #noOfPage#>
       		<cfoutput> <a href="ctsearch.cfm?start=#evaluate(nextTwenty)#&type=#url.type#">Next</a> ||</cfoutput> 
      		</cfif>
      		<cfoutput>Page #page# Of #noOfPage#</cfoutput> </div>
		<cfelse>
			<h3>No Records were found.</h3>
		</cfif>
		<br>
		</fieldset>
	

</body>
</html>
