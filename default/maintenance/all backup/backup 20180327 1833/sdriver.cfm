<html>
<head>
<title>Create Or Edit Or View</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevtwenty" default="0">
<cfparam name="nexttwenty" default="0">
<cfquery datasource='#dts#' name="getPersonnel">
	Select * from driver order by driverno
</cfquery>
<body>
<!--- ADD ON 15-07-2009 --->
<cfquery name="getGsetup" datasource="#dts#">
  Select lDRIVER from GSetup
</cfquery>
<!--- <cfset typeNo=#url.type# & "No"> 
	<cfset link = #url.type# &".cfm"> --->
<!--- <cfif isdefined("URL.Type")> --->
<h1><cfoutput>#getGsetup.lDRIVER# Selection Page</cfoutput></h1>
<cfoutput> 
  <h4>
	<cfif getpin2.h1C10 eq 'T'><a href="Driver.cfm?type=Create"> Creating a #getGsetup.lDRIVER#</a> </cfif>
	<cfif getpin2.h1C20 eq 'T'>|| <a href="vdriver.cfm">List all #getGsetup.lDRIVER#</a> </cfif>
	<cfif getpin2.h1C30 eq 'T'>|| <a href="sdriver.cfm">Search #getGsetup.lDRIVER#</a> </cfif>
	<cfif getpin2.h1C40 eq 'T'>|| <a href="pdriver.cfm" target="_blank">#getGsetup.lDRIVER# Listing</a></cfif></h4>
</cfoutput>
<cfoutput>
<form action="sdriver.cfm" method="post">
    <h1>Search By : 
    	<select name="searchType">
        <cfif lcase(hcomid) eq 'tcds_i'>
        <option value="icno">IC No</option>
        <option value="driverno">#getGsetup.lDRIVER# No</option>
        <option value="name">Member Name</option>
        <option value="contact">Mobile</option>
        <option value="phone">Phone</option>
        <cfelse>
        	<option value="driverno">#getGsetup.lDRIVER# No</option>
        	<option value="name" <cfif lcase(HcomID) eq "polypet_i">selected</cfif>>#getGsetup.lDRIVER# Name</option>
        	<option value="attn">Attn</option>
        	<option value="customerno">Customer No</option>
            <option value="add1">Address 1</option>
            <option value="add2">Address 2</option>
            <option value="add3">Address 3</option>
            <option value="contact">Contact</option>
            <option value="icno">IC No</option>
        	<!--- <option value="phone">#URL.Type# Tel</option> --->
        </cfif>
      	</select>
      	Search for #getGsetup.lDRIVER# : 
      	<input type="text" name="searchStr" value="">
    </h1>
</form>
</cfoutput>			
<cfif getPersonnel.recordcount neq 0>
	<cfif isdefined("form.skeypage")>
		<cfset noOfPage=round(getPersonnel.recordcount/20)>
		
		<cfif getPersonnel.recordcount mod 20 LT 10 and getPersonnel.recordcount mod 20 neq 0>
			<cfset noOfPage = noOfPage + 1>
		</cfif>
		
		<cfif form.skeypage gt noofpage OR form.skeypage lt 1>
			<h3 align="center"><font color="##FF0000">Wrong page number! Please try again.</font></h3>
			<cfabort>
		</cfif>
	</cfif>
    </cfif>
	<cfform action="sdriver.cfm" method="post">
		<div align="right">Page <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">
		
		<cfset noOfPage=round(getPersonnel.recordcount/20)>
		
		<cfif getPersonnel.recordcount mod 20 LT 10 and getPersonnel.recordcount mod 20 neq 0>
			<cfset noOfPage = noOfPage+1>
		</cfif>
		
		<cfif isdefined("url.start")>
			<cfset start = url.start>
		</cfif>
		
		<cfif isdefined("form.skeypage")>				
			<cfset start = form.skeypage * 20 + 1 - 20>				
			
			<cfif form.skeypage eq "1">
				<cfset start = "1">					
			</cfif>  				
		</cfif> 

		<cfset prevtwenty = start -20>
		<cfset nexttwenty = start +20>
		<cfset page = round(nextTwenty/20)>
		
		<cfoutput>
			<cfif start neq 1>
				|| <a href="sdriver.cfm?start=#prevtwenty#">Previous</a> ||
			</cfif>
		
			<cfif page neq noOfPage>
				 <a href="sdriver.cfm?start=#evaluate(nexttwenty)#">Next</a> ||
			</cfif>
		
			Page #page# Of #noOfPage#
		</cfoutput>
	</div>
    </cfform>	


