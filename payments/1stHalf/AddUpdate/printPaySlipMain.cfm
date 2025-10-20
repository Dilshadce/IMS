<html>
<head>
	<title>2nd Half payroll - Annual Leave To Allowance</title>
	<link rel="stylesheet" href="/stylesheet/app.css"/>
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
    <script type="text/javascript">
	function printpdf()
	{
		document.pForm.action = document.getElementById('type1').value;
	}
	
	function printpdf2()
	{
		document.pForm.action = document.getElementById('type1').value;
	}
	
	function printpdf1()
	{<cfoutput>
		<cfif HcomID eq "bestform" or HcomID eq "cleansing" or HcomID eq "knights" or HcomID eq "bestform10" or HcomID eq "taff" or HcomID eq "taftc" or HcomID eq "cstct" or hcomid eq "amtaire" or hcomid eq "btgroup" or hcomid eq "mcjim" or hcomid eq "vtop" or hcomid eq "megatech" or hcomid eq "xinbao" or hcomid eq "kjcpl">
		document.pForm.action = "/bill/#hcomid#_p/customizepayslip.cfm?type=paytran";
		<cfelse>
		document.pForm.action = "printPaySlipProcess.cfm";
		</cfif>
	 </cfoutput>	
	}
	</script>
</head>

<body>

<cfquery name="gs_qry" datasource="payroll_main">
SELECT myear, mmonth
FROM gsetup WHERE comp_id = "#HcomID#"
</cfquery>

<cfquery name="emp_qry" datasource="#dts#">
SELECT empno, name, emp_code
FROM pmast where confid >= #hpin#
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

