<cfset dts_p = replace(dts,'_i','_p')>
<cfset hcomid = replace(dts,'_i','')>
<html>
	<head>
		<title>
			Single girl
		</title>
        
        
        <script>
            var dts="<cfoutput>#dts#</cfoutput>";
            var Hlinkams = '<cfoutput>#Hlinkams#</cfoutput>';
            var limit=10;
            var batchnoval = '';
            
            function formatResult2(result){
				return result.batches; 
			};
			
			function formatSelection2(result){
				return result.batches;  
			};
            
            function formatResultEmp(result){
				return result.empno+" - "+result.name; 
			};
			
			function formatSelectionEmp(result){
				return result.empno+" - "+result.name;   
			};
            
            $(document).ready(function(e) {
				$('.batchfilter').select2({
					ajax:{
						type: 'POST',
						url:'/latest/filter/filterBatches.cfc',
						dataType:'json',
						data:function(term,page){
							return{
								method:'listAccount',
								returnformat:'json',
								dts:dts,
								Hlinkams:Hlinkams,
								term:term,
								limit:limit,
								page:page-1,
                                mmonth:"<cfoutput>#url.mmonth#</cfoutput>",
							};
						},
						results:function(data,page){
							var more=((page-1)*limit)<data.total;
							return{
								results:data.result,
								more:more
							};
						}
					},
					initSelection: function(element, callback) {
						var value=$(element).val();
						if(value!=''){
							$.ajax({
								type:'POST',
								url:'/latest/filter/filterBatches.cfc',
								dataType:'json',
								data:{
									method:'getSelectedAccount',
									returnformat:'json',
									dts:dts,
									value:value,
									Hlinkams:Hlinkams,
								},
							}).done(function(data){callback(data);});
						};
					},
					formatResult:formatResult2,
					formatSelection:formatSelection2,
					minimumInputLength:0,
					width:'off',
					dropdownCssClass:'bigdrop',
					dropdownAutoWidth:true,
					placeholder:"Choose a Batch",
                    allowClear: "true",
					
				}).on('change', function (e) {
				var batchnoval = $("#batch").val();
					$('.empnoFilter').select2({
							ajax:{
								type: 'POST',
								url:'/latest/filter/filterEmpno.cfc',
								dataType:'json',
								data:function(term,page){
									return{
										method:'listAccount',
										returnformat:'json',
										dts:dts,
										term:term,
										batches:batchnoval,                                        
										limit:limit,
										page:page-1,
									};
								},
								results:function(data,page){
									var more=((page-1)*limit)<data.total;
									return{
										results:data.result,
										more:more
									};
								}
							},
							initSelection: function(element, callback) {
								var value=$(element).val();
								if(value!=''){
									$.ajax({
										type:'POST',
										url:'/latest/filter/filterEmpno.cfc',
										dataType:'json',
										data:{
											method:'getSelectedAccount',
											returnformat:'json',
											dts:dts,
											value:value,
										},
									}).done(function(data){callback(data);});
								};
							},
							formatResult:formatResultEmp,
							formatSelection:formatSelectionEmp,
							minimumInputLength:0,
							width:'off',
							dropdownCssClass:'bigdrop',
							dropdownAutoWidth:true,
                            allowClear: "true",
						}).select2('val','');
				});
                
                var batchnoval = $("#batch").val();
                $('.empnoFilter').select2({
							ajax:{
								type: 'POST',
								url:'/latest/filter/filterEmpno.cfc',
								dataType:'json',
								data:function(term,page){
									return{
										method:'listAccount',
										returnformat:'json',
										dts:dts,
										term:term,
										batches:batchnoval,
										limit:limit,
										page:page-1,
									};
								},
								results:function(data,page){
									var more=((page-1)*limit)<data.total;
									return{
										results:data.result,
										more:more
									};
								}
							},
							initSelection: function(element, callback) {
								var value=$(element).val();
								if(value!=''){
									$.ajax({
										type:'POST',
										url:'/latest/filter/filterEmpno.cfc',
										dataType:'json',
										data:{
											method:'getSelectedAccount',
											returnformat:'json',
											dts:dts,
											value:value,
										},
									}).done(function(data){callback(data);});
								};
							},
							formatResult:formatResultEmp,
							formatSelection:formatSelectionEmp,
							minimumInputLength:0,
							width:'off',
							dropdownCssClass:'bigdrop',
							dropdownAutoWidth:true,
                            allowClear: "true",
						}).on('change','');
				
			});
        </script>
        
        
	</head>
	<body>
        <cfoutput>
		<cfquery name="acBank_qry" datasource="#dts_p#">
SELECT * FROM address a
WHERE org_type in ('BANK')
</cfquery>
		<cfquery name="aps_qry" datasource="#dts_p#">
