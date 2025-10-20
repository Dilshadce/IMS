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
        		<label>Choose CFS Employee</label>
            </td>
            <td>
            	<cfquery name="getcfsemp" datasource="#dts#">
                SELECT icno,name,name2 FROM cfsemp WHERE icno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getCFSprofile.icno#">
                </cfquery>
            	<cfset defaultemp = getCFSprofile.icno>
                <cfselect name="cfsprofile" id="cfsprofile">
                	<option value="">Please Select a CFS Employee</option>
                    <cfloop query="getCFSEmplist">
                        <option value="#getCFSEmplist.icno#" <cfif defaultemp eq getCFSEmplist.icno>Selected</cfif>>#getcfsemp.name# #getcfsemp.name2#</option>
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
        		<label>Administration fee (%)</label>
            </td>
            <td>
                <cfinput type="text" id="adminfee" name="adminfee" value="#getCFSprofile.adminfee#">
            </td>
        </tr>
        <tr>
        	<td>
            </td>
            <td>
            	<br>
            	<cfinput type="submit" name="Submit" value="#url.type#" validate="submitonce"/>
            </td>
        </tr>
    </table>
</cfform>
</cfoutput>