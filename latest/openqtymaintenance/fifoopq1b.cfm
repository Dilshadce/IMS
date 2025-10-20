<html>
<head>
<title>Edit Item Opening Quantity/Cost</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>


<body>
<h2 align="center">Item No - <cfoutput>#CFGRIDKEY#</cfoutput></h2>

<table border="0" class="data" align="center">
<tr>
<td>
   <cfform name="form" method="post" action="">
	
    		
	   <cfgrid name="usersgrid" align="middle" format="html">
		<cfgridcolumn name="No" header="No" width="140"  select="no" dataAlign="Right">
		<cfgridcolumn name="Quantity" header="Quantity" width="80"  select="no">
		<cfgridcolumn name="Unit_Price" header="Unit Price" width="120"  select="no">
		<cfgridcolumn name="ffd11" header="Date" width="100"  select="no">	
		<cfset cnt = 50>
  		
		<cfloop condition="cnt gte 11">  
  			<cfset ffq = "ffq"&"#cnt#">
			<cfset ffc = "ffc"&"#cnt#">
			<cfset ffd = "ffd"&"#cnt#">
  			
			<cfquery name="getopq" datasource="#dts#">
				select #ffq# as xffq, #ffc# as xffc, #ffd# as xffd 
				from fifoopq 
				where itemno='#CFGRIDKEY#';
			</cfquery>
	
			<cfif getopq.xffq eq "">
				<cfset vffq = 0>
			<cfelse>
				<cfset vffq = getopq.xffq>
			</cfif>
			
			<cfif getopq.xffc eq "">
				<cfset vffc = 0>
			<cfelse>
				<cfset vffc = getopq.xffc>
			</cfif>
			
			<cfif getopq.xffd eq "">
				<cfset vffd = "00/00/0000">
			<cfelse>
				<cfset vffd = dateformat(getopq.xffd,"dd/mm/yyyy")>
			</cfif>
			
			<cfoutput>
  				<cfset cnt2 = cnt -10>
  				
				<cfif #cnt# eq 50>
					<cfgridrow data =" Oldest #cnt#,#vffq#,#vffc#,01-01-2010"> 
				<cfelse>#cnt#
					<cfgridrow data ="#cnt#,#vffq#,#vffc#,#vffd#"> 
				</cfif>
    			</cfoutput>
  			
			<cfset cnt = cnt -1>
  		</cfloop>
	   </cfgrid>

   </cfform>
</td>
</tr>
</table>
</body>
</html>