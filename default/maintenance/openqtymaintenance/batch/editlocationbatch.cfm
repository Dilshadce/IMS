<cfquery name="getgsetup" datasource="#dts#">
    select lbatch from gsetup
</cfquery>

<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>
		<cfquery name="getitem" datasource="#dts#">
            select itemno,desp 
            from icitem 
            order by itemno;
        </cfquery>
        
        <cfquery name="getlocation" datasource="#dts#">
            select location,desp 
            from iclocation 
            order by location;
        </cfquery>

<html>
<head>
<cfif url.type eq 'Create'>

<cfset button='Create'>
<cfset location=''>
<cfset batchcode=''>
<cfset itemno=''>
<cfset Type=''>
<cfset Refno=''>
<cfset BTH_QOB=''>
<cfset expdate=''>
<cfset manudate=''>
<cfset milcert=''>
<cfset importpermit=''>
<cfset countryoforigin=''>
<cfset pallet=''>
<cfset permit_no=''>
<cfset permit_no2=''>

<cfset remark1=''>
<cfset remark2=''>
<cfset remark3=''>
<cfset remark4=''>
<cfset remark5=''>
<cfset remark6=''>
<cfset remark7=''>
<cfset remark8=''>
<cfset remark9=''>
<cfset remark10=''>

<cfelse>
<cfquery name="geteditlocationbatch" datasource="#dts#">
	select * 
	from lobthob 
	where location='#url.location#' and batchcode='#url.batchcode#' and itemno='#url.itemno#';
</cfquery>

<cfset button='Edit'>
<cfset location=geteditlocationbatch.location>
<cfset batchcode=geteditlocationbatch.batchcode>
<cfset itemno=geteditlocationbatch.itemno>
<cfset Type=geteditlocationbatch.type>
<cfset Refno=geteditlocationbatch.refno>
<cfset BTH_QOB=geteditlocationbatch.BTH_QOB>
<cfset expdate=geteditlocationbatch.expdate>
<cfset manudate=geteditlocationbatch.manudate>
<cfset milcert=geteditlocationbatch.milcert>
<cfset importpermit=geteditlocationbatch.importpermit>
<cfset countryoforigin=geteditlocationbatch.countryoforigin>
<cfset pallet=geteditlocationbatch.pallet>

<cfset remark1=geteditlocationbatch.remark1>
<cfset remark2=geteditlocationbatch.remark2>
<cfset remark3=geteditlocationbatch.remark3>
<cfset remark4=geteditlocationbatch.remark4>
<cfset remark5=geteditlocationbatch.remark5>
<cfset remark6=geteditlocationbatch.remark6>
<cfset remark7=geteditlocationbatch.remark7>
<cfset remark8=geteditlocationbatch.remark8>
<cfset remark9=geteditlocationbatch.remark9>
<cfset remark10=geteditlocationbatch.remark10>

<cfif checkcustom.customcompany eq "Y">
<cfset permit_no=geteditlocationbatch.permit_no>
<cfset permit_no2=geteditlocationbatch.permit_no2>
</cfif>

</cfif>


<title>Edit Location - Item Batch Record</title>
<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfinclude template = "../../../CFC/convert_single_double_quote_script.cfm">
<body onLoad="document.editlocationbatch.qtybf.focus()">

<cfoutput>
<cfif url.type eq 'create'>
<h1 align="center">Create Location - Item <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput></cfif> Record</h1>
<cfelse>
<h1 align="center">Edit Location <font color="red">#url.location#</font> - Item <font color="red">#url.itemno#</font> <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput></cfif> <font color="red">#url.batchcode#</font>Record</h1>
</cfif>


