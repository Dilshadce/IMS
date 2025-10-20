<cfajaximport tags="cfform">
<html>
	<head>
		<title>
			Giro Control Report
		</title>
		<link href="/stylesheet/stylesheetnew.css" rel="stylesheet" type="text/css">
		<script language="javascript" type="text/javascript" src="/scripts/collapse_expand_single_item.js"></script>
		<script type="text/javascript" src="/scripts/ajax.js"></script>
	</head>
	<body>
		<cfoutput>
			<h3>
				<a>
					<font size="3">
						Batch Control Approval and Status
					</font>
				</a>
			</h3>
			<input type="hidden" name="hidid" id="hidid" value="">
			<table>
				<tr>
					<th>
						<cfquery name="getpayroll" datasource="#dts#">
SELECT mmonth,myear FROM payroll_main.gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
						<cfif getpayroll.mmonth eq "13">
							<cfset getpayroll.mmonth = 12>
						</cfif>
						<cfset payrollmonth = getpayroll.mmonth>
						<cfif isdefined('url.monthno')>
							<cfset payrollmonth = url.monthno>
						</cfif>
						<cfset payrollyear = getpayroll.myear>
						<input type="button" name="refresh_btn" id="refresh_btn" value="Refresh" onClick="window.location.reload()">
						&nbsp;&nbsp;&nbsp;Choose Month:
						<select name="month" id="month" onChange="window.location.href='viewapproval.cfm?monthno='+this.value">
							<cfloop from="1" to="12" index="i">
								<option value="#i#"
								<cfif i eq payrollmonth>
									Selected
								</cfif>
								>#i#/#payrollyear#</option>
							</cfloop>
						</select>
						<cfquery name="getbatch" datasource="#dts#">
    SELECT batches,a.giropaydate,a.banktype,a.approvedbydate FROM assignmentslip a
	LEFT JOIN argiro b
	ON a.batches = b.batchno
	WHERE
	month(submited_on) = "#payrollmonth#"
    and year(assignmentslipdate) = "#payrollyear#"
    and batches <> "" and batches is not null
    Group By Batches
    order by batches
    </cfquery>

						<cfset batchgiropaydate = structnew()>
						<cfset batchbanktype = structnew()>
						<cfset batchapprovedbydate = structnew()>
						<cfloop query="getbatch">
							<cfset structinsert(batchgiropaydate,trim(getbatch.batches),dateformat(getbatch.giropaydate,'dd/mm/yyyy'))>
							<cfset structinsert(batchapprovedbydate,trim(getbatch.batches),dateformat(getbatch.approvedbydate,'dd/mm/yyyy'))>
							<cfset structinsert(batchbanktype,trim(getbatch.batches),getbatch.banktype)>
						</cfloop>
						<br>
						<br>
					</th>
				</tr>
				<tr>
					<th colspan="100%">
						<div align="center" style="font-size:18px; color:##30F">
							<strong>
								Pending Approval
							</strong>
						</div>
					</th>
				</tr>
				<td colspan="100%" valign="top">
					<table width="100%">
						<tr>
							<th style="font-size:11px">
								Approved By
							</th>
							<th style="font-size:11px">
								Bank
							</th>
							<th style="font-size:11px">
								Submitted On
							</th>
							<th style="font-size:11px">
								Batch No
							</th>
							<th style="font-size:11px">
								Giro Credit Date
							</th>
							<th style="font-size:11px">
								Submitted By
							</th>
							<th style="font-size:11px">
								No of EE
							</th>
							<th style="font-size:11px">
								<div align="right">
									Total Inv Amt
								</div>
							</th>
							<th style="font-size:11px">
								<div align="right">
									Total Giro Amt
								</div>
							</th>
							<!--- <cfif getauthuser() eq "ultracai" or getauthuser() eq "adminbepstest" or getauthuser() eq "Chrisbeps" or getauthuser() eq "caibeps"> --->
							<th style="font-size:11px">
								Action
							</th>
							<!--- </cfif> --->
						</tr>
						<cfquery name="getlist" datasource="#dts#">
