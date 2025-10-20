<cfdirectory action="list" directory="#HRootPath#\images\#hcomid#\" name="picture_list">

<cfoutput>

<cfquery name="getItemNo" datasource="#dts#">
	SELECT *
    FROM icitem;    
</cfquery>

<cfloop query="getItemNo">

    <cfquery name="getictrantemp" datasource="#dts#">
    	INSERT ignore iccate(cate,desp) 
    	VALUES ('#getItemNo.category#','#getItemNo.category#');
	</cfquery>
     
</cfloop>

</cfoutput>








