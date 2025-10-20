<html>
<head>
	<title>Transaction 0</title>
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<!--- <cfquery name="getRefnoset" datasource="main">
	select * from refnoset
	where userDept = '#dts#'
	and type = 'ASSM'
	order by counter
</cfquery> --->

<cfquery name="getRefnoset" datasource="#dts#">
	select * from refnoset
	where type = 'ASSM'
	order by counter
</cfquery>

<cfset refnoname = "Assembly">

<body>
<cfform name="form1" action="assm1.cfm" method="post">
	<h2>Please choose 1 set of <cfoutput>#refnoname#</cfoutput> number to continue:</h2>

	<table width="40%" class="data" cellpadding="3" align="center">
	<tr>
		<th><cfoutput>#refnoname#</cfoutput> No</th>
		<th>Selection</th>
	</tr>
  	<cfoutput>
	<cfloop query="getRefnoset">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
      		<td>Set #getRefnoset.counter# - #getRefnoset.lastUsedNo#</td>
    		<td align="center"><input name="invset" type="radio" value="#getRefnoset.counter#" <cfif getRefnoset.counter eq 1>checked</cfif>></td>
		</tr>
	</cfloop>
  	<tr>
    	<td></td>
    	<td align="center"><input type="submit" name="submit" value="submit"></td>
  	</tr>
  	</cfoutput>
</table>
</cfform>

</body>
</html>