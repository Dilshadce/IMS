<cfsetting showdebugoutput="yes">
<!---import csv file into manpower_p.timesheet, [20170322, Alvin]--->
<cfoutput>
    <cfif IsDefined('form.path') AND ('form.path') NEQ "">
    	<cfset path = replace(form.importFile,'\', '\\')>
        
        <cftry>
            <CFFILE DESTINATION="#HRootPath#\importfile\timesheet_import.csv" ACTION="UPLOAD" FILEFIELD="form.importFile" attributes="normal">
        <cfcatch type="any">
        	#cfcatch.message# <br>  #cfcatch.detail# 
        </cfcatch>
        </cftry>
        
        <cfquery name="InsertIntoTimesheet" datasource="#form.comid#_p"><!---change to manpower_p to import live--->
        	LOAD DATA LOCAL INFILE '#Replace(HRootPath, '\', '\\', 'ALL')#\\importfile\\timesheet_import.csv' INTO TABLE timesheet
            FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY
            '\r\n' (placementno, empno, stcol, tsrowcount, pdate, starttime, endtime, workhours, breaktime, ot1, ot2, ot3, ot4, ot5, ot6, ot7, ot8, remarks, ampm, tmonth);
        </cfquery>	
        
        <cftry>
            <cffile action = "delete" file = "#HRootPath#\importfile\timesheet_import.csv">	 
        <cfcatch type="any">
            #cfcatch.message# <br>  #cfcatch.detail# 
        </cfcatch>
        </cftry>
        
        <script>
			alert("Record inserted into timesheet!");
			window.open('/default/admin/importtable/ImportCsvTimesheet.cfm','_self');
		</script>
    </cfif>
    
    <cfif IsDefined('form.generatePath') AND ('form.generatePath') NEQ "" AND #exceltype# NEQ "">
    	<cfset path = replace(form.generatePath,'\', '\\')>
        <cfif #exceltype# EQ "Samsung">
            <cfset excelfile = 'timesheet_import_generate.xlsx'>
            <cfset excellocation = 'Excel_to_csv.cfm'>
        <cfelse>
            <cfset excelfile = 'jo_timesheet_generate.csv'>
            <cfset excellocation = 'Excel_to_csv_JO.cfm'>
        </cfif>
            
        <cftry>
            <CFFILE DESTINATION="#HRootPath#\importfile\#excelfile#" ACTION="UPLOAD" nameconflict="OVERWRITE" FILEFIELD="form.generateFile" attributes="normal">
                
            <cflocation url="../../../csv_generator/#excellocation#">
        <cfcatch type="any">
        	#cfcatch.message# <br>  #cfcatch.detail# 
        </cfcatch>
        </cftry>
    
    </cfif>

</cfoutput>
<!---import CSV--->