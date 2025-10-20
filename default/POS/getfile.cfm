<cfset uniqcode = replace(createuuid(),'-','','all')>
<cfif isdefined('url.dtsname')>
<cfset dts= url.dtsname>
</cfif>
<cfif isdefined('url.type')>
<cfif url.type eq "import">
<cfset form.importpos = "Y">
</cfif>
<cfif url.type eq "export">
<cfset form.exportpos = "Y">
</cfif>
</cfif>
<cfif isdefined('url.posid')>
<cfset form.posidnew = url.posid>
</cfif>

<cfquery name="getposdetail" datasource="#dts#">
SELECT posfolder,id,posbill,custno FROM poschannel WHERE id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.posidnew#" >
</cfquery>

<cfif isdefined('form.importpos') or isdefined('form.exportpos')>
<cfelse>
<cfoutput>
<script type="text/javascript">
alert('No Operation Selected');
window.location.href="index.cfm";
</script>
<cfabort />
</cfoutput>
</cfif>

<cfquery name="getftpdetail" datasource="#dts#">
SELECT * FROM ftpdetail
</cfquery>

<cfif getftpdetail.recordcount eq 0>
<cfoutput>
<script type="text/javascript">
alert('No FTP Account Existed');
history.go(-1);
</script>
<cfabort />
</cfoutput>
</cfif>


<cfset posusername = getftpdetail.ftpuser>
<cfset posip = getftpdetail.ftphost>
<cfset pospass = getftpdetail.ftppass>
<cfset posport = getftpdetail.ftpport>

<cfset currentDirectory = "C:\POSFILE\"&#dts#>
<cfif DirectoryExists(currentDirectory) eq false>
<cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>
<cfset currentDirectory = "C:\POSFILE\"&#dts#&"\"&getposdetail.posfolder>
<cfif DirectoryExists(currentDirectory) eq false>
<cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>
<cftry>
 <cfftp action="open" username="#posusername#" password="#pospass#" server="#posip#" connection="posftp#uniqcode#" port="#posport#" passive="yes">
 <cfftp action="listdir" stoponerror="yes" name="Files" directory="/#getposdetail.posfolder#/" connection="posftp#uniqcode#" passive="yes">
 <cfftp action="close" connection="posftp#uniqcode#" stoponerror="yes" passive="yes">
<cfloop query="Files">
<cfif Files.isdirectory eq false>
<cfset localfiledrir = currentDirectory&"\"&files.name>
<cftry>
<cffile action="delete" file="#localfiledrir#" > 
<cfcatch type="any">
</cfcatch>
</cftry>
<cfftp action="getfile" username="#posusername#" password="#pospass#" server="#posip#" port="#posport#" transfermode="binary" localfile="#localfiledrir#" remotefile="/#getposdetail.posfolder#/#files.name#"  passive="yes" >

<cfif right(files.name,4) eq ".zip">
<cfset zipdirectory =  currentDirectory&"\"&mid(files.name,5,2)>
<cfif DirectoryExists(zipdirectory) eq false>
<cfdirectory action = "create" directory = "#zipdirectory#" >
</cfif>
<cfzip action="unzip" destination="#zipdirectory#" file="#localfiledrir#" overwrite="yes">

</cfif>
</cfif>
</cfloop>
<cfcatch type="any"></cfcatch></cftry>


<!--- Start data extraction --->
<cfset poswsdts = "posws#getposdetail.id#"&dts>
<cfset possvdts = "possv#getposdetail.id#"&dts>
<cfinvoke component="cfc.verify" method="VerifyDSN" dsn="#poswsdts#" returnvariable="result" />
<cfif result eq "false" >
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
				  name = "#possvdts#",
