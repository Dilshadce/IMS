<!------------------------------------------------------------------------------
File Name: createCFS.cfm
Directory: 
Description: The source code below are the form to create CFS
Last Modified By (Developer Name): Nieo Jie Xiang
Last Modified On (DateTime): 4/10/2016 12:02PM
Copy Rights: Netiquette Software Pte Ltd
--------------------------------------------------------------------------------->

<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/stylesheet/tabber.css" rel="stylesheet" type="text/css" media="screen">
<cfquery name="banklist" datasource="payroll_main">
SELECT bankcode,bankname FROM payroll_main.bankcode 
</cfquery>

<h1>CFS Employee</h1>
<cfoutput>
<cfform action="/CFSpaybill/CFSprocess.cfm?type=create" name="form">
    <table>
    	<tr>
        	<th class="subheader" colspan="2" style="text-align:left; background-color:##F0606D; color:white"><label >Person Details</label></th>
        </tr>
        <tr>
        	<td>
                <label>First Name: </label>                
            </td>
            <td>
                <input type="text" id="name" name="name" value="" required>                
            </td>
        </tr>
        <tr>
        	<td>
                <label>Last Name: </label>
            </td>
            <td>
                <input type="text" id="name2" name="name2" value="" required>
            </td>
        </tr>
        <tr>
        	<td>
            	<label>IC Number: </label>
            </td>
            <td>
            	<input type="text" id="icno" name="icno" value="" required>
            </td>
        </tr>
        <tr>
        	<td>
            	<label>Address: </label>
            </td>
            <td>
            	<input type="text" id="add1" name="add1" value="">            
            </td>
        </tr>
        <tr>
        	<td>
            </td>
            <td>
            	<input type="text" id="add2" name="add2" value="">
            </td>
        </tr>
        <tr>
        	<td>
            </td>
            <td>
            	<input type="text" id="add3" name="add3" value="">
            </td>
        </tr>
        <tr>
        	<td>
            	<label>Phone Number: </label>
            </td>
            <td>
            	<input type="text" id="phone" name="phone" value="" >
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
            	<input type="text" id="bankpersonname1" name="bankpersonname1" value="">
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
            	<input type="text" id="bankicno" name="bankicno" value="">
            </td>
        </tr>
        <!---<tr>
        	<th class="subheader" colspan="2" style="text-align:left; background-color:##F0606D; color:white"><label >Bank Company Details</label></th>
        </tr>--->
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
            	<label>Bank Company Register Number: </label>
            </td>
            <td>
            	<input type="text" id="bankcompregno" name="bankcompregno" value="">
                <div>
                <label style="color:red">Please fill in Company Register Number above <br>(You may ignore if you are using personal account)</label>
                </div>
            </td>
        </tr>
        <tr>
        	<td>
            	<label>Bank Type: </label>
            </td>
            <td>
				<cfset default = "">
                <select name="banktype" id="banktype" onChange="" required>
                	<option value="">Please select a bank</option>
                    <cfloop query="banklist">
                        <option value="#banklist.bankcode#" <cfif banklist.bankcode EQ default>Selected</cfif>>#banklist.bankname#</option>
                    </cfloop>                 
                </select>
            </td>
        </tr>
        <tr>
        	<td>
            	<label>Bank Account Number: </label>
            </td>
            <td>
            	<input type="text" id="bankaccno" name="bankaccno" value="" required>
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