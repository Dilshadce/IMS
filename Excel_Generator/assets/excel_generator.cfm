<cfset HRootPath = 'C:/inetpub/wwwroot/IMS/' >
<cfscript>
	/*
*
*    filename (String)
* 	 headerFields (array)
*    excelData (array of array)
*
* 		excelData sample :
*
*       	excelData = [
* 					[ '12313','name','price'],
* 					[ '12313','name','price']
* 				];
*
*
*
*/
	excelRowCount = ArrayLen(excelData);
	columnCount = ArrayLen(headerFields);

</cfscript>
<cfxml variable="data">
	<cfinclude template="excel_header.cfm">
	<Worksheet ss:Name="<cfoutput>#filename#</cfoutput>">
	<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
		<Column ss:Width="64.5"/>
		<Column ss:Width="60.25"/>
		<Column ss:Width="183.75"/>
		<Column ss:AutoFitWidth="0" ss:Width="60"/>
		<Column ss:Width="47.25"/>
		<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
		<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
		<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
		<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
			<cfloop array="#headerFields#" index="field" >
				<Cell ss:StyleID="s27">
					<Data ss:Type="String">
						<cfoutput>
							#field#
						</cfoutput>
					</Data>
				</Cell>
			</cfloop>
		</Row>
		<cfloop from="1" to="#excelRowCount#" index="i" >
			<Row>
				<cfloop from='1' to='#columnCount#' index="j">
					<Cell>
						<Data ss:Type="String">
							<cfoutput>
								#REREPLACE(excelData[i][j],'&','&amp;')#
							</cfoutput>
						</Data>
					</Cell>
				</cfloop>
			</Row>
		</cfloop>
		<Row ss:AutoFitHeight="0" ss:Height="12"/>
	</Table>
	<cfinclude template="/excel_template/excel_footer.cfm">
</cfxml>
<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#filename#.xls" output="#tostring(data)#" charset="utf-8">
<cfheader name="Content-Disposition" value="inline; filename=#dts##filename##huserid#.xls">
<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#filename#.xls">

<cfinclude template="excel_footer.cfm">