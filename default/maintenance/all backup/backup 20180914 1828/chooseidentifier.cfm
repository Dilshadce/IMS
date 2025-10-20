    <cfquery datasource='#dts#' name="getidentifier">
		select * from identifier order by identifierno
	</cfquery>

<cfoutput><h1>Company List</h1></cfoutput>

<cfform name="getidentifierlistform" action="" method="post">
	<cfoutput>			
    <table width="480px">
    <cfloop query="getidentifier">
    <tr>
    <td width="460px">#getidentifier.identifierno# - #getidentifier.desp#</td>
    <td width="20px">
    <cfinput type="checkbox" name="identifierpicklist" id="identifierpicklist" value="#getidentifier.identifierno#" >
    </td>
    </tr>
    </cfloop>
    <tr><td></td></tr>
    <tr><td align="center"><input type="button" name="identifierdone" id="identifierdone" value="Submit" onClick="captureidentifier();"></td></tr>
    </table>
	</cfoutput>			
</cfform>
