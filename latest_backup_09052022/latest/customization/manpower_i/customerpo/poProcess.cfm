<cfprocessingdirective pageencoding="UTF-8">

<cfif IsDefined('url.refno')>
	<cfset URLrefno = trim(urldecode(url.refno))>
</cfif>

<cfquery name='getGsetup' datasource='#dts#'>
  SELECT capall,autolocbf 
  FROM gsetup
</cfquery>

<cfoutput>
<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		
		<cfif form.wos_date eq "">
		<cfset ndate="0000-00-00">
		<cfelse>
		<cfset ndate=dateformat(createdate(right(form.wos_date,4),mid(form.wos_date,4,2),left(form.wos_date,2)),'yyyy-mm-dd')>
		</cfif>
		
		<cfif form.povalidate eq "">
		<cfset ndate2="0000-00-00">
		<cfelse>
		<cfset ndate2=dateformat(createdate(right(form.povalidate,4),mid(form.povalidate,4,2),left(form.povalidate,2)),'yyyy-mm-dd')>
		</cfif>
		
		
		<cfquery name="checkExist" datasource="#dts#">
			SELECT refno 
            FROM manpowerpo
			WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.refno)#">;
		</cfquery>
		<cfif checkExist.recordcount>
			<script type="text/javascript">
				alert('This #trim(form.refno)# already exist!');
				window.open('po.cfm?action=create','_self');
			</script>
		<cfelse>
			<cftry> 
				<cfquery name="createProduct" datasource="#dts#">
					INSERT INTO manpowerpo (refno,custno,name,wos_date,povalidate,poamount,pothresholdamount,notificationemail,notificationuser,notificationsetting,virtualpo,created_by,created_on)                     
					VALUES
					(
                    	
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.refno)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.custno)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.name)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#ndate#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#ndate2#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.poamount)#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.pothresholdamount)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.notificationemail)#">,
						<cfif isdefined('form.notificationuser')>
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.notificationuser)#">
						<cfelse>
						""
						</cfif>
						,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.notificationsetting)#">,
                        <cfif isdefined('form.virtualpo')>'Y'<cfelse>''</cfif>,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(huserid)#">,
						now()
					)
				</cfquery>

				<cfcatch type="any">
					<script type="text/javascript">
						alert('Failed to create #trim(form.refno)#!\nError Message: #cfcatch.message#');
						window.open('po.cfm?action=create','_self');
					</script>
				</cfcatch>
			</cftry>
			
			<script type="text/javascript">
				alert('#trim(form.refno)# has been created successfully!');
				window.open('poProfile.cfm?menuID','_self');
			</script>

		</cfif>
	<cfelseif url.action EQ "update">
	
		<cfif form.wos_date eq "">
		<cfset ndate="0000-00-00">
		<cfelse>
		<cfset ndate=dateformat(createdate(right(form.wos_date,4),mid(form.wos_date,4,2),left(form.wos_date,2)),'yyyy-mm-dd')>
		</cfif>
		
		<cfif form.povalidate eq "">
		<cfset ndate2="0000-00-00">
		<cfelse>
		<cfset ndate2=dateformat(createdate(right(form.povalidate,4),mid(form.povalidate,4,2),left(form.povalidate,2)),'yyyy-mm-dd')>
		</cfif>
		<cftry>	
			<cfquery name="updateProduct" datasource="#dts#">
				UPDATE manpowerpo
				SET
						custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.custno)#">,
						name=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.name)#">,
                        wos_date=<cfqueryparam cfsqltype="cf_sql_varchar" value="#ndate#">,
                        povalidate=<cfqueryparam cfsqltype="cf_sql_varchar" value="#ndate2#">,
                        poamount=<cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.poamount)#">,
						pothresholdamount=<cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.pothresholdamount)#">,
                        notificationemail=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.notificationemail)#">,
                        notificationuser=<cfif isdefined('form.notificationuser')><cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.notificationuser)#"><cfelse>""</cfif>,
                        notificationsetting=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.notificationsetting)#">,
                        virtualpo=''
                   
				WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.refno)#">;
			</cfquery>
            
		<cfcatch type="any"><!---
			<script type="text/javascript">
				alert('Failed to update #trim(form.refno)#!\nError Message: #cfcatch.message#');
				window.open('po.cfm?action=update#&refno=#form.refno#','_self');
			</script>--->
		</cfcatch>
		</cftry>
        
       
		<script type="text/javascript">
			alert('Updated #trim(form.refno)# successfully!');
			window.open('poProfile.cfm','_self');
		</script>	

	<cfelseif url.action EQ "delete">
    	<cftry>
			<cfquery name="deleteCategory" datasource="#dts#">
				DELETE FROM manpowerpo
				WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLrefno#">
			</cfquery>
			<cfcatch type="any">
				<script type="text/javascript">
					alert('Failed to delete #URLrefno#!\nError Message: #cfcatch.message#');
					window.open('poProfile.cfm','_self');
				</script>
			</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Deleted #URLrefno# successfully!');
			window.open('poProfile.cfm','_self');
		</script>
	<cfelseif url.action EQ "print">
    
		<cfquery name="getGsetup" datasource="#dts#">
			SELECT compro 
            FROM gsetup;
		</cfquery>
        
		<cfquery name="printProduct" datasource="#dts#">
			SELECT itemno,aitemno,desp,despa
			FROM icitem
			ORDER BY itemno;
		</cfquery>
        <cfoutput>
        <cfset pageTitle = "#words[291]#">
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
           <!--- <meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <title>#pageTitle#</title>
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
                    <h1 class="text">#pageTitle#</h1>
                    <p class="lead">#words[100]#: #getGsetup.compro#</p>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>#UCase(words[120])#</th>
                                <th>#UCase(words[121])#</th>
                                <th>#UCase(words[65])#</th>
                            </tr>
                        </thead>
                        <tbody>
                            <cfloop query="printProduct">
                                <tr>
                                    <td>#itemno#</td>
                                    <td>#aitemno#</td>
                                    <td>#desp#-#despa#</td>
                                </tr>
                            </cfloop>
                        </tbody>
                    </table>
                </div>
                <div class="panel-footer">
                    <p>#words[101]# #DateFormat(Now(),'DD-MM-YYYY')#, #TimeFormat(Now(),'HH:MM:SS')#</p>
                </div>
            </div>		
		</body>
		</html>
        </cfoutput>
	<cfelse>
		<script type="text/javascript">
			window.open('/latest/maintenance/productProfile.cfm','_self');
		</script>		
	</cfif>
<cfelse>
	<script type="text/javascript">
		window.open('/latest/maintenance/productProfile.cfm','_self');
	</script>
</cfif>
</cfoutput>