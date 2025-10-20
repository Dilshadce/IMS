<html>
<head>
	<title>Edit Overtime Rate/ CPF</title>
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">
</head>

<body>

<cfquery name="pay_qry" datasource="#dts#">
SELECT * 
FROM paytra1 
WHERE EMPNO = "#url.empno#"
</cfquery>

<cfquery name="emp_qry" datasource="#dts#">
SELECT * FROM pmast
WHERE EMPNO = "#url.empno#"
</cfquery>

<cfquery name="ot_qry" datasource="#dts#">
SELECT ot_desp, ot_unit FROM ottable
WHERE ot_cou between 1 and 6
</cfquery>

<cfquery name="gsetup" datasource="#dts_main#">
	SELECT * FROM gsetup WHERE  comp_id = "#HcomID#"
</cfquery>

<cfset country_code = "#gsetup.ccode#" > 

<cfoutput>
<cfif country_code eq 'MY'>
	<div class="mainTitle">1st Half Payroll - Edit Overtime Rate/ EPF / SOCSO / PCB</div>
<cfelse>
	<div class="mainTitle">1st Half Payroll - Edit Overtime Rate / CPF</div>
</cfif>


<cfform name="OTCPFForm" action="/payments/1stHalf/AddUpdate/editOTRateCPF_process.cfm?empno=#pay_qry.empno#" method="post">
<table class="form" border="0">
<tr>
	<td>Employee No.</td>
	<td><input type="text" name="empno" value="#emp_qry.empno#" size="8" readonly></td>
	<td colspan="2"><input type="text" name="name" value="#emp_qry.name#" size="49" readonly></td>
</tr>
<tr>
	<td>Line No.</td>
	<td><input type="text" name="plineno" value="#emp_qry.plineno#" size="8" readonly></td>
