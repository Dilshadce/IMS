<cfajaximport tags="cfform,cftooltip">
<cfajaximport tags="cfwindow,cflayout-tab">
<html>
<head>
<title>Search Repair Service</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
    
    <script language="javascript" type="text/javascript">
	function PopupCenter(pageURL, title,w,h) {
		var left = (screen.width/2)-(w/2);
		var top = (screen.height/2)-(h/2);
		var targetWin = window.open (pageURL, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
	} 
	
	</script>
    
</head>

<body>
<h1>Repair Service Selection Page</h1>

<cfoutput>
	<h4>
	<a href="createrepairservicetable.cfm?type=Create">Creating A New Repair Transaction</a>
	|| <a href="repairservicetable.cfm">List All Repair Transaction</a>
	|| <a href="s_repairservicetable.cfm?type=Repair">Search For Repair Transaction</a>
    || <a href="p_repairservice.cfm">Repair Transaction Listing</a>
	</h4>

    <form action="s_repairservicetable.cfm" method="post">
		<h1>Search By :
        <select name="searchType">
			<option value="repairno">Repair No</option>
	      	<option value="Desp">Description</option>
	    </select>
      	Search for Repair Service : 
      	<input type="text" name="searchStr" value="" size="40">
	  	</h1>
	</form>
	
	<cfif isdefined("url.process")>
		<h1>#form.status#</h1><hr>
  	</cfif>
	
  	<cfquery datasource='#dts#' name="type">
		select * from repairtran order by wos_date desc
  	</cfquery>
		
  	<cfif isdefined("form.searchStr")>
  		<cfquery datasource="#dts#" name="exactResult">
    		select * from repairtran where #form.searchType# = '#form.searchStr#' order by #form.searchType#
		</cfquery>
			
  		<cfquery datasource="#dts#" name="similarResult">
    		select * from repairtran where #form.searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> order by #form.searchType#
		</cfquery>
			
		<h2>Exact Result</h2>
		<cfif exactResult.recordCount neq 0>
		
		<table align="center" class="data" width="50%">
      		<tr> 
        		<th>Service</th>
        		<th>Customer</th>
                
                <cfloop query="exactResult"> 
                <cfquery datasource="#dts#" name="checkrccreated">
                select refno from artran where type='RC' and refno='#exactResult.repairno#'
                </cfquery>
                <cfquery datasource="#dts#" name="checkdocreated">
                select refno from artran where type='DO' and refno='#exactResult.repairno#'
                </cfquery>
                
                <th>Status</th>
					<th width="10%">Action</th>
      		</tr>
      		
            
        	<tr> 
          		<td>#exactResult.repairno#</td>
          		<td>#exactResult.custno# #exactResult.name#</td>
                <td>
                <cfif checkrccreated.recordcount eq 0>
                    <a href="createrepairRC.cfm?repairno=#exactResult.repairno#" target="_blank">
					<img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#exactResult.status#</a> 
                <cfelseif checkDOcreated.recordcount eq 0 and checkrccreated.recordcount neq 0 and exactResult.status eq 'Repair'>
                    <a href="repairservicetable2.cfm?repairno=#exactResult.repairno#" target="_blank">
					<img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#exactResult.status#</a> 
            	<cfelseif checkDOcreated.recordcount eq 0 and checkrccreated.recordcount neq 0 and exactResult.status eq 'Delivery'>
                    <a href="javascript:void(0)" onClick="PopupCenter('createrepairDO.cfm?repairno=#exactResult.repairno#','linkname','800','600');">
                    
                    
					<img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#exactResult.status#</a> 
            	<cfelse> 
                <img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#exactResult.status#
                
                </cfif>
                
                </td>
          		<cfif getpin2.h1F11 eq 'T'>
				<td nowrap> 
            		<div align="center">
                    <a href="printrepair.cfm?repairno=#exactResult.repairno#" target="_blank">
					Print PDF</a>&nbsp; 
                    <a href="processprint.cfm?repairno=#exactResult.repairno#" target="_blank">
					Print</a>&nbsp; 
					&nbsp;
                    <cfif exactResult.status neq 'Done'>
                    <a href="repairservicetable2.cfm?repairno=#exactResult.repairno#" target="_blank">
                    <img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">
                    Edit
                    </a>
                    </cfif>
                    <a href="createrepairservicetable.cfm?type=Delete&repairno=#exactResult.repairno#">
                    &nbsp;
                    <img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 				
					
                    </div>
				</td>
				</cfif>
        	</tr>
      		</cfloop> 
    	</table>
	<cfelse>
	  	<h3>No Exact Records were found.</h3>
    </cfif>
			
    <h2>Similar Result</h2>
    <cfif similarResult.recordCount neq 0>
    		<cfquery datasource="#dts#" name="checkrccreated2">
            select refno from artran where type='RC' and refno='#similarResult.repairno#'
            </cfquery>
            <cfquery datasource="#dts#" name="checkdocreated2">
            select refno from artran where type='DO' and refno='#similarResult.repairno#'
            </cfquery>
    
      	<table align="center" class="data" width="50%">					
	    	<tr>
	      		<th>Service</th>
        		<th>Customer</th>
                <th>Status</th>
				<th width="10%">Action</th>
	    	</tr>
	
	   		<cfloop query="similarResult">
	      	<tr> 
          		<td>#similarResult.repairno#</td>
          		<td>#similarResult.custno# #similarResult.name#</td>
                <td>
                <cfif checkrccreated2.recordcount eq 0>
                    <a href="createrepairRC.cfm?repairno=#similarResult.repairno#" target="_blank">
					<img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#similarResult.status#</a> 
                <cfelseif checkDOcreated2.recordcount eq 0 and checkrccreated2.recordcount neq 0 and similarResult.status eq 'Repair'>
                    <a href="repairservicetable2.cfm?repairno=#similarResult.repairno#" target="_blank">
					<img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#similarResult.status#</a> 
            	<cfelseif checkDOcreated2.recordcount eq 0 and checkrccreated2.recordcount neq 0 and similarResult.status eq 'Delivery'>
                    <a href="javascript:void(0)" onClick="PopupCenter('createrepairDO.cfm?repairno=#similarResult.repairno#','linkname','800','600');">
					<img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#similarResult.status#</a> 
                <cfelse> 
                <img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#similarResult.status#
                </cfif>
                
                </td>
          		<cfif getpin2.h1F11 eq 'T'>
				<td nowrap> 
            		<div align="center">
                     <a href="printrepair.cfm?repairno=#similarResult.repairno#" target="_blank">
					Print PDF</a>&nbsp;
                    <a href="processprint.cfm?repairno=#similarResult.repairno#" target="_blank">
					Print</a>&nbsp; 
                    <cfif similarResult.status neq 'Done'>
                    <a href="repairservicetable2.cfm?repairno=#similarResult.repairno#" target="_blank">
                    <img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">
                    Edit
                    </a>
                    </cfif>
                    &nbsp; 
					<a href="createrepairservicetable.cfm?type=Delete&repairno=#similarResult.repairno#">
					<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 
                    
                    </div>
				</td>
				</cfif>
        	</tr>
	    	</cfloop>
      	</table>
    <cfelse>
	  	<h3>No Similar Records were found.</h3>
    </cfif>
</cfif>
</cfoutput>
<hr><fieldset>
<legend style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-style: italic;line-height: normal;font-weight: bold;text-transform: capitalize;color: #0066FF;">
20 Newest Address:
</legend><br>


<cfif type.recordCount neq 0>
  	<table align="center" class="data" width="50%">
    	<tr> 
      		<th>No.</th>
      		<th>Repair Service</th>
      		<th>Customer</th>
            <th>Status</th>
			<th width="10%">Action</th>
    	</tr>
    	<cfoutput query="type" maxrows="50"> 
        <cfquery datasource="#dts#" name="checkrccreated3">
            select refno from artran where type='RC' and refno='#type.repairno#'
            </cfquery>
            <cfquery datasource="#dts#" name="checkdocreated3">
            select refno from artran where type='DO' and refno='#type.repairno#'
            </cfquery>
      	<tr> 
        	<td width="5%">#type.currentrow#</td>
        	<td>#type.repairno#</td>
        	<td nowrap>#type.custno# #type.name#</td>
            <td>
            <cfif checkrccreated3.recordcount eq 0>
                    <a href="createrepairRC.cfm?repairno=#type.repairno#" target="_blank">
					<img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#type.status#</a> 
            <cfelseif checkDOcreated3.recordcount eq 0 and checkrccreated3.recordcount neq 0 and type.status eq 'Repair'>
                    <a href="repairservicetable2.cfm?repairno=#type.repairno#" target="_blank">
					<img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#type.status#</a> 
            	<cfelseif checkDOcreated3.recordcount eq 0 and checkrccreated3.recordcount neq 0 and type.status eq 'Delivery'>
                    <a href="javascript:void(0)" onClick="PopupCenter('createrepairDO.cfm?repairno=#type.repairno#','linkname','800','600');">
					<img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#type.status#</a>
               	<cfelse> 
                <img height="18px" width="18px" src="/images/create.png" alt="Edit" border="0">#type.status#
            </cfif>
            </td>
			<cfif getpin2.h1F11 eq 'T'>
				<td nowrap><div align="center">
                	<a href="printrepair.cfm?repairno=#type.repairno#" target="_blank">
					Print PDF</a>&nbsp; 
                	<a href="processprint.cfm?repairno=#type.repairno#" target="_blank">
					Print</a>&nbsp; 
                    <cfif type.status neq 'Done'>
                    <a href="repairservicetable2.cfm?repairno=#type.repairno#" target="_blank">
                    <img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">
                    Edit
                    </a>
                    </cfif>
                    &nbsp; 
                    
					<a href="createrepairservicetable.cfm?type=Delete&repairno=#type.repairno#">
					<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp; 

                    </div> 
				</td>
			</cfif>
      	</tr>
    	</cfoutput>
	</table>
<cfelse>
  	<h3>No Records were found.</h3>
</cfif>
<br>
</fieldset>
</body>
</html>