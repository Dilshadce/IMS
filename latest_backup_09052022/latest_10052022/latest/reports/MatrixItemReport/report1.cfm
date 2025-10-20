<html>
<head>
<title>Matrix Item Report</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfparam name="totcol" default="14">
<cfset subtotalsize =0>
<cfset subtotalsize2=0>
<cfset subtotalArray = ArrayNew(1)>

<cfquery name="getgeneral" datasource="#dts#">
	select compro 
    from gsetup
</cfquery>
<body>
	
<cfquery name="getiteminfo" datasource="#dts#">
	select * from icmitem
	<cfif trim(form.matrixItemFrom) neq "" and trim(form.matrixItemTo) neq "">
		where mitemno between '#form.matrixItemFrom#' and '#form.matrixItemTo#'
	</cfif>
	order by mitemno
</cfquery>
<cfswitch expression="#url.type#">
	<cfcase value="opening">
		<cfset title = "MATRIX ITEM OPENING BALANCE">
	</cfcase>
	<cfcase value="sales">
		<cfset title = "MATRIX ITEM SALES REPORT">
	</cfcase>
	<cfcase value="purchase">
		<cfset title = "MATRIX ITEM PURCHASE REPORT">
	</cfcase>
	<cfcase value="stockbalance">
		<cfset title = "MATRIX STOCK BALANCE">
	</cfcase>
</cfswitch>

