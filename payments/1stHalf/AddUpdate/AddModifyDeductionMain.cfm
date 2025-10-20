<cfif findnocase(cgi.script_name,cgi.path_info)>
    <cfset request.path_info = cgi.path_info>
<cfelse>
    <cfset request.path_info = cgi.script_name & cgi.path_info>
</cfif>
<cfset currentFile=getToken(request.path_info,listlen(request.path_info,"/"),"/")>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Add / Modify Allowance</title>
	<script src="/javascripts/tabber.js" type="text/javascript"></script>
	<link href="/stylesheet/tabber.css" rel="stylesheet" TYPE="text/css" MEDIA="screen">
	<link href="/stylesheet/app.css" rel="stylesheet" type="text/css">	
	<script language="javascript" type="text/javascript" src="/javascripts/ajax.js"></script>
	
	<script language="javascript">
	function showFoot(empno)
	{
		document.getElementById("ename").innerHTML = document.getElementById("name_"+empno).value;
		document.getElementById("edcomm").innerHTML = document.getElementById("dcomm_"+empno).value;
		document.getElementById("epayrtype").innerHTML = document.getElementById("payrtype_"+empno).value;
		document.getElementById("edresign").innerHTML = document.getElementById("dresign_"+empno).value;
	}
	</script>
</head>
	
    
<cfoutput>
<cfquery name="select_paytra1_data" datasource="#dts#">
SELECT * FROM paytra1 as pt LEFT JOIN pmast as pm ON pt.empno=pm.empno WHERE pm.paystatus = "A" <cfif isdefined("form.stype")>and #form.stype# like '%#form.sFor#%'</cfif>
</cfquery>
</cfoutput>
<cfquery name="select_ded_desp" datasource="#dts#">
SELECT * FROM dedtable
</cfquery>

<body>
<div class="mainTitle">Add / Modify Deduction</div>
<font color="red" size="2.5"><cfif isdefined("form.status")><cfoutput>#form.status#</cfoutput></cfif></font>
		<div class="ttype3">
			<cfoutput>
			<form action="#currentFile#" method="post">
			<span class="ttype">Search By :
				<select name="sType">
			      <option value="pm.empno">Employee No.</option>
			      <option value="pm.name">Employee Name</option>
			      <option value="pm.plineno">Line No.</option>
			    </select>
				Search for : 
				<input type="text" name="sFor" <cfif isdefined("form.sfor")><cfoutput>Value="#form.sfor#"</cfoutput></cfif>>
			</span>
			</form>
			</cfoutput>
            </div>
 <form action="AddModifyDeductionProcess.cfm" method="post">
 <input type="hidden" name="emp_list" <cfif isdefined("form.sfor")><cfoutput>Value="#form.sfor#"</cfoutput></cfif> />
 <input type="hidden" name="emp_type" <cfif isdefined("form.stype")><cfoutput>Value="#form.stype#"</cfoutput></cfif> />
<div class="tabber">
<div class="tabbertab" height="400">
<h3>All</h3>
<cfoutput>
<table class="form" border="0">
<tr>
<th width="90">Employee No.</th>
<cfloop from="1" to="15" index="i">
<cfquery name="select_ded_desp" datasource="#dts#">
SELECT * FROM dedtable where ded_COU=#i#
</cfquery>
<cfif select_ded_desp.ded_desp neq "">
<th width="90">#select_ded_desp.ded_desp#</th>
<cfelse>
<th width="90">ded#i#</th>
</cfif>
</cfloop>
</tr>
<cfset j=0 >
<cfloop query="select_paytra1_data">
<tr onclick="showFoot('#select_paytra1_data.currentrow#');">

<td width="90">#select_paytra1_data.empno#</td>
<cfloop from="101" to="115" index="i">
<cfquery name="select_ded_amt" datasource="#dts#">
SELECT * FROM paytra1 where empno = "#select_paytra1_data.empno#"
</cfquery>
<cfquery name="select_empno_list" datasource="#dts#">
SELECT * FROM pmast WHERE empno = "#select_paytra1_data.empno#"
</cfquery>
<cfset ded_attrib = "ded" & #i# >
<td width="90"><input type="text" name="ded1_#i#_#j#" value="#NumberFormat(evaluate('select_paytra1_data.#ded_attrib#'),'.__')#" size="5" /></td>
</cfloop>
<cfset j=j+1>
</tr>
<input type="hidden" name="empno" id="empno" value="#select_paytra1_data.empno#">
				<input type="hidden" name="name_#select_paytra1_data.currentrow#" id="name_#select_paytra1_data.currentrow#" value="#select_empno_list.name#">
				<input type="hidden" name="dcomm_#select_paytra1_data.currentrow#" id="dcomm_#select_paytra1_data.currentrow#" value="#DateFormat(select_empno_list.dcomm, "dd-mm-yyyy")#">
				<input type="hidden" name="payrtype_#select_paytra1_data.currentrow#" id="payrtype_#select_paytra1_data.currentrow#" value="<cfif #select_empno_list.payrtype# eq "M">Monthly<cfelseif #select_empno_list.payrtype# eq "D">Daily<cfelseif #select_empno_list.payrtype# eq "H">Hourly</cfif>">
				<input type="hidden" name="dresign_#select_paytra1_data.currentrow#" id="dresign_#select_paytra1_data.currentrow#" value="#DateFormat(select_empno_list.dresign, "dd-mm-yyyy")#">
</cfloop>

</table>
</cfoutput>
</div>

<!--- <div class="tabbertab" height="400">
<h3>Fixed</h3>

