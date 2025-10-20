<html>
<head>
<title>Boss Menu</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<cfquery name="getmodule" datasource="#dts#">
	select * 
	from modulecontrol;
</cfquery>

<h1><center>Boss Menu</center></h1>
<cfquery datasource="#dts#" name="getGeneral">
	select * from gsetup
</cfquery>
<table width="85%" border="0" class="data" align="center">
  	<tr>
		<cfif getpin2.H5910 eq "T">
    		<td><a href="changeitemno.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change Item No.</a></td>
		</cfif>
		<cfif getpin2.H5920 eq "T">
    		<td><a href="changecategory.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change <cfoutput>#getGeneral.lCATEGORY#</cfoutput></a></td>
		</cfif>
		<cfif getpin2.H5930 eq "T">
    		<td><a href="changegroup.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change <cfoutput>#getGeneral.lGROUP#</cfoutput></a></td>
		</cfif>
		<cfif getpin2.H5940 eq "T">
    		<td><a href="changeservice.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change Service Code</a></td>
		</cfif>
  	</tr>
	<tr>
		<cfif getpin2.H5950 eq "T">
    		<td><a href="changecustsupp.cfm?custtype=Customer" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change Customer No.</a></td>
		</cfif>
		<cfif getpin2.H5960 eq "T">
    		<td><a href="changecustsupp.cfm?custtype=Supplier" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change Supplier No.</a></td>
		</cfif>
		<cfif getpin2.H5970 eq "T">
			<td><a href="changeagent.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change <cfoutput>#getGeneral.lAGENT#</cfoutput></a></td>
		</cfif>
		<cfif getpin2.H5980 eq "T">
			<td><a href="changerefno.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change Reference No.</a></td>
		</cfif>
  	</tr>
    <tr>
    		<cfif getpin2.H5990 eq "T">
			<td><a href="changebrand.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change Brand</a></td>
		</cfif>
        <cfif getpin2.H59A0 eq "T">
			<td><a href="changeproject.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change <cfoutput>#getGeneral.lproject#</cfoutput></a></td>
		</cfif>
        <cfif getpin2.H59B0 eq "T">
			<td><a href="changejob.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change <cfoutput>#getGeneral.ljob#</cfoutput></a></td>
		</cfif>
        <cfif getpin2.H59C0 eq "T">
			<td><a href="recovertransaction.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Recover Updated Transaction</a></td>
		</cfif>
    </tr>
    <tr>
    <cfif getpin2.H59D0 eq "T">
			<td><a href="changeenduser.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change <cfoutput>#getGeneral.ldriver#</cfoutput></a></td>
		</cfif>
        <cfif getpin2.H59E0 eq "T">
			<td><a href="enableedit.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Enable Edit Of Transaction That are updated</a></td>
		</cfif>
        <cfif getpin2.H59F0 eq "T">
			<td><a href="changedate.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change Date</a></td>
		</cfif>
        <cfif getpin2.H59G0 eq "T">
			<td><a href="costformula.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Update Cost Code</a></td>
		</cfif>
    </tr>
    <tr>
    <cfif getpin2.H59H0 eq "T">
			<td><a href="changeterm.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change Term</a></td>
		</cfif>
    <cfif getpin2.H59I0 eq "T">
			<td><a href="recovervoid.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Unvoid Transaction</a></td>
		</cfif>
        <cfif getpin2.H59J0 eq "T">
			<td><a href="changebusiness.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change Business</a></td>
		</cfif>
        <cfif getpin2.H59K0 eq "T">
			<td><a href="changearea.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change Area</a></td>
		</cfif>
    </tr>
    <tr>
    <cfif getpin2.H59L0 eq "T">
			<td><a href="changeteam.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change Team</a></td>
		</cfif>
         <cfif getpin2.H59M0 eq "T">
			<td><a href="changecolorid.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change <cfoutput>#getGeneral.LMaterial#</cfoutput></a></td>
		</cfif>
        <cfif getpin2.H59M0 eq "T">
			<td><a href="changeaddress.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change Address</a></td>
		</cfif>
        <cfif getpin2.H59M0 eq "T">
			<td><a href="changelocation.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change Location</a></td>
		</cfif>
        </tr>
        
    <tr>
<cfif getmodule.auto eq "1">
			<td><a href="changevehicle.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change Vehicle</a></td>
		</cfif>
        <td><a href="changeattentionno.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Change Attention No</a></td>
        <cfif getpin2.H5910 eq "T" and left(dts,4) eq "tcds">
        <td>
        <a href="replaceitemno.cfm" target="mainFrame"><img name="Cash Sales" src="/images/reportlogo.gif">Replace Itemno</a>
        </td>
		</cfif>
    </tr>
</table>

</body>
</html>