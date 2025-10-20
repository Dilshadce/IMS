<!---DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd"--->
<cfquery name="getgeneral" datasource="#dts#">
	select * from gsetup
</cfquery>

<cfif getgeneral.interface eq 'old'>
<html>
<head>
<title>Inventory Management System</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<base target="mainFrame">

<cfif getgeneral.menutype eq "V">
	<cfif HUserGrpID eq 'muser'>
		<cflocation url="home2.cfm">
	<cfelse>
	<!--- <frameset rows="60,*" cols="*" frameborder="yes" border="0" framespacing="0">
		<frame src="header.cfm" name="topFrame" scrolling="NO" noresize >
		<frameset cols="150,*" frameborder="yes" border="0" framespacing="0">
    		<frame src="menu/left2.cfm" name="leftFrame" scrolling="no"  noresize>
    		<frame src="newBody.cfm" name="mainFrame">
		</frameset>
	</frameset>
	<noframes></noframes> --->
	<body style="overflow:hidden;margin:0;padding:0;border:0">
	<iframe name="ifr" id="ifr" style="position:absolute;width:100%;height:100%;left:0px;top:0px" src="frameset2.cfm"></iframe>
	</cfif>
<cfelseif getgeneral.menutype eq "H">
	<body style="overflow:hidden;margin:0;padding:0;border:0" onload="Pop_Go();">
	
	<cfif HUserGrpID eq 'muser'>
		<cflocation url="home2.cfm">
	<cfelse>
		<!--- REMARK ON 030608 AND REPLACE WITH THE IFRAME ---> 
		<!---frameset rows="60,*" cols="*" frameborder="yes" border="0" framespacing="0">
			<frame src="header.cfm" name="topFrame" scrolling="NO" noresize >
			<frameset cols="150,*" frameborder="yes" border="0" framespacing="0">
    			<frame src="menu/left2.cfm" name="leftFrame" scrolling="no"  noresize>
    			<frame src="home.cfm" name="mainFrame">
			</frameset>
		</frameset>
		<noframes></noframes--->
		<iframe name="ifr" id="ifr" style="position:absolute;width:100%;height:100%;left:0px;top:0px" src="frameset.cfm"></iframe>
	</cfif>

	<!--- Scripts for the 7.00 HV Pop menu --->
	<script type='text/javascript'>
		function Pop_Go(){return}
		function PopMenu(a,b){return}
		function OutMenu(a){return}
	</script>
	
	<cfinclude template="dropdownmenu/exmplmenu2super_var.cfm">
	
	<script type='text/javascript' src='dropdownmenu/menu5_com.js'></script>
	<cfsetting showdebugoutput="no">
	</body>	
</cfif>
<!--- ADD THE BODY TAG ON 270508 FOR THE MENUBAR --->

<!--- <cfquery name="check" datasource="main">
	select * from startupwarning
	where comid='#dts#'
</cfquery> --->
<cfquery name="check" datasource="main">
	select * from startupwarning
	where (comid='#dts#' or comid='all')
	limit 1
</cfquery>
<cfif check.recordcount neq 0 and (check.message neq "" or check.details neq "")>
	<cfinclude template="startupwarning.cfm">
</cfif>
</html>

<cfelseif getgeneral.interface eq 'shell'>

<script type='text/javascript'>
		function Pop_Go(){return}
		function PopMenu(a,b){return}
		function OutMenu(a){return}
	</script>
    <cfinclude template="dropdownmenu/exmplmenu2super_var.cfm">
	
	<script type='text/javascript' src='dropdownmenu/menu5_com.js'></script>
	<cfsetting showdebugoutput="no">
<html>
<head>
<title>Inventory Management System</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
</head>
<link rel="shortcut icon"
 href="/IMS.ico" />
<cfoutput>
<frameset rows="130,*" cols="*" frameborder="no" border="0" framespacing="0">
<frame src="/newinterfaceshell/header.cfm" name="topFrame" scrolling="NO" noresize >
<frameset cols="200,*" frameborder="no" border="0" framespacing="0">
<frame src="/menunewshell/transaction.cfm" name="leftFrame" scrolling="auto"  noresize>
<frame src="/newBody2.cfm" name="mainFrame" scrolling="YES">
</frameset>
</frameset><noframes></noframes>
</cfoutput>
</html>

<cfelse>

<script type='text/javascript'>
		function Pop_Go(){return}
		function PopMenu(a,b){return}
		function OutMenu(a){return}
	</script>
    <cfinclude template="dropdownmenu/exmplmenu2super_var.cfm">
	
	<script type='text/javascript' src='dropdownmenu/menu5_com.js'></script>
	<cfsetting showdebugoutput="no">
<html>
<head>
<title>Inventory Management System</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
</head>
<link rel="shortcut icon"
 href="/IMS.ico" />
<cfoutput>
<frameset rows="130,*" cols="*" frameborder="no" border="0" framespacing="0">
<cfif getgeneral.header eq 'fix'>
<frame src="/newinterface2/header2.cfm" name="topFrame" scrolling="Yes" noresize >
<cfelse>
<frame src="/newinterface2/header.cfm" name="topFrame" scrolling="NO" noresize >
</cfif>
<frameset cols="200,*" frameborder="no" border="0" framespacing="0">
<frame src="/menunew2/transaction.cfm" name="leftFrame" scrolling="auto"  noresize>
<frame src="/newBody2.cfm" name="mainFrame">
</frameset>
</frameset><noframes></noframes>
</cfoutput>
</html>
</cfif>
<!--- <cfif getgeneral.interface eq 'old'>
<cfinclude template="/updateemail/updateemail.cfm">
</cfif> --->
<cftry>
<cfquery name="checklog" datasource="main">
select userlogid from userlog where udatabase='#hcomid#'
</cfquery>
<cfquery name="checkskipwizard" datasource="#dts#">
select skipwizard from gsetup
</cfquery>


<cfif checklog.recordcount lt 5 and checkskipwizard.skipwizard eq ''>
<cflocation url="/setupwizard/wizard1.cfm?type=w1">
</cfif>
<cfcatch></cfcatch>
</cftry>
