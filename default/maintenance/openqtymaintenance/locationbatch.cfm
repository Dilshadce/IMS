<cfquery name="getgsetup" datasource="#dts#">
    select lbatch from gsetup
</cfquery>
<html>
<head>
<title>Edit Location - Item Batch Opening Quantity</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevTwenty" default="0">
<cfparam name="nextTwenty" default="0">

<cfquery name="getrecordcount" datasource="#dts#">
	select count(batchcode) as totalrecord 
	from lobthob 
	order by batchcode
</cfquery>


</head>
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>
<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<cfoutput>
<cfif isdefined("form.selectlocation") and form.selectlocation eq "Search">
	<form action="locationsearch.cfm" name="done" method="post">
		<input type="hidden" name="batchcode" value="#batchcode#">
		<input type="hidden" name="items" value="#items#">
		<input type="hidden" name="qtybf" value="#qtybf#">
		<input type="hidden" name="type" value="#type#">
		<input type="hidden" name="refno" value="#refno#">
		<input type="hidden" name="expdate" value="#expdate#">
        <cfif checkcustom.customcompany eq "Y">
            <input type="hidden" name="permit_no" value="#permit_no#">
            <input type="hidden" name="permit_no2" value="#permit_no2#">
        </cfif>
	</form>
	<script language="javascript" type="text/javascript">
		done.submit()
	</script>
<cfelseif isdefined("form.searchitem") and form.searchitem eq "Search">
	<form action="itemsearch.cfm" name="done" method="post">
		<input type="hidden" name="batchcode" value="#batchcode#">
		<input type="hidden" name="location" value="#location#">
		<input type="hidden" name="qtybf" value="#qtybf#">
		<input type="hidden" name="type" value="#type#">
		<input type="hidden" name="refno" value="#refno#">
		<input type="hidden" name="expdate" value="#expdate#">
        <cfif checkcustom.customcompany eq "Y">
            <input type="hidden" name="permit_no" value="#permit_no#">
            <input type="hidden" name="permit_no2" value="#permit_no2#">
        </cfif>
	</form>
	<script language="javascript" type="text/javascript">
		done.submit();
	</script>
</cfif>
</cfoutput>

<body>

<h4>
<a href="editlocationbatch.cfm?type=Create">Creating a New Location <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput></cfif> Opening Qty</a>
</h4>

<h1 align="center">Location - Item <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput></cfif> Opening Quantity</h1>

<cfif isdefined("url.type") and url.type eq "delete">
	<cfquery name="deletebatch" datasource="#dts#">
		delete from lobthob 
		where location='#url.location#' and batchcode='#url.batchcode#' and itemno='#url.itemno#';
	</cfquery>

<cfelseif isdefined("url.type") and url.type eq "edit">
	<cfquery name="editbatch" datasource="#dts#">
		update lobthob set 
        bth_qob='#form.qtybf#',
        type='#form.type#',
		refno='#form.refno#',
        pallet='#val(form.pallet)#',
        importpermit='#form.importpermit#',
        countryoforigin='#form.countryoforigin#',
        milcert='#form.milcert#'
        ,remark1='#form.remark1#'
        ,remark2='#form.remark2#'
        ,remark3='#form.remark3#'
        ,remark4='#form.remark4#'
        ,remark5='#form.remark5#'
        ,remark6='#form.remark6#'
        ,remark7='#form.remark7#'
        ,remark8='#form.remark8#'
        ,remark9='#form.remark9#'
        ,remark10='#form.remark10#'
        
        <cfif checkcustom.customcompany eq "Y">
		,permit_no='#form.permit_no#'
        ,permit_no2='#form.permit_no2#'
		</cfif> 
		where location='#form.location#' and batchcode='#form.batchcode#' and itemno='#form.items#';
	</cfquery>
    
    <cfquery name="editbatch2" datasource="#dts#">
		update obbatch set 
        pallet='#val(form.pallet)#',
        importpermit='#form.importpermit#',
        countryoforigin='#form.countryoforigin#',
        milcert='#form.milcert#'
        ,remark1='#form.remark1#'
        ,remark2='#form.remark2#'
        ,remark3='#form.remark3#'
        ,remark4='#form.remark4#'
        ,remark5='#form.remark5#'
        ,remark6='#form.remark6#'
        ,remark7='#form.remark7#'
        ,remark8='#form.remark8#'
        ,remark9='#form.remark9#'
        ,remark10='#form.remark10#'
        
		where batchcode='#form.batchcode#' and itemno='#form.items#';
	</cfquery>

	<cfoutput><h3 align="center">The Location - Item <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput> Code</cfif> Has Been Edited !</h1></cfoutput>

