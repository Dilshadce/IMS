<cfoutput>
	<cfif isdefined('url.profileid')>
		<cfquery name="getCFSEmpProfile" datasource="#dts#">
		SELECT * FROM cfsempinprofile
		WHERE profileid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.profileid#">
		</cfquery>
		<cfquery name="getprofilelist" datasource="#dts#">
		SELECT profilename,empno,ratetype,payrate,billrate,adminfee,adminFeeCap,custno FROM paybillprofile
		WHERE id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.profileid#">
		</cfquery>
		<cfquery name="getemplist" datasource="#dts#">
		SELECT id,icno,name,name2 FROM cfsemp
		WHERE id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getprofilelist.empno#">
		</cfquery>
		
	</cfif>
	<script type="text/javascript">
function calpaybill(qty,ratetype,payrate,billrate,adminfee,id){

	if (ratetype == "day")
	{
		var totalpay = Number(payrate)*Number(qty);
		var totalbill = Number(billrate)*Number(qty);
		if(adminfee.search('%') > 0){
			var admin = adminfee.replace('%','');
			var totaladmin = Number(totalbill)*(Number(admin)/100);
			document.getElementById('adminfeeamt'+id+'').value = totaladmin;
		}else{
			document.getElementById('adminfeeamt'+id+'').value = adminfee;
		}
		document.getElementById('totalpayamt'+id+'').value = totalpay;
		document.getElementById('totalbillamt'+id+'').value = totalbill;
		document.getElementById('totalpayamtfix'+id+'').value = totalpay;
		document.getElementById('totalbillamtfix'+id+'').value = totalbill;
	}else if(ratetype == "hour")
	{
		var totalpay = Number(payrate)*Number(qty);
		var totalbill = Number(billrate)*Number(qty);
		if(adminfee.search('%') > 0){
			var admin = adminfee.replace('%','');
			var totaladmin = Number(totalbill)*(Number(admin)/100);
			document.getElementById('adminfeeamt'+id+'').value = totaladmin;
		}else{
			document.getElementById('adminfeeamt'+id+'').value = adminfee;
		}
		document.getElementById('totalpayamt'+id+'').value = totalpay;
		document.getElementById('totalbillamt'+id+'').value = totalbill;
		document.getElementById('totalpayamtfix'+id+'').value = totalpay;
		document.getElementById('totalbillamtfix'+id+'').value = totalbill;
	}else if(ratetype.toLowerCase() == "mth")
	{
		var totalpay = Number(payrate)*Number(qty);
		var totalbill = Number(billrate)*Number(qty);
		if(adminfee.search('%') > 0){
			var admin = adminfee.replace('%','');
			var totaladmin = Number(totalbill)*(Number(admin)/100);
			document.getElementById('adminfeeamt'+id+'').value = totaladmin;
		}else{
			document.getElementById('adminfeeamt'+id+'').value = adminfee;
		}
		document.getElementById('totalpayamt'+id+'').value = totalpay;
		document.getElementById('totalbillamt'+id+'').value = totalbill;
		document.getElementById('totalpayamtfix'+id+'').value = totalpay;
		document.getElementById('totalbillamtfix'+id+'').value = totalbill;
	}else
	{
		alert("Rate type empty");
	}

	<cfif getprofilelist.adminFeeCap GT 0 >
		if(document.getElementById("adminfeeamt"+id+'').value > 2500){
			document.getElementById('adminfeeamt' + id).value = 2500;
		}
	</cfif>
};

