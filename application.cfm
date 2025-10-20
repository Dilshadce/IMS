<cfsilent>
	<!---
		************************************************************************
		Program Name : application.cfm
		Program : To SET Application informations to all pages
		************************************************************************
    --->
    <cfapplication name="IMS" sessionmanagement="yes" clientmanagement="no" sessiontimeout="#createTimespan(1,0,0,0)#" scriptProtect="all">
    <cfinclude template="/latest/login/loginprocess.cfm">
    
<!---     <cfparam name="SESSION.loginTime" default="">  
    <cfparam name="SESSION.isLogIn" default="No">
    <cfparam name="SESSION.path" default="">
    <cfparam name="session.hcredit_limit_exceed" default="">
    <cfparam name="session.bcredit_limit_exceed" default="">
    <cfparam name="session.customercode" default="">
    <cfparam name="session.tran_refno" default=""> --->
    <cfset sessiontime = 15>
    <cfset currentURL =  CGI.SERVER_NAME>
    
    <cfquery datasource='main' name="getHQstatus">
        SELECT * 
        FROM users 
        WHERE userId = '#GetAuthUser()#';
    </cfquery>
    
    <cfif gethqstatus.userdept neq "">
        <cfset dts = gethqstatus.userdept>
        <cfset localdb = gethqstatus.userdept>
    <cfelse>
        <h2>Please assign a database for this user.</h2>
        <cfabort>
    </cfif> 
    
    <cfset HcomID = getHQstatus.userBranch>
    <cfif  HcomID eq "samac_i">
	<cfset HcomID = 'f1auto_i'>
    </cfif>
    	
	<cfif  HcomID eq "emjaytest_i">
	<cfset HcomID = 'emjay_i'>
    </cfif>
    
    <cfif HcomID eq "nfagritech_i">
    	<cfset HcomID = "ktycsb_i">
    </cfif>
    
    <cfif HcomID eq "amgwsb_i">
    	<cfset HcomID = "amgworld_i">
    </cfif>
    
    <cfset HUserID = getHQstatus.userId>
    <cfset HUserName = getHQstatus.userName>
    <cfset HUserGrpID = getHQstatus.UserGrpID>
    <cfset HUserCty = getHQstatus.UserCty>
    <cfset Huseremail = getHQstatus.userEmail>
    <cfset Hserver = "smtp.mynetiquette.com">
    <cfset HVariable1 = "">
    <cfset HDir = getHQstatus.userDirectory>
    <cfif currentURL eq "operation.mp4u.com.my" or currentURL eq "operation2.mp4u.com.my">
        <cfset HRootPath = "C:\NEWSYSTEM\IMS">  
    <cfelse>
        <cfset HRootPath = "D:\NEWSYSTEM\IMS">  
    </cfif>
    <!---<cfset HRootPath = "c:/inetpub/wwwroot/IMS/" >--->
    <cfset Hlinkams = getHQstatus.linktoams>
    <cfset hlang = "" <!---getHQstatus.lang--->>
    <!--- ADD ON 300908, THE USER LOCATION --->
    <cfset Huserloc = getHQstatus.location>
    <!--- ADD ON 110211, THE USER GROUP --->
    <cfset Hitemgroup = getHQstatus.itemgroup>
    <!--- ADD ON 110211, THE USER PROJECT --->
    <cfset Huserproject = getHQstatus.project>
    <!--- ADD ON 250713, THE USER JOB --->
    <cfset Huserjob = getHQstatus.job>
	
	
	<!---Emjay--->
	<cfif lcase(HcomID) eq "emjay_i">
	<cfquery datasource='#dts#' name="getemjaycontrol">
        SELECT * 
        FROM emjayusercontrol 
        WHERE userId = '#GetAuthUser()#';
    </cfquery>
	
	<cfset emjayhcustno=getemjaycontrol.custno>
	<cfset emjayhgroup=getemjaycontrol.wos_group>
	<cfset emjayhcate=getemjaycontrol.category>
	</cfif>
	
    
    <cfset start_time1=timeformat(getHQstatus.start_time,"HH:mm:ss")>
    <cfset end_time1=timeformat(getHQstatus.end_time,"HH:mm:ss")>
    <cfset timenow=timeformat(now(),"HH:mm:ss")>
    
   <!--- <cfif getHQstatus.start_time neq "" and start_time1 neq "00:00:00">
        <cfset start_hr=listgetat(start_time1,1,":")>
        <cfset start_min=listgetat(start_time1,2,":")>
        
       <cfif listgetat(timenow,1,":") lt start_hr>
           <cfinclude template="logout.cfm"><cfabort>
        </cfif>
        <cfif listgetat(timenow,1,":") eq start_hr and listgetat(timenow,2,":") lt start_min>
            <cfinclude template="logout.cfm"><cfabort>
        </cfif>
    </cfif>
    
    <cfif getHQstatus.end_time neq "" and end_time1 neq "00:00:00">
        <cfset end_hr=listgetat(end_time1,1,":")>
        <cfset end_min=listgetat(end_time1,2,":")>
        
        <cfif listgetat(timenow,1,":") gt end_hr>
            <cfinclude template="logout.cfm"><cfabort>
        </cfif>
        <cfif listgetat(timenow,1,":") eq end_hr and listgetat(timenow,2,":") gt end_min>
            <cfinclude template="logout.cfm"><cfabort>
        </cfif>
    </cfif>--->
    
