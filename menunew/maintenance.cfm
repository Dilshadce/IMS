<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Testing</title>
<link rel="stylesheet" type="text/css" href="/newinterface2/css1.css" />
<script language="javascript" type="text/javascript" src="/scripts/change_left_menunew.js"></script>

</head>

<body class="netiquette" onload="SwitchMenu('sub1')">
<cfquery name="getgeneral" datasource="#dts#">
SELECT * FROM gsetup
</cfquery>

<cfquery name="getlanguage" datasource="#dts#">
select * from main.menulang
</cfquery>

<cfquery name="getmodule" datasource="#dts#">
	select * 
	from modulecontrol;
</cfquery>

<cfset menutitle=StructNew()>
<cfloop query="getlanguage">
<cfif getgeneral.dflanguage eq 'english'>
<cfset menutitle['#getlanguage.no#']=getlanguage.eng>
<cfelseif getgeneral.dflanguage eq 'sim_ch'>
<cfset menutitle['#getlanguage.no#']=getlanguage.sim_ch>
<cfelseif getgeneral.dflanguage eq 'tra_ch'>
<cfset menutitle['#getlanguage.no#']=getlanguage.tra_ch>
</cfif>
</cfloop>

<cfoutput>
<div style="overflow:hidden;">
<div class="secondary_menu">
<div id="masterdiv">
<cfif getpin2.h1200 eq "T" or  getpin2.h1100 eq "T" or getpin2.h1300 eq "T" or getpin2.h1G00 eq "T" or lcase(HcomID) eq "beps_i">
<li onClick="SwitchMenu('sub1')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[126]#</cfoutput>">
<cfoutput>#menutitle[126]#</cfoutput></a></li>
<span id="sub1" style="display:none;" class="submenu">
<cfif getpin2.h1200 eq "T">
<li>
	<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/linkPage.cfm?type=Customer" target="mainFrame" title="<cfoutput>#menutitle[2]#</cfoutput>">
		<cfoutput>#menutitle[2]#</cfoutput>
	</a>
</li>
</cfif>
<cfif getpin2.h1100 eq "T">
<li>
	<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/linkPage.cfm?type=Supplier" target="mainFrame" title="<cfoutput>#menutitle[3]#</cfoutput>">
		<cfoutput>#menutitle[3]#</cfoutput>
	</a>
</li>
</cfif>
<cfif getpin2.h1300 eq "T">
<li>
	<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/s_icitem.cfm?type=icitem" target="mainFrame" title="<cfoutput>#menutitle[4]#</cfoutput>">
    	<cfif getgeneral.dflanguage eq 'english'>
                	#getgeneral.litemno# Profile
        <cfelse>
        <cfoutput>#menutitle[4]#</cfoutput>
        </cfif>
	</a>
</li>
</cfif>
<cfif getpin2.h1G00 eq "T">
<li>
	<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/servicetable.cfm" target="mainFrame" title="<cfoutput>#menutitle[5]#</cfoutput>">
		<cfoutput>#menutitle[5]#</cfoutput>
	</a>
</li>
</cfif>
<cfif lcase(HcomID) eq "beps_i">
<cfif getpin2.h1Z80 eq "T">
<li>
	<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/Placement/Placementtable.cfm" target="mainFrame" title="<cfoutput>#menutitle[127]#</cfoutput>">
		<cfoutput>#menutitle[127]#</cfoutput>
	</a>
</li>
</cfif>
</cfif>
<cfif lcase(HcomID) eq "simplysiti_i">
     <cfif getpin2.h1300 eq "T">
<li>
	<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/branch/branchtable.cfm" target="mainFrame">
		<cfoutput>Branch Profile</cfoutput>
	</a>
</li>
<li>
	<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/branchitemno/branchitemno.cfm" target="mainFrame">
		<cfoutput>Branch Item No Profile</cfoutput>
	</a>
</li>
<li>
	<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/monthlytransfer/monthlytransfertable.cfm" target="mainFrame">
		<cfoutput>Transfer Limit Profile</cfoutput>
	</a>
</li>
        </cfif>
