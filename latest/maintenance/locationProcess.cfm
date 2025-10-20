<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "487,100,482,65,101">
<cfinclude template="/latest/words.cfm">s
<cfif IsDefined('url.location')>
	<cfset URLlocation = trim(urldecode(url.location))>
</cfif>

<cfquery name="getfunctioncontrol" datasource="#dts#">
	SELECT * FROM functioncontrol
</cfquery>


<cfoutput>
<cfif IsDefined("url.action")>
	<cfif url.action EQ "create">
		<cfquery name="checkExist" datasource="#dts#">
			SELECT location 
            FROM iclocation
			WHERE location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.location)#">
		</cfquery>
		<cfif checkExist.recordcount>
			<script type="text/javascript">
				alert('This #trim(form.location)# already exist!');
				window.open('/latest/maintenance/location.cfm?action=create','_self');
			</script>
		<cfelse>
			<cftry>
				<cfquery name="createCode" datasource="#dts#">
					INSERT INTO iclocation (location,desp,outlet,custno,addr1,addr2,addr3,addr4,source)
					VALUES
					(
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.location)#">,        
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.desp)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.consignmentOutlet)#">,    
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.customerNo)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add1)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add2)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add3)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add4)#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.source)#">
					)
				</cfquery>
                <cfif IsDefined('form.generateitem')>
                    <cfquery name="insertlocation" datasource="#dts#">
                    	INSERT IGNORE INTO LOCQDBF (itemno,location,desp) 
                        SELECT itemno,"#trim(form.location)#","#trim(form.desp)#" AS location 
                        FROM icitem 
                        ORDER BY itemno;
                    </cfquery>
				</cfif>
				<cfcatch type="any">
					<script type="text/javascript">
						alert('Failed to create #trim(form.location)#!\nError Message: #cfcatch.message#');
						window.open('/latest/maintenance/location.cfm?action=create','_self');
					</script>
				</cfcatch>
			</cftry>
			<script type="text/javascript">
				alert('#trim(form.location)# has been created successfully!');
				window.open('/latest/maintenance/locationProfile.cfm','_self');
			</script>
		</cfif>
	<cfelseif url.action EQ "update">
   		
		<cftry>
			<cfquery name="updateCode" datasource="#dts#">
				UPDATE iclocation
				SET
                    location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.location)#">,
                    desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.desp)#">, 
                    outlet = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.consignmentOutlet)#">,      
                    custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.customerNo)#">,
                    addr1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add1)#">,
                    addr2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add2)#">,
                    addr3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add3)#">,
                    addr4 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.add4)#">,  
		    source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.source)#">,
                    <cfif IsDefined('form.discontinueLocation')>
                    	noactivelocation = 'Y'
					<cfelse>
                    	noactivelocation = ''
                    </cfif>
				WHERE location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.location)#">
			</cfquery>
            
            <!--- --->
            <cfif getfunctioncontrol.refnobylocation eq "Y">
            <cfloop list="QUO,SO,DO,INV,CS,CN,DN,PO,PR,RC,RQ,SAM,DEP" index="i" delimiters=",">
            <cfquery name="insertlocationrefno" datasource="#dts#">
    			UPDATE refnoset_location SET
                lastusedno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(evaluate('form.refno_#i#'))#">,
                activate=<cfif isdefined('form.activate_#i#')>'T'<cfelse>''</cfif>
                where type="#i#" and location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.location)#">
    		</cfquery>
            </cfloop>
            </cfif>
            <!--- --->
            
            
		<cfcatch type="any">
			<script type="text/javascript">
				alert('Failed to update #trim(form.location)#!\nError Message: #cfcatch.message#');
				window.open('/latest/maintenance/location.cfm?action=update&location=#form.location#','_self');
			</script>
		</cfcatch>
		</cftry>
		<script type="text/javascript">
			alert('Updated #trim(form.location)# successfully!');
			window.open('/latest/maintenance/locationProfile.cfm','_self');
		</script>	
	<cfelseif url.action EQ "delete">
        <cfquery name="checkICTRAN" datasource='#dts#'>
            SELECT location 
            FROM ictran 
            WHERE location='#URLlocation#';
        </cfquery>
        <cfif checkICTRAN.recordcount NEQ 0>
            <script type="text/javascript">
                alert('This #URLlocation# has been used in transaction. Deleting is not allowed!');
                window.open('/latest/maintenance/locationProfile.cfm','_self');
            </script>
        <cfelse>
            <cftry>
                <cfquery name="deleteCode" datasource="#dts#">
                    DELETE FROM iclocation
                    WHERE location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#URLlocation#">
                </cfquery>
                
                <!--- --->
				<cfif getfunctioncontrol.refnobylocation eq "Y">
                
                <cfquery name="insertlocationrefno" datasource="#dts#">
                    DELETE FROM refnoset_location 
                    WHERE location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.location)#">
                </cfquery>

                </cfif>
                <!--- --->
                
                
            <cfcatch type="any">   
                <script type="text/javascript">
                    alert('Failed to delete #URLlocation#!\nError Message: #cfcatch.message#');
                    window.open('/latest/maintenance/locationProfile.cfm','_self');
                </script>
            </cfcatch>
            </cftry>
        </cfif>
		<script type="text/javascript">
			alert('Deleted #URLlocation# successfully!');
			window.open('/latest/maintenance/locationProfile.cfm','_self');
		</script>
	<cfelseif url.action EQ "print">
    
		<cfquery name="getGsetup" datasource="#dts#">
			SELECT compro 
            FROM gsetup;
		</cfquery>
        
		<cfquery name="printLocation" datasource="#dts#">
			SELECT location,desp
			FROM iclocation
			ORDER BY location;
		</cfquery>
        		
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<!---<meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>#words[487]#</title>
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
			<h1 class="text">#words[487]#</h1>
			<p class="lead">#words[100]#: #getGsetup.compro#</p>
		</div>
        
		<div class="table-responsive">
		<table class="table table-hover">
			<thead>
				<tr>
					<th>#UCase(words[482])#</th>
					<th>#UCase(words[65])#</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="printLocation">
				<tr>
					<td>#location#</td>
					<td>#desp#</td>
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
			window.open('/latest/maintenance/locationProfile.cfm','_self');
		</script>		
	</cfif>
<cfelse>
	<script type="text/javascript">
		window.open('/latest/maintenance/locationProfile.cfm','_self');
	</script>
</cfif>
</cfoutput>