<html>
<head>
<title>IMS Posted bills But not in AMS</title>
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
<cfset dts2=replace(dts,'_i','_a','all')>

	<cfquery name="getamsbills" datasource="#dts2#">
		select reference from glpost where acc_code<>'' and fperiod<>'99'
	</cfquery>
    
    <cfset amsbills=valuelist(getamsbills.reference)>
    
    <cfquery name="checkims" datasource="#dts#">
		select * from artran where posted='P' and fperiod<>'99' and refno not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#amsbills#">)
	</cfquery>
<cfoutput>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="data">
	<tr>
		<td colspan="100%"><div align="center"><font size="3" face="Times New Roman,Times,serif"><strong>Bills Posted in IMS That Does Not Exist In AMS</strong></font></div></td>
	</tr>
    <tr> 
      	<td colspan="4"><font size="2" face="Times New Roman,Times,serif">#getgeneral.compro#</font></td>
      	<td colspan="8"><div align="right"><font size="2" face="Times New Roman,Times,serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
    <tr> 
      	<td colspan="100%"><hr></td>
    </tr>
    <tr>
      	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Date</strong></font></div></td>
	  	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Bill Type</strong></font></div></td>
      	<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Reference No</strong></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Period</strong></font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Grand Total</strong></font></div></td>
    </tr>
    <tr> 
      	<td colspan="100%"><hr></td>
    </tr>


	
	<cfloop query="checkims">
	
    <tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
    <td><div align="left"><font  face="Times New Roman,Times,serif">#dateformat(checkims.wos_date,'DD/MM/YYYY')#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif">#checkims.type#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif">#checkims.refno#</font></div></td>
    <td><div align="left"><font  face="Times New Roman,Times,serif">#checkims.fperiod#</font></div></td>
    <td><div align="right"><font  face="Times New Roman,Times,serif">#numberformat(checkims.grand,',_.__')#</font></div></td>
    </tr>
    
		<tr><td><br></td></tr>
	</cfloop>
	<tr> 
		<td colspan="100%"><hr></td>
	</tr>
	
</table>

</cfoutput>

<cfif checkims.recordcount eq 0>
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