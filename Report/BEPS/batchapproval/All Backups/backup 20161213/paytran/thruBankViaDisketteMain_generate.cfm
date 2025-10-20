<cfset dts = replace(dts,'_i','_p')>
<cfset hcomid = replace(dts,'_p','')>
<html>
<head>
	<title>Thru Bank Via Diskette</title>
</head>
<body>

	
<cfquery name="acBank_qry" datasource="#dts#">
SELECT * FROM address a
WHERE org_type in ('BANK')
</cfquery>

<cfquery name="aps_qry" datasource="#dts#">
SELECT entryno, apsbank, apsnote FROM aps_set
</cfquery>

<cfquery name="gs_qry" datasource="payroll_main">
SELECT mmonth, myear FROM gsetup WHERE comp_id = "#HcomID#"
</cfquery>

<cfquery name="category_qry" datasource="#dts#">
SELECT * FROM address a where category="#url.type#" and org_type="BANK" 
</cfquery>


<cfoutput>
<form name="tgForm" action="/Report/BEPS/batchapproval/paytran/generateThruBankViaDiskette.cfm?type=#url.tbl#" method="post" target="_BLANK" onSubmit="return validateform();">
<table class="form">
<tr>
	<th colspan="2">Generate ASCII File</th>
</tr>
<tr style="display:none">
	<td>Category</td>
	<td>
	<select name="category" id="category" onChange="apsfilename2();">
	<option value="#category_qry.category#">#category_qry.category#-#category_qry.org_name#</option>
	<cfloop query="acBank_qry">
		<option value="#acBank_qry.category#" id="#acBank_qry.aps_num#" title="#acBank_qry.APS_FILE#">#acBank_qry.category#-#acBank_qry.org_name#</option>
	</cfloop>
	</select>
	</td>
</tr>
<tr style="display:none">
	<td>Confidential Level</td>
	<td>
	<select name="confid">
		<option value=""></option>
		<option value="1">1</option>
		<option value="2">2</option>
		<option value="3">3</option>
	</select>
	</td>
</tr>
<!--- <cfquery name="getempno" datasource="#dts#">
SELECT empno,name from pmast order by empno
</cfquery> --->
<tr style="display:none">
<td>Employee No From</td>
<td>
<select name="empnofrom" id="empnofrom">
<option value="">Choose an employee</option>
<!--- <cfloop query="getempno">
<option value="#getempno.empno#">#getempno.empno# - #getempno.name#</option>
</cfloop> --->
</select>
</td>
</tr>
<tr style="display:none">
<td>Employee No To</td>
<td>
<select name="empnoto" id="empnoto">
<option value="">Choose an employee</option>
<!--- <cfloop query="getempno">
<option value="#getempno.empno#">#getempno.empno# - #getempno.name#</option>
</cfloop> --->
</select>
</td>
</tr>
<cfquery name="getcate" datasource="#dts#">
SELECT * from category order by category
</cfquery>
<tr style="display:none">
<td>Category From</td>
<td>
<select name="catefrom" id="catefrom">
<option value="">Choose a Category</option>
<cfloop query="getcate">
<option value="#getcate.category#">#getcate.category# - #getcate.desp#</option>
</cfloop>
</select>
</td>
</tr>
<tr style="display:none">
<td>Category To</td>
<td>
<select name="cateto" id="cateto">
<option value="">Choose a Category</option>
<cfloop query="getcate">
<option value="#getcate.category#">#getcate.category# - #getcate.desp#</option>
</cfloop>
</select>
</td>
</tr>
<cfquery name="getdept" datasource="#dts#">
SELECT * FROM dept order by deptcode
</cfquery>
<tr style="display:none">
<td>Department From</td>
<td>
<select name="deptfrom" id="deptfrom">
<option value="">Choose a Department</option>
<cfloop query="getdept">
<option value="#getdept.deptcode#">#getdept.deptcode# - #getdept.deptdesp#</option>
</cfloop>
</select>
</td>
</tr>
<tr style="display:none">
<td>Department To</td>
<td>
<select name="deptto" id="deptto">
<option value="">Choose a Department</option>
<cfloop query="getdept">
<option value="#getdept.deptcode#">#getdept.deptcode# - #getdept.deptdesp#</option>
</cfloop>
</select>
</td>
</tr>
<cfif left(dts,8) eq "manpower">

