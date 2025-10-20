<cfoutput>
<html>
<head></head>
<body>
<cfquery name="getcompany" datasource="main">
	SELECT userDept,linktoams FROM users where 
	userDept not in ('cyt_i','hom_i','mj_i','oilestates_a','pwd_i','steel05_i','steel_i','marujyu_i','anglomlw08_i')
	and userDept not like '%_a' group by userDept
</cfquery>
<table border="1">
<tr>
<th>Comapny ID</th>
<th>ICTRAN</th>
<th>ICITEM</th>
<th>ICCATE</th>
<th>LOCQDBF</th>
<th>AMSICTRAN</th>
</tr>
 <cfloop query="getcompany">
	<cfset dts=getcompany.userDept>
    <tr>
    <td>#dts#</td>
    <cftry>
<cfquery name="ictran" datasource="#dts#">
show columns from ictran where field = "wos_group"
</cfquery>
<td>#ictran.type#</td>
<cfquery name="icitem" datasource="#dts#">
show columns from icitem where field = "wos_group"
</cfquery>
<td>#icitem.type#</td>
<cfquery name="iccate" datasource="#dts#">
show columns from icgroup where field = "wos_group"
</cfquery>
<td>#iccate.type#</td>
<cfquery name="locqdbf" datasource="#dts#">
show columns from locqdbf where field = "wos_group"
</cfquery>
<td>#locqdbf.type#</td>
<cfif getcompany.linktoams eq "Y">
<cfquery name="amsictran" datasource="#replacenocase(dts,"_i","_a","all")#">
show columns from ictran where field = "wos_group"
</cfquery>
<cfset typeams = amsictran.type>
<cfelse>
<cfset typeams = "">
</cfif>
<td>#typeams#</td>
</tr>
	<cfcatch type="any">
		<td>#cfcatch.Detail#</td></tr>
	</cfcatch>
	</cftry>
</cfloop>
Finish.
</body>
</html>
</cfoutput>