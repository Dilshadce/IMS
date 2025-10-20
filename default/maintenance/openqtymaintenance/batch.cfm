<cfquery name="getgsetup" datasource="#dts#">
    select lbatch from gsetup
</cfquery>
<html>
<head>
<title>Edit Batch Opening Quantity</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='/ajax/core/engine.js'></script>
<script type='text/javascript' src='/ajax/core/util.js'></script>
<script type='text/javascript' src='/ajax/core/settings.js'></script>


<script type="text/javascript">
	function checkExist(){
		var batchcode = document.batchform.batchcode.value;
		DWREngine._execute(_tranflocation, null, 'checkLotNumberExist',batchcode,'', showLotNumberResult);
	}
		
	function showLotNumberResult(LotObject){
		if(LotObject.EXISTENCE == 'yes'){
			alert('This Lot Number Already Used!');
			document.batchform.batchcode.value='';
			document.batchform.batchcode.focus();
		}
	}
	
</script>

<cfparam name="start" default="1">
<cfparam name="page" default="1">
<cfparam name="prevTwenty" default="0">
<cfparam name="nextTwenty" default="0">

<cfquery name="getrecordcount" datasource="#dts#">
	select count(batchcode) as totalrecord 
	from obbatch 
	order by batchcode
</cfquery>



</head>
<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>
<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<cfif isdefined("form.searchitem") and form.searchitem eq "Search">
	<cfoutput>
		<form action="itemsearch.cfm?stype=batch" name="done" method="post">
			<input type="hidden" name="batchcode" value="#batchcode#">
			<input type="hidden" name="location" value="">
			<input type="hidden" name="qtybf" value="#qtybf#">
			<input type="hidden" name="type" value="#type#">
			<input type="hidden" name="refno" value="#refno#">
			<input type="hidden" name="expdate" value="#expdate#">
            <cfif checkcustom.customcompany eq "Y">
                <input type="hidden" name="permit_no" value="#permit_no#">
                <input type="hidden" name="permit_no2" value="#permit_no2#">
			</cfif>
		</form>
	</cfoutput>
	<script language="javascript" type="text/javascript">
		done.submit();
	</script>
</cfif>


<body>

<h4>
<a href="editbatch.cfm?type=Create">Creating a New <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput></cfif> Opening Qty</a>
</h4>

<h1 align="center"><cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput></cfif> Opening Quantity</h1>

<cfif isdefined("url.type") and url.type eq "delete">
	<cfquery name="deletebatch" datasource="#dts#">
		DELETE FROM obbatch 
		WHERE batchcode='#url.batchcode#'
        AND itemno='#url.itemno#'
	</cfquery>

