	<cfquery datasource='#dts#' name="getsolist">
    select "" as refno,"" as itemno,"" as desp
    UNION ALL
		select refno,itemno,desp from ictran where type='SO'
	</cfquery>

<cfoutput><h1>Sales Order List</h1></cfoutput>

<cfform name="getsolist" action="" method="post">
	<cfoutput>			
    <table width="480px">
    <tr>
    <td width="180px">So No</td>
    <td width="180px">Item No</td>
    <td width="180px">Description</td>
    </td>
    </tr>
    
    <cfloop query="getsolist">
    <tr>
    <td width="180px">#getsolist.refno#</td>
    <td width="180px">#getsolist.itemno#</td>
    <td width="180px">#getsolist.desp#</td>
    <td width="20px" <cfif getsolist.refno eq ''>style="display:none"</cfif>>
    
    <cfinput type="checkbox" name="soitemlist" id="soitemlist" value="#getsolist.refno#" >
    </td>
    </tr>
    </cfloop>
    <tr><td></td></tr>
    <tr><td align="center" colspan="100%"><input type="button" name="multisodone" id="multisodone" value="Submit" onClick="captureso();"></td></tr>
    </table>
	</cfoutput>			
</cfform>