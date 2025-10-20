<cfquery name="getcfstrans" datasource="#dts#">
SELECT CFSTransactionBatch.*,
(SELECT profilename FROM paybillprofile WHERE id = CFSTransactionBatch.payBillProfileId) as profileName FROM CFSTransactionBatch ORDER BY id DESC
</cfquery>
<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/latest/css/maintenance/profile.css" />
<cfoutput>
	<div class="container">
	<div class="page-header">
		<h2>
			CFS Transactions List
		</h2>
	</div>
	<div class="container">
		<table class="table table-bordered table-hover" id="resultTable" style="table-layout:fixed;">
			<tr>
				<th>
					Batch No.
				</th>
				<th>
					Date
				</th>
				<th>
					Profile
				</th>
				<th>
					Action
				</th>
			</tr>
			<cfif getcfstrans.recordcount eq 0>
				<tr>
					<td valign="top" colspan="4" class="dataTables_empty">
						No data available in table
					</td>
				</tr>
			<cfelse>
				<cfloop query="getcfstrans">
					<tr>
						<td>
							#getcfstrans.id#
						</td>
						<td>
							#dateformat(getcfstrans.created_on,'yyyy-mm-dd')#
						</td>
						<td>
							#getcfstrans.profileName#
						</td>
						<td>
							<cfif #getcfstrans.generatedBankFile# eq 0>
								<span class="glyphicon glyphicon-pencil btn btn-link" onclick="window.open('/CFSpaybill/generateInvoiceBankFileData.cfm?profileid=#getcfstrans.paybillprofileid#&type=Edit&id=#getcfstrans.id#','_self');">
								</span>
								<span class="glyphicon glyphicon-remove btn btn-link" onclick="if(confirm('Are you sure you wish to delete this profile?')){window.open('/CFSpaybill/generateInvoiceBankfileprocess.cfm?type=Delete&id=#getcfstrans.id#','_self');}">
								</span>
							<cfelse>
								Bank file generated
							</cfif>
						</td>
					</tr>
				</cfloop>
			</cfif>
		</table>
	</div>
</cfoutput>
