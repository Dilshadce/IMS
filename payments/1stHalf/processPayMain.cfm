<cfset dts=replace(dts,'_i','_p','all')>

<cfquery name="userpin_qry" datasource="#dts#">
		SELECT pin from userpin where usergroup = "#getHQstatus.userGrpID#"
	</cfquery>
	<cfset Hpin = userpin_qry.pin >
	<cfif getHQstatus.userGrpID eq "super">
		<cfset Hpin = 0>
	</cfif>
<cfset HcomID=replace(HcomID,'_i','','all')>
<cfset DTS_MAIN = "payroll_main">

<script language="javascript" type="text/javascript" src="/javascripts/ajax.js"></script>
<cfif isdefined('url.done')>
<script type="text/javascript">
window.close();
</script>
</cfif>
<html>
<head>
	<title>1st Half Payroll</title>
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
    <script type="text/javascript">
	function searchSel(fieldid,textid) {
	  var input=document.getElementById(textid).value.toLowerCase();
	  var output=document.getElementById(fieldid).options;
	  for(var i=0;i<output.length;i++) {
		if(output[i].text.toLowerCase().indexOf(input)>=0 && i != 0){
		  output[i].selected=true;
		  break;
		  }
		if(document.getElementById(textid).value==''){
		  output[0].selected=true;
		  }
	  }
	}
    </script>
</head>

<body>
<cfoutput>
<cfquery name="gs_qry" datasource="#dts_main#">
SELECT *
FROM gsetup
WHERE comp_id = "#HcomID#"
</cfquery>
<cfquery name="emp_qry" datasource="#dts#">
SELECT EMPNO, NAME, EMP_CODE 
FROM pmast where confid >= #hpin#
<cfif gs_qry.t1 eq 0>
        <cfif gs_qry.bp_payment eq "2">
        and (nppm = "2" or nppm = "0") 
		<cfelse>
        and nppm = "2"
		</cfif>
		</cfif>
ORDER BY empno
</cfquery>

<cfquery name="lin_qry" datasource="#dts#">
SELECT *
FROM tlineno
ORDER BY lineno
</cfquery>

<cfquery name="bra_qry" datasource="#dts#">
SELECT *
FROM branch
ORDER BY brcode
</cfquery>

<cfquery name="dep_qry" datasource="#dts#">
SELECT *
FROM dept
ORDER BY deptcode
</cfquery>

<cfquery name="cat_qry" datasource="#dts#">
SELECT *
FROM category
ORDER BY category
</cfquery>

<cfform name="pForm" action="processPayProcess2.cfm" method="post">
<table class="form">
<tr>
	<td><div class="mainTitle"><strong>Process Pay</strong></div></td>
</tr>
<tr>
	<td>&nbsp;&nbsp;&nbsp; Process 1st half payroll pay.</td>
</tr>
<tr>
	<td colspan="4"><hr></td>
</tr>
<!--- <tr>
	<td>
	<select name="" onchange="">
		<option value="">Employee No.</option>
		<option value="">Line No.</option>
		<option value="">Branch From</option>
		<option value="">Department From</option>
		<option value="">Category</option>
		<option value="">Employee Code From</option>
	</select>
	</td>
	<td>From</td>
</tr> --->
<tr>
	<td>Employee No.</td>
	<td>
	<select name="empno" id="empno">
	<option name=""></option>
	<cfloop query="emp_qry">
	<option name="" value="#emp_qry.empno#" >#emp_qry.empno# | #emp_qry.name#</option>
	</cfloop>
	</select>
    <br/>
    Search Employee : <input type="text" name="searchempnofrom" id="searchempnofrom" onKeyUp="searchSel('empno','searchempnofrom')" />
	</td>
	<td>to</td>
	<td>
	<select name="empno1" id="empno1">
	<option name=""></option>
	<cfloop query="emp_qry">
	<option name="" value="#emp_qry.empno#" >#emp_qry.empno# | #emp_qry.name#</option>
	</cfloop>
	</select><br/>
    Search Employee : <input type="text" name="searchempnoto" id="searchempnoto" onKeyUp="searchSel('empno1','searchempnoto')" />
    
	</td>
