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
<!--- <cfset objPOI = CreateObject( 
		"component", 
		"POIUtility" 
		).Init() 
		/> --->
	
	
	<!--- 
		Read in the Exercises excel sheet. This has Push, Pull,
		and Leg exercises split up on to three different sheets.
		By default, the POI Utilty will read in all three sheets
		from the workbook. Since our excel sheet has a header
		row, we want to strip it out of our returned queries.
	--->
<!--- 	<cfset arrSheets = objPOI.ReadExcel( 
		FilePath = "#filename#",
		HasHeaderRow = false
		) /> --->
		
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
    
	 <!--- <cfloop
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
					insert into ictran_excel
					(itemno,desp,comment,brem1,brem2,brem3,brem4,location,qty,price,dispec1,dispec2,dispec3,note_a,taxpec1)
					values
					(<cfqueryparam cfsqltype="cf_sql_varchar" value="#column1#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#column2#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#column3#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#column4#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#column5#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#column6#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#column7#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#column8#">, '#val(replace(column9,',','','all'))#', '#val(replace(column10,',','','all'))#', '#val(replace(column11,',','','all'))#', '#val(replace(column12,',','','all'))#', '#val(replace(column13,',','','all'))#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#column14#">, '#val(replace(column15,',','','all'))#')
				</cfquery>
			</cfif>
		<cfcatch type="any">
			<cfoutput>#column1#::#column2#:::#cfcatch.Message#<br>#cfcatch.Detail#<br></cfoutput>
		</cfcatch>
		</cftry>
	</cfif>
</cfloop></cfloop> --->

<cfspreadsheet action="read" src="#filename#" query="queryData"> 
<cfloop query="querydata" startrow="2">
<cfif trim(querydata.col_1) neq "">
				<cfquery name="inserticitem" datasource="#dts#">
					insert into ictran_excel
					(itemno,desp,comment,brem1,brem2,brem3,brem4,location,qty,price,dispec1,dispec2,dispec3,note_a,taxpec1)
					values
					(<cfqueryparam cfsqltype="cf_sql_varchar" value="BASIC">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(querydata.col_6)#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(querydata.col_1)#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(querydata.col_2)#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(querydata.col_4)# - #trim(querydata.col_5)#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(querydata.col_3)#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="">, '#val(replace(trim(querydata.col_7),',','','all'))#', '#val(replace(trim(querydata.col_8),',','','all'))#', '#val(replace(trim(querydata.col_9),',','','all'))#', '#val(replace(trim(querydata.col_10),',','','all'))#', '0',<cfif val(replace(trim(querydata.col_8),',','','all')) neq 0 and val(replace(trim(querydata.col_9),',','','all')) eq 0>"OS",0<cfelse>"SR",6</cfif>)
				</cfquery>
			</cfif>
</cfloop>