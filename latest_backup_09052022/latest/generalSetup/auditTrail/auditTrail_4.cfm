<html>
<head>
	<title>Audit Trail for Last Used No</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link href="../../stylesheet/reportprint.css" rel="stylesheet" type="text/css">
	<style type="text/css" media="print">
		.noprint { display: none; }
	</style>
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

		<cfquery name="getinfo" datasource="#dts#">
			select * from refnoset_audittrait where edited_by not like 'ultra%' order by edittype,edited_on
		</cfquery>

<body>
	<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<cfoutput>
		<tr>
			<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>Audit Trail for Last Used No</strong></font></div></td>
		</tr>
		<tr>
			<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td colspan="3"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
		</tr>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<tr>
			<td width="3%"><font size="2" face="Times New Roman, Times, serif">Edit Type</font></td>
			<td width="5%"><font size="2" face="Times New Roman, Times, serif">Edit Field</font></td>
			<td width="12%"><font size="2" face="Times New Roman, Times, serif">Before Edit</font></td>
			<td width="10%"><font size="2" face="Times New Roman, Times, serif">After Edit</font></td>
			<td width="10%"><font size="2" face="Times New Roman, Times, serif">Edited By</font></td>
			<td width="15%"><font size="2" face="Times New Roman, Times, serif">Edited On</font></td>
			<!---<td width="10%"><font size="2" face="Times New Roman, Times, serif">Counter</font></td>--->
           <td></td>
		</tr>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<cfloop query="getinfo">
        
        <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><font size="2" face="Times New Roman, Times, serif">#getinfo.edittype#</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#getinfo.editfield#</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#getinfo.beforeedit#</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#getinfo.afteredit#</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#getinfo.edited_by#</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getinfo.edited_on,'DD/MM/YYYY')# #timeformat(getinfo.edited_on,'HH:MM:SS')#</font></td>
                <!---<td><font size="2" face="Times New Roman, Times, serif">#getinfo.counter#</font></td>--->
                </tr>
		</cfloop>
	</cfoutput>
	</table>
</body>
</html>