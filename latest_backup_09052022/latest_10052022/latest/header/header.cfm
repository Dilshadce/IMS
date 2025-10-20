
    
<cfquery name="getGsetup" datasource="#dts#">
	SELECT compro,period,lastaccyear,dflanguage 
    FROM gsetup;
</cfquery>

<cfif getGsetup.dflanguage NEQ "english">
        <cfset menuname=getGsetup.dflanguage>
        <cfset titledesp="titledesp_"&getGsetup.dflanguage>	
    <cfelse>
        <cfset menuname="menu_name">
        <cfset titledesp="titledesp">
    </cfif>
    
    <cfif hlang neq "">
<cfif hlang neq "english">
<cfset menuname=hlang>
<cfset titledesp="titledesp_"&hlang>	
<cfelse>
<cfset menuname="menu_name">
<cfset titledesp="titledesp">
</cfif>
</cfif>

<cfquery name="insertUserDefinedMenu" datasource="#dts#">
       INSERT IGNORE INTO userDefinedMenu(menu_id,menu_name,new_menu_name,menu_level)
       SELECT menu_id, menu_name AS a,menu_name AS b,menu_level AS c
       FROM main.menunew2;
    </cfquery>
    
    	<cfquery name="updateUserDefinedMenu" datasource="#dts#">
		UPDATE userDefinedMenu a,main.menunew2 b
		SET 
			a.new_menu_name = b.#menuname#,
			a.menu_name = b.menu_name
		WHERE a.menu_id = b.menu_id
		AND changed != '1';
    </cfquery>

<cfquery name="getModuleControl" datasource="#dts#">
	SELECT malaysiagst
    FROM modulecontrol;
</cfquery>

<cfquery name="getInviteFriend" datasource="main">
	SELECT companyID
    FROM inviteFriend;
</cfquery>

<cfquery name="getUsers" datasource="main">
	SELECT userid,usergrpid,userbranch
    FROM users
    WHERE userid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(getauthuser())#">;
</cfquery>

<cfquery name="getMasterUser" datasource="main">
    SELECT userID
    FROM masterUser
</cfquery>

<cfquery name="getUserLevel" datasource="#dts#">
    SELECT level 
    FROM userpin2 
    ORDER BY level;
</cfquery> 

<cfset comid = replace(getUsers.userbranch,'_i','')>
<cfquery name="getPartner" datasource="main">
	SELECT companyid 
    FROM invitefriend
    WHERE companyid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#comid#">;
</cfquery>
            
<cfset userLevel = getUsers.usergrpid>
<cfset userID = getauthuser()> 
<cfloop query="getMasterUser">
    <cfset masterUserList = ValueList(getMasterUser.userID,",")>
</cfloop>
<cfloop query="getInviteFriend">
    <cfset nonInviteList = ValueList(getInviteFriend.companyID,",")>
