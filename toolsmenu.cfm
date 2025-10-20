<html>
<head>
<title>Purchase Transactions Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>
<body>

<h1 align="center">Purchase Transactions</h1>

<cfquery name="gettranname" datasource="#dts#">
select lconsignin,lconsignout,lISS,lOAI,lOAR from gsetup
</cfquery> 

<table width="75%" border="0" align="center" class="data">
	<tr> 
    	<td height="30" colspan="4"><div align="center">PURCHASE TRANSACTION</div></td>
  	</tr>
    <cfquery name="getGeneralInfo" datasource="#dts#">
	select * 
	from gsetup;
	</cfquery>
		<tr> 
        <cfif getpin2.h5D00 eq "T" >

        <td width="25%">
			<a href="/default/admin/importtable/import.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Import CSV File to IMS
			</a>
		</td>
        </cfif>
        
        <cfif getpin2.h5E00 eq "T" >
        <td width="25%">
			<a href="/default/admin/importtable/import_excel.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Import EXCEL File to IMS
			</a>
		</td>
        </cfif>
        <cfif getpin2.h5F00 eq "T" >
        <td width="25%">
			<a href="/default/admin/export_to_csv_list.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Export To CSV File
			</a>
		</td>
        </cfif>
        <cfif getpin2.H5900 eq "T">
        <td width="25%">
			<a href="/default/admin/bossmenu/bossmenu.cfm" target="mainFrame"><img name="Cash Sales" src="../../images/reportlogo.gif">
				Boss Menu
			</a>
		</td>
    </cfif>
        	

</table>

</body>
</html>