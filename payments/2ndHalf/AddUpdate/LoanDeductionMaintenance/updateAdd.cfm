<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Loan Maintenance</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">	
	<link href="/stylesheet/CalendarControl.css" rel="stylesheet" type="text/css">
	<script src="/javascripts/CalendarControl.js" language="javascript"></script>
	
		<script type="text/javascript">
		function validate_required(field,alerttxt)
		{
		with (field)
		{
		if (value==null||value=="")
		  {alert(alerttxt);return false;}
		else {return true}
		}
		}function validate_form(thisform)
		{
		with (thisform)
		{
		if (validate_required(accno,"A/C Number must be filled out!")==false
			|| validate_required(lamt,"Loan Amount must be filled out!")==false)
		  {accno || lamt.focus();return false;}
		 
		}
		}
		
		function confirmDelete(entryno,type,empno) {
		var answer = confirm("Confirm Delete?")
		if (answer){
			window.location = "updateAdd_process.cfm?type="+type+ "&entryno="+entryno+ "&empno="+empno;
			}
		else{
			
			}
		}
	</script>
	
</head>

<cfquery name="getEmp_qry" datasource="#dts#">
SELECT empno,name,brate,payrtype FROM pmast
WHERE empno='#empno#'
</cfquery>

<cfquery name="loan_qry" datasource="#dts#">
SELECT * FROM loanmst WHERE empno='#getEmp_qry.empno#'
</cfquery>

<cfquery name="ded_qry" datasource="#dts#">
SELECT ded_cou,ded_desp FROM dedtable
</cfquery>

