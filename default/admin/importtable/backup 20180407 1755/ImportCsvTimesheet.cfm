<cfsetting showdebugoutput="yes">
<!---import csv file into manpower_p.timesheet, [20170322, Alvin]--->

<cfoutput>

<html>
<head>
	<script type="text/javascript">
    	function checkCsv()
		{
			if(document.getElementById('importFile').value.match(".csv"))
			{
				document.getElementById('submitButton').disabled = false;
				document.getElementById('path').value = document.getElementById('importFile').value;
			}
			else
			{
				document.getElementById('submitButton').disabled = true;	
			}
		}
		
		function checkExcel()
		{
			if(document.getElementById('generateFile').value.match(".xlsx") || document.getElementById('generateFile').value.match(".csv"))
			{
				document.getElementById('submitButton2').disabled = false;
				document.getElementById('generatePath').value = document.getElementById('generateFile').value;
			}
			else
			{
				document.getElementById('submitButton2').disabled = true;	
			}
		}
    </script>
</head>
<body>
    <h1> Import CSV File Into Timesheet Module </h1>
    <h2 style="background:##FF0"> Note** The column in CSV file has to be in the following order:</h2>
    <h3> Sample format: <a href="download/timesheet_format.xlsx"> timesheet_format.csv </a>(Empty excel) 
    	 OR  <a href="download/timesheet_format.csv"> timesheet_format.csv </a>(Filled with sample data - CSV) 
    </h3>
    <h4> **You may use the template and add data into empty template. <br />
    	 **Please Remove the First Line (Header) Before Convert to .CSV	<br>
		 **If data is not arranged according to the sample header, it might mess up the data. <br />
	 **Import is only available for testing database to avoid any mixing up of data. Please request to open the functionality to import to live once testing has been done.
    </h4>
	<h3>
    	<table>
        <tr>
        	<th> No. </th>
            <th> Column </th>
            <th> Description </th>
        </tr>
        <tr>
        	<td> 1. </td>
            <td> Placementno </td>
            <td> - Placement no </td>
        </tr>
        
        <tr>
        	<td> 2. </td>
            <td> Empno </td>
            <td> - Employee no </td>
        </tr>

        <tr>
        	<td> 3. </td>
            <td> stcol </td>
            <td> - (worktype, e.g. AL,WD,OD,etc.) </td>
        </tr>
        
        <tr>
        	<td> 4. </td>
            <td> tsrowcount </td>
            <td> - [digit] (day count: starts from zero) For example, first day of the timesheet will be given tsrowcount = 0, second day tsrowcount =1 and so on </td>
        </tr>
        
        <tr>
        	<td> 5. </td>
            <td> Pdate </td>
            <td> - Date (YYYY-MM-DD) format </td>
        </tr>
        
        <tr>
        	<td> 6. </td>
            <td> starttime </td>
            <td> - Time in (HH:MM:SS) format </td>
        </tr>
        
        <tr>
        	<td> 7. </td>
            <td> endtime </td>
            <td> - Time out (HH:MM:SS) format </td>
        </tr>
        
        <tr>
        	<td> 8. </td>
            <td> workhours </td>
            <td> - Working hour of the day (x.xx) e.g.[8.50] format </td>
        </tr>
        
        <tr>
        	<td> 9. </td>
            <td> breaktime </td>
            <td> - Break hour (x.xx) e.g.[1.75] format </td>
        </tr>
        
        <tr>
        	<td> 10. </td>
            <td> ot1 </td>
            <td> - Ot 1.0 hour (x.xxxxx) e.g.[3.50000] format </td>
        </tr>
        
        <tr>
        	<td> 11. </td>
            <td> ot2 </td>
            <td> - Ot 1.5 hour (x.xxxxx) e.g.[3.50000] format </td>
        </tr>
        
        <tr>
        	<td> 12. </td>
            <td> ot3 </td>
            <td> - Ot 2.0 hour (x.xxxxx) e.g.[3.50000] format </td>
        </tr>
        
        <tr>
        	<td> 13. </td>
            <td> ot4 </td>
            <td> - Ot 3.0 hour (x.xxxxx) e.g.[3.50000] format </td>
        </tr>
        
        <tr>
        	<td> 14. </td>
            <td> ot5 </td>
            <td> - RD 1.0 hour (x.xxxxx) e.g.[3.50000] format </td>
        </tr>
        
        <tr>
        	<td> 15. </td>
            <td> ot6 </td>
            <td> - RD 2.0 hour (x.xxxxx) e.g.[3.50000] format </td>
        </tr>
        
        <tr>
        	<td> 16. </td>
            <td> ot7 </td>
            <td> - Ph 1.0 hour (x.xxxxx) e.g.[3.50000] format </td>
        </tr>
        
        <tr>
        	<td> 17. </td>
            <td> ot8 </td>
            <td> - Ph 2.0 hour (x.xxxxx) e.g.[3.50000] format </td>
        </tr>
        
        <tr>
        	<td> 18. </td>
            <td> remarks </td>
            <td> - Remarks (String format) </td>
        </tr>
        
        <tr>
        	<td> 19. </td>
            <td> ampm </td>
            <td> - leave type (AM, PM, FUll DAY) (String format) </td>
        </tr>
            
        <tr>
        	<td> 18. </td>
            <td> tmont </td>
            <td> - Month Of The Timesheet (String format) </td>
        </tr>

    	</table>
    </h3>    
    
    <!---<cfif IsDefined('form.path')>
    	<cfset path = replace(form.importFile,'\', '\\')>
        
        <cftry>
            <CFFILE DESTINATION="C:\timesheet_import.csv" ACTION="UPLOAD" FILEFIELD="form.importFile" attributes="normal">
        <cfcatch type="any">
        	#cfcatch.message# <br>  #cfcatch.detail# 
        </cfcatch>
        </cftry>
        
        <cfquery name="InsertIntoTimesheet" datasource="manpower_p"><!---change to manpower_p to import live--->
        	LOAD DATA LOCAL INFILE 'C:\\timesheet_import.csv' INTO TABLE timesheet
            FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY
            '\r\n' (placementno, empno, stcol, tsrowcount, pdate, starttime, endtime, workhours, breaktime, ot1, ot2, ot3, ot4, ot5, ot6, ot7, ot8, remarks);
        </cfquery>	
        
        <cftry>
            <cffile action = "delete" file = "C:\timesheet_import.csv">	 
        <cfcatch type="any">
            #cfcatch.message# <br>  #cfcatch.detail# 
        </cfcatch>
        </cftry>
        
        <script>
			alert("Record inserted into timesheet!");
		</script>
    </cfif>--->
    
    <form name="form1" id="form1" method="post" action="ImportCsvTimesheetProcess.cfm" target="_self" enctype="multipart/form-data">
        <div align="center">
            <h3>Database: 
                <select name="comID" id="comID" style="width: 150px">
                    <option id="manpowertest" value="manpowertest">manpowertest</option>
                    <cfif #HUserGrpID# EQ "Super">
                        <option id="manpower" value="manpower">manpower</option>                
                    </cfif>
                </select>
            </h3>
            <br />
            <input type="file" name="importFile" id="importFile" size="50" accept=".csv" onChange="checkCsv()">
            <input type="hidden" name="path" id="path" value="">
            <button type="submit" id="submitButton" name="submitButton" disabled> Import </button>
        </div>
	</form>
	
	<h2>Generate CSV Timesheet (Samsung - Maximum 60 tab of sheet in excel file)</h2>
	
	<form name="form2" id="form2" method="post" action="ImportCsvTimesheetProcess.cfm" target="_blank" enctype="multipart/form-data">
        <div align="center">
            <input type="file" name="generateFile" id="generateFile" size="50" accept=".xlsx,.csv" onChange="checkExcel()">
            <input type="hidden" name="generatePath" id="generatePath" value="">
            <input type="radio" name="exceltype" id="exceltype" value="Samsung" checked> Samsung (xlsx file)
            <input type="radio" name="exceltype" id="exceltype2" value="TAS"> Time Attendance System (TAS - csv file) <br /> <br />
            <button type="submit" id="submitButton2" name="submitButton2" disabled> Generate Csv </button>
        </div>
	</form>
	
	</body>
</html>

</cfoutput>
<!---import CSV--->