</tr>
<tr>
	<td>Line No.</td>
	<td>
	<select name="lineno">
	<option name=""></option>
	<cfloop query="lin_qry">
	<option name="" value="#lin_qry.lineno#">#lin_qry.lineno# | #lin_qry.desp#</option>
	</cfloop>
	</select>
	</td>
	<td>to</td>
	<td>
	<select name="lineno1">
	<option name=""></option>
	<cfloop query="lin_qry">
	<option name="" value="#lin_qry.lineno#">#lin_qry.lineno# | #lin_qry.desp#</option>
	</cfloop>
	</select>
	</td>
</tr>
<tr>
	<td>Branch From</td>
	<td>
	<select name="brcode">
	<option name=""></option>
	<cfloop query="bra_qry">
	<option name="" value="#bra_qry.brcode#">#bra_qry.brcode# | #bra_qry.brdesp#</option>
	</cfloop>
	</select>
	</td>
	<td>to</td>
	<td>
	<select name="brcode1">
	<option name=""></option>
	<cfloop query="bra_qry">
	<option name="" value="#bra_qry.brcode#">#bra_qry.brcode# | #bra_qry.brdesp#</option>
	</cfloop>
	</select>
	</td>
</tr>
<tr>
	<td>Department From</td>
	<td>
	<select name="deptcode">
	<option name=""></option>
	<cfloop query="dep_qry">
	<option name="" value="#dep_qry.deptcode#">#dep_qry.deptcode# | #dep_qry.deptdesp#</option>
	</cfloop>
	</select>
	</td>
	<td>to</td>
	<td>
	<select name="deptcode1">
	<option name=""></option>
	<cfloop query="dep_qry">
	<option name="" value="#dep_qry.deptcode#">#dep_qry.deptcode# | #dep_qry.deptdesp#</option>
	</cfloop>
	</select>
	</td>
</tr>
<tr>
	<td>Category</td>
	<td>
	<select name="category">
	<option name=""></option>
	<cfloop query="cat_qry">
	<option name="" value="#cat_qry.category#">#cat_qry.category# | #cat_qry.desp#</option>
	</cfloop>
	</select>
	</td>
	<td>to</td>
	<td>
	<select name="category1">
	<option name=""></option>
	<cfloop query="cat_qry">
	<option name="" value="#cat_qry.category#">#cat_qry.category# | #cat_qry.desp#</option>
	</cfloop>
	</select>
	</td>
</tr>
<tr>
	<td>Employee Code From</td>
	<td>
	<select name="emp_code">
	<option name=""></option>
	<cfloop query="emp_qry">
	<option name="" value="#emp_qry.emp_code#">#emp_qry.emp_code# | #emp_qry.name#</option>
	</cfloop>
	</select>
	</td>
	<td>to</td>
	<td>
	<select name="emp_code1">
	<option name=""></option>
	<cfloop query="emp_qry">
	<option name="" value="#emp_qry.emp_code#">#emp_qry.emp_code# | #emp_qry.name#</option>
	</cfloop>
	</select>
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td colspan="2"><input type="checkBox" name="negativePay" value="1"><strong>Show Employees with Negative Pay</strong></td>
</tr>
<tr>
	<td colspan="2">To check calculation, set both Employee No. to the same.</td>
</tr>
<tr>
	<td colspan="4" align="right">
		<input type="submit" name="submit" value="OK" onClick="javascript:ColdFusion.Window.show('errors');">
		<input type="button" name="cancel" value="Cancel" onClick="window.close();">
	</td>
</tr>
</table>
</cfform>

</cfoutput>
<cfwindow name="errors" title="Under Progress!" modal="true" closable="false" width="350" height="260" center="true" initShow="false" >
<p align="center">Under Process, Please Wait!</p>
<p align="center"><img src="/images/loading.gif" name="Cash Sales" width="30" height="30"></p>
<br />
</cfwindow> 
</body>

</html>