</cfif>

</span>
</cfif>

<cfif getmodule.auto eq "1">
<li onClick="SwitchMenu('sub30')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>Vehicle Profile</cfoutput>">
<cfoutput>Vehicle Profile</cfoutput></a></li>
<span id="sub30" style="display:none;" class="submenu">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/package/packagetable.cfm" target="mainFrame" title="<cfoutput>Package Profile</cfoutput>">
                <cfoutput>Package Profile</cfoutput>
			</a>
		</li>
        
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/shellvehicles/S_vehicles.cfm" target="mainFrame" title="<cfoutput>Vehicle Profile</cfoutput>">
                <cfoutput>Vehicle Profile</cfoutput>
			</a>
		</li>
        
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/make/maketable.cfm" target="mainFrame" title="<cfoutput>Make Profile</cfoutput>">
                <cfoutput>Make Profile</cfoutput>
			</a>
		</li>
        
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/model/modeltable.cfm" target="mainFrame" title="<cfoutput>Model Profile</cfoutput>">
                <cfoutput>Model Profile</cfoutput>
			</a>
		</li>
</span>
	
</cfif>


<cfif getpin2.h1400 eq "T" or  getpin2.h1500 eq "T" or getpin2.h1600 eq "T" or  getpin2.h1700 eq "T" or getpin2.h1800 eq "T" or getpin2.h1900 eq "T" or getpin2.h1P00 eq "T" >
<li onClick="SwitchMenu('sub2')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[128]#</cfoutput>">
<cfoutput>#menutitle[128]#</cfoutput></a></li>
<span id="sub2" style="display:none;" class="submenu">
<cfif getpin2.h1400 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/categorytable.cfm" target="mainFrame" title="<cfoutput>#menutitle[6]#</cfoutput>">
                <cfif getgeneral.dflanguage eq 'english'>
               		#getgeneral.lcategory# Profile
                <cfelse>
                <cfoutput>#menutitle[6]#</cfoutput>
                </cfif>
			</a>
		</li>
	</cfif>
	<cfif getpin2.h1500 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/grouptable.cfm" target="mainFrame" title="<cfoutput>#menutitle[7]#</cfoutput>">
				<cfif getgeneral.dflanguage eq 'english'>
                	#getgeneral.lgroup# Profile
                <cfelse>
                <cfoutput>#menutitle[7]#</cfoutput>
                </cfif>
			</a>
		</li>
	</cfif>
	<cfif getpin2.h1600 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/sizeidtable.cfm" target="mainFrame" title="<cfoutput>#menutitle[8]#</cfoutput>">
				<cfif getgeneral.dflanguage eq 'english'>
               #getgeneral.lsize# Profile
                <cfelse>
                <cfoutput>#menutitle[8]#</cfoutput>
                </cfif>
			</a>
		</li>
	</cfif>
	<cfif getpin2.h1700 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/costcodetable.cfm" target="mainFrame" title="<cfoutput>#menutitle[129]#</cfoutput>">
				<cfif getgeneral.dflanguage eq 'english'>
               		#getgeneral.lrating# Profile		
                    <cfelse>
                    <cfoutput>#menutitle[129]#</cfoutput>
                    </cfif>
			</a>
		</li>
	</cfif>
	<cfif getpin2.h1800 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/coloridtable.cfm" target="mainFrame" title="<cfoutput>#menutitle[10]#</cfoutput>">
				<cfif getgeneral.dflanguage eq 'english'>
               #getgeneral.lMaterial# Profile
                <cfelse>
                <cfoutput>#menutitle[10]#</cfoutput>
                </cfif>
                
			</a>
		</li>
	</cfif>
	<cfif getpin2.h1900 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/shelftable.cfm" target="mainFrame" title="<cfoutput>#menutitle[130]#</cfoutput>">
				<cfif getgeneral.dflanguage eq 'english'>
               				#getgeneral.lModel# Profile
                    <cfelse>
                    <cfoutput>#menutitle[130]#</cfoutput>
                    </cfif>
			</a>
		</li>
	</cfif>
    <cfif getpin2.h1P00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/brandtable.cfm" target="mainFrame" title="<cfoutput>#menutitle[12]#</cfoutput>">
				<cfoutput>#menutitle[12]#</cfoutput>
			</a>
		</li>
	</cfif>