</tr>
<tr><td colspan="3"><hr></td></tr>
<tr>
	<td colspan="2">
	<table>
	<tr>
		<td width="100">Basic Rate</td>
		<td width="120"><input type="text" name="BRATE" value="#numberformat(pay_qry.BRATE,'.__')#" size="10" readonly></td>
	</tr>
	<tr>
		<td width="100">Working Days</td>
		<td width="120"><input type="text" name="WDAY" value="#numberformat(pay_qry.WDAY,'.__')#" size="10" readonly></td>
	</tr>
	<tr>
		<td width="100">DW</td>
		<td width="120"><input type="text" name="" value="#numberformat(pay_qry.DW,'.__')#" size="10" readonly></td>
	</tr>
	<tr>
		<td width="100">PH</td>
		<td width="120"><input type="text" name="PH" value="#numberformat(pay_qry.PH,'.__')#" size="10" readonly></td>
	</tr>
	<tr>
		<td width="100">AL</td>
		<td width="120"><input type="text" name="AL" value="#numberformat(pay_qry.AL,'.__')#" size="10" readonly></td>
	</tr>
	<tr>
		<td width="100">MC</td>
		<td width="120"><input type="text" name="MC" value="#numberformat(pay_qry.MC,'.__')#" size="10" readonly></td>
	</tr>
	<tr>
		<td width="100">MT</td>
		<td width="120"><input type="text" name="MT" value="#numberformat(pay_qry.MT,'.__')#" size="10" readonly></td>
	</tr>
	<tr>
		<td width="100">CL</td>
		<td width="120"><input type="text" name="CL" value="#numberformat(pay_qry.CL,'.__')#" size="10" readonly></td>
	</tr>
	<tr>
		<td width="100">HL</td>
		<td width="120"><input type="text" name="HL" value="#numberformat(pay_qry.HL,'.__')#" size="10" readonly></td>
	</tr>
	<tr>
		<td width="100">EX</td>
		<td width="120"><input type="text" name="EX" value="#numberformat(pay_qry.EX,'.__')#" size="10" readonly></td>
	</tr>
	<tr>
		<td width="100">PT</td>
		<td width="120"><input type="text" name="PT" value="#numberformat(pay_qry.PT,'.__')#" size="10" readonly></td>
	</tr>
	<tr>
		<td width="100">AD</td>
		<td width="120"><input type="text" name="AD" value="#numberformat(pay_qry.AD,'.__')#" size="10" readonly></td>
	</tr>
	<tr>
		<td width="100">#pay_qry.OPLD#</td>
		<td width="120"><input type="text" name="OPL" size="10" value="#numberformat(pay_qry.OPL,'.__')#" readonly ></td>
	</tr>
	<tr>
		<td width="100">LS</td>
		<td width="120"><input type="text" name="LS" value="#numberformat(pay_qry.LS,'.__')#" size="10" readonly></td>
	</tr>
	<tr>
		<td width="100">NPL</td>
		<td width="120"><input type="text" name="NPL" value="#numberformat(pay_qry.NPL,'.__')#" size="10" readonly></td>
	</tr>
	<tr>
		<td width="100">AB</td>
		<td width="120"><input type="text" name="AB" value="#numberformat(pay_qry.AB,'.__')#" size="10" readonly></td>
	</tr>
    	<tr>
		<td width="100">#pay_qry.ONPLD#</td>
		<td width="120"><input type="text" name="ONPL" size="10" value="#numberformat(pay_qry.ONPL,'.__')#" readonly></td>
	</tr>
	</table>
	</td>
	<td>
	<table border="0">

	<tr>
		<th width="80">Overtime</th>
		<th width="80">Rate</th>
		<th width="80">Hrs/Days</th>
		<td width="30"></td>
	</tr>
	<cfset i=1>
	<cfloop query="ot_qry">
	<tr>
		<td>#ot_qry.ot_desp#</td>
		<td><input type="text" name="RATE#i#" value="#numberformat(evaluate('pay_qry.RATE#i#'),'.____')#" size="10"></td>
		<td><input type="text" name="HR#i#" value="#numberformat(evaluate('pay_qry.HR#i#'),'.__')#" size="10"></td>
		<td>#ot_qry.ot_unit#</td>
	</tr>
	<cfset i=i+1>
	</cfloop>
	<tr>
	<cfif country_code eq 'MY'>
		<th colspan="3">EPF</th>
	<cfelse>
		<th colspan="3">CPF</th>
	</cfif>
	</tr>
	<tr>
		<cfif country_code eq 'MY'>	<td>EPF 'Yee</td><cfelse><td>CPF 'Yee</td></cfif>
		<td colspan="2" align="right"><input type="text" name="EPFWW" value="#numberformat(pay_qry.EPFWW,'0')#"></td>
	</tr>
	<tr>
		<cfif country_code eq 'MY'>	<td>EPF 'Yer</td><cfelse><td>CPF 'Yer</td></cfif>
		<td colspan="2" align="right"><input type="text" name="EPFCC" value="#numberformat(pay_qry.EPFCC,'0')#">
		</td>
	</tr>
	<cfif country_code eq 'MY'>
	<tr>
	  <th colspan="3">Insurance</th>
  </tr>
	<tr>
	  <td>SOCSO 'Yee </td>
      <td colspan="2" align="right"><input type="text" name="SOCSOWW" value="#numberformat(pay_qry.SOCSOWW,'0')#"></td>
  </tr>
	<tr>
	  <td>SOCSO 'Yer </td>
	  <td colspan="2" align="right"><input type="text" name="SOCSOCC" value="#numberformat(pay_qry.SOCSOCC,'0')#"></td>
  </tr>
	<tr>
	  <th colspan="3">Income Tax </th>
  </tr>
	<tr>
	  <td>PCB</td>
	  <td colspan="2" align="right"><input type="text" name="ITAXPCB" value="#numberformat(pay_qry.ITAXPCB,'0')#"></td>
  </tr>
	<tr>
	  <th colspan="3">Pencen</th>
  </tr>
	<tr>
	  <td>Pencen</td>
      <td colspan="2" align="right"><input type="text" name="PENCEN" value="#numberformat(pay_qry.PENCEN,'0')#"></td>
  </tr>
  </cfif>
	<tr>
		<th colspan="3">Fixed  Rate</th>
	</tr>
	<tr>
		<td>Fixed (O,E,S,P,R)</td>
		<td colspan="2" align="right"><input type="text" name="FIXOESP" value="#pay_qry.FIXOESP#"></td>
	</tr>
	</table>
	</td>
</tr>
</table>
<br />
<center>
	<!--- <input type="reset" name="reset" value="Reset"> --->
	<input type="submit" name="save" value="Save">
	<input type="button" name="exit" value="Exit" onClick="window.location='/payments/1stHalf/AddUpdate/editOTRateCPFMain.cfm'">
</center>
</cfform>
</cfoutput>
</body>

</html>