<cfelseif isdefined("url.type") and url.type eq "create">
	<cfquery name="checkitem" datasource="#dts#">
		select itemno 
		from icitem 
		where itemno='#form.items#';
	</cfquery>
	
	<cfif checkitem.recordcount neq 0>
		<cfif checkcustom.customcompany eq "Y">
			<cfquery name="checklotnumber" datasource="#dts#">
				select * from lotnumber where lotnumber='#form.batchcode#'
			</cfquery>
			<cfif checklotnumber.recordcount neq 0>
				<cfif checklotnumber.itemno neq form.items>
					<script language="javascript" type="text/javascript">
						alert("This Lot Number already Exist!");
						javascript:history.back();
					</script>
					<cfabort>
				</cfif>
			</cfif>
		</cfif>
		<cftry>
			<cfquery name="insert_location_batch_record" datasource="#dts#">
				insert into lobthob 
                (location,batchcode,itemno,type,refno,bth_qob,bth_qin,bth_qut,rpt_qob,rpt_qin,rpt_qut,expdate,rc_type,rc_refno,rc_expdate,remark1,remark2,remark3,remark4,remark5,remark6,remark7,remark8,remark9,remark10
                <cfif checkcustom.customcompany eq "Y">,permit_no,permit_no2</cfif>) 
				values             ('#form.location#','#form.batchcode#','#form.items#','#form.type#','#form.refno#','#form.qtybf#','0','0','0','0','0',<cfif form.expdate eq ''>'0000-00-00'<cfelse>'#dateformat(form.expdate,"yyyy-mm-dd")#'</cfif>,'#form.type#','#form.refno#',<cfif form.expdate eq ''>'0000-00-00'<cfelse>'#dateformat(form.expdate,"yyyy-mm-dd")#'</cfif>
				,'#form.remark1#'
                ,'#form.remark2#'
                ,'#form.remark3#'
                ,'#form.remark4#'
                ,'#form.remark5#'
                ,'#form.remark6#'
                ,'#form.remark7#'
                ,'#form.remark8#'
                ,'#form.remark9#'
                ,'#form.remark10#'
				<cfif checkcustom.customcompany eq "Y">,'#form.permit_no#','#form.permit_no2#'</cfif>)
			</cfquery>
            <cfif checkcustom.customcompany eq "Y">
                <cfquery name="insert" datasource="#dts#">
                    insert ignore into lotnumber
                    (LotNumber,itemno)
                    value
                    (<cfqueryparam cfsqltype="cf_sql_char" value="#form.batchcode#">,
                    <cfqueryparam cfsqltype="cf_sql_char" value="#form.items#">)
                </cfquery>
			</cfif>
            <cfoutput><h3 align="center">The Location - Item <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput> Code</cfif> Has Been Created !</h1></cfoutput>

			<cfcatch type="database">
				<h3 align="center">The Location - Item <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput> Code</cfif> Found ! Please Enter Again !</h1>
			</cfcatch>
		</cftry>
		
		<cfquery name="insert_location_item_record" datasource="#dts#">
			insert ignore into locqdbf 
			(location,itemno,locqfield,locqactual,locqtran,lminimum,lreorder,qty_bal,val_bal,price,wos_group,category,shelf,supp) 
			values
			('#form.location#','#form.items#','#form.qtybf#','0','0','0','0','0','0','0','','','','');
		</cfquery>
		
		<cfquery name="InsertObbatch" datasource="#dts#">
			insert ignore into obbatch 
            (batchcode,itemno,type,refno,bth_qob,bth_qin,bth_qut,rpt_qob,rpt_qin,rpt_qut,exp_date,rc_type,rc_refno,rc_expdate,remark1,remark2,remark3,remark4,remark5,remark6,remark7,remark8,remark9,remark10
            <cfif checkcustom.customcompany eq "Y">,permit_no,permit_no2</cfif>) 
			values            ('#form.batchcode#','#form.items#','#form.type#','#form.refno#','#form.qtybf#','0','0','0','0','0','#dateformat(form.expdate,"yyyy-mm-dd")#','#form.type#','#form.refno#','#dateformat(form.expdate,"yyyy-mm-dd")#'
			,'#form.remark1#'
            ,'#form.remark2#'
            ,'#form.remark3#'
            ,'#form.remark4#'
            ,'#form.remark5#'
            ,'#form.remark6#'
            ,'#form.remark7#'
            ,'#form.remark8#'
            ,'#form.remark9#'
            ,'#form.remark10#'
			<cfif checkcustom.customcompany eq "Y">,'#form.permit_no#','#form.permit_no2#'</cfif>);
		</cfquery>
	<cfelse>
		<h3 align="center">The Location - Item <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput> Code</cfif> Does Not Exist !</h1>
	</cfif>

	


