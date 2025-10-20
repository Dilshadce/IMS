<html>
<head>
<title>Insert User PIN</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="submit" default="">

<body onLoad="form1.code.focus();">
	<H1>Add User Pin</H1>
<p>

<form name="form1" method="post" action="">
	<table width="60%" border="0" cellspacing="0" cellpadding="2" class="data" align="center">
		<tr>
    		<td>Code</td>
    		<td>Desp</td>
			<td>Add After Column</td>
  		</tr>
  		<tr>
    		<td><input type="text" name="code" maxlength="10"></td>
			<td><input type="text" name="desp" size="50" maxlength="50"></td>
			<td><input type="text" name="addafter" maxlength="4"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan="2">
				<div align="right">
					<input type="submit" name="Submit" value="Submit">
        		</div>
			</td>
		</tr>
	</table>
</form>
</p>
<cfif submit eq 'Submit'>
	<cfif form.code eq "">
		Code cannot be empty!<cfabort>
	</cfif>
	<cfif form.desp eq "">
		Desp cannot be empty!<cfabort>
	</cfif>
	<cfquery name="check" datasource="#dts#">
		select * from userpin where CODE = '#form.code#'
	</cfquery>
	<cfif check.recordcount neq 0>
		The Code already exist! Please key in another one! <cfabort>
	<cfelse>
		<cftry>
			<cfset columnname = "H"&form.code>
			<cfset columnbefore = "H"&form.addafter>
			
			<cfif form.addafter neq "">
				<cfquery name="check2" datasource="#dts#">
					select #columnbefore# from userpin2 limit 1
				</cfquery>
			</cfif>
		 	<cfquery name="insert" datasource="#dts#">
				insert into userpin values ('#form.code#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">,'T','T','T','T','T','T','')
			</cfquery>
                
            <cfquery name="insertuserpinlang" datasource="main">
				insert into userpinlang values ('#form.code#', <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">, <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.desp#">, '', '', '', '', '')
			</cfquery>
			
			<cfquery name="alter" datasource="#dts#">
				alter table userpin2 add column #columnname# char(1) not null <cfif form.addafter neq "">after #columnbefore#</cfif>
			</cfquery> 
			
			<cfquery name="update" datasource="#dts#">
				update userpin2 
				set #columnname# = 'T'
				where level = 'Super'
			</cfquery>
			The User Pin added successfully!
		<cfcatch type="database">
			Error when inserting data. Please check with the Administrator!
		</cfcatch>
		</cftry>
	</cfif>
</cfif>
</body>
</html>