</cfloop>       


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
   <!--- <meta name="viewport" content="width=device-width, initial-scale=1.0" />--->
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Inventory Management System</title>
    <link rel="stylesheet" href="/latest/css/jqueryui/smoothness/jquery-ui-1.10.3.custom.min.css" />
    <link rel="stylesheet" href="/latest/css/pnotify/jquery.pnotify.default.css" />
    <link rel="stylesheet" href="/latest/css/header/header.css" />
    <cfoutput>
		<style>
            body {
                margin: 0;
            }
            ##container {
                height: 62px;
                margin: 0;
                border-bottom: 6px solid ##f0606d;
            }
            .company{
                background-image: url(/billformat/#dts#/companyLogo.jpg);
            }
        </style>

		<script type="text/javascript">
            <cfif ListFind(masterUserList,HuserID)>
                function changeUserLevel(userID,newUserLvl){
                  
                    ajaxFunction(document.getElementById('newUserLevel'),"updateNewUserLevel.cfm?userID=" + userID + "&newUserLvl=" + newUserLvl);
                    setTimeout("refreshPage();",5);
                }
                
                function refreshPage(){
                    window.top.location = "/index.cfm";
                }
            </cfif>
            
            <cfif ListFind(nonInviteList,HcomID)>
                var displayInviteFriend = '';
            <cfelse>
                var displayInviteFriend = 'jqueryui';            	
            </cfif>
        </script>
        <script type="text/javascript" src="/latest/js/jquery/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="/latest/js/pnotify/jquery.pnotify.min.js"></script>
        <cfif getPartner.recordcount eq 0>
        	<script type="text/javascript" src="/latest/js/header/header.js"></script>
        </cfif>
        <script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
    </cfoutput>
</head>
<body>
<cfoutput>
<div id="container">
    <div>	
        <div class="lastLoginInfo">
            <strong>Company ID:</strong> #listgetat(dts,'1','_')# &nbsp;&nbsp;&nbsp;
            <strong>User ID:</strong> #getUsers.userid# &nbsp;&nbsp;&nbsp;
            <cftry>
            	<strong>Login On:</strong> #DayOfWeekAsString(DayOfWeek(Session.loginTime))#,  #DateFormat(Session.loginTime, "dd-mm-yyyy")#, #TimeFormat(Session.loginTime, "HH:MM:SS")# &nbsp;&nbsp;&nbsp;
            <cfcatch>
            	 
            </cfcatch>
            </cftry> 

	   <cfinclude template="/CFC/LastDayOfMonth.cfm">
    	   <cfset date2 = dateadd('m',getGsetup.period,getGsetup.lastaccyear)>
    	   <cfset date2a = LastDayOfMonth(month(date2),year(date2))>
    
            <strong>IP Address:</strong> #cgi.REMOTE_ADDR# &nbsp;&nbsp;&nbsp;
            <strong>Account Year:</strong> #DateFormat(DateAdd('d',1,getGsetup.lastaccyear),'DD-MM-YYYY')# to #dateformat(date2a,'DD-MM-YYYY')#
        </div>
        <div class="menu">
            <div class="item">
                <a class="link logout" title="Logout" href="/latest/logout/logout.cfm" onclick="return confirm('Are you sure you want to log out?')" target="_parent"></a>
            </div>
            <div class="item expandable">
                <a class="link company" title="Click to change Company Logo" href="/latest/body/uploadLogo.cfm" target="mainFrame"></a>
                <div class="item_content">
                    <span class="company_name" title="#getGsetup.compro#">#getGsetup.compro#</span><br />
                    <span class="company_id" title="Company ID: #listgetat(dts,'1','_')#">Company ID: #listgetat(dts,'1','_')#</span>
                </div>
            </div>
            <cfif getPartner.recordcount eq 0>
            	<div class="item">
                	<a class="link contact" title="Contact" href="/latest/body/contact.cfm" target="mainFrame"></a>
            	</div>
            	<div class="item">
                	<a class="link support" title="Help & Support" href="/latest/body/support.cfm" target="mainFrame"></a>
            	</div>
            <cfelse>
            	<div class="item">
                	<a class="link contact" title="Contact" href="/latest/body/partnercontact.cfm" target="mainFrame"></a>
            	</div>
            </cfif>
            <div class="item">
                <a class="link home" title="Overview" href="/latest/body/overview.cfm" target="mainFrame"></a>
            </div>
            <cfif lcase(left(HuserID,5)) eq 'ultra'>
                <div class="changeUserLevel">
                	<select class="form-control input-sm" id="newUserLevel" name="newUserLevel" onchange="changeUserLevel('#userID#',this.value);">
                        <cfloop query="getUserLevel">
                            <option value="#getUserLevel.level#" <cfif getUserLevel.level EQ userLevel>selected</cfif>>#getUserLevel.level#</option>
                        </cfloop>
                    </select>   
                </div>
            </cfif>
            <cfif getModuleControl.malaysiagst EQ "1">
				<script language="javascript" type="text/javascript">
                    var left = (screen.width/2)-(800/2);
                    var top = (screen.height/2)-(600/2);
                    var targetWin = window.open ('/latest/overdueDOReport.cfm', 'Overdue DO', 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=800, height=600, top='+top+', left='+left);
                </script>
            </cfif>
        </div>
    </div>
</div>
<script type="text/javascript">
	setTimeout("window.location.reload();",900000);
</script> 
</cfoutput>
</body>
</html>