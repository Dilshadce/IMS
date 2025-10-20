
<html>
<head>
<title>Year End Processing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="submit" default="">

<body>
<form action="" method="post">
<H1>Add Refno Set For New Company</H1>
Company Datasource:
<input type="text" name="dts" value="">

<input type="submit" name="submit" value="Submit">
</form>

<cfif submit eq 'Submit'>
	<cfquery name="getinfo" datasource="main">
		select * from refnoset where userDept = '#form.dts#' limit 1
	</cfquery>
	<cfif getinfo.recordcount eq 0>
		<!--- Begin: Invoice --->
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('INV','', '', '00000000', '1', 1, '#form.dts#')
		</cfquery>
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('INV','', '', '00000000', '0', 2, '#form.dts#')
		</cfquery>
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('INV','', '', '00000000', '0', 3, '#form.dts#')
		</cfquery>
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('INV','', '', '00000000', '0', 4, '#form.dts#')
		</cfquery>
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('INV','', '', '00000000', '0', 5, '#form.dts#')
		</cfquery>
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('INV','', '', '00000000', '0', 6, '#form.dts#')
		</cfquery>
		<!--- End: Invoice --->
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('RC','', '', '00000000', '1', 1, '#form.dts#')
		</cfquery>
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('PR','', '', '00000000', '1', 1, '#form.dts#')
		</cfquery>
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('DO','', '', '00000000', '1', 1, '#form.dts#')
		</cfquery>
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('CS','', '', '00000000', '1', 1, '#form.dts#')
		</cfquery>
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('CN','', '', '00000000', '1', 1, '#form.dts#')
		</cfquery>
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('DN','', '', '00000000', '1', 1, '#form.dts#')
		</cfquery>
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('ISS','', '', '00000000', '1', 1, '#form.dts#')
		</cfquery>
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('PO','', '', '00000000', '1', 1, '#form.dts#')
		</cfquery>
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('SO','', '', '00000000', '1', 1, '#form.dts#')
		</cfquery>
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('QUO','', '', '00000000', '1', 1, '#form.dts#')
		</cfquery>
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('ASSM','', '', '00000000', '1', 1, '#form.dts#')
		</cfquery>
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('TR','', '', '00000000', '1', 1, '#form.dts#')
		</cfquery>
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('OAI','', '', '00000000', '1', 1, '#form.dts#')
		</cfquery>
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('OAR','', '', '00000000', '1', 1, '#form.dts#')
		</cfquery>
		
		<cfquery name="insert" datasource="main">
			insert into refnoset
			values
			('SAM','', '', '00000000', '1', 1, '#form.dts#')
		</cfquery>
		<h2>Company <cfoutput>#form.dts#</cfoutput>'s refno set already created.</h2>
	<cfelse>
    	<h2>Company <cfoutput>#form.dts#</cfoutput>'s refno set was created before.</h2>
	</cfif>
</cfif>
</body>


</html>
