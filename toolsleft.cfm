<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Menu</title>
<link rel="stylesheet" type="text/css" href="/newinterface2/css1.css" />
<script language="javascript" type="text/javascript" src="/scripts/change_left_menunew.js"></script>
<script type="text/javascript" src="/scripts/prototypenew.js" ></script>
<script type="text/javascript">
<!--
function popup(url) 
{
 params  = 'width='+screen.width;
 params += ', height='+screen.height;
 params += ', top=0, left=0, status=yes,menubar=no , location = no'
 params += ', fullscreen=yes,scrollbars=yes';

 newwin=window.open(url,'expressbill', params);
 if (window.focus) {newwin.focus()}
 return false;
}
// -->
</script>
</head>
<cfquery name="getgeneral" datasource="#dts#">
	select * from gsetup
</cfquery>
<cfquery name="getlanguage" datasource="#dts#">
select * from main.menulang
</cfquery>
<cfquery name="getGeneralInfo" datasource="#dts#">
	select * 
	from gsetup;
</cfquery>

<cfquery name="getmodule" datasource="#dts#">
	select * 
	from modulecontrol;
</cfquery>
<cfset menutitle=StructNew()>
<cfloop query="getlanguage">
<cfif getGeneralInfo.dflanguage eq 'english'>
<cfset menutitle['#getlanguage.no#']=getlanguage.eng>
<cfelseif getGeneralInfo.dflanguage eq 'sim_ch'>
<cfset menutitle['#getlanguage.no#']=getlanguage.sim_ch>
<cfelseif getGeneralInfo.dflanguage eq 'tra_ch'>
<cfset menutitle['#getlanguage.no#']=getlanguage.tra_ch>
</cfif>
</cfloop>
<cfoutput>

<body class="netiquette">
<div style="overflow:hidden;">
<div class="secondary_menu">
<div id="masterdiv">
<li onClick="SwitchMenu('sub2')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="Tools"><cfoutput>Tools</cfoutput></a></li>
<span class="submenu" id="sub2">
 <cfif getpin2.h5D00 eq 'T'>
				<li>
				<a class="oe_secondary_submenu_item" href="/default/admin/importtable/import.cfm" target="mainFrame">
					<cfoutput>Import CSV File to IMS</cfoutput>
                </a></li>
			</cfif>
            
            <cfif getpin2.h5E00 eq 'T'>
				<li>
				<a class="oe_secondary_submenu_item" href="/default/admin/importtable/import_excel.cfm" target="mainFrame">
					<cfoutput>Import EXCEL File to IMS</cfoutput>
                </a></li>
			</cfif>	 
            
            <cfif getpin2.h5F00 eq "T">
			<li>
				<a class="oe_secondary_submenu_item" href="/default/admin/export_to_csv_list.cfm" target="mainFrame">
					<cfoutput>Export To CSV File</cfoutput>
            </a></li>
		</cfif>
        
            <cfif getpin2.H5900 eq "T">
			<li>
				<a class="oe_secondary_submenu_item" href="/default/admin/bossmenu/bossmenu.cfm" target="mainFrame">
					<cfoutput>Boss Menu</cfoutput>
            </a></li>
			</cfif>

</span>
</div>	
</div>
</div>
</body>
</cfoutput>
</html>