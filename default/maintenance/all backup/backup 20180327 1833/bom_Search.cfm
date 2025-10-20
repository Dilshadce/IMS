<html>
<head>
<title>Search B.O.M</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    <script type="text/javascript" src="/scripts/prototypenew.js" ></script>

</head>
<cfquery datasource='#dts#' name="getgeneral">
	SELECT lgroup AS layer ,ldescription 
    FROM gsetup;
</cfquery>
<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevtwenty" default="0">
<cfparam name="nexttwenty" default="0">
<cfquery datasource='#dts#' name="getBOM">
	SELECT * FROM billmat 
    GROUP BY itemno,bomno
    ORDER BY itemno,bomno;
</cfquery>

<script language="javascript" type="text/javascript">
function deletebomno(itemno,bomno){
	var r=confirm("Confirm Delete Bomno");
if (r==true){
	var updateurl = '/default/maintenance/deletebom.cfm?itemno='+escape(itemno)+'&bomno='+escape(bomno);
		new Ajax.Request(updateurl,
      {
        method:'get',
        onSuccess: function(getdetailback){
		document.getElementById('ajaxFieldPro').innerHTML = trim(getdetailback.responseText);
        },
        onFailure: function(){ 
		alert('Error Delete Bom'); },		
		
		onComplete: function(transport){
		alert('Bom has been deleted');
		window.location.href='/default/maintenance/bom_Search.cfm';
        }
      })
	
}

}

</script>


<body>
	
<h1>B.O.M Selection Page</h1>		
<cfoutput>
  <h4>
    <cfif getpin2.h1J10 eq 'T'>
      <a href="bom.cfm">Create B.O.M</a>
    </cfif>
    <cfif getpin2.h1J20 eq 'T'>
      || <a href="vbom.cfm">List B.O.M</a>
    </cfif>
    <cfif getpin2.h1J30 eq 'T'>
      || <a href="bom.cfm">Search B.O.M</a>
    </cfif>
    <cfif getpin2.h1J40 eq 'T'>
      || <a href="genbomcost.cfm">Generate 
      Cost</a>
    </cfif>
    <cfif getpin2.h1J50 eq 'T'>
      || <a href="checkmaterial.cfm">Check Material</a>
    </cfif>
    <cfif getpin2.h1J60 eq 'T'>
      || <a href="useinwhere.cfm">Use In Where</a> || <a href="bominforecast.cfm">Bom Item Forecast by SO</a>
    </cfif>
    || <a href="createproduction.cfm?type=Create">Create Production Planning</a>|| <a href="productionlist_newest.cfm?refno=sono">Production Planning List</a></h4>
</cfoutput> 
		
<cfoutput>
<form action="bom_Search.cfm" method="post"></cfoutput>
	<cfoutput>
	<h1>Search By :
	
	<select name="searchType">
		<option value="itemno">Item No</option>
	</select>
Search for B.O.M : 
<input type="text" name="searchStr" value=""> </h1>
	</cfoutput>
</form>

<cfif getBOM.recordcount neq 0>
	<cfif isdefined("form.skeypage")>
		<cfset noOfPage=round(getBOM.recordcount/20)>

		<cfif getBOM.recordcount mod 20 LT 10 and getBOM.recordcount mod 20 neq 0>
			<cfset noOfPage = noOfPage + 1>
		</cfif>
		
		<cfif form.skeypage gt noofpage OR form.skeypage lt 1>
			<h3 align="center"><font color="#FF0000">Wrong page number! Please try again.</font></h3>
			<cfabort>
		</cfif>
	</cfif>
    </cfif>
	<cfform action="bom_Search.cfm" method="post">
		<div align="right">Page <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">
		
		<cfset noOfPage=round(getBOM.recordcount/20)>
		
		<cfif getBOM.recordcount mod 20 LT 10 and getBOM.recordcount mod 20 neq 0>
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
				|| <a href="bom_Search.cfm?start=#prevtwenty#">Previous</a> ||
			</cfif>
		
			<cfif page neq noOfPage>
				 <a href="bom_Search.cfm?start=#evaluate(nexttwenty)#">Next</a> ||
			</cfif>
		
			Page #page# Of #noOfPage#
		</cfoutput>
	</div>
    </cfform>	

<cfif isdefined("url.process")>
		<cfoutput><h1>#form.status#</h1><hr></cfoutput>
</cfif>

<cfquery datasource='#dts#' name="type">
	SELECT * FROM billmat 
    GROUP BY itemno,bomno
    ORDER BY itemno, bomno
    LIMIT #start-1#,20;
</cfquery>

