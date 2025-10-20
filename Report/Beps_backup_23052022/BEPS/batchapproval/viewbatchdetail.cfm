<cfif isdefined('url.id')>
	<cfset displayphrase = 'id="nodisplay$$countid$$" style="display:none"'>
	<cfoutput>
		<cfset countid = 1>
		<cfquery name="getassignment" datasource="#dts#">
SELECT uuid, batchno, giropaydate, group_concat(invoiceno) as invoiceno, custid, customer, sum(invoicegross) as invoicegross, sum(gstamt) as gstamt, sum(totalinv) as totalinv, multipleassign, empno, empname, chequeno, sum(eegross) as eegross, sum(reimb) as reimb, sum(deduction) as deduction, sum(eecpf) as eecpf, sum(funddd) as funddd, sum(netpay) as netpay, sum(ercpf) as ercpf, sum(sdfamt) as sdfamt, sum(invless) as invless,  sum(ibasicpay) as ibasicpay, sum(ipaidlvl) as ipaidlvl, sum(iot) as iot, sum(ipayded) as ipayded, sum(ipbaws) as ipbaws, sum(ipbawsext) as ipbawsext, sum(ibackoverpay) as ibackoverpay, sum(icpf) as icpf, sum(isdf) as isdf, sum(iadminfee) as iadminfee, sum(irebate) as irebate, sum(ins) as ins, sum(iaddcharges) as iaddcharges, sum(pbasicpay) as pbasicpay, sum(ppaidlvl) as ppaidlvl, sum(pot) as pot, sum(ppayded) as ppayded, sum(ppbaws) as ppbaws, sum(pbackoverpay) as pbackoverpay, sum(pns) as pns,
 sum(eesdf) as eesdf, sum(ersdf) as ersdf
FROM icgiro
WHERE mainid = "#url.id#"
GROUP BY empno
</cfquery>
		<cfquery name="getbanktype" datasource="#dts#">
Select banktype from assignmentslip WHERE batches = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.batchno#">
</cfquery>
		<h4>
			Bank info : #getbanktype.banktype#
		</h4>
		<table border="1">
			<tr>
				<th valign="top" align="left" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>Batch No</th> <th valign="top" align="left" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>Giro Pay Date</th>
				<th valign="top" align="left">
					Invoice No
				</th>
				<th valign="top" align="left" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>Cust ID</th>
				<th valign="top" align="left">
					Customer
				</th>
				<th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>Basic Pay</th> <th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>Paid PH &
				<br>
				Leave</th> <th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>OT</th> <th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>Payments &
				<br />
				Deductions</th> <th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>PB/AWS</th> <th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>EPF/SOCSO/WI/ADM for PB/AWS</th> <th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>Back/Over Pay</th> <th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>EPF</th> <th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>SOCSO</th> <th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>Admin Fee</th> <th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>Rebate</th> <th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>NS</th>
				<th valign="top" align="right">
					Add Ded
				</th>
				<th valign="top" align="left">
					Invoice Gross
				</th>
				<th valign="top" align="left" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>GST</th> <th valign="top" align="left" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>Total Invoice</th> <th valign="top" align="left" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>MA</th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>&nbsp;</th> <th valign="top" align="left" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>Employee No</th>
				<th valign="top" align="left">
					Employee
				</th>
				<th valign="top" align="left" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>CHQ No</th> <th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>Basic Pay</th> <th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>Paid PH & Leave</th> <th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>OT</th> <th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)#
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
				<th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>Deduction</th> <th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>EE EPF</th>
				<!---<th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)# <cfset countid = countid + 1>>EE SOCSO</th>--->
				<th valign="top" align="right" #replace(displayphrase,'$$countid$$',countid)#
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
					<td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap">#getassignment.batchno#</td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap">#dateformat(getassignment.giropaydate,'dd/mm/yyyy')#</td>
					<td  nowrap="nowrap">
						#getassignment.invoiceno#
					</td>
					<td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap">#getassignment.custid#</td>
					<td nowrap="nowrap">
						#getassignment.customer#
					</td>
					<td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.ibasicpay),',.__')#</td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.ipaidlvl),',.__')#</td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.iot),',.__')#</td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.ipayded),',.__')#</td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.ipbaws),',.__')#</td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.ipbawsext),',.__')#</td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.ibackoverpay),',.__')#</td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.icpf),',.__')#</td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.eesdf),',.__')#</td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.iadminfee),',.__')#</td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.irebate),',.__')#</td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.ins),',.__')#</td>
					<td  nowrap="nowrap" align="right">
						#numberformat(val(getassignment.iaddcharges),',.__')#
					</td>
					<td  nowrap="nowrap" align="right">
						#numberformat(val(getassignment.invoicegross),',.__')#
					</td>
					<td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.gstamt),',.__')#</td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.totalinv),',.__')#</td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap">#getassignment.multipleassign#</td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap"></td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap">#getassignment.empno#</td>
					<td  nowrap="nowrap">
						#getassignment.empname#
					</td>
					<td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap">#getassignment.chequeno#</td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.pbasicpay),',.__')#</td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.ppaidlvl),',.__')#</td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.pot),',.__')#</td> <td #replace(displayphrase,'$$countid$$',countid)#
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
					<td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.deduction),',.__')#</td> <td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.eecpf),',.__')#</td>
					<!---<td #replace(displayphrase,'$$countid$$',countid)# <cfset countid = countid + 1>  nowrap="nowrap" align="right">#numberformat(val(getassignment.eesdf),',.__')#</td>--->
					<td #replace(displayphrase,'$$countid$$',countid)#
					<cfset countid = countid + 1>
					nowrap="nowrap" align="right">#numberformat(val(getassignment.funddd),',.__')#</td>
					<td nowrap="nowrap" align="right">
						#numberformat(val(getassignment.netpay),',.__')#
					</td>
					<td  nowrap="nowrap" align="right">
						#numberformat(val(getassignment.ercpf),',.__')#
					</td>
					<td  nowrap="nowrap" align="right">
						#numberformat(val(getassignment.ersdf),',.__')#
					</td>
					<td  nowrap="nowrap" align="right">
						#numberformat(getassignment.invless,',.__')#,
						<br>
						Invoice gross - ( Salary + Add Charges - DED + EPF)
					</td>
					<th><a href="viewbatchdetailverbose.cfm?id=#getassignment.uuid#&batchno=#getassignment.batchno#&empno=#getassignment.empno#" target="_blank">View Detail</a></th>
				</tr>
			</cfloop>
			<cfquery name="gettotal" datasource="#dts#">