SELECT * FROM argiro WHERE appstatus = "Pending"
and batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getbatch.batches)#" list="yes" separator=",">) 
ORDER by if(approvedbydate = '0000-00-00' or approvedbydate is null,1,0),approvedbydate,date(submited_on),batchno
</cfquery>
						<cfloop query="getlist">
							<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
								<td>
									#batchapprovedbydate[getlist.batchno]#
								</td>
								<td>
									#batchbanktype[getlist.batchno]#
								</td>
								<td>
									#dateformat(getlist.submited_on,'dd/mm/yyyy')#
								</td>
								<td>
									<u>
										<!--- style="cursor:pointer" onClick="document.getElementById('hidid').value='#getlist.id#';ColdFusion.Window.show('viewbatch');" --->
										<a href="viewbatchdetail.cfm?id=#getlist.id#" >
											#getlist.batchno#
										</a>
									</u>
								</td>
								<td>
									#batchgiropaydate[getlist.batchno]#
								</td>
								<td>
									#getlist.submited_by#
								</td>
								<td>
									#getlist.noofempno#
								</td>
								<td align="right">
									#numberformat(getlist.totalinv,'.__')#
								</td>
								<td align="right">
									#numberformat(getlist.netpay,'.__')#
								</td>
								<td style="padding:0px 0px 0px 20px;">
									<div id="approvediv#getlist.id#">
										<cfif getauthuser() eq "mptest10" or getauthuser() eq "kelly.lim@manpower.com.my" or getauthuser() eq "renusidhu.as@manpower.com.my" or getauthuser() eq "adminbepstest" or getauthuser() eq "Chrisbeps">
											<input type="button" name="approve_btn" id="approve_btn" value="Approve" onClick="if(confirm('Are you sure you want to approve batch #getlist.batchno#?')){ajaxFunction(document.getElementById('approvediv#getlist.id#'),'approvebatch.cfm?id=#getlist.id#')}">
											&nbsp;&nbsp;
										</cfif>
										<input type="button" name="approve_btn" id="approve_btn" value="Reject" onClick="document.getElementById('hidid').value='#getlist.id#';ColdFusion.Window.show('rejectbatch');">
									</div>
								</td>
							</tr>
						</cfloop>
					</table>
				</td>
				</tr>
				<tr>
					<th colspan='100%' onClick="javascript:shoh('r1');">
						<br>
						<br>
						<div align='center' style="font-size:18px; color:##30F">
							<strong>
								Approved
								<img src="/images/u.gif" name="imgr1" align="center">
							</strong>
						</div>
					</th>
				</tr>
				<tr>
					<td colspan="100%" valign="top">
						<table id="r1" align="center" width="100%">
							<tr>
								<th style="font-size:11px">
									Approved On
								</th>
								<th style="font-size:11px">
									Batch No
								</th>
								<th style="font-size:11px">
									Giro Credit Date
								</th>
								<th style="font-size:11px">
									Bank
								</th>
								<th style="font-size:11px">
									Approved By
								</th>
								<th style="font-size:11px">
									No of EE
								</th>
								<th style="font-size:11px">
									<div align="right">
										Total Inv Amt
									</div>
								</th>
								<th style="font-size:11px">
									<div align="right">
										Total Giro Amt
									</div>
								</th>
								<th style="font-size:11px">
									Giro Refno
								</th>
							</tr>
							<cfquery name="getlist" datasource="#dts#">
