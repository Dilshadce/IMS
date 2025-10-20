<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "100, 16, 536, 101,1499,23">
<cfinclude template="/latest/words.cfm">

<cfif IsDefined('url.driverno')>
	<cfset URLdriverno = trim(urldecode(url.driverno))>
</cfif>

<cfif IsDefined('form.expiredate')>
<cfif trim(form.expiredate) eq "">
<cfset expiredate = "0000-00-00">
<cfelse>
<cfset expiredate = createdate(right(form.expiredate,4),mid(form.expiredate,4,2),left(form.expiredate,2))>
</cfif>
</cfif>

<cfoutput>

<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
	
		<cfif lcase(hcomid) eq "wijayasensasi_i">
		<!---wijayasensasi create--->
			<cftry>
				<cfquery name="createDriver" datasource="#dts#">
					INSERT INTO driver (name,name2,attn,customerno,
                    					add1,add2,add3,dept,contact,phone,phonea,e_mail,fax,
                    					dadd1,dadd2,dadd3,dattn,dcontact,remarks,commission1,discontinuedriver,photo,icno,expiredate,wijayamemberid,wijayamembertype,wijayamemberloc,wijayamemberstatus)
					VALUES
					(
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.name)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.name2)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.attention)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.customerNo)#">,
                        
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add1)#">,   
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add2)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add3)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.department)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.contact)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.phone)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.hp)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.email)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.fax)#">,
                        
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_add1)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_add2)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_add3)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_attn)#">,    
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_contact)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.remark)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.commission)#">, 
                        <cfif IsDefined('form.discontinueDriver')>   
                        	'Y'
                        <cfelse>	
                        	'N'
                        </cfif>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.photo_available)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.icno)#">,
                        <cfif trim(form.expiredate) eq "">
                        "0000-00-00"
                        <cfelse>
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(expiredate,'yyyy-mm-dd')#">
                        </cfif>
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.wijayamemberid)#">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.wijayamembertype)#">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.wijayamemberloc)#">
						,<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.wijayamemberstatus)#">
						
					)
				</cfquery>
				<cfcatch type="any">
					<script type="text/javascript">
						alert('Failed to create #trim(form.driverNo)#!\nError Message: #cfcatch.message#');
						window.open('/latest/maintenance/driver.cfm?action=create','_self');
					</script>
				</cfcatch>
			</cftry>
			<script type="text/javascript">
				alert('#trim(form.driverno)# has been created successfully!');
				window.open('/latest/maintenance/driverProfile.cfm','_self');
			</script>
		
		
		
		<cfelse>
	
		<cfquery name="checkExist" datasource="#dts#">
			SELECT driverno 
            FROM driver
			WHERE driverno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.driverNo)#">
		</cfquery>
		<cfif checkExist.recordcount>
			<script type="text/javascript">
				alert('This #trim(form.driverNo)# already exist!');
				window.open('/latest/maintenance/driver.cfm?action=create','_self');
			</script>
		<cfelse>
			<cftry>
				<cfquery name="createDriver" datasource="#dts#">
					INSERT INTO driver (driverno,name,name2,attn,customerno,
                    					add1,add2,add3,dept,contact,phone,phonea,e_mail,fax,
                    					dadd1,dadd2,dadd3,dattn,dcontact,remarks,commission1,discontinuedriver,photo,icno,expiredate)
					VALUES
					(
					
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.driverNo)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.name)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.name2)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.attention)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.customerNo)#">,
                        
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add1)#">,   
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add2)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add3)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.department)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.contact)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.phone)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.hp)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.email)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.fax)#">,
                        
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_add1)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_add2)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_add3)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_attn)#">,    
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_contact)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.remark)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.commission)#">, 
                        <cfif IsDefined('form.discontinueDriver')>   
                        	'Y'
                        <cfelse>	
                        	'N'
                        </cfif>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.photo_available)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.icno)#">,
                        <cfif trim(form.expiredate) eq "">
                        "0000-00-00"
                        <cfelse>
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(expiredate,'yyyy-mm-dd')#">
                        </cfif>
					)
				</cfquery>
				<cfcatch type="any">
					<script type="text/javascript">
						alert('Failed to create #trim(form.driverNo)#!\nError Message: #cfcatch.message#');
						window.open('/latest/maintenance/driver.cfm?action=create','_self');
					</script>
				</cfcatch>
			</cftry>
			<script type="text/javascript">
				alert('#trim(form.driverno)# has been created successfully!');
				window.open('/latest/maintenance/driverProfile.cfm','_self');
			</script>
		</cfif>
		</cfif>
	<cfelseif url.action EQ "update">
   		
		<cftry>
			<cfquery name="updateDriver" datasource="#dts#">
				UPDATE driver
				SET
                    name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.name)#">,
                    name2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.name2)#">,
                    attn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.attention)#">,
                    customerno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.customerNo)#">,
                    add1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add1)#">,
                    add2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add2)#">,
                    add3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add3)#">,
                    dept = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.department)#">,
                    contact = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.contact)#">,
                    phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.phone)#">,
                    phonea = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.hp)#">,
                    e_mail= <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.email)#">,
                    fax = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.fax)#">,
                    dadd1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_add1)#">,
                    dadd2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_add2)#">,
                    dadd3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_add3)#">,
                    dattn = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_attn)#">,
                    dcontact = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.d_contact)#">,
                    remarks = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.remark)#">,
                    commission1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.commission)#">,
                    
                    <cfif IsDefined('form.discontinueDriver') >   
                        	discontinuedriver = 'Y'
                        <cfelse>	
                        	discontinuedriver = 'N'
                        </cfif>,
                    photo = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.photo_available)#">,
                    icno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.icno)#">,
                    expiredate=
                    <cfif trim(form.expiredate) eq "">
                        "0000-00-00"
                    <cfelse>
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(expiredate,'yyyy-mm-dd')#">
                    </cfif>      

					<cfif lcase(hcomid) eq "wijayasensasi_i">
					,wijayamemberid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#wijayamemberid#">
					,wijayamembertype=<cfqueryparam cfsqltype="cf_sql_varchar" value="#wijayamembertype#">
					,wijayamemberloc=<cfqueryparam cfsqltype="cf_sql_varchar" value="#wijayamemberloc#">
					,wijayamemberstatus=<cfqueryparam cfsqltype="cf_sql_varchar" value="#wijayamemberstatus#">
					</cfif>

					
				WHERE driverno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.driverNo)#">
			</cfquery>
		<cfcatch type="any">
			<script type="text/javascript">
				alert('Failed to update #trim(form.driverNo)#!\nError Message: #cfcatch.message#');
				window.open('/latest/maintenance/driver.cfm?action=update&driverno=#form.driverno#','_self');
			</script>
		</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Updated #trim(form.driverNo)# successfully!');
			window.open('/latest/maintenance/driverProfile.cfm','_self');
		</script>	
	<cfelseif url.action EQ "delete">
		<cftry>
			<cfquery name="deleteDriver" datasource="#dts#">
				DELETE FROM driver
				WHERE driverno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLdriverno#">
			</cfquery>
			<cfcatch type="any">
				<script type="text/javascript">
					alert('Failed to delete #URLdriverno#!\nError Message: #cfcatch.message#');
					window.open('/latest/maintenance/driverProfile.cfm','_self');
				</script>
			</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Deleted #URLdriverno# successfully!');
			window.open('/latest/maintenance/driverProfile.cfm','_self');
		</script>
	<cfelseif url.action EQ "print">
    
		<cfquery name="getGsetup" datasource="#dts#">
			SELECT compro 
            FROM gsetup;
		</cfquery>
        
		<cfquery name="printDriver" datasource="#dts#">
			SELECT *
			FROM driver
			ORDER BY driverno;
		</cfquery>
        		
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<!---<meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>Customer Service Listing</title>
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
			<h1 class="text">Customer Service Listing</h1>
			<p class="lead">#words[100]#: #getGsetup.compro#</p>
		</div>
        
		<div class="table-responsive">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>#UCASE(words[1499])#</th>
					<th>#UCase(words[23])#</th>
                    <th>IC No</th>
                    <th>DOB</th>
                    <th>ADDRESS</th>
                    <th>PHONE</th>
                    <th>HP</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="printDriver">
				<tr>
					<td>#driverno#</td>
                    <td>#name# #name2#</td>
                    <td>#icno#</td>
                    <td>#dateformat(dob,'dd/mm/yyyy')#</td>
                    <td>#add1#<br />#add2#<br />#add3#</td>
                    <td>#phone#</td>
                    <td>#contact#</td>
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
			window.open('/latest/maintenance/driverProfile.cfm','_self');
		</script>		
	</cfif>
<cfelse>
	<script type="text/javascript">
		window.open('/latest/maintenance/driverProfile.cfm','_self');
	</script>
</cfif>
</cfoutput>