</cfif>


	
<cfif isdefined("form.generate")>
	<cfquery name="update_locqdbf" datasource="#dts#">
		update locqdbf,(select location,itemno,sum(bth_qob) as balance from lobthob group by location,itemno) as location_batch 
		set locqdbf.locqfield=location_batch.balance 
		where locqdbf.location=location_batch.location and locqdbf.itemno=location_batch.itemno;
	</cfquery>
	
	<cfquery name="update_obbatch" datasource="#dts#">
		update obbatch,(select batchcode,itemno,sum(bth_qob) as balance from lobthob group by batchcode,itemno) as location_batch 
		set obbatch.bth_qob=location_batch.balance 
		where obbatch.batchcode=location_batch.batchcode and obbatch.itemno=location_batch.itemno;
	</cfquery>
	
	<cfquery name="update_icitem" datasource="#dts#">
		update icitem,(select itemno,sum(bth_qob) as balance from lobthob group by itemno) as batch 
		set icitem.qtybf=batch.balance 
		where icitem.itemno=batch.itemno;
	</cfquery>
	
	<h3 align="center">Generate Location - Item <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput></cfif> Completed!</h1>

</cfif>

<cfquery name="getlocationbatch" datasource="#dts#">
	select location,batchcode,itemno,refno,pallet,importpermit,countryoforigin,milcert,type,bth_qob,expdate<cfif checkcustom.customcompany eq "Y">,permit_no,permit_no2</cfif>
	from lobthob 
	where (bth_qut <=(bth_qob+bth_qin)) 
	order by location;
</cfquery>


<form action="locationbatch.cfm" method="post">
		<h1>Search By :
        <select name="searchType">
			<option value="batchcode">Batch Code</option>
	      	<option value="itemno">Item No</option>
	    </select>
      	Search for Batch Opening : 
      	<input type="text" name="searchStr" value="" size="40">
	  	</h1>
</form>