SELECT * FROM argiro WHERE appstatus = "Approved"
and batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getbatch.batches)#" list="yes" separator=",">) ORDER by girorefno,approved_on,batchno
</cfquery>
							<cfset startgirorefno = trim(getlist.girorefno)>
							<cfset subempno = 0>
							<cfset subinvamt = 0>
							<cfset subgiroamt = 0>
							<cfloop query="getlist">
								<cfif trim(getlist.girorefno) neq trim(startgirorefno) and trim(getlist.girorefno) neq "">
									<tr>
										<td colspan="100%">
											<hr/>
										</td>
									</tr>
									<tr>
										<th colspan="5" style="font-size:11px">
											Sub Total
										</th>
										<th style="font-size:11px;padding:0px 0px 0px 0px;">
											<div align="left" >
												#val(subempno)#
											</div>
										</th>
										<th style="font-size:11px;padding:0px 0px 0px 0px;">
											#numberformat(subinvamt,'.__')#
										</th>
										<th style="font-size:11px;padding:0px 0px 0px 0px;" >
											#numberformat(subgiroamt,'.__')#
										</th>
										<th style="font-size:11px;padding:0px 0px 0px 20px;">
											<div align="left">
												#startgirorefno#
											</div>
										</th>

									<tr>
										<td colspan="100%">
											<hr/>
										</td>
									</tr>
									<cfset startgirorefno = getlist.girorefno>
									<cfset subempno = 0>
									<cfset subinvamt = 0>
									<cfset subgiroamt = 0>
								</cfif>
								<tr  onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
									<td>
										#dateformat(getlist.approved_on,'dd/mm/yyyy')#
									</td>
									<td>
										<u>
											<!--- style="cursor:pointer" onClick="document.getElementById('hidid').value='#getlist.id#';ColdFusion.Window.show('viewbatch');" --->
											<a href="viewbatchdetail.cfm?id=#getlist.id#" >
												#getlist.batchno#
											</a>
										</u>
									</td>
									<td>
										#batchgiropaydate[getlist.batchno]#
									</td>
									<td>
										#batchbanktype[getlist.batchno]#
									</td>
									<td>
										#getlist.approved_by#
									</td>
									<td>
										#getlist.noofempno#
									</td>
									<td align="right">
										#numberformat(getlist.totalinv,'.__')#
									</td>
									<td align="right">
										#numberformat(getlist.netpay,'.__')#
									</td>
									<cfset subempno = subempno + val(getlist.noofempno)>
									<cfset subinvamt = subinvamt + numberformat(getlist.totalinv,'.__')>
									<cfset subgiroamt = subgiroamt + numberformat(getlist.netpay,'.__')>
									<td style="padding:0px 0px 0px 20px;">
										<div id="approvediv#getlist.id#">
											<div id="giro#getlist.id#">
												<cfif getlist.girorefno eq "">
													<input type="text" name="girorefno#getlist.id#" id="girorefno#getlist.id#" value="" size="10">
													&nbsp;
													<input type="button" name="save_btn" id="save_btn" value="Save" onClick="if(document.getElementById('girorefno#getlist.id#').value == ''){alert('Giro Refno Number is Required!')}else{ajaxFunction(document.getElementById('giro#getlist.id#'),'savegirorefno.cfm?id=#getlist.id#&girorefno='+escape(document.getElementById('girorefno#getlist.id#').value))}">
													<cfif getauthuser() eq "ultracai" or getauthuser() eq "adminbepstest" or getauthuser() eq "Chrisbeps">
														&nbsp;&nbsp;
														<input type="button" name="approve_btn" id="approve_btn" value="Reject" onClick="document.getElementById('hidid').value='#getlist.id#';ColdFusion.Window.show('rejectbatch');">
													</cfif>
												<cfelse>
													#getlist.girorefno#
												</cfif>
											</div>
										</div>
									</td>

								</tr>
								<cfif getlist.recordcount eq getlist.currentrow and trim(getlist.girorefno) neq "">
									<tr>
										<td colspan="100%">
											<hr/>
										</td>
									</tr>
									<tr>
										<th colspan="5" style="font-size:11px">
											Sub Total
										</th>
										<th style="font-size:11px;padding:0px 0px 0px 0px;">
											<div align="left">
												#val(subempno)#
											</div>
										</th>
										<th style="font-size:11px;padding:0px 0px 0px 0px;">
											#numberformat(subinvamt,'.__')#
										</th>
										<th style="font-size:11px;padding:0px 0px 0px 0px;" >
											#numberformat(subgiroamt,'.__')#
										</th>
										<th style="font-size:11px;padding:0px 0px 0px 20px;">
											<div align="left">
												#startgirorefno#
											</div>
										</th>
									<tr>
										<td colspan="100%">
											<hr/>
										</td>
									</tr>
									<cfset startgirorefno = getlist.girorefno>
									<cfset subempno = 0>
									<cfset subinvamt = 0>
									<cfset subgiroamt = 0>
								</cfif>
							</cfloop>
							<tr>
								<td colspan="100%">
									<div align="center">
										<input type="button" name="paytra1giro_btn" id="paytra1giro_btn" value="Generate Normal Pay Out Giro" onClick="ColdFusion.Window.show('generategiro1');">
										&nbsp;&nbsp;&nbsp;
										<input type="button" name="paytrangiro_btn" id="paytrangiro_btn" value="Generate Exception Pay Out Giro" onClick="ColdFusion.Window.show('generategiro2');">
										&nbsp;&nbsp;&nbsp;
										<input type="button" name="single_giro" id="single_giro_btn" value="Generate Single Giro" onClick="ColdFusion.Window.show('singlegiro');">

									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<th colspan='100%' onClick="javascript:shoh('r2');">
						<br>
						<br>
						<div align='center' style="font-size:18px; color:##30F">
							<strong>
								Rejected
								<img src="/images/u.gif" name="imgr2" align="center">
							</strong>
						</div>
					</th>
				</tr>
				<tr>
					<td colspan="100%" valign="top">
						<table id="r2" align="center" width="100%">
							<tr>
								<th style="font-size:11px">
									Rejected On
								</th>
								<th style="font-size:11px">
									Batch No
								</th>
								<th style="font-size:11px">
									Giro Credit Date
								</th>
								<th style="font-size:11px">
									Rejected By
								</th>
								<th style="font-size:11px">
									No of EE
								</th>
								<th style="font-size:11px">
									<div align="right">
										Total Inv Amt
									</div>
								</th>
								<th style="font-size:11px">
									<div align="right">
										Total Giro Amt
									</div>
								</th>
								<th style="font-size:11px">
									Reason
								</th>
								<th>
								</th>
							</tr>
							<cfquery name="getlist" datasource="#dts#">