<!---     <cfquery name="getPRtype" datasource="#dts#">
        SELECT prf 
        FROM gsetup;
    </cfquery> --->
    
    <cfif Hlinkams eq "Y">
        <cfset target_arcust = replacenocase(dts,"_i","_a","all")&".arcust">
        <!--- <cfif getPRtype.prf eq "creditor"> --->
        <cfset target_apvend = replacenocase(dts,"_i","_a","all")&".apvend">
       <!---  <cfelse>
        <cfset target_apvend = replacenocase(dts,"_i","_a","all")&".arcust">
        </cfif> --->
        <cfset target_icterm = replacenocase(dts,"_i","_a","all")&".icterm">
        <cfset target_currency = replacenocase(dts,"_i","_a","all")&".currency">
        <cfset target_currencymonth = replacenocase(dts,"_i","_a","all")&".currencyratemonth">
        <cfset target_taxtable = replacenocase(dts,"_i","_a","all")&".taxtable">
        <cfset target_project= replacenocase(dts,"_i","_a","all")&".project">
        <cfset target_icagent= replacenocase(dts,"_i","_a","all")&".icagent">
        <cfset target_icarea= replacenocase(dts,"_i","_a","all")&".icarea">
    <cfelse>
        <cfset target_arcust = dts&".arcust">
         <!--- <cfif getPRtype.prf eq "creditor">  --->
        <cfset target_apvend = dts&".apvend">
        <!--- <cfelse>
        <cfset target_apvend = dts&".arcust">
        </cfif> --->
        <cfset target_icterm = dts&".icterm">
        <cfset target_currency = dts&".currency">
        <cfset target_currencymonth = dts&".currencyratemonth">
        <cfset target_taxtable = dts&".taxtable">
        <cfset target_project = dts&".project">
        <cfset target_icagent = dts&".icagent">
        <cfset target_icarea = dts&".icarea">
    </cfif>
    
    <!--- ADD ON 050608 --->
    <cfif husergrpid eq "suser">
        <cfset thislevel = "standard">
    <cfelseif husergrpid eq "guser">
        <cfset thislevel = "general">
    <cfelseif husergrpid eq "luser">
        <cfset thislevel = "limited">
    <cfelseif husergrpid eq "muser">
        <cfset thislevel = "mobile">
    <cfelse>
        <cfset thislevel = husergrpid>
    </cfif>
    <!--- ADD ON 050608 --->
    
    <cfquery name="getpin2" datasource="#dts#">
        select * 
        from userpin2 
        where level = '#thislevel#'
    </cfquery>
	<Cfset getUserPin2 = getpin2>
        
    <cfquery datasource="#dts#">
        SET SESSION binlog_format = 'MIXED'
    </cfquery>
    
    <!--- <cfquery name="getUserPin2" datasource="#dts#">
        SELECT * 
        FROM userpin2 
        WHERE level = '#thislevel#';
    </cfquery> --->

</cfsilent>

        <!---Added Nieo, session timeout 20170804--->
        <cfif isdefined('SESSION.loginTime')>
            <cfif datediff('n',SESSION.loginTime,now()) gt sessiontime>
                <cfset SessionInvalidate()>
                <cflogout>
                <script>
                    window.open("/latest/logout/logout.cfm?msg=sessionout", "_top");
                </script>
            </cfif>
            <cfset time = now()>
            <cfset SESSION.loginTime = "#time#">
        <cfelse>
            <cfset SessionInvalidate()>
            <cflogout>
            <script>
                window.open("/latest/logout/logout.cfm?msg=sessionout", "_top");
            </script>
        </cfif>
    <!---End Added Nieo, session timeout 20170804--->

<!---<cfif Left(huserid,5) NEQ 'ultra'>
    <cferror type="exception" template="/latest/error/error.cfm">
    <cferror type="request" template="/latest/error/error.cfm">
    <cferror type="validation" template="/latest/error/error.cfm">
</cfif>--->