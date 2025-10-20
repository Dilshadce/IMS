<cfquery name="getCFSprofilelist" datasource="#dts#">
SELECT id,profilename FROM paybillprofile GROUP BY profilename ORDER BY profilename
</cfquery>

<cfquery name="acBank_qry" datasource="manpower_p">
SELECT * FROM address a WHERE org_type in ('BANK')
</cfquery>

<h1>Generate Invoice and Bankfile</h1>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfoutput>

    <table class="form">
    	<tr>
        	<td>
        		<label><h2>Choose CFS Profile: </h2></label>
            </td>
            <td>
                <select name="cfsprofile" id="cfsprofile" onChange="window.frames['newframe'].location ='/CFSpaybill/generateInvoiceBankfileData.cfm?profileid='+this.value;">
                    <cfloop query="getCFSprofilelist">
                        <option value="#getCFSprofilelist.id#">#getCFSprofilelist.profilename#</option>
                    </cfloop>                 
                </select>
            </td>
        </tr>
        </table>
        
        <iframe src="/CFSpaybill/generateInvoiceBankfileData.cfm?profileid=#getCFSprofilelist.id[1]#" name="newframe" id="newframe" width="100%" height="900" frameborder="0" scrolling ="no"></iframe>
        
        
    
</cfoutput>