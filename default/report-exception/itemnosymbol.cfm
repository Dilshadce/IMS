<html>
<head>
<title>No Location Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
<style type="text/css" media="print">
	.noprint { display: none; }
</style>
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getgsetup2" datasource='#dts#'>
  Select * from gsetup2
</cfquery>

<cfset iDecl_UPrice = getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice = ",.">

<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
  <cfset stDecl_UPrice = stDecl_UPrice & "_">
</cfloop>


<body>
	<cfquery name="getitemno" datasource="#dts#">
		select * from icitem where itemno like "%##%" or itemno like "%?%" or itemno like "%'%" or itemno like '%"%' or itemno like "%@%" or itemno like "%&%" or itemno like "%,%" or itemno like "%\%" or itemno like "%+%"
	</cfquery>
<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="data">
	<tr>
		<td colspan="100%"><div align="center"><font size="3" face="Times New Roman,Times,serif"><strong>Item No Symbol</strong></font></div></td>
	</tr>
    <tr> 
      	<td colspan="4"><font size="2" face="Times New Roman,Times,serif">#getgeneral.compro#</font></td>
      	<td colspan="8"><div align="right"><font size="2" face="Times New Roman,Times,serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
    <tr> 
      	<td colspan="100%"><hr></td>
    </tr>
    <tr>
      	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Itemno</strong></font></div></td>
	  	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong></strong></font></div></td>
      	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Description</strong></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong></strong></font></div></td>
    </tr>
    <tr> 
      	<td colspan="100%"><hr></td>
    </tr>


	
	<cfloop query="getitemno">
	
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    <td><div align="left"><font  face="Times New Roman,Times,serif">#getitemno.itemno#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif"></font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif">#getitemno.desp#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif"></font></div></td>
    </tr>
    
		<tr><td><br></td></tr>
	</cfloop>
	<tr> 
		<td colspan="100%"><hr></td>
	</tr>
	
</table>

</cfoutput>

<cfif getitemno.recordcount eq 0>
	<h3 style="color:red">Sorry, No records were found.</h3>
</cfif>

<br><br>

<div align="right">
	<font  face="Arial,Helvetica,sans-serif">
		<a href="javascript:print()" class="noprint"><u>Print</u></a>
	</font>
</div>

<p class="noprint">
	<font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font>
</p>

</body>
</html>