<html>
<head>
	<title>View Audit Trail</title>
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

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",___.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
	<cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>


	

		<cfquery name="getinfo" datasource="#dts#">
			select * from edited_bossmenu
			where 0=0
			<cfif form.type neq "">
				and edittype = '#form.type#'
			</cfif>
            order by edittype
		</cfquery>


<body>
	<table width="100%" border="0" cellspacing="0" cellpadding="2">
	<cfoutput>
		<tr>
			<td colspan="100%"><div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>VIEW BOSS MENU AUDIT TRAIL</strong></font></div></td>
		</tr>
		<cfif form.type neq "" >
			<tr>
				<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Edit Type: #form.type#</font></div></td>
			</tr>
		</cfif>
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
			<td width="5%"><font size="2" face="Times New Roman, Times, serif">TYPE</font></td>
			<td width="12%"><font size="2" face="Times New Roman, Times, serif">BEFORE EDIT</font></td>
			<td width="10%"><div align="center"><font size="2" face="Times New Roman, Times, serif">AFTER EDIT</font></div></td>
			<td width="10%"><font size="2" face="Times New Roman, Times, serif">EDITED BY</font></td>
			<td width="15%"><div align="center"><font size="2" face="Times New Roman, Times, serif">EDITED ON</font></div></td>
			<td width="10%"><div align="center"><font size="2" face="Times New Roman, Times, serif">REF NO EDITED(Only for Edit Date)</font></div></td>
		</tr>
		<tr>
			<td colspan="100%"><hr></td>
		</tr>
		<cfloop query="getinfo">
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><font size="2" face="Times New Roman, Times, serif">#getinfo.edittype#</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#getinfo.beforeedit#</font></td>
				<td><font size="2" face="Times New Roman, Times, serif">#getinfo.afteredit#</font></td>
                <td><font size="2" face="Times New Roman, Times, serif">#getinfo.edited_by#</font></td>
				<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#dateformat(getinfo.edited_on,"dd/mm/yyyy")#</font></div></td>
				
				<td><font size="2" face="Times New Roman, Times, serif">#getinfo.editrefno#</font></td>
			</tr>
		</cfloop>
	</cfoutput>
	</table>
</body>
</html>