<cfif isdefined("form.searchStr")>
  		<cfquery datasource="#dts#" name="exactResult">
    		select *
            from lobthob 
            where #form.searchType# = '#form.searchStr#' order by #form.searchType# 
             
		</cfquery>
			
  		<cfquery datasource="#dts#" name="similarResult">
    		select *
            from lobthob 
            where #form.searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> order by #form.searchType#
            
             
		</cfquery>
			
		<h2>Exact Result</h2>
		<cfif exactResult.recordCount neq 0>
		
		<table width="75%" border="0" cellspacing="0" cellpadding="2" class="data" align="center">
      		<tr>
			<th>Location</th>
			<th><cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput> Code</cfif></th>
			<th>Item No.</th>
			<th>Qty B/f</th>
			<th>Expiry Date</th>
			<th>Type</th>
			<th>Ref No.</th>
            <th><cfif lcase(HcomID) eq "asaiki_i">PO No<cfelse>Mil Cert</cfif></th>
            <th><cfif lcase(hcomid) eq "asaiki_i" or lcase(hcomid) eq "netivan_i">Length<cfelse>Import Permit</cfif></th>
            <th><cfif lcase(hcomid) eq "asaiki_i" or lcase(hcomid) eq "netivan_i">CUST P/N / REMARK<cfelse>Country Of Origin</cfif></th>
            <th><cfif lcase(hcomid) eq "asaiki_i" or lcase(hcomid) eq "netivan_i">SQM<cfelse>Pallet</cfif></th>
            <cfif checkcustom.customcompany eq "Y">
            	<th>Permit Number (II)</th>
                <th>Permit Number (RM)</th>
			</cfif>
			<th>Action</th>
		</tr>
		<cfoutput query="exactResult">
		<tr>
			<td nowrap><div align="left">#exactResult.location#</div></td>
			<td nowrap><div align="left">#exactResult.batchcode#</div></td>
			<td nowrap><div align="left">#exactResult.itemno#</div></td>
			<td nowrap><div align="right">#val(exactResult.bth_qob)#</div></td>
			<td nowrap><div align="center">#dateformat(exactResult.expdate,"dd-mm-yyyy")#</div></td>
			<td nowrap><div align="right">#exactResult.type#</div></td>
			<td nowrap><div align="right">#exactResult.refno#</div></td>
            <td nowrap><div align="right">#exactResult.milcert#</div></td>
            <td nowrap><div align="right">#exactResult.importpermit#</div></td>
            <td nowrap><div align="right">#exactResult.countryoforigin#</div></td>
            <td nowrap><div align="right">#exactResult.pallet#</div></td>
            <cfif checkcustom.customcompany eq "Y">
            	<td nowrap><div align="left">#exactResult.permit_no#</div></td>
                <td nowrap><div align="left">#exactResult.permit_no2#</div></td>
			</cfif>
			<td nowrap><div align="center">
			<a href="locationbatch.cfm?type=delete&location=#URLEncodedFormat(exactResult.location)#&batchcode=#URLEncodedFormat(exactResult.batchcode)#&itemno=#URLEncodedFormat(exactResult.itemno)#" onClick="javascript:return confirm('Are You Sure ?');">
			<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;
			<a href="editlocationbatch.cfm?type=edit&location=#URLEncodedFormat(exactResult.location)#&batchcode=#URLEncodedFormat(exactResult.batchcode)#&itemno=#URLEncodedFormat(exactResult.itemno)#">
			<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a>
			</div></td>
		</tr>
		</cfoutput>
    	</table>
	<cfelse>
	  	<h3>No Exact Records were found.</h3>
    </cfif>
			
    <h2>Similar Result</h2>
    <cfif similarResult.recordCount neq 0>
      	<table width="75%" border="0" cellspacing="0" cellpadding="2" class="data" align="center">		
	    		<tr>
			<th>Location</th>
			<th><cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput> Code</cfif></th>
			<th>Item No.</th>
			<th>Qty B/f</th>
			<th>Expiry Date</th>
			<th>Type</th>
			<th>Ref No.</th>
            <th><cfif lcase(HcomID) eq "asaiki_i">PO No<cfelse>Mil Cert</cfif></th>
            <th><cfif lcase(hcomid) eq "asaiki_i" or lcase(hcomid) eq "netivan_i">Length<cfelse>Import Permit</cfif></th>
            <th><cfif lcase(hcomid) eq "asaiki_i" or lcase(hcomid) eq "netivan_i">CUST P/N / REMARK<cfelse>Country Of Origin</cfif></th>
            <th><cfif lcase(hcomid) eq "asaiki_i" or lcase(hcomid) eq "netivan_i">SQM<cfelse>Pallet</cfif></th>
            <cfif checkcustom.customcompany eq "Y">
            	<th>Permit Number (II)</th>
                <th>Permit Number (RM)</th>
			</cfif>
			<th>Action</th>
		</tr>
		<cfoutput query="exactResult">
		<tr>
			<td nowrap><div align="left">#similarResult.location#</div></td>
			<td nowrap><div align="left">#similarResult.batchcode#</div></td>
			<td nowrap><div align="left">#similarResult.itemno#</div></td>
			<td nowrap><div align="right">#val(similarResult.bth_qob)#</div></td>
			<td nowrap><div align="center">#dateformat(similarResult.expdate,"dd-mm-yyyy")#</div></td>
			<td nowrap><div align="right">#similarResult.type#</div></td>
			<td nowrap><div align="right">#similarResult.refno#</div></td>
            <td nowrap><div align="right">#similarResult.milcert#</div></td>
            <td nowrap><div align="right">#similarResult.importpermit#</div></td>
            <td nowrap><div align="right">#similarResult.countryoforigin#</div></td>
            <td nowrap><div align="right">#similarResult.pallet#</div></td>
            <cfif checkcustom.customcompany eq "Y">
            	<td nowrap><div align="left">#similarResult.permit_no#</div></td>
                <td nowrap><div align="left">#similarResult.permit_no2#</div></td>
			</cfif>
			<td nowrap><div align="center">
			<a href="locationbatch.cfm?type=delete&location=#URLEncodedFormat(similarResult.location)#&batchcode=#URLEncodedFormat(similarResult.batchcode)#&itemno=#URLEncodedFormat(similarResult.itemno)#" onClick="javascript:return confirm('Are You Sure ?');">
			<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;
			<a href="editlocationbatch.cfm?type=edit&location=#URLEncodedFormat(similarResult.location)#&batchcode=#URLEncodedFormat(similarResult.batchcode)#&itemno=#URLEncodedFormat(similarResult.itemno)#">
			<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a>
			</div></td>
		</tr>
		</cfoutput>
      	</table>
    <cfelse>
	  	<h3>No Similar Records were found.</h3>
    </cfif>
</cfif>



<cfif getlocationbatch.recordcount eq 0>
	<h3 align="center">No Location - Item <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput></cfif> Record Found ! Please Add a Record !</h3>
</cfif>

<cfif getlocationbatch.recordcount neq 0>


