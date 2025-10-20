<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "444,100,438,23,16,101">
<cfinclude template="/latest/words.cfm">
<cfif IsDefined('url.code')>
	<cfset URLcode = trim(urldecode(url.code))>
</cfif>

<cfoutput>
<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfquery name="checkExist" datasource="#dts#">
			SELECT code 
            FROM address
			WHERE code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.code)#">
		</cfquery>
		<cfif checkExist.recordcount>
			<script type="text/javascript">
				alert('This #trim(form.code)# already exist!');
				window.open('/latest/maintenance/address.cfm?action=create','_self');
			</script>
		<cfelse>
			<cftry>
				<cfquery name="createCode" datasource="#dts#">
					INSERT INTO address (code,name,name2,custno,add1,add2,add3,add4,country,postalcode,attn,phone,fax,phonea,e_mail,gstno)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.code)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.name)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.name2)#">,      
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.customerNo)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add1)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add2)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add3)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add4)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.country)#">,         
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.postalCode)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.attention)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.telephone)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.fax)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.phone2)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.email)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.gstno)#">
					)
				</cfquery>
				<cfcatch type="any">
					<script type="text/javascript">
						alert('Failed to create #trim(form.code)#!\nError Message: #cfcatch.message#');
						window.open('/latest/maintenance/address.cfm?action=create','_self');
					</script>
				</cfcatch>
			</cftry>
			<script type="text/javascript">
				alert('#trim(form.code)# has been created successfully!');
				window.open('/latest/maintenance/addressProfile.cfm','_self');
			</script>
		</cfif>
	<cfelseif url.action EQ "update">
   		
		<cftry>
			<cfquery name="updateCode" datasource="#dts#">
				UPDATE address
				SET
                    name=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.name)#">,    
                    name2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.name2)#">,      
                    custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.customerNo)#">,
                    add1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add1)#">,
                    add2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add2)#">,
                    add3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add3)#">,
                    add4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add4)#">,
                    country=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.country)#">,         
                    postalcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.postalCode)#">,
                    attn=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.attention)#">,
                    phone=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.telephone)#">,
                    fax=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.fax)#">,
                    phonea=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.phone2)#">,
                    e_mail=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.email)#">,
                    gstno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.gstno)#">       
				WHERE code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.code)#">
			</cfquery>
		<cfcatch type="any">
			<script type="text/javascript">
				alert('Failed to update #trim(form.code)#!\nError Message: #cfcatch.message#');
				window.open('/latest/maintenance/address.cfm?action=update&code=#form.code#','_self');
			</script>
		</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Updated #trim(form.code)# successfully!');
			window.open('/latest/maintenance/addressProfile.cfm','_self');
		</script>	
	<cfelseif url.action EQ "delete">
		<cftry>
			<cfquery name="deleteCode" datasource="#dts#">
				DELETE FROM address
				WHERE code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLcode#">
			</cfquery>
			<cfcatch type="any">
				<script type="text/javascript">
					alert('Failed to delete #URLcode#!\nError Message: #cfcatch.message#');
					window.open('/latest/maintenance/addressProfile.cfm','_self');
				</script>
			</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Deleted #URLcode# successfully!');
			window.open('/latest/maintenance/addressProfile.cfm','_self');
		</script>
	<cfelseif url.action EQ "print">
    
		<cfquery name="getGsetup" datasource="#dts#">
			SELECT compro 
            FROM gsetup;
		</cfquery>
        
		<cfquery name="printAddress" datasource="#dts#">
			SELECT code,name,custno
			FROM address
			ORDER BY code;
		</cfquery>
        		
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<!---<meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>#words[444]#</title>
		<link rel="stylesheet" type="text/css" href="/latest/css/bootstrap/bootstrap.min.css" />
		<!--[if lt IE 9]>
			<script type="text/javascript" src="/latest/js/html5shiv/html5shiv.js"></script>
			<script type="text/javascript" src="/latest/js/respond/respond.min.js"></script>
		<![endif]-->
		<script type="text/javascript" src="/latest/js/bootstrap/bootstrap.min.js"></script>
		</head>
		<body>
		
		<div class="container">
		<div class="page-header">
			<h1 class="text">#words[444]#</h1>
			<p class="lead">#words[100]#: #getGsetup.compro#</p>
		</div>
        
		<div class="table-responsive">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>#UCase(words[438])#</th>
					<th>#UCase(words[23])#</th>
                    <th>#UCase(words[16])#</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="printAddress">
				<tr>
					<td>#code#</td>
					<td>#name#</td>
                    <td>#custno#</td>
				</tr>
				</cfloop>
			</tbody>
		</table>
		</div>
		<div class="panel-footer">
		<p>#words[101]# #DateFormat(Now(),'dd-mm-yyyy')#, #TimeFormat(Now(),'HH:MM:SS')#</p>
		</div>
		</div>		
		
		</body>
		</html>
	<cfelse>
		<script type="text/javascript">
			window.open('/latest/maintenance/addressProfile.cfm','_self');
		</script>		
	</cfif>
<cfelse>
	<script type="text/javascript">
		window.open('/latest/maintenance/addressProfile.cfm','_self');
	</script>
</cfif>
</cfoutput>