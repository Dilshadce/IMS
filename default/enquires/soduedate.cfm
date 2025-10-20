<cfif getpin2.h4G00 eq "T">
<script language="JavaScript"> 
var popup="Sorry, right-click is disabled.";
 function noway(go) { if 
(document.all) { if (event.button == 2) { alert(popup); return false; } } if (document.layers) 
{ if (go.which == 3) { alert(popup); return false; } } } if (document.layers) 
{ document.captureEvents(Event.MOUSEDOWN); } document.onmousedown=noway;
</script>
</cfif>

<cfquery name="getdisplaydetail" datasource="#dts#">
select * from displaysetup
</cfquery>

<html>
<head>
<title>Billing Date Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select 
	cost,
	compro,
	lastaccyear,
    singlelocation
	from gsetup;
</cfquery>

<cfset todaydate=dateformat(now(),'DD/MM/YYYY')>
<cfquery name="getso" datasource="#dts#">
	select * from artran where type='SO' and (rem45 ='#todaydate#' or rem46 ='#todaydate#' or rem47 ='#todaydate#' or rem48 ='#todaydate#' or rem49 ='#todaydate#')
</cfquery>

<body <cfif getpin2.h4G00 eq "T">onBeforePrint="document.body.style.display = 'none';" onAfterPrint="document.body.style.display = '';"</cfif>>

<table align="center" border="0" width="100%">
	<tr>
		<td colspan="8"><div align="center"><font size="3" face="Times New Roman,Times,serif"><strong>Billing Date Report</strong></font></div></td>
	</tr>
	<cfoutput>

	<tr>
		<td colspan="3"><div align="left"><font size="2" face="Times New Roman,Times,serif">#getgeneral.compro#</font></div></td>
    	<td colspan="5"><div align="right"><font size="2" face="Times New Roman,Times,serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
	</tr>
	<tr>
		<td colspan="8"><hr></td>
	</tr>
	<tr>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">SO No</font></div></td>
		<td><div align="left"><font size="2" face="Times New Roman,Times,serif">SO Date</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">Customer Name</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">Quotation No</font></div></td>
    </tr>
	<tr>
      	<td colspan="8"><hr></td>
    </tr>
	<cfloop query="getso">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getso.refno#</font></div></td>

        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">#dateformat(getso.wos_date,'DD/MM/YYYY')#</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getso.name#</font></div></td>
        <td><div align="left"><font size="2" face="Times New Roman,Times,serif">#getso.dono#</font></div></td>
       
		</tr>
</cfloop></cfoutput>
		
</table>

<cfif getso.recordcount eq 0>
	<h3>No records were found.</h3>
</cfif>

<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>