</span>
</cfif>

<cfif  getpin2.h1F00 eq "T" or  getpin2.h1Z90 eq "T" or getpin2.h1B00 eq "T" or getpin2.h1Z00 eq "T" or  getpin2.h1D00 eq "T" or getpin2.h1J00 eq "T" or getpin2.h1S00 eq "T" or getpin2.h1E00 eq "T" or getpin2.h1C00 eq "T" or getpin2.h1E00 eq "T" or getpin2.h1H00 eq "T" or getpin2.h1I00 eq "T" or  getpin2.h1A00 eq "T" or  getpin2.h1Z10 eq "T" or  getpin2.h1Z70 eq "T" or getpin2.h1K00 eq "T" or getpin2.h1K10 eq "T" or getpin2.h1K20 eq "T" or getpin2.h1K30 eq "T" or getpin2.h1K40 eq "T" or getpin2.h1K50 eq "T" or getpin2.h1K60 eq "T" or getpin2.h1K70 eq "T" or getpin2.h1ZA0 eq "T">
<li onClick="SwitchMenu('sub3')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[131]#</cfoutput>">
<cfoutput>#menutitle[131]#</cfoutput></a></li>
<span id="sub3" style="display:none;" class="submenu">
<cfif getpin2.h1F00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/addresstable.cfm" target="mainFrame" title="<cfoutput>#menutitle[13]#</cfoutput>">
				<cfoutput>#menutitle[13]#</cfoutput>
			</a>
		</li>
        </cfif>
        <cfif getpin2.h1Z90 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/customized/iel_i/maintenance/s_collectionaddress.cfm" target="mainFrame" title="<cfoutput>#menutitle[412]#</cfoutput>">
				<cfoutput>#menutitle[412]#</cfoutput>
			</a>
		</li>
	</cfif>

    
	<cfif getpin2.h1B00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/agenttable.cfm" target="mainFrame" title="<cfoutput>#menutitle[15]#</cfoutput>">
				<cfif getgeneral.dflanguage eq 'english'>
               #getgeneral.lAGENT# Profile
                <cfelse>
                <cfoutput>#menutitle[15]#</cfoutput>
                </cfif>
			</a>
		</li>
	</cfif>
    <cfif getpin2.h1Z10 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/teamtable.cfm" target="mainFrame" title="<cfoutput>#menutitle[16]#</cfoutput>">
				<cfif getgeneral.dflanguage eq 'english'>
               #getgeneral.lTeam# Profile
                <cfelse>
                <cfoutput>#menutitle[16]#</cfoutput>
                </cfif>
			</a>
		</li>
	</cfif>
	<cfif getpin2.h1Z70 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/areatable.cfm" target="mainFrame" title="<cfoutput>#menutitle[17]#</cfoutput>">
				<cfoutput>#menutitle[17]#</cfoutput>
			</a>
		</li>
	</cfif>
	<cfif getpin2.h1J00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/bom.cfm" target="mainFrame" title="<cfoutput>#menutitle[18]#</cfoutput>">
				<cfoutput>#menutitle[18]#</cfoutput>
			</a>
		</li>
	</cfif>
    <cfif getpin2.h1S00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/businesstable.cfm" target="mainFrame" title="<cfoutput>#menutitle[19]#</cfoutput>">
				<cfoutput>#menutitle[19]#</cfoutput>
			</a>
		</li>
   </cfif>
	<cfif getpin2.h1E00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/commenttable.cfm" target="mainFrame" title="<cfoutput>#menutitle[20]#</cfoutput>">
				<cfoutput>#menutitle[20]#</cfoutput>
			</a>
		</li>
	</cfif>
	<cfif getpin2.h1C00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/vdriver.cfm" target="mainFrame" title="<cfoutput>#menutitle[21]#</cfoutput>">
				<cfif getgeneral.dflanguage eq 'english'>
               #getgeneral.lDRIVER# Profile
                <cfelse>
                <cfoutput>#menutitle[21]#</cfoutput>
                </cfif>
			</a>
		</li>
	</cfif>
	<cfif getpin2.h1D00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/locationtable.cfm" target="mainFrame" title="<cfoutput>#menutitle[22]#</cfoutput>">
				<cfif getgeneral.dflanguage eq 'english'>
               #getgeneral.lLOCATION# Profile
                <cfelse>
                <cfoutput>#menutitle[22]#</cfoutput>
                </cfif>
			</a>
		</li>
	</cfif>
	
	<cfif getpin2.h1H00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/Projecttable.cfm" target="mainFrame" title="<cfoutput>#menutitle[24]#</cfoutput>">
				<cfif getgeneral.dflanguage eq 'english'>
               #getgeneral.lPROJECT# Profile
                <cfelse>
                <cfoutput>#menutitle[24]#</cfoutput>
                </cfif>
			</a>
		</li>
	</cfif>
    <cfif getpin2.h1ZA0 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/Job/Projecttable.cfm" target="mainFrame" title="<cfoutput>#menutitle[132]#</cfoutput>">
				<cfif getgeneral.dflanguage eq 'english'>
               				#getgeneral.lJOB# Profile
                    <cfelse>
                    <cfoutput>#menutitle[132]#</cfoutput>
                    </cfif>
			</a>
		</li>
	</cfif>
	
	<cfif getpin2.h1I00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/termtable.cfm" target="mainFrame" title="<cfoutput>#menutitle[25]#</cfoutput>">
				<cfoutput>#menutitle[25]#</cfoutput>
			</a>
		</li>
	</cfif>
	<cfif getpin2.h1A00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/unittable.cfm" target="mainFrame" title="<cfoutput>#menutitle[26]#</cfoutput>">
				<cfoutput>#menutitle[26]#</cfoutput>
			</a>
		</li>
	</cfif>
     <cfif getpin2.h1ZB0 eq "T">
		<li>
        <a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/identifier/Identifiertable.cfm" target="mainFrame">
			
				Identifier Profile
			</a>
		</li>
	</cfif>
	<cfif getpin2.h1K00 eq "T" or getpin2.h1K10 eq "T" or getpin2.h1K20 eq "T" or getpin2.h1K30 eq "T" or getpin2.h1K40 eq "T" or getpin2.h1K50 eq "T" or getpin2.h1K60 eq "T" or getpin2.h1K70 eq "T">
                <li onClick="SwitchMenu2('sub5')"><a class="oe_secondary_menu_item2" style="cursor:pointer" title="<cfoutput>#menutitle[27]#</cfoutput>"><cfoutput>#menutitle[27]#</cfoutput></a></li>
                <span id="sub5" style="display:none;" class="submenu2">
                <cfif getpin2.h1K10 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/openqtymaintenance/fifoopq.cfm" target="mainFrame" title="<cfoutput>#menutitle[133]#</cfoutput>">
                       <cfoutput>#menutitle[133]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getmodule.batchcode eq '1'>
                <cfif getpin2.h1K20 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/openqtymaintenance/batch.cfm?modeaction=no" target="mainFrame" title="<cfoutput>#menutitle[134]#</cfoutput>">
                        <cfoutput>#menutitle[134]#</cfoutput>
                    </a>
                </li>
                </cfif>
                </cfif>
                <cfif getpin2.h1K30 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/openqtymaintenance/location_opening_qty_maintenance.cfm?modeaction=no" target="mainFrame" title="<cfoutput>#menutitle[135]#</cfoutput>">
                        <cfoutput>#menutitle[135]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.h1K30 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/openqtymaintenance/location_opening_qty_maintenance-new.cfm?modeaction=no" target="mainFrame" title="<cfoutput>#menutitle[136]#</cfoutput>">
                        <cfoutput>#menutitle[136]#</cfoutput>
                    </a>
                </li>
                </cfif>
                 <cfif getmodule.batchcode eq '1'>
                <cfif getpin2.h1K40 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/openqtymaintenance/locationbatch.cfm?modeaction=no" target="mainFrame" title="<cfoutput>#menutitle[137]#</cfoutput>">
                        <cfoutput>#menutitle[137]#</cfoutput>
                    </a>
                </li>
                </cfif>
                </cfif>
                <cfif getpin2.h1K50 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/openqtymaintenance/serialno_opening_qty_maintenance.cfm" target="mainFrame" title="<cfoutput>#menutitle[138]#</cfoutput>">
                        <cfoutput>#menutitle[138]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.h1K60 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/openqtymaintenance/grade_opening_qty_maintenance.cfm" target="mainFrame" title="<cfoutput>#menutitle[139]#</cfoutput>">
                        <cfoutput>#menutitle[139]#</cfoutput>
                    </a>
                </li>
                </cfif>
                 <cfif getpin2.h1K60 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/openqtymaintenance/grade.cfm" target="mainFrame" title="<cfoutput>#menutitle[140]#</cfoutput>">
                        <cfoutput>#menutitle[140]#</cfoutput>
                    </a>
                </li>
                </cfif>
                <cfif getpin2.h1K70 eq "T">
                <li>
                    <a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/openqtymaintenance/s_opvalue.cfm" target="mainFrame" title="<cfoutput>#menutitle[141]#</cfoutput>">
                        <cfoutput>#menutitle[141]#</cfoutput>
                    </a>
                </li>
                </cfif>
                </span>
                </cfif>


