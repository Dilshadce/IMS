<cfset srcFile = "#ExpandPath('samsung_june.xls')#">
<cfspreadsheet action="read" src="#srcFile#" sheetname="Page56" query="placementEmpno">
<cfset lastrow =1>

<cfloop query="placementEmpno" startrow="11" endrow="50">
		<cfif #placementEmpno.col_1# eq "">
			<cfset lastrow = #placementEmpno.currentRow#>
			<cfbreak>
		</cfif>
	</cfloop>

	<cfset lastrow = #val(lastrow)# - 1>
<cfspreadsheet action="read" src="#srcFile#" sheetname="Page56" rows="#lastrow-1#" query="placementEmpno2">
<cfdump var = #placementEmpno2#>

<cfdump var = #lastrow#>

