<cfset frgrade=11>
<cfset tograde=310>
<cfset numberofgrade=tograde-frgrade+1>
<html>
<head>
<title>Graded Item Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="startgrade" default="1">
<cfparam name="totcol" default="6">
<cfif url.type eq "sales">
	<cfif form.datefrom neq "" and form.dateto neq "">
		<cfset date1 = createDate(ListGetAt(form.datefrom,3,"/"),ListGetAt(form.datefrom,2,"/"),ListGetAt(form.datefrom,1,"/"))>
		<cfset date2 = createDate(ListGetAt(form.dateto,3,"/"),ListGetAt(form.dateto,2,"/"),ListGetAt(form.dateto,1,"/"))>
	</cfif>
</cfif>
<cfif url.type eq "status">
	<cfif form.date neq "">
		<cfset date1 = createDate(ListGetAt(form.date,3,"/"),ListGetAt(form.date,2,"/"),ListGetAt(form.date,1,"/"))>
	</cfif>
</cfif>
<cfquery name="getgeneral" datasource="#dts#">
	select compro from gsetup
</cfquery>
<body>
<cfswitch expression="#url.type#">
	<cfcase value="opening">
		<cfset title = "GRADED ITEM OPENING">
		<cfquery name="getiteminfo" datasource="#dts#">
			select 
			<cfloop from="#startgrade+10#" to="#tograde#" index="i">
				a.grd#i#,
			</cfloop>
			b.*
			
			from itemgrd as a 
			
			left join
			(
				select x.itemno,x.desp as itemdesp,x.wos_group,x.category,x.graded,x.shelf,y.desp as groupdesp
				<cfloop from="#startgrade+10#" to="#tograde#" index="i">
					,y.gradd#i#
				</cfloop>
				from icitem x,icgroup y
				where x.wos_group = y.wos_group
				and
				<cfif startgrade neq numberofgrade>
					(y.gradd#tograde# <> ''
					<cfloop from="#startgrade+10#" to="#tograde-1#" index="i">
						or y.gradd#i# <> ''
					</cfloop>)
				<cfelse>
					y.gradd#tograde# <> ''
				</cfif>
				
			) as b on a.itemno = b.itemno
			
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
		<!--- <cfdump var="#getiteminfo#"> --->
	</cfcase>
	<cfcase value="sales">
		<cfset title = "GRADED ITEM SALES">
		<cfquery name="getiteminfo" datasource="#dts#">
			select 
			<cfloop from="#startgrade+10#" to="#tograde#" index="i">
				(ifnull(c.qout#i#,0)) as grd#i#,
			</cfloop>
			b.*
			
			from itemgrd as a 
			
			left join
			(
				select x.itemno,x.desp as itemdesp,x.wos_group,x.category,x.graded,x.shelf,y.desp as groupdesp
				<cfloop from="#startgrade+10#" to="#tograde#" index="i">
					,y.gradd#i#
				</cfloop>
				from icitem x,icgroup y
				where x.wos_group = y.wos_group
				and
				<cfif startgrade neq numberofgrade>
					(y.gradd#tograde# <> ''
					<cfloop from="#startgrade+10#" to="#tograde-1#" index="i">
						or y.gradd#i# <> ''
					</cfloop>)
				<cfelse>
					y.gradd#tograde# <> ''
				</cfif>
				
			) as b on a.itemno = b.itemno
			
			left join
			(
				select  
				<cfloop from="#startgrade+10#" to="#tograde#" index="i">
					sum(grd#i# * factor1 / factor2) as qout#i#,
				</cfloop>
				itemno
				from igrade 
				where type in ('INV','CS','DN') 
				and fperiod<>'99' 
				and (void = '' or void is null)
				and factor2 > 0 
   				<cfif form.periodfrom neq "" and form.periodto neq "">
					and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#'
				</cfif> 
				<cfif form.datefrom neq "" and form.dateto neq "">
					and wos_date between #date1# and #date2# 
				</cfif>
				group by itemno
			) as c on a.itemno=c.itemno
			
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
		<!--- <cfdump var="#getiteminfo#"> --->
	</cfcase>
	<cfcase value="status">
		<cfset title = "GRADED ITEM STATUS">
		<cfquery name="getiteminfo" datasource="#dts#">
			select 
			<cfloop from="#startgrade+10#" to="#tograde#" index="i">
				(ifnull(a.grd#i#,0)+ifnull(c.qin#i#,0)-ifnull(d.qout#i#,0)) as grd#i#,
			</cfloop>
			b.*
			
			from itemgrd as a 
			
			left join
			(
				select x.itemno,x.desp as itemdesp,x.wos_group,x.category,x.graded,x.shelf,y.desp as groupdesp
				<cfloop from="#startgrade+10#" to="#tograde#" index="i">
					,y.gradd#i#
				</cfloop>
				from icitem x,icgroup y
				where x.wos_group = y.wos_group
				and
				<cfif startgrade neq numberofgrade>
					(y.gradd#tograde# <> ''
					<cfloop from="#startgrade+10#" to="#tograde-1#" index="i">
						or y.gradd#i# <> ''
					</cfloop>)
				<cfelse>
					y.gradd#tograde# <> ''
				</cfif>
				
			) as b on a.itemno = b.itemno
			
			left join
			(
				select  
				<cfloop from="#startgrade+10#" to="#tograde#" index="i">
					sum(grd#i# * factor1 / factor2) as qin#i#,
				</cfloop>
				itemno
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
				group by itemno
			) as c on a.itemno = c.itemno
			
			left join
			(
				select  
				<cfloop from="#startgrade+10#" to="#tograde#" index="i">
					sum(grd#i# * factor1 / factor2) as qout#i#,
				</cfloop>
				itemno
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
				group by itemno
			) as d on a.itemno=d.itemno
			
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
		<!--- <cfdump var="#getiteminfo#"> --->
	</cfcase>
</cfswitch>
<table align="center" width="80%" border="0" cellspacing="0">
	<cfoutput>
	<tr>
		<td colspan="100%">
			<div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>#title#</strong></font></div>
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
	<tr>
		<td colspan="3"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		<cfset columncount = totcol - 3 + 1>
		<td colspan="#columncount#"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd-mm-yyyy")#</font></div></td>
	</tr>
	</cfoutput>
	<tr><td height="5"></td></tr>
	<cfset thisgroup = "">
	
	<cfoutput query="getiteminfo">
		<cfif thisgroup neq getiteminfo.wos_group>
			<cfif thisgroup neq "">
				<tr><td height="10"></td></tr>
			</cfif>
			<cfset thisgroup = getiteminfo.wos_group>
			<cfset thiscurrentrow = getiteminfo.currentrow>
			<cfset count = 0>
			<cfset gradelist = "">
			<cfloop from="#startgrade+10#" to="#tograde#" index="i">
				<cfif getiteminfo["gradd#i#"][getiteminfo.currentrow] neq "">
					<cfif count eq 0>
						<cfset gradelist = i>
					<cfelse>
						<cfset gradelist = gradelist&','&i>
					</cfif>
					<cfset count = count + 1>
				</cfif>
			</cfloop>
			<cfset myArray = ListToArray(gradelist,",")>
			<cfset totalgrade = ArrayLen(myArray)>
			<!--- <cfset totcol = 6> --->
			<cfset totrow = ceiling(totalgrade / totcol)>
			<tr>
				<cfloop from="0" to="#totrow-1#" index="a">
					<cfif a neq 0 and a neq val(totrow-1)>
						</tr>
						<tr>
							<td></td>
					<cfelseif a neq 0 and a eq val(totrow-1)>
						</tr>
						<tr>
							<td style="border-bottom:1px solid black;">&nbsp;</td>
					<cfelseif a eq 0 and a eq val(totrow-1)>
						<td style="border-top:1px solid black;border-bottom:1px solid black;" height="24" width="120px">
							<div align="left"><font size="2" face="Times New Roman,Times,serif">ITEM.NO.</font></div>
						</td>
					<cfelseif a eq 0 and a neq val(totrow-1)>
						<td style="border-top:1px solid black;" height="24" width="120px">
							<div align="left"><font size="2" face="Times New Roman,Times,serif">ITEM.NO.</font></div>
						</td>	
					</cfif>
					
					
					<cfloop from="1" to="#totcol#" index="b">
						<cfset thisrecord = b+(startgrade - 1)+(a*totcol) + 10>
						<cfif ListFindNoCase(gradelist, thisrecord,",") neq 0>
							<cfif a neq 0 and a neq val(totrow-1)>
								<td width="100px" nowrap>
									<div align="center"><font size="2" face="Times New Roman,Times,serif">#getiteminfo["gradd#thisrecord#"][thiscurrentrow]#</font></div>
								</td>
							<cfelseif a eq 0 and a eq val(totrow-1)>
								<td style="border-top:1px solid black;border-bottom:1px solid black;" width="100px" nowrap>
									<div align="center"><font size="2" face="Times New Roman,Times,serif">#getiteminfo["gradd#thisrecord#"][thiscurrentrow]#</font></div>
								</td>
							<cfelseif a eq 0 and a neq val(totrow-1)>
								<td style="border-top:1px solid black;" width="100px" nowrap>
									<div align="center"><font size="2" face="Times New Roman,Times,serif">#getiteminfo["gradd#thisrecord#"][thiscurrentrow]#</font></div>
								</td>
							<cfelseif a neq 0 and a eq val(totrow-1)>
								<td style="border-bottom:1px solid black;" width="100px" nowrap>
									<div align="center"><font size="2" face="Times New Roman,Times,serif">#getiteminfo["gradd#thisrecord#"][thiscurrentrow]#</font></div>
								</td>	
							</cfif>
						<cfelse>
							<cfif a eq 0 and a eq val(totrow-1)>
								<td style="border-top:1px solid black;border-bottom:1px solid black;" width="100px">&nbsp;</td>
							<cfelseif a eq 0 and a neq val(totrow-1)>
								<td style="border-top:1px solid black;" width="100px">&nbsp;</td>
							<cfelseif a neq 0 and a eq val(totrow-1)>
								<td style="border-bottom:1px solid black;" width="100px">&nbsp;</td>
							</cfif>
						</cfif>
					</cfloop>					
				</cfloop>
			</tr>
			
			<tr>
				<td height="24" colspan="100%"><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong><u>GROUP: #getiteminfo.wos_group# - #getiteminfo.groupdesp#</u></strong></font></div></td>
			</tr>
		</cfif>
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<td nowrap>
				<div align="left"><font size="2" face="Times New Roman,Times,serif">#getiteminfo.itemno#</font></div>
			</td>
			<cfloop from="0" to="#totrow-1#" index="a">		
				<cfif a neq 0>
					</tr>
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
						<td></td>
				</cfif>	
				<cfloop from="1" to="#totcol#" index="b">
					<cfset thisrecord = b+(startgrade - 1)+(a*totcol) + 10>
					<cfif ListFindNoCase(gradelist, thisrecord,",") neq 0>
						<td width="100px" nowrap>
							<div align="center"><font size="2" face="Times New Roman,Times,serif">#getiteminfo["grd#thisrecord#"][getiteminfo.currentrow]#</font></div>
						</td>
					<cfelse>
						<td>&nbsp;</td>
					</cfif>
				</cfloop>					
			</cfloop>
		</tr>
	</cfoutput>
	
</table>
<cfif getiteminfo.recordcount eq 0>
	<h3>Sorry, No records were found.</h3>
</cfif>
<br>
<br>
<div align="right"><font size="1" face="Arial, Helvetica, sans-serif"><a href="javascript:print()" class="noprint"><u>Print</u></a></font></div>
</body>
</html>