SELECT * FROM argiro WHERE id = "#url.id#"
</cfquery>
			<tr>
				<th align="left">
					Total
				</th>
				<th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				></th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				></th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				></th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				></th>
				<th >
				</th>
				<th align="right" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>#numberformat(gettotal.ibasicpay,',.__')#</th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				align="right">#numberformat(gettotal.ipaidlvl,',.__')#</th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				align="right">#numberformat(gettotal.iot,',.__')#</th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				align="right">#numberformat(gettotal.ipayded,',.__')#</th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				align="right">#numberformat(gettotal.ipbaws,',.__')#</th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				align="right">#numberformat(gettotal.ipbawsext,',.__')#</th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				align="right">#numberformat(gettotal.ibackoverpay,',.__')#</th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				align="right">#numberformat(gettotal.icpf,',.__')#</th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				align="right">#numberformat(gettotal.eesdf,',.__')#</th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				align="right">#numberformat(gettotal.iadminfee,',.__')#</th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				align="right">#numberformat(gettotal.irebate,',.__')#</th> <th align="right" #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				>#numberformat(gettotal.ins,',.__')#</th>
				<th align="right">
					#numberformat(gettotal.iaddcharges,',.__')#
				</th>
				<th align="right">
					#numberformat(gettotal.invgross,',.__')#
				</th>
				<th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				align="right">#numberformat(gettotal.gstamt,',.__')#</th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				align="right">#numberformat(gettotal.totalinv,',.__')#</th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				></th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				></th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				></th>
				<th >
				</th>
				<th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				></th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				align="right">#numberformat(gettotal.pbasicpay,',.__')#</th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				align="right">#numberformat(gettotal.ppaidlvl,',.__')#</th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				align="right">#numberformat(gettotal.pot,',.__')#</th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				align="right">#numberformat(gettotal.ppayded,',.__')#</th>
				<th  align="right">
					#numberformat(gettotal.ppbaws,',.__')#
				</th>
				<th  align="right">
					#numberformat(gettotal.pbackoverpay,',.__')#
				</th>
				<th  align="right">
					#numberformat(gettotal.pns,',.__')#
				</th>
				<th align="right">
					#numberformat(gettotal.eegross,',.__')#
				</th>
				<th align="right">
					#numberformat(gettotal.reimb,',.__')#
				</th>
				<th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				align="right">#numberformat(gettotal.dedamt,',.__')#</th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				align="right">#numberformat(gettotal.eecpf,',.__')#</th> <th #replace(displayphrase,'$$countid$$',countid)#
				<cfset countid = countid + 1>
				align="right">#numberformat(gettotal.funddd,',.__')#</th>
				<th align="right">
					#numberformat(gettotal.netpay,',.__')#
				</th>
				<th align="right">
					#numberformat(gettotal.ercpf,',.__')#
				</th>
				<th align="right">
					#numberformat(gettotal.sdf,',.__')#
				</th>
				<th align="right">
					#numberformat(gettotal.invless,',.__')#
				</th>
			</tr>
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
			<tr>
				<td colspan="8">
					<input type="button" name="back_btn" id="back_btn" value="Back" onClick="history.go(-1)">
					&nbsp;&nbsp;&nbsp;
					<input type="button" name="detail_btn" id="detail_btn" value="View Detail" onClick="displayfield();">
				</td>
				<td align="right" colspan="34">
					<input type="button" name="back_btn" id="back_btn" value="Back" onClick="history.go(-1)">
				</td>
			</tr>
		</table>
		<script type="text/javascript">
function displayfield()
{
	if(document.getElementById('nodisplay1').style.display == 'none')
	{
		for(var i = 1; i<#countid#; i++)
		{
	document.getElementById('nodisplay'+i).style.display = 'block';
		}
		document.getElementById('detail_btn').value = "Hide Detail";
	}
	else{
		for(var i = 1; i<#countid#; i++)
		{
	document.getElementById('nodisplay'+i).style.display = 'none';
		}

		document.getElementById('detail_btn').value = "View Detail";
	}
}
</script>
	</cfoutput>
</cfif>
