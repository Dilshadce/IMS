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
<li onClick="SwitchMenu('sub2')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="Sales"><cfoutput>Sales</cfoutput></a></li>

<span class="submenu" id="sub2" style="display:block">
    <cfif getpin2.h2870 eq 'T'>
    <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=quo" target="mainFrame" title="<cfoutput>#menutitle[68]#</cfoutput>">
					<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lQUO#
                    <cfelse>
                    <cfoutput>#menutitle[70]#</cfoutput>
                    </cfif>
				</a>
			</li>
				
			</cfif>
            
            <cfif getpin2.h2880 eq 'T'>
            <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=so" target="mainFrame" title="<cfoutput>#menutitle[69]#</cfoutput>">
					<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lSO#
                    <cfelse>
                    <cfoutput>#menutitle[69]#</cfoutput>
                    </cfif>
				</a>
			</li>
			</cfif>	 
            <cfif getpin2.h2300 eq "T">
            <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=do" target="mainFrame" title="<cfoutput>#menutitle[44]#</cfoutput>">
					<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lDO#
                    <cfelse>
                    <cfoutput>#menutitle[44]#</cfoutput>
                    </cfif>
				</a>
			</li>
		</cfif>
            <cfif getpin2.h2400 eq "T">
			<li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=inv" target="mainFrame" title="<cfoutput>#menutitle[45]#</cfoutput>">
					<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lINV#
                    <cfelse>
                    <cfoutput>#menutitle[45]#</cfoutput>
                    </cfif>
				</a>
			</li>
			</cfif>
            <cfif getpin2.h2500 eq "T">
             <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=cs" target="mainFrame" title="<cfoutput>#menutitle[70]#</cfoutput>">
                <cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lCS#
                    <cfelse>
                    <cfoutput>#menutitle[46]#</cfoutput>
                </cfif>
				</a>
				</li>
			</cfif>
	    	<cfif getpin2.h2700 eq "T">
			<li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=dn" target="mainFrame" title="<cfoutput>#menutitle[48]#</cfoutput>">
					<cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lDN#
                    <cfelse>
                    <cfoutput>#menutitle[48]#</cfoutput>
                    </cfif>
				</a>
			</li>
			</cfif>
        	<cfif getpin2.h2600 eq "T">
			  <li>
				<a class="oe_secondary_submenu_item" href="/#HDir#/transaction/transaction.cfm?tran=cn" target="mainFrame" title="<cfoutput>#menutitle[156]#</cfoutput>">
                <cfif getGeneralInfo.dflanguage eq 'english'>
               				#getGeneralInfo.lCN#
                    <cfelse>
                    <cfoutput>#menutitle[47]#</cfoutput>
                </cfif>
				</a>
				</li>
			</cfif>	

</span>
</div>
</div>	
</div>

</body>
</cfoutput>
</html>