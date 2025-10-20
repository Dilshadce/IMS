<html>
<head>
<title>Generate Print Bills</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<body>


<cftry>
<cfif lcase(hcomid) eq "anab_i" and url.type eq "CN" >
<cfinclude template="../../billformat/#dts#/print_bills/print_bills_menu.cfm">

	<cfelseif url.type eq "INV" or lcase(hcomid) eq "anab_i" and url.type eq "CN" or lcase(hcomid) eq "elitez_i" and url.type eq "DO" or lcase(hcomid) eq "pengwang_i" and url.type eq "CN" or lcase(hcomid) eq "taftc_i" and url.type eq "CN"> 
    <cfinclude template="../../billformat/#dts#/print_bills/print_bills_menu1.cfm">
    <cfelse>
	<cfinclude template="../../billformat/#dts#/print_bills/print_bills_menu.cfm">
	</cfif>
	<cfcatch type="any">
    
    <cfset currentDirectory = GetDirectoryFromPath(GetTemplatePath()) & "..\..\billformat\"&dts&"\print_bills">
	<cfif DirectoryExists(currentDirectory) eq false>
    
	<cfdirectory action = "create" directory = "#currentDirectory#" >
      
    <cfset copy1=GetDirectoryFromPath(GetTemplatePath()) &"..\..\billformat\general\print_bills\print_bills_menu.cfm">
    <cfset paste1=GetDirectoryFromPath(GetTemplatePath()) &"..\..\billformat\"&dts&"\print_bills\">
<cffile action = "copy" source = "#copy1#" 
    destination = "#paste1#">
    
    <cfset copy2=GetDirectoryFromPath(GetTemplatePath()) &"..\..\billformat\general\print_bills\print_bills_menu1.cfm">
    <cfset paste2=GetDirectoryFromPath(GetTemplatePath()) &"..\..\billformat\"&dts&"\print_bills\">
<cffile action = "copy" source = "#copy2#" 
    destination = "#paste2#">
    
    <cfset copy3=GetDirectoryFromPath(GetTemplatePath()) &"..\..\billformat\general\print_bills\print_bills_result.cfm">
    <cfset paste3=GetDirectoryFromPath(GetTemplatePath()) &"..\..\billformat\"&dts&"\print_bills\">
<cffile action = "copy" source = "#copy3#" 
    destination = "#paste3#">
    
    <cfset copy4=GetDirectoryFromPath(GetTemplatePath()) &"..\..\billformat\general\print_bills\print_bills_result1.cfm">
    <cfset paste4=GetDirectoryFromPath(GetTemplatePath()) &"..\..\billformat\"&dts&"\print_bills\">
<cffile action = "copy" source = "#copy4#" 
    destination = "#paste4#">
    
    <cfset copy5=GetDirectoryFromPath(GetTemplatePath()) &"..\..\billformat\general\print_bills\print_bills_result1Ajax.cfm">
    <cfset paste5=GetDirectoryFromPath(GetTemplatePath()) &"..\..\billformat\"&dts&"\print_bills\">
<cffile action = "copy" source = "#copy5#" 
    destination = "#paste5#">
    
    <cfset copy6=GetDirectoryFromPath(GetTemplatePath()) &"..\..\billformat\general\print_bills\print_bills_result2.cfm">
    <cfset paste6=GetDirectoryFromPath(GetTemplatePath()) &"..\..\billformat\"&dts&"\print_bills\">
<cffile action = "copy" source = "#copy6#" 
    destination = "#paste6#">
    
    <cfset copy7=GetDirectoryFromPath(GetTemplatePath()) &"..\..\billformat\general\print_bills\print_bills_result21.cfm">
    <cfset paste7=GetDirectoryFromPath(GetTemplatePath()) &"..\..\billformat\"&dts&"\print_bills\">
<cffile action = "copy" source = "#copy7#" 
    destination = "#paste7#">

	<cfset copy8=GetDirectoryFromPath(GetTemplatePath()) &"..\..\billformat\general\preprintedformat1.cfm">
    <cfset paste8=GetDirectoryFromPath(GetTemplatePath()) &"..\..\billformat\"&dts&"\">
<cffile action = "copy" source = "#copy8#" 
    destination = "#paste8#">
	</cfif>
    

		
		<script language="javascript" type="text/javascript">
		history.go(0)
		</script>
	</cfcatch>
</cftry>

</body>
</html>