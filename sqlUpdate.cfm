<cfquery name="getArcust" datasource="#dts#">
	SELECT custno,name
	FROM kaydesign_a.arcust
</cfquery>

<cfloop query="getArcust">
	<cfquery name="getictrantemp22" datasource="#dts#">
		UPDATE artran
        SET 
            name = '#trim(getArcust.name)#',
            frem0 = '#trim(getArcust.name)#'
        WHERE frem0 = ''	   
        AND custno = '#trim(getArcust.custno)#'
	</cfquery>
</cfloop>