<cfquery name="getgsetup" datasource="#dts#">
    select lbatch from gsetup
</cfquery>
<html>
<head>
<title>Edit Batch Record</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/scripts/CalendarControl.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="/scripts/CalendarControl.js"></script>
</head>

<cfquery name="checkcustom" datasource="#dts#">
    select customcompany from dealer_menu
</cfquery>

<cfquery name="getitem" datasource="#dts#">
            select itemno,desp 
            from icitem 
            order by itemno;
        </cfquery>

<body onLoad="document.editbatch.batchcode.focus()">
<cfoutput>

<cfif url.type eq 'Create'>

<cfset button='Create'>
<cfset batchcode=''>
<cfset itemno=''>
<cfset Type=''>
<cfset Refno=''>
<cfset BTH_QOB=''>
<cfset exp_date=''>
<cfset manu_date=''>
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
<cfquery name="geteditbatch" datasource="#dts#">
	select *
    from obbatch 
    where batchcode='#url.batchcode#'
    and itemno='#url.itemno#'
</cfquery>

<cfset button='Edit'>
<cfset batchcode=geteditbatch.batchcode>
<cfset itemno=geteditbatch.itemno>
<cfset Type=geteditbatch.type>
<cfset Refno=geteditbatch.refno>
<cfset BTH_QOB=geteditbatch.BTH_QOB>
<cfset exp_date=geteditbatch.exp_date>
<cfset manu_date=geteditbatch.manu_date>
<cfset milcert=geteditbatch.milcert>
<cfset importpermit=geteditbatch.importpermit>
<cfset countryoforigin=geteditbatch.countryoforigin>
<cfset pallet=geteditbatch.pallet>

<cfset remark1=geteditbatch.remark1>
<cfset remark2=geteditbatch.remark2>
<cfset remark3=geteditbatch.remark3>
<cfset remark4=geteditbatch.remark4>
<cfset remark5=geteditbatch.remark5>
<cfset remark6=geteditbatch.remark6>
<cfset remark7=geteditbatch.remark7>
<cfset remark8=geteditbatch.remark8>
<cfset remark9=geteditbatch.remark9>
<cfset remark10=geteditbatch.remark10>

<cfif checkcustom.customcompany eq "Y">
<cfset permit_no=geteditbatch.permit_no>
<cfset permit_no2=geteditbatch.permit_no2>
</cfif>

</cfif>

<cfif url.type eq 'Create'>
<h1 align="center">Create <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput></cfif> <font color="red"></font> Record</h1>
<cfelse>
<h1 align="center">Edit <cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput></cfif> <font color="red">#url.batchcode#</font> Record</h1>
</cfif>
<cfinclude template = "../../../CFC/convert_single_double_quote_script.cfm">

<cfform name="editbatch" action="batch.cfm?type=#url.type#">	
	<table align="center">
		<tr align="justify">
			<th><cfif checkcustom.customcompany eq "Y">Lot Number<cfelse><cfoutput>#getgsetup.lbatch#</cfoutput> Code</cfif></th>
			<td nowrap>
            <cfif url.type eq 'Create'>
            <cfinput name="batchcode" type="text" size="15" value="#convertquote(batchcode)#" required="yes">
            <cfelse>
            <input name="batchcode" type="text" size="15" value="#convertquote(batchcode)#" readonly>
            </cfif>
            </td>
			<th>Item No</th>
			<td nowrap>
            <cfif url.type eq 'Create'>
            <cfselect name="items" required="yes">
                    <option value="">Please Select a Item</option>
                    <cfoutput>
                    <cfloop query="getitem">
                            <option value="#convertquote(getitem.itemno)#">#getitem.itemno# - #getitem.desp#</option>
                    </cfloop>
                    </cfoutput>
                </cfselect>
            <cfelse>
            <input name="items" type="text" size="15" value="#convertquote(itemno)#" readonly>
            </cfif>
            </td>
		</tr>
		<tr align="justify">
			<th>QTY B/F</th>
			<td nowrap><cfinput name="qtybf" type="text" size="5" required="yes" validate="integer" message="The Qty B/F Must Be Integer !" value="#bth_qob#"></td>
			<th>Expiry Date</th>
			<td nowrap><cfinput name="expdate" type="text" validate="eurodate"  size="10" value="#dateformat(exp_date,'dd/mm/yyyy')#" >
                        &nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(expdate);">
				(DD/MM/YYYY)
            </td>
		</tr>
		<tr align="justify">
			<th>Type</th>
			<td nowrap>
            <cfif url.type eq 'Create'>
            <input name="type" type="text" size="4" value="#type#">
            <cfelse>
            <input name="type" type="text" size="4" value="#type#" readonly>
            </cfif>
            </td>
			<th>Ref No</th>
			<td nowrap>
            <cfif url.type eq 'Create'>
            <input name="refno" type="text" size="8" value="#convertquote(refno)#">
            <cfelse>
            <input name="refno" type="text" size="8" value="#convertquote(refno)#" readonly>
            </cfif>
            </td>
		</tr>
        
        <tr align="justify">
			<th><cfif lcase(HcomID) eq "asaiki_i">PO No<cfelse>Mil Cert</cfif></th>
			<td nowrap><input type="text" name="milcert" id="milcert" value="#milcert#" maxlength="100"></td>
			<th><cfif lcase(hcomid) eq "asaiki_i" or lcase(hcomid) eq "netivan_i">Length<cfelse>Import Permit</cfif></th>
			<td nowrap>
            <input type="text" name="importpermit" id="importpermit" value="#importpermit#" maxlength="100" >
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
        <tr align="justify">
        <th>Manufacturing Date</th>
			<td nowrap><cfinput name="manudate" type="text" size="10" value="#dateformat(manu_date,'dd/mm/yyyy')#" validate="eurodate" message="Please Key in date Format">
            &nbsp;<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(manudate);">
				(DD/MM/YYYY)
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
			<td><input type="button" name="Back" value="Back" onClick="window.location='batch.cfm'"></td>
		</tr>
	</table>
</cfform>
</cfoutput>
</body>
</html>