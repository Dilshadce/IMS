<cfset frgrade=11>
<cfset tograde=310>
<html>
<head>
<title>Graded Item Physical Worksheet Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select compro from gsetup
</cfquery>
<cfif form.date neq "">
	<cfset date1 = createDate(ListGetAt(form.date,3,"/"),ListGetAt(form.date,2,"/"),ListGetAt(form.date,1,"/"))>
<cfelse>
	<cfset date1 = now()>
</cfif>
<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#date1#" returnvariable="cperiod"/>
<cfif cperiod neq form.period>
	<cfset form.period = cperiod>
</cfif>

<cfquery name="getiteminfo" datasource="#dts#">
	select 
	<cfloop from="#frgrade#" to="#tograde#" index="i">
		(ifnull(a.grd#i#,0)+ifnull(c.qin#i#,0)-ifnull(d.qout#i#,0)) as qty#i#,
		(ifnull(a.cgrd#i#,0)) as qtyactual#i#,
	</cfloop>
	a.location,b.*,(select desp from iclocation where location=a.location) as locdesp
			
	from logrdob as a 
			
	left join
	(
		select x.itemno,x.desp as itemdesp,x.wos_group,x.category,x.graded,x.shelf,y.desp as groupdesp
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
			sum(grd#i# * factor1 / factor2) as qin#i#,
		</cfloop>
		itemno,location
		from igrade
		where type in ('RC','CN','OAI','TRIN')
		and fperiod<>'99' 
		and (void = '' or void is null)  
		and factor2 > 0
		<cfif form.period neq "">
			and fperiod <='#form.period#'
		</cfif> 
		<cfif form.date neq "">
			and wos_date <= #date1# 
		</cfif>
		group by itemno,location
	) as c on (a.itemno=c.itemno and a.location=c.location)
			
	left join
	(
		select  
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			sum(grd#i# * factor1 / factor2) as qout#i#,
		</cfloop>
		itemno,location
		from igrade 
		where type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
		and fperiod<>'99' 
		and (void = '' or void is null) 
		and generated=''
		and factor2 > 0 
   		<cfif form.period neq "">
			and fperiod <='#form.period#'
		</cfif> 
		<cfif form.date neq "">
			and wos_date <= #date1# 
		</cfif>
		group by itemno,location
	) as d on (a.itemno=d.itemno and a.location=d.location)
		
	where b.graded = 'Y'
	<cfif trim(form.catefrom) neq "" and trim(form.cateto) neq "">
		and b.category between '#form.catefrom#' and '#form.cateto#'
	</cfif>
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and b.itemno between '#form.itemfrom#' and '#form.itemto#'
	</cfif>
    <cfif isdefined('form.tranitemonly')>
    and b.itemno in (select itemno from ictran where 0=0
    <cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and itemno between '#form.itemfrom#' and '#form.itemto#'
	</cfif>
    <cfif trim(form.locfrom) neq "" and trim(form.locto) neq "">
		and location between '#form.locfrom#' and '#form.locto#'
	</cfif>
    )
    </cfif>
	<cfif form.shelffrom neq "" and form.shelfto neq "">
		and b.shelf between '#form.shelffrom#' and '#form.shelfto#'
	</cfif>
	<cfif trim(form.groupfrom) neq "" and trim(form.groupto) neq "">
		and b.wos_group between '#form.groupfrom#' and '#form.groupto#'
	</cfif>
	<cfif trim(form.locfrom) neq "" and trim(form.locto) neq "">
		and a.location between '#form.locfrom#' and '#form.locto#'
	</cfif>
	order by a.location,b.itemno
</cfquery>
<!--- <cfdump var="#getiteminfo#"><cfabort> --->
<body>
<table align="center" width="75%" border="0" cellspacing="0">
	<tr>
		<td colspan="100%">
			<div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>LOCATION - GRADED ITEM PHYSICAL WORKSHEET</strong></font></div>
		</td>
	</tr>
	<cfoutput>
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
	<cfif form.period neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">AS AT PERIOD: #form.period#</font></div></td>
		</tr>
	</cfif>
	<tr>
		<td colspan="2"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		<td colspan="3"><div align="right"><font size="2" face="Times New Roman, Times, serif">AS AT DATE: #dateformat(date1,"dd-mm-yyyy")#</font></div></td>
	</tr>
	</cfoutput>
	<tr><td height="5"></td></tr>
	<tr>
		<td style="border-top:1px solid black;border-bottom:1px solid black;" height="24"><div align="left"><font size="2" face="Times New Roman,Times,serif">ITEM NO.</font></div></td>
		<td style="border-top:1px solid black;border-bottom:1px solid black;"><div align="left"><font size="2" face="Times New Roman,Times,serif">GRADE</font></div></td>
		<td style="border-top:1px solid black;border-bottom:1px solid black;" width="80"><div align="center"><font size="2" face="Times New Roman,Times,serif">
			<cfif isdefined("form.with_qty")>BOOK QTY<cfelse>&nbsp;</cfif>
		</font></div></td>
		<td style="border-top:1px solid black;border-bottom:1px solid black;" width="80"><div align="center"><font size="2" face="Times New Roman,Times,serif">
			<cfif isdefined("form.with_qty")>ACTUAL QTY<cfelse>&nbsp;</cfif>
		</font></div></td>
		<td style="border-top:1px solid black;border-bottom:1px solid black;" width="80"><div align="center"><font size="2" face="Times New Roman,Times,serif">
			<cfif isdefined("form.with_qty")>ADJ.QTY<cfelse>&nbsp;</cfif>
		</font></div></td>
	</tr>
	<tr><td height="5"></td></tr>
	<cfset thisloc = "999999999">
	<cfoutput query="getiteminfo">
		<cfif thisloc neq getiteminfo.location>
			<cfset thisloc = getiteminfo.location>
			<tr>
				<td height="21"><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>LOCATION: #getiteminfo.location#</strong></font></div></td>
				<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>#getiteminfo.locdesp#</strong></font></div></td>
			</tr>
		</cfif>
		<tr>
			<td height="21"><div align="left"><font size="2" face="Times New Roman,Times,serif">&nbsp;<u>#getiteminfo.itemno#</u></font></div></td>
			<td><div align="left"><font size="2" face="Times New Roman,Times,serif"><u>#getiteminfo.itemdesp#</u></font></div></td>
		</tr>
		<cfloop from="#frgrade#" to="#tograde#" index="i">
			<cfif isdefined("form.include_stock")>
				<cfif getiteminfo["gradd#i#"][getiteminfo.currentrow] neq "">
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
						<td></td>
						<td style="border-right:1px solid black;border-bottom:1px solid black;"><div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo["gradd#i#"][getiteminfo.currentrow]#</font></div></td>
						<td style="border-right:1px solid black;border-bottom:1px solid black;"><div align="right"><font size="2" face="Times New Roman,Times,serif"><cfif isdefined("form.with_qty")>#getiteminfo["qty#i#"][getiteminfo.currentrow]#<cfelse>&nbsp;</cfif></font></div></td>
						<td style="border-right:1px solid black;border-bottom:1px solid black;"><div align="right"><font size="2" face="Times New Roman,Times,serif"><cfif isdefined("form.with_qty")>#getiteminfo["qtyactual#i#"][getiteminfo.currentrow]#<cfelse>&nbsp;</cfif></font></div></td>
						<cfif isdefined("form.with_qty")>
							<cfset qtyadj = val(getiteminfo["qty#i#"][getiteminfo.currentrow]) - val(getiteminfo["qtyactual#i#"][getiteminfo.currentrow])>
							<td style="border-right:1px solid black;border-bottom:1px solid black;"><div align="right"><font size="2" face="Times New Roman,Times,serif">#qtyadj#</font></div></td>
						<cfelse>
							<td style="border-right:1px solid black;border-bottom:1px solid black;">&nbsp;</td>
						</cfif>
					</tr>
				</cfif>
			<cfelse>
				<cfif getiteminfo["qty#i#"][getiteminfo.currentrow] neq 0>
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
						<td></td>
						<td style="border-right:1px solid black;border-bottom:1px solid black;"><div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo["gradd#i#"][getiteminfo.currentrow]#</font></div></td>
						<td style="border-right:1px solid black;border-bottom:1px solid black;"><div align="right"><font size="2" face="Times New Roman,Times,serif"><cfif isdefined("form.with_qty")>#getiteminfo["qty#i#"][getiteminfo.currentrow]#<cfelse>&nbsp;</cfif></font></div></td>
						<td style="border-right:1px solid black;border-bottom:1px solid black;"><div align="right"><font size="2" face="Times New Roman,Times,serif"><cfif isdefined("form.with_qty")>#getiteminfo["qtyactual#i#"][getiteminfo.currentrow]#<cfelse>&nbsp;</cfif></font></div></td>
						<cfif isdefined("form.with_qty")>
							<cfset qtyadj = val(getiteminfo["qty#i#"][getiteminfo.currentrow]) - val(getiteminfo["qtyactual#i#"][getiteminfo.currentrow])>
							<td style="border-right:1px solid black;border-bottom:1px solid black;"><div align="right"><font size="2" face="Times New Roman,Times,serif">#qtyadj#</font></div></td>
						<cfelse>
							<td style="border-right:1px solid black;border-bottom:1px solid black;">&nbsp;</td>
						</cfif>
					</tr>
				</cfif>
			</cfif>
		</cfloop>
		<tr><td height="10"></td></tr>
	</cfoutput>
</table>
</body>
</html>