<cfif isdefined("url.process")>
	<h1><cfoutput>#form.status#</cfoutput></h1>
    <hr>
</cfif>
<cfquery datasource='#dts#' name="type">
	Select * from driver order by created_on desc
</cfquery>
		
<cfif isdefined("form.searchStr")>
	<cfquery datasource="#dts#" name="exactResult">
		Select * from driver where #form.searchType# = '#form.searchStr#' order by #form.searchType#
	</cfquery>
			
	<cfquery datasource="#dts#" name="similarResult">
		Select * from driver where #form.searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> order by #form.searchType#
	</cfquery>
			
	<h2>Exact Result</h2>
	<cfif exactResult.recordCount neq 0>
		<table align="center" class="data" width="600px">	
			<tr>	
				<th><cfoutput>#getGsetup.lDRIVER#</cfoutput></th>
				<th>Name</th>						
        		<th>Attn</th>
                <cfif lcase(HcomID) neq "polypet_i">
				<th><cfif lcase(HcomID) eq "iel_i" or lcase(HcomID) eq "ielm_i">Supplier<cfelse>Customer</cfif> No</th>				</cfif>
                <cfif lcase(HcomID) eq "polypet_i">
                <th>Address</th>				
                </cfif>
				<th>Contact</th>
                <th><cfif lcase(hcomid) eq "tcds_i">IC. No<cfelse>Remarks :</cfif></th>
                <cfif lcase(hcomid) eq "tcds_i">
                <th>Member Since</th>
                <th>Point Balance</th>
                </cfif>
				<cfif getpin2.h1C11 eq 'T'><th>Action</th></cfif>
			</tr>
			<cfoutput query="exactResult">
				<tr>
					<td>#exactResult.Driverno#</td>
					<td>#exactResult.name#</td>
					<td>#exactResult.attn#</td>
                    <cfif lcase(HcomID) neq "polypet_i">
					<td>#exactResult.customerno#</td>
                    </cfif>
                    <cfif lcase(HcomID) eq "polypet_i">
                    <td>#exactResult.add1# <br> #exactResult.add2# <br> #exactResult.add3#</td>
                    </cfif>
					<td>#exactResult.contact#</td>
                    <td>#exactResult.remarks#</td>
                    <cfif lcase(hcomid) eq "tcds_i">
                    <td>#dateformat(exactResult.created_on,'DD/MM/YYYY')#</td>
                    <td align="right">#val(exactResult.pointsbf)+val(exactResult.points)-val(exactResult.pointsredeem)#</td>
                    </cfif>
					<cfif getpin2.h1C11 eq 'T'>
          				<td width="10%" nowrap>
						<div align="center"><a href="driver.cfm?type=Delete&driverno=#exactResult.driverno#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;<a href="driver.cfm?type=Edit&driverno=#exactResult.driverno#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a></div></td>
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
			<th><cfoutput>#getGsetup.lDRIVER#</cfoutput></th>
			<th>Name</th>				
        	<th>Attn</th>
            <cfif lcase(HcomID) neq "polypet_i">
			<th><cfif lcase(HcomID) eq "iel_i" or lcase(HcomID) eq "ielm_i">Supplier<cfelse>Customer</cfif> No</th>	
            </cfif>				
            <cfif lcase(HcomID) eq "polypet_i">
                <th>Address</th>				
            </cfif>
                
			<th>Contact</th>
            <th><cfif lcase(hcomid) eq "tcds_i">IC. No<cfelse>Remarks :</cfif></th>
            <cfif lcase(hcomid) eq "tcds_i">
            <th>Member Since</th>
            <th>Point Balance</th>
            </cfif>
			<cfif getpin2.h1C11 eq 'T'><th>Action</th></cfif>
		</tr>
		<cfoutput query="similarResult">
			<tr>
				<td>#similarResult.driverno#</td>
				<td>#similarResult.name#</td>
				<td>#similarResult.attn#</td>
                <cfif lcase(HcomID) neq "polypet_i">
				<td>#similarResult.customerno#</td>
                </cfif>
                <cfif lcase(HcomID) eq "polypet_i">
                <td>#similarResult.add1# <br> #similarResult.add2# <br> #similarResult.add3#</td>
                </cfif>
				<td>#similarResult.contact#</td>
                <td>#similarResult.remarks#</td>
                <cfif lcase(hcomid) eq "tcds_i">
                <td>#dateformat(similarResult.created_on,'DD/MM/YYYY')#</td>
                <td align="right">#val(similarResult.pointsbf)+val(similarResult.points)-val(similarResult.pointsredeem)#</td>
                </cfif>
				<cfif getpin2.h1C11 eq 'T'>
          			<td width="10%" nowrap> 
            			<div align="center"><a href="driver.cfm?type=Delete&driverno=#similarResult.driverno#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;<a href="driver.cfm?type=Edit&driverno=#similarResult.driverno#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a>
                        
                        <a href="sdrivercommission.cfm?driverno=#similarResult.driverno#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Comm</a>
                        </div></td>
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
		
