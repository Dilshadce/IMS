<cfsetting requesttimeout = 0>

<cfset currentURL =  CGI.SERVER_NAME>
    
<cfif currentURL eq "operation.mp4u.com.my">
    <cfset serverhost = "10.72.75.4">
    <cfset servername = "appserver1">
    <cfset serverpass = "Nickel266(">
<cfelse>
    <cfset serverhost = "127.0.0.1">
    <cfset servername = "root">
    <cfset serverpass = "8888">
</cfif>
    
<cfset tbltoclear = "arcust_gp,arcust_po,arcust_temp,assignmentslip_cp39,assignmentslip_cp39txt,assignmentslip_gp,assignmentslip_paysummary,assignmentslip_po,assignmentslip_socso,ictran_excel,ictran_glps,ictran_po,ictrantemp,placement_gp,placement_po,placementtemp">
    
<cfloop index="a" list="#tbltoclear#">
    <cfquery name="clear_lorealadvance" datasource="#dts#">
        truncate #a#
    </cfquery>    
</cfloop>
        
<cfif currentURL eq "operation.mp4u.com.my">
    <cfset currentDirectory = "C:\NEWSYSTEM\IMS\DATABACKUP\" & dts>
<cfelse>
    <cfset currentDirectory = "#Hrootpath#\DATABACKUP\" & dts>