<cfoutput>
<table class="form" border="0">
<tr>
<td width="90">Employee No.</td>
<cfloop from="1" to="10" index="i">
<cfquery name="select_ded_desp" datasource="#dts#">
SELECT * FROM dedtable where ded_COU=#i#
</cfquery>
<cfif select_ded_desp.ded_desp neq "">
<th width="90">#select_ded_desp.ded_desp#</th>
<cfelse>
<th width="90">ded#i#</th>
</cfif>
</cfloop>
</tr>
<cfset j=0 >
<cfloop query="select_paytra1_data">
<tr onclick="showFoot('#select_paytra1_data.currentrow#');">

<td width="90">#select_paytra1_data.empno#</td>
<cfloop from="101" to="110" index="i">
<cfquery name="select_ded_amt" datasource="#dts#">
SELECT * FROM paytra1 where empno = #select_paytra1_data.empno#
</cfquery>
<cfquery name="select_empno_list" datasource="#dts#">
SELECT * FROM pmast WHERE empno = #select_paytra1_data.empno#
</cfquery>
<cfset ded_attrib = "ded" & #i# >
<td width="90"><input type="text" name="ded2_#i#_#j#" value="#NumberFormat(evaluate('select_paytra1_data.#ded_attrib#'),'.__')#" size="5" /></td>
</cfloop>
<cfset j=j+1>
</tr>
<input type="hidden" name="empno" id="empno" value="#select_paytra1_data.empno#">
				<input type="hidden" name="name_#select_paytra1_data.currentrow#" id="name_#select_paytra1_data.currentrow#" value="#select_empno_list.name#">
				<input type="hidden" name="dcomm_#select_paytra1_data.currentrow#" id="dcomm_#select_paytra1_data.currentrow#" value="#DateFormat(select_empno_list.dcomm, "dd-mm-yyyy")#">
				<input type="hidden" name="payrtype_#select_paytra1_data.currentrow#" id="payrtype_#select_paytra1_data.currentrow#" value="<cfif #select_empno_list.payrtype# eq "M">Monthly<cfelseif #select_empno_list.payrtype# eq "D">Daily<cfelseif #select_empno_list.payrtype# eq "H">Hourly</cfif>">
				<input type="hidden" name="dresign_#select_paytra1_data.currentrow#" id="dresign_#select_paytra1_data.currentrow#" value="#DateFormat(select_empno_list.dresign, "dd-mm-yyyy")#">
</cfloop>
</table>
</cfoutput>

</div> --->
<!--- <div class="tabbertab" height="400">
<h3>Variable</h3>
<cfoutput>
<table class="form" border="0">
<tr>
<th width="90">Employee No.</th>
<cfloop from="11" to="15" index="i">
<cfquery name="select_ded_desp" datasource="#dts#">
SELECT * FROM dedtable where ded_COU=#i#
</cfquery>
<cfif select_ded_desp.ded_desp neq "">
<th width="90">#select_ded_desp.ded_desp#</th>
<cfelse>
<th width="90">ded#i#</th>
</cfif>
</cfloop>
</tr>
<cfset j=0 >
<cfloop query="select_paytra1_data">
<tr onclick="showFoot('#select_paytra1_data.currentrow#');">

<td width="90"><!--- #select_paytra1_data.empno# ---><input type="hidden" name="empno_#i#_#j#" value="#select_paytra1_data.empno#"  /></td>
<cfloop from="111" to="115" index="i">
<cfquery name="select_ded_amt" datasource="#dts#">
SELECT * FROM paytra1 where empno = #select_paytra1_data.empno#
</cfquery>
<cfquery name="select_empno_list" datasource="#dts#">
SELECT * FROM pmast WHERE empno = #select_paytra1_data.empno#
</cfquery>
<cfset ded_attrib = "ded" & #i# >
<td width="90"><input type="text" name="ded3_#i#_#j#" value="#NumberFormat(evaluate('select_paytra1_data.#ded_attrib#'),'.__')#" size="5" /></td>
</cfloop>
<cfset j=j+1>
</tr>
<input type="hidden" name="empno" id="empno" value="#select_paytra1_data.empno#">
				<input type="hidden" name="name_#select_paytra1_data.currentrow#" id="name_#select_paytra1_data.currentrow#" value="#select_empno_list.name#">
				<input type="hidden" name="dcomm_#select_paytra1_data.currentrow#" id="dcomm_#select_paytra1_data.currentrow#" value="#DateFormat(select_empno_list.dcomm, "dd-mm-yyyy")#">
				<input type="hidden" name="payrtype_#select_paytra1_data.currentrow#" id="payrtype_#select_paytra1_data.currentrow#" value="<cfif #select_empno_list.payrtype# eq "M">Monthly<cfelseif #select_empno_list.payrtype# eq "D">Daily<cfelseif #select_empno_list.payrtype# eq "H">Hourly</cfif>">
				<input type="hidden" name="dresign_#select_paytra1_data.currentrow#" id="dresign_#select_paytra1_data.currentrow#" value="#DateFormat(select_empno_list.dresign, "dd-mm-yyyy")#">
</cfloop>
</table>
</cfoutput>
</div> --->
</div>
	<br />
		
		<table border="1">
			<tr>
				<td>Name</td>
				<td>:</td>
				<td width="200"><label id="ename"></label></td>
				<td></td>
				<td>Date Commence</td>
				<td>:</td>
				<td width="125"><label id="edcomm"></label></td>
			</tr>
			<tr>
				<td>Pay Rate Type</td>
				<td>:</td>
				<td><label id="epayrtype"></label></td>
				<td></td>
				<td>Date Resign</td>
				<td>:</td>
				<td><label id="edresign"></label></td>
			</tr>
		</table>
		<br />	
<br />
	<center>
		<input type="submit" name="save" value="Save">
		<input type="button" name="exit" value="Exit" onClick="window.location.href='/payments/1stHalf/AddUpdate/AddUpdatelist.cfm'">
	</center>
</form>
</body>
</html>