<cfoutput>
<form name="pForm" action="" method="post" target="_blank">
<div class="mainTitle"><H6>Print Pay Slip</H6></div>
		<table class="form">
		<tr>
			<th colspan="4" font="36"><strong>Print Pay Slip</strong></th>
            <td rowspan="14">&nbsp;</td>
            <td rowspan="14"><select name="type1" id="type1" size="10" >
        		<cfif HcomID eq "cleansing">
                <option value="/bill/#dts#/half2/printPaySlipPDF.cfm">1. Pay Slip</option>
				<cfelse>	
				<option value="printPaySlipPDF.cfm">1. Pay Slip</option>
                </cfif>
				<option value="customizepayslip.cfm">2. Pay Slip</option>
				<option value="customizePaySlip_cy.cfm">3. Pay Slip</option>
				<cfif #HcomID# eq "jothi">	
				<option value="customizePaySlip_jothi.cfm">4. Pay Slip</option>
				</cfif>
				<cfif #HcomID# eq "amtaircon" OR #HcomID# eq "amtaire">
				<option value="customizePaySlip_AMTAIRCON.cfm?type=paytran">4. Pay Slip</option>
				</cfif>
				<cfif #HcomID# eq "lchconst" or #HcomID# eq "lcheng" or #HcomID# eq "lchpj">
				<option value="customizePaySlip_LCH.cfm?type=paytran">4. Pay Slip</option>
				</cfif>
                <option value="paymentvoucher.cfm?type=paytran">Payment Voucher</option>
                <option value="customizePaySlip_daily.cfm?type=paytran">Daily Pay Slip</option>
                <option value="customizePaySlip_hour.cfm?type=paytran">Hourly Pay Slip</option>
			</select></td>
		</tr>
		<tr>
			<td>Employee No.</td>
			<td>
			<select name="empno" id="empno">
				<option name="" value=""></option>
				<cfloop query="emp_qry">
				<option name="" value="#emp_qry.empno#">#emp_qry.empno# | #emp_qry.name#</option>
				</cfloop>
			</select>
            <br/>
    Search Employee : <input type="text" name="searchempnofrom" id="searchempnofrom" onKeyUp="searchSel('empno','searchempnofrom')" />
			</td>
			<td>-</td>
			<td>
			<select name="empno1" id="empno1">
				<option name="" value="">zzzzzz</option>
				<cfloop query="emp_qry">
				<option name="" value="#emp_qry.empno#">#emp_qry.empno# | #emp_qry.name#</option>
				</cfloop>
			</select>
            <br/>
    Search Employee : <input type="text" name="searchempnoto" id="searchempnoto" onKeyUp="searchSel('empno1','searchempnoto')" />
			</td>
		</tr>
		<tr>
			<td>Line No.</td>
			<td>
			<select name="lineno">
				<option name="" value=""></option>
				<cfloop query="lin_qry">
				<option name="" value="#lin_qry.lineno#">#lin_qry.lineno# | #lin_qry.desp#</option>
				</cfloop>
			</select>
			</td>
			<td>-</td>
			<td>
			<select name="lineno1">
				<option name="" value="">zzzzzz</option>
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
				<option name="" value=""></option>
				<cfloop query="bra_qry">
				<option name="" value="#bra_qry.brcode#">#bra_qry.brcode# | #bra_qry.brdesp#</option>
				</cfloop>
			</select>
			</td>
			<td>to</td>
			<td>
			<select name="brcode1">
				<option name="" value="">zzzzzz</option>
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
				<option name="" value=""></option>
				<cfloop query="dep_qry">
				<option name="" value="#dep_qry.deptcode#">#dep_qry.deptcode# | #dep_qry.deptdesp#</option>
				</cfloop>
			</select>
			</td>
			<td>to</td>
			<td>
			<select name="deptcode1">
				<option name="" value="">zzzzzz</option>
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
				<option name="" value=""></option>
				<cfloop query="cat_qry">
				<option name="" value="#cat_qry.category#">#cat_qry.category# | #cat_qry.desp#</option>
				</cfloop>
			</select>
			</td>
			<td>-</td>
			<td>
			<select name="category1">
				<option name="" value="">zzzzzz</option>
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
			<option name="" value=""></option>
			<cfloop query="emp_qry">
			<option name="" value="#emp_qry.emp_code#">#emp_qry.emp_code# | #emp_qry.name#</option>
			</cfloop>
			</select>
			</td>
			<td>to</td>
			<td>
			<select name="emp_code1">
			<option name="" value="">zzzzzz</option>
			<cfloop query="emp_qry">
			<option name="" value="#emp_qry.emp_code#">#emp_qry.emp_code# | #emp_qry.name#</option>
			</cfloop>
			</select>
			</td>
		</tr>
		<tr>
			<td>Order By</td>
			<td>
			<select name="order">
		    	<option value=""></option>
				<option value="category">Category</option>
				<option value="deptcode">Department</option>
				<option value="empno" selected="true">Employee No.</option>
				<option value="plineno">Line No.</option>
				<option value="name">Name</option>
			</select>
			</td>
		</tr>
		<tr>
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
		<tr>
			<td>Pay Rate Type</td>
			<td>
			<select name="payrtype">
				<option value="">All</option>
				<option value="M">Monthly</option>
				<option value="D">Daily</option>
				<option value="H">Hourly</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Pay Method</td>
			<td  colspan="3">
			<select name="paymeth">
				<option value="">All</option>
				<option value="B">Bank</option>
				<option value="C">Cash</option>
				<option value="Q">Cheque</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>Pay Slip Date</td>
		    <cfset psDate = Createdate(gs_qry.myear, gs_qry.mmonth, 1)>
			<cfset mday = daysinmonth(psdate)>
		    <cfset psDate = Createdate(gs_qry.myear, gs_qry.mmonth, mday)>
			<td><input type="text" name="psDate" value="#DateFormat(psDate, "dd/mm/yyyy")#" size="10"></td>
		</tr>
		<tr>
			<td>Remark</td>
			<td><textarea name="remark" id="remark" rows="5" cols="40"></textarea></td>
		</tr>
		<tr>
			<td colspan="4" align="right"><br />
				<input type="submit" name="submit" value="OK" onClick="javascript:printpdf1();">
		        <cfif #HcomID# eq "pc1">
		        <input type="submit" name="pdf" value="PDF" onClick="javascript:printpdf2();">
		        <cfelse>
		        <input type="submit" name="pdf" value="PDF" onClick="javascript:printpdf();">
				</cfif>
		        <input type="button" name="exit" value="Exit" onClick="window.location='/payments/2ndHalf/2ndHalfList.cfm'">
			</td>
		</tr>
		</table>	

</form>
</cfoutput>
</body>

</html>