</cfif>
<cfif DirectoryExists(currentDirectory) eq false>
<cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>
<cfset remark = "YEAREND">
<cfset filename=dts&"_"&dateformat(now(),'YYYYMMDD')&"_"&timeformat(now(),'HHMMSS')&"_"&GetAuthUser()&"_"&trim(#remark#)&".sql">
<cfset currentdirfile=currentDirectory&"\"&filename>

<cfif currentURL eq "operation.mp4u.com.my">
    <cfexecute name = "C:\NEWSYSTEM\IMS\mysqldump"
        arguments = "--host=#serverhost# --user=#servername# --password=#serverpass# #dts#" outputfile="#currentdirfile#" timeout="7200">
    </cfexecute> 
<cfelse>   
    <cfexecute name = "#Hrootpath#\mysqldump.exe"
        arguments = "--host=#serverhost# --user=#servername# --password=#serverpass# #dts#" outputfile="#currentdirfile#" timeout="7200">
    </cfexecute> 
</cfif>

<cfset filesize = GetFileInfo('#currentdirfile#').size >

<cfif filesize lt 200000>
<h1>Year End Failed! Please contact help desk at IT@manpower.com.my </h1>
<cfabort>
<cfelse>
</cfif>
    
<cftry>
    
    <cfquery name="getyear" datasource="#dts#">
    SELECT year(lastaccyear)+1 as myear FROM gsetup 
    </cfquery>
    
    <cfquery name="update_fperiod" datasource="#dts#">
        update ictran
        set operiod = fperiod
        where fperiod<>99
    </cfquery>

    <cfquery name="update_fperiod" datasource="#dts#">
        update ictran
        set fperiod = 99
    </cfquery>

    <cfquery name="update_fperiod" datasource="#dts#">
        update artran
        set operiod = fperiod
        where fperiod<>99
    </cfquery>

    <cfquery name="update_fperiod" datasource="#dts#">
        update artran
        set fperiod = 99
        where fperiod<>99 and type in ('inv','cn','dn')
    </cfquery>

    <cfquery name="update_payrollperiod" datasource="#dts#">
        update assignmentslip
        set oriperiod = payrollperiod
    </cfquery>

    <cfquery name="update_payrollperiod" datasource="#dts#">
        update assignmentslip
        set payrollperiod=99
        where payrollperiod<>99
    </cfquery>

    <cfquery name="clear_ictrantempcn" datasource="#dts#">
        truncate ictrantempcn
    </cfquery>
        
    <cfquery name="clear_lorealadvance" datasource="#dts#">
        truncate lorealadvance
    </cfquery>

    <cfset status_msg="Year End Success!">
        
    <cfcatch type="database">
		<cfset status_msg="Fail To Year End. Error Message : #cfcatch.Detail#">
	</cfcatch>
</cftry>
        
<cfif status_msg eq "Year End Success!">
    
    <cfset currentdirfilenew = currentdirfile>
    <cfset currentURL =  CGI.SERVER_NAME>
        
    <cfset yearnow = numberformat(right(getyear.myear,2),'00')>

    <cfset newdts =replace(dts,'_i','')&val(yearnow)&"_i">
        
    <cfset companyidnew = replace(newdts,'_i','')>
        
    <cfset dbname = #companyidnew#&"_i" >
        
    <cfquery name="create_DB" datasource="#dts#">
    CREATE DATABASE #dbname#;
    </cfquery>
    <cfquery name="select_tbl" datasource="#dts#">
    show tables from #dts#
    </cfquery>

    <cfloop query="select_tbl">
        <cfquery name="createtbl" datasource="#dts#">
        CREATE TABLE #dbname#.#evaluate('select_tbl.tables_in_#dts#')# like #dts#.#evaluate('select_tbl.tables_in_#dts#')#
        </cfquery>
    </cfloop>

    <cfif currentURL eq "operation.mp4u.com.my">
        <cfset currentDirectory = "C:\NEWSYSTEM\IMS\DATABACKUP\"& newdts>
    <cfelse>
        <cfset currentDirectory = "#Hrootpath#\DATABACKUP\"& newdts>
    </cfif>        
    <cfif DirectoryExists(currentDirectory) eq false>
        <cfdirectory action = "create" directory = "#currentDirectory#" >
    </cfif>
    <cfset filename=newdts&"_"&dateformat(now(),'YYYYMMDD')&"_"&timeformat(now(),'HHMMSS')&"_"&GetAuthUser()&"_RESBACK.sql">
    <cfset currentdirfile=currentDirectory&"\"&filename>

    <cfif currentURL eq "operation.mp4u.com.my">
        <cfset mysqldumppath = "C:\inetpub\wwwroot\payroll\mysqldump.exe">
    <cfelse>
        <cfset mysqldumppath = "#Hrootpath#\mysqldump.exe">
    </cfif>

    <cfexecute name = "#mysqldumppath#"
        arguments = "--host=#serverhost# --user=#servername# --password=#serverpass# #newdts#" outputfile="#currentdirfile#" timeout="7200">
    </cfexecute>

    <cfset filesize = GetFileInfo('#currentdirfile#').size >

    <cfif filesize lt 200000>        
        <h1>Year End Completed But Create Previous Year Database failed!Please contact System Administrator!</h1>
        <cfabort>
    </cfif>




    <cfif currentURL eq "operation.mp4u.com.my">
        <cfset currentDirectory = "C:\NEWSYSTEM\IMS\DATABACKUP\" & newdts>
    <cfelse>
        <cfset currentDirectory = "#Hrootpath#\DATABACKUP\" & newdts>
    </cfif>
    <cfset runfile = currentDirectory&"\"&newdts&".bat">
    <cfset filename=currentdirfilenew>
    <cfif currentURL eq "operation.mp4u.com.my">
        <cfset filecontent = "C:\NEWSYSTEM\IMS\mysql.exe "&" --host=#serverhost# --user=#servername# --password=#serverpass# "&newdts&" < "&filename>
    <cfelse>
        <cfset filecontent = "#Hrootpath#\mysql.exe "&" --host=#serverhost# --user=#servername# --password=#serverpass# "&newdts&" < "&filename>
    </cfif>


    <cffile action="Write" 
                file="#runfile#" 
                output="#filecontent#" nameconflict="overwrite"> 

    <cfexecute name = "#runfile#" timeout="7200">
    </cfexecute>
        
    <cfquery name="add_year_gsteup_qry" datasource="#dts#">
        update gsetup 
        set 
        lastaccyear = DATE_ADD(lastaccyear, INTERVAL 1 YEAR)
    </cfquery>

    <cfset adminAPI = createObject( 'component', 'cfide.adminapi.administrator' ) />
    <cfif currentURL eq "operation.mp4u.com.my">
        <cfset adminAPI.login( 'Sapphire5611()3027' ) />
    <cfelse>
        <cfset adminAPI.login( '8888' ) />
    </cfif>

    <cfscript>
        dsnAPI = createObject( 'component', 'cfide.adminapi.datasource' );

        dsn = {
            driver = 'mysql5',
            name = '#companyidnew#_p',
            host = '#serverhost#',
            port = '3306',
            database = '#companyidnew#_p',
            username = '#servername#',
            password = '#serverpass#',
            args = 'zeroDateTimeBehavior=convertToNull'
        };

        dsnAPI.setMySQL5( argumentCollection = dsn );

        dsn = {
            driver = 'mysql5',
            name = '#companyidnew#_i',
            host = '#serverhost#',
            port = '3306',
            database = '#companyidnew#_i',
            username = '#servername#',
            password = '#serverpass#',
            args = 'zeroDateTimeBehavior=convertToNull'
        };

        dsnAPI.setMySQL5( argumentCollection = dsn );
    </cfscript>
     
    <cfoutput>
    <script type="text/javascript">
    alert("#status_msg#");
    window.close();
    </script>
    </cfoutput>
    
</cfif>