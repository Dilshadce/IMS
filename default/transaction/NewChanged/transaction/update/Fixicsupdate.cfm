<html>
<head>
<title>Update Main Page</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script src="/scripts/CalendarControl.js" language="javascript"></script>
</head>


<cfquery name="getmodule" datasource="#dts#">
    select * from modulecontrol
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
	select invoneset,rc_oneset,pr_oneset,do_oneset,cs_oneset,cn_oneset,dn_oneset,iss_oneset,poapproval,
	po_oneset,so_oneset, quo_oneset, assm_oneset, tr_oneset, oai_oneset, oar_oneset, sam_oneset,updatetopo,rem5
	from gsetup
</cfquery>

<cfquery datasource="#dts#" name="gettranname">
	Select lRC,lPR,lDO,lINV,lCS,lCN,lDN,lPO,lQUO,lSO,lSAM,lRQ

	from GSetup
</cfquery>

<body>

	<h1>Update to Tickets</h1>
	
	<cfif url.t1 eq "DO">
		<cfset type = gettranname.lDO>
	<cfelseif url.t1 eq "QUO">
		<cfset type = gettranname.lQUO>
	<cfelseif url.t1 eq "INV">
		<cfset type = gettranname.lINV>
	</cfif>

<cfoutput>
	<form action="update.cfm?t1=#URLEncodedFormat(t1)#" method="post">
		<h1>Search By :
		<select name="searchType">
        	<option value="all">All</option>
			<option value="custno">Customer No</option>
			<option value="name">Customer Name</option>
            <option value="source" >Project</option>
			<option value="rem5">#getgeneral.rem5#</option>
			<!--- <option value="wos_date">Invoice Date</option> --->
		</select>
		Search for
		<input type="text" name="searchStr" value="">
        <input type="submit" id="submit" name="submit" value="Search">
		</h1>
        
	</form>
</cfoutput>

<br>
This page will show all outstanding bills<br><hr>
<!--- t2 = "PO" and t1 = "SO" t2 = "PO" and t1 = "SO" t2 = "PO" and t1 = "SO" t2 = "PO" and t1 = "SO" t2 = "PO" and t1 = "SO" --->

	<cfquery datasource="#dts#" name="getupdate">
		Select lower(refno) as refno, lower(custno) as custno, lower(name) as name, userid,refno,source,lower(rem5) as rem5,permitno from artran where type = '#t1#'
		<!---and ticket = ''---> and (toinv='' or toinv is null) and (void = '' or void is null) group by custno order by custno
	</cfquery>

<cfif isdefined("form.searchStr")>
	<cfquery dbtype="query" name="exactResult">
		Select * from getupdate where <cfif searchType eq 'all'>custno='#LCASE(form.searchStr)#' or name='#LCASE(form.searchStr)#' or permitno='#LCASE(form.searchStr)#' or refno='#LCASE(form.searchStr)#' or rem5='#LCASE(form.searchStr)#' order by custno<cfelse>#form.searchType# = '#LCASE(form.searchStr)#' order by #form.searchType#</cfif>
	</cfquery>

	<cfquery dbtype="query" name="similarResult">
		Select * from getupdate where <cfif searchType eq 'all'>custno LIKE '%#LCASE(form.searchStr)#%' or name LIKE '%#LCASE(form.searchStr)#%' or permitno LIKE '%#LCASE(form.searchStr)#%' or rem5 LIKE '%#LCASE(form.searchStr)#%' or refno LIKE '%#LCASE(form.searchStr)#%' order by custno<cfelse>#form.searchType# LIKE '%#LCASE(form.searchStr)#%' order by #form.searchType#</cfif>
	</cfquery>

	<h2>Exact Result</h2>

	<cfif exactResult.recordCount neq 0>
		<table align="center" class="data" width="70%">
			<tr>
				<td colspan="6"><div align="center"><strong><cfoutput>#type#</cfoutput></strong></div></td>
			</tr>
			<tr>
				<th>Reference No</th>
				<th>Customer Name</th>
                
				<th>Curr.Code</th>
				<th>User</th>
				<th>Action</th>
			</tr>

			<cfoutput query="exactresult">
					<cfquery name="getcust" datasource="#dts#">
						select name,currcode from #target_apvend# where custno = '#custno#'
					</cfquery>
				

				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td>#ucase(exactresult.refno)#</td>
					<td nowrap><cfif url.t2 eq "INV" and url.t1 eq "SO" and lcase(hcomid) eq "atc2005_i">#exactresult.rem5#<cfelse>#exactresult.custno# - #getcust.name#</cfif></td>
                    
					<td>#getcust.currcode#</td>
					<td>#exactresult.userid#</td>

					
                    <td><a href="Fixicsupdate2.cfm?t1=#URLEncodedFormat(t1)#&refno=#URLEncodedFormat(exactresult.refno)#">Update</a></td>
                    
				</tr>
			</cfoutput>
		</table>
		<hr>
	<cfelse>
		<h3>No Exact Records were found.</h3>
	</cfif>

	<h2>Similar Result</h2>

	<cfif similarResult.recordCount neq 0>
		<table align="center" class="data" width="70%">
			<tr>
  			  	<td colspan="6"><div align="center"><strong><cfoutput>#type#</cfoutput></strong></div></td>
 			</tr>
 			<tr>
 			   	<th>Reference No</th>
				<th>Customer Name</th>
                
			   	<th>Curr.Code</th>
 			   	<th>User</th>
 			   	<th>Action</th>
			</tr>

			<cfoutput query="similarResult">
  				
					<cfquery name="getcust" datasource="#dts#">
						select name,currcode from #target_apvend# where custno = '#custno#'
					</cfquery>

				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    			  	<td>#ucase(similarResult.refno)#</td>
    			  	<td nowrap>#similarResult.custno# - #getcust.name#</td>
                    
				  	<td>#getcust.currcode#</td>
    			  	<td>#similarResult.userid#</td>

                    <td><a href="Fixicsupdate2.cfm?t1=#URLEncodedFormat(t1)#&refno=#URLEncodedFormat(similarResult.refno)#">Update</a></td>
                  
				</tr>
			</cfoutput>
		</table>
		<hr>
	<cfelse>
		<h3>No Similar Records were found.</h3>
	</cfif>
</cfif>

<table align="center" class="data" width="70%">
	<tr>
    	<td colspan="6"><div align="center"><strong><cfoutput>#type#</cfoutput></strong></div></td>
  	</tr>
  	<tr>
    	<th>Reference No</th>
		<th>Customer Name</th>
		<th>Curr.Code</th>
    	<th>User</th>
    	<th>Action</th>
  	</tr>

	<cfoutput query="getupdate" startrow="1">
			<cfquery name="getcust" datasource="#dts#">
				select name,currcode from #target_arcust# where custno = '#custno#'
			</cfquery>

		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
      		<td>#ucase(getupdate.refno)#</td>
      		<td nowrap>#getupdate.custno# - #getcust.name#</td>
           
	  		<td>#getcust.currcode#</td>
      		<td>#getupdate.userid#</td>
			
           
                    <td><a href="Fixicsupdate2.cfm?t1=#URLEncodedFormat(t1)#&refno=#URLEncodedFormat(getupdate.refno)#">Update</a></td>
          
		</tr>
	</cfoutput>
</table>

</body>
</html>