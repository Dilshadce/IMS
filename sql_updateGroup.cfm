<cfdirectory action="list" directory="#HRootPath#\images\#hcomid#\" name="picture_list">

<cfoutput>

<cfquery name="getItemNo" datasource="#dts#">
	SELECT *
    FROM icitem;    
</cfquery>

<cfloop query="getItemNo">

    <cfquery name="getictrantemp" datasource="#dts#">
    	INSERT ignore icgroup(wos_group,desp) 
    	VALUES ('#getItemNo.wos_group#','#getItemNo.wos_group#');
	</cfquery>
     
</cfloop>

</cfoutput>








