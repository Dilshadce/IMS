<html>
<head>
	<title>1st Half payroll</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
	
</head>

<body>

<cfquery name="gs_qry" datasource="#dts_main#">
SELECT *
FROM gsetup
WHERE comp_id = "#HcomID#"
</cfquery>

<cfquery name="emp_qry" datasource="#dts#">
SELECT *
FROM pmast
WHERE empno = "#url.empno#"
</cfquery>

<cfquery name="ot_qry" datasource="#dts#">
SELECT ot_desp, ot_unit FROM ottable
WHERE ot_cou between 1 and 6
</cfquery>

<cfquery name="aw1_qry" datasource="#dts#">
SELECT aw_desp FROM awtable
WHERE aw_cou < 11
</cfquery>

<cfquery name="aw2_qry" datasource="#dts#">
SELECT aw_desp FROM awtable
WHERE aw_cou between 11 and 17
</cfquery>

<cfquery name="ded1_qry" datasource="#dts#">
SELECT ded_desp FROM dedtable
WHERE ded_cou < 11
</cfquery>

<cfquery name="ded2_qry" datasource="#dts#">
SELECT ded_desp FROM dedtable
WHERE ded_cou between 11 and 15
</cfquery>

<cfquery name="udr1_qry" datasource="#dts#">
SELECT udrat_desp FROM awtable
WHERE aw_cou between 1 and 15
</cfquery>

<cfquery name="udr2_qry" datasource="#dts#">
SELECT udrat_desp FROM awtable
WHERE aw_cou between 16 and 30
</cfquery>

<cfquery name="note_qry" datasource="#dts#">
SELECT * FROM paynote
WHERE empno = "#url.empno#"
</cfquery>

