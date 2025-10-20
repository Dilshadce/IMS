<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfquery name="getgeneral" datasource="#dts#">
	select invoicedatafile from gsetup
</cfquery>
<cfset datetimenow = now() >
<cfset datenow = dateformat(datetimenow,'yyyymmdd')>
<cfset timenow = timeformat(datetimenow,'HHMMSS')>
<cfoutput>
<cfif form.msg eq "success">
<cftry>
<cffile action = "copy" source = "#HRootPath#\eInvoicing\#dts#\iv3600#getgeneral.invoicedatafile#.dat" destination = "#HRootPath#\eInvoicing\#dts#\history\">

<cffile action = "rename"
   source = "#HRootPath#\eInvoicing\#dts#\history\iv3600#getgeneral.invoicedatafile#.dat"    destination = "#HRootPath#\eInvoicing\#dts#\history\iv3600#getgeneral.invoicedatafile##datenow##timenow#.dat">
<cfcatch>

</cfcatch></cftry>   
   
<cfloop list="#form.invoicelist#" index="i">
<cfquery name="updateinvoice" datasource="#dts#">
update artran set 
eInvoice_Submited = "Y",
Submited_on = #datetimenow#
WHERE
refno = "#i#" and type = "INV"
</cfquery>

</cfloop>

<cfloop list="#form.attachedbill#" index="i">
<cftry>
<cffile action = "copy" source = "#HRootPath#\eInvoicing\#dts#\bill\#i#.pdf" destination = "#HRootPath#\eInvoicing\#dts#\history\">

<cffile action = "rename"
   source = "#HRootPath#\eInvoicing\#dts#\history\#i#.pdf"    destination = "#HRootPath#\eInvoicing\#dts#\history\#i##datenow##timenow#.pdf">
   <cfcatch>

</cfcatch></cftry>   
</cfloop>

<h1 align="center">eInvoice Submission is Successful</h1>

<cfquery name="saveRecords" datasource="#dts#">
Insert into eInvoiceLog (logdatetime,historylogname,status,submitedby<cfif isdefined('form.attachedbill')>,invoicelist</cfif>)
VALUES(now(),"iv3600#getgeneral.invoicedatafile##datenow##timenow#.dat","Success","#HUserName#"<cfif isdefined('form.attachedbill')>,"#form.attachedbill#"</cfif>)
</cfquery>

<cfelse>
<h2 align="center">eInvoice Submission is fail</h2>
<cfquery name="saveRecords" datasource="#dts#">
Insert into eInvoiceLog (logdatetime,historylogname,status,submitedby,invoicelist)
VALUES(now(),"iv3600#getgeneral.invoicedatafile##datenow##timenow#.dat","Fail","#HUserName#","#form.msg#")
</cfquery>
<p>Error: #form.msg#</p>
</cfif>
</cfoutput>