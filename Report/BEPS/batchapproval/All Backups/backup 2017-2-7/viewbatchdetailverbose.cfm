

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
<html>
<head>
	<title>MP4u</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
		<h4>
			Bank info : #getbanktype.banktype#
		</h4>
		<table class="table table-border table-hover">
			<tr>
				<th valign="top" align="left"
				>Batch No</th> <th valign="top" align="left"
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
				<th valign="top" align="right"
				<cfset countid = countid + 1>
				>Basic Pay</th> <th valign="top" align="right"
				<cfset countid = countid + 1>
				>Paid PH &
				<br>
				Leave</th> <th valign="top" align="right"
				<cfset countid = countid + 1>
				>OT</th> <th valign="top" align="right"
				<cfset countid = countid + 1>
				>Payments &
				<br />
				Deductions</th> <th valign="top" align="right"
				<cfset countid = countid + 1>
				>PB/AWS</th> <th valign="top" align="right"
				<cfset countid = countid + 1>
				>EPF/SOCSO/WI/ADM for PB/AWS</th> <th valign="top" align="right"
				<cfset countid = countid + 1>
				>Back/Over Pay</th> <th valign="top" align="right"
				<cfset countid = countid + 1>
				>EPF</th> <th valign="top" align="right"
				<cfset countid = countid + 1>
				>SOCSO</th> <th valign="top" align="right"
				<cfset countid = countid + 1>
				>Admin Fee</th> <th valign="top" align="right"
				<cfset countid = countid + 1>
				>Rebate</th> <th valign="top" align="right"
				<cfset countid = countid + 1>
				>NS</th>
				<th valign="top" align="right">
					Add Ded
				</th>
				<th valign="top" align="left">
					Invoice Gross
				</th>
				<th valign="top" align="left"
				<cfset countid = countid + 1>
				>GST</th> <th valign="top" align="left"
				<cfset countid = countid + 1>
				>Total Invoice</th> <th valign="top" align="left"
				<cfset countid = countid + 1>
				>MA</th> <th
				<cfset countid = countid + 1>
				>&nbsp;</th> <th valign="top" align="left"
				<cfset countid = countid + 1>
				>Employee No</th>
				<th valign="top" align="left">
					Employee
				</th>
				<th valign="top" align="left"
				<cfset countid = countid + 1>
				>CHQ No</th> <th valign="top" align="right"
				<cfset countid = countid + 1>
				>Basic Pay</th> <th valign="top" align="right"
				<cfset countid = countid + 1>
				>Paid PH & Leave</th> <th valign="top" align="right"
				<cfset countid = countid + 1>
				>OT</th> <th valign="top" align="right"
				<cfset countid = countid + 1>
				>Payments & Deductions</th>
				<th valign="top" align="right">
					PB/AWS
				</th>
				<th valign="top" align="right">
					Back/Over Pay
				</th>
				<th valign="top" align="right">
					NS
				</th>
				<th valign="top" align="right">
					EE Gross
				</th>
				<th valign="top" align="right">
					Reimb
				</th>
				<th valign="top" align="right"
				<cfset countid = countid + 1>
				>Deduction</th> <th valign="top" align="right"
				<cfset countid = countid + 1>
				>EE EPF</th>
				<!---<th valign="top" align="right"  <cfset countid = countid + 1>>EE SOCSO</th>--->
				<th valign="top" align="right"
				<cfset countid = countid + 1>
				>TAX</th>
				<th valign="top" align="right" >
					NET PAY /
					<br />
					GIRO Amount
				</th>
				<th valign="top" align="right">
					ER EPF
				</th>
				<th valign="top" align="right">
					SOCSO
				</th>
				<th valign="top" align="right">
					Invoice less Salary
				</th>

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
					<td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.ibasicpay),',.__')#</td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.ipaidlvl),',.__')#</td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.iot),',.__')#</td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.ipayded),',.__')#</td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.ipbaws),',.__')#</td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.ipbawsext),',.__')#</td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.ibackoverpay),',.__')#</td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.icpf),',.__')#</td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.isdf),',.__')#</td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.iadminfee),',.__')#</td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.irebate),',.__')#</td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.ins),',.__')#</td>
					<td  nowrap="nowrap" align="right">
						#numberformat(val(getassignment.iaddcharges),',.__')#
					</td>
					<td  nowrap="nowrap" align="right">
						#numberformat(val(getassignment.invoicegross),',.__')#
					</td>
					<td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.gstamt),',.__')#</td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.totalinv),',.__')#</td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap">#getassignment.multipleassign#</td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap"></td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap">#getassignment.empno#</td>
					<td  nowrap="nowrap">
						#getassignment.empname#
					</td>
					<td
					<cfset countid = countid + 1>
					nowrap="nowrap">#getassignment.chequeno#</td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.pbasicpay),',.__')#</td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.ppaidlvl),',.__')#</td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.pot),',.__')#</td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.ppayded),',.__')#</td>
					<td  nowrap="nowrap" align="right">
						#numberformat(val(getassignment.ppbaws),',.__')#
					</td>
					<td  nowrap="nowrap" align="right">
						#numberformat(val(getassignment.pbackoverpay),',.__')#
					</td>
					<td  nowrap="nowrap" align="right">
						#numberformat(val(getassignment.pns),',.__')#
					</td>
					<td  nowrap="nowrap" align="right">
						#numberformat(val(getassignment.eegross),',.__')#
					</td>
					<td  nowrap="nowrap" align="right">
						#numberformat(val(getassignment.reimb),',.__')#
					</td>
					<td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.deduction),',.__')#</td> <td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.eecpf),',.__')#</td>
					<!---<td  <cfset countid = countid + 1>  nowrap="nowrap" align="right">#numberformat(val(getassignment.eesdf),',.__')#</td>--->
					<td
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.funddd),',.__')#</td>
					<td nowrap="nowrap" align="right">
						#numberformat(val(getassignment.netpay),',.__')#
					</td>
					<td  nowrap="nowrap" align="right">
						#numberformat(val(getassignment.ercpf),',.__')#
					</td>
					<td  nowrap="nowrap" align="right">
						#numberformat(val(getassignment.sdfamt),',.__')#
					</td>
					<td  nowrap="nowrap" align="right">
						#numberformat(getassignment.invless,',.__')#,
						<br>
						Invoice gross - ( Salary + Add Charges - DED + EPF)
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
						<table>
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

	</cfoutput>
</cfif>
</body>
</html>
