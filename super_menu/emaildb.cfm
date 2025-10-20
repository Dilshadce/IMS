<cfoutput>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfif left(huserid,5) eq "ultra">
<h1>Schedule Email Backup File on 28th Each Month</h1>
<cfif isdefined('url.type')>
<cfquery name="getdetail" datasource="main">
SELECT * From automailer where id = "#url.id#"
</cfquery>
<cfset newcomid = getdetail.comid>
<cfset newemail = getdetail.emailaddress>
<cfelse>
<cfset newcomid = "">
<cfset newemail = "">
</cfif>
<cfform name="emaildb" id="emaildb" action="emaildbprocess.cfm" method="post">
<cfif isdefined('url.type')>
<input type="hidden" name="hidid" id="hidid" value="#url.id#">
</cfif>
<table>
<tr>
<th>Company ID</th>
<td>:</td>
<td>
<cfquery name="getcompanyid" datasource="main">
SELECT userbranch FROM users group by userbranch order by userbranch
</cfquery>
<cfselect name="comid" id="comid" query="getcompanyid" value="userbranch" display="userbranch" required="yes" selected="#newcomid#"></cfselect>
</td>
</tr>
<tr>
<th>Email Address</th>
<td>:</td>
<td>
<cfinput type="text" name="emailaddress" id="emailaddress" required="yes" message="Email is Required" value="#newemail#" size="50">
</td>
</tr>
<tr>
<td colspan="3" align="center">
<cfif isdefined('url.type')>
<input type="button" name="cancel_btn" id="cancel_btn" value="Cancel" onClick="window.location.href='emaildb.cfm';">
</cfif>&nbsp;&nbsp;<input type="submit" name="sub_btn" id="sub_btn" value="<cfif isdefined('url.type')>#url.type#<cfelse>Create</cfif>" >
</td>
</tr>
</table>
</cfform>
<cfquery name="getlist" datasource="main">
SELECT * FROM automailer
</cfquery>
<table>
<tr>
<th width="50px">No</th>
<th width="100px">Company ID</th>
<th width="200px">Email</th>
<Th width="100px">Action</Th>
</tr>
<cfloop query="getlist">
<tr>
<td>#getlist.currentrow#</td>
<td>#getlist.comid#</td>
<td>#getlist.emailaddress#</td>
<td>
<a href="emaildb.cfm?type=update&id=#getlist.id#">Edit</a>&nbsp;&nbsp;
<a href="emaildb.cfm?type=delete&id=#getlist.id#">Delete</a>
</td>
</tr>
</cfloop>
</table>
</cfif>
</cfoutput>