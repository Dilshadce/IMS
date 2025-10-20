<html>
<head>
<title>Item Assembly</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
	function data_validation()
	{
		<!--- INSERT COMPULSORY LOCATION CHECKING --->
		<cfinclude template = "transaction_setting_checking/compulsory_location_assm3.cfm">
		<!--- INSERT COMPULSORY LOCATION CHECKING --->
	}
</script>
</head>

<cfparam name="pricehis1" default="">
<cfparam name="pricehis2" default="">
<cfparam name="pricehis3" default="">
<cfparam name="disc1" default="">
<cfparam name="disc2" default="">
<cfparam name="disc3" default="">
<cfparam name="date1" default="">
<cfparam name="date2" default="">
<cfparam name="date3" default="">
<cfparam name="itembal" default="0">
<cfparam name="RCqty" default="0">
<cfparam name="PRqty" default="0">
<cfparam name="DOqty" default="0">
<cfparam name="invqty" default="0">
<cfparam name="CNqty" default="0">
<cfparam name="DNqty" default="0"> 
<cfparam name="CSqty" default="0"> 
<cfparam name="ISSqty" default="0"> 
<cfparam name="trinqty" default="0"> 
<cfparam name="troutqty" default="0">
<cfparam name="oaiqty" default="0">
<cfparam name="oarqty" default="0">
<cfparam name="balonhand" default="0">

<cfquery datasource="#dts#" name="getlocation">
	select location from iclocation
</cfquery>

