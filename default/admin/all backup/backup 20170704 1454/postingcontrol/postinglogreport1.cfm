<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getagent" datasource="#dts#">
	SELECT action,billtype,actiondata,user,timeaccess FROM postlog where 0=0
    <cfif trim(form.refnofrom) neq ''>
    and actiondata like '%#form.refnofrom#%'
    </cfif>
    <cfif lcase(husergrpid) neq 'super'>
    and user not like 'ultra%'
    </cfif>
</cfquery>

<html>
<head>
<title>Posting Log Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css">
	.borderformat {border-top-style:double;border-bottom-style:double;border-bottom-color:black;border-top-color:black}
</style>

</head>

<body>
<table align="center" width="100%" border="0" cellspacing="0">
<cfoutput>
	<tr>
		<td colspan="100%">
			<div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Posting Log Report</strong></font></div>
		</td>
	</tr>
	
    <cfif trim(form.refnofrom) neq ''>
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman,Times,serif">Ref No: #form.refnofrom#</font></div></td>
		</tr>
	</cfif>

	<tr>
		<td colspan="3"><font size="2" face="Times New Roman,Times,serif">#getgeneral.compro#</font></td>
		<td colspan="2"><div align="right"><font size="2" face="Times New Roman,Times,serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
	</tr>
	<tr>
		<td colspan="100%"><hr></td>
	</tr>
	<tr>
    	<td width="10%"><div align="left"><font size="2" face="Times New Roman,Times,serif">Action</font></div></td>
   		<td  width="20%"><div align="left"><font size="2" face="Times New Roman,Times,serif">Bill TYPE</font></div></td>
		<td  width="50%"><div align="left"><font size="2" face="Times New Roman,Times,serif">Bill List</font></div></td>
        <td  width="10%"><div align="left"><font size="2" face="Times New Roman,Times,serif">User</font></div></td>
        <td  width="10%"><div align="left"><font size="2" face="Times New Roman,Times,serif">Time Accessed</font></div></td>
        
	</tr>
	<tr>
		<td colspan="100%"><hr></td>
	</tr>
	
	<cfloop query="getagent">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
        	<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#action#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#billtype#</font></div></td>
			<td><font size="2" face="Times New Roman,Times,serif">#replace(actiondata,',',', ','all')#</font></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif">#user#</font></div></td>
            <td><div align="left"><font size="2" face="Times New Roman,Times,serif">#timeaccess# </font></div></td>

		</tr>

        </cfloop>

	
</cfoutput>
</table>
</body>
</html>