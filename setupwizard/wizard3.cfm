<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/stylesheet/jquery-ui.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/scripts/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/scripts/jquery-ui.js"></script>
<script>

  $( document ).tooltip({ position: { my: "center top+0", at: "center bottom", collision: "flipfit" } });

</script>
<cfquery name="getgsetup" datasource="#dts#">
SELECT * from gsetup
</cfquery>

<cfquery name="getCurrency" datasource="#dts#">
	select * from #target_currency#
	order by CurrCode 
</cfquery>
<cfquery name="getGeneralInfo" datasource="#dts#">
	select * 
	from modulecontrol;
</cfquery>

<cfset project = getGeneralInfo.project>
<cfset job = getGeneralInfo.job>
<cfset auto = getGeneralInfo.auto>
<cfset location = getGeneralInfo.location>
<cfset serialno = getGeneralInfo.serialno>
<cfset grade = getGeneralInfo.grade>
<cfset matrix = getGeneralInfo.matrix>
<cfset manufacturing = getGeneralInfo.manufacturing>
<cfset batchcode = getGeneralInfo.batchcode>

<cfif isdefined('form.sub_btn')>

<cfset thisPath = ExpandPath("/billformat/#dts#/*.*")>
<cfset thisDirectory = GetDirectoryFromPath(thisPath)>

<cfif DirectoryExists(thisDirectory) eq 'NO'>
	<cfdirectory action="create" directory="#thisDirectory#">
</cfif>

<cfif FileExists('#thisDirectory#preprintedformat.cfm') eq 'NO'>
<cftry>
	
	<cffile action="copy" source="#ExpandPath("/billformat/empty_i/preprintedformat.cfm")#" destination="#thisDirectory#">
	<cffile action="copy" source="#ExpandPath("/billformat/empty_i/transactionformat.cfm")#" destination="#thisDirectory#">
    <cfif form.formattype eq '1'>
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/CN.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_CN.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/CS.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_CS.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/DN.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_DN.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/DO.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_DO.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/INV.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_INV.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/PR.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_PR.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/QUO.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_QUO.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/RC.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_RC.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/SO.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_SO.cfr">
    <cfelseif form.formattype eq '2'>
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/CN2.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_CN.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/CS2.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_CS.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/DN2.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_DN.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/DO2.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_DO.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/INV2.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_INV.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/PR2.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_PR.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/QUO2.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_QUO.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/RC2.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_RC.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/SO2.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_SO.cfr">
    
    <cfelseif form.formattype eq '3'>
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/CN3.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_CN.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/CS3.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_CS.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/DN3.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_DN.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/DO3.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_DO.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/INV3.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_INV.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/PR3.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_PR.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/QUO3.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_QUO.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/RC3.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_RC.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/SO3.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_SO.cfr">
    
    <cfelseif form.formattype eq '4'>
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/CN4.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_CN.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/CS4.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_CS.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/DN4.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_DN.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/DO4.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_DO.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/INV4.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_INV.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/PR4.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_PR.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/QUO4.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_QUO.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/RC4.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_RC.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/SO4.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_SO.cfr">
    
    <cfelse>
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/CN5.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_CN.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/CS5.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_CS.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/DN5.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_DN.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/DO5.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_DO.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/INV5.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_INV.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/PR5.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_PR.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/QUO5.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_QUO.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/RC5.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_RC.cfr">
    <cffile action="copy" source="#ExpandPath("/billformat/empty_i/SO5.cfr")#" destination="#thisDirectory#/#dts#_iCBIL_SO.cfr">
    </cfif>
    
    <cfquery name="insert" datasource="#dts#">
    insert into customized_format (type,display_name,file_name,counter,d_option) values
    ('CN','Credit Note','#dts#_iCBIL_CN','1','0'),
    ('CS','Cash Sales','#dts#_iCBIL_CS','1','0'),
    ('DN','Debit Note','#dts#_iCBIL_DN','1','0'),
    ('DO','Delivery Order','#dts#_iCBIL_DO','1','0'),
    ('INV','Invoice','#dts#_iCBIL_INV','1','0'),
    ('PR','Purhcase Return','#dts#_iCBIL_PR','1','0'),
    ('QUO','Quotation','#dts#_iCBIL_QUO','1','0'),
    ('RC','Receive','#dts#_iCBIL_RC','1','0'),
    ('SO','Sales Order','#dts#_iCBIL_SO','1','0')
    </cfquery>
    
	<cfcatch type="any">
