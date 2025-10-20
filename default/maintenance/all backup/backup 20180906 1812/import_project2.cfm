<!--- Blog Entry:
	Reading Excel Files With ColdFusion And POI
	
	Code Snippet:
	1
	
	Author:
	Ben Nadel / Kinky Solutions
	
	Link:
	http://www.bennadel.com/index.cfm?dax=blog:472.view
	
	Date Posted:
	Jan 14, 2007 at 3:08 PM --->


<!---
	Create the Excel file system object. This object is
	responsible for reading in the given Excel file.
--->
<cfset objPOI = CreateObject( 
		"component", 
		"POIUtility" 
		).Init() 
		/>
	
	
	<!--- 
		Read in the Exercises excel sheet. This has Push, Pull,
		and Leg exercises split up on to three different sheets.
		By default, the POI Utilty will read in all three sheets
		from the workbook. Since our excel sheet has a header
		row, we want to strip it out of our returned queries.
	--->
	<cfset arrSheets = objPOI.ReadExcel( 
		FilePath = "#filename#",
		HasHeaderRow = false
		) />
		
<!---         <cfloop
		index="intSheet"
		from="1"
		to="#ArrayLen( arrSheets )#"
		step="1">
		
		<!--- Get a short hand to the current sheet. --->
		<cfset objSheet = arrSheets[ intSheet ] />
        <cfdump var="#objSheet#">
        </cfloop> --->
	
	<!--- 
		The ReadExcel() has returned an array of sheet object.
		Let's loop over sheets and output the data. NOTE: This
		could be also done to insert into a DATABASE!
	--->
    
	 <cfloop
		index="intSheet"
		from="1"
		to="#ArrayLen( arrSheets )#"
		step="1">
		
		<!--- Get a short hand to the current sheet. --->
		<cfset objSheet = arrSheets[ intSheet ] />
<!--- <cfdump var="#qCell#"> --->




<cfloop query="objSheet.Query">
<cfset qCell = objSheet.Query>
	<cfif qCell.currentrow gt 1>
		<cftry>

			<cfif trim(column1) neq "">
				<cfquery name="inserticitem" datasource="#dts#">
					insert into project_temp
					(source)
					values
					(<cfqueryparam cfsqltype="cf_sql_varchar" value="#column1#">)
				</cfquery>
			</cfif>
		<cfcatch type="any">
			<cfoutput>#column1#:::#cfcatch.Message#<br>#cfcatch.Detail#<br></cfoutput>
		</cfcatch>
		</cftry>
	</cfif>
</cfloop></cfloop>