<cfif isdefined("form.skeypage")>
		<cfset noOfPage = round(getrecordcount.totalrecord/20)>
		<cfif getrecordcount.totalrecord mod 20 LT 10 and getrecordcount.totalrecord mod 20 neq 0>
			<cfset noOfPage = noOfPage + 1>
		</cfif>
		
		<cfif form.skeypage gt noofpage or form.skeypage lt 1>
			<h3 align="center"><font color="FF0000">Wrong page number! Please try again.</font></h3>
			<cfabort>
		</cfif>
 	</cfif>
    
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
     <cfoutput>
    <cfform action="locationbatch.cfm" method="post" target="_self">
    <div align="right">Page <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">
	
    <cfif start neq 1>
			|| <a target="_self" href="locationbatch.cfm?start=#prevTwenty#">Previous</a> ||
		</cfif>
		
		<cfif page neq noOfPage>
			<a target="_self" href="locationbatch.cfm?start=#nextTwenty#">Next</a> ||
		</cfif>

		Page #page# Of #noOfPage#
    </div>
    </cfform>
	</cfoutput>
    
    <h2>Location Batch Result</h2>

	<table width="75%" border="0" cellspacing="0" cellpadding="2" class="data" align="center">
		<tr>
			<th>Location</th>
			<th><cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput> Code</cfif></th>
			<th>Item No.</th>
			<th>Qty B/f</th>
			<th>Expiry Date</th>
			<th>Type</th>
			<th>Ref No.</th>
            <th><cfif lcase(HcomID) eq "asaiki_i">PO No<cfelse>Mil Cert</cfif></th>
            <th><cfif lcase(hcomid) eq "asaiki_i" or lcase(hcomid) eq "netivan_i">Length<cfelse>Import Permit</cfif></th>
            <th><cfif lcase(hcomid) eq "asaiki_i" or lcase(hcomid) eq "netivan_i">CUST P/N / REMARK<cfelse>Country Of Origin</cfif></th>
            <th><cfif lcase(hcomid) eq "asaiki_i" or lcase(hcomid) eq "netivan_i">SQM<cfelse>Pallet</cfif></th>
            <cfif checkcustom.customcompany eq "Y">
            	<th>Permit Number (II)</th>
                <th>Permit Number (RM)</th>
			</cfif>
			<th>Action</th>
		</tr>
		<cfoutput query="getlocationbatch" startrow="#start#" maxrows="20">
		<tr>
			<td nowrap><div align="left">#getlocationbatch.location#</div></td>
			<td nowrap><div align="left">#getlocationbatch.batchcode#</div></td>
			<td nowrap><div align="left">#getlocationbatch.itemno#</div></td>
			<td nowrap><div align="right">#val(getlocationbatch.bth_qob)#</div></td>
			<td nowrap><div align="center">#dateformat(getlocationbatch.expdate,"dd-mm-yyyy")#</div></td>
			<td nowrap><div align="right">#getlocationbatch.type#</div></td>
			<td nowrap><div align="right">#getlocationbatch.refno#</div></td>
            <td nowrap><div align="right">#getlocationbatch.milcert#</div></td>
            <td nowrap><div align="right">#getlocationbatch.importpermit#</div></td>
            <td nowrap><div align="right">#getlocationbatch.countryoforigin#</div></td>
            <td nowrap><div align="right">#getlocationbatch.pallet#</div></td>
            <cfif checkcustom.customcompany eq "Y">
            	<td nowrap><div align="left">#getlocationbatch.permit_no#</div></td>
                <td nowrap><div align="left">#getlocationbatch.permit_no2#</div></td>
			</cfif>
			<td nowrap><div align="center">
			<a href="locationbatch.cfm?type=delete&location=#URLEncodedFormat(getlocationbatch.location)#&batchcode=#URLEncodedFormat(getlocationbatch.batchcode)#&itemno=#URLEncodedFormat(getlocationbatch.itemno)#" onClick="javascript:return confirm('Are You Sure ?');">
			<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;
			<a href="editlocationbatch.cfm?type=edit&location=#URLEncodedFormat(getlocationbatch.location)#&batchcode=#URLEncodedFormat(getlocationbatch.batchcode)#&itemno=#URLEncodedFormat(getlocationbatch.itemno)#">
			<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a>
			</div></td>
		</tr>
		</cfoutput>
	</table>
</cfif>
<br><br><br>
<cfform name="locationbatchform" action="locationbatch.cfm" method="post">
<table align="center">
<cfoutput>
			<td nowrap><cfinput name="generate" type="submit" value="Generate QtyBF into Item Profile/Batch Opening"></td>
	
	</tr>
</table>
</cfoutput>
</cfform>
</body>
</html>