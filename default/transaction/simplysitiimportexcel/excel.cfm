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
<cfset objExcelFileSystem = CreateObject(
	"java",
	"org.apache.poi.poifs.filesystem.POIFSFileSystem"
	).Init(
 
		CreateObject(
			"java",
			"java.io.FileInputStream"
			).Init(#filename#)) />
 
 
<!---
	Get the workbook from the Excel file system object that
	we just created. Remember, the workbook contains the
	Excel sheets that have our data.
--->
<cfset objWorkBook = CreateObject(
	"java",
	"org.apache.poi.hssf.usermodel.HSSFWorkbook"
	).Init(
		objExcelFileSystem
		) />
 
<!---
	For this demo, we are only interested in reading in the
	data from the first sheet. Remember, since Java is zero-
	based, not one-based like ColdFusion, the first Excel
	sheet is at index ZERO (not ONE).
--->
<cfset objSheet = objWorkBook.GetSheetAt(
	JavaCast( "int", 0 )
	) />
 
 
<!---
	We are going to build a ColdFusion query that houses the
	Excel data, but we don't know anything about the data
	just yet. So, just create the place holder for the query
	and then we will add to it when we have more information.
--->
<cfset qCell = "" />
 
 
<!---
	Get the Excel sheet's row iterator. This appears to be some
	sort of implementation of the Java class java.util.TreeMap,
	but I don't know much about that. What I do know, is that
	this will allow us to loop over the rows in the Excel file
	until there are no more to loop over. The interface for it
	looks like the standard iterator interface.
--->
<cfset objRowIterator = objSheet.rowIterator() />
 
 
<!---
	User the row iterator to loop over all the physical rows in
	the Excel sheet. This condition checks to see if we have a
	row to read in. At this point, the iterator is NOT pointing
	at a valid Excel data row.
--->
<cfloop condition="objRowIterator.HasNext()">
 
	<!---
		We have determined that we have a valid row to read.
		Now, move the iterator to point to this valid row.
	--->
	<cfset objRow = objRowIterator.Next() />
 
	<!---
		Get the number of physical cells in this row. While I
		think that this can possibly change from row to row,
		for the purposes of this demo, I am going to assume
		that all rows are uniform and that this row is a model
		of how the rest of the data will be displayed.
	--->
	<cfset intCellCount = objRow.GetPhysicalNumberOfCells() />
 
 
	<!---
		Check to see if the query variable we have it actually
		a query. If we have not done anything to it yet, then
		it should still just be a string value (Yahoo for
		dynamic typing!!!). If that is the case, then let's use
		this first data row to set up the query object.
	--->
	<cfif NOT IsQuery( qCell )>
 
		<!---
			Create an empty query. Doing it this way creates a
			query with neither column nor row values.
		--->
		<cfset qCell = QueryNew( "" ) />
 
		<!---
			Now that we have an empty query, we are going to
			loop over the cells COUNT for this data row and for
			each cell, we are going to create a query column
			of type VARCHAR. I understand that cells are going
			to have different data types, but I am chosing to
			store everything as a string to make it easier.
		--->
		<cfloop
			index="intCell"
			from="0"
			to="#(intCellCount - 1)#"
			step="1">
 
			<!---
				Add the column. Notice that the name of the
				column is the text "column" plus the column
				index. I am starting my column indexes at ONE
				rather than ZERO to get it back into a more
				ColdFusion standard notation.
			--->
			<cfset QueryAddColumn(
				qCell,
				"column#(intCell + 1)#",
				"CF_SQL_VARCHAR",
				ArrayNew( 1 )
				) />
 
		</cfloop>
 
	</cfif>
 
 
	<!---
		ASSERT: Whether we are on our first Excel data row or
		our Nth data row, at this point, we have a ColdFusion
		query object that has the proper columns defined.
	--->
 
	<!---
		Add a row to the query so that we can store this row's
		data values.
	--->
	<cfset QueryAddRow( qCell ) />
 
 
	<!--- Loop over the cells in this row to find values. --->
	<cfloop
		index="intCell"
		from="0"
		to="#(intCellCount - 1)#"
		step="1">
 
 
		<!---
			When getting the value of a cell, it is important
			to know what type of cell value we are dealing
			with. If you try to grab the wrong value type,
			an error might be thrown. For that reason, we must
			check to see what type of cell we are working with.
			These are the cell types and they are constants
			of the cell object itself:
 
			0 - CELL_TYPE_NUMERIC
			1 - CELL_TYPE_STRING
			2 - CELL_TYPE_FORMULA
			3 - CELL_TYPE_BLANK
			4 - CELL_TYPE_BOOLEAN
			5 - CELL_TYPE_ERROR
		--->
 
		<!--- Get the cell from the row object. --->
		<cftry>
			<cfset objCell = objRow.GetCell(
				JavaCast( "int", intCell )
				) />
	 
			<!--- Get the type of data in this cell. --->
			<cfset objCellType = objCell.GetCellType() />
	 
			<!---
				Get teh value of the cell based on the data type.
				The thing to worry about here is cell forumlas and
				cell dates. Formulas can be strange and dates are
				stored as numeric types. For this demo, I am not
				going to worry about that at all. I will just grab
				dates as floats and formulas I will try to grab as
				numeric values.
			--->
			<cfif (objCellType EQ objCell.CELL_TYPE_NUMERIC)>
	 
				<!---
					Get numeric cell data. This could be a
					standard number, could also be a date value.
					I am going to leave it up to the calling
					program to decide.
				--->
				<cfset objCellValue = objCell.GetNumericCellValue() />
	 
			<cfelseif (objCellType EQ objCell.CELL_TYPE_STRING)>
	 
				<cfset objCellValue = objCell.GetStringCellValue() />
	 
			<cfelseif (objCellType EQ objCell.CELL_TYPE_FORMULA)>
	 
				<!---
					Since most forumlas deal with numbers, I am
					going to try to grab the value as a number. If
					that throws an error, I will just grab it as a
					string value.
				--->
				<cftry>
					<cfset objCellValue = objCell.GetNumericCellValue() />
	 
					<cfcatch>
	 
						<!---
							The numeric grab failed. Try to get the
							value as a string. If this fails, just
							force the empty string.
						--->
						<cftry>
							<cfset objCellValue = objCell.GetStringCellValue() />
	 
							<cfcatch>
	 
								<!--- Force empty string. --->
								<cfset objCellValue = "" />
	 
							</cfcatch>
						</cftry>
	 
					</cfcatch>
				</cftry>
	 
			<cfelseif (objCellType EQ objCell.CELL_TYPE_BLANK)>
	 
				<cfset objCellValue = "" />
	 
			<cfelseif (objCellType EQ objCell.CELL_TYPE_BOOLEAN)>
	 
				<cfset objCellValue = objCell.GetBooleanCellValue() />
	 
			<cfelse>
	 
				<!--- If all else fails, get empty string. --->
				<cfset objCellValue = "" />
	 
			</cfif>
		<cfcatch type="any">
			<cfset objCellValue = "" />
		</cfcatch>
		</cftry>
		<!--- <cfset objCell = objRow.GetCell(
			JavaCast( "int", intCell )
			) />
 
		<!--- Get the type of data in this cell. --->
		<cfset objCellType = objCell.GetCellType() />
 
		<!---
			Get teh value of the cell based on the data type.
			The thing to worry about here is cell forumlas and
			cell dates. Formulas can be strange and dates are
			stored as numeric types. For this demo, I am not
			going to worry about that at all. I will just grab
			dates as floats and formulas I will try to grab as
			numeric values.
		--->
		<cfif (objCellType EQ objCell.CELL_TYPE_NUMERIC)>
 
			<!---
				Get numeric cell data. This could be a
				standard number, could also be a date value.
				I am going to leave it up to the calling
				program to decide.
			--->
			<cfset objCellValue = objCell.GetNumericCellValue() />
 
		<cfelseif (objCellType EQ objCell.CELL_TYPE_STRING)>
 
			<cfset objCellValue = objCell.GetStringCellValue() />
 
		<cfelseif (objCellType EQ objCell.CELL_TYPE_FORMULA)>
 
			<!---
				Since most forumlas deal with numbers, I am
				going to try to grab the value as a number. If
				that throws an error, I will just grab it as a
				string value.
			--->
			<cftry>
				<cfset objCellValue = objCell.GetNumericCellValue() />
 
				<cfcatch>
 
					<!---
						The numeric grab failed. Try to get the
						value as a string. If this fails, just
						force the empty string.
					--->
					<cftry>
						<cfset objCellValue = objCell.GetStringCellValue() />
 
						<cfcatch>
 
							<!--- Force empty string. --->
							<cfset objCellValue = "" />
 
						</cfcatch>
					</cftry>
 
				</cfcatch>
			</cftry>
 
		<cfelseif (objCellType EQ objCell.CELL_TYPE_BLANK)>
 
			<cfset objCellValue = "" />
 
		<cfelseif (objCellType EQ objCell.CELL_TYPE_BOOLEAN)>
 
			<cfset objCellValue = objCell.GetBooleanCellValue() />
 
		<cfelse>
 
			<!--- If all else fails, get empty string. --->
			<cfset objCellValue = "" />
 
		</cfif> --->
 
 
		<!---
			ASSERT: At this point, we either got the cell value
			out of the Excel data cell or we have thrown an
			error or didn't get a matching type and just
			have the empty string by default. No matter what,
			the object objCellValue is defined and has some
			sort of SIMPLE ColdFusion value in it.
		--->
 
 
		<!---
			Now that we have a value, store it as a string in
			the ColdFusion query object. Remember again that my
			query names are ONE based for ColdFusion standards.
			That is why I am adding 1 to the cell index.
		--->
		<cfset qCell[ "column#(intCell + 1)#" ][ qCell.RecordCount ] = JavaCast( "string", objCellValue ) />
 
 
	</cfloop>
 
</cfloop>
 
 
<!---
	At this point, the excel data should be in a ColdFusion
	query object. However, if the query did not contain any
	record, then the row iterator was never launched which
	mean we never actually defined a query. As one final check
	just make sure we are dealing with a query.
--->
<cfif NOT IsQuery( qCell )>
 
	<!--- Just define an empty query. --->
	<cfset qCell = QueryNew( "" ) />
 
</cfif>
<!--- <cfdump var="#qCell#"> --->

