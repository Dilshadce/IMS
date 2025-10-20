<cfinclude template = "/CFC/convert_single_double_quote_script.cfm">
<cfquery name="getbatchname" datasource="#dts#">
SELECT lbatch FROM gsetup
</cfquery>



<cfquery name="getinfo" datasource="#dts#">
	select itemno,type,refno,pallet,importpermit,
	location,expdate,qty,milcert,
	defective,mc1_bil,mc2_bil,
	batchcode,sodate,dodate 
	from issuetemp
	where trancode='#url.trancode#' 
    and uuid='#url.uuid#'
</cfquery>

<cfquery name="getitembatch" datasource="#dts#">
<cfif trim(getinfo.location) neq "">
	<cfif lcase(hcomid) eq "remo_i">
		select a.location,a.batchcode,a.itemno,a.pallet,a.importpermit,
		a.rc_type,a.rc_refno,((a.bth_qob+a.bth_qin)-a.bth_qut-ifnull(b.soqty,0)) as batch_balance,
		a.expdate as exp_date ,
        a.milcert
		from lobthob as a 
		left join 
		(
			select 
			batchcode,
			itemno,
			location, 
			sum(qty) as soqty 
			from ictran 
			where type='SO' 
			and itemno='#getinfo.itemno#' 
			and location='#getinfo.location#'
			and (qty-shipped)<>0 
			and fperiod<>'99' 
			and (void = '' or void is null) 
			group by location,batchcode
			order by location,batchcode
		) as b on a.itemno=b.itemno and a.batchcode=b.batchcode and a.location=b.location
		where a.location='#getinfo.location#'
		and a.itemno='#getinfo.itemno#' 
		and ((a.bth_qob+a.bth_qin)-a.bth_qut-ifnull(b.soqty,0)) >='#getinfo.qty#'
		order by a.itemno
	<cfelse>
		select 
		batchcode,rc_type,rc_refno,pallet,importpermit,
		((bth_qob+bth_qin)-bth_qut) as batch_balance,
		expdate as exp_date ,
        milcert
		from lobthob 
		where location='#getinfo.location#' 
		and itemno='#getinfo.itemno#' 
		and ((bth_qob+bth_qin)-bth_qut) >= '#getinfo.qty#' 
		order by itemno
	</cfif>		
<cfelse>
    <cfif HcomID eq "remo_i">
			select 
			a.batchcode,a.pallet,a.importpermit,
			a.itemno,
			a.rc_type,
			a.rc_refno,
			((a.bth_qob+a.bth_qin)-a.bth_qut-ifnull(b.soqty,0)) as batch_balance,
			a.exp_date 
			from obbatch as a 
			left join 
			(
				select 
				batchcode,
				itemno, 
				sum(qty) as soqty 
				from ictran 
				where type='SO' 
				and itemno='#getinfo.itemno#' 
				and (qty-shipped)<>0 
				and fperiod<>'99' 
				and (void = '' or void is null) 
				group by batchcode 
				order by batchcode 
			) as b on a.itemno=b.itemno and a.batchcode=b.batchcode 
			where a.itemno='#getinfo.itemno#' 
			and ((a.bth_qob+a.bth_qin)-a.bth_qut-ifnull(b.soqty,0)) >='#getinfo.qty#'
			order by a.itemno
		<cfelse>
			select 
			batchcode,pallet,importpermit,
			rc_type,
			rc_refno,
			((bth_qob+bth_qin)-bth_qut) as batch_balance,
			exp_date 
			from obbatch 
			where itemno='#getinfo.itemno#'  
			and ((bth_qob+bth_qin)-bth_qut) >='#getinfo.qty#'
			order by itemno
		</cfif>
</cfif>
    
</cfquery>

<cfif getinfo.recordcount neq 0>
	<cfset mc1bil = getinfo.mc1_bil>
	<cfset mc2bil = getinfo.mc2_bil>
	<cfset xbatchcode = getinfo.batchcode>
	<cfset defective = getinfo.defective>
	<cfset qty = getinfo.qty>
    <cfset pallet = getinfo.pallet>
    <cfset milcert = getinfo.milcert>
	<cfif getinfo.expdate neq "">
		<cfset expdate = dateformat(getinfo.expdate,"dd-mm-yyyy")>
	<cfelse>
		<cfset expdate = getinfo.expdate>
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
    	<cfset importpermit=getinfo.importpermit>
<cfelse>
	<cfset mc1bil = "0.00">
	<cfset mc2bil = "0.00">
    <cfset importpermit="">
	<cfset xbatchcode = "">
    <cfset pallet = "0">
	<cfset expdate = "">
    <cfset milcert = "">
	<cfset sodate = "">
	<cfset dodate = "">
	<cfset defective = "">
	<cfset qty = getinfo.qty>
</cfif>
<h1 align="center"><cfoutput><font color="red">#getinfo.location#</font></cfoutput>: Select <cfoutput>#getbatchname.lbatch#</cfoutput> For Item <cfoutput><font color="red">#getinfo.itemno#</font></cfoutput></h1>
<cfform name="form2" action="issdissemble_batch2.cfm" method="post">
<cfoutput>	
	<input type="hidden" name="location" value="#getinfo.location#">
	<input type="hidden" name="tran" value="#getinfo.type#">
    <input type="hidden" name="issdissembleuuid" value="#url.uuid#">
    <input type="hidden" name="issdissembletrancode" value="#url.trancode#">
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
	<tr><td><div id="batchdetail"></div></td></tr>
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
			<select name="enterbatch" id="enterbatch" onchange="getbatchdetail(this.value,'#getinfo.location#','#getinfo.itemno#');">
				<option value="">Select a batch</option>
				<cfloop query="getitembatch">
					<option value="#convertquote(getitembatch.batchcode)#" title="#getitembatch.pallet#" <cfif xbatchcode eq getitembatch.batchcode>selected</cfif>>#getitembatch.batchcode# (balance: #getitembatch.batch_balance#)</option>
				</cfloop>
			</select> 
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
    <tr>
		<th>Width</th>
		<td>
 		<cfinput name="importpermit" id="importpermit" type="text" size="5" value="#val(importpermit)#">
        
        </td>	
	</tr>
    <tr>
		<th>SQM</th>
		<td><cfinput name="pallet" type="text" size="5" readonly value="#pallet#" validate="float" message="Numbers only"></td>	
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