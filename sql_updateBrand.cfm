<cfdirectory action="list" directory="#HRootPath#\images\#hcomid#\" name="picture_list">

<cfoutput>

<cfquery name="getItemNo" datasource="#dts#">
	SELECT *
    FROM icitem;    
</cfquery>

<cfloop query="getItemNo">

    <cfquery name="updateBrand" datasource="#dts#">
    	INSERT ignore brand(brand,desp) 
    	VALUES ('#getItemNo.brand#','#getItemNo.brand#');
	</cfquery>
     
</cfloop>

</cfoutput>