<cfoutput>
	<cfif url.type1 eq "Add">
		
		<cfquery datasource='#dts#' name="checkitemExist">
			select * from ictran where refno = '#nexttranno#' and itemno = '#itemno#' and type = 'ISS'
		</cfquery>

		<cfif checkitemExist.recordcount GT 0>
			<div align="center"><h3>You have added this item before.</h3>
			<input type="button" name="back" value="back" onClick="javascript:history.back()"></div>
			<cfabort>
		</cfif> 
	
		<cfquery datasource="#dts#" name="getproductdetails">
			Select * from icitem where itemno = '#itemno#'
		</cfquery>
		
		<cfquery datasource='#dts#' name="getpricehis">
			select * from ictran where itemno= '#itemno#' order by wos_date desc
		</cfquery>
		
		<cfquery name="getitembal" datasource="#dts#">
			select qtybf from icitem where itemno = '#itemno#'
		</cfquery>
		
		<cfset itemno = itemno>
		<cfset desp="">
		<cfset despa="">
		<cfset xlocation="">
		<cfset qty="0">
		<cfset price="0">
		<cfset dono="">
		<cfset gst_item="">
		<cfset totalup="">
		<cfset dispec1="0">
		<cfset taxpec1="0">
		<cfset wos_grouop="">
		<cfset category="">
		<cfset area="">
		<cfset shelf="">
		<cfset mode="Add">
		<cfset button="Add">
	</cfif>
	
	<cfif getpricehis.recordcount gt 0>
		<cfloop query="getpricehis" startrow="1" endrow="1">
			<cfset pricehis1 = numberformat(price,"____.__")>
			<cfset date1 = dateformat(wos_date,"dd/mm/yyyy")>
			<cfset disc1 = dispec1>
		</cfloop>
		
		<cfloop query="getpricehis" startrow="2" endrow="2">
			<cfset pricehis2 = numberformat(price,"____.__")>
			<cfset date2 = dateformat(wos_date,"dd/mm/yyyy")>
			<cfset disc2 = dispec1>
		</cfloop>
		
		<cfloop query="getpricehis" startrow="3" endrow="3">
			<cfset pricehis3 = numberformat(price,"____.__")>
			<cfset date3 = dateformat(wos_date,"dd/mm/yyyy")>
			<cfset disc3 = dispec1>
		</cfloop>		
	</cfif>
	
	<cfif getitembal.qtybf neq "">
		<cfset itembal = getitembal.qtybf>	
	</cfif> 
	
	<cfquery name="getrc" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type ="RC" and itemno = "#itemno#" and fperiod <> '99' and (void='' or void is null)
	</cfquery>
	
	<cfif getrc.recordcount gt 0>
		<cfif getrc.sumqty neq "">
			<cfset RCqty = getrc.sumqty>
		</cfif>
	</cfif>
	
	<cfquery name="getpr" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "PR" and itemno = "#itemno#" and fperiod <> '99' and (void='' or void is null)
	</cfquery>
	
	<cfif getpr.recordcount gt 0>
		<cfif getpr.sumqty neq "">
			<cfset PRqty = getpr.sumqty>
		</cfif>
	</cfif>
	
	<cfquery name="getdo" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "DO" and toinv = "" and itemno = "#itemno#" and fperiod <> '99' and (void='' or void is null)
	</cfquery>
	
	<cfif getdo.recordcount gt 0>
		<cfif getdo.sumqty neq "">
			<cfset DOqty = getdo.sumqty>
		</cfif>
	</cfif>

	<cfquery name="getinv" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "INV" and itemno = "#itemno#" and fperiod <> '99' and (void='' or void is null)
	</cfquery>

	<cfif getinv.recordcount gt 0>
		<cfif getinv.sumqty neq "">
			<cfset INVqty = getinv.sumqty>
		</cfif>
	</cfif>
	
	<cfquery name="getcn" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "CN" and itemno = "#itemno#" and fperiod <> '99' and (void='' or void is null)
	</cfquery>
	
	<cfif getcn.recordcount gt 0>
		<cfif getcn.sumqty neq "">
			<cfset CNqty = getcn.sumqty>
		</cfif>
	</cfif>
	
	<cfquery name="getdn" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "DN" and itemno = "#itemno#" and fperiod <> '99' and (void='' or void is null)
	</cfquery>
	
	<cfif getdn.recordcount gt 0>
		<cfif getdn.sumqty neq "">
			<cfset DNqty = getdn.sumqty>
		</cfif>		
	</cfif>
	
	<cfquery name="getcs" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "CS" and itemno = "#itemno#" and fperiod <> '99' and (void='' or void is null)
	</cfquery>
	
	<cfif getcs.recordcount gt 0>
		<cfif getcs.sumqty neq "">
			<cfset CSqty = getcs.sumqty>
		</cfif>		
	</cfif>
	
	<cfquery name="getiss" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "ISS" and itemno = "#itemno#" and fperiod <> '99' and (void='' or void is null)
	</cfquery>
	
	<cfif getiss.recordcount gt 0>
		<cfif getiss.sumqty neq "">
			<cfset ISSqty = getiss.sumqty>
		</cfif>		
	</cfif>
	
	<cfquery name="gettrin" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "TRIN" and itemno = '#itemno#' and fperiod <> '99' and (void='' or void is null)
	</cfquery>
	
	<cfif gettrin.recordcount gt 0>
		<cfif gettrin.sumqty neq "">
			<cfset trinqty = gettrin.sumqty>
		</cfif>		
	</cfif>
		
	<cfquery name="gettrout" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "TROU" and itemno = '#itemno#' and fperiod <> '99' and (void='' or void is null)
	</cfquery>
	
	<cfif gettrout.recordcount gt 0>
		<cfif gettrout.sumqty neq "">
			<cfset troutqty = gettrout.sumqty>
		</cfif>		
	</cfif>
		
	<cfquery name="getoai" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "OAI" and itemno = '#itemno#' and fperiod <> '99' and (void='' or void is null)
	</cfquery>
	
	<cfif getoai.recordcount gt 0>
		<cfif getoai.sumqty neq "">
			<cfset oaiqty = getoai.sumqty>
		</cfif>		
	</cfif>
	
	<cfquery name="getoar" datasource="#dts#">
		select sum(qty)as sumqty from ictran where type = "OAR" and itemno = '#itemno#' and fperiod <> '99' and (void='' or void is null)
	</cfquery>
		
	<cfif getoar.recordcount gt 0>
		<cfif getoar.sumqty neq "">
			<cfset oarqty = getoar.sumqty>
		</cfif>		
	</cfif>
	
	<!--- <cfset balonhand = itembal + rcqty - prqty - doqty - invqty + cnqty - dnqty - csqty - issqty>  ---> 
	<cfset balonhand = itembal + rcqty - prqty - doqty - invqty + cnqty - dnqty - csqty - issqty + trinqty - troutqty + oaiqty - oarqty>  
</cfoutput>


<body>
<cfform name="form1" method="post" action="assm4.cfm?nDateCreate=#nDateCreate#" onsubmit="JavaScript:return data_validation();">

<cfquery name="getbom" datasource="#dts#">
	select * from billmat where itemno = '#form.itemno#' and bomno = '#form.bomno#' group by itemno,bomno,bmitemno order by bmitemno
</cfquery>

<cfset totalprice = 0>

<cfif getproductdetails.bom_cost neq "">
	<cfset xbomcost = getproductdetails.bom_cost>
<cfelse>
	<cfset xbomcost = 0>
</cfif>

<cfoutput query="getbom">	
	<cfquery name="getitem" datasource="#dts#">
		select * from icitem where itemno = '#bmitemno#'
	</cfquery>
    
    	<cfif isdefined('form.movingavrg')>
    <!--- Get average moving cost --->
    <cfset intrantype="'RC','CN','OAI','TRIN'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU','CT'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU','CT'">
	<cfset outtrantypewodo="'INV','PR','DN','CS','ISS','OAR','TROU','CT'">