datasource = "Visual FoxPro Tables",
args ="Driver={Microsoft Visual FoxPro Driver}; SourceType=DBF; SourceDB=C:\POSFILE\#dts#\#getposdetail.posfolder#\sv; Exclusive=No;",username = "system");
				</cfscript>
                
                 <cfscript>
				  adminObj = createObject("component","cfide.adminapi.administrator");
				  adminObj.login("#key#");
				  myObj = createObject("component","cfide.adminapi.datasource");
				  myObj.setODBCSocket(driver="ODBCSocket", 
				  name = "#poswsdts#",
datasource = "Visual FoxPro Tables",
args ="Driver={Microsoft Visual FoxPro Driver}; SourceType=DBF; SourceDB=C:\POSFILE\#dts#\#getposdetail.posfolder#\ws; Exclusive=No;",username = "system");
				</cfscript>
	<cflogout>
	<cflogin>
	<cfloginuser name="#huserid#" password="1234567890" roles="">
	</cflogin>

</cfif>


<cfif isdefined('form.importpos')>
<cfinclude template="importartran.cfm">

<cfinclude template="importictran.cfm">

<cfinclude template="importgrade.cfm"> 

<cfinclude template="importserial.cfm">

<!---update tax --->

<cfquery name="getgroup" datasource="#dts#">
       select * from artran where type='CS'
</cfquery>

<cfquery name="updategroup" datasource="#dts#">
       update artran set note='SR' where type='CS'
</cfquery>

<cfloop query="getgroup">
<cfoutput>

<cfif getgroup.grand_bil neq 0>
<cfif getgroup.taxincl eq "T">
    <cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictran 
        set note_a='SR',
        TAXPEC1='#getgroup.taxp1#',
        TAXAMT_BIL=round((AMT_BIL/#val(getgroup.net_bil)#)*#val(getgroup.tax1_bil)#,5),
        TAXAMT=round((AMT/#val(getgroup.net)#)*#val(getgroup.tax)#,5)
        where type='#getgroup.type#' and refno='#getgroup.refno#';
    </cfquery>
    <cfelse>
	<cfquery name="updateictrantax" datasource="#dts#">
    	UPDATE ictran 
        set note_a='SR',
        TAXPEC1='#getgroup.taxp1#',
        TAXAMT_BIL=round((AMT_BIL/#val(getgroup.gross_bil)#)*#val(getgroup.tax1_bil)#,5),
        TAXAMT=round((AMT/#val(getgroup.invgross)#)*#val(getgroup.tax)#,5)
        where type='#getgroup.type#' and refno='#getgroup.refno#';
    </cfquery>
</cfif>
</cfif>
</cfoutput>
</cfloop>

<!--- --->

</cfif>

<cfif isdefined('form.exportpos')>
<cfinclude template="exporticitem.cfm">

<cfzip source="#currentDirectory#\sv" action="zip" file="#currentDirectory#\pos_sv.zip" overwrite="yes"></cfzip>
<cftry>
<cfftp action="open" username="#posusername#" password="#pospass#" server="#posip#" connection="posftpupload#uniqcode#" stoponerror="yes"  passive="yes">
<cfcatch type="any">
</cfcatch></cftry>
<cftry>
<cfftp action="remove" username="#posusername#" password="#pospass#" server="#posip#" port="#posport#" item="/#getposdetail.posfolder#/pos_sv.zip"  passive="yes">
<cfcatch type="any">
</cfcatch>
</cftry>
<cftry>
<cfftp action="close" connection="posftpupload#uniqcode#" stoponerror="yes"  passive="yes">
<cfcatch  type="any">
</cfcatch>
</cftry>
<cftry>
<cfftp action="putfile" username="#posusername#" password="#pospass#" server="#posip#" transfermode="binary" localfile="#currentDirectory#\pos_sv.zip" remotefile="/#getposdetail.posfolder#/pos_sv.zip" port="#posport#"  passive="yes">
<cfcatch type="any">
</cfcatch>
</cftry>
</cfif>

<cfoutput>
<script type="text/javascript">
alert('Import / Export Success!');
<cfif isdefined('url.dtsname') eq false>
window.location.href="index.cfm?id=#getposdetail.id#";
</cfif>
</script>
</cfoutput>