<cfoutput>
<form name="pForm" action="/payments/1stHalf/addUpdate/paySlipAdditionalMain_process.cfm" method="post">
<div class="mainTitle">1st Half Payroll 
		[<cfif gs_qry.mmonth eq 1>January<cfelseif gs_qry.mmonth eq 2>February<cfelseif gs_qry.mmonth eq 3>March
		<cfelseif gs_qry.mmonth eq 4>April<cfelseif gs_qry.mmonth eq 5>May<cfelseif gs_qry.mmonth eq 6>June
		<cfelseif gs_qry.mmonth eq 7>July<cfelseif gs_qry.mmonth eq 8>August<cfelseif gs_qry.mmonth eq 9>September
		<cfelseif gs_qry.mmonth eq 10>October<cfelseif gs_qry.mmonth eq 11>November<cfelseif gs_qry.mmonth eq 12>December</cfif>
		#gs_qry.myear#]
</div>

<table class="form">
<tr>
	<td>Employee No.</td>
	<td><input type="text" name="empno" value="#note_qry.EMPNO#" size="8" readonly></td>
	<td colspan="2"><input type="text" name="name" value="#emp_qry.NAME#" size="40" readonly></td>
</tr>
<tr>
	<td>Line No.</td>
	<td><input type="text" name="plineno" value="#emp_qry.PLINENO#" size="8" readonly></td>
</tr>
</table>

<div class="tabber">
	<div class="tabbertab" style="height:390px;">
		<h3>Basic Pay And Overtime</h3>
		<table class="form">
		<tr>
			<td>
			<table class="form">
			<tr>
				<td width="100px">Basic Rate</td>
				<td width="250px"><input type="text" name="brate" value="#note_qry.brate#" size="30"></td>
			</tr>
			<tr>
				<td>W. Days</td>
				<td><input type="text" name="wday" value="#note_qry.wday#" size="30"></td>
			</tr>
			<tr><td><br /></td></tr>
			<tr>
				<td>DW</td>
				<td><input type="text" name="dw" value="#note_qry.dw#" size="30"></td>
			</tr>
			<tr>
				<td>PH</td>
				<td><input type="text" name="ph" value="#note_qry.ph#" size="30"></td>
			</tr>
			<tr>
				<td>AL</td>
				<td><input type="text" name="al" value="#note_qry.al#" size="30"></td>
			</tr>
			<tr>
				<td>MC</td>
				<td><input type="text" name="mc" value="#note_qry.mc#" size="30"></td>
			</tr>
			<tr>
				<td>MT</td>
				<td><input type="text" name="mt" value="#note_qry.mt#" size="30"></td>
			</tr>
            <tr>
				<td>CC</td>
				<td><input type="text" name="cc" value="#note_qry.cc#" size="30"></td>
			</tr>
			<tr>
				<td>MR</td>
				<td><input type="text" name="mr" value="#note_qry.mr#" size="30"></td>
			</tr>
			<tr>
				<td>CL</td>
				<td><input type="text" name="cl" value="#note_qry.cl#" size="30"></td>
			</tr>
			<tr>
				<td>HL</td>
				<td><input type="text" name="hl" value="#note_qry.hl#" size="30"></td>
			</tr>
			<tr><td><br /></td></tr>
			<tr>
				<td>No Pay LS</td>
				<td><input type="text" name="ls" value="#note_qry.ls#" size="30"></td>
			</tr>
			<tr>
				<td>No Pay NPL</td>
				<td><input type="text" name="npl" value="#note_qry.npl#" size="30"></td>
			</tr>
			<tr>
				<td>No Pay AB</td>
				<td><input type="text" name="ab" value="#note_qry.ab#" size="30"></td>
			</tr>
			</table>
			</td>
			<td>
			<table class="form">
			<tr>
				<th colspan="2">Overtime</th>
			</tr>
			<cfset i=1>
					<cfloop query="ot_qry">
					<tr>
						<td width="80px">#ot_qry.ot_desp#</td>
						<td width="140px"><input type="text" name="HR#i#" value="#evaluate('note_qry.HR#i#')#" size="20"></td>
					</tr>
					<cfset i=i+1>
					</cfloop>
			<tr><td><br /></td></tr>
			<tr>
				<td>Work Hours</td>
				<td><input type="text" name="workhr" value="#note_qry.workhr#" size="20"></td>
			</tr>
			<tr>
				<td>Lateness</td>
				<td><input type="text" name="latehr" value="#note_qry.latehr#" size="20"></td>
			</tr>
			<tr>
				<td>Earlt Dep.</td>
				<td><input type="text" name="earlyhr" value="#note_qry.earlyhr#" size="20"></td>
			</tr>
			<tr>
				<td>No Pay Hour</td>
				<td><input type="text" name="nopayhr" value="#note_qry.nopayhr#" size="20"></td>
			</tr>
			<tr><td><br /></td></tr>
			<tr>
				<td>OOB</td>
				<td><input type="text" name="oob" value="#note_qry.oob#" size="20"></td>
			</tr>
			</table>
			</td>
		</tr>
		</table>
	</div>
	<div class="tabbertab" style="height:390px;">
		<h3>Allowances</h3>
		<table class="form">
		<tr>
			<th colspan="2" width="290px">Director Fee</th>
		</tr>
		<tr>
			<td width="80px">Director Fee</td>
			<td><input type="text" name="dirfee" value="#note_qry.dirfee#" size="30"></td>
		</tr>
		<tr>
			<td colspan="2">
			<table class="form">
			<tr>
				<th colspan="3" width="295px">Allowance</th>
			</tr>
			<cfset i=1>
				<cfset j=101>
				<cfloop query="aw1_qry">
				<tr>
					<td width="">#i#.</td>
					<td width="120px">#aw1_qry.aw_desp#</td>
					<td><input type="text" name="AW#j#" value="#evaluate('note_qry.AW#j#')#" size="20"></td>
				</tr>
				<cfset i=i+1>
				<cfset j=j+1>
				</cfloop>
			</table>
			</td>
			<td>
			<table class="form">
			<tr>
				<th colspan="3" width="290px">Allowance</th>
			</tr>
			<cfset i=11>
				<cfset j=111>
				<cfloop query="aw2_qry">
				<tr>
					<td>#i#.</td>
					<td width="120px">#aw2_qry.aw_desp#</td>
					<td><input type="text" name="AW#j#" value="#evaluate('note_qry.AW#j#')#" size="20"></td>
				</tr>
				<cfset i=i+1>
				<cfset j=j+1>
				</cfloop>
			</table>
			</td>
		</tr>
		</table>
	</div>
	<div class="tabbertab" style="height:390px;">
		<h3>Deduction</h3>
		<table class="form">
		<tr>
			<td>
			<table class="form">
			<tr>
				<th colspan="3" width="290px">Deductions</th>
			</tr>
			<cfset i=1>
				<cfset j=101>
				<cfloop query="ded1_qry">
				<tr>
					<td>#i#.</td>
					<td width="120px">#ded1_qry.ded_desp#</td>
					<td><input type="text" name="DED#j#" value="#evaluate('note_qry.DED#j#')#" size="20"></td>
				</tr>
				<cfset i=i+1>
				<cfset j=j+1>
				</cfloop>
			</table>
			</td>
			<td>
			<table class="form">
			<tr>
				<th colspan="3" width="290px">Deductions</th>
			</tr>
			<cfset i=11>
				<cfset j=111>
				<cfloop query="ded2_qry">
				<tr>
					<td>#i#.</td>
					<td width="120px">#ded2_qry.ded_desp#</td>
					<td><input type="text" name="DED#j#" value="#evaluate('note_qry.DED#j#')#" size="20"></td>
				</tr>
				<cfset i=i+1>
				<cfset j=j+1>
				</cfloop>
			<tr><td><br /></td></tr>
			<tr>
				<th colspan="3" width="290px">Advance</th>
			</tr>
			<tr>
				<td>Advance</td>
				<td></td>
				<td><input type="text" name="advance" value="#note_qry.advance#" size="20"></td>
			</tr>
			</table>
			</td>
		</tr>
		</table>
	</div>
	<div class="tabbertab" style="height:390px;">
		<h3>Other</h3>
		<table class="form">
		<tr>
			<th colspan="2" width="300px">Other Benefit</th>
		</tr>
		<tr>
			<td width="120px">Medical Fund</td>
			<td><input type="text" name="mfund" value="#note_qry.mfund#" size="25"></td>
		</tr>
		<tr>
			<td>Dental Fund</td>
			<td><input type="text" name="dfund" value="#note_qry.dfund#" size="25"></td>
		</tr>
		<tr>
			<th colspan="2" width="300px">CPF</th>
		</tr>
		<tr>
			<td width="120px">CPF 'Yee</td>
			<td><input type="text" name="epfww" value="#note_qry.epfww#" size="25"></td>
		</tr>
		<tr>
			<td>CPF 'Yer</td>
			<td><input type="text" name="epfcc" value="#note_qry.epfcc#" size="25"></td>
		</tr>
		<tr>
			<th colspan="2" width="300px">ETF</th>
		</tr>
		<tr>
			<td width="120px">EPG 'Yee</td>
			<td><input type="text" name="epgww" value="#note_qry.epgww#" size="25"></td>
		</tr>
		<tr>
			<td>CPG 'Yer</td>
			<td><input type="text" name="epgcc" value="#note_qry.epgcc#" size="25"></td>
		</tr>
		</table>
	</div>
	<div class="tabbertab" style="height:390px;">
		<h3>User Define Rate</h3>
		<table class="form">
		<tr>
			<th colspan="2">User Define Rate</th>
		</tr>
		<tr>
		<td>
		<table class="form">
		<cfset i=1>
			<cfloop query="udr1_qry">
			<tr>					
				<td width="100px">
				<cfif #udr1_qry.udrat_desp# eq "">
					UDRATE#i#
				<cfelse>
					#udr1_qry.udrat_desp#
				</cfif>
				</td>
				<td><input type="text" name="UDRATE#i#" value="#evaluate('note_qry.UDRATE#i#')#" size="25"></td>
			</tr>
			<cfset i=i+1>
			</cfloop>
			</table>
			</td>
			<td>
			<table>
			<cfset i=16>
			<cfloop query="udr2_qry">
			<tr>
				<td width="100px">
				<cfif #udr2_qry.udrat_desp# eq "">
					UDRATE#i#
				<cfelse>
					#udr2_qry.udrat_desp#
				</cfif>
				</td>
				<td width=""><input type="text" name="UDRATE#i#" value="#evaluate('note_qry.UDRATE#i#')#" size="25"></td>
			</tr>
			<cfset i=i+1>
			</cfloop>				
			</table>
			</td>
		</tr>
		</table>
	</div>
</div>

<br />
<center>
	<input type="button" name="clear" value="Clear" onClick="">
	<input type="submit" name="save" value="Save">
	<input type="button" name="exit" value="Exit" onClick="window.location='/payments/1stHalf/addUpdate/paySlipAdditionalMain.cfm'">
</center>
</form>
</cfoutput>
</body>

</html>