<fieldset><legend style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-style: italic;line-height: normal;font-weight: bold;text-transform: capitalize;color: #0066FF;">
	<cfoutput>20 Newest #getGsetup.lDRIVER#:</cfoutput></legend><br>
	<cfif #type.recordCount# neq 0>
		<table align="center" class="data" width="600px">	
			<tr>
				<th>No.</th>
				<th><cfoutput>#getGsetup.lDRIVER#</cfoutput></th>
				<th>Name</th>
				<th>Attn</th>
                <cfif lcase(HcomID) neq "polypet_i">
				<th><cfif lcase(HcomID) eq "iel_i" or lcase(HcomID) eq "ielm_i">Supplier<cfelse>Customer</cfif> No</th>				</cfif>
                <cfif lcase(HcomID) eq "polypet_i">
                <th>Address</th>				
            	</cfif>
				<th>Contact</th>
                <th><cfif lcase(hcomid) eq "tcds_i">IC. No<cfelse>Remarks :</cfif></th>
                <cfif lcase(hcomid) eq "tcds_i">
                <th>Member Since</th>
                <th>Point Balance</th>
                </cfif>
				<cfif getpin2.h1C11 eq 'T'><th>Action</th></cfif>
			</tr>
			<cfoutput query="type" startrow="#nextTwenty#" maxrows="20">
				<tr>
					<td>#i#</td>
					<td>#type.driverno#</td>
					<td>#type.name#</td>
					<td>#type.attn#</td>
                    <cfif lcase(HcomID) neq "polypet_i">
					<td>#type.customerno#</td>
                    </cfif>
                    <cfif lcase(HcomID) eq "polypet_i">
                    <td>#type.add1# <br> #type.add2# <br>#type.add3#</td>
                    </cfif>
					<td>#type.contact#</td>
                    <td>#type.remarks#</td>
                    <cfif lcase(hcomid) eq "tcds_i">
                    <td>#dateformat(type.created_on,'DD/MM/YYYY')#</td>
                    <td align="right">#val(type.pointsbf)+val(type.points)-val(type.pointsredeem)#</td>
                    </cfif>
					<cfif getpin2.h1C11 eq 'T'>
        				<td width="10%" nowrap> 
         				<div align="center"><a href="driver.cfm?type=Delete&driverno=#type.driverno#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;<a href="driver.cfm?type=Edit&driverno=#type.driverno#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a>
                        
                        <a href="sdrivercommission.cfm?driverno=#type.driverno#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Comm</a>
                        </div></td>
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
	<!--- <cfelse>
		<h1>URL Error. Please Click On The Correct Link.</h1>
	</cfif> --->	

</body>
</html>