SELECT entryno, apsbank, apsnote FROM aps_set
</cfquery>
		<cfquery name="gs_qry" datasource="payroll_main">
SELECT mmonth, myear FROM gsetup WHERE comp_id = "#hcomid#"
</cfquery>
		<cfquery name="category_qry" datasource="#dts_p#">
SELECT * FROM address a where category="#url.type#" and org_type="BANK"
</cfquery>
		<cfquery name="getempno" datasource="#dts#">
						SELECT empno,empname,branch from assignmentslip WHERE
						batches is not null OR batches !=''
						 and created_on > #createdate(gs_qry.myear,1,7)#
    and payrollperiod = "#gs_qry.mmonth#"
						 GROUP BY empno order by empno
						</cfquery>
		<cfquery name="getbatches" datasource="#dts#">
						 SELECT batches,giropaydate FROM assignmentslip WHERE 1=1
    and created_on > #createdate(gs_qry.myear,1,7)#
    and batches <> "" and batches is not null
    Group By Batches
    order by batches
						</cfquery>
        </cfoutput>
		<cfoutput>
			<form name="tgForm" action="/Report/BEPS/batchapproval/generateGiroBankfile/generateSingleGiroBankFile.cfm" method="post" target="BLANK">
				<table class="form">
					<tr>
						<th colspan="2">
							Generate ASCII File
						</th>
					</tr>
					<tr style="display:none">
						<td>
							Category
						</td>
						<td>
							<select name="category" id="category" onChange="apsfilename2();">
								<option value="#category_qry.category#">
									#category_qry.category#-#category_qry.org_name#
								</option>
								<cfloop query="acBank_qry">
									<option value="#acBank_qry.category#" id="#acBank_qry.aps_num#" title="#acBank_qry.APS_FILE#">
										#acBank_qry.category#-#acBank_qry.org_name#
									</option>
								</cfloop>
							</select>
						</td>
					</tr>
					<tr style="display:none">
						<td>
							Confidential Level
						</td>
						<td>
							<select name="confid">
								<option value="">
								</option>
								<option value="1">
									1
								</option>
								<option value="2">
									2
								</option>
								<option value="3">
									3
								</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							Payout type
						</td>
						<td>
							<select name="paydate">
								<option value="paytran">
									Normal payout
								</option>
								<option value="paytra1">
									Exception payout
								</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							Giro Pay Date
						</td>
						<td>
							<cfoutput>
								<input type="date" name="giropaydate" value='#dateformat(now(),"yyyy-mm-dd")#' >
							</cfoutput>
						</td>
					</tr>					
					<tr>
						<td>
							Batch No
						</td>
						<td>
                            <input type="hidden" class="batchFilter" name="batch" id="batch" value="" placeholder="Select a batch">
							<!---<select name="batch" id="batch">
								<option value="">
									Choose a batch
								</option>
								<cfloop query="getbatches">
									<option value="#getbatches.batches#">
										#getbatches.batches#
									</option>
								</cfloop>
							</select>--->
						</td>
					</tr>
                    <tr style="">
						<td>
							Employee No
						</td>
						<td>
                            <input type="hidden" class="empnoFilter" name="empno" id="empno" value="" placeholder="Select a Employee">
							<!---<select name="empno" id="empnofrom">
								<option value="">
									Choose an employee
								</option>
								<cfloop query="getempno">
									<option value="#getempno.empno#">
										#getempno.empno# - #getempno.empname#
									</option>
								</cfloop>
							</select>--->
						</td>
					</tr>
					<tr id="batchRow">
					</tr>
					<cfquery name="getcate" datasource="#dts_p#">
SELECT * from category order by category
</cfquery>
					<tr style="display:none">
						<td>
							Category From
						</td>
						<td>
							<select name="catefrom" id="catefrom">
								<option value="">
									Choose a Category
								</option>
								<cfloop query="getcate">
									<option value="#getcate.category#">
										#getcate.category# - #getcate.desp#
									</option>
								</cfloop>
							</select>
						</td>
					</tr>
					<cfif left(dts,8) eq "manpower">
						<!--- temp query for feb payout
							<cfquery name="getbatch" datasource="#replace(dts,'_p','_i')#">
							SELECT batches,giropaydate FROM assignmentslip WHERE
							paydate = "paytran"
							and year(assignmentslipdate) = "#gs_qry.myear#"
							and month(assignmentslipdate) = "#gs_qry.mmonth#"
							and batches <> "" and batches is not null
							Group By Batches
							order by batches
							</cfquery>
							--->
						<cfquery name="getbatch" datasource="#replace(dts,'_p','_i')#">
    SELECT batches,giropaydate FROM assignmentslip WHERE
    paydate = "paytran"
    and created_on > #createdate(gs_qry.myear,1,7)#
    and month(assignmentslipdate) = "2"
    and batches <> "" and batches is not null
    Group By Batches
    order by batches
    </cfquery>
						<cfquery name="getvalidbatch" datasource="#replace(dts,'_p','_i')#">