</cfcatch>
</cftry>
<cftry>
	<cfdirectory action="create" directory="#GetDirectoryFromPath(ExpandPath("/Download/#dts#/ver9.0/*.*"))#">
	<cfdirectory action="create" directory="#GetDirectoryFromPath(ExpandPath("/Download/#dts#/ver9.1/*.*"))#">
	<cffile action="copy" source="#ExpandPath("/Download/ver9.0/glpost9.csv")#" destination="#GetDirectoryFromPath(ExpandPath("/Download/#dts#/ver9.0/*.*"))#">
	<cffile action="copy" source="#ExpandPath("/Download/ver9.1/glpost9.csv")#" destination="#GetDirectoryFromPath(ExpandPath("/Download/#dts#/ver9.1/*.*"))#">
<cfcatch type="any">
</cfcatch>
</cftry>
	<cfoutput><p>Company directory has been created.</p></cfoutput>

</cfif>

</cfif>


<cfoutput>
<cfform name="wizard2form" id="wizard2form" method="post" action="wizard4.cfm?type=w4">
<cfinclude template="header_wizard.cfm">
<!---<div align="Center"><h3>*Below is a <strong>6 step</strong> simple wizard to help you set up your Inventory Management System</h3></div>--->
<br />
<br />
<h1  align="center">Advance Feature Activation Page</h1>
<table height="700" cellpadding="0" cellspacing="0" align="center" style="border: 1px solid black ;">
<tr>
<th><div align="center">Feature</div></th>
<th colspan="2"><div align="center">Description</div></th>
<th><div align="center">Possible Use</div></th>
<th><div align="center">Action</div></th>
</tr>
<tr> 
        <tr title="Enables all the project module. If this option is not tick, the project module wont show."> 
		  	<td align="left" nowrap="nowrap">Project Module</td>
            <td align="left" width="300">This feature will enable you to track the performance of the project that your company is engaged on. User may break down into job level for more detail breakdown.
			</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td align="left" nowrap="nowrap">
            1. Renovation Company<br />
            2. Construction Company<br />
            3. Contracts Manufacturing<br />
			</td>
		  	<td align="center"><input name="project" type="checkbox" value="1" <cfif project eq '1'>checked</cfif>></td>
		</tr>
        <tr>
        <td colspan="100%"><hr /></td>
        </tr>
       	
        <tr title="Enables all the location module. If this option is not tick, the location module wont show."> 
		  	<td align="left" nowrap="nowrap">Location Module</td>
            <td align="left" width="300">When this feature is activated, it will allow you to store and track your inventory by location.
			</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td align="left" nowrap="nowrap">
            1. Multiple Storage Location<br />
            2. Consignment Tracking<br />
            3. Internal large storage monitoring<br />
			</td>
		  	<td align="center"><input name="location" type="checkbox" value="1" <cfif location eq '1'>checked</cfif>></td>
		</tr>        
        <tr>
        <td colspan="100%"><hr /></td>
        </tr>       
        <tr title="Enables all the serial no module. If this option is not tick, the serial no module wont show."> 
		  	<td align="left" nowrap="nowrap">Serial Number Module&nbsp;&nbsp;&nbsp;</td>
            <td align="left" width="300">This feature is usually used by high value item that has extended warranty purposes. Industries that sell products and extend warranty like computers, industrial equipment that has their own serial number.
			</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td align="left" nowrap="nowrap">
            1. Computer Warranty Tracking<br />
            2. Industrial machinery<br />
            3. Controlled item such as <br />
			</td>
            
		  	<td align="center"><input name="serialno" type="checkbox" value="1" <cfif serialno eq '1'>checked</cfif>></td>
		</tr>   
        <tr>
        <td colspan="100%"><hr /></td>
        </tr>    
         <tr title="Enables all the grade module. If this option is not tick, the grade module wont show."> 
		  	
            <td align="left" nowrap="nowrap">Grade Module</td>
            <td align="left" width="300">This feature is useful in environment where user need a single visual view of their inventory holding of a particular product by colour or slight variation.
			</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td align="left" nowrap="nowrap">
            Single colour variation products<br />
            1. Bottles (Red/Blue/Green)<br />
            2. Metal Rack (Black/Brown/White)<br />
			</td>
            
		  	<td align="center"><input name="grade" type="checkbox" value="1" <cfif grade eq '1'>checked</cfif>></td>
		</tr> 
        <tr>
        <td colspan="100%"><hr /></td>
        </tr>      
         <tr title="Enables all the matrix module. If this option is not tick, the matrix module wont show."> 
		  	<td align="left" nowrap="nowrap">Matrix Control Module</td>
            <td align="left" width="300">This feature will enable user to have a visual overview by colour and size in one glance.
			</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td align="left" nowrap="nowrap">
            1. Garments<br />
            2. Footwear<br />
			</td>
		  	<td align="center"><input name="matrix" type="checkbox" value="1" <cfif matrix eq '1'>checked</cfif>></td>
		</tr>  
        <tr>
        <td colspan="100%"><hr /></td>
        </tr>
         <tr title="Enables all the manufacturing module. If this option is not tick, the manufacturing module wont show."> 
		  	<td align="left" nowrap="nowrap">Bill of Material</td>
            <td align="left" width="300">This feature will proved to be very useful for companies that does some simple assembly function to a semi or fully finished products. One example would be combining of various IT component into one unique model.
			</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td align="left" nowrap="nowrap">
            1. Motor Vehicle Part <br />
            2. Lighting Trading firm<br />
            3. Computer parts trading company<br />
            4. Piping and connectors<br />
			</td>
            
		  	<td align="center"><input name="manufacturing" type="checkbox" value="1" <cfif manufacturing eq '1'>checked</cfif>></td>
		</tr>
        <tr>
        <td colspan="100%"><hr /></td>
        </tr>
         <tr title="Enables all the batch code module. If this option is not tick, the batch code module wont show."> 
		  	<td align="left" nowrap="nowrap">Batch Code Module
</td>
            <td align="left" width="350">This feature is usually used by companies that deal in food products, medical consumable and related industries. This feature track inventory by the expiry and/or manufacturing date.
			</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td align="left" nowrap="nowrap">
            1. Chemical<br />
            2. Food Products<br />
            3. Medicine<br />
			</td>
		  	<td align="center"><input name="batchcode" type="checkbox" value="1" <cfif batchcode eq '1'>checked</cfif>></td>
		</tr>  
        
<tr>
<tr><td>&nbsp;</td></tr>
<td colspan="100%" align="center">
<!--- <p align="right">
<input type="button" name="skip_this" id="skip_this" value="Skip This" onclick="window.location.href='wizard4.cfm?type=w4'" />
</p> --->
<input type="button" name="back_btn" id="back_btn" value="Back" onclick="window.location.href='wizard2.cfm?type=w2'" />&nbsp;&nbsp;&nbsp;
<input type="button" name="skip_btn" id="skip_btn" value="Skip Wizard Setup" onclick="window.location.href='skipwizard.cfm'" />&nbsp;&nbsp;&nbsp;
<input type="submit" name="sub_btn" id="sub_btn" value="Next" />
</td>
</tr>
</table>

</cfform>
</cfoutput>
