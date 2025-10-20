<cfset frgrade=11>
<cfset tograde=310>
<html>
<head>
<title>Graded Item Report - Stock Card</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfif form.datefrom neq "" and form.dateto neq "">
	<cfset date1 = createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
	<cfset date2 = createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
</cfif>
<cfquery name="getgeneral" datasource="#dts#">
	select compro from gsetup
</cfquery>

<cfquery name="getiteminfo" datasource="#dts#">
	select 
	<cfloop from="#frgrade#" to="#tograde#" index="i">
		(ifnull(e.qin#i#,0)) as qin#i#,
		(ifnull(f.qout#i#,0)) as qout#i#,
		(ifnull(a.grd#i#,0)+ifnull(c.getlastin#i#,0)-ifnull(d.getlastout#i#,0)) as qtybf#i#,
		(ifnull(a.grd#i#,0)+ifnull(c.getlastin#i#,0)-ifnull(d.getlastout#i#,0)+ifnull(e.qin#i#,0)-ifnull(f.qout#i#,0)) as balance#i#,
	</cfloop>
	b.*
			
	from itemgrd as a 
			
	left join
	(
		select x.itemno,x.unit,x.desp as itemdesp,x.wos_group,x.category,x.graded,y.desp as groupdesp
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			,y.gradd#i#
		</cfloop>
		from icitem x,icgroup y
		where x.wos_group = y.wos_group
		and
			(y.gradd#tograde# <> ''
			<cfloop from="#frgrade#" to="#tograde-1#" index="i">
				or y.gradd#i# <> ''
			</cfloop>)
	) as b on a.itemno = b.itemno
	
	left join
	(
		select  
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			sum(grd#i# * factor1 / factor2) as getlastin#i#,
		</cfloop>
		itemno
		from igrade
		where type in ('RC','CN','OAI','TRIN')
		and fperiod<>'99' 
		and fperiod+0 < '#form.periodfrom#' 
		and (void = '' or void is null)  
		and factor2 > 0
		<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date < #date1#
		</cfif>
		group by itemno
	) as c on a.itemno = c.itemno
	
	left join
	(
		select  
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			sum(grd#i# * factor1 / factor2) as getlastout#i#,
		</cfloop>
		itemno
		from igrade 
		where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
		and fperiod<>'99' 
		and fperiod+0 < '#form.periodfrom#' 
		and (void = '' or void is null) 
		and generated=''
		and factor2 > 0 
		<cfif form.datefrom neq "" and form.dateto neq "">
			and wos_date < #date1#
		</cfif>
		group by itemno
	) as d on a.itemno=d.itemno
						
	left join
	(
		select  
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			sum(grd#i# * factor1 / factor2) as qin#i#,
		</cfloop>
		itemno
		from igrade
		where type in ('RC','CN','OAI','TRIN')
		and fperiod<>'99' 
		and (void = '' or void is null)  
		and factor2 > 0
		<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
   		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
    		and wos_date between #date1# and #date2#
    	</cfif> 
		group by itemno
	) as e on a.itemno = e.itemno
			
	left join
	(
		select  
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			sum(grd#i# * factor1 / factor2) as qout#i#,
		</cfloop>
		itemno
		from igrade 
		where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
		and fperiod<>'99' 
		and (void = '' or void is null) 
		and generated=''
		and factor2 > 0 
   		<cfif form.periodfrom neq "" and form.periodto neq "">
			and fperiod+0 between '#form.periodfrom#' and '#form.periodto#'
   		</cfif>
		<cfif form.datefrom neq "" and form.dateto neq "">
    		and wos_date between #date1# and #date2#
    	</cfif> 
		group by itemno
	) as f on a.itemno=f.itemno
		
	where b.graded = 'Y'
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and b.category between '#form.catefrom#' and '#form.cateto#'
	</cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and b.itemno between '#form.itemfrom#' and '#form.itemto#'
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and b.wos_group between '#form.groupfrom#' and '#form.groupto#'
	</cfif>
	order by b.wos_group,b.itemno
</cfquery>
<!--- <cfdump var="#getiteminfo#"><cfabort> --->
<body>
<table width="80%" border="0" align="center" cellspacing="0">
	<cfoutput>
	<tr>
		<td colspan="100%">
			<div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>GRADED ITEM STOCK CARD SUMMARY</strong></font></div>
		</td>
	</tr>
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">CATE: #form.catefrom# - #form.cateto#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">GROUP: #form.groupfrom# - #form.groupto#</font></div></td>
		</tr>
	</cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM.NO. #form.itemfrom# - #form.itemto#</font></div></td>
		</tr>
	</cfif>
	<cfif form.periodfrom neq "" and form.periodto neq "">
      	<tr>
        	<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Period From #periodfrom# To #periodto#</font></div></td>
      	</tr>
    </cfif>
    <cfif form.datefrom neq "" and form.dateto neq "">
      	<tr>
        	<td colspan="9"><div align="center"><font size="2" face="Times New Roman, Times, serif">Date From #dateformat(date1,"dd-mm-yyyy")# To #dateformat(date2,"dd-mm-yyyy")#</font></div></td>
      	</tr>
    </cfif>
	<tr><td height="10"></td></tr>
	<tr>
		<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		<td colspan="4"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd-mm-yyyy")#</font></div></td>
	</tr>
	</cfoutput>
	<tr><td height="5"></td></tr>
	<tr>
    	<td style="border-top:1px solid black;border-bottom:1px solid black;" height="24" width="15%"><div align="center"><font size="2" face="Times New Roman, Times, serif">ITEM NO.</font></div></td>
		<td style="border-top:1px solid black;border-bottom:1px solid black;" width="*"><div align="center"><font size="2" face="Times New Roman, Times, serif">DESP</font></div></td>
    	<td style="border-top:1px solid black;border-bottom:1px solid black;" width="15%"><div align="center"><font size="2" face="Times New Roman, Times, serif">GRADE</font></div></td>
    	<td style="border-top:1px solid black;border-bottom:1px solid black;" width="10%"><div align="center"><font size="2" face="Times New Roman, Times, serif">QTY B/F </font></div></td>
    	<td style="border-top:1px solid black;border-bottom:1px solid black;" width="10%"><div align="center"><font size="2" face="Times New Roman, Times, serif">IN</font></div></td>
    	<td style="border-top:1px solid black;border-bottom:1px solid black;" width="10%"><div align="center"><font size="2" face="Times New Roman, Times, serif">OUT</font></div></td>
   	 	<td style="border-top:1px solid black;border-bottom:1px solid black;" width="10%"><div align="center"><font size="2" face="Times New Roman, Times, serif">BALANCE</font></div></td>
		<td style="border-top:1px solid black;border-bottom:1px solid black;" width="10%"><div align="center"><font size="2" face="Times New Roman, Times, serif">ACTION</font></div></td>
  	</tr>
	<tr><td height="5"></td></tr>
	<cfoutput query="getiteminfo">
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			<cfif getiteminfo["gradd#i#"][getiteminfo.currentrow] neq "">
				<cfif isdefined("form.include_stock")>	<!--- Include 0 qty --->
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
						<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getiteminfo.itemno#</font></div></td>
						<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getiteminfo.itemdesp#</font></div></td>
						<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["gradd#i#"][getiteminfo.currentrow]#</font></div></td>
						<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["qtybf#i#"][getiteminfo.currentrow]#</font></div></td>
						<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["qin#i#"][getiteminfo.currentrow]#</font></div></td>
						<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["qout#i#"][getiteminfo.currentrow]#</font></div></td>
						<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["balance#i#"][getiteminfo.currentrow]# #getiteminfo.unit#</font></div></td>
						<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">
							<a href="gradedstockcard2.cfm?itemno=#urlencodedformat(getiteminfo.itemno)#&itemdesp=#urlencodedformat(getiteminfo.itemdesp)#&itembal=#getiteminfo["qtybf#i#"][getiteminfo.currentrow]#&pf=#urlencodedformat(form.itemfrom)#&pt=#urlencodedformat(form.itemto)#&cf=#form.catefrom#&ct=#form.cateto#&pef=#form.periodfrom#&pet=#form.periodto#&gpf=#form.groupfrom#&gpt=#form.groupto#&df=#form.datefrom#&dt=#form.dateto#&gradenum=#i#&gradedesp=#getiteminfo["gradd#i#"][getiteminfo.currentrow]#">View Details</a>
						</font></div></td>
					</tr>
				<cfelse>
					<cfif getiteminfo["balance#i#"][getiteminfo.currentrow] neq 0>
						<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
							<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getiteminfo.itemno#</font></div></td>
							<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getiteminfo.itemdesp#</font></div></td>
							<td nowrap><div align="left"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["gradd#i#"][getiteminfo.currentrow]#</font></div></td>
							<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["qtybf#i#"][getiteminfo.currentrow]#</font></div></td>
							<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["qin#i#"][getiteminfo.currentrow]#</font></div></td>
							<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["qout#i#"][getiteminfo.currentrow]#</font></div></td>
							<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">#getiteminfo["balance#i#"][getiteminfo.currentrow]# #getiteminfo.unit#</font></div></td>
							<td nowrap><div align="center"><font size="2" face="Times New Roman, Times, serif">
								<a href="gradedstockcard2.cfm?itemno=#urlencodedformat(getiteminfo.itemno)#&itemdesp=#urlencodedformat(getiteminfo.itemdesp)#&itembal=#getiteminfo["qtybf#i#"][getiteminfo.currentrow]#&pf=#urlencodedformat(form.itemfrom)#&pt=#urlencodedformat(form.itemto)#&cf=#form.catefrom#&ct=#form.cateto#&pef=#form.periodfrom#&pet=#form.periodto#&gpf=#form.groupfrom#&gpt=#form.groupto#&df=#form.datefrom#&dt=#form.dateto#&gradenum=#i#&gradedesp=#getiteminfo["gradd#i#"][getiteminfo.currentrow]#">View Details</a>
							</font></div></td>
						</tr>
					</cfif>
				</cfif>
			</cfif>
		</cfloop>
	</cfoutput>
</table>
</body>
</html>