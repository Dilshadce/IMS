<html>
<head>
<title>Search Customer</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevTwenty" default="0">
<cfparam name="nextTwenty" default="0">
<body>

	<!--- <cfset typeNo="customerno">  --->
	<cfset link = "custsearch.cfm">
	<cfif type eq 1>
		<cfset title = "Customer">
	<cfelse>
		<cfset title = "Supplier">
	</cfif>
		<cfif husergrpid eq "Muser"><a href="../home2.cfm"><u>Home</u></a></cfif>
		<h1><cfoutput>Customer Selection Page</cfoutput></h1>
		
		<!--- <br>
		 <cfoutput>Mode = #ttype#</cfoutput>
		<br>
		 <cfoutput>Type = #stype#</cfoutput> --->
		
		<cfoutput>		
		<form action="custsearch.cfm?type=#type#&get=#get#<cfif isdefined("rtype")>&rtype=#rtype#</cfif><cfif isdefined("getfrom")>&getfrom=#getfrom#</cfif><cfif isdefined("getto")>&getto=#getto#</cfif>" method="post">
					
			<h1>Search By :
			
			<select name="searchType">
				<option value="name">#title# Name</option>
				<option value="customerno">#title# ID</option>
				<option value="phone">#title# Tel</option>
			</select>
        	Search for Customer : <input type="text" name="searchStr" value=""> 
			<cfif husergrpid eq "Muser"><input type="submit" name="submit" value="Search"></cfif></h1>		
			
		</form>
	    </cfoutput>
		
		<cfquery name="getgeneral" datasource="#dts#">
			select invsecure from gsetup
		</cfquery>
		
		<cfquery datasource='#dts#' name="data">
			Select * from #title# <cfif getgeneral.invsecure eq 1><cfif husergrpid neq "admin" and husergrpid neq 'super'>where agent = '#huserid#'</cfif></cfif>order by Date desc, Name
		</cfquery>
		
		<cfif isdefined("form.searchStr")>
			<cfquery dbtype="query" name="exactResult">
				Select * from data where #form.searchType# = '#form.searchStr#' order by #form.searchType#
			</cfquery>
			
			<cfquery dbtype="query" name="similarResult">
				Select * from data where #form.searchType# LIKE '#form.searchStr#' order by #form.searchType#
			</cfquery>
			
			<h2>Exact Result</h2>
			<cfif #exactResult.recordCount# neq 0>
				
    		<table width="600" align="center" class="data">
     		  <cfoutput>
			  <tr> 			   	
			   <th>Agent</th>
			   <th>#title# No</th>
			   <th>Name</th>
 			   <th>Address</th>
  			  <th>Telephone</th>
  			  <th>Attention</th>
  			  <th>Action</th>	
 			 </tr>
			 </cfoutput>
  			<cfoutput query="exactresult"> 
   			 <tr> 
   			<td>#exactresult.agent#</td>
			<td>#exactresult.customerno#</td>			   
          	<td>#exactresult.name#</td>
   			   <td>#exactResult.Add1#<br>#exactResult.Add2#<br>#exactResult.Add3#<br>#exactResult.Add4#</td>
   			   <td>(1) #exactResult.phone#<br>(2) #exactResult.phonea#</td>
    			  <td>#exactResult.attn#</td>
    			  <td><a href="listing_report.cfm?custno=#exactresult.customerno#&type=#type#&get=#get#<cfif isdefined("rtype")>&rtype=#rtype#</cfif><cfif isdefined("getfrom")>&getfrom=#getfrom#</cfif><cfif isdefined("getto")>&getto=#getto#</cfif>">Select</a></td>
  			  </tr>
 			 </cfoutput> 
			</table>			
			<cfelse>
				<h3>No Exact Records were found.</h3>
			</cfif>
			
			<h2>Similar Result</h2>
			<cfif #similarResult.recordCount# neq 0>	
			
			 
      <table width="600" align="center" class="data">
        <cfoutput>
		<tr> 
				<th>Agent</th>
				<th>#title# No</th>
				<th>Name</th>
 			  	<th>Address</th>
				<th>Telephone</th>
				<th>Attention</th>
				<th>Action</th>
				
 			 </tr>
			 </cfoutput>
  			<cfoutput query="similarResult" startrow="#start#" maxrows="10"> 
   			 <tr> 
			 	<td>#similarResult.agent#</td>
				<td>#similarResult.customerno#</td>
   			   <td>#similarResult.name#</td>
   			   <td>#similarResult.Add1#<br>#similarResult.Add2#<br>#similarResult.Add3#<br>#similarResult.Add4#</td>
   			   <td>(1) #similarResult.phone#<br>(2) #similarResult.phonea#</td>
    		   <td>#similarResult.attn#</td>			   
  			   <td><a href="listing_report.cfm?custno=#similarResult.customerno#&type=#type#&get=#get#<cfif isdefined("rtype")>&rtype=#rtype#</cfif><cfif isdefined("getfrom")>&getfrom=#getfrom#</cfif><cfif isdefined("getto")>&getto=#getto#</cfif>">Select</a></td>			
  			  </tr>
 			 </cfoutput> 
			</table>
							
			<cfelse>
				<h3>No Similar Records were found.</h3>
			</cfif>
		</cfif>

		<hr>
		
		<fieldset><legend style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;
		font-style: italic;line-height: normal;font-weight: bold;text-transform: capitalize;color: #0066FF;">
		<cfoutput>10 Newest Customer:</cfoutput></legend><br>
		<cfif #data.recordCount# neq 0>
			<cfform action="custsearch.cfm?type=#type#&get=#get#" method="post">
				
				<cfoutput>
				<cfif isdefined("rtype")>
					<input type="hidden" name="rtype" value="#rtype#">
				</cfif>
				<cfif isdefined("getfrom")>				
					<input type="hidden" name="getfrom" value="#getfrom#">
				</cfif>
				<cfif isdefined("getto")>
					<input type="hidden" name="getto" value="#getto#">
				</cfif>				
				</cfoutput>
				
				<cfset noOfPage=round(#data.recordcount#/10)>
			
				<cfif isdefined("skeypage")>
					<cfif skeypage gt noofpage OR skeypage lt 1>
						<h3 align="center"><font color="#FF0000">Wrong page number! Please try again.</font></h3>
						<cfabort>
					</cfif>
				</cfif>	
			
				<div align="right">Page <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">
								
			<cfif #data.recordcount# mod 10 LT 5 and #data.recordcount# mod 10 neq 0>
				<cfset noOfPage=#noOfPage#+1>
			</cfif>
			
			<cfif isdefined("start")> 
				<cfset start=#start#>
			</cfif> 
			
			<cfif isdefined("form.skeypage")>				
				<cfset start = #form.skeypage# * 10 + 1 - 10>				
				<cfif form.skeypage eq "1">
					<cfset start = "1">					
				</cfif>  				
			</cfif>
			
			<cfparam name="i" default="#start#" type="numeric">
			
			<cfset prevTwenty=#start# -10>
			<cfset nextTwenty=#start# +10>
			<cfset page=round(#nextTwenty#/10)>
				
			<cfif #start# neq 1>			  
				<cfoutput>|| <a href="custsearch.cfm?start=#prevTwenty#&type=#type#&get=#get#<cfif isdefined("rtype")>&rtype=#rtype#</cfif><cfif isdefined("getfrom")>&getfrom=#getfrom#</cfif><cfif isdefined("getto")>&getto=#getto#</cfif>">Previous</a> ||</cfoutput>			  					
			</cfif>
				
		    <cfif #page# neq #noOfPage#>			  
				<cfoutput> <a href="custsearch.cfm?start=#evaluate(nextTwenty)#&type=#type#&get=#get#<cfif isdefined("getfrom")>&getfrom=#getfrom#</cfif><cfif isdefined("getto")>&getto=#getto#</cfif>">Next</a> ||</cfoutput>			 					
			</cfif>
				
			<cfoutput>Page #page# Of #noOfPage#</cfoutput>		
			
			</cfform>
			</div>
		<table align="center" class="data" width="600px">					
				<cfoutput>
				<tr>
						<th>No.</th>
						<th>Agent</th>
						<th>#title# No</th>
						<th>Name</th>
						<th>Address</th>
						<th>Telephone</th>
						<th>Attention</th>
						<th>Action</th>
				</tr>
				</cfoutput>
				<cfoutput query="data" startrow="#start#" maxrows="10">
				<tr>
						
						<td>#i#</td>
						<td>#data.agent#</td>
						<td>#data.customerno#</td>
						<td>#data.Name#</td>
						<td>#data.Add1#<br>#data.Add2#<br>#data.Add3#<br>#data.Add4#</td>
						<td>(1) #data.phone#<br>(2) #data.phonea#</td>
						<td>#data.attn#</td>
						<td><a href="listing_report.cfm?custno=#data.customerno#&type=#type#&get=#get#<cfif isdefined("rtype")>&rtype=#rtype#</cfif><cfif isdefined("getfrom")>&getfrom=#getfrom#</cfif><cfif isdefined("getto")>&getto=#getto#</cfif>">Select</a></td>
				</tr>
				<cfset i = incrementvalue(#i#)>
				</cfoutput>
		</table>
		<hr>
		<div align="right">
   			<cfif #start# neq 1>			  
				<cfoutput>|| <a href="custsearch.cfm?start=#prevTwenty#&type=#type#&get=#get#<cfif isdefined("rtype")>&rtype=#rtype#</cfif><cfif isdefined("getfrom")>&getfrom=#getfrom#</cfif><cfif isdefined("getto")>&getto=#getto#</cfif>">Previous</a> ||</cfoutput>			 					
			</cfif>
				
		    <cfif #page# neq #noOfPage#>			  
				<cfoutput> <a href="custsearch.cfm?start=#evaluate(nextTwenty)#&type=#type#&get=#get#<cfif isdefined("rtype")>&rtype=#rtype#</cfif><cfif isdefined("getfrom")>&getfrom=#getfrom#</cfif><cfif isdefined("getto")>&getto=#getto#</cfif>">Next</a> ||</cfoutput>			  					
			</cfif>
      		<cfoutput>Page #page# Of #noOfPage#</cfoutput> </div>
		<cfelse>
			<h3>No Records were found.</h3>
		</cfif>
		<br>
		</fieldset>
	

</body>
</html>
