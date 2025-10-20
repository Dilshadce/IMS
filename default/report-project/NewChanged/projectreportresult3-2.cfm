<html>
<head>
<title>PRODUCT ISSUE REPORT DETAILS</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<!--- Add On 28-01-2010 --->
<cfquery name="getdealer_menu" datasource="#dts#">
	select include_SO_PO_stockcard from dealer_menu limit 1
</cfquery>

<cfparam name="totalqty" default="0">
<cfparam name="totalamt" default="0">

<cfif df neq "" and dt neq "">
	<cfset dd=dateformat(df,"DD")>

	<cfif dd greater than "12">
		<cfset ndatefrom=dateformat(df,"YYYYMMDD")>
	<cfelse>
		<cfset ndatefrom=dateformat(df,"YYYYDDMM")>
	</cfif>

	<cfset dd=dateformat(dt,"DD")>

	<cfif dd greater than "12">
		<cfset ndateto=dateformat(dt,"YYYYMMDD")>
	<cfelse>
		<cfset ndateto=dateformat(dt,"YYYYDDMM")>
	</cfif>
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select 
	compro,cost,
	lastaccyear,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,lproject
	from gsetup;
</cfquery>

	
		<cfquery name="getictran" datasource="#dts#">
		select * from ictran where type = 'ISS' and itemno='#url.itemno#' and source = '#url.project#'
        <cfif trim(url.jobfrom) neq "" and trim(url.jobto) neq "">
        and job between '#url.jobfrom#' and '#url.jobto#'
        </cfif>
        <cfif cf neq "" and ct neq "">
        and category between '#url.cf#' and '#url.ct#'
        </cfif>
        <cfif gpf neq "" and gpt neq "">
        and wos_group between '#url.gpf#' and '#url.gpt#'
        </cfif>
        <cfif pef neq "" and pet neq "">
        and fperiod between '#url.pef#' and '#url.pet#'
        </cfif>
        <cfif df neq "" and dt neq "">
        and wos_date between '#url.df#' and '#url.dt#'
        </cfif>
        order by trdatetime
		</cfquery>

<body>
<p align="center"><font color="#000000" size="4" face="Times New Roman, Times, serif"><strong>PRODUCT ISSUE REPORT DETAILS</strong></font></p>

<table width="100%" border="0" align="center" cellspacing="0">
<cfoutput>
<cfif url.project neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lPROJECT#  #url.project#</font></div></td>
		</tr>
	</cfif>
    
<cfif trim(url.jobfrom) neq "" and trim(url.jobto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">Job From #url.jobfrom# To #url.jobto#</font></div></td>
		</tr>
	</cfif>

	<cfif cf neq "" and ct neq "">
		<tr>
        	<td colspan="9" align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lCATEGORY# From #cf# To #ct#</font></td>
      	</tr>
    </cfif>
    <cfif gpf neq "" and gpt neq "">
      	<tr>
        	<td colspan="9" align="center"><font size="2" face="Times New Roman, Times, serif">#getgeneral.lGROUP# From #gpf# To #gpt#</font></td>
		</tr>
    </cfif>
    
    <cfif pef neq "" and pet neq "">
      	<tr>
        	<td colspan="9" align="center"><font size="2" face="Times New Roman, Times, serif">Period From #pef# To #pet#</font></td>
      	</tr>
    </cfif>
    <cfif df neq "" and dt neq "">
      	<tr>
        	<td colspan="9" align="center"><font size="2" face="Times New Roman, Times, serif">Date From #df# To #dt#</font></td>
      	</tr>
    </cfif>

    <tr>
      	<td colspan="5"><cfif getgeneral.compro neq ""><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></cfif></td>
		<td colspan="2"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd/mm/yyyy")#</font></div></td>
    </tr>
	<tr>
        <td colspan="9"><font size="2" face="Times New Roman, Times, serif">ITEM NO: #itemno# - #getictran.desp#</font></td>
    </tr>
	<tr>
    	<td colspan="12"><hr></td>
  	</tr>
  	<tr>
    	<td><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE</font></div></td>
    	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">REFNO</font></div></td>
    	<td><div align="left"><font size="2" face="Times New Roman, Times, serif">DESCRIPTION</font></div></td>
    	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">QTY</font></div></td>
    	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">PRICE</font></div></td>
    	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">AMOUNT</font></div></td>
  	</tr>
  	<tr>
    	<td colspan="12"><hr></td>
  	</tr>
  	
  <cfloop query="getictran">

    	<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
      		<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#dateformat(wos_date,"dd/mm/yy")#</font></div></td>
      		<td>
				<div align="left"><font size="2" face="Times New Roman, Times, serif">#refno#</font></div>
			</td>
      		<td><font size="2" face="Times New Roman, Times, serif">#name#</font></td>
            <td><font size="2" face="Times New Roman, Times, serif"><div align="right">#qty#</div></font></td>
            <td><font size="2" face="Times New Roman, Times, serif"><div align="right">#lsnumberformat(price,',_.__')#</div></font></td>
           <td><font size="2" face="Times New Roman, Times, serif"><div align="right">#lsnumberformat(amt,',_.__')#</div></font></td>
            <cfset totalqty=totalqty+qty>
            <cfset totalamt=totalamt+amt>
      		
  	</cfloop>
	<tr>
    	<td colspan="9"><hr></td>
  	</tr>
    <tr>
      	<td></td>
      	<td></td>
      	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong>Total:</strong></div></font></td>
      	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong>#totalqty#</strong></div></font></td>
      	<td></td>
      	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong>#lsnumberformat(totalamt,',_.__')#</strong></div></font></td>

    </tr>
  	</cfoutput>
</table>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
<p class="noprint"><font size="2">Please print in Landscape format. Go to File - Page Setup, select "Landscape".</font></p>
</body>
</html>