function recalc(id,adminfee){
	var newpayamt = 0.00;
	var newbillamt = 0.00;
	var misctotal = 0.00;
	var misctotalx = 0.00;

	var payamt = document.getElementById('totalpayamtfix'+id+'').value;
	var billamt = document.getElementById('totalbillamtfix'+id+'').value;
	for(i=1; i<6; i++){
		var miscamt = document.getElementById('misc'+i+id+'').value;
		if(miscamt.search('-') >0){
			var misc = miscamt.replace('-','');
			misctotal -=(Number(misc)*1);
		}else{
			misctotal +=(Number(miscamt)*1);
		}
	}

	for(i=1; i<6; i++){
		var miscamt = document.getElementById('miscx'+i+id+'').value;
		if(miscamt.search('-') >0){
			var misc = miscamt.replace('-','');
			misctotalx -=(Number(misc)*1);
		}else{
			misctotalx +=(Number(miscamt)*1);
		}
	}

	newpayamt = (Number(payamt)*1)+(Number(misctotal)*1);
	newbillamt = (Number(billamt)*1)+(Number(misctotal)*1);

	if(adminfee.search('%') >0){
			var admin = adminfee.replace('%','');
			var totalbill = newbillamt;
			var totaladmin = Number(totalbill)*(Number(admin)/100);
			document.getElementById('adminfeeamt'+id+'').value = totaladmin;
	}else{
			document.getElementById('adminfeeamt'+id+'').value = adminfee;
		}

	newpayamt += (Number(misctotalx)*1);
	newbillamt += (Number(misctotalx)*1);

	document.getElementById('totalpayamt'+id+'').value = Number(newpayamt);
	document.getElementById('totalbillamt'+id+'').value = Number(newbillamt);

	<cfif getprofilelist.adminFeeCap GT 0 >
		if(document.getElementById("adminfeeamt"+id+'').value > 2500){
			document.getElementById('adminfeeamt' + id).value = 2500;
		}
	</cfif>
}
/*function recalcx(id){
	var newpayamt = 0.00;
	var newbillamt = 0.00;
	var misctotal = 0.00;

	var payamt = document.getElementById('totalpayamtfix'+id+'').value;
	var billamt = document.getElementById('totalbillamtfix'+id+'').value;
	for(i=1; i<6; i++){
		var miscamt = document.getElementById('miscx'+i+id+'').value;
		if(miscamt.search('-') >0){
			var misc = miscamt.replace('-','');
			misctotal -=(Number(misc)*1);
		}else{
			misctotal +=(Number(miscamt)*1);
		}
	}

	newpayamt = (Number(payamt)*1)+(Number(misctotal)*1);
	newbillamt = (Number(billamt)*1)+(Number(misctotal)*1);

	document.getElementById('totalpayamt'+id+'').value = Number(newpayamt);
	document.getElementById('totalbillamt'+id+'').value = Number(newbillamt);
};*/
</script>
	<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	<style>
		table { font-family: arial, sans-serif; border-collapse: collapse; width: 100%; } td, th { border: 1px solid ##dddddd; text-align: left; padding: 8px; } tr:nth-child(even) { background-color: ##dddddd; }
	</style>
	<cfif isdefined('url.type') and isdefined('url.id') AND url.type eq "Edit">
		<cfquery name="gettran" datasource="#dts#">
				select g.*,name,c.id as empId FROM geninvbankfile g LEFT JOIN CFSEmp c ON g.empno = c.id
				WHERE g.CFSTransactionBatch = #url.id#
		</cfquery>
		<cfform action="/CFSpaybill/generateInvoiceBankfileprocess.cfm?type=edit&profileid=#url.profileid#&id=#url.id#" name="form">
			<input type="hidden" name="custno" value="<cfoutput>#getprofilelist.custno#</cfoutput>" >
			<input type="hidden" name="transactionId" value="#url.id#">
			<table>
				<tr>
					<th>
						Name
					</th>
					<th>
						IC No.
					</th>
					<th>
						Total #getprofilelist.ratetype# worked
					</th>
					<th>
						Misc
					</th>
					<th>
						Total Pay
					</th>
					<th>
						Total Bill
					</th>
					<th>
						Total Admin Fee
					</th>
					<th>
						Taxable
					</th>
				</tr>
				<cfloop query="gettran">
					<tr>
						<td>
							#gettran.name#
						</td>
						<td>
							#gettran.icno#
						</td>
						<td>
							<input type="text" id="workdays#gettran.empId#"  name="workdays#gettran.empId#" value="#gettran.workdays#" onKeyUp="calpaybill(this.value,'#getprofilelist.ratetype#','#getprofilelist.payrate#','#getprofilelist.billrate#','#getprofilelist.adminfee#','#getemplist.id#')">
						</td>
						<td>
							<input type="text" id="miscrem1#gettran.empId#"  name="miscrem1#gettran.empId#" value="#gettran.rem1#" placeholder="Remark 1">
							&nbsp;
							<input type="text" id="misc1#gettran.empId#"  name="misc1#gettran.empId#" value="#gettran.misc1#" onChange="recalc('#gettran.empId#','#getprofilelist.adminfee#')">
							<br>
							<input type="text" id="miscrem2#gettran.empId#"  name="miscrem2#gettran.empId#" value="#gettran.rem2#"  placeholder="Remark 2">
							&nbsp;
							<input type="text" id="misc2#gettran.empId#"  name="misc2#gettran.empId#" value="#gettran.misc2#" onChange="recalc('#gettran.empId#','#getprofilelist.adminfee#')">
							<br>
							<input type="text" id="miscrem3#gettran.empId#"  name="miscrem3#gettran.empId#" value="#gettran.rem3#" placeholder="Remark 3">
							&nbsp;
							<input type="text" id="misc3#gettran.empId#"  name="misc3#gettran.empId#" value="#gettran.misc3#" onChange="recalc('#gettran.empId#','#getprofilelist.adminfee#')">
							<br>
							<input type="text" id="miscrem4#gettran.empId#"  name="miscrem4#gettran.empId#" value="#gettran.rem4#"  placeholder="Remark 4">
							&nbsp;
							<input type="text" id="misc4#gettran.empId#"  name="misc4#gettran.empId#" value="#gettran.misc4#" onChange="recalc('#gettran.empId#','#getprofilelist.adminfee#')">
							<br>
							<input type="text" id="miscrem5#gettran.empId#"  name="miscrem5#gettran.empId#" value="#gettran.rem5#"  placeholder="Remark 5">
							&nbsp;
							<input type="text" id="misc5#gettran.empId#"  name="misc5#gettran.empId#" value="#gettran.misc5#"  onChange="recalc('#gettran.empId#','#getprofilelist.adminfee#')">
							<br>
							<strong>
								Without Admin Fee
							</strong>
							<br>
							<input type="text" id="miscrem11#gettran.empId#"  name="miscrem11#gettran.empId#" value="#gettran.remx1#" placeholder="Remark 1">
							&nbsp;
							<input type="text" id="miscx1#gettran.empId#"  name="miscx1#gettran.empId#" value="#gettran.miscx1#" onChange="recalc('#gettran.empId#','#getprofilelist.adminfee#')">
							<br>
							<input type="text" id="miscrem22#gettran.empId#"  name="miscrem22#gettran.empId#" value="#gettran.remx2#"  placeholder="Remark 2">
							&nbsp;
							<input type="text" id="miscx2#gettran.empId#"  name="miscx2#gettran.empId#" value="#gettran.miscx2#" onChange="recalc('#gettran.empId#','#getprofilelist.adminfee#')">
							<br>
							<input type="text" id="miscrem33#gettran.empId#"  name="miscrem33#gettran.empId#" value="#gettran.remx3#" placeholder="Remark 3">
							&nbsp;
							<input type="text" id="miscx3#gettran.empId#"  name="miscx3#gettran.empId#" value="#gettran.miscx3#" onChange="recalc('#gettran.empId#','#getprofilelist.adminfee#')">
							<br>
							<input type="text" id="miscrem44#gettran.empId#"  name="miscrem44#gettran.empId#" value="#gettran.remx4#"  placeholder="Remark 4">
							&nbsp;
							<input type="text" id="miscx4#gettran.empId#"  name="miscx4#gettran.empId#" value="#gettran.miscx4#" onChange="recalc('#gettran.empId#','#getprofilelist.adminfee#')">
							<br>
							<input type="text" id="miscrem55#gettran.empId#"  name="miscrem55#gettran.empId#" value="#gettran.remx5#"  placeholder="Remark 5">
							&nbsp;
							<input type="text" id="miscx5#gettran.empId#"  name="miscx5#gettran.empId#" value="#gettran.miscx5#"  onChange="recalc('#gettran.empId#','#getprofilelist.adminfee#')">
						</td>
						<td>
							<input type="hidden" id="totalpayamtfix#gettran.empId#"  name="totalpayamtfix#gettran.empId#" value="#gettran.payamt#">
							<input type="text" id="totalpayamt#gettran.empId#"  name="totalpayamt#gettran.empId#" value="#gettran.payamt#" readonly>
							<br>
							Pay rate: #getprofilelist.payrate#
						</td>
						<td>
							<input type="hidden" id="totalbillamtfix#gettran.empId#"  name="totalbillamtfix#gettran.empId#" value="#gettran.billamt#">
							<input type="text" id="totalbillamt#gettran.empId#"  name="totalbillamt#gettran.empId#" value="#gettran.billamt#" readonly>
							<br>
							Bill rate: #getprofilelist.billrate#
						</td>
						<td>
							<input type="text" id="adminfeeamt#gettran.empId#"  name="adminfeeamt#gettran.empId#" value="#gettran.adminfeeamt#" readonly>
							<br>
							Admin Fee: #getprofilelist.adminfee#
						</td>
						<td>
							<input type="checkbox" name="taxable_#gettran.empId#"
							<cfif gettran.taxcode eq 'SR'>
								checked
							</cfif>
							>
						</td>
					</tr>
				</cfloop>
				<tr>
					<td colspan="100%" style="text-align:right">
						<cfif getemplist.recordcount eq 0>
						<cfelse>
							<cfinput  type="submit" name="Submit" value=" Save " validate="submitonce"/>
							&nbsp;&nbsp;
							<cfinput  type="submit" name="Submit" value=" Generate Bankfile Now " validate="submitonce"/>
						</cfif>
					</td>
				</tr>
			</table>
		</cfform>
	<cfelse>
		<cfform action="/CFSpaybill/generateInvoiceBankfileprocess.cfm?type=add&profileid=#url.profileid#" name="form">
			<input type="hidden" name="custno" value="<cfoutput>#getprofilelist.custno#</cfoutput>" >
			<table>
				<tr>
					<th>
						Name
					</th>
					<th>
						IC No.
					</th>
					<th>
						Total #getprofilelist.ratetype# worked
					</th>
					<th>
						Misc
					</th>
					<th>
						Total Pay
					</th>
					<th>
						Total Bill
					</th>
					<th>
						Total Admin Fee
					</th>
					<th>
						Taxable
					</th>
				</tr>
				<cfif getprofilelist.empno eq ''>
					<tr>
						<td valign="top" colspan="100%" class="dataTables_empty">
							There is no Contractor tag to the selected profile.
						</td>
					</tr>
				<cfelse>
					<cfloop query="getprofilelist">
						<tr>
							<td>
								#getemplist.name# #getemplist.name2#
							</td>
							<td>
								#getemplist.icno#
							</td>
							<td>
								<input type="text" id="workdays#getemplist.id#"  name="workdays#getemplist.id#" value="0" onKeyUp="calpaybill(this.value,'#getprofilelist.ratetype#','#getprofilelist.payrate#','#getprofilelist.billrate#','#getprofilelist.adminfee#','#getemplist.id#')">
							</td>
							<td>
								<strong>
									With Admin Fee
								</strong>
								<br>
								<input type="text" id="miscrem1#getemplist.id#"  name="miscrem1#getemplist.id#" value="" placeholder="Remark 1">

								<input type="text" id="misc1#getemplist.id#"  name="misc1#getemplist.id#" value="0" onChange="recalc('#getemplist.id#','#getprofilelist.adminfee#')">
								<br>
								<input type="text" id="miscrem2#getemplist.id#"  name="miscrem2#getemplist.id#" value=""  placeholder="Remark 2">

								<input type="text" id="misc2#getemplist.id#"  name="misc2#getemplist.id#" value="0" onChange="recalc('#getemplist.id#','#getprofilelist.adminfee#')">
								<br>
								<input type="text" id="miscrem3#getemplist.id#"  name="miscrem3#getemplist.id#" value="" placeholder="Remark 3">

								<input type="text" id="misc3#getemplist.id#"  name="misc3#getemplist.id#" value="0" onChange="recalc('#getemplist.id#','#getprofilelist.adminfee#')">
								<br>
								<input type="text" id="miscrem4#getemplist.id#"  name="miscrem4#getemplist.id#" value=""  placeholder="Remark 4">

								<input type="text" id="misc4#getemplist.id#"  name="misc4#getemplist.id#" value="0" onChange="recalc('#getemplist.id#','#getprofilelist.adminfee#')">
								<br>
								<input type="text" id="miscrem5#getemplist.id#"  name="miscrem5#getemplist.id#" value=""  placeholder="Remark 5">

								<input type="text" id="misc5#getemplist.id#"  name="misc5#getemplist.id#" value="0"  onChange="recalc('#getemplist.id#','#getprofilelist.adminfee#')">
								<br>
								<strong>
									Without Admin Fee
								</strong>
								<br>
								<input type="text" id="miscrem11#getemplist.id#"  name="miscrem11#getemplist.id#" value="" placeholder="Remark 1">

								<input type="text" id="miscx1#getemplist.id#"  name="miscx1#getemplist.id#" value="0" onChange="recalc('#getemplist.id#','#getprofilelist.adminfee#')">
								<br>
								<input type="text" id="miscrem22#getemplist.id#"  name="miscrem22#getemplist.id#" value=""  placeholder="Remark 2">

								<input type="text" id="miscx2#getemplist.id#"  name="miscx2#getemplist.id#" value="0" onChange="recalc('#getemplist.id#','#getprofilelist.adminfee#')">
								<br>
								<input type="text" id="miscrem33#getemplist.id#"  name="miscrem33#getemplist.id#" value="" placeholder="Remark 3">

								<input type="text" id="miscx3#getemplist.id#"  name="miscx3#getemplist.id#" value="0" onChange="recalc('#getemplist.id#','#getprofilelist.adminfee#')">
								<br>
								<input type="text" id="miscrem44#getemplist.id#"  name="miscrem44#getemplist.id#" value=""  placeholder="Remark 4">

								<input type="text" id="miscx4#getemplist.id#"  name="miscx4#getemplist.id#" value="0" onChange="recalc('#getemplist.id#','#getprofilelist.adminfee#')">
								<br>
								<input type="text" id="miscrem55#getemplist.id#"  name="miscrem55#getemplist.id#" value=""  placeholder="Remark 5">

								<input type="text" id="miscx5#getemplist.id#"  name="miscx5#getemplist.id#" value="0"  onChange="recalc('#getemplist.id#','#getprofilelist.adminfee#')">
							</td>
							<td>
								<input type="hidden" id="totalpayamtfix#getemplist.id#"  name="totalpayamtfix#getemplist.id#" value="0">
								<input type="text" id="totalpayamt#getemplist.id#"  name="totalpayamt#getemplist.id#" value="0" readonly>
								<br>
								Pay rate: #getprofilelist.payrate#
							</td>
							<td>
								<input type="hidden" id="totalbillamtfix#getemplist.id#"  name="totalbillamtfix#getemplist.id#" value="0">
								<input type="text" id="totalbillamt#getemplist.id#"  name="totalbillamt#getemplist.id#" value="0" readonly>
								<br>
								Bill rate: #getprofilelist.billrate#
							</td>
							<td>
								<input type="text" id="adminfeeamt#getemplist.id#"  name="adminfeeamt#getemplist.id#" value="0" readonly>
								<br>
								Admin Fee: #getprofilelist.adminfee#
							</td>
							<td>
								<input type="checkbox" name="taxable_#getemplist.id#">
							</td>
						</tr>
					</cfloop>
					<tr>
						<td colspan="100%" style="text-align:right">
							<cfif getemplist.recordcount eq 0>
							<cfelse>
								<cfinput  type="submit" name="Submit" value=" Save " validate="submitonce"/>
								&nbsp;&nbsp;
								<cfinput  type="submit" name="Submit" value=" Generate Bankfile Now " validate="submitonce"/>
							</cfif>
						</td>
					</tr>
				</cfif>
			</table>
		</cfform>
	</cfif>
</cfoutput>
