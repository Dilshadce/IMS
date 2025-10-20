<cfquery name="getictrantemp" datasource="#dts#">
	SELECT custno,name 
    FROM HODAKAMS_a.arcust
</cfquery>

<cfloop query="getictrantemp">
	<cfquery name="getictrantemp22" datasource="#dts#">
		UPDATE artran set
        	frem0 = '#getictrantemp.name#', 
        	name = '#getictrantemp.name#'
		WHERE custno = '#getictrantemp.custno#'
        AND name = ''
	</cfquery>
</cfloop>