<cfelseif isdefined("url.type") and url.type eq "edit">
	<cfquery name="editbatch" datasource="#dts#">
		update obbatch 
		set bth_qob='#form.qtybf#',
        pallet='#val(form.pallet)#',
        importpermit='#form.importpermit#',
        countryoforigin='#form.countryoforigin#',
        milcert='#form.milcert#'
        ,<cfif form.expdate eq ''>exp_date='0000-00-00'<cfelse>exp_date='#dateformat(createdate(right(form.expdate,4),mid(form.expdate,4,2),left(form.expdate,2)),'yyyy-mm-dd')#'</cfif>
        <cfif checkcustom.customcompany eq "Y">
		,permit_no='#form.permit_no#'
        ,permit_no2='#form.permit_no2#'
		</cfif> 
        ,<cfif form.manudate eq ''>manu_date='0000-00-00'<cfelse>manu_date='#dateformat(createdate(right(form.manudate,4),mid(form.manudate,4,2),left(form.manudate,2)),'yyyy-mm-dd')#'</cfif>
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
        
        where batchcode='#form.batchcode#'
        and itemno='#form.items#'
	</cfquery>

	<h3 align="center">The <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput> Code</cfif> "<cfoutput>#form.batchcode#</cfoutput>" Has Been Edited !</h3>

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
				<script language="javascript" type="text/javascript">
					alert("This Lot Number already Exist!");
					javascript:history.back();
				</script>
				<cfabort>
			</cfif>
		</cfif>
		<cftry>
			<cfquery name="insertbatchrecord" datasource="#dts#">
				insert into obbatch 
                (batchcode,itemno,type,refno,bth_qob,bth_qin,bth_qut,rpt_qob,rpt_qin,rpt_qut,exp_date,rc_type,rc_refno,rc_expdate,pallet,importpermit,countryoforigin,milcert,manu_date,remark1,remark2,remark3,remark4,remark5,remark6,remark7,remark8,remark9,remark10
				<cfif checkcustom.customcompany eq "Y">,permit_no,permit_no2</cfif>)
				values           			
                ('#form.batchcode#','#form.items#','#form.type#','#form.refno#','#form.qtybf#','0','0','0','0','0',<cfif form.expdate eq ''>'0000-00-00'<cfelse>'#dateformat(createdate(right(form.expdate,4),mid(form.expdate,4,2),left(form.expdate,2)),'yyyy-mm-dd')#'</cfif>,'#form.type#','#form.refno#',<cfif form.expdate eq ''>'0000-00-00'<cfelse>'#dateformat(createdate(right(form.expdate,4),mid(form.expdate,4,2),left(form.expdate,2)),'yyyy-mm-dd')#'</cfif>,
				
                '#val(form.pallet)#',
                '#form.importpermit#',
                '#form.countryoforigin#',
                '#form.milcert#',
                <cfif form.manudate eq ''>'0000-00-00'<cfelse>'#dateformat(createdate(right(form.manudate,4),mid(form.manudate,4,2),left(form.manudate,2)),'yyyy-mm-dd')#'</cfif>
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
                    insert into lotnumber
                    (LotNumber,itemno)
                    value
                    (<cfqueryparam cfsqltype="cf_sql_char" value="#form.batchcode#">,
                    <cfqueryparam cfsqltype="cf_sql_char" value="#form.items#">)
                </cfquery>
			</cfif>
            
            <h3 align="center">The <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput> Code</cfif> "<cfoutput>#form.batchcode#</cfoutput>" Has Been Created !</h3>
            
		<cfcatch type="database">
				<h3 align="center">The <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput> Code</cfif> "<cfoutput>#form.batchcode#</cfoutput>" Found ! Please Enter Other <cfoutput>#getgsetup.lbatch#</cfoutput> Code !</h1>
			</cfcatch>
		</cftry>

	<cfelse>
		<cfoutput><h3 align="center">The Item Code Does Not Exist !</h3></cfoutput>
	</cfif>
	

</cfif>

    <cfif isdefined("form.generate")>
	<cfquery name="updateitem" datasource="#dts#">
		update icitem,(select itemno,sum(bth_qob) as balance from obbatch group by itemno) as batch
		set icitem.qtybf=batch.balance 
		where icitem.itemno=batch.itemno;
	</cfquery>

	<h3 align="center">Generate <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput></cfif> Record Completed!</h3>
	</cfif>

<cfquery name="getbatch" datasource="#dts#">
	select batchcode,itemno,refno,milcert,pallet,importpermit,countryoforigin,type,bth_qob,manu_date,exp_date<cfif checkcustom.customcompany eq "Y">,permit_no,permit_no2</cfif>
	from obbatch 
	where (bth_qut <=(bth_qob+bth_qin)) 
	order by batchcode;
</cfquery>


<form action="batch.cfm" method="post">
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
    		select batchcode,itemno,refno,milcert,pallet,importpermit,countryoforigin,type,bth_qob,manu_date,exp_date<cfif checkcustom.customcompany eq "Y">,permit_no,permit_no2</cfif>
            from obbatch 
            where #form.searchType# = '#form.searchStr#' order by #form.searchType# 
             
		</cfquery>
			
  		<cfquery datasource="#dts#" name="similarResult">
    		select batchcode,itemno,refno,milcert,pallet,importpermit,countryoforigin,type,bth_qob,manu_date,exp_date<cfif checkcustom.customcompany eq "Y">,permit_no,permit_no2</cfif>
            from obbatch 
            where #form.searchType# LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.searchStr#%"> order by #form.searchType#
            
             
		</cfquery>
			
		<h2>Exact Result</h2>
		<cfif exactResult.recordCount neq 0>
		
		<table width="75%" border="0" cellspacing="0" cellpadding="2" class="data" align="center">
      		<tr>
			<th><cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput> Code</cfif></th>
			<th>Item No.</th>
			<th>Qty B/f</th>
			<th>Expiry Date</th>
            <th>Manufacturing Date</th>
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
			<td nowrap><div align="left">#exactResult.batchcode#</div></td>
			<td nowrap><div align="left">#exactResult.itemno#</div></td>
			<td nowrap><div align="right">#numberformat(exactResult.bth_qob,0)#</div></td>
			<td nowrap><div align="center">#dateformat(exactResult.exp_date,"dd-mm-yyyy")#</div></td>
            <td nowrap><div align="center">#dateformat(exactResult.manu_date,"dd-mm-yyyy")#</div></td>
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
			<a href="batch.cfm?type=delete&batchcode=#URLEncodedFormat(exactResult.batchcode)#&itemno=#URLEncodedFormat(exactResult.itemno)#" onClick="javascript:return confirm('Are You Sure To Delete This Batch?');">
			<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;
			<a href="editbatch.cfm?type=edit&batchcode=#URLEncodedFormat(exactResult.batchcode)#&itemno=#URLEncodedFormat(exactResult.itemno)#">
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
			<th><cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput> Code</cfif></th>
			<th>Item No.</th>
			<th>Qty B/f</th>
			<th>Expiry Date</th>
            <th>Manufacturing Date</th>
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
		<cfoutput query="similarResult">
		<tr>
			<td nowrap><div align="left">#similarResult.batchcode#</div></td>
			<td nowrap><div align="left">#similarResult.itemno#</div></td>
			<td nowrap><div align="right">#numberformat(similarResult.bth_qob,0)#</div></td>
			<td nowrap><div align="center">#dateformat(similarResult.exp_date,"dd-mm-yyyy")#</div></td>
            <td nowrap><div align="center">#dateformat(similarResult.manu_date,"dd-mm-yyyy")#</div></td>
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
			<a href="batch.cfm?type=delete&batchcode=#URLEncodedFormat(similarResult.batchcode)#&itemno=#URLEncodedFormat(similarResult.itemno)#" onClick="javascript:return confirm('Are You Sure To Delete This Batch?');">
			<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;
			<a href="editbatch.cfm?type=edit&batchcode=#URLEncodedFormat(similarResult.batchcode)#&itemno=#URLEncodedFormat(similarResult.itemno)#">
			<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a>
			</div></td>
		</tr>
		</cfoutput>
      	</table>
    <cfelse>
	  	<h3>No Similar Records were found.</h3>
    </cfif>
</cfif>


<cfif getbatch.recordcount eq 0>
	<h3 align="center">No <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput></cfif> Record Found ! Please Add a <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput></cfif> Record !</h3>
</cfif>

<cfif getbatch.recordcount neq 0>


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
    <cfform action="batch.cfm" method="post" target="_self">
    <div align="right">Page <cfinput name="skeypage" type="text" size="2" validate="integer" message="Wrong value in Page field.">
	
    <cfif start neq 1>
			|| <a target="_self" href="batch.cfm?start=#prevTwenty#">Previous</a> ||
		</cfif>
		
		<cfif page neq noOfPage>
			<a target="_self" href="batch.cfm?start=#nextTwenty#">Next</a> ||
		</cfif>

		Page #page# Of #noOfPage#
    </div>
    </cfform>
	</cfoutput>

<h2>Batch Result</h2>
	<table width="75%" border="0" cellspacing="0" cellpadding="2" class="data" align="center">
		<tr>
			<th><cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput> Code</cfif></th>
			<th>Item No.</th>
			<th>Qty B/f</th>
			<th>Expiry Date</th>
            <th>Manufacturing Date</th>
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
		<cfoutput query="getbatch" startrow="#start#" maxrows="20">
		<tr>
			<td nowrap><div align="left">#getbatch.batchcode#</div></td>
			<td nowrap><div align="left">#getbatch.itemno#</div></td>
			<td nowrap><div align="right">#numberformat(getbatch.bth_qob,0)#</div></td>
			<td nowrap><div align="center">#dateformat(getbatch.exp_date,"dd-mm-yyyy")#</div></td>
            <td nowrap><div align="center">#dateformat(getbatch.manu_date,"dd-mm-yyyy")#</div></td>
			<td nowrap><div align="right">#getbatch.type#</div></td>
			<td nowrap><div align="right">#getbatch.refno#</div></td>
            <td nowrap><div align="right">#getbatch.milcert#</div></td>
            <td nowrap><div align="right">#getbatch.importpermit#</div></td>
            <td nowrap><div align="right">#getbatch.countryoforigin#</div></td>
            <td nowrap><div align="right">#getbatch.pallet#</div></td>
            <cfif checkcustom.customcompany eq "Y">
            	<td nowrap><div align="left">#getbatch.permit_no#</div></td>
                <td nowrap><div align="left">#getbatch.permit_no2#</div></td>
			</cfif>
            
			<td nowrap><div align="center">
			<a href="batch.cfm?type=delete&batchcode=#URLEncodedFormat(getbatch.batchcode)#&itemno=#URLEncodedFormat(getbatch.itemno)#" onClick="javascript:return confirm('Are You Sure To Delete This Batch?');">
			<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>&nbsp;
			<a href="editbatch.cfm?type=edit&batchcode=#URLEncodedFormat(getbatch.batchcode)#&itemno=#URLEncodedFormat(getbatch.itemno)#">
			<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a>
			</div></td>
		</tr>
		</cfoutput>
	</table>
</cfif>
<br><br><br>

<cfform name="batchform" action="batch.cfm" method="post">

<table align="center">
	<tr align="center">

			<td nowrap><cfinput name="generate" type="submit" value="Generate QtyBF into Item Profile"></td>

	</tr>
</table>
</cfform>

</body>
</html>