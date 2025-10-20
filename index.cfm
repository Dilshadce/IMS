
<cfquery name="getstart" datasource="main">
	SELECT * FROM startupwarning
	WHERE (comid='#dts#' or comid='all')
	limit 1
</cfquery>
<cfif getstart.recordcount neq 0 and (getstart.message neq "" or getstart.details neq "") and not isdefined("url.check")>
 	<cfinclude template="/startupwarning/startupwarning.cfm">

<cfelse>

<cfquery name="checkLog" datasource="main">
	SELECT userlogid 
    FROM userlog 
    WHERE udatabase='#hcomid#'
</cfquery>

<cfquery name="getPasswordControl" datasource="main">
	SELECT * 
    FROM passwordControls;
</cfquery>

<cfquery name="getPasswordHistory" datasource="main">
	SELECT * 
    FROM passwordHistory
    WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getauthuser())#">
    AND companyID = "manpower_i"
    ORDER BY updatedOn DESC
    LIMIT 1;
</cfquery>

<cfquery name="getUserLog" datasource="main">
	SELECT * 
    FROM userlog 
    WHERE userLogID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getauthuser())#">;
</cfquery>

<cfquery name="checkskipwizard" datasource="#dts#">
	SELECT skipwizard 
    FROM gsetup;
</cfquery>

<cfif checkLog.recordcount LT 5 AND checkskipwizard.skipwizard EQ ''>
	<cflocation url="/setupwizard/wizard1.cfm">
</cfif>

<cfset lastChangedDate = DateFormat(getPasswordHistory.updatedOn,"YYYY/MM/DD")>
<cfset currentTime = DateFormat(NOW(),"YYYY/MM/DD")>
<cfset passwordExpiryDays = getPasswordControl.expiryDays>
<cfset reminderExpiryDays = getPasswordControl.reminderChangePasswordDays> 
<cfset reminderExpiry = val(passwordExpiryDays - getPasswordControl.reminderChangePasswordDays)>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>OPERATION MP4U</title>
    <link rel="shortcut icon" href="/images/mp.ico" />
</head>

<cfoutput>
	<cfif husergrpid NEQ 'super' AND dts EQ 'manpower_i'>
		<cfif IsDate(lastChangedDate)>
            <cfif DateDiff("d",lastChangedDate,currentTime) GTE #passwordExpiryDays#> 
                <script type="text/javascript">
                    alert('Your password has expired and must be changed! You will be redirected to change password page....');
                    window.open('../latest/generalSetup/userMaintenance/changePassword.cfm?fromMainPage=1','_self');
                </script>
                <cfabort>
            </cfif> 
            
            <cfif DateDiff("d",lastChangedDate,currentTime) EQ #reminderExpiry#> 
                <script type="text/javascript">
                    alert('Your password will expiry in #reminderExpiryDays# days! Please change it as soon as possible.');
                </script>
            </cfif>       
        </cfif>
        
        <cfif getPasswordHistory.recordcount EQ 0> 
            <script type="text/javascript">
                alert('Welcome On Board Operation!! You are required to change your password....');
                window.open('../latest/generalSetup/userMaintenance/changePassword.cfm?fromMainPage=1','_self');
            </script>
            <cfabort>
        </cfif> 
    </cfif>    
</cfoutput>


<frameset cols="218px,*" border="0">
    <frame frameborder="no" id="leftFrame" name="leftFrame" noresize="noresize" scrolling="no" src="/latest/side/sidemenu.cfm" />
    <frameset rows="68px,*" border="0">
        <frame frameborder="no" id="topFrame" name="topFrame" noresize="noresize" scrolling="no" src="/latest/header/header.cfm" />
        <frame frameborder="no" id="mainFrame" name="mainFrame" noresize="noresize" scrolling="yes" src="/latest/body/overview.cfm" />
    </frameset>
</frameset>

<noframes>Sorry, please use browser with support frameset while using this system.</noframes>
</html>
</cfif>