<cfquery name="getarcust" datasource="#dts#">
SELECT custno,name FROM arcust
</cfquery>

<cfquery name="getCFSprofile" datasource="#dts#">
SELECT * FROM paybillprofile WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
</cfquery>

<cfquery name="getCFSEmplist" datasource="#dts#">
SELECT * FROM cfsemp
</cfquery>


<h1>Create CFS Pay & Bill profile</h1>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
<cfinclude template="/CFSpaybill/filter/filterCustomer.cfm">
<script type="text/javascript" src="/latest/js/select2/select2.min.js"></script>
<link rel="stylesheet" href="/latest/css/select2/select2.css" />
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfoutput>
<cfform name="form" action="/CFSpaybill/CFSpaybillProfileprocess.cfm?type=#url.type#&id=#url.id#">
    <table>
    	<tr>
        	<td>
        		<label>Profile Name</label>
            </td>
            <td>
            	<cfinput type="text" id="profilename" name="profilename" value="#getCFSprofile.profilename#">
            </td>
        </tr>
    	<tr>
        	<td>
        		<label>Choose Client</label>
            </td>
            <td>
            	<cfset default = getCFSprofile.custno>
            	<cfselect name="custprofile" id="custprofile">
                	<option value="">Please Select a Customer Profile</option>
                    <cfloop query="getarcust">
                        <option value="#getarcust.custno#" <cfif default eq getarcust.custno>Selected</cfif>>#getarcust.name#</option>
                    </cfloop>                 
                </cfselect>
            </td>
        </tr>
         <tr>
        	<td>
        		<label>Pay Rate</label>
            </td>
            <td>
                <cfinput type="text" id="payrate" name="payrate" value="#getCFSprofile.payrate#">
            </td>
        </tr>
        <tr>
        	<td>
        		<label>Bill Rate</label>
            </td>
            <td>
                <cfinput type="text" id="billrate" name="billrate" value="#getCFSprofile.billrate#">
            </td>
        </tr>
        <tr>
        	<td>
        		<label>Rate Type</label>
            </td>
            <td>
                <select name="ratetype" id="ratetype">
                	<option value="">Please choose a rate type</option>
                    <option value="day" <cfif getCFSprofile.ratetype eq "day">selected</cfif>>Day</option>
                    <option value="hour" <cfif getCFSprofile.ratetype eq "hour">selected</cfif>>Hr</option>
                </select>
            </td>
        </tr>
        <tr>
        	<td>
        		<label>Administration fee</label>
            </td>
            <td>
                <input type="text" id="adminfee" name="adminfee" value="#getCFSprofile.adminfee#">
                <input type="checkbox" id="adminfeecap" name="adminfeecap" value="2500" <cfif getCFSprofile.adminFeeCap GT 0 >checked</cfif>>
                <label>Admin Fee Cap (Max. 2500)</label>
            </td>
        </tr>
        <tr>
        	<td>
            </td>
            <td>
            	<br>
            	<cfinput type="submit" name="Submit" value="#url.type#" validate="submitonce"/>
                <a href="/CFSpaybill/listCFSProfile.cfm"><input type="button" id="cancelbtn" name="cancelbtn" value="Cancel"></a>
            </td>
        </tr>
    </table>
</cfform>
</cfoutput>