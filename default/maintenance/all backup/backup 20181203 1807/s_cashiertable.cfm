<html>
<head>
<title>Create Or Edit Or View</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>
		
<h1><cfoutput>Cashier Selection Page</cfoutput></h1>
		
<cfoutput>
	<h4>
		<cfif getpin2.h1P10 eq 'T'><a href="cashiertable2.cfm?type=Create">Creating a New Cashier</a> </cfif>
		<cfif getpin2.h1P20 eq 'T'>|| <a href="cashiertable.cfm">List all Cashier</a> </cfif>
		<cfif getpin2.h1P30 eq 'T'>|| <a href="s_cashiertable.cfm?type=brand">Search For Cashier</a></cfif>
        <cfif getpin2.h1630 eq 'T'>|| <a href="p_cashier.cfm">Cashier Listing</a>
        || <a href="attendancereport.cfm">Staff Attendance Report</a>
        </cfif>
	</h4>
</cfoutput>
		
<cfoutput>
	<form action="s_cashiertable.cfm" method="post"></cfoutput>
	<cfoutput>
		<h1>Search By :
		<select name="searchType">
			<option value="cashierid">Cashier</option>
		</select>
        Search for Cashier : <input type="text" name="searchStr" value=""> </h1>
	</cfoutput>
	</form>
		
	<cfif isdefined("url.process")>
		<cfoutput><h1>#form.status#</h1><hr></cfoutput>
	</cfif>
	
	<cfquery datasource='#dts#' name="type">
		Select * from cashier order by cashierid, name,password
	</cfquery>
		
	<cfif isdefined("form.searchStr")>
		<cfquery datasource='#dts#' name="exactResult">
			Select * from cashier where #form.searchType# = '#form.searchstr#' order by cashierid, name, password
		</cfquery>
			
		<cfquery datasource='#dts#' name="similarResult">
			Select * from cashier where #form.searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> order by cashierid, name, password
		</cfquery>
			
		<h2>Exact Result</h2>
		<cfif exactResult.recordCount neq 0>
			<table align="center" class="data" width="600px">				
	     		<tr> 
	        		<cfoutput><th>Cashier</th></cfoutput>
					<th>Name</th>
					<cfif getpin2.h1P11 eq 'T'><th>Action</th></cfif>				
				</tr>
				<cfoutput query="exactResult">
					<tr>
						<td>#exactResult.cashierid#</a></td>
						<td>#exactResult.name#</td>					
	          			<cfif getpin2.h1P11 eq 'T'>
		          			<td width="10%" nowrap><div align="center">
			          			<a href="cashiertable2.cfm?type=Delete&cashier=#URLEncodedFormat(exactResult.cashierid)#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>
			          			&nbsp;<a href="cashiertable2.cfm?type=Edit&cashier=#URLEncodedFormat(exactResult.cashierid)#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a>
							</div></td>
						</cfif>
					</tr>
				</cfoutput>
			</table>
		<cfelse>
			<h3>No Exact Records were found.</h3>
		</cfif>
			
		<h2>Similar Result</h2>
		<cfif similarResult.recordCount neq 0>
			<table align="center" class="data" width="600px">	
	     		<tr> 
	        		<cfoutput><th>Cashier</th></cfoutput>
					<th>Name</th>
                    
					<cfif getpin2.h1P11 eq 'T'><th>Action</th></cfif>
				</tr>
				<cfoutput query="similarResult">
					<tr>
						<td>#similarResult.cashierid#</a></td>
						<td>#similarResult.name#</td>					
	          			<cfif getpin2.h1P11 eq 'T'>
		          			<td width="10%" nowrap> 
	            				<div align="center"><a href="cashiertable2.cfm?type=Delete&cashier=#URLEncodedFormat(similarResult.cashierid)#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>
	            				&nbsp;<a href="cashiertable2.cfm?type=Edit&cashier=#URLEncodedFormat(similarResult.cashierid)#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a>
								</div>
							</td>
						</cfif>
					</tr>
				</cfoutput>
			</table>
		<cfelse>
			<h3>No Similar Records were found.</h3>
		</cfif>
	</cfif>
		
	<cfparam name="i" default="1" type="numeric">
	<hr>
		
	<fieldset>
	<legend style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;
		font-style: italic;line-height: normal;font-weight: bold;text-transform: capitalize;color: #0066FF;"> 
		<cfoutput>20 Newest Cashier :</cfoutput>
	</legend>
	<br>
		<cfif type.recordCount neq 0>
			<table align="center" class="data" width="600px">	
				<tr>
					<th>No</th>
	      			<cfoutput><th>Cashier ID</th></cfoutput>
					<th>Name</th>
					<cfif getpin2.h1P11 eq 'T'><th>Action</th></cfif>
				</tr>
				<cfoutput query="type" maxrows="20">
					<tr>	
						<td>#i#</td>
						<td>#type.cashierid#</a></td>
						<td>#type.name#<br></td>					
		       			<cfif getpin2.h1P11 eq 'T'>
			       			<td width="10%" nowrap>
				       			<div align="center"><a href="cashiertable2.cfm?type=Delete&cashier=#URLEncodedFormat(type.cashierid)#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>
				       			&nbsp;<a href="cashiertable2.cfm?type=Edit&cashier=#URLEncodedFormat(type.cashierid)#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a>
								</div>
							</td>
						</cfif>
					</tr>
					<cfset i = incrementvalue(#i#)>
				</cfoutput>
			</table>
		<cfelse>
			<h3>No Records were found.</h3>
		</cfif>
		<br>
	</fieldset>
</body>
</html>
