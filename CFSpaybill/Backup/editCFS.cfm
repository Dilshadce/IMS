<cfquery name="banklist" datasource="payroll_main">
SELECT bankcode,bankname FROM payroll_main.bankcode 
</cfquery>

<cfquery name="getallCFS" datasource="#dts#">
SELECT * FROM cfsemp
</cfquery>

<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<h1>CFS Employee</h1>

<cfoutput>
<cfform action="CFSprocess.cfm?type=#url.type#&id=#getallCFS.id#" name="form">
<cfinput type="hidden" name="id" id="id" value="#getallCFS.id#">
    <table>
        <tr>
        	<td>
                <label>First Name: </label>                
            </td>
            <td>
                <cfinput type="text" id="name" name="name" value="#getallCFS.name#">                
            </td>
        </tr>
        <tr>
        	<td>
                <label>Last Name: </label>
            </td>
            <td>
                <cfinput type="text" id="name2" name="name2" value="#getallCFS.name2#">
            </td>
        </tr>
        <tr>
        	<td>
            	<label>IC Number: </label>
            </td>
            <td>
            	<cfinput type="text" id="icno" name="icno" value="#getallCFS.icno#" validate="integer" validateat="onsubmit">
            </td>
        </tr>
        <tr>
        	<td>
            	<label>Address: </label>
            </td>
            <td>
            	<cfinput type="text" id="add1" name="add1" value="#getallCFS.add1#">            
            </td>
        </tr>
        <tr>
        	<td>
            </td>
            <td>
            	<cfinput type="text" id="add2" name="add2" value="#getallCFS.add2#">
            </td>
        </tr>
        <tr>
        	<td>
            </td>
            <td>
            	<cfinput type="text" id="add3" name="add3" value="#getallCFS.add3#">
            </td>
        </tr>
        <tr>
        	<td>
            	<label>Phone Number: </label>
            </td>
            <td>
            	<cfinput type="text" id="phone" name="phone" value="#getallCFS.phone#">
            </td>
        </tr>
        <tr>
        	<td>
           		<label>Bank Person Name: </label>
            </td>
            <td>
            	<cfinput type="text" id="bankpersonname" name="bankpersonname" value="#getallCFS.bankpersonname#">
            </td>
        </tr>
        <tr>
        	<td>
            	<label>Bank IC Number: </label>
            </td>
            <td>
            	<cfinput type="text" id="bankicno" name="bankicno" value="#getallCFS.bankicno#" validate="integer" validateat="onsubmit">
            </td>
        </tr>
        <tr>
        	<td>
            	<label>Bank Company Register Number: </label>
            </td>
            <td>
            	<cfinput type="text" id="bankcompregno" name="bankcompregno" value="#getallCFS.bankcompregno#">
            </td>
        </tr>
        <tr>
        	<td>
            	<label>Bank Type: </label>
            </td>
            <td>
				<cfset default = getallCFS.banktype>
                <cfselect name="banktype" id="banktype">
                	<option value="">Please select a bank</option>
                    <cfloop query="banklist">
                        <option value="#banklist.bankcode#" <cfif banklist.bankcode EQ default>Selected</cfif>>#banklist.bankname#</option>
                    </cfloop>                 
                </cfselect>
            </td>
        </tr>
        <tr>
        	<td>
            	<label>Bank Account Number: </label>
            </td>
            <td>
            	<cfinput type="text" id="bankaccno" name="bankaccno" value="#getallCFS.bankaccno#" validate="integer" validateat="onsubmit">
            </td>
        </tr>
        <tr>
        	<td>
            </td>
            <td>
            	<br>
            	<cfinput type="submit" name="Submit" value="#url.type#" validate="submitonce"/>
                <a href="http://ims.asia/nieo/listCFSEmployee.cfm"><input type="button" id="cancelbtn" name="cancelbtn" value="Cancel"></a>
            </td>
        </tr>
    </table>
</cfform>
</cfoutput>