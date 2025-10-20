<cfif form.sub_btn eq "create">
<cfquery name="checkexist" datasource="#dts#">
SELECT id FROM poschannel WHERE posid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.posid#">
</cfquery>
<cfif checkexist.recordcount eq 0>
        <cfquery name="inserttransact" datasource="#dts#">
        INSERT INTO poschannel (posid,posfolder,posbill,created_on,created_by,custno)
        VALUES
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.posid#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.posfolder#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.posbill#">,
        now(),
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">,
         <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">
        )
        </cfquery>
        <cfquery name="getlastid" datasource="#dts#">
        SELECT LAST_INSERT_ID() as lastid;
        </cfquery>
        <cfset possv = "possv"&getlastid.lastid&dts>
        <cfset posws = "posws"&getlastid.lastid&dts>
        <cfoutput>
         <cfquery name="select_key" datasource="main">
                SELECT * FROM sec
                </cfquery>
                
                <cfset key = decrypt(#select_key.enc#,#select_key.keys#,#select_key.algo#,#select_key.encode#) >
                <cfset dbkey = decrypt(#select_key.dbkey#,#select_key.keys#,#select_key.algo#,#select_key.encode#) >
                
               <cfscript>
				  adminObj = createObject("component","cfide.adminapi.administrator");
				  adminObj.login("#key#");
				  myObj = createObject("component","cfide.adminapi.datasource");
				  myObj.setODBCSocket(driver="ODBCSocket", 
				  name = "#possv#",
datasource = "Visual FoxPro Tables",
args ="Driver={Microsoft Visual FoxPro Driver}; SourceType=DBF; SourceDB=C:\POSFILE\#dts#\#form.posfolder#\sv; Exclusive=No;",username = "system");
				</cfscript>
                
                 <cfscript>
				  adminObj = createObject("component","cfide.adminapi.administrator");
				  adminObj.login("#key#");
				  myObj = createObject("component","cfide.adminapi.datasource");
				  myObj.setODBCSocket(driver="ODBCSocket", 
				  name = "#posws#",
datasource = "Visual FoxPro Tables",
args ="Driver={Microsoft Visual FoxPro Driver}; SourceType=DBF; SourceDB=C:\POSFILE\#dts#\#form.posfolder#\ws; Exclusive=No;",username = "system");
				</cfscript>
                <cflogout>
                <cflogin>
                <cfloginuser name="#huserid#" password="1234567890" roles="">
                </cflogin>
                
        <script type="text/javascript">
        alert('POS Channel ID #form.posid# is successfully created!');
        window.location.href="listpos.cfm";
        </script>
</cfoutput>
<cfabort />
<cfelse>
<cfoutput>
<script type="text/javascript">
alert('POS Channel ID existed');
history.go(-1);
</script>
</cfoutput>
<cfabort />
</cfif>

<cfelseif form.sub_btn eq "edit">
<cfquery name="updatepos" datasource="#dts#">
UPDATE poschannel SET 
posbill = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.posbill#">,
posID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.posid#">,
posFolder = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.posfolder#">,
custno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">
WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.posrowid#">
</cfquery>
<cfoutput>
<script type="text/javascript">
alert('POS Channel ID #form.posid# is successfully updated!');
window.location.href="listpos.cfm";
</script>
</cfoutput>
<cfabort />
<cfelseif form.sub_btn eq "delete">
<cfquery name="checkid" datasource="#dts#">
SELECT id FROM poschannel WHERE posid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.posid#">
</cfquery>
<cfquery name="updatepos" datasource="#dts#">
DELETE FROM poschannel 
WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.posrowid#">
</cfquery>
<cftry>
<cfschedule action="delete" task="posexport#dts##form.posrowid#">
<cfcatch type="any">
</cfcatch>
</cftry>
<cftry>
<cfschedule action="delete" task="posimport#dts##form.posrowid#">
<cfcatch type="any">
</cfcatch>
</cftry>
<cfquery name="select_key" datasource="main">
    SELECT * FROM sec
    </cfquery>
    
    <cfset key = decrypt(#select_key.enc#,#select_key.keys#,#select_key.algo#,#select_key.encode#) >
    <cfset dbkey = decrypt(#select_key.dbkey#,#select_key.keys#,#select_key.algo#,#select_key.encode#) >
    
   <cfscript>
      adminObj = createObject("component","cfide.adminapi.administrator");
      adminObj.login("#key#");
      myObj = createObject("component","cfide.adminapi.datasource");
      myObj.deleteDatasource(dsnname="possv#form.posrowid##dts#");
    </cfscript>
    
     <cfscript>
	  adminObj = createObject("component","cfide.adminapi.administrator");
	  adminObj.login("#key#");
	  myObj = createObject("component","cfide.adminapi.datasource");
	  myObj.deleteDatasource(dsnname="posws#form.posrowid##dts#");
	</cfscript>
	<cflogout>
	<cflogin>
	<cfloginuser name="#huserid#" password="1234567890" roles="">
	</cflogin>
                
<cfoutput>
<script type="text/javascript">
alert('POS Channel ID #form.posid# is successfully deleted!');
window.location.href="listpos.cfm";
</script>
</cfoutput>
<cfabort />
</cfif>