SELECT * FROM argiro WHERE appstatus = "Rejected"
and batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getbatch.batches)#" list="yes" separator=",">) ORDER by date(approved_on),batchno
</cfquery>
							<cfloop query="getlist">
								<tr  onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
									<td>
										#dateformat(getlist.approved_on,'dd/mm/yyyy')#
									</td>
									<td>
										<u>
											<!---  style="cursor:pointer" onClick="document.getElementById('hidid').value='#getlist.id#';ColdFusion.Window.show('viewbatch');" --->
											<a href="viewbatchdetail.cfm?id=#getlist.id#">
												#getlist.batchno#
											</a>
										</u>
									</td>
									<td>
										#batchgiropaydate[getlist.batchno]#
									</td>
									<td>
										#getlist.approved_by#
									</td>
									<td>
										#getlist.noofempno#
									</td>
									<td align="right">
										#numberformat(getlist.totalinv,'.__')#
									</td>
									<td align="right">
										#numberformat(getlist.netpay,'.__')#
									</td>
									<td style="padding:0px 0px 0px 20px;">
										#getlist.reason#
									</td>
									<Td>
										<a href="#">
											Generate normal payout
										</a>
									</Td>
									<Td>
										<a href="#">
											Generate Exception payout
										</a>
									</Td>
								</tr>
							</cfloop>
						</table>
					</td>
				</tr>
			</table>
		</cfoutput>
		<cfwindow center="true" modal="true" width="800" height="500" name="viewbatch" refreshOnShow="true" title="View Batches" initshow="false" source="viewbatchdetail.cfm?id={hidid}" />
		<cfwindow center="true" modal="true" width="600" height="200" name="rejectbatch" refreshOnShow="true" title="Reject Batches" initshow="false" source="rejectbatch.cfm?id={hidid}" />
		<cfwindow center="true" width="600" height="500"
			name="generategiro1" title="Generate APS"
			initshow="false" draggable="true" resizable="true"
			source="/report/beps/batchapproval/paytra1/thruBankViaDisketteMain_generate.cfm?type=1&mmonth=#payrollmonth#" refreshonshow="true" modal="true"  />
		<cfwindow center="true" width="600" height="500"
			name="generategiro2" title="Generate APS"
			initshow="false" draggable="true" resizable="true"
			source="/report/beps/batchapproval/paytran/thruBankViaDisketteMain_generate.cfm?tbl=paytran&type=1&mmonth=#payrollmonth#" refreshonshow="true" modal="true"  />

			<cfwindow center="true" width="600" height="500"
			name="singlegiro" title="Generate single giro"
			initshow="false" draggable="true" resizable="true"
			source="/report/beps/batchapproval/singlegiro.cfm?type=1" refreshonshow="true" modal="true"  />

	</body>
</html>
