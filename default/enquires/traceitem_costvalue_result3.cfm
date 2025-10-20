<html>
<head>
<title>Trace FIFO</title>
<link href="/stylesheet/reportprint.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgeneral" datasource="#dts#">
	select a.compro,concat(',.',repeat('_',b.decl_uprice))as decl_uprice, b.decl_uprice as Decl_UPrice1
	from gsetup as a, gsetup2 as b
</cfquery>

<cfset stDecl_UPrice = getgeneral.decl_uprice>

<cfquery name="getinfo" datasource="#dts#">
	select a.itemno,a.desp,
	<cfloop index="i" from="11" to="50">
		ifnull(b.FFQ#i#,0) as FFQ#i#,
		ifnull(b.FFC#i#,0) as FFC#i#,
		b.FFD#i#<cfif i neq 50>,</cfif>
	</cfloop>
	from icitem a
	
	left join fifoopq as b on a.itemno=b.itemno
	
	
	where 0=0
	<cfif trim(form.itemfrom) neq "" and trim(form.itemto) neq "">
		and a.itemno between '#form.itemfrom#' and '#form.itemto#'
	</cfif>
	order by a.itemno
</cfquery>
<body>
<table align="center" width="80%" cellspacing="0">
	<tr>
		<td colspan="100%">
			<div align="center"><font size="3" face="Times New Roman, Times, serif"><strong>TRACE FIFO</strong></font></div>
		</td>
	</tr>
	<cfoutput>
	<tr>
		<td colspan="3"><font size="2" face="Times New Roman, Times, serif">#getgeneral.compro#</font></td>
		<td colspan="1"><div align="right"><font size="2" face="Times New Roman, Times, serif">#dateformat(now(),"dd-mm-yyyy")#</font></div></td>
	</tr>
	</cfoutput>
	<tr><td height="5"></td></tr>
	<tr>
		<td style="border-top:1px solid black;border-bottom:1px solid black;" height="25"><font size="2" face="Times New Roman, Times, serif">NO.</font></td>
      	<td style="border-top:1px solid black;border-bottom:1px solid black;"><font size="2" face="Times New Roman, Times, serif">BILL NO.</font></td>
      	<td style="border-top:1px solid black;border-bottom:1px solid black;"><font size="2" face="Times New Roman, Times, serif">BILL DATE</font></td>
      	<td style="border-top:1px solid black;border-bottom:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">QUANTITY</font></div></td>
      	<td style="border-top:1px solid black;border-bottom:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">COST</font></div></td>
      	<td style="border-top:1px solid black;border-bottom:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">VALUE</font></div></td>
    </tr>
		
	<cfoutput query="getinfo">
		<cfset thisitem=getinfo.itemno>
		<cfset totqty=0>
		<cfset totcost=0>
		<cfquery name="getrc" datasource="#dts#">
			select type,refno,itemno,qty,wos_date,
			if(type='CN',(it_cos/qty),<cfif isdefined ('form.cbincludecharge')>
            ((amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7)/qty)) as price,
            <cfelse>
            (amt/qty)) as price,
            </cfif>
			if(type='CN',it_cos,<cfif isdefined ('form.cbincludecharge')>(amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7))as amt<cfelse> amt) as amt</cfif>
			from ictran
			where fperiod <> '99'
			and fperiod+0 <= '#form.periodat#'
			and type in ('RC','OAI','CN')
			and itemno='#thisitem#'
			and (void = '' or void is null)
			order by wos_date,trdatetime
		</cfquery>
        
        <cfquery name="getqtybf" datasource="#dts#">
			select qtybf from icitem where itemno='#thisitem#'
		</cfquery>
		
		<cfquery name="getictranout" datasource="#dts#">
			select ifnull(sum(qty),0) as qout
			from ictran as a
			where (void = '' or void is null)
			and fperiod<>'99' 
			and (linecode <> 'SV' or linecode is null)
			and itemno='#thisitem#'
			and fperiod+0 <= '#form.periodat#'
			and (type in ('DO','PR','CS','DN','ISS','OAR') or 
			(type='INV' and refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno)))  
		</cfquery>
		<cfif getictranout.recordcount neq 0>
			<cfset qqout=getictranout.qout>
		<cfelse>
			<cfset qqout=0>
		</cfif>
		<cfset totalcount=40>
		<cfset fifocount=totalcount-getrc.recordcount>

		<tr>
			<td colspan="2"><font size="2" face="Times New Roman, Times, serif"><u>#getinfo.itemno#</u></font></td>
			<td colspan="2"><font size="2" face="Times New Roman, Times, serif"><u>#getinfo.desp#</u></font></td>
		</tr>
		
		<cfset counter=40>
		<cfset balqty=0>
		<cfif fifocount gt 0>
			<cfloop from="#fifocount+10#" to="11" index="i" step="-1">
				<cfif val(getinfo["FFQ#i#"][getinfo.currentrow]) gt qqout>
					<cfset getinfo["FFQ#i#"][getinfo.currentrow]=val(getinfo["FFQ#i#"][getinfo.currentrow])-qqout>
					<cfset qqout=0>
				<cfelse>
					<cfset qqout=qqout-val(getinfo["FFQ#i#"][getinfo.currentrow])>
					<cfset getinfo["FFQ#i#"][getinfo.currentrow]=0>
				</cfif>
				<cfif i eq fifocount+10>
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
						<td><font size="2" face="Times New Roman, Times, serif">Oldest:</font></td>
				      	<td><font size="2" face="Times New Roman, Times, serif">Opening</font></td>
				      	<td><font size="2" face="Times New Roman, Times, serif"></font></td>
				      	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getinfo["FFQ#i#"][getinfo.currentrow]#</font></div></td>
				      	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getinfo["FFC#i#"][getinfo.currentrow],stDecl_UPrice)#</font></div></td>
				      	<cfset thisvalue=val(getinfo["FFQ#i#"][getinfo.currentrow])*val(getinfo["FFC#i#"][getinfo.currentrow])>
				      	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(thisvalue,stDecl_UPrice)#</font></div></td>
				    </tr>
				<cfelse>
					<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
						<td><font size="2" face="Times New Roman, Times, serif">#counter#.</font></td>
				      	<td><font size="2" face="Times New Roman, Times, serif">Opening</font></td>
                        <cfset datevalue = #getinfo["FFD#i#"][getinfo.currentrow]# >
				      	<td><font size="2" face="Times New Roman, Times, serif"><cfif datevalue neq "0000-00-00" >#dateformat(datevalue,'dd/mm/yyyy')#</cfif></font></td>
				      	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#getinfo["FFQ#i#"][getinfo.currentrow]#</font></div></td>
				      	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getinfo["FFC#i#"][getinfo.currentrow],'.____')#</font></div></td>
				      	<cfset thisvalue=val(getinfo["FFQ#i#"][getinfo.currentrow])*val(getinfo["FFC#i#"][getinfo.currentrow])>
				      	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(thisvalue,stDecl_UPrice)#</font></div></td>
				    </tr>
				</cfif>
				<cfset totqty=totqty+val(getinfo["FFQ#i#"][getinfo.currentrow])>
				<cfset totcost=totcost+thisvalue>
				<cfset counter=counter-1>
			</cfloop>
		</cfif>
		<cfif getrc.recordcount gte 40>
			<cfset counter=getrc.recordcount>
		</cfif>
        
		<cfloop query="getrc">
        <cfif getrc.Currentrow eq 1>
        	<cfif val(getrc.qty) gt qqout>
				<cfset getrc.qty=getrc.qty-qqout>
				<cfset qqout=0>
			<cfelse>
				<cfset qqout=qqout-val(getrc.qty)>
				<cfset getrc.qty=0>
			</cfif>
        <cfelse>
			<cfif val(getrc.qty) gt qqout>
				<cfset getrc.qty=getrc.qty-qqout>
				<cfset qqout=0>
			<cfelse>
				<cfset qqout=qqout-val(getrc.qty)>
				<cfset getrc.qty=0>
			</cfif>
        </cfif>
			<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
				<td><font size="2" face="Times New Roman, Times, serif">#counter#.</font></td>
		      	<td><font size="2" face="Times New Roman, Times, serif">#getrc.type# #getrc.refno#</font></td>
		      	<td><font size="2" face="Times New Roman, Times, serif">#dateformat(getrc.wos_date,"dd/mm/yyyy")#</font></td>
		      	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#val(getrc.qty)#</font></div></td>
		      	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(getrc.price,'.____')#</font></div></td>
		      	<cfset thisvalue=val(getrc.qty)*val(getrc.price)>
		      	<td><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(thisvalue,stDecl_UPrice)#</font></div></td>
		    </tr>
		    <cfset totqty=totqty+val(getrc.qty)>
			<cfset totcost=totcost+thisvalue>
		    <cfset counter=counter-1>
		</cfloop>
		<tr><td height="5"></td></tr>
		<tr>
			<td style="border-top:1px solid black;" height="25" colspan="3"><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
	      	<td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#totqty#</font></div></td>
	      	<td style="border-top:1px solid black;"><font size="2" face="Times New Roman, Times, serif">&nbsp;</font></td>
	      	<td style="border-top:1px solid black;"><div align="right"><font size="2" face="Times New Roman, Times, serif">#numberformat(totcost,stDecl_UPrice)#</font></div></td>
	    </tr>
	</cfoutput>
</table>
</body>
</html>