</span>
</cfif>

<cfif  getpin2.h1L00 eq "T" or getpin2.h1M00 eq "T" or getpin2.h1N00 eq "T" or getpin2.h1O00 eq "T" or getpin2.h1Q00 eq "T" or getpin2.h1U00 eq "T" or getpin2.h1X00 eq "T" or getpin2.h1Y00 eq "T" or getpin2.h1R00 eq "T" or getpin2.h1Z30 eq "T" or getpin2.h1Z40 eq "T" or lcase(HcomID) eq "unichem_i" or lcase(HcomID) eq "mcjim_i" or getpin2.h1V00 eq "T" or getpin2.h1Z50 eq "T" or getpin2.h1Z60 eq "T" or lcase(HcomID) eq "hunting_i">
<li onClick="SwitchMenu('sub4')"><a class="oe_secondary_menu_item" style="cursor:pointer" title="<cfoutput>#menutitle[142]#</cfoutput>">
<cfoutput>#menutitle[142]#</cfoutput></a></li>
<span id="sub4" style="display:none;" class="submenu">
<cfif getpin2.h1L00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/s_colorsizetable.cfm" target="mainFrame" title="<cfoutput>#menutitle[29]#</cfoutput>">
				<cfoutput>#menutitle[29]#</cfoutput>
			</a>
		</li>
	</cfif>
	<cfif getpin2.h1M00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/s_matrixitemtable.cfm" target="mainFrame" title="<cfoutput>#menutitle[30]#</cfoutput>">
				<cfoutput>#menutitle[30]#</cfoutput>
			</a>
		</li>
	</cfif>
	<cfif getpin2.h1N00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/s_titletable.cfm" target="mainFrame" title="<cfoutput>#menutitle[31]#</cfoutput>">
				<cfoutput>#menutitle[31]#</cfoutput>
			</a>
		</li>
	</cfif>
    <cfif getpin2.h1O00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/symbol/symbolMaintenance.cfm" target="mainFrame" title="<cfoutput>#menutitle[32]#</cfoutput>">
				<cfoutput>#menutitle[32]#</cfoutput>
			</a>
		</li>
	</cfif>
    <cfif getpin2.h1Q00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/vehicles/vehicles.cfm" target="mainFrame" title="<cfoutput>#menutitle[143]#</cfoutput>">
				<cfoutput>#menutitle[143]#</cfoutput>
			</a>
		</li>
	</cfif>
    <cfif getpin2.h1U00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/vattention.cfm" target="mainFrame" title="<cfoutput>#menutitle[33]#</cfoutput>">
				<cfoutput>#menutitle[33]#</cfoutput>
			</a>
		</li>
	</cfif>
	<cfif getpin2.h1X00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/languagetable.cfm" target="mainFrame" title="<cfoutput>#menutitle[34]#</cfoutput>">
				<cfoutput>#menutitle[34]#</cfoutput>
			</a>
		</li>
        </cfif>
    <cfif getpin2.h1Y00 eq "T">    
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/termsandconditiontable.cfm" target="mainFrame" title="<cfoutput>#menutitle[35]#</cfoutput>">
				<cfoutput>#menutitle[35]#</cfoutput>
			</a>
		</li>
        </cfif>

    <cfif getpin2.h1R00 eq "T">
		<li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/voucher/voucher.cfm" target="mainFrame" title="<cfoutput>#menutitle[36]#</cfoutput>">
				<cfoutput>#menutitle[36]#</cfoutput>
			</a>
		</li>
     </cfif>
     <cfif getpin2.h1Z30 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/promotion/" target="mainFrame" title="<cfoutput>#menutitle[37]#</cfoutput>">
				<cfoutput>#menutitle[37]#</cfoutput>
			</a>
		</li>
     </cfif>
     <cfif getpin2.h1Z40 eq "T">
         <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/commission/" target="mainFrame" title="<cfoutput>#menutitle[38]#</cfoutput>">
				<cfoutput>#menutitle[38]#</cfoutput>
			</a>
		</li>
     </cfif>
	
    <cfif lcase(HcomID) eq "unichem_i">
    <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/contract/" target="mainFrame" title="<cfoutput>#menutitle[144]#</cfoutput>">
				<cfoutput>#menutitle[144]#</cfoutput>
			</a>
		</li>
	</cfif>
    <cfif lcase(HcomID) eq "mcjim_i">
       <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/itemforecastmaintainece/" target="mainFrame" title="<cfoutput>#menutitle[145]#</cfoutput>">
				<cfoutput>#menutitle[145]#</cfoutput>
			</a>
		</li>
    </cfif>
     <cfif getpin2.h1V00 eq "T">
     <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/recurrgroup/recurrmain.cfm" target="mainFrame" title="<cfoutput>#menutitle[39]#</cfoutput>">
				<cfoutput>#menutitle[39]#</cfoutput>
			</a>
		</li>
     </cfif>
     <cfif getpin2.h1Z50 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/counter/countertable.cfm" target="mainFrame" title="<cfoutput>#menutitle[40]#</cfoutput>">
				<cfoutput>#menutitle[40]#</cfoutput>
			</a>
		</li>
        
        </cfif>
        <cfif getpin2.h1Z60 eq "T">
        <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/discounttable.cfm" target="mainFrame" title="<cfoutput>#menutitle[413]#</cfoutput>">
				<cfoutput>#menutitle[413]#</cfoutput>
			</a>
		</li>
		</cfif>
        
        <cfif lcase(HcomID) eq "hunting_i">
     <li>
			<a class="oe_secondary_submenu_item" href="/#HDir#/maintenance/hunting/index.cfm" target="_blank" title="<cfoutput>#menutitle[146]#</cfoutput>">
				<cfoutput>#menutitle[146]#</cfoutput>
			</a>
		</li>
        </cfif>
</span>
</cfif>

<a class="oe_secondary_submenu_item" href="https://www.teamviewer.com/link/?url=505374&id=625664214" style="text-decoration:none; text-align:left">
    <img src="https://www.teamviewer.com/link/?url=979936&id=625664214" alt="TeamViewer for Remote Support" title="TeamViewer for Remote Support" border="0" width="130" height="50">
</a>

<a class="oe_secondary_submenu_item" href="https://showmypc.com/ShowMyPC3150.exe" style="text-decoration:none; text-align:left">
	<img src="https://showmypc.com/images/home/remote-support-logo2521.jpg" alt="ShowMyPc for Remote Support" title="Show My Pc for Remote Support" border="0" width="130" height="50">
</a>
</div>
</div>
</div>
</cfoutput>
</body>
</html>
