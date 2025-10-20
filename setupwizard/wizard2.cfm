<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<link href="/stylesheet/jquery-ui.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/scripts/jquery-1.9.1.js"></script>
<script type="text/javascript" src="/scripts/jquery_form.js"></script>
<script type="text/javascript" src="/scripts/jquery-ui.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('#photoimg').on('change', function(e){
		$('#upload_picture').ajaxForm({
			target: '#preview',
			success: function() { 
				$('#loading').css("display", "none");
			} 
		}).submit();
	});
   $("#format1").tooltip(
   		{content: '<img src="/billformat/general/format1.jpg" />'},
		{ position: { my: "left+15 center", at: "right center", collision: "flipfit" }}
	); 
   $("#format2").tooltip(
   		{content: '<img src="/billformat/general/format2.jpg" />'},
		{ position: { my: "left+15 center", at: "right center", collision: "flipfit" }}
	);
   $("#format3").tooltip(
   		{content: '<img src="/billformat/general/format3.jpg" />'},
		{ position: { my: "left+15 center", at: "right center", collision: "flipfit" }}
	);    
	$("#format4").tooltip(
   		{content: '<img src="/billformat/general/format4.jpg" />'},
		{ position: { my: "left+15 center", at: "right center", collision: "flipfit" }}
	);   
	$("#format5").tooltip(
   		{content: '<img src="/billformat/general/format5.jpg" />'},
		{ position: { my: "left+15 center", at: "right center", collision: "flipfit" }}
	);   
});
</script>
<cfquery name="getgsetup" datasource="#dts#">
SELECT * from gsetup
</cfquery>
<cfquery name="getCurrency" datasource="#dts#">
	select * from #target_currency#
	order by CurrCode 
</cfquery>
<cfif isdefined('form.sub_btn')>
<cfset dd = dateformat(form.lastaccyear, "DD")>
	<cfif dd greater than '12'>
		<cfset nDateCreate = dateformat(form.lastaccyear,"YYYYMMDD")>
	<cfelse>
		<cfset nDateCreate = dateformat(form.lastaccyear,"YYYYDDMM")>
	</cfif>	
	<cfif form.period gt 18>
		<cfset xperiod = 18>
	<cfelse>
		<cfset xperiod = form.period>
	</cfif>	
	<cfif Hlinkams eq "Y">
		<cfquery name="SaveGeneralInfo" datasource="#replace(dts,'_i','_a','all')#">
			update gsetup set
			compro='#form.compro#',
			compro2='#form.compro2#',
			compro3='#form.compro3#',
			compro4='#form.compro4#',
			compro5='#form.compro5#',
			compro6='#form.compro6#',
			compro7='#form.compro7#',
			ctycode='#form.bcurr#',
			comuen='#form.comuen#',
			gstno='#form.gstno#'
			where companyid=companyid;
		</cfquery>
	</cfif>	
	<cfquery name="SaveGeneralInfo" datasource="#dts#">
		update gsetup set 
		LastAccYear=#nDateCreate#,
		period='#xperiod#',
		compro='#form.compro#',
		compro2='#form.compro2#',
		compro3='#form.compro3#',
		compro4='#form.compro4#',
		compro5='#form.compro5#',
		compro6='#form.compro6#',
		compro7='#form.compro7#',
		bcurr = '#form.bcurr#',
		comuen='#form.comuen#',
		gstno='#form.gstno#'
		
		where companyid='IMS';
	</cfquery>
</cfif>
<cfoutput>
<div id="content">    
</div>
<cfinclude template="header_wizard.cfm">
<!---
<div align="Center"><h3>*Below is a <strong>6 step</strong> simple wizard to help you set up your Inventory Management System</h3></div>--->
<br />
<div id="content"></div>
<br />
<h1 align="center">Company Logo/Bill Format</h1>   

	<table class="data" align="center" width="779">
		<tr>
        	<th height='20' colspan='8'><div align='center'><strong>Upload Company Logo</strong></div></th>
      	</tr>
        <tr>
        <td><h3>
        A.       The recommended image size of your company logo is 200kb or less in the following format; jpg, gif or png for optimised printing result and application performance.
        <br />
        B.      For bill format 1 & 2, we would suggest that the image size to be set with at least 10px width x 10px height
        <br />
        C.       For bill format 3 to 5, we would suggest that the image size to be set with at least 15px width x 15px height

        
        </h3>		
		</td>
		<tr>
			<td align="center">
				<cfinclude template="/setupwizard/companylogo.cfm">
			</td>
		</tr>
	</table>
<cfform name="wizard1form" id="wizard1form" method="post" action="wizard3.cfm?type=w3">
<table align="center"  class="data" width="779">
<tr><th><div align="center">Format</div></th></tr>
<tr>

<td><h3>
Move your mouse to the "Preview" and have a visual look and view of the proposed bill format.</h3>
</td>
</td>
<tr>

<td align="center">
<input type="radio" name="formattype" id="formattype" value="1" checked="checked" /> Format 1 - Modern Day Business Feel&nbsp;&nbsp;&nbsp; <a id="format1" href="/billformat/general/format1.pdf" target="_blank" title="">Preview</a>
<td>
</tr>
<tr>

<td align="center">
<input type="radio" name="formattype" id="formattype" value="2" /> Format 2 - Visually Rich and Appealing &nbsp;&nbsp;&nbsp; <a id="format2" href="/billformat/general/format2.pdf" target="_blank" title="">Preview</a>
<td>
</tr>
<tr>

<td align="center">
<input type="radio" name="formattype" id="formattype" value="3" /> Format 3 - Professional and Fuss Free Look &nbsp;&nbsp;&nbsp; <a id="format3" href="/billformat/general/format3.pdf" target="_blank" title="">Preview</a>
<td>
</tr>
<tr>

<td align="center">
<input type="radio" name="formattype" id="formattype" value="4" /> Format 4 - Contents Rich Format for Service Based business &nbsp;&nbsp;&nbsp; <a id="format4" href="/billformat/general/format4.pdf" target="_blank" title="">Preview</a>
<td>
</tr>
<tr>

<td align="center">
<input type="radio" name="formattype" id="formattype" value="5" /> Format 5 - Contents Rich Format for Trading Based Business &nbsp;&nbsp;&nbsp; <a id="format5" href="/billformat/general/format5.pdf" target="_blank" title="">Preview</a>
<td>
</tr>
<tr>
<tr><td>&nbsp;</td></tr>
<td colspan="2" align="center">
<!--- <p align="right">
<input type="button" name="skip_this" id="skip_this" value="Skip This" onclick="window.location.href='wizard3.cfm?type=w3'" />
</p> --->
<input type="button" name="back_btn" id="back_btn" value="Back" onclick="window.location.href='wizard1.cfm?type=w1'" />&nbsp;&nbsp;&nbsp;
<input type="button" name="skip_btn" id="skip_btn" value="Skip Wizard Setup" onclick="window.location.href='skipwizard.cfm'" />&nbsp;&nbsp;&nbsp;
<input type="submit" name="sub_btn" id="sub_btn" value="Next" />
</td>
</tr>
</table>
</cfform>
</cfoutput>
