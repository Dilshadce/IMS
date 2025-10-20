<cfquery name="banklist" datasource="payroll_main">
SELECT bankcode,bankname FROM payroll_main.bankcode 
</cfquery>

<cfquery name="getallCFS" datasource="#dts#">
SELECT * FROM cfsemp
</cfquery>

<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/stylesheet/tabber.css" rel="stylesheet" type="text/css" media="screen">

<h1>CFS Employee</h1>

<cfoutput>
<cfform action="CFSprocess.cfm?type=#url.type#&id=#getallCFS.id#" name="form">
<cfinput type="hidden" name="id" id="id" value="#getallCFS.id#">
    <table>
    	<tr>
        	<th class="subheader" colspan="2" style="text-align:left; background-color:##F0606D; color:white"><label >Person Details</label></th>
        </tr>
        <tr>
        	<td>
                <label>First Name: </label>                
            </td>
            <td>
                <input type="text" id="name" name="name" value="#getallCFS.name#">                
            </td>
        </tr>
        <tr>
        	<td>
                <label>Last Name: </label>
            </td>
            <td>
                <input type="text" id="name2" name="name2" value="#getallCFS.name2#">
            </td>
        </tr>
        <tr>
        	<td>
            	<label>IC Number: </label>
            </td>
            <td>
            	<input type="text" id="icno" name="icno" value="#getallCFS.icno#">
            </td>
        </tr>
        <tr>
        	<td>
            	<label>Address: </label>
            </td>
            <td>
            	<input type="text" id="add1" name="add1" value="#getallCFS.add1#">            
            </td>
        </tr>
        <tr>
        	<td>
            </td>
            <td>
            	<input type="text" id="add2" name="add2" value="#getallCFS.add2#">
            </td>
        </tr>
        <tr>
        	<td>
            </td>
            <td>
            	<input type="text" id="add3" name="add3" value="#getallCFS.add3#">
            </td>
        </tr>
        <tr>
        	<td>
            	<label>Phone Number: </label>
            </td>
            <td>
            	<input type="text" id="phone" name="phone" value="#getallCFS.phone#">
            </td>
        </tr>
        <tr>
        	<th class="subheader" colspan="2" style="text-align:left; background-color:##F0606D; color:white"><label >Bank Details</label></th>
        </tr>
        <tr>
        	<td>
           		<label>Bank Person Name: </label>
            </td>
            <td>
            	<input type="text" id="bankpersonname1" name="bankpersonname1" value="#getallCFS.bankpersonname#">
                <div>
                <label style="color:red">Please enter Bank Person Name above<br>if the Beneficial Name is different than the full name filled above</label>
                </div>
            </td>
        </tr>
        <tr>
        	<td>
            	<label>Bank IC Number: </label>
            </td>
            <td>
            	<input type="text" id="bankicno" name="bankicno" value="#getallCFS.bankicno#">
            </td>
        </tr>
        <tr>
        	<td>
            	<label>Bank Company Register Number: </label>
            </td>
            <td>
            	<input type="text" id="bankcompregno" name="bankcompregno" value="#getallCFS.bankcompregno#">
            </td>
        </tr>
        <tr>
        	<td>
           		<label>Bank Company Name: </label>
            </td>
            <td>
            	<input type="text" id="bankpersonname2" name="bankpersonname2" value="">
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
            	<input type="text" id="bankaccno" name="bankaccno" value="#getallCFS.bankaccno#" validate="integer" validateat="onsubmit">
            </td>
        </tr>
        <tr>
        	<td>
            </td>
            <td>
            	<br>
            	<input type="submit" name="Submit" value="#url.type#" validate="submitonce"/>
                <a href="/CFSpaybill/listCFSEmployee.cfm"><input type="button" id="cancelbtn" name="cancelbtn" value="Cancel"></a>
            </td>
        </tr>
    </table>
</cfform>
</cfoutput>