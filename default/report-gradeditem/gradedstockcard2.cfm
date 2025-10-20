<html>
<head>
<title>Graded Item Report - Stock Card Details</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="totalin" default="0">
<cfparam name="totalout" default="0">

<cfif url.df neq "" and url.dt neq "">
	<cfset date1 = createDate(ListGetAt(url.df,3,"/"),ListGetAt(url.df,2,"/"),ListGetAt(url.df,1,"/"))>
	<cfset date2 = createDate(ListGetAt(url.dt,3,"/"),ListGetAt(url.dt,2,"/"),ListGetAt(url.dt,1,"/"))>
</cfif>
<cfquery name="getgeneral" datasource="#dts#">
	select compro,lastaccyear from gsetup
</cfquery>

<cfquery name="getiteminfo" datasource="#dts#">
	select a.type,a.refno,a.wos_date,a.itemno,a.grd#url.gradenum# as qty,b.batchcode,b.importpermit,b.price,b.toinv,
	if(b.type='TROU' or b.type='TRIN','TRANSFER',b.name) as name
	from igrade a,ictran b	
	where a.type = b.type
	and a.refno = b.refno
	and a.itemno = b.itemno
    and a.trancode = b.trancode
	and a.itemno = '#url.itemno#'
	and a.type not in ('QUO','SO','PO','SAM')
	and (a.void = '' or a.void is null) 
	and a.fperiod<>'99'
	and a.grd#url.gradenum# > 0
	<cfif url.pef neq "" and url.pet neq "">
		and a.fperiod between '#url.pef#' and '#url.pet#'
	</cfif>
	<cfif url.df neq "" and url.dt neq "">
		and a.wos_date >= #date1# and a.wos_date <= #date2#
	<cfelse>
		and a.wos_date > #getgeneral.lastaccyear#
	</cfif>
	order by b.wos_date, b.trdatetime
