<cfset currentDirectory = "C:\importtranbody\#dts#">
<cfif DirectoryExists(currentDirectory) eq false>
<cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>

	<cftry>
		<cffile action = "delete" file = "C:\importtranbody\#dts#\project.xls">
	<cfcatch type="any">
	</cfcatch>
	</cftry>
	
	<cftry>
		<CFFILE DESTINATION="C:\importtranbody\#dts#\project.xls" ACTION="UPLOAD" FILEFIELD="form.geticitem" attributes="normal">
	<cfcatch type="any">
	</cfcatch>
	</cftry>
    
	<cfset filename="C:/importtranbody/#dts#/project.xls">
	<cfquery name="deleteprojecttemp" datasource="#dts#">
    truncate project_temp
    </cfquery>
    <cftry>
		<cfinclude template = "import_project2.cfm">
    <cfcatch>
    <h3>Please upload the file in .xls format only</h3>
    <cfabort>
    </cfcatch>
    </cftry>    
    
	<cfquery name="getprojecttemp" datasource="#dts#">
    select * FROM #target_project# where porj='P'
    </cfquery>
    <cfset projectlist=valuelist(getprojecttemp.source)>
    
    <cfquery name="getprojecttemp" datasource="#dts#">
    select * FROM #target_project#_temp where source not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#projectlist#">)
    </cfquery>

<html>
<head>
<title>Stock Card Details</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<!--- Add On 28-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select include_SO_PO_stockcard from dealer_menu limit 1
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
	select 
	compro,
	lastaccyear,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION 
	from gsetup;
</cfquery>

<body>
<p align="center"><font color="#000000" size="4" face="Times New Roman, Times, serif"><strong>Project Compare</strong></font></p>

<table width="100%" border="0" align="center" cellspacing="0">
<cfoutput>
    <tr>
    	<td colspan="5"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
      	<td colspan="4"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
    <tr>
    <td colspan="100%"><hr></td>
    </tr>
	<tr>
    <td><font size="2" face="Times New Roman, Times, serif">No.</font></td>
        <td><font size="2" face="Times New Roman, Times, serif">Project</font></td>
    </tr>
    <tr>
    <td colspan="100%"><hr></td>
    </tr>
    <cfset i=1>
    <cfloop query="getprojecttemp">
    <tr>
    <td>
				<div align="left"><font size="2" face="Times New Roman, Times, serif">#i#</font></div>
			</td>
            <td>
				<div align="left"><font size="2" face="Times New Roman, Times, serif">#getprojecttemp.source#</font></div>
			</td>
	</tr>
    <cfset i=i+1>
  	</cfloop>
  	</cfoutput>
</table>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>