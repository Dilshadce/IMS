
<cfquery datasource='#dts#' name="getgeneral">
	Select lcategory as layer from gsetup
</cfquery>
<html>
<head>
<title>View <cfoutput>#getgeneral.layer#</cfoutput></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

</head>

<body>
<!--- <cfif isdefined("url.type")> --->
<!--- <cfset typeNo="itemno"> 
			<cfset link = #url.type# &".cfm"> --->
<cfquery datasource='#dts#' name="getPersonnel">
	Select * from iccate order by cate
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
select * from gsetup
</cfquery>

			<!--- <cfset type = #url.type#> --->
<!--- <cfelse> --->
			<!--- <cfset typeNo=#type# & "No"> 
			<cfset link = #type# &".cfm">
 --->
			<!--- <cfquery datasource='#dts#' name="getPersonnel">
				Select * from icitem order by itemno
			</cfquery> --->
						
<!--- </cfif> --->
			
			
			<cfparam name="start" default="1">
			<cfparam name="page" default="1">
			<cfparam name="prevFive" default="0">
			<cfparam name="nextFive" default="0">
			<cfoutput>
  <h1>View #getgeneral.layer# Informations</h1>
</cfoutput>
			<cfoutput>
  <h4><cfif getpin2.h1410 eq 'T'><a href="categorytable2.cfm?type=Create">Creating a New #getgeneral.layer#</a> </cfif><cfif getpin2.h1420 eq 'T'>|| 
    <a href="categorytable.cfm">List all #getgeneral.layer#</a> </cfif><cfif getpin2.h1430 eq 'T'>|| <a href="s_categorytable.cfm?type=Iccate">Search 
    For #getgeneral.layer#</a></cfif>
    
    <cfif getpin2.h1430 eq 'T'>|| <a href="p_category.cfm">#getgeneral.layer# Listing</a></cfif>
    </h4>
</cfoutput><cfif #getPersonnel.recordcount# neq 0>
				<cfif isdefined("form.skeypage")>
  					<cfset noOfPage=round(#getPersonnel.recordcount#/5)>
					<cfif #getPersonnel.recordcount# mod 5 LT 3 and #getPersonnel.recordcount# mod 5 neq 0>
						<cfset noOfPage=#noOfPage#+1>
					</cfif>
					<cfif form.skeypage gt noofpage OR form.skeypage lt 1>
						<h3 align="center"><font color="#FF0000">Wrong page number! Please try again.</font></h3>
						<cfabort>
					</cfif>
 				</cfif>
				<cfform action="categorytable.cfm" method="post">
				<div align="right">Page <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">
				
			
			<cfset noOfPage=round(#getPersonnel.recordcount#/5)>
			
			<cfif #getPersonnel.recordcount# mod 5 LT 3 and #getPersonnel.recordcount# mod 5 neq 0>
				<cfset noOfPage=#noOfPage#+1>
			</cfif>
			
			<cfif isdefined("url.start")>
				<cfset start=#url.start#>
			</cfif>
			<cfif isdefined("form.skeypage")>				
				<cfset start = #form.skeypage# * 5 + 1 - 5>				
				<cfif form.skeypage eq "1">
					<cfset start = "1">					
				</cfif>  				
			</cfif> 
			
				<cfset prevFive=#start# -5>
				<cfset nextFive=#start# +5>
				<cfset page=round(#nextFive#/5)>
			
						
				<cfif #start# neq 1>
					<cfoutput>|| <a href="categorytable.cfm?start=#prevFive#">Previous</a> ||</cfoutput>
				</cfif>
				
			    <cfif #page# neq #noOfPage#>
					<cfoutput> <a href="categorytable.cfm?start=#evaluate(nextFive)#">Next</a> ||</cfoutput>
				</cfif>
				
				<cfoutput>Page #page# Of #noOfPage#</cfoutput>
			</div>
			
			<hr>
			
			<cfif isdefined("url.process")>
				<cfoutput><h1>#form.status#</h1><hr></cfoutput>
			</cfif>
			
			
				<cfoutput query="getPersonnel" startrow="#start#" maxrows="5">
				<cfset strNo = "getPersonnel.cate"> 
				
      <table align="center" class="data" width="450px">
        <!--- <tr> 
          <th width="20%">No</th>
          <td>#evaluate(strNo)#</td>
        </tr> --->
        <tr> 
          <th width="20%">#getgeneral.layer#</th>
          <td>#getPersonnel.cate#</td>
        </tr>
        <tr> 
          <th>Description</th>
          <td>#getPersonnel.desp#<br></td>
        </tr>
        <cfif getpin2.h1411 eq 'T'><tr> 
          <td colspan="2"><div align="right"><a href="categorytable2.cfm?type=Delete&CATE=#URLEncodedFormat(evaluate(strNo))#"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0"> 
              Delete</a> <a href="categorytable2.cfm?type=Edit&CATE=#URLEncodedFormat(evaluate(strNo))#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a></div></td>
        </tr>
		</cfif>
      </table>
							
				<br>
				<hr>
				
				</cfoutput>
				</cfform>
				<div align="right">
			
				<cfif #start# neq 1>
					<cfoutput>|| <a href="categorytable.cfm?start=#prevFive#">Previous</a> ||</cfoutput>
				</cfif>
				
			    <cfif #page# neq #noOfPage#>
					<cfoutput> <a href="categorytable.cfm?start=#evaluate(nextFive)#">Next</a> ||</cfoutput>
				</cfif>
				
				<cfoutput>Page #page# Of #noOfPage#</cfoutput>
				</div>
			
				<hr>
				<cfelse>
					<h3>Sorry, No records were found.</h3>
				</cfif>			
</body>
</html>