<cfform name="editlocationbatch" action="locationbatch.cfm?type=#url.type#">	
	<table align="center">
		<tr align="justify">
			<th>Location</th>
			<td nowrap>
            <cfif url.type eq 'Create'>
            <select name="location" id="location">
            <option value="">Choose a location</option>
            <cfloop query="getlocation">
            <option value="#getlocation.location#">#getlocation.location# - #getlocation.desp#</option>
            </cfloop>
            </select>
            <cfelse>
            <input name="location" type="text" size="24" maxlength="24" value="#location#" readonly>
            </cfif>
            </td>
		</tr>
		<tr align="justify">
			<th><cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput> Code</cfif></th>
			<td nowrap>
            <cfif url.type eq 'Create'>
            <input name="batchcode" type="text" size="15" maxlength="15" value="#convertquote(batchcode)#">
            <cfelse>
            <input name="batchcode" type="text" size="15" maxlength="15" value="#convertquote(batchcode)#" readonly>
            </cfif>
            </td>
            
            
            <th>Item No</th>
			<td nowrap>
            <cfif url.type eq 'Create'>
            <select name="items" id="items">
            <option value="">Choose a Item No</option>
            <cfloop query="getitem">
            <option value="#getitem.itemno#">#getitem.itemno# - #getitem.desp#</option>
            </cfloop>
            </select>
            <cfelse>
            <input name="items" type="text" size="15" maxlength="15" value="#convertquote(itemno)#" readonly>
            </cfif>
            </td>
		</tr>
		<tr align="justify">
			<th>QTY B/F</th>
			<td nowrap><cfinput name="qtybf" type="text" size="5" maxlength="5" required="yes" validate="integer" message="The Qty B/F Must Be Integer !" value="#bth_qob#"></td>
			<th>Expiry Date</th>
			<td nowrap><cfinput name="expdate" type="text" size="10" validate="eurodate" message="Please Enter Correct Expiry Date !" maxlength="10" value="#dateformat(expdate,'dd-mm-yyyy')#"></td>
		</tr>
		<tr align="justify">
			<th>Type</th>
			<td nowrap><cfinput name="type" type="text" size="4" maxlength="4" value="#type#"></td>
			<th>Ref No</th>
			<td nowrap><cfinput name="refno" type="text" size="8" maxlength="8" value="#refno#"></td>
		</tr>
        
        <tr align="justify">
			<th><cfif lcase(HcomID) eq "asaiki_i">PO No<cfelse>Mil Cert</cfif></th>
			<td nowrap><input type="text" name="milcert" id="milcert" value="#milcert#" maxlength="100"></td>
			<th><cfif lcase(hcomid) eq "asaiki_i" or lcase(hcomid) eq "netivan_i">Length<cfelse>Import Permit</cfif></th>
			<td nowrap>
            <input type="text" name="importpermit" id="importpermit" value="#importpermit#" maxlength="100" <cfif lcase(hcomid) neq "asaiki_i">readonly</cfif>>
            </td>
		</tr>
        
        <tr align="justify">
			<th><cfif lcase(hcomid) eq "asaiki_i" or lcase(hcomid) eq "netivan_i">CUST P/N / REMARK<cfelse>Country Of Origin</cfif></th>
			<td nowrap><input type="text" name="countryoforigin" id="countryoforigin" value="#countryoforigin#" maxlength="150"></td>
			<th><cfif lcase(hcomid) eq "asaiki_i" or lcase(hcomid) eq "netivan_i">SQM<cfelse>Pallet</cfif></th>
			<td nowrap>
            <input type="text" name="pallet" id="pallet" value="#val(pallet)#" maxlength="100">
            </td>
		</tr>
        
        <tr>
        <th><cfif lcase(hcomid) eq 'asaiki_i'>Slitting Date<cfelse>Remark 1</cfif></th>
        <td nowrap><input type="text" name="remark1" id="remark1" value="#remark1#" maxlength="100"></td>
        <th><cfif lcase(hcomid) eq 'asaiki_i'>Unwind<cfelse>Remark 2</cfif></th>
        <td nowrap><input type="text" name="remark2" id="remark2" value="#remark2#" maxlength="100"></td>
        </tr>
        <tr>
        <th><cfif lcase(hcomid) eq 'asaiki_i'>Rewind<cfelse>Remark 3</cfif></th>
        <td nowrap><input type="text" name="remark3" id="remark3" value="#remark3#" maxlength="100"></td>
        <th><cfif lcase(hcomid) eq 'asaiki_i'>Received<cfelse>Remark 4</cfif></th>
        <td nowrap><input type="text" name="remark4" id="remark4" value="#remark4#" maxlength="100"></td>
        </tr>
        <tr>
        <th><cfif lcase(hcomid) eq 'asaiki_i'>Received Master Roll sticky Side<cfelse>Remark 5</cfif></th>
        <td nowrap><input type="text" name="remark5" id="remark5" value="#remark5#" maxlength="100"></td>
        <th><cfif lcase(hcomid) eq 'asaiki_i'>Checking Master Roll Sticky side<cfelse>Remark 6</cfif></th>
        <td nowrap><input type="text" name="remark6" id="remark6" value="#remark6#" maxlength="100"></td>
        </tr>
        <tr>
        <th><cfif lcase(hcomid) eq 'asaiki_i'>Output<cfelse>Remark 7</cfif></th>
        <td nowrap><input type="text" name="remark7" id="remark7" value="#remark7#" maxlength="100"></td>
        <th><cfif lcase(hcomid) eq 'asaiki_i'>Remark<cfelse>Remark 8</cfif></th>
        <td nowrap><input type="text" name="remark8" id="remark8" value="#remark8#" maxlength="100"></td>
        </tr>
        <tr>
        <th><cfif lcase(hcomid) eq 'asaiki_i'>Photo<cfelse>Remark 9</cfif></th>
        <td nowrap><input type="text" name="remark9" id="remark9" value="#remark9#" maxlength="100"></td>
        <th><cfif lcase(hcomid) eq 'asaiki_i'><cfelse>Remark 10</cfif></th>
        <td nowrap><input type="text" name="remark10" id="remark10" value="#remark10#" maxlength="100"></td>
        </tr>
        
		<cfif checkcustom.customcompany eq "Y">
			<tr align="justify">
                <th>Permit Number (II)</th>
                <td nowrap>
                	<input name="permit_no" type="text" size="15" maxlength="35" value="#permit_no#">
                </td>
                <th>Permit Number (RM)</th>
                <td nowrap>
                	<input name="permit_no2" type="text" size="15" maxlength="35" value="#permit_no2#">
                </td>
            </tr>
        </cfif>
	</table>
	<table align="center">
		<tr>
			<td><input type="submit" name="Edit" value="#button#"></td>
			<td><input type="button" name="Back" value="Back" onClick="window.location='locationbatch.cfm'"></td>
		</tr>
	</table>
</cfform>
</cfoutput>

</body>
</html>