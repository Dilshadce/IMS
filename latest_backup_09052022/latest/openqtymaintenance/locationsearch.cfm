<html>
<head>
<title>Search Location</title>
<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<h1 align="center">Search Location</h1>

<cfoutput>
	<form action="locationsearch.cfm" method="post">
		<input type="hidden" name="batchcode" value="#batchcode#">
		<input type="hidden" name="items" value="#items#">
		<input type="hidden" name="qtybf" value="#qtybf#">
		<input type="hidden" name="type" value="#type#">
		<input type="hidden" name="refno" value="#refno#">
		<input type="hidden" name="expdate" value="#expdate#">
        <cfif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "jaynbtrading_i" or lcase(hcomid) eq "laihock_i">
            <input type="hidden" name="permit_no" value="#permit_no#">
            <input type="hidden" name="permit_no2" value="#permit_no2#">
        </cfif>
		<h1>Search By :
			<select name="searchType">
	    		<option value="location">Location</option>
				<option value="desp">Description</option>
	  		</select>
			Search for Item : 
      		<input type="text" name="searchStr" value="">
	  		<cfif husergrpid eq "Muser"><input type="submit" name="submit" value="Search"></cfif>
		</h1>
	</form>
</cfoutput>

<cfquery datasource='#dts#' name="type1">
	Select * 
	from iclocation 
	order by location desc;
</cfquery>
		
<cfif isdefined("form.searchStr")>
	<cfquery dbtype="query" name="exactResult">
		Select * 
		from type1 
		where #form.searchType#='#form.searchStr#' 
		order by #form.searchType#;
	</cfquery>
			
	<cfquery dbtype="query" name="similarResult">
	  	Select * 
		from type1 
		where #form.searchType# LIKE '#form.searchStr#' 
		order by #form.searchType#;
	</cfquery>
			
	<h2>Exact Result</h2>
	<cfif exactResult.recordCount neq 0>
		<table align="center" class="data" width="550px">					
	    	<tr>
		  		<th>Location</th>
		  		<th>Description</th>
		  		<th>Action</th>
			</tr>
			<form action="locationbatch.cfm?modeaction=add" name="done" method="post">
				<cfoutput>
					<input type="hidden" name="batchcode" value="#batchcode#">
					<input type="hidden" name="items" value="#items#">
					<input type="hidden" name="qtybf" value="#qtybf#">
					<input type="hidden" name="type" value="#type#">
					<input type="hidden" name="refno" value="#refno#">
					<input type="hidden" name="expdate" value="#expdate#">
                    <cfif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "jaynbtrading_i" or lcase(hcomid) eq "laihock_i">
                        <input type="hidden" name="permit_no" value="#permit_no#">
                        <input type="hidden" name="permit_no2" value="#permit_no2#">
                    </cfif>
				</cfoutput>
			<cfoutput query="exactResult">
		  	<tr>
		    	<td>#exactResult.location#</a></td>
		    	<td>#exactResult.desp#</td>
				<td><input type="submit" name="select1" value="#exactResult.location#" style="background-color:##CCCCFF; border-color:##CCCCFF; border-style:none"></td>
		  	</tr>
	    	</cfoutput>
			</form>
	  	</table>
	<cfelse>
	  	<h3>No Exact Records were found.</h3>
	</cfif>
			
	<h2>Similar Result</h2>
	<cfif similarResult.recordCount neq 0>
	  	<table align="center" class="data" width="600px">					
			<tr>
		  		<th>Location</th>
		  		<th>Description</th>
		  		<th>Action</th>
			</tr>
			<form action="locationbatch.cfm?modeaction=add" name="done" method="post">
				<cfoutput>
					<input type="hidden" name="batchcode" value="#batchcode#">
					<input type="hidden" name="items" value="#items#">
					<input type="hidden" name="qtybf" value="#qtybf#">
					<input type="hidden" name="type" value="#type#">
					<input type="hidden" name="refno" value="#refno#">
					<input type="hidden" name="expdate" value="#expdate#">
                    <cfif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "jaynbtrading_i" or lcase(hcomid) eq "laihock_i">
                        <input type="hidden" name="permit_no" value="#permit_no#">
                        <input type="hidden" name="permit_no2" value="#permit_no2#">
                    </cfif>
				</cfoutput>
			<cfoutput query="similarResult">
		  	<tr>
		    	<td>#similarResult.location#</a></td>
		    	<td>#similarResult.desp#</td>
				<td><input type="submit" name="select2" value="#similarResult.location#" style="background-color:##CCCCFF; border-color:##CCCCFF; border-style:none"></td>
		  	</tr>
	    	</cfoutput>
			</form>
	  	</table>
	<cfelse>
	  	<h3>No Similar Records were found.</h3>
	</cfif>
</cfif>
  
<cfparam name="i" default="1" type="numeric">
  
<hr><fieldset><legend style="font-family:Verdana, Arial,Helvetica,sans-serif;font-size:12px;font-style:italic;line-height:normal;font-weight:bold;text-transform:capitalize;color:##0066FF;">
20 Newest Icitem:</legend><br>

<cfif type1.recordCount neq 0>
	<table align="center" class="data" width="600px">					
		<tr>
			<th>No.</th>
		  	<th>Location</th>
		  	<th>Description</th>
		  	<th>Action</th>
		</tr>
		<form action="locationbatch.cfm?modeaction=add" name="done" method="post">
			<cfoutput>
				<input type="hidden" name="batchcode" value="#batchcode#">
				<input type="hidden" name="items" value="#items#">
				<input type="hidden" name="qtybf" value="#qtybf#">
				<input type="hidden" name="type" value="#type#">
				<input type="hidden" name="refno" value="#refno#">
				<input type="hidden" name="expdate" value="#expdate#">
                <cfif lcase(hcomid) eq "thaipore_i" or lcase(hcomid) eq "jaynbtrading_i" or lcase(hcomid) eq "laihock_i">
                    <input type="hidden" name="permit_no" value="#permit_no#">
                    <input type="hidden" name="permit_no2" value="#permit_no2#">
                </cfif>
			</cfoutput>
		<cfoutput query="type1" maxrows="20">
		<tr>
			<td>#i#</td>
			<td>#type1.location#</a></td>
			<td>#type1.desp#</td>
			<td><input type="submit" name="select3" value="#type1.location#" style="background-color:##CCCCFF; border-color:##CCCCFF; border-style:none"></td>
		</tr>
		<cfset i = incrementvalue(i)>
		</cfoutput>
		</form>
	</table>
<cfelse>
	<h3>No Records were found.</h3>
</cfif>

<table align="center">
	<tr>
		<td><input type="button" name="Back" value="Back" onClick="window.location='locationbatch.cfm?modeaction=add'"></td>
	</tr>
</table>

<br>
</fieldset>  	
</body>
</html>