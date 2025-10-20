<html>
	<head>
		<title>
			MP4u
		</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<!-- jQuery library -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
		<!-- Latest compiled JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<style>
			.colField{ background-color : 1b4487; color : white; width: 100px; } .colee{ background-color:#FAFAFA; }
			.coler {
				background-color : #E9E9E9;
			}
			.coldata{
				text-align:right;
			}
		</style>
	</head>
	<body>
		<h4>
			Bank info : #getbanktype.banktype#
		</h4>
		<cfif isdefined('url.id')>
			<cfoutput>
				<cfset countid = 1>
				<cfquery name="getassignment" datasource="#dts#">
SELECT uuid, batchno, giropaydate, group_concat(invoiceno) as invoiceno, custid, customer, sum(invoicegross) as invoicegross, sum(gstamt) as gstamt, sum(totalinv) as totalinv, multipleassign, empno, empname, chequeno, sum(eegross) as eegross, sum(reimb) as reimb, sum(deduction) as deduction, sum(eecpf) as eecpf, sum(funddd) as funddd, sum(netpay) as netpay, sum(ercpf) as ercpf, sum(sdfamt) as sdfamt, sum(invless) as invless,  sum(ibasicpay) as ibasicpay, sum(ipaidlvl) as ipaidlvl, sum(iot) as iot, sum(ipayded) as ipayded, sum(ipbaws) as ipbaws, sum(ipbawsext) as ipbawsext, sum(ibackoverpay) as ibackoverpay, sum(icpf) as icpf, sum(isdf) as isdf, sum(iadminfee) as iadminfee, sum(irebate) as irebate, sum(ins) as ins, sum(iaddcharges) as iaddcharges, sum(pbasicpay) as pbasicpay, sum(ppaidlvl) as ppaidlvl, sum(pot) as pot, sum(ppayded) as ppayded, sum(ppbaws) as ppbaws, sum(pbackoverpay) as pbackoverpay, sum(pns) as pns, sum(eesdf) as eesdf, sum(ersdf) as ersdf
FROM icgiro
WHERE uuid = "#url.id#" AND batchno = "#url.batchno#" and empno = "#url.empno#"
GROUP BY empno
</cfquery>
				<cfquery name="getbanktype" datasource="#dts#">
Select banktype from assignmentslip WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.batchno#">
</cfquery>
				<table class="table table-border table-hover">
					<tr>
						<th valign="top" align="left"
							>
							Batch No
						</th>
						<th valign="top" align="left"
						<cfset countid = countid + 1>
						>Giro Pay Date</th>
						<th valign="top" align="left">
							Invoice No
						</th>
						<th valign="top" align="left"
						<cfset countid = countid + 1>
						>Cust ID</th>
						<th valign="top" align="left">
							Customer
						</th>
						<th valign="top" align="left"
						<cfset countid = countid + 1>
						>MA</th> <th valign="top" align="left"
						<cfset countid = countid + 1>
						>Employee No</th>
						<th valign="top" align="left">
							Employee
						</th>
						<th valign="top" align="left"
						<cfset countid = countid + 1>
						>CHQ No</th>
					</tr>
					<cfloop query="getassignment">
						<tr  onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
							<td
							<cfset countid = countid + 1>
							nowrap="nowrap">#getassignment.batchno#</td> <td
							<cfset countid = countid + 1>
							nowrap="nowrap">#dateformat(getassignment.giropaydate,'dd/mm/yyyy')#</td>
							<td  nowrap="nowrap">
								#getassignment.invoiceno#
							</td>
							<td
							<cfset countid = countid + 1>
							nowrap="nowrap">#getassignment.custid#</td>
							<td nowrap="nowrap">
								#getassignment.customer#
							</td>
							<td nowrap="nowrap">
								#getassignment.multipleassign#
							</td>
							<td
							<cfset countid = countid + 1>
							nowrap="nowrap">#getassignment.empno#</td>
							<td  nowrap="nowrap">
								#getassignment.empname#
							</td>
						</tr>
					</cfloop>
					<cfquery name="gettotal" datasource="#dts#">
SELECT * FROM argiro WHERE id = "#url.id#"
</cfquery>
					<cfquery name="getremark" datasource="#dts#">
SELECT assigndesp,refno,batches FROM assignmentslip
WHERE
refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getassignment.invoiceno)#" list="yes" separator=",">)
AND assigndesp <> ""
AND assigndesp is not null
ORDER BY batches,refno
</cfquery>
					<cfif getremark.recordcount neq 0>
						<tr>
							<td colspan="100%">
								<table >
									<tr>
										<th>
											Batch No
										</th>
										<th>
											Invoice No
										</th>
										<th>
											Remark
										</th>
									</tr>
									<cfloop query="getremark">
										<tr>
											<td>
												#getremark.batches#
											</td>
											<td>
												#getremark.refno#
											</td>
											<td>
												#getremark.assigndesp#
											</td>
										</tr>
									</cfloop>
								</table>
							</td>
						</tr>
					</cfif>
				</table>
				<br />
				<hr />
				<br />
				<table class="table table-hover table-border" style="width:600px;">
					<tr>
						<td >
						</td>
						<th colspan='1'>
							Employer
						</th>
						<th colspan='1'>
							Employee
						</th>
					</tr>
					<tr>
						<td class="colField">
							Basic Pay
						</td>
						<td class="colER coldata">
							#numberformat(val(getassignment.ibasicpay),',.__')#
						</td>
						<td class="colEE coldata">
							#numberformat(val(getassignment.pbasicpay),',.__')#
						</td>
					</tr>
					<tr>
						<td class="colField">
							Paid PH & Leave
						</td>
						<td class="colER coldata">
							#numberformat(val(getassignment.ipaidlvl),',.__')#
						</td>
						<td class="colEE coldata">
							#numberformat(val(getassignment.ppaidlvl),',.__')#
						</td>
					</tr>
					<tr>
						<td class="colField">
							OT
						</td>
						<td class="colER coldata">
							#numberformat(val(getassignment.iot),',.__')#
						</td>
						<td class="colEE coldata">
							#numberformat(val(getassignment.pot),',.__')#
						</td>
					</tr>
					<tr>
						<td class="colField">
							Payments & Deductions
						</td>
						<td class="colER coldata">
							#numberformat(val(getassignment.ipayded),',.__')#
						</td>
						<td class="colEE coldata">
							#numberformat(val(getassignment.ppayded),',.__')#
						</td>
					</tr>
					<tr>
						<td class="colField">
							PB/AWS
						</td>
						<td class="colER coldata">
							#numberformat(val(getassignment.ipbaws),',.__')#
						</td>
						<td class="colEE coldata">
							#numberformat(val(getassignment.ppbaws),',.__')#
						</td>
					</tr>
					<tr>
						<td class="colField">
							EPF/SOCSO/WI/ADM for PB/AWS
						</td>
						<td class="colER coldata">
							#numberformat(val(getassignment.ipbawsext),',.__')#
						</td>
						<td class="colEE coldata">
							-
						</td>
					</tr>
					<tr>
						<td class="colField">
							Back/Over Pay
						</td>
						<td class="colER coldata">
							#numberformat(val(getassignment.ibackoverpay),',.__')#
						</td>
						<td class="colEE coldata">
							#numberformat(val(getassignment.pbackoverpay),',.__')#
						</td>
					</tr>
					<tr>
						<td class="colField">
							EPF
						</td>
						<td class="colER coldata">
							#numberformat(val(getassignment.ercpf),',.__')#
						</td>
						<td class="colEE coldata">
							#numberformat(val(getassignment.eecpf),',.__')#
						</td>
					</tr>
					<tr>
						<td class="colField">
							SOCSO
						</td>
						<td class="colER coldata">
							#numberformat(val(getassignment.ersdf),',.__')#
						</td>
						<td class="colEE coldata">
							#numberformat(val(getassignment.eesdf),',.__')#
						</td>
					</tr>
					<tr>
						<td class="colField">
							Admin Fee
						</td>
						<td class="colER coldata">
							#numberformat(val(getassignment.iadminfee),',.__')#
						</td>
						<td class="colEE coldata">
							-
						</td>
					</tr>
					<tr>
						<td class="colField">
							Rebate
						</td>
						<td class="colER coldata">
							#numberformat(val(getassignment.irebate),',.__')#
						</td>
						<td class="colEE coldata">
							-
						</td>
					</tr>
					<tr>
						<td class="colField">
							NS
						</td>
						<td class="colER coldata">
							#numberformat(val(getassignment.ins),',.__')#
						</td>
						<td class="colEE coldata">
							#numberformat(val(getassignment.pns),',.__')#
						</td>
					</tr>
					<tr>
						<td class="colField">
							Add Ded
						</td>
						<td class="colER coldata">
							#numberformat(val(getassignment.iaddcharges),',.__')#
						</td>
						<td class="colEE coldata">
							-
						</td>
					</tr>
					<tr>
						<Td class="colField">
							Deduction
						</Td>
						<td class="colER coldata">
						</td>
						<td class="colEE coldata">
							#numberformat(val(getassignment.deduction),',.__')#
						</td>
					</tr>
					<tr>
						<td class="colField">
							Invoice Gross
						</td>
						<td class="colER coldata">
							#numberformat(val(getassignment.invoicegross),',.__')#
						</td>
						<td class="colEE coldata">
						</td>
					</tr>
					<tr>
						<td class="colField">
							GST Total Invoice
						</td>
						<td class="colER coldata">
							#numberformat(val(getassignment.gstamt),',.__')#
						</td>
						<td class="colEE coldata">
						</td>
					</tr>
					<tr>
						<td class="colField">
							Total Invoice
						</td>
						<td class="colER coldata">
							#numberformat(val(getassignment.totalinv),',.__')#
						</td>
						<td class="colEE coldata">
						</td>
					</tr>
					<tr>
						<td class="colField">
							EE Gross
						</td>
						<td class="colER coldata">
							-
						</td>
						<td class="colEE coldata">
							#numberformat(val(getassignment.eegross),',.__')#
						</td>
					</tr>
					<tr>
						<td class="colField">
							Nett Giro
						</td>
						<td class="colER coldata">
							-
						</td>
						<td class="colEE coldata">
							#numberformat(val(getassignment.netpay),',.__')#
						</td>
					</tr>
				</table>
			</cfoutput>
		</cfif>
	</body>
</html>
