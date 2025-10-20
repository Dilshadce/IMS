<cfsetting showDebugOutput="No">
<cfquery name="fillSelection" datasource="manpower_i">
		SELECT *,'' as blank FROM manpower_i.assignmentslip WHERE 1=1
		<cfif #form.refno# neq "">
			and refno like "%#form.refno#%"
			</cfif>
		<cfif #form.placementno# neq "">
			and placementno like "%#form.placementno#%"
			</cfif>
		<cfif #form.empno# neq "">
			and empno like "%#form.empno#%"
			</cfif>
		<cfif #form.period# neq "">
			AND payrollperiod = "#form.period#"
			</cfif>
			<cfif #form.custname# neq "">
			AND custname LIKE "%#form.custname#%"
			</cfif>
		<cfif #form.name# neq "">
			AND empname LIKE "%#form.name#%"
			</cfif>
			<cfif #form.custno# neq "">
				AND custno = "#form.custno#"
			</cfif>
			<cfif trim(#form.where#) neq "">
				AND #form.where#
			</cfif>

</cfquery>
<script>
	$("#selectors").on("submit",function(e){
		e.preventDefault();
		var form = document.getElementById("selectors");
		$.ajax({
			url : "assignProcess.cfm",
			method : "POST",
			data : new FormData(form),
			processData: false,
			contentType: false,
			success : function(response){ showResults(response); }


		});

	});

	function checkAll(){
		if($("#selectAll").is(":checked")){
			$(".selectAssignment").prop("checked",true);
		}else{
			$(".selectAssignment").prop("checked",false);
		}
	}

	function check(id){
		$("#check_"+id).trigger("click");
	}
</script>
<form id="selectors" method="POST">
	<input type="checkbox" id="selectAll" onchange="checkAll()">
	SELECT ALL
	<input type="submit" name="go" value="go" class="btn btn-info pull-right">
	<hr />
	<table class="table">
		<tr>
			<th>
			</th>
			<th>
				REFNO
			</th>
			<th>
				Emp Name
			</th>
			<th>
				Emp No
			</th>
			<th>
				Customer
			</th>
			<th>
				cust no
			</th>
			<th>
				Date
			</th>
		</tr>
		<cfloop query="fillSelection">
			<cfoutput>
				<tr onclick="check('#fillSelection.refno#')">
					<td>
						<input type="checkbox" id="check_#fillSelection.refno#" class="selectAssignment" name="refno" value="#fillSelection.refno#">
					</td>
					<td>
						#fillSelection.refno#
					</td>
					<td>
						#fillSelection.empname#
					</td>
					<td>
						#fillSelection.empno#
					</td>
					<td>
						#fillSelection.custname#
					</td>
					<td>
						#fillSelection.custno#
					</td>

					<td>
						#dateFormat(fillSelection.assignmentslipdate,'Y-m-d')#
					</td>
				</tr>
			</cfoutput>
		</cfloop>
	</table>
</form>