SELECT batchno FROM argiro WHERE batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getbatch.batches)#" list="yes" separator=",">)
and appstatus = "Approved" and (girorefno = "" or girorefno is null)
</cfquery>
						<tr>
							<td>
								Assignment Batch
							</td>
							<td>
								<!--- temp query for feb payout
									<cfquery datasource="#replace(dts,'_p','_i')#" name="getbatch">
									Select batches,giropaydate from assignmentslip WHERE
									paydate = "paytran"
									and month(assignmentslipdate) = "#gs_qry.mmonth#"
									and year(assignmentslipdate) = "#gs_qry.myear#"  and locked = "Y" and batches <> ""
									and batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getvalidbatch.batchno)#" separator="," list="yes">)
									GROUP BY batches order by batches
									</cfquery>
									--->
								<cfquery datasource="#replace(dts,'_p','_i')#" name="getbatch">
			Select batches,giropaydate from assignmentslip WHERE
            paydate = "paytran"
            and month(assignmentslipdate) = "2"
            and created_on > #createdate(gs_qry.myear,1,7)#  and locked = "Y" and batches <> ""

            and batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getvalidbatch.batchno)#" separator="," list="yes">)

             GROUP BY batches order by batches
		</cfquery>
							</td>
						</tr>
					</cfif>
					<!---<tr>
						<td>Order By</td>
						<td>
						<select name="Order_By">
						<option value="E">Employee No.</option>
						<option value="C">Category</option>
						<option value="D">Department</option>
						<option value="L">Line No.</option>
						<option value="N">Name</option>
						</select>
						</td>
						</tr>--->
					<!---<tr>
						<td>Report Date</td>
						<cfset rdate = Createdate(gs_qry.myear, gs_qry.mmonth, DaysInMonth(CreateDate(gs_qry.myear, gs_qry.mmonth, 1)))>
						<td><input type="text" id="rdate" name="rdate" value="#DateFormat(rdate,"yyyy/mm/dd")#" size="10"></td>
						</tr>--->
					<tr>
						<td>
							Prepared By
						</td>
						<td>
							<input type="text" id="Prepared_By" name="Prepared_By" value="#getauthuser()#" readonly>
						</td>
					</tr>
					<tr>
						<!---<td>Batch No.</td>
							<cfif #category_qry.APS_NUM# eq  "5">
							<input type="hidden" id="APS_NUM" name="APS_NUM">
							<td><input type="text" id="Batch_No" name="Batch_No" value="00001" size="8" >
							</td>
						<cfelse>
							<input type="hidden" id="APS_NUM" name="APS_NUM">
							<td><input type="text" id="Batch_No" name="Batch_No" value="01" size="8"></td>
							</cfif>--->
						<input type="hidden" id="Batch_No" name="Batch_No" value="00001" size="8" >
						<td>
							PIR Reference No
						</td>
						<td>
							<input type="text" id="pir_refno" name="pir_refno" value="" size="30" >
						</td>
					</tr>
					<tr>
						<!---<td>Batch Code</td>
							<td><input type="text" name="" value="" size="20"></td>--->
						<td>
							Remarks
						</td>
						<td>
							<input type="text" name="" value="" size="20">
						</td>
					</tr>
					<cfif category_qry.APS_FILE neq "">
						<cfset APS_FILE = "#category_qry.aps_file#">
					<cfelse>
						<cfset APS_FILE = "">
					</cfif>
					<tr>
						<th colspan="2" width="350px">
							TO GENERATE APS FILE :
							<input type="text" name="APS_FILE" id="APS_FILE" value="#APS_FILE#" readonly >
						</th>
					</tr>
					<!---<tr>
						<th colspan="2" width="350px">FOR APS NUMBER :<input type="text" name="aps_num2" id="aps_num2" value="#category_qry.aps_num#" readonly></th>
						</tr>--->
					<tr>
						<td colspan="2" align="center">
							<br />
							<!--- <input type="checkbox" name="" value="" style="display:none">Generate Instruction Letter
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --->
                            <input type="submit" name="submit" value="Generate Encrypted File">
							<input type="submit" name="submit" value="Generate Text File">
                            <input type="submit" name="submit" value="Generate Duitnow File">
							<!--- <input type="button" name="print" value="Print" onClick="" disabled="">
								<input type="button" name="cancel" value="Cancel"  onclick="javascript:ColdFusion.Window.hide('mywindow2');"/> --->
						</td>
					</tr>
				</table>
			</form>
		</cfoutput>
	</body>
</html>