<cfquery name="getbatch" datasource="#replace(dts,'_p','_i')#">
    SELECT batches,giropaydate FROM assignmentslip WHERE 
    paydate = "paytran" 
    and year(assignmentslipdate) = "#gs_qry.myear#"
    and month(assignmentslipdate) = "#gs_qry.mmonth#"
    and batches <> "" and batches is not null
    Group By Batches
    order by batches
    </cfquery>
    
    
<cfquery name="getvalidbatch" datasource="#replace(dts,'_p','_i')#">
SELECT batchno FROM argiro WHERE batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getbatch.batches)#" list="yes" separator=",">)
and appstatus = "Approved" and (girorefno = "" or girorefno is null)
</cfquery>

<tr>
	<td>Assignment Batch</td>
	<td>
	<cfquery datasource="#replace(dts,'_p','_i')#" name="getbatch">
			Select batches from assignmentslip WHERE 
            paydate = "paytran" 
            and month(assignmentslipdate) = "#gs_qry.mmonth#"
            and year(assignmentslipdate) = "#gs_qry.myear#" and locked = "Y" and batches <> ""
            
            and batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getvalidbatch.batchno)#" separator="," list="yes">)
			
             GROUP BY batches order by batches
		</cfquery>
         <cfloop query="getbatch">
        <input type="checkbox" name="batch" id="batch" value="#getbatch.batches#">&nbsp;&nbsp;#getbatch.batches#<br>
        </cfloop>
	</td>
</tr>
</cfif>
<tr>
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
</tr>
<tr>
	<td><cfif left(dts,8) eq "manpower">Bank Processing Date<cfelse>Salary Credit Date</cfif></td>
	<cfset rdate = Createdate(gs_qry.myear, gs_qry.mmonth, DaysInMonth(CreateDate(gs_qry.myear, gs_qry.mmonth, 1)))>
	<td><input type="text" name="cdate" value="#DateFormat(rdate,"yyyy/mm/dd")#" size="10"></td>
</tr>
<tr>
	<td>Report Date</td>
	<cfset rdate = Createdate(gs_qry.myear, gs_qry.mmonth, DaysInMonth(CreateDate(gs_qry.myear, gs_qry.mmonth, 1)))>
	<td><input type="text" id="rdate" name="rdate" value="#DateFormat(rdate,"yyyy/mm/dd")#" size="10"></td>
</tr>
<tr>
	<td>Prepared By</td>
	<td><input type="text" id="Prepared_By" name="Prepared_By" value="" size="25"></td>
</tr>
<tr>
	<td>Batch No.</td>
	<cfif #category_qry.APS_NUM# eq  "5">
		<input type="hidden" id="APS_NUM" name="APS_NUM">
	<td><input type="text" id="Batch_No" name="Batch_No" value="00001" size="8" >
	</td>
	<cfelse>
		<input type="hidden" id="APS_NUM" name="APS_NUM">
	<td><input type="text" id="Batch_No" name="Batch_No" value="01" size="8"></td>
	</cfif>
</tr>
<tr>
	<td>Batch Code</td>
	<td><input type="text" name="" value="" size="20"></td>
</tr>
<cfif category_qry.APS_FILE neq "">
<cfset APS_FILE = "#category_qry.aps_file#">
<cfelse>
<cfset APS_FILE = "">
</cfif>

<tr>
	<th colspan="2" width="350px">TO GENERATE APS FILE :<input type="text" name="APS_FILE" id="APS_FILE" value="#APS_FILE#" readonly ></th>
</tr>
<tr>
	<th colspan="2" width="350px">FOR APS NUMBER :<input type="text" name="aps_num2" id="aps_num2" value="#category_qry.aps_num#" readonly></th>
</tr>
<tr>
	<td colspan="2" align="center"><br />
		<!--- <input type="checkbox" name="" value="">Generate Instruction Letter
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --->
		<input type="submit" name="submit" value="OK">
		<!--- <input type="button" name="print" value="Print" onClick="" disabled="">
		<input type="button" name="cancel" value="Cancel"  onclick="javascript:ColdFusion.Window.hide('mywindow2');"/> --->
	</td>
</tr>
</table>
</form>
</cfoutput>
</body>

</html>