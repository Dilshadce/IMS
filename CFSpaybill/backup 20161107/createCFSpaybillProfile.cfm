<cfquery name="getarcust" datasource="#dts#">
SELECT custno,name FROM arcust
</cfquery>

<cfquery name="getCFSprofile" datasource="#dts#">
SELECT icno,name FROM cfsemp
</cfquery>


<h1>Create CFS Pay & Bill profile</h1>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfoutput>
<cfform name="form" action="/CFSpaybill/CFSpaybillProfileprocess.cfm?type=create">
    <table>
    	<tr>
        	<td>
        		<label>Profile Name</label>
            </td>
            <td>
            	<cfinput type="text" id="profilename" name="profilename" value="">
            </td>
        </tr>
    	<tr>
        	<td>
        		<label>Choose Client</label>
            </td>
            <td>
            	<cfselect name="custprofile" id="custprofile">
                	<option value="">Please Select a Customer Profile</option>
                    <cfloop query="getarcust">
                        <option value="#getarcust.custno#">#getarcust.name#</option>
                    </cfloop>                 
                </cfselect>
            </td>
        </tr>
        <tr>
        	<td>
        		<label>Choose CFS Employee</label>
            </td>
            <td>
                <cfselect name="cfsprofile" id="cfsprofile">
                	<option value="">Please Select a CFS Employee</option>
                    <cfloop query="getCFSprofile">
                        <option value="#getCFSprofile.icno#">#getCFSprofile.name#</option>
                    </cfloop>                 
                </cfselect>
            </td>
        </tr>
         <tr>
        	<td>
        		<label>Rate for Pay</label>
            </td>
            <td>
                <cfinput type="text" id="payrate" name="payrate" value="0.00">
            </td>
        </tr>
        <tr>
        	<td>
        		<label>Rate for Bill</label>
            </td>
            <td>
                <cfinput type="text" id="billrate" name="billrate" value="0.00">
            </td>
        </tr>
        <tr>
        	<td>
        		<label>Administration fee (%)</label>
            </td>
            <td>
                <cfinput type="text" id="adminfee" name="adminfee" value="0.00">
            </td>
        </tr>
        <tr>
        	<td>
            </td>
            <td>
            	<br>
            	<cfinput type="submit" name="Submit" value="Create" validate="submitonce"/>
            </td>
        </tr>
    </table>
</cfform>
</cfoutput>