<table align="center" width="80%" border="0" cellspacing="0" cellpadding="1">
	<cfoutput>
	<tr>
		<td colspan="100%">
			<div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>#title#</strong></font></div>
		</td>
	</tr>
	<cfif trim(form.matrixItemFrom) neq "" and trim(form.matrixItemTo) neq "">
		<tr>
			<td colspan="100%"><div align="center"><font size="2" face="Times New Roman, Times, serif">MATRIX ITEM: #form.matrixItemFrom# - #form.matrixItemTo#</font></div></td>
		</tr>
	</cfif>
	<tr>
		<td colspan="4"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		<cfset columncount = totcol - 4 + 2>
		<td colspan="#columncount#"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd-mm-yyyy")#</font></div></td>
	</tr>
	</cfoutput>
	<tr><td height="5"></td></tr>
	<cfoutput query="getiteminfo">
		<cfset subtotal = 0>
		<cfset totalcolor = 0>
		<tr>
			<td><font size="2" face="Times New Roman, Times, serif"><b>#getiteminfo.mitemno#</b></font></td>
			<td colspan="60%"><font size="2" face="Times New Roman, Times, serif"><b>#getiteminfo.desp#</b></font></td>
		</tr>
		<tr><td height="5"></td></tr>
		<cfset colorlist = "">
		<cfset sizelist = "">
		<cfif getiteminfo.sizecolor eq "C">
			<cfloop from="1" to="20" index="i">
				<cfif getiteminfo["color#i#"][getiteminfo.currentrow] neq "">
					<cfif colorlist eq "">
						<cfset colorlist = getiteminfo["color#i#"][getiteminfo.currentrow]>
					<cfelse>
						<cfset colorlist = colorlist&','&getiteminfo["color#i#"][getiteminfo.currentrow]>
					</cfif>
				</cfif>
			</cfloop>
			<cfset colorArray = ListToArray(colorlist,",")>
		<cfelseif getiteminfo.sizecolor eq "S">
			<cfloop from="1" to="20" index="i">
				<cfif getiteminfo["size#i#"][getiteminfo.currentrow] neq "">
					<cfif sizelist eq "">
						<cfset sizelist = getiteminfo["size#i#"][getiteminfo.currentrow]>
					<cfelse>
						<cfset sizelist = sizelist&','&getiteminfo["size#i#"][getiteminfo.currentrow]>
					</cfif>
				</cfif>
			</cfloop>
			<cfset sizeArray = ListToArray(sizelist,",")>
		<cfelseif getiteminfo.sizecolor eq "SC">
			<cfloop from="1" to="20" index="i">
				<cfif getiteminfo["color#i#"][getiteminfo.currentrow] neq "">
					<cfif colorlist eq "">
						<cfset colorlist = getiteminfo["color#i#"][getiteminfo.currentrow]>
					<cfelse>
						<cfset colorlist = colorlist&','&getiteminfo["color#i#"][getiteminfo.currentrow]>
					</cfif>
				</cfif>
				<cfif getiteminfo["size#i#"][getiteminfo.currentrow] neq "">
					<cfif sizelist eq "">
						<cfset sizelist = getiteminfo["size#i#"][getiteminfo.currentrow]>
					<cfelse>
						<cfset sizelist = sizelist&','&getiteminfo["size#i#"][getiteminfo.currentrow]>
					</cfif>
				</cfif>
			</cfloop>
			<cfset colorArray = ListToArray(colorlist,",")>
			<cfset sizeArray = ListToArray(sizelist,",")>
		</cfif>
		
		<cfif getiteminfo.sizecolor eq "C">
			<tr>
				<td style="border-top:2px solid black;border-bottom:2px solid black;" height="24" width="150px"><font size="2" face="Times New Roman,Times,serif">COLOR</font></td>
				<cfloop from="1" to="#totcol#" index="x">
					<td style="border-top:2px solid black;border-bottom:2px solid black;" width="50px">&nbsp;</td>
				</cfloop>
				<td style="border-top:2px solid black;border-bottom:2px solid black;" width="50px"><div align="center"><font size="2" face="Times New Roman,Times,serif">TOTAL</font></div></td>
			</tr>
			<cfloop from="1" to="#ArrayLen(colorArray)#" index="y">
				<cfif isdefined("form.inserthyphen")>
					<cfset thisitemno = getiteminfo.mitemno&'-'&colorArray[y]>
				<cfelse>
					<cfset thisitemno = getiteminfo.mitemno&colorArray[y]>
				</cfif>
				<!--- <cfquery name="getqtybf" datasource="#dts#">
					select qtybf as qty from icitem
					where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
				</cfquery> --->
				<cfswitch expression="#url.type#">
					<cfcase value="opening">
						<cfquery name="getinfo" datasource="#dts#">
							select qtybf as qty from icitem
							where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
						</cfquery>
					</cfcase>
					<cfcase value="sales">
						<cfquery name="getinfo" datasource="#dts#">
							select (ifnull(b.salesqty,0)+ifnull(c.doqty,0)-ifnull(d.cnqty,0)) as qty 
											
							from icitem a
											
							left join
							(
								select sum(qty) as salesqty,itemno
								from ictran
								where fperiod <> '99'
								and type in ('INV','CS','DN')
								and (void = '' or void is null)
								and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
								group by itemno
							)as b on a.itemno = b.itemno 
											
							left join
							(
								select sum(qty) as doqty,itemno
								from ictran
								where fperiod <> '99'
								and type = 'DO'
								and (void = '' or void is null)
								and toinv = ''
								and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
								group by itemno
							)as c on a.itemno = c.itemno 
											
							left join
							(
								select sum(qty) as cnqty,itemno
								from ictran
								where fperiod <> '99'
								and type = 'CN'
								and (void = '' or void is null)
								and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
								group by itemno
							)as d on a.itemno = d.itemno 
							where a.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
						</cfquery>
					</cfcase>
					<cfcase value="purchase">
						<cfquery name="getinfo" datasource="#dts#">
							select (ifnull(b.rcqty,0)-ifnull(c.prqty,0)) as qty 
										
							from icitem a
											
							left join
							(
								select sum(qty) as rcqty,itemno
								from ictran
								where fperiod <> '99'
								and type = 'RC'
								and (void = '' or void is null)
								and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
								group by itemno
							)as b on a.itemno = b.itemno 
											
							left join
							(
								select sum(qty) as prqty,itemno
								from ictran
								where fperiod <> '99'
								and type = 'PR'
								and (void = '' or void is null)
								and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
								group by itemno
							)as c on a.itemno = c.itemno 
							where a.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
						</cfquery>
					</cfcase>
					<cfcase value="stockbalance">
						<cfquery name="getinfo" datasource="#dts#">
							select (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as qty 
											
							from icitem a
											
							left join
							(
								select sum(qty) as getlastin,itemno
								from ictran
								where fperiod <> '99'
								and type in ('RC','CN','OAI','TRIN')
								and (void = '' or void is null)
								and fperiod < '#form.periodfrom#' 
								group by itemno
							)as b on a.itemno = b.itemno 
											
							left join
							(
								select sum(qty) as getlastout,itemno
								from ictran
								where fperiod <> '99'
								and type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
								and (void = '' or void is null)
								and toinv = ''
								and fperiod < '#form.periodfrom#' 
								group by itemno   
							)as c on a.itemno = c.itemno 
											
							left join
							(
								select sum(qty) as qin,itemno
								from ictran
								where fperiod <> '99'
								and type in ('RC','CN','OAI','TRIN')
								and (void = '' or void is null)
								and fperiod between '#form.periodfrom#' and '#form.periodto#' 
								group by itemno
							)as d on a.itemno = d.itemno 
											
							left join
							(
								select sum(qty) as qout,itemno
								from ictran
								where fperiod <> '99'
								and type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
								and (void = '' or void is null)
								and toinv = ''
								and fperiod between '#form.periodfrom#' and '#form.periodto#' 
								group by itemno
							)as e on a.itemno = e.itemno 
							where a.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
						</cfquery>
					</cfcase>
				</cfswitch>
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td><font size="2" face="Times New Roman,Times,serif">#colorArray[y]#</font></td>
					<cfif getinfo.recordcount neq 0>
						<cfset xqty = val(getinfo.qty)>
					<cfelse>
						<cfset xqty = 0>
					</cfif>
					<td><div align="center"><font size="2" face="Times New Roman,Times,serif">#xqty#</font></div></td>
					<cfloop from="1" to="#totcol-1#" index="x">
						<td>&nbsp;</td>
					</cfloop>
					<td><div align="center"><font size="2" face="Times New Roman,Times,serif">#xqty#</font></div></td>
				</tr>
				<cfset subtotal = subtotal + val(xqty)>
                <cfflush>
			</cfloop>
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='33FF99';">
				<td style="border-top:1px solid black;" height="21" width="150px"><font size="2" face="Times New Roman,Times,serif"><strong>Sub Total:</strong></font></td>
				<td style="border-top:1px solid black;"><div align="center"><font size="2" face="Times New Roman,Times,serif"><strong>#val(subtotal)#</strong></font></div></td>
				<cfloop from="1" to="#totcol-1#" index="x">
					<td style="border-top:1px solid black;">&nbsp;</td>
				</cfloop>
				<td style="border-top:1px solid black;"><div align="center"><font size="2" face="Times New Roman,Times,serif"><strong>#val(subtotal)#</strong></font></div></td>
			</tr>
            <cfflush>
			<tr><td height="10"></td></tr>
		<cfelseif getiteminfo.sizecolor eq "S">
			<cfset totalsize = ArrayLen(sizeArray)>
			<cfset totrow = ceiling(totalsize / totcol)>
			<!--- HEADER --->
			<tr>
			<cfloop from="0" to="#val(totrow-1)#" index="a">
				<cfif a neq 0 and a neq val(totrow-1)>
					</tr>
					<tr>
						<td>&nbsp;</td>
				<cfelseif a neq 0 and a eq val(totrow-1)>
					</tr>
					<tr>
						<td style="border-bottom:2px solid black;">&nbsp;</td>
				<cfelseif a eq 0 and a eq val(totrow-1)>
					<td style="border-top:2px solid black;border-bottom:2px solid black;" height="24" width="150px">
						<div align="left"><font size="2" face="Times New Roman,Times,serif">COLOR</font></div>
					</td>
				<cfelseif a eq 0 and a neq val(totrow-1)>
					<td style="border-top:2px solid black;" height="24" width="150px">
						<div align="left"><font size="2" face="Times New Roman,Times,serif">COLOR</font></div>
					</td>	
				</cfif>
				<cfloop from="1" to="#totcol#" index="b">
					<cfset thisrecord = (a*totcol) + b>
					<cfif thisrecord lte ArrayLen(sizeArray)>
						<cfif a neq 0 and a neq val(totrow-1)>
							<td width="50px">
								<div align="center"><font size="2" face="Times New Roman,Times,serif">#sizeArray[thisrecord]#</font></div>
							</td>
						<cfelseif a eq 0 and a eq val(totrow-1)>
							<td style="border-top:2px solid black;border-bottom:2px solid black;" width="50px">
								<div align="center"><font size="2" face="Times New Roman,Times,serif">#sizeArray[thisrecord]#</font></div>
							</td>
						<cfelseif a eq 0 and a neq val(totrow-1)>
							<td style="border-top:2px solid black;" width="50px">
								<div align="center"><font size="2" face="Times New Roman,Times,serif">#sizeArray[thisrecord]#</font></div>
							</td>
						<cfelseif a neq 0 and a eq val(totrow-1)>
							<td style="border-bottom:2px solid black;" width="50px">
								<div align="center"><font size="2" face="Times New Roman,Times,serif">#sizeArray[thisrecord]#</font></div>
							</td>	
						</cfif>
					<cfelse>
						<cfif a neq 0 and a neq val(totrow-1)>
							<td></td>
						<cfelseif a eq 0 and a eq val(totrow-1)>
							<td style="border-top:2px solid black;border-bottom:2px solid black;" width="50px">&nbsp;</td>
						<cfelseif a eq 0 and a neq val(totrow-1)>
							<td style="border-top:2px solid black;" width="50px">&nbsp;</td>
						<cfelseif a neq 0 and a eq val(totrow-1)>
							<td style="border-bottom:2px solid black;" width="50px">&nbsp;</td>
						</cfif>
					</cfif>	
				</cfloop>
				<cfif a neq 0 and a neq val(totrow-1)>
					<td></td>
				<cfelseif a neq 0 and a eq val(totrow-1)>
					<td style="border-bottom:2px solid black;">&nbsp;</td>
				<cfelseif a eq 0 and a eq val(totrow-1)>
					<td style="border-top:2px solid black;border-bottom:2px solid black;" height="24" width="50px">
						<div align="center"><font size="2" face="Times New Roman,Times,serif">TOTAL</font></div>
					</td>
				<cfelseif a eq 0 and a neq val(totrow-1)>
					<td style="border-top:2px solid black;" height="24" width="50px">
						<div align="center"><font size="2" face="Times New Roman,Times,serif">TOTAL</font></div>
					</td>	
				</cfif>
			</cfloop>
			</tr>	<!--- HEADER --->
			
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td></td>
				<cfset subtotalcolor = 0>
				<cfloop from="1" to="#ArrayLen(sizeArray)#" index="b">
					<cfif isdefined("form.inserthyphen")>
						<cfset thisitemno = getiteminfo.mitemno&'-'&sizeArray[b]>
					<cfelse>
						<cfset thisitemno = getiteminfo.mitemno&sizeArray[b]>
					</cfif>
					<!--- <cfquery name="gettotalcolor" datasource="#dts#">
						select qtybf as qty from icitem
						where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
					</cfquery> --->
					<cfswitch expression="#url.type#">
						<cfcase value="opening">
							<cfquery name="gettotalcolor" datasource="#dts#">
								select qtybf as qty from icitem
								where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
							</cfquery>
						</cfcase>
						<cfcase value="sales">
							<cfquery name="gettotalcolor" datasource="#dts#">
								select (ifnull(b.salesqty,0)+ifnull(c.doqty,0)-ifnull(d.cnqty,0)) as qty 
											
								from icitem a
											
								left join
								(
									select sum(qty) as salesqty,itemno
									from ictran
									where fperiod <> '99'
									and type in ('INV','CS','DN')
									and (void = '' or void is null)
									and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
									group by itemno
								)as b on a.itemno = b.itemno 
											
								left join
								(
									select sum(qty) as doqty,itemno
									from ictran
									where fperiod <> '99'
									and type = 'DO'
									and (void = '' or void is null)
									and toinv = ''
									and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
									group by itemno
								)as c on a.itemno = c.itemno 
											
								left join
								(
									select sum(qty) as cnqty,itemno
									from ictran
									where fperiod <> '99'
									and type = 'CN'
									and (void = '' or void is null)
									and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
									group by itemno
								)as d on a.itemno = d.itemno 
								where a.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
							</cfquery>
						</cfcase>
						<cfcase value="purchase">
							<cfquery name="gettotalcolor" datasource="#dts#">
								select (ifnull(b.rcqty,0)-ifnull(c.prqty,0)) as qty 
										
								from icitem a
											
								left join
								(
									select sum(qty) as rcqty,itemno
									from ictran
									where fperiod <> '99'
									and type = 'RC'
									and (void = '' or void is null)
									and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
									group by itemno
								)as b on a.itemno = b.itemno 
											
								left join
								(
									select sum(qty) as prqty,itemno
									from ictran
									where fperiod <> '99'
									and type = 'PR'
									and (void = '' or void is null)
									and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
									group by itemno
								)as c on a.itemno = c.itemno 
								where a.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
							</cfquery>
						</cfcase>
						<cfcase value="stockbalance">
							<cfquery name="gettotalcolor" datasource="#dts#">
								select (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as qty 
											
								from icitem a
											
								left join
								(
									select sum(qty) as getlastin,itemno
									from ictran
									where fperiod <> '99'
									and type in ('RC','CN','OAI','TRIN')
									and (void = '' or void is null)
									and fperiod < '#form.periodfrom#' 
									group by itemno
								)as b on a.itemno = b.itemno 
											
								left join
								(
									select sum(qty) as getlastout,itemno
									from ictran
									where fperiod <> '99'
									and type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
									and (void = '' or void is null)
									and toinv = ''
									and fperiod < '#form.periodfrom#' 
									group by itemno   
								)as c on a.itemno = c.itemno 
											
								left join
								(
									select sum(qty) as qin,itemno
									from ictran
									where fperiod <> '99'
									and type in ('RC','CN','OAI','TRIN')
									and (void = '' or void is null)
									and fperiod between '#form.periodfrom#' and '#form.periodto#' 
									group by itemno
								)as d on a.itemno = d.itemno 
											
								left join
								(
									select sum(qty) as qout,itemno
									from ictran
									where fperiod <> '99'
									and type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
									and (void = '' or void is null)
									and toinv = ''
									and fperiod between '#form.periodfrom#' and '#form.periodto#' 
									group by itemno
								)as e on a.itemno = e.itemno 
								where a.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
							</cfquery>
						</cfcase>
					</cfswitch>
					<cfif gettotalcolor.recordcount neq 0>
						<cfset subtotalcolor = subtotalcolor + gettotalcolor.qty>
					</cfif>
				</cfloop>
				
				<cfloop from="0" to="#val(totrow-1)#" index="a">
					<cfif a neq 0>
						</tr>
						<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
							<td></td>
					</cfif>	
						
					<cfloop from="1" to="#totcol#" index="b">
						<cfset thisrecord = (a*totcol) + b>
						<cfif thisrecord lte ArrayLen(sizeArray)>
							<cfif isdefined("form.inserthyphen")>
								<cfset thisitemno = getiteminfo.mitemno&'-'&sizeArray[thisrecord]>
							<cfelse>
								<cfset thisitemno = getiteminfo.mitemno&sizeArray[thisrecord]>
							</cfif>
							<!--- <cfquery name="getinfo" datasource="#dts#">
								select qtybf as qty from icitem
								where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
							</cfquery> --->
							<cfswitch expression="#url.type#">
								<cfcase value="opening">
									<cfquery name="getinfo" datasource="#dts#">
										select qtybf as qty from icitem
										where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
									</cfquery>
								</cfcase>
								<cfcase value="sales">
									<cfquery name="getinfo" datasource="#dts#">
										select (ifnull(b.salesqty,0)+ifnull(c.doqty,0)-ifnull(d.cnqty,0)) as qty 
											
										from icitem a
											
										left join
										(
											select sum(qty) as salesqty,itemno
											from ictran
											where fperiod <> '99'
											and type in ('INV','CS','DN')
											and (void = '' or void is null)
											and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
											group by itemno
										)as b on a.itemno = b.itemno 
											
										left join
										(
											select sum(qty) as doqty,itemno
											from ictran
											where fperiod <> '99'
											and type = 'DO'
											and (void = '' or void is null)
											and toinv = ''
											and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
											group by itemno
										)as c on a.itemno = c.itemno 
											
										left join
										(
											select sum(qty) as cnqty,itemno
											from ictran
											where fperiod <> '99'
											and type = 'CN'
											and (void = '' or void is null)
											and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
											group by itemno
										)as d on a.itemno = d.itemno 
										where a.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
									</cfquery>
								</cfcase>
								<cfcase value="purchase">
									<cfquery name="getinfo" datasource="#dts#">
										select (ifnull(b.rcqty,0)-ifnull(c.prqty,0)) as qty 
										
										from icitem a
											
										left join
										(
											select sum(qty) as rcqty,itemno
											from ictran
											where fperiod <> '99'
											and type = 'RC'
											and (void = '' or void is null)
											and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
											group by itemno
										)as b on a.itemno = b.itemno 
											
										left join
										(
											select sum(qty) as prqty,itemno
											from ictran
											where fperiod <> '99'
											and type = 'PR'
											and (void = '' or void is null)
											and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
											group by itemno
										)as c on a.itemno = c.itemno 
										where a.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
									</cfquery>
								</cfcase>
								<cfcase value="stockbalance">
									<cfquery name="getinfo" datasource="#dts#">
										select (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as qty 
											
										from icitem a
											
										left join
										(
											select sum(qty) as getlastin,itemno
											from ictran
											where fperiod <> '99'
											and type in ('RC','CN','OAI','TRIN')
											and (void = '' or void is null)
											and fperiod < '#form.periodfrom#' 
											group by itemno
										)as b on a.itemno = b.itemno 
											
										left join
										(
											select sum(qty) as getlastout,itemno
											from ictran
											where fperiod <> '99'
											and type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
											and (void = '' or void is null)
											and toinv = ''
											and fperiod < '#form.periodfrom#' 
											group by itemno   
										)as c on a.itemno = c.itemno 
											
										left join
										(
											select sum(qty) as qin,itemno
											from ictran
											where fperiod <> '99'
											and type in ('RC','CN','OAI','TRIN')
											and (void = '' or void is null)
											and fperiod between '#form.periodfrom#' and '#form.periodto#' 
											group by itemno
										)as d on a.itemno = d.itemno 
											
										left join
										(
											select sum(qty) as qout,itemno
											from ictran
											where fperiod <> '99'
											and type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
											and (void = '' or void is null)
											and toinv = ''
											and fperiod between '#form.periodfrom#' and '#form.periodto#' 
											group by itemno
										)as e on a.itemno = e.itemno 
										where a.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
									</cfquery>
								</cfcase>
							</cfswitch>
							<cfif getinfo.recordcount neq 0>
								<cfset xqty = val(getinfo.qty)>
							<cfelse>
								<cfset xqty = 0>
							</cfif>
								
							<cfif thisrecord eq 1>
								<cfset subtotalsize = xqty>
							<cfelse>
								<cfset subtotalsize = subtotalsize&','&xqty>
							</cfif>
								
							<td width="50px">
								<div align="center"><font size="2" face="Times New Roman,Times,serif">#xqty#</font></div>
							</td>
						<cfelse>
							<td>&nbsp;</td>
						</cfif>
					</cfloop>	
					<cfif a eq 0>
						<td width="50px"><font size="2" face="Times New Roman,Times,serif"><div align="center">#subtotalcolor#</div></font></td>
						<cfset totalcolor = subtotalcolor>
					<cfelse>
						<td></td>
					</cfif>	
				</cfloop>
                <cfflush>
			</tr>
			<cfset subtotalArray = ListToArray(subtotalsize,",")>
			
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='33FF99';">
				<td style="border-top:1px solid black;" width="150px"><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Sub Total:</strong></font></div></td>
				<cfset counter = 0>
				<cfloop from="1" to="#ArrayLen(subtotalArray)#" index="x">
					<cfif x gt totcol>
						<cfif counter eq totcol>
							<cfset counter = 0>
							</tr>
							<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='33FF99';">
								<td>&nbsp;</td>
								<td width="50px" nowrap><div align="center"><font size="2" face="Times New Roman,Times,serif"><strong>#subtotalArray[x]#</strong></font></div></td>
						<cfelse>
							<td width="50px" nowrap><div align="center"><font size="2" face="Times New Roman,Times,serif"><strong>#subtotalArray[x]#</strong></font></div></td>
						</cfif>
					<cfelse>
						<cfif counter eq totcol>
							<cfset counter = 0>
							</tr>
							<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='33FF99';">
								<td style="border-top:1px solid black;">&nbsp;</td>
								<td width="50px" style="border-top:1px solid black;" nowrap><div align="center"><font size="2" face="Times New Roman,Times,serif"><strong>#subtotalArray[x]#</strong></font></div></td>
						<cfelse>
							<td width="50px" style="border-top:1px solid black;" nowrap><div align="center"><font size="2" face="Times New Roman,Times,serif"><strong>#subtotalArray[x]#</strong></font></div></td>
						</cfif>
					</cfif>
					
					<cfif x eq totcol>
						<td style="border-top:1px solid black;" width="50px" nowrap><div align="center"><font size="2" face="Times New Roman,Times,serif"><strong>#totalcolor#</strong></font></div></td>
					</cfif>
						
					<cfset counter = counter + 1>
				</cfloop>
				<cfif ArrayLen(subtotalArray) lt totcol>
					<cfset loopcount = totcol - ArrayLen(subtotalArray)>
					<cfloop from="1" to="#loopcount#" index="y">
						<td style="border-top:1px solid black;">&nbsp;</td>
					</cfloop>
					<td style="border-top:1px solid black;" width="50px" nowrap><div align="center"><font size="2" face="Times New Roman,Times,serif"><strong>#totalcolor#</strong></font></div></td>
				</cfif>
				<cfif ArrayLen(subtotalArray) gt totcol and counter lt totcol>
					<cfset loopcount = totcol - counter + 1>
					<cfloop from="1" to="#loopcount#" index="y">
						<td>&nbsp;</td>
					</cfloop>
				</cfif>
			</tr>
			<tr><td height="10"></td></tr>
		<cfelseif getiteminfo.sizecolor eq "SC">
			<cfset totalsize = ArrayLen(sizeArray)>
			<cfset totrow = ceiling(totalsize / totcol)>
			<!--- HEADER --->
			<tr>
			<cfloop from="0" to="#val(totrow-1)#" index="a">
				<cfif a neq 0 and a neq val(totrow-1)>
					</tr>
					<tr>
						<td>&nbsp;</td>
				<cfelseif a neq 0 and a eq val(totrow-1)>
					</tr>
					<tr>
						<td style="border-bottom:2px solid black;">&nbsp;</td>
				<cfelseif a eq 0 and a eq val(totrow-1)>
					<td style="border-top:2px solid black;border-bottom:2px solid black;" height="24" width="150px">
						<div align="left"><font size="2" face="Times New Roman,Times,serif">COLOR</font></div>
					</td>
				<cfelseif a eq 0 and a neq val(totrow-1)>
					<td style="border-top:2px solid black;" height="24" width="150px">
						<div align="left"><font size="2" face="Times New Roman,Times,serif">COLOR</font></div>
					</td>	
				</cfif>
				<cfloop from="1" to="#totcol#" index="b">
					<cfset thisrecord = (a*totcol) + b>
					<cfif thisrecord lte ArrayLen(sizeArray)>
						<cfif a neq 0 and a neq val(totrow-1)>
							<td width="50px">
								<div align="center"><font size="2" face="Times New Roman,Times,serif">#sizeArray[thisrecord]#</font></div>
							</td>
						<cfelseif a eq 0 and a eq val(totrow-1)>
							<td style="border-top:2px solid black;border-bottom:2px solid black;" width="50px">
								<div align="center"><font size="2" face="Times New Roman,Times,serif">#sizeArray[thisrecord]#</font></div>
							</td>
						<cfelseif a eq 0 and a neq val(totrow-1)>
							<td style="border-top:2px solid black;" width="50px">
								<div align="center"><font size="2" face="Times New Roman,Times,serif">#sizeArray[thisrecord]#</font></div>
							</td>
						<cfelseif a neq 0 and a eq val(totrow-1)>
							<td style="border-bottom:2px solid black;" width="50px">
								<div align="center"><font size="2" face="Times New Roman,Times,serif">#sizeArray[thisrecord]#</font></div>
							</td>	
						</cfif>
					<cfelse>
						<cfif a neq 0 and a neq val(totrow-1)>
							<td></td>
						<cfelseif a eq 0 and a eq val(totrow-1)>
							<td style="border-top:2px solid black;border-bottom:2px solid black;" width="50px">&nbsp;</td>
						<cfelseif a eq 0 and a neq val(totrow-1)>
							<td style="border-top:2px solid black;" width="50px">&nbsp;</td>
						<cfelseif a neq 0 and a eq val(totrow-1)>
							<td style="border-bottom:2px solid black;" width="50px">&nbsp;</td>
						</cfif>
					</cfif>	
				</cfloop>
				<cfif a neq 0 and a neq val(totrow-1)>
					<td></td>
				<cfelseif a neq 0 and a eq val(totrow-1)>
					<td style="border-bottom:2px solid black;">&nbsp;</td>
				<cfelseif a eq 0 and a eq val(totrow-1)>
					<td style="border-top:2px solid black;border-bottom:2px solid black;" height="24" width="50px">
						<div align="center"><font size="2" face="Times New Roman,Times,serif">TOTAL</font></div>
					</td>
				<cfelseif a eq 0 and a neq val(totrow-1)>
					<td style="border-top:2px solid black;" height="24" width="50px">
						<div align="center"><font size="2" face="Times New Roman,Times,serif">TOTAL</font></div>
					</td>	
				</cfif>
			</cfloop>
			</tr>	<!--- HEADER --->
			<cfset totalcolor = 0>
			<cfloop from="1" to="#ArrayLen(colorArray)#" index="i">	<!--- LOOP THE COLORLIST --->
				<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
					<td><font size="2" face="Times New Roman,Times,serif">#colorArray[i]#</font></td>
					<cfset subtotalcolor = 0>
					<cfloop from="0" to="#val(totrow-1)#" index="a">
						<cfloop from="1" to="#totcol#" index="b">
							<cfset thisrecord = (a*totcol) + b>
							<cfif thisrecord lte ArrayLen(sizeArray)>
								<cfif isdefined("form.inserthyphen")>
									<cfset thisitemno = getiteminfo.mitemno&'-'&colorArray[i]&'-'&sizeArray[thisrecord]>
								<cfelse>
									<cfset thisitemno = getiteminfo.mitemno&colorArray[i]&sizeArray[thisrecord]>
								</cfif>
								<cfswitch expression="#url.type#">
									<cfcase value="opening">
										<cfquery name="gettotalcolor" datasource="#dts#">
											select qtybf as qty from icitem
											where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
										</cfquery>
									</cfcase>
									<cfcase value="sales">
										<cfquery name="gettotalcolor" datasource="#dts#">
											select (ifnull(b.salesqty,0)+ifnull(c.doqty,0)-ifnull(d.cnqty,0)) as qty 
											
											from icitem a
											
											left join
											(
												select sum(qty) as salesqty,itemno
												from ictran
												where fperiod <> '99'
												and type in ('INV','CS','DN')
												and (void = '' or void is null)
												and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
												group by itemno
											)as b on a.itemno = b.itemno 
											
											left join
											(
												select sum(qty) as doqty,itemno
												from ictran
												where fperiod <> '99'
												and type = 'DO'
												and (void = '' or void is null)
												and toinv = ''
												and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
												group by itemno
											)as c on a.itemno = c.itemno 
											
											left join
											(
												select sum(qty) as cnqty,itemno
												from ictran
												where fperiod <> '99'
												and type = 'CN'
												and (void = '' or void is null)
												and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
												group by itemno
											)as d on a.itemno = d.itemno 
											where a.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
										</cfquery>
									</cfcase>
									<cfcase value="purchase">
										<cfquery name="gettotalcolor" datasource="#dts#">
											select (ifnull(b.rcqty,0)-ifnull(c.prqty,0)) as qty 
											
											from icitem a
											
											left join
											(
												select sum(qty) as rcqty,itemno
												from ictran
												where fperiod <> '99'
												and type = 'RC'
												and (void = '' or void is null)
												and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
												group by itemno
											)as b on a.itemno = b.itemno 
											
											left join
											(
												select sum(qty) as prqty,itemno
												from ictran
												where fperiod <> '99'
												and type = 'PR'
												and (void = '' or void is null)
												and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
												group by itemno
											)as c on a.itemno = c.itemno 
											where a.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
										</cfquery>
									</cfcase>
									<cfcase value="stockbalance">
										<cfquery name="gettotalcolor" datasource="#dts#">
											select (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as qty 
											
											from icitem a
											
											left join
											(
												select sum(qty) as getlastin,itemno
												from ictran
												where fperiod <> '99'
												and type in ('RC','CN','OAI','TRIN')
												and (void = '' or void is null)
												and fperiod < '#form.periodfrom#' 
												group by itemno
											)as b on a.itemno = b.itemno 
											
											left join
											(
												select sum(qty) as getlastout,itemno
												from ictran
												where fperiod <> '99'
												and type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
												and (void = '' or void is null)
												and toinv = ''
												and fperiod < '#form.periodfrom#'    
												group by itemno
											)as c on a.itemno = c.itemno 
											
											left join
											(
												select sum(qty) as qin,itemno
												from ictran
												where fperiod <> '99'
												and type in ('RC','CN','OAI','TRIN')
												and (void = '' or void is null)
												and fperiod between '#form.periodfrom#' and '#form.periodto#' 
												group by itemno
											)as d on a.itemno = d.itemno 
											
											left join
											(
												select sum(qty) as qout,itemno
												from ictran
												where fperiod <> '99'
												and type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
												and (void = '' or void is null)
												and toinv = ''
												and fperiod between '#form.periodfrom#' and '#form.periodto#' 
												group by itemno
											)as e on a.itemno = e.itemno 
											where a.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
										</cfquery>
									</cfcase>
								</cfswitch>
								
								<cfif gettotalcolor.recordcount neq 0>
									<cfset subtotalcolor = subtotalcolor + gettotalcolor.qty>
								</cfif>
							</cfif>
						</cfloop>
					</cfloop>
					<cfloop from="0" to="#val(totrow-1)#" index="a">
						<cfif a neq 0>
							</tr>
							<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
								<td></td>
						</cfif>	
						
						<cfloop from="1" to="#totcol#" index="b">
							<cfset thisrecord = (a*totcol) + b>
							<cfif thisrecord lte ArrayLen(sizeArray)>
								<cfif isdefined("form.inserthyphen")>
									<cfset thisitemno = getiteminfo.mitemno&'-'&colorArray[i]&'-'&sizeArray[thisrecord]>
								<cfelse>
									<cfset thisitemno = getiteminfo.mitemno&colorArray[i]&sizeArray[thisrecord]>
								</cfif>
								<!--- <cfquery name="getinfo" datasource="#dts#">
									select qtybf as qty from icitem
									where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
								</cfquery> --->
								<cfswitch expression="#url.type#">
									<cfcase value="opening">
										<cfquery name="getinfo" datasource="#dts#">
											select qtybf as qty from icitem
											where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
										</cfquery>
									</cfcase>
									<cfcase value="sales">
										<cfquery name="getinfo" datasource="#dts#">
											select (ifnull(b.salesqty,0)+ifnull(c.doqty,0)-ifnull(d.cnqty,0)) as qty 
											
											from icitem a
											
											left join
											(
												select sum(qty) as salesqty,itemno
												from ictran
												where fperiod <> '99'
												and type in ('INV','CS','DN')
												and (void = '' or void is null)
												and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
												group by itemno
											)as b on a.itemno = b.itemno 
											
											left join
											(
												select sum(qty) as doqty,itemno
												from ictran
												where fperiod <> '99'
												and type = 'DO'
												and (void = '' or void is null)
												and toinv = ''
												and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
												group by itemno
											)as c on a.itemno = c.itemno 
											
											left join
											(
												select sum(qty) as cnqty,itemno
												from ictran
												where fperiod <> '99'
												and type = 'CN'
												and (void = '' or void is null)
												and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
												group by itemno
											)as d on a.itemno = d.itemno 
											where a.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
										</cfquery>
									</cfcase>
									<cfcase value="purchase">
										<cfquery name="getinfo" datasource="#dts#">
											select (ifnull(b.rcqty,0)-ifnull(c.prqty,0)) as qty 
											
											from icitem a
											
											left join
											(
												select sum(qty) as rcqty,itemno
												from ictran
												where fperiod <> '99'
												and type = 'RC'
												and (void = '' or void is null)
												and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
												group by itemno
											)as b on a.itemno = b.itemno 
											
											left join
											(
												select sum(qty) as prqty,itemno
												from ictran
												where fperiod <> '99'
												and type = 'PR'
												and (void = '' or void is null)
												and fperiod >='#form.periodfrom#' and fperiod <= '#form.periodto#' 
												group by itemno
											)as c on a.itemno = c.itemno 
											where a.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
										</cfquery>
									</cfcase>
									<cfcase value="stockbalance">
										<cfquery name="getinfo" datasource="#dts#">
											select (ifnull(a.qtybf,0)+ifnull(b.getlastin,0)-ifnull(c.getlastout,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as qty 
											
											from icitem a
											
											left join
											(
												select sum(qty) as getlastin,itemno
												from ictran
												where fperiod <> '99'
												and type in ('RC','CN','OAI','TRIN')
												and (void = '' or void is null)
												and fperiod < '#form.periodfrom#' 
												group by itemno
											)as b on a.itemno = b.itemno 
											
											left join
											(
												select sum(qty) as getlastout,itemno
												from ictran
												where fperiod <> '99'
												and type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
												and (void = '' or void is null)
												and toinv = ''
												and fperiod < '#form.periodfrom#' 
												group by itemno   
											)as c on a.itemno = c.itemno 
											
											left join
											(
												select sum(qty) as qin,itemno
												from ictran
												where fperiod <> '99'
												and type in ('RC','CN','OAI','TRIN')
												and (void = '' or void is null)
												and fperiod between '#form.periodfrom#' and '#form.periodto#' 
												group by itemno
											)as d on a.itemno = d.itemno 
											
											left join
											(
												select sum(qty) as qout,itemno
												from ictran
												where fperiod <> '99'
												and type in ('INV','PR','CS','DN','ISS','OAR','TROU','DO') 
												and (void = '' or void is null)
												and toinv = ''
												and fperiod between '#form.periodfrom#' and '#form.periodto#' 
												group by itemno
											)as e on a.itemno = e.itemno 
											where a.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#thisitemno#">
										</cfquery>
									</cfcase>
								</cfswitch>
								<cfif getinfo.recordcount neq 0>
									<cfset xqty = val(getinfo.qty)>
								<cfelse>
									<cfset xqty = 0>
								</cfif>
								<cfif i eq 1>
									<cfif thisrecord eq 1>
										<cfset subtotalsize = xqty>
									<cfelse>
										<cfset subtotalsize = subtotalsize&','&xqty>
									</cfif>
								<cfelse>
									<cfif thisrecord eq 1>
										<cfset subtotalsize2 = xqty>
									<cfelse>
										<cfset subtotalsize2 = subtotalsize2&','&xqty>
									</cfif>
								</cfif>
								<td width="50px">
									<div align="center"><font size="2" face="Times New Roman,Times,serif">#xqty#</font></div>
								</td>
							<cfelse>
								<td>&nbsp;</td>
							</cfif>
						</cfloop>	
						<cfif a eq 0>
							<td width="50px"><font size="2" face="Times New Roman,Times,serif"><div align="center">#subtotalcolor#</div></font></td>
							<cfset totalcolor = totalcolor + subtotalcolor>
						<cfelse>
							<td></td>
						</cfif>	
					</cfloop>
					<cfif i eq 1>
						<cfset subtotalArray = ListToArray(subtotalsize,",")>
					<cfelse>
						<cfset subtotalArray2 = ListToArray(subtotalsize2,",")>
						<cfloop from="1" to="#ArrayLen(subtotalArray)#" index="x">
							<cfset subtotalArray[x] = subtotalArray[x] + val(subtotalArray2[x])>
						</cfloop>		
					</cfif>
                    <cfflush>
				</tr>
			</cfloop>
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='33FF99';">
				<td style="border-top:1px solid black;"><div align="left"><font size="2" face="Times New Roman,Times,serif"><strong>Sub Total:</strong></font></div></td>
				<cfset counter = 0>
				<cfloop from="1" to="#ArrayLen(subtotalArray)#" index="x">
					<cfif x gt totcol>
						<cfif counter eq totcol>
							<cfset counter = 0>
							</tr>
							<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='33FF99';">
								<td>&nbsp;</td>
								<td width="50px" nowrap><div align="center"><font size="2" face="Times New Roman,Times,serif"><strong>#subtotalArray[x]#</strong></font></div></td>
						<cfelse>
							<td width="50px" nowrap><div align="center"><font size="2" face="Times New Roman,Times,serif"><strong>#subtotalArray[x]#</strong></font></div></td>
						</cfif>
					<cfelse>
						<cfif counter eq totcol>
							<cfset counter = 0>
							</tr>
							<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='33FF99';">
								<td style="border-top:1px solid black;">&nbsp;</td>
								<td width="50px" style="border-top:1px solid black;" nowrap><div align="center"><font size="2" face="Times New Roman,Times,serif"><strong>#subtotalArray[x]#</strong></font></div></td>
						<cfelse>
							<td width="50px" style="border-top:1px solid black;" nowrap><div align="center"><font size="2" face="Times New Roman,Times,serif"><strong>#subtotalArray[x]#</strong></font></div></td>
						</cfif>
					</cfif>
					
					<cfif x eq totcol>
						<td style="border-top:1px solid black;" width="50px" nowrap><div align="center"><font size="2" face="Times New Roman,Times,serif"><strong>#totalcolor#</strong></font></div></td>
					</cfif>
						
					<cfset counter = counter + 1>
				</cfloop>
				<cfif ArrayLen(subtotalArray) lt totcol>
					<cfset loopcount = totcol - ArrayLen(subtotalArray)>
					<cfloop from="1" to="#loopcount#" index="y">
						<td style="border-top:1px solid black;">&nbsp;</td>
					</cfloop>
					<td style="border-top:1px solid black;" width="50px" nowrap><div align="center"><font size="2" face="Times New Roman,Times,serif"><strong>#totalcolor#</strong></font></div></td>
				</cfif>
				<cfif ArrayLen(subtotalArray) gt totcol and counter lt totcol>
					<cfset loopcount = totcol - counter + 1>
					<cfloop from="1" to="#loopcount#" index="y">
						<td>&nbsp;</td>
					</cfloop>
				</cfif>
			</tr>
			<tr><td height="10"></td></tr>
		</cfif>
	</cfoutput>
</table>
</body>
</html>