<cfif isdefined("form.searchStr")>
	<cfquery datasource='#dts#' name="exactResult">
		SELECT * FROM billmat
        WHERE #form.searchType# = '#form.searchStr#' 
        GROUP BY itemno,bomno
        ORDER BY itemno,bomno
        LIMIT #start-1#,20;
	</cfquery>
	
	<cfquery datasource='#dts#' name="similarResult">
		SELECT * FROM billmat
        WHERE #form.searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> 
        GROUP BY itemno,bomno
        ORDER BY itemno,bomno
        LIMIT #start-1#,20;
	</cfquery>
	<div id="ajaxFieldPro"></div>
	<h2>Exact Result</h2>
	<cfif #exactResult.recordCount# neq 0>
	
		<table align="center" class="data" width="600px">
		  <tr> 
			<cfoutput><th>Item No</th></cfoutput>
			<cfoutput>
			  <th>B.O.M No</th></cfoutput>
			<cfif getpin2.h1511 eq 'T'><th>Action</th></cfif>
		  </tr>
		  <cfoutput query="exactResult"> 
			<tr> 
			  <td>#exactResult.itemno#</a></td>
			  <td>#exactResult.bomno#</td>
			  <td width="20%" nowrap><div align="center">
               	  <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('copybomfunction.cfm?itemno=#urlencodedformat(exactResult.itemno)#&bomno=#urlencodedformat(exactResult.bomno)#');"><img height="18px" width="18px" src="/images/Copy Icon.jpg" alt="Copy" border="0">Copy</a>
              	  &nbsp;&nbsp;
				  <a href="bom.cfm?type=Edit&itemno=#urlencodedformat(exactResult.itemno)#&bomno=#urlencodedformat(exactResult.bomno)#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a>
                  &nbsp;&nbsp;
                  <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="deletebomno('#exactResult.itemno#','#exactResult.bomno#')"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Edit" border="0">Delete</a>
                  </div></td>
			</tr>
		  </cfoutput> 
		</table>
	<cfelse>
	<h3>No Exact Records were found.</h3>
	</cfif>
	
	<h2>Similar Result</h2>
	<cfif #similarResult.recordCount# neq 0>
			
    <table align="center" class="data" width="600px">
      <tr> 
        <cfoutput>
          <th>Item No</th></cfoutput>
        <cfoutput>
          <th>B.O.M No</th></cfoutput>
		<cfif getpin2.h1511 eq 'T'><th>Action</th></cfif>
      </tr>
      <cfoutput query="similarResult"> 
        <tr> 
          <td>#similarResult.itemno#</a></td>
          <td>#similarResult.bomno#</td>
          <td width="20%" nowrap><div align="center">
          	  <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('copybomfunction.cfm?itemno=#urlencodedformat(itemno)#&bomno=#urlencodedformat(bomno)#');"><img height="18px" width="18px" src="/images/Copy Icon.jpg" alt="Copy" border="0">Copy</a>
              	  &nbsp;&nbsp;
              <a href="bom.cfm?type=Edit&itemno=#urlencodedformat(similarResult.itemno)#&bomno=#urlencodedformat(similarResult.bomno)#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a>
              &nbsp;&nbsp;
                  <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="deletebomno('#similarResult.itemno#','#similarResult.bomno#')"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Edit" border="0">Delete</a>
              </div></td>
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
		<cfoutput>20 Newest B.O.M :</cfoutput></legend>
		<br>
		<cfif #type.recordCount# neq 0>
  		<cfelse>
			<h3>No Records were found.</h3>
		</cfif>
		<br>

<table align="center" class="data" width="600px">
  <tr> 
    <th>No</th>
    <cfoutput>
      <th>Item No</th>
     
    <th>B.O.M No</th>
    
    </cfoutput>
    <cfif getpin2.h1511 eq 'T'><th>Action</th></cfif>
  </tr>
  <cfoutput query="type" maxrows="20"> 
    <tr> 
      <td>#i#</td>
      <td>#type.itemno#</td>
      <td>#type.bomno#</td>
     <td width="20%" nowrap><div align="center">
     	  <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="window.open('copybomfunction.cfm?itemno=#urlencodedformat(itemno)#&bomno=#urlencodedformat(bomno)#');"><img height="18px" width="18px" src="/images/Copy Icon.jpg" alt="Copy" border="0">Copy</a>
          &nbsp;&nbsp;
          <a href="bom.cfm?type=Edit&itemno=#urlencodedformat(type.itemno)#&bomno=#urlencodedformat(type.bomno)#"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a>
          &nbsp;&nbsp;
                  <a onMouseOver="JavaScript:this.style.cursor='hand';" onClick="deletebomno('#type.itemno#','#type.bomno#')"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Edit" border="0">Delete</a>
          </div></td>
    </tr>
    <cfset i = incrementvalue(#i#)>
  </cfoutput> 
</table>
<br>
</fieldset>
</body>
</html>
