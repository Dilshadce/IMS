<cfdirectory action="list" directory="#HRootPath#\images\#hcomid#\" name="picture_list">

<cfoutput>

<cfquery name="getUnit" datasource="#dts#">
	SELECT unit
    FROM ictran;    
</cfquery>

<cfloop query="getUnit">

    <cfquery name="updateUnit" datasource="#dts#">
    	INSERT ignore unit(unit,desp) 
    	VALUES ('#getItemNo.unit#','#getItemNo.unit#');
	</cfquery>
     
</cfloop>

</cfoutput>








