<!---<cfquery name="getictrantemp" datasource="#dts#">
	SELECT * FROM userpin
    ORDER BY code
</cfquery>

    <table>
        <tr>
            <td>CODE</td>
            <td>DESP</td>
        </tr>
        
        </tr>
        <cfoutput query="getictrantemp">
            <tr>
                <td>#code#</td>
                <td>#desp#</td>
            </tr>
        </cfoutput>
    </table>--->
    
    
<cfquery name="getictrantemp" datasource="#dts#">
	SELECT * FROM userdefinedmenu
</cfquery>
   
<table>
<tr>
<td>MENU ID</td>
<td>MENU NAME</td>
<td>NEW MENU NAME</td>
<td>CHANGED</td>


</tr>
	<cfoutput query="getictrantemp">
        <tr>
            <td>#menu_ID#</td><td>#menu_name#</td><td>#new_menu_name#</td><td>#changed#</td>
        </tr>
    </cfoutput>
</table>
