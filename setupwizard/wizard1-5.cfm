
<link href="/stylesheet/stylesheetsetupwizard.css" rel="stylesheet" type="text/css">
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
<div align="center">
<img src="/login/imslogo2.png" alt="Inventory Management System">
</div>
<div align="Center"><h3>*Below is a <strong>6 step</strong> simple wizard to help you set up your Inventory Management System</h3></div>
<br />
<div align="center">

<table width="80%" align="center" cellpadding="0" cellspacing="0" style="font-family: Ubuntu, Helvetica, sans-serif;
	font-size: 16px;
	color: ##FFFFFF;
	border: ##eff8ff;
	line-height: 30px;
	font-style: normal; 
	letter-spacing: 1px;     
	text-align: center;
	background-color:##00abcc;" class="a">

<tr>
<th style="font-family: Ubuntu, Helvetica, sans-serif;
	font-size: 16px;
	color: ##FFFFFF;
	line-height: 30px;
	font-style: normal; 
	letter-spacing: 1px;     
	text-align: center;
	background-color:##F93; border-color:##00abcc">
<div align="center">
<font color="##FFFFFF">Company Profile</font>
</div>
</th>
<th nowrap="nowrap" style="font-family: Ubuntu, Helvetica, sans-serif;
	font-size: 16px;
	color: ##FFFFFF;
	line-height: 30px;
	font-style: normal; 
	letter-spacing: 1px;     
	text-align: center;
	background-color:##00abcc; border-color:##00abcc">>>></th>
    
<th style="font-family: Ubuntu, Helvetica, sans-serif;
	font-size: 16px;
	color: ##FFFFFF;
	line-height: 30px;
	font-style: normal; 
	letter-spacing: 1px;     
	text-align: center;
	background-color:##00abcc; border-color:##00abcc"><font color="##FFFFFF">Module</font></th>
    
<th nowrap="nowrap" style="font-family: Ubuntu, Helvetica, sans-serif;
	font-size: 16px;
	color: ##FFFFFF;
	line-height: 30px;
	font-style: normal; 
	letter-spacing: 1px;     
	text-align: center;
	background-color:##00abcc; border-color:##00abcc">>>></th>
<th style="font-family: Ubuntu, Helvetica, sans-serif;
	font-size: 16px;
	color: ##FFFFFF;
	line-height: 30px;
	font-style: normal; 
	letter-spacing: 1px;     
	text-align: center;
	background-color:##00abcc; border-color:##00abcc"><font color="##FFFFFF">Transaction & stock Control</font></th>
<th nowrap="nowrap" style="font-family: Ubuntu, Helvetica, sans-serif;
	font-size: 16px;
	color: ##FFFFFF;
	line-height: 30px;
	font-style: normal; 
	letter-spacing: 1px;     
	text-align: center;
	background-color:##00abcc; border-color:##00abcc">>>></th>
<th style="font-family: Ubuntu, Helvetica, sans-serif;
	font-size: 16px;
	color: ##FFFFFF;
	line-height: 30px;
	font-style: normal; 
	letter-spacing: 1px;     
	text-align: center;
	background-color:##00abcc; border-color:##00abcc"><font color="##FFFFFF">Import Master File</font></th>
<th nowrap="nowrap" style="font-family: Ubuntu, Helvetica, sans-serif;
	font-size: 16px;
	color: ##FFFFFF;
	line-height: 30px;
	font-style: normal; 
	letter-spacing: 1px;     
	text-align: center;
	background-color:##00abcc; border-color:##00abcc">>>></th>
<th style="font-family: Ubuntu, Helvetica, sans-serif;
	font-size: 16px;
	color: ##FFFFFF;
	line-height: 30px;
	font-style: normal; 
	letter-spacing: 1px;     
	text-align: center;
	background-color:##00abcc; border-color:##00abcc"><font color="##FFFFFF">User Setup</font></th>
<th nowrap="nowrap" style="font-family: Ubuntu, Helvetica, sans-serif;
	font-size: 16px;
	color: ##FFFFFF;
	line-height: 30px;
	font-style: normal; 
	letter-spacing: 1px;     
	text-align: center;
	background-color:##00abcc; border-color:##00abcc">>>></th>
<th style="font-family: Ubuntu, Helvetica, sans-serif;
	font-size: 16px;
	color: ##FFFFFF;
	line-height: 30px;
	font-style: normal; 
	letter-spacing: 1px;     
	text-align: center;
	background-color:##00abcc; border-color:##00abcc"><font color="##FFFFFF">User Define Setup</font></th>

</tr>

</table>


</div>
<br />

<!--- style="border: 1px solid black ;
border-radius: 10px ;
-moz-border-radius: 10px ;
-webkit-border-radius: 10px ;"--->
<div align="center">
<font size="+5" style="vertical-align:middle"><strong>Company Logo/Bill Format</strong></font></td>
</div>

<form name="upload_picture" action="company_image.cfm" method="post" enctype="multipart/form-data" target="_blank">
	<table class="data" align="center" width="779">
		<tr>
        	<th height='20' colspan='8'><div align='center'><strong>Upload Company Logo</strong></div></th>
      	</tr>
        <tr>
        <td><h3>*The Maximum Size For Logo is 200kb
        <br />*If You Are Choosing Format 1/Format 2 The recommanded size will be at least 10px width x 10px Height<br />*If You Are Choosing Format 3 The recommanded size will be at least 15px width x 10px Height
        </h3></td>
        <tr>
        <tr><td><div id="companylogo" align="center"><img src="/billformat/#dts#/logo.jpg"></div></td></tr>
		<tr>
			<td align="center">
				<input type="file" name="formatlogo" id="formatlogo" size="50" accept="image/gif,image/jpeg,image/tiff,image/x-ms-bmp,image/x-photo-cd,image/x-png,image/x-portable-greymap,image/x-portable-pixmap,image/x-portablebitmap">
				<br/>
				<input type="submit" name="Upload" value="Upload">
			</td>
		</tr>
	</table>
</form>

<cfform name="wizard1form" id="wizard1form" method="post" action="wizard2.cfm">
<table align="center"  class="data" width="779">
<tr><th><div align="center">Format</div></th></tr>
<tr>

<td align="center">
<input type="radio" name="formattype" id="formattype" value="1" checked="checked" /> Format 1 &nbsp;&nbsp;&nbsp; <a href="javascript:void(0)" onclick="window.open('/billformat/general/format1.pdf')">Preview</a>
<td>
</tr>
<tr>

<td align="center">
<input type="radio" name="formattype" id="formattype" value="2" /> Format 2 &nbsp;&nbsp;&nbsp; <a href="javascript:void(0)" onclick="window.open('/billformat/general/format2.pdf')">Preview</a>
<td>
</tr>
<tr>

<td align="center">
<input type="radio" name="formattype" id="formattype" value="3" /> Format 3 &nbsp;&nbsp;&nbsp; <a href="javascript:void(0)" onclick="window.open('/billformat/general/format3.pdf')">Preview</a>
<td>
</tr>
<tr>
<tr><td>&nbsp;</td></tr>
<td colspan="2" align="center">
<input type="button" name="back_btn" id="back_btn" value="Back" onclick="window.location.href='wizard1.cfm'" />&nbsp;&nbsp;&nbsp;
<input type="button" name="skip_btn" id="skip_btn" value="Skip Wizard Setup" onclick="window.location.href='skipwizard.cfm'" />&nbsp;&nbsp;&nbsp;
<input type="submit" name="sub_btn" id="sub_btn" value="Next" />
</td>
</tr>
</table>

</cfform>
</cfoutput>