<body>
<div class="mainTitle">Loan Maintenance</div>
<div class="tabber">
<font color="red" size="2.5"><cfif isdefined("form.status")><cfoutput>#form.status#</cfoutput></cfif></font>
	<form name="lForm" action="updateAdd_process.cfm" onSubmit="return validate_form(this)"  method="post">
	<cfoutput>
		<table>
		<tr>
			<th>Employee No.</th>
			<td colspan="2" width="100px"><input type="text" size="12"  name="empno" value="#getEmp_qry.empno#" readonly="yes"/></td>
		</tr>
		<tr>
			<th>Name</th>
			<td colspan="2" width="300px"><input type="text" size="60" name="name" value="#getEmp_qry.name#" readonly="yes"/></td>
		</tr>
		<tr>
			<th>Basic Rate</th>
			<td width="128px"><input type="text" size="15" name="brate" value="#getEmp_qry.brate#" readonly="yes"/></td>
			<td width="240px"><input type="text" size="6" 
					<cfif #getEmp_qry.payrType# eq "M"> value="Monthly"
					<cfelseif #getEmp_qry.payrType# eq "D"> value="Daily"
					<cfelseif #getEmp_qry.payrType# eq "H"> value="Hourly"
					</cfif>
			 readonly="yes"/></td>
		</tr>
		<tr>
			<th>A/C Number</th>
			<td colspan="2" width="380px"><input type="text" name="accno" size="25" value="" maxlength="20"/></td>
			<th>Bank Name</th>
			<td><input type="text" size="45" name="bname" value="" maxlength="35"/></td>
		</tr>
		<tr>
			<th>Loan Amount</th>
			<td width="128px"><input type="text" size="10" name="lamt" value="" maxlength="6" /></td>
			<td>Last Payment</td>
		</tr>
		<tr>
			<th>Date From</th>
			<td width="128px"><input type="text" size="14" name="dateFrom" value=""/>
				<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateFrom);"></td>
			<td width="240px"><input type="text" size="14" name="pdate1" value=""/>
				<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(pdate1);"></td>
			<th>Ded.No.</th>
			<td><select name="dnum"/>
				<cfloop query="ded_qry">
				<option name="#ded_qry.ded_cou#" value="#ded_qry.ded_cou#" <cfif #ded_qry.ded_cou# eq 12><cfoutput>selected</cfoutput></cfif>>#ded_qry.ded_cou#|#ded_qry.ded_desp#</option>
				</cfloop>
			</select></td>
		</tr>
		<tr>
			<th>Date To</th>
			<td width="128px"><input type="text" size="14" name="dateTo" value=""/>
				<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(dateTo);"></td>
			<td width="240px"><input type="text" size="14" name="pdate2" value=""/>
				<img src="/images/cal.gif" width=17 height=15 border=0 onClick="showCalendarControl(pdate2);"></td>
		</tr>
		<tr>
			<th>Repayment Amount</th>
			<td width="128px"><input type="text" size="10" name="rpayamt" value="#numberformat(0.00,'.__')#" maxlength="6"/></td>
			<td width="240px"><input type="text" size="10" name="lpayamt" value="#numberformat(0.00,'.__')#" maxlength="6"/></td>
			<td></td>
			<td width="240px"><input type="checkbox" name="fixed" value="#loan_qry.fixed#"/> Fixed</td>
		</tr>
		</table>
	
		<br />
		<center>
			<input type="button" name="GPS" value="Generate Payment Schedule" onClick="window.location.href='generatePaymentSchedule.cfm?empno=#url.empno#';">
            <input type="submit" name="save" value="Save">
			<input type="button" name="exit" value="Exit" onclick="window.close()">
		</center>
		<br />
		</cfoutput>
	</form>
	
		<table class="form" border="0">
		<tr>
			<th width="130px">A/C Number</th>
			<th width="70px">Loan Amount</th>
			<th width="70px">Date From</th>
			<th width="70px">Date To</th>
			<th width="70px">Repayment Amt</th>
			<th width="70px">Date From [L.P]</th>
			<th width="70px">Date To [L.P]</th>
			<th width="70px">Repayment Amount [L.P]</th>
			<th width="55px">Deduction No.</th>
			<th width="30px">Fixed</th>
			<th width="200px">Bank Name</th>
			<th width="120px">Action</th>
		</tr>
		
		<cfoutput query="loan_qry">
		<input type="hidden" name="empno" value="#loan_qry.empno#" />
		<input type="hidden" name="entryno" value="#loan_qry.entryno#" />
		<tr>
			<td>
				<input type="text" name="accno__r#loan_qry.empno#" value="#loan_qry.accno#" size="20" readonly="yes" />
			</td>
			<td>
				<input type="text" name="loanamt__r#loan_qry.empno#" value="#loan_qry.loanamt#" size="10" readonly="yes" />
			</td>
			<td>
				<input type="text" name="dates1__r#loan_qry.empno#" value="#dateformat(loan_qry.dates1,"dd/mm/YYYY")#" size="10" readonly="yes"/>
			</td>
			<td>
				<input type="text" name="datee1__r#loan_qry.empno#" value="#lsdateformat(loan_qry.datee1,"DD/MM/YYYY")#" size="10" readonly="yes"/>
			</td>
			<td>
				<input type="text" name="loanret1__r#loan_qry.empno#" value="#loan_qry.loanret1#" size="10" readonly="yes"/>
			</td>
			<td>
				<input type="text" name="dates2__r#loan_qry.empno#" value="#lsdateformat(loan_qry.dates2,"DD/MM/YYYY")#" size="10" readonly="yes"/>
			</td>
			<td>
				<input type="text" name="datee2__r#loan_qry.empno#" value="#lsdateformat(loan_qry.datee2,"DD/MM/YYYY")#" size="10" readonly="yes"/>
			</td>
			<td>
				<input type="text" name="loanret2__r#loan_qry.empno#" value="#loan_qry.loanret2#" size="10" readonly="yes"/>
			</td>
			<td>
				<input type="text" name="dednum__r#loan_qry.empno#" value="#loan_qry.dednum#" size="8"  readonly="yes"/>
			</td>
			<td>
				<input type="text" name="fixed__r#loan_qry.empno#" value="#loan_qry.fixed#" size="4" readonly="yes"/>
			</td>
			<td>
				<input type="text" name="bankname__r#loan_qry.empno#" value="#loan_qry.bankname#" size="30" readonly="yes"/>
			</td>
			<td>
				<a href="/payments/2ndHalf/AddUpdate/LoanDeductionMaintenance/updateAdd_edit.cfm?type=edit&entryno=#loan_qry.entryno#">
				<img height="18px" width="18px" src="/images/edit.ICO" alt="Edit" border="0">Edit</a> || 
				<a href="##" onclick="confirmDelete(#loan_qry.entryno#,'del','#loan_qry.empno#')">
				<img height="18px" width="18px" src="/images/delete.ICO" alt="Delete" border="0">Delete</a>			
			</td>
		</tr>
		</cfoutput>
		</table>
	
</div>
</body>
</html>