</cfquery>
<!--- <cfdump var="#getiteminfo#"><cfabort> --->
<body>
<table width="80%" border="0" align="center" cellspacing="0">
	<cfoutput>
	<tr>
		<td colspan="100%">
			<div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>GRADED ITEM STOCK CARD DETAILS</strong></font></div>
		</td>
	</tr>
	<cfif trim(url.cf) neq "" and trim(url.ct) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATE: #url.cf# - #url.ct#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(url.gpf) neq "" and trim(url.gpt) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #url.gpf# - #url.gpt#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(url.pf) neq "" and trim(url.pt) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM.NO. #url.pf# - #url.pt#</font></div></td>
		</tr>
	</cfif>
	<cfif url.pef neq "" and url.pet neq "">
      	<tr>
        	<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Period From #url.pef# To #url.pet#</font></div></td>
      	</tr>
    </cfif>
    <cfif url.df neq "" and url.dt neq "">
      	<tr>
        	<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Date From #dateformat(date1,"dd-mm-yyyy")# To #dateformat(date2,"dd-mm-yyyy")#</font></div></td>
      	</tr>
    </cfif>
	<tr><td height="10"></td></tr>
	<tr>
		<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		<td colspan="5"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd-mm-yyyy")#</font></div></td>
	</tr>
	<tr><td height="10"></td></tr>
	<tr>
        <td colspan="5"><font size="2" face="Times New Roman, Times, serif">ITEM NO: #url.itemno# - #url.itemdesp#</font></td>
		<td colspan="4"><div align="right"><font size="2" face="Times New Roman, Times, serif">GRADE: #url.gradedesp#</font></div></td>
    </tr>
	</cfoutput>
	<tr><td height="5"></td></tr>
	<tr>
    	<td style="border-top:1px solid black;border-bottom:1px solid black;" height="24"><div align="center"><font size="2" face="Times New Roman, Times, serif">DATE</font></div></td>
    	<td style="border-top:1px solid black;border-bottom:1px solid black;"><div align="left"><font size="2" face="Times New Roman, Times, serif">REFNO</font></div></td>
    	<td style="border-top:1px solid black;border-bottom:1px solid black;"><div align="left"><font size="2" face="Times New Roman, Times, serif">DESCRIPTION</font></div></td>
        <cfif lcase(hcomid) eq "laihock_i">
        <td style="border-top:1px solid black;border-bottom:1px solid black;"><div align="left"><font size="2" face="Times New Roman, Times, serif">Permit No</font></div></td>
        <td style="border-top:1px solid black;border-bottom:1px solid black;"><div align="left"><font size="2" face="Times New Roman, Times, serif">Permit No 2</font></div></td>
        
        <td style="border-top:1px solid black;border-bottom:1px solid black;"><div align="left"><font size="2" face="Times New Roman, Times, serif">Lot no</font></div></td>
        </cfif>
    	<td style="border-top:1px solid black;border-bottom:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
    	<td style="border-top:1px solid black;border-bottom:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
    	<td style="border-top:1px solid black;border-bottom:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">BALANCE</font></div></td>
    	<td style="border-top:1px solid black;border-bottom:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">COST P.</font></div></td>
    	<td style="border-top:1px solid black;border-bottom:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">SELL P.</font></div></td>
    	<td style="border-top:1px solid black;border-bottom:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">AMOUNT</font></div></td>
  	</tr>
	<tr>
    	<td></td>
    	<td></td>
    	<td><font size="2" face="Times New Roman, Times, serif">Balance B/F:</font></td>
    	<td></td>
   	 	<td></td>
        <cfif lcase(hcomid) eq "laihock_i">
        <td></td><td></td>
        </cfif>
    	<td><font size="2" face="Times New Roman, Times, serif"><div align="right"><cfoutput>#url.itembal#</cfoutput></div></font></td>
    	<td></td>
    	<td></td>
    	<td></td>
  	</tr>
	<cfset itembal = val(url.itembal)>
	<cfoutput query="getiteminfo">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td><div align="center"><font size="2" face="Times New Roman, Times, serif">#dateformat(wos_date,"dd/mm/yy")#</font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman, Times, serif">#type# #refno#</font></div></td>
			<td><font size="2" face="Times New Roman, Times, serif">#name#</font></td>
            <cfif lcase(hcomid) eq "laihock_i">
            <cfquery name="getpermitno" datasource="#dts#">
       		 select permit_no,permit_no2 from obbatch where batchcode='#batchcode#'
            </cfquery>
            <cfquery name="gettran" datasource="#dts#">
       		 select rem6 from artran where refno='#getiteminfo.refno#' and type='#getiteminfo.type#'

            </cfquery>
            <td><font size="2" face="Times New Roman, Times, serif">#getpermitno.permit_no#</font></td>
            <cfif lcase(hcomid) eq "laihock_i">
            <td><font size="2" face="Times New Roman, Times, serif">#gettran.rem6#</font></td>
            <cfelse>
            <font size="2" face="Times New Roman, Times, serif">#getpermitno.permit_no2#</font>
            </cfif>
            <td><font size="2" face="Times New Roman, Times, serif">#batchcode#</font></td>
            </cfif>
			<td>
				<cfif type eq "RC" or type eq "CN" or type eq "OAI" or type eq "TRIN">
          			<cfset itembal = itembal + qty>
          			<cfset totalin = totalin + qty>
         			<font size="2" face="Times New Roman, Times, serif"><div align="right">#qty#</div></font>
				</cfif>
			</td>
			<td>
				<cfif type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU">
          			<cfif type eq "DO" and toinv neq "">
            			<font size="2" face="Times New Roman, Times, serif"><div align="right">INV #toinv#</div></font>
					<cfelse>
            			<cfset itembal = itembal - qty>
            			<cfset totalout = totalout + qty>
            			<font size="2" face="Times New Roman, Times, serif"><div align="right">#qty#</div></font>
          			</cfif>
        		</cfif>
			</td>
      		<td>
				<cfif type eq "DO" and toinv neq "">
          		<cfelse>
          			<font size="2" face="Times New Roman, Times, serif"><div align="right">#itembal#</div></font>
          		</cfif>
			</td>
      		<td>
				<cfif type eq "RC" or type eq "CN" or type eq "OAI" or type eq "TRIN">
          			<div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(price,",.____")#</font> </div>
        		</cfif>
			</td>
      		<td>
				<cfif type eq "INV" or type eq "DO" or type eq "DN" or type eq "CS" or type eq "PR" or type eq "ISS" or type eq "OAR" or type eq "TROU">
         	 		<font size="2" face="Times New Roman, Times, serif"><div align="right">#numberformat(price,",.____")#</div></font>
          		</cfif>
			</td>
			<cfset amt = val(qty) * val(price)>
      		<td><font size="2" face="Times New Roman, Times, serif"><div align="right">#numberformat(amt,",.__")#</div></font></td>
		</tr>
	</cfoutput>
	<tr><td height="5" colspan="100%"></td></tr>
	<cfoutput>
		<tr>
        <cfif lcase(hcomid) eq "laihock_i">
			<td colspan="6" style="border-top:1px solid black;"><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong>Total:</strong></div></font></td>
			<cfelse>
            <td colspan="3" style="border-top:1px solid black;"><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong>Total:</strong></div></font></td>
            </cfif>
			<td style="border-top:1px solid black;"><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong>#totalin#</strong></div></font></td>
      		<td style="border-top:1px solid black;"><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong>#totalout#</strong></div></font></td>
      		<td style="border-top:1px solid black;"><font size="2" face="Times New Roman, Times, serif"><div align="right"><strong>#itembal#</strong></div></font></td>
      		<td colspan="6" style="border-top:1px solid black;">&nbsp;</td>
		</tr>
	</cfoutput>
</table>
</body>
</html>