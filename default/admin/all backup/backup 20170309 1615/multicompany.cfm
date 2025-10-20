<cfif HUserGrpID eq "SUPER" and left(huserid,5) eq "ultra">	
    <cfquery datasource='main' name="getcompany">
		select userbranch 
			from users 
			where userDept not in ('cyt_i','hom_i','mj_i','oilestates_a','pwd_i','steel05_i','steel_i','marujyu_i')
			and userDept not like '%_a'
            and comsta = "Y"
			group by userbranch order by userbranch;
	</cfquery>

<cfoutput><h1>Company List</h1></cfoutput>

<cfform name="multicomlistform" action="" method="post">
	<cfoutput>			
    <table width="480px">
    <cfloop query="getcompany">
    <tr>
    <td width="460px">#getcompany.userbranch#</td>
    <td width="20px">
    <cfif listfind(comlist,getcompany.userbranch,',') neq 0>
    <cfinput type="checkbox" name="multicompicklist" id="multicompicklist" value="#getcompany.userbranch#" checked>
    <cfelse>
    <cfinput type="checkbox" name="multicompicklist" id="multicompicklist" value="#getcompany.userbranch#" >
    </cfif>
    </td>
    </tr>
    </cfloop>
    <tr><td></td></tr>
    <tr><td align="center"><input type="button" name="multicomdone" id="multicomdone" value="Submit" onClick="capturecomid();"></td></tr>
    </table>
	</cfoutput>			
</cfform>
</cfif>