<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<cfquery name="getbatchname" datasource="#dts#">
SELECT lbatch FROM gsetup
</cfquery>


<cfquery name="getinfo" datasource="#dts#">
	select itemno,type,refno,pallet,
	location,expdate,qty,milcert,importpermit,
	defective,mc1_bil,mc2_bil,
	batchcode,sodate,dodate 
	from receivetemp
	where trancode='#url.trancode#' 
    and uuid='#url.uuid#'
</cfquery>

<cfquery name="getlength" datasource="#dts#">
	select remark1,remark2 from icitem where itemno='#getinfo.itemno#'
</cfquery>

<cfif getinfo.recordcount neq 0>

<cfquery name="getrcbatchcode" datasource="#dts#">
select batchcode,milcert,expdate from issuetemp where uuid='#url.uuid#'
</cfquery>

	<cfset mc1bil = getinfo.mc1_bil>
	<cfset mc2bil = getinfo.mc2_bil>
    <cfset importpermit=getinfo.importpermit>
    <cfif getinfo.batchcode eq ''>
    <cfset xbatchcode = getrcbatchcode.batchcode>
    <cfelse>
	<cfset xbatchcode = getinfo.batchcode>
    </cfif>
	<cfset defective = getinfo.defective>
    <cfif getinfo.pallet eq 0>
    <cfset pallet = val(getlength.remark1)*val(getlength.remark2)>
    <cfelse>
    <cfset pallet = getinfo.pallet>
    </cfif>
	<cfset qty = getinfo.qty>
    <cfif getinfo.batchcode eq ''>
    <cfset milcert = getrcbatchcode.milcert>
    <cfelse>
    <cfset milcert = getinfo.milcert>
    </cfif>
	<cfif getinfo.expdate neq "">
		<cfset expdate = dateformat(getinfo.expdate,"dd-mm-yyyy")>
	<cfelse>
    <cfif getrcbatchcode.expdate neq "">
		<cfset expdate = dateformat(getrcbatchcode.expdate,"dd-mm-yyyy")>
    <cfelse>
    	<cfset expdate = ''>
    </cfif>
	</cfif>
	<cfif getinfo.sodate neq "">
		<cfset sodate = dateformat(getinfo.sodate,"dd-mm-yyyy")>
	<cfelse>
		<cfset sodate = getinfo.sodate>
	</cfif>
	<cfif getinfo.dodate neq "">
		<cfset dodate = dateformat(getinfo.dodate,"dd-mm-yyyy")>
	<cfelse>
		<cfset dodate = getinfo.dodate>
	</cfif>
<cfelse>

<cfquery name="getrcbatchcode" datasource="#dts#">
select batchcode from issuetemp where uuid='#url.uuid#'
</cfquery>

	<cfset mc1bil = "0.00">
	<cfset mc2bil = "0.00">
    <cfset importpermit="">
	<cfset xbatchcode = getrcbatchcode.batchcode>
	<cfset expdate = "">
    <cfset milcert = "">
    <cfset pallet = val(getlength.remark1)*val(getlength.remark2)>
	<cfset sodate = "">
	<cfset dodate = "">
	<cfset defective = "">
	<cfset qty = getinfo.qty>
</cfif>
<h1 align="center"><cfoutput><font color="red">#getinfo.location#</font></cfoutput>: Select <cfoutput>#getbatchname.lbatch#</cfoutput> For Item <cfoutput><font color="red">#getinfo.itemno#</font></cfoutput></h1>
<cfform name="form1" action="rcdissemble_batch2.cfm" method="post">
<cfoutput>	
	<input type="hidden" name="location" value="#getinfo.location#">
	<input type="hidden" name="tran" value="#getinfo.type#">
    <input type="hidden" name="rcdissembleuuid" value="#url.uuid#">
    <input type="hidden" name="rcdissembletrancode" value="#url.trancode#">
	<input type="hidden" name="itemno" value="#convertquote(getinfo.itemno)#">
<table align="center">
	<tr>
		<th>Other Charges 1</th>
		<td><input name="mc1bil" type="text" size="10" value="#numberformat(mc1bil,'0.00')#" onKeyPress="return onlyNumbers();"></td>
	</tr>
	<tr>
		<th>Other Charges 2</th>
		<td><input name="mc2bil" type="text" size="10" value="#numberformat(mc2bil,'0.00')#" onKeyPress="return onlyNumbers();"></td>
	</tr>
	<tr><td><br></td></tr>
	<tr>
		<th>Sales Order Date</th>
		<td><input name="sodate" type="text" size="10" value="#sodate#">(e.g dd-mm-yyyy)</td>
	</tr>
	<tr>	
		<th>Delivery Date</th>
		<td><input name="dodate" type="text" size="10" value="#dodate#">(e.g dd-mm-yyyy)</td>
	</tr>
	<tr><td><br></td></tr>
	<tr>
		<th>#getbatchname.lbatch# Code</th>
		<td>
			<!--- <input name="enterbatch" type="text" size="10" value=""> --->
            <input type="text" name="enterbatch" id="enterbatch" value="#xbatchcode#" maxlength="50"/>
		</td>
	</tr>
	<tr>
		<th>Expiry Date</th>
		<td><cfinput name="expdate" type="text" size="10" value="#expdate#" validate="eurodate">(e.g dd-mm-yyyy)</td>
	</tr>
    <tr>
		<th><cfif lcase(hcomid) eq 'asaiki_i'>PO No<cfelse>Mill Certificate</cfif></th>
		<td><input name="milcert" type="text" size="10" value="#milcert#"></td>
	</tr>
	<tr>
		<th>Quantity</th>
		<td><cfinput name="batchqty" type="text" size="5" value="#qty#" readonly validate="float" message="Numbers only"></td>	
	</tr>
    <tr style="display:none">
		<th>Width/Length</th>
		<td>
        W: <cfinput name="SQMW" id="SQMW" type="text" size="5" value="#val(getlength.remark2)#" readonly onKeyUp="document.getElementById('pallet').value=(document.getElementById('SQMW').value/1000)*document.getElementById('importpermit').value" >    

        </td>	
	</tr>
    <tr>
		<th>Width</th>
		<td>
 		<cfinput name="importpermit" id="importpermit" type="text" size="5" value="#val(importpermit)#" >
        
        </td>	
	</tr>
    <tr>
		<th>SQM</th>
		<td><cfinput name="pallet" id="pallet" type="text" size="5" value="#pallet#" validate="float" message="Numbers only"></td>	
	</tr>
	<tr><td><br></td></tr>
	<tr>
		<th>#getbatchname.lbatch# Status</th>
		<td align="left">
			<input name="defective" id="defective" type="radio" value="D" <cfif defective eq "D"> checked</cfif>> Damage <br>
			<input name="defective" id="defective" type="radio" value="W" <cfif defective eq "W"> checked</cfif>> Write Off <br>
			<input name="defective" id="defective" type="radio" value="R" <cfif defective eq "R"> checked</cfif>> Repair <br>
			<input name="defective" id="defective" type="radio" value="" <cfif defective eq ""> checked</cfif>> Good Item
		</td>
	</tr>
	<tr><td><br></td></tr>
	<tr>
		<td colspan="100%" align="center">
			<input type="submit" name="issbatchsubmit" id="issbatchsubmit" value="Ok" >&nbsp;&nbsp;<input type="button" value="Cancel" onClick="ColdFusion.Window.hide('issbatch');">
		</td>
	</tr>
</table>
</cfoutput>
</cfform>