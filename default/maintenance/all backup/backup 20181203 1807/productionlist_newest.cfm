<html>
<head>
<title>Search Items</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getdealermenu" datasource="#dts#">
    select * from dealer_menu
</cfquery>

<cfquery name="getdisplaysetup" datasource="#dts#">
    select * from displaysetup
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select concat(',.',(repeat('_',decl_uprice))) as decl_uprice 
	from gsetup2
</cfquery>

<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevTwenty" default="0">
<cfparam name="nextTwenty" default="0">

<cfquery name="getrecordcount" datasource="#dts#">
	select count(itemno) as totalrecord 
	from icitem 
    <cfif Hitemgroup neq ''>
            where wos_group='#Hitemgroup#'
            </cfif>
	order by wos_date
</cfquery>

<cfquery name="getproduction" datasource="#dts#">
select * from productplanning
</cfquery> 
<body>
<cfoutput>
	
  <h4><cfif getpin2.h1J10 eq 'T'><a href="bom.cfm">Create B.O.M</a> </cfif><cfif getpin2.h1J20 eq 'T'>|| <a href="vbom.cfm">List B.O.M</a> </cfif><cfif getpin2.h1J30 eq 'T'>|| <a href="bom.cfm">Search B.O.M</a> </cfif><cfif getpin2.h1J40 eq 'T'>|| <a href="genbomcost.cfm">Generate 
    Cost</a> </cfif><cfif getpin2.h1J50 eq 'T'>|| <a href="checkmaterial.cfm">Check Material</a> </cfif><cfif getpin2.h1J60 eq 'T'>|| <a href="useinwhere.cfm">Use In Where</a> || <a href="bominforecast.cfm">Bom Item Forecast by SO</a></cfif>|| <a href="createproduction.cfm?type=Create">Create Production Planning</a>|| <a href="productionlist_newest.cfm?refno=sono">Production Planning List</a></h4>

	<cfform action="sicitem_newest.cfm" method="post" target="_self">
		<!---<div align="right">Page <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">
		
		<cfset noOfPage = round(getrecordcount.totalrecord/20)>
		
		<cfif getrecordcount.totalrecord mod 20 LT 10 and getrecordcount.totalrecord mod 20 neq 0>
			<cfset noOfPage = noOfPage + 1>
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

		<cfset prevTwenty = start -20>
		<cfset nextTwenty = start +20>
		<cfset page = round(nextTwenty/20)>
		
		<cfquery datasource='#dts#' name="getjob">
			select a.*,m.desp as mdesp
			from icitem a
			left join iccolorid m on (a.colorid=m.colorid)
            <cfif Hitemgroup neq ''>
            where a.wos_group='#Hitemgroup#'
            </cfif>
			order by a.itemno
			limit #start-1#,20;
		</cfquery>

		<cfif start neq 1>
			|| <a target="_self" href="sicitem_newest.cfm?start=#prevTwenty#">Previous</a> ||
		</cfif>
		
		<cfif page neq noOfPage>
			<a target="_self" href="sicitem_newest.cfm?start=#nextTwenty#">Next</a> ||
		</cfif>

		Page #page# Of #noOfPage#
		</div>--->
		<hr>
		<table align="center" class="data" width="100%">
      		<tr>
            	<th>Item No</th> 
                <th>Period</th> 
                <th>Action</th>
      		</tr>
      		
			<cfloop query="getproduction"> 
        		<tr>
                	<td nowrap>#getproduction.itemno#</td>
                    <td nowrap>#getproduction.fperiod# - #dateformat(dateadd('m',getproduction.fperiod,getgsetup.lastaccyear),"mmm yy")#</td>
					
						<td nowrap><div align="center">
							<a href="productlist.cfm?type=Delete&itemno=#urlencodedformat(getproduction.itemno)#&period=#getproduction.fperiod#" target="_blank"><img height="18px" width="18px" src="../../images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
              				<a href="productlist.cfm?type=Edit&itemno=#urlencodedformat(getproduction.itemno)#&period=#getproduction.fperiod#" target="_blank"><img height="18px" width="18px" src="../../images/edit.ICO" alt="Edit" border="0">Edit</a>
						</td>
        		</tr>
      		</cfloop> 
    	</table>
		<hr>
		
	</cfform>

</cfoutput>
</body>
</html>