<cfelse>
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewodo="'INV','PR','DN','CS','ISS','OAR','TROU'">
</cfif>
 <cfquery name="getitem2" datasource="#dts#">
			select a.itemno,a.desp,a.ucost,(ifnull(a.qtybf,0)) as qtybf,b.lastin,c.lastout,d.qin,e.qout,f.rcamt,f.rcqty,g.pramt,g.prqty,h.movqin,i.movqout,ifnull(((ifnull(a.qtybf,0))+ifnull(d.qin,0)-ifnull(e.qout,0)),0) as balance,
							((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0))) as unitcost,
				ifnull((((ifnull(a.qtybf,0))+ifnull(d.qin,0)-ifnull(e.qout,0))*((((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0))*ifnull(a.avcost2,0)+ifnull(f.rcamt,0)-ifnull(g.pramt,0))/((ifnull(a.qtybf,0))+ifnull(h.movqin,0)-ifnull(i.movqout,0)+ifnull(f.rcqty,0)-ifnull(g.prqty,0)))),1) as stockbalance
			
			from icitem as a
	
			left join
			(
				select sum(qty) as lastin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
                and fperiod !='99'
				and (linecode <> 'SV' or linecode is null)
				group by itemno
			) as b on a.itemno=b.itemno
	
			left join
			(
				select sum(qty) as lastout,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (void = '' or void is null) and (toinv='' or toinv is null)
                and fperiod !='99'
				and (linecode <> 'SV' or linecode is null)

				group by itemno
			) as c on a.itemno=c.itemno
	
			left join
			(
				select sum(qty) as qin,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(intrantype)#) and (void = '' or void is null)
                and fperiod !='99'
				and (linecode <> 'SV' or linecode is null)

				group by itemno
			) as d on a.itemno=d.itemno
	
			left join
			(
				select sum(qty) as qout,itemno 
				from ictran
				where type in (#PreserveSingleQuotes(outtrantypewithinv)#) and (void = '' or void is null) and (toinv='' or toinv is null)
                and fperiod !='99'
				and (linecode <> 'SV' or linecode is null)

				group by itemno
			) as e on a.itemno=e.itemno
	
			left join
			(
				select sum(qty) as rcqty,sum(amt) as rcamt,itemno 
				from ictran
				where type='RC' and (void = '' or void is null)
				and fperiod !='99'
				group by itemno
			) as f on a.itemno=f.itemno
	
			left join
			(
				select sum(qty) as prqty,sum(amt) as pramt,itemno 
				from ictran
				where type='PR' and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and fperiod !='99'
				group by itemno
			) as g on a.itemno=g.itemno
	
			left join
			(
				select sum(qty) as movqin,itemno 
				from ictran
				where type='CN' and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null))	and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)

				group by itemno
			) as h on a.itemno=h.itemno
	
			left join
			(
				select sum(qty) as movqout,itemno 
				from ictran
				where type in ('CN','INV') and wos_date=(select max(wos_date) from ictran where type='RC' and (void = '' or void is null)) and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)

				group by itemno
			) as i on a.itemno=i.itemno
	
			left join
			(	
				select (ifnull(bb.sumqty,0)-ifnull(cc.sumqty,0)) as pqty,ifnull(bb.sumqty,0) as pin,ifnull(cc.sumqty,0) as pout,aa.itemno 
				from icitem as aa
				left join
				(
					select sum(qty) as sumqty,itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(intrantype)#) and fperiod='99' 
					and (linecode <> 'SV' or linecode is null)
					group by itemno
				) as bb on aa.itemno=bb.itemno
	
				left join
				(
					select sum(qty) as sumqty, itemno 
					from ictran
					where (void = '' or void is null) and type in (#PreserveSingleQuotes(outtrantypewithinv)#) and fperiod='99' and (toinv='' or toinv is null) 
					and (linecode <> 'SV' or linecode is null)
					group by itemno
				) as cc on aa.itemno=cc.itemno
	
					and aa.itemno ='#bmitemno#'
				
				group by aa.itemno
			) as j on a.itemno = j.itemno
	

			where a.itemno <> ''
			
			and a.itemno ='#bmitemno#'
			
			order by a.itemno;
		</cfquery>
        </cfif>
    <!--- end of average moving cost --->
	 <cfif isdefined('form.movingavrg')>
    <cfif getitem2.balance gt 0>
    <cfset itemprice = getitem2.stockbalance/getitem2.balance>
    
    <cfelse>
    <cfset itemprice = getitem.ucost>
    </cfif>
    <cfelse>
    
	<cfif getitem.price neq "">
		<cfset itemprice = getitem.ucost>
	<cfelse>		
		<cfset itemprice = 0>
	</cfif>
	</cfif>
	<cfset amt1_bil = bmqty * itemprice * currrate>
	<cfset totalprice = totalprice + amt1_bil>
</cfoutput>

<!--- <cfset totalprice = totalprice + xbomcost> --->

<cfoutput> 
  	<input type="hidden" name="bomno" value="#form.bomno#">
  	<input type="hidden" name="desp" value="#form.desp#">
  	<input type="hidden" name="despa" value="#form.despa#">
  	<input type="hidden" name="custno" value="ASSM/999">
  	<input type="hidden" name="nexttranno" value="#nexttranno#">
  	<input type="hidden" name="invoicedate" value="#invoicedate#">
  	<input type="hidden" name="readperiod" value="#form.readperiod#">
  	<input type="hidden" name="currrate" value="#currrate#">
  	<input type="hidden" name="refno3" value="#refno3#">
  	
	<cfif mode eq "Add">
    	<input type="hidden" name="mode" value="ADD">
    <cfelseif mode eq "Edit">
    	<input type ="hidden" name="mode" value="Edit">
    <cfelse>
    	<input type="hidden" name="mode" value="Delete">
  	</cfif>
  	
	<table align="center" class="data">
    	<tr> 
      		<th colspan="6">Invoice Body</th>
    	</tr>
    	<tr> 
      		<th width="73" height="37">Item Code</th>
      		<td colspan="3">#itemno#<input type="hidden" name="itemno" value="#itemno#"></td>
      		<th width="129">Balance on Hand</th>
      		<td width="60"><input name="balance" type="text" size="6" maxlength="10" value="#balonhand#" readonly></td>
    	</tr>
    	<tr> 
      		<th rowspan="2">Description</th>
      		<td colspan="3" nowrap><input name="desp2" type="text" value="#getproductdetails.desp#" size="40" maxlength="40"></td>
      		<th>Qty To Order</th>
      		<td><cfinput name="qty" type="text" id="qty" size="6" maxlength="10" value="#qty#" required="yes" message="Please key in the quantity." validate="integer"></td>
    	</tr>
    	<tr> 
      		<td colspan="3" nowrap><input type="text" name="despa2" value="#getproductdetails.despa#" size="40" maxlength="40"></td> 
			<th>Price</th>
      		<td><input name="price" type="text" size="6" maxlength="10" value="#numberformat(val(totalprice)+val(getproductdetails.bom_cost),".__")#"></td>
    	</tr>
		</cfoutput>
    	<tr> 
      		<th>Location</th>
      		<td colspan="3">
				<select name="location">
          			<option value="">Choose a Location</option>
          			<cfoutput query="getlocation"> 
            			<option value="#getlocation.location#">#location#</option>
          			</cfoutput>
				</select>
			</td>
      		<th>Discount (%)</th>
      		<td><cfoutput><input name="dispec1" type="text" value="#dispec1#" size="6" maxlength="3"></cfoutput></td>
    	</tr>
    	<cfoutput> 
      	<tr> 
        	<th></th>
        	<td></td>
        	<td></td>
        	<td></td>
        	<th>Tax (%)</th>
        	<td><input name="taxpec1" type="text" value="#taxpec1#" size="6" maxlength="3"></td>
      	</tr>
    	</cfoutput> 
	    <cfoutput> 
      	<tr> 
        	<th colspan="4">Last 3 Price / Discount History</th>
      	</tr>
      	<tr> 
        	<td><strong>Date</strong></td>
        	<td width="72"><strong>Price</strong></td>
        	<td width="95">&nbsp;</td>
        	<td width="95"><strong>Discount %</strong></td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
      	</tr>
      	<tr> 
        	<td>#date1#</td>
        	<td>#pricehis1#</td>
        	<td>&nbsp;</td>
        	<td>#disc1#</td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
      	</tr>
      	<tr> 
        	<td>#date2#</td>
        	<td>#pricehis2#</td>
        	<td>&nbsp;</td>
        	<td>#disc2#</td>
        	<td></td>
        	<td>&nbsp;</td>
      	</tr>
      	<tr> 
        	<td>#date3#</td>
        	<td>#pricehis3#</td>
        	<td>&nbsp;</td>
        	<td>#disc3#</td>
        	<td></td>
        	<td>&nbsp;</td>
      	</tr>
        <tr>
        <td style="visibility:hidden">By Moving Average Cost<input type="checkbox" name="movingavrg" id="movingavrg" <cfif isdefined('form.movingavrg')>checked</cfif>></td>
        </tr>
      	<tr> 
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        	<td><input type="button" name="back2" value=" back " onClick="javascript:history.back()">  <input type="submit" name="Submit" value=" #mode# "></td> 
      	</tr>
    	</cfoutput>
  	</table>
</cfform>

</body>
</html>