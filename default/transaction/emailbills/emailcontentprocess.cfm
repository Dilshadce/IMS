<cfset url.BillName = form.billname>
<cfset url.doption = "0">
<cfset url.counter = "1">

<cfif form.billname eq "dfnongstitem" or form.billname eq "dfgstitem" or form.billname eq "dfnormalitem">
<cfset url.tax = "1">
<cfelse>
<cfset url.tax = "2">
</cfif>

<cfif form.billname eq "dfnongstitem" or form.billname eq "dfnongstbill">
<cfset url.gst = "N">
<cfelse>
<cfset url.gst = "Y">
</cfif>

<cfset uuid=createuuid()>

<cfquery name="getuserdetail" datasource="main">
	SELECT emailsignature,useremail FROM users	WHERE 
    userid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#"> and
    userbranch=<cfqueryparam cfsqltype="cf_sql_varchar" value="#dts#">
</cfquery>

<cfif form.billname eq "dfnongstitem" or form.billname eq "dfgstitem" or form.billname eq "dfnongstbill" or form.billname eq "dfgstbill">
<cfset personTemplate = fileRead(expandPath( "/billformat/default/newDefault/MYR/preprintedformat.cfm" )) />

<cfelseif form.billname eq "dfnormalitem" or form.billname eq "dfnormalbill">
<cfset personTemplate = fileRead(expandPath( "/billformat/default/newDefault/preprintedformat.cfm" )) />

<cfelse>
<cfset personTemplate = fileRead(expandPath( "/billformat/#dts#/preprintedformat.cfm" )) />
</cfif>

<cfset personTemplate = replace(
    personTemplate,
    'query="MyQuery"',
    'query="MyQuery" filename="#HRootPath#\billformat\#dts#\#uuid#_#url.nexttranno#.pdf"',
    'all'
    ) /><!---overwrite="yes"--->

<cfset fileWrite(
    expandPath( "/billformat/#dts#/emailformatcust#uuid#.cfm" ),
    personTemplate
    ) />

<cfoutput>
#url.tax#--#url.gst#
</cfoutput>


<cftry>

<cfinclude template="/billformat/#dts#/emailformatcust#uuid#.cfm">

<cfmail from="noreply@mynetiquette.com" to="#form.emailto#" bcc="#form.emailbcc#" cc="#form.emailcc#" replyto="#form.emailreplyto#" subject="#form.emailsubject#" type="html"> 
<cfmailparam file = "#HRootPath#\billformat\#dts#\#uuid#_#url.nexttranno#.pdf" >
<cfmailparam 
        file="#ExpandPath('/images/netiquette.png')#"
        contentid="netiquette" 
        disposition="inline"
        />
<p>
#form.emaildetail#
</p>
<br />
<p>
#getuserdetail.emailsignature#
</p>
<br />

<p></p>
<p style="font-size:14px">
	<b>Powered By</b><br>
    <img src="cid:netiquette" width="180" height="60"/>
</p>
<p style="font-size:11px">
	For More Information About Us Click <a href="http://www.netiquette.asia/">Here</a>
</p>
</cfmail>


<!---<cffile action="delete" file="#HRootPath#\billformat\#dts#\#uuid#_#url.nexttranno#.pdf">--->
<cffile action="delete" file="#HRootPath#\billformat\#dts#\emailformatcust#uuid#.cfm">



<script language="javascript" type="text/javascript">
alert('Email Has Been Send');
ColdFusion.Window.hide('emailcontent');
</script>

<cfcatch>
<script language="javascript" type="text/javascript">
alert('Format error kindly add item!');
ColdFusion.Window.hide('emailcontent');
</script>

</cfcatch></cftry>

<!---







<cfsavecontent variable="PDFhtml">
<cfinclude template="/billformat/#dts#/preprintedformat.cfm">
</cfsavecontent>

<cfdocument format="pdf" filename="#HRootPath#\billformat\#dts#\#url.nexttranno#.pdf" overwrite="Yes">
<cfoutput>
#variables.PDFhtml#
</cfoutput>
</cfdocument>

<cfheader name="Content-Disposition" value="attachment;filename=#url.nexttranno#.pdf">
<cfcontent type="application/octet-stream" file="#HRootPath#\billformat\#dts#\#url.nexttranno#.pdf" >--->