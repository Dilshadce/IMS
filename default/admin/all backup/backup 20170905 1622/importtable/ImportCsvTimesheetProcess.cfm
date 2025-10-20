<cfsetting showdebugoutput="yes">
<!---import csv file into manpower_p.timesheet, [20170322, Alvin]--->
<cfoutput>
    <cfif IsDefined('form.path') AND ('form.path') NEQ "">
    	<cfset path = replace(form.importFile,'\', '\\')>
        
        <cftry>
            <CFFILE DESTINATION="C:\timesheet_import.csv" ACTION="UPLOAD" FILEFIELD="form.importFile" attributes="normal">
        <cfcatch type="any">
        	#cfcatch.message# <br>  #cfcatch.detail# 
        </cfcatch>
        </cftry>
        
        <cfquery name="InsertIntoTimesheet" datasource="#form.comid#_p"><!---change to manpower_p to import live--->
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
			window.open('/default/admin/importtable/ImportCsvTimesheet.cfm','_self');
		</script>
    </cfif>
    
    <cfif IsDefined('form.generatePath') AND ('form.generatePath') NEQ "">
    	<cfset path = replace(form.generatePath,'\', '\\')>
        
        
        
        <cftry>
            <CFFILE DESTINATION="C:\NEWSYSTEM\IMS\timesheet_import_generate.xlsx" ACTION="UPLOAD" nameconflict="OVERWRITE" FILEFIELD="form.generateFile" attributes="normal">
        <cfcatch type="any">
        	#cfcatch.message# <br>  #cfcatch.detail# 
        </cfcatch>
        </cftry>
        
        <cfinclude template="../../../csv_generator/Excel_to_csv.cfm">

        <!---<cftry>
            <cffile action = "delete" file = "C:\NEWSYSTEM\IMS\timesheet_import_generate.xlsx">	 
        <cfcatch type="any">
            #cfcatch.message# <br>  #cfcatch.detail# 
        </cfcatch>
        </cftry>--->
        
        <!---<script>
			alert("Record inserted into timesheet!");
			window.open('/default/admin/importtable/ImportCsvTimesheet.cfm','_self');
		</script>--->
    </cfif>

</cfoutput>
<!---import CSV--->