<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script language="javascript" type="text/javascript" src="/scripts/ajax.js"></script>
 <title>PRODUCTION PLANNING</title>
</head>
<body>

<cfquery name="getgeneral" datasource="#dts#">
	select a.compro,date_format(a.lastaccyear,'%Y-%m-%d') as lastaccyear,concat(',.',repeat('_',b.decl_uprice))as decl_uprice,agentlistuserid
	from gsetup as a, gsetup2 as b;
</cfquery>

<h4>
<cfif getpin2.h1J10 eq 'T'><a href="bom.cfm">Create B.O.M</a> </cfif><cfif getpin2.h1J20 eq 'T'>|| <a href="vbom.cfm">List B.O.M</a> </cfif><cfif getpin2.h1J30 eq 'T'>|| <a href="bom.cfm">Search B.O.M</a> </cfif><cfif getpin2.h1J40 eq 'T'>|| <a href="genbomcost.cfm">Generate 
    Cost</a> </cfif><cfif getpin2.h1J50 eq 'T'>|| <a href="checkmaterial.cfm">Check Material</a> </cfif><cfif getpin2.h1J60 eq 'T'>|| <a href="useinwhere.cfm">Use In Where</a> || <a href="bominforecast.cfm">Bom Item Forecast by SO</a></cfif>|| <a href="createproduction.cfm?type=Create">Create Production Planning</a>|| <a href="productionlist_newest.cfm?refno=sono">Production Planning List</a></h4>


<cfoutput>

<cfif isdefined('url.type')>
<cfif url.type eq 'Edit'>
<cfset xitemno=url.itemno>
<cfset xperiod=url.period>
<cfset button='Edit'>
</cfif>
<cfif url.type eq 'Delete'>
<cfset xitemno=url.itemno>
<cfset xperiod=url.period>
<cfset button='Delete'>
</cfif>
<cfelse>



<cfset xitemno=form.itemno>
<cfset xperiod=form.period>
<cfset button='Create'>

<cfquery name="checkrecordexist" datasource="#dts#">
    select itemno from productplanning where itemno='#xitemno#' and fperiod = '#xperiod#'
</cfquery>

<cfif checkrecordexist.recordcount gt 0>
<h3>This Production planning already existed.</h3> <input type="button" name="back" id="back" value="Close" onclick="window.close();" />
<cfabort>
</cfif>

</cfif>

<script type="text/javascript">
function calculate1()
	{
		for(i=1;i<=document.getElementById('totalrecord').value;i++)
		{
		document.getElementById('needqty1_'+i).value=document.getElementById('bomqty1_'+i).value*document.getElementById('qty').value;

		document.getElementById('bal1_'+i).value=document.getElementById('qtybf1_'+i).value-document.getElementById('needqty1_'+i).value
		}
	}

</script>
<cfform name="create" id="create" action="productprocess.cfm" method="post">

<table width="90%">
<tr>
<th colspan="100%"><div align="left">Finish Goods :#xitemno#
<input type="hidden" name="itemno" id="itemno" value="#xitemno#" readonly /></div>
</th>

</tr>


<tr>
<th>BOM Balance</th>

<th colspan='4'>#dateformat(dateadd('m',xperiod,getgeneral.lastaccyear),"mmm yy")#</th>
</tr>

<cfquery name="getproduction" datasource="#dts#">
select * from productplanning where itemno='#xitemno#' and fperiod='#xperiod#'
</cfquery>  
<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td><input type="hidden" name="period" id="period" value="#xperiod#" /></td>

<td colspan='4'><div align="right"><input type="text"  size="7" name="qty" id="qty" value="#getproduction.qty#" onkeyup="calculate1();"/></div></td> 

</tr>


<tr>
<th>Bom Item</th>
<th>Balance</th>
<th>Previous Month</th>
<th>NeedQty</th>
<th>Bal</th>

</tr>

<cfquery name="getbomlist" datasource="#dts#">
	select bmitemno,bmqty from billmat where itemno='#xitemno#'
</cfquery>

<cfloop query="getbomlist">

<cfquery name="getitembalance" datasource="#dts#">
    select 
	itemno,qtybf
	from icitem
	where itemno='#getbomlist.bmitemno#' 
</cfquery>

<cfquery name="getin" datasource="#dts#">
		select fperiod,sum(qty) as sumtotalin 
		from ictran 
		where type in ('RC','CN','OAI','TRIN') 
		and itemno='#getbomlist.bmitemno#' 
        and fperiod <= '#xperiod#'
		and fperiod<>'99'
		and (void = '' or void is null)
        group by fperiod
</cfquery>

<cfquery name="getout" datasource="#dts#">
		select fperiod,sum(qty) as sumtotalout 
		from ictran 
		where type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) 
		and itemno='#getbomlist.bmitemno#' 
		and fperiod<>'99'
        and fperiod <= '#xperiod#'
		and (void = '' or void is null)
		and (toinv='' or toinv is null) 
        group by fperiod
</cfquery>

<cfset reserve1=0>
<cfset reserve2=0>

<cfquery name="getallfgitemlist" datasource="#dts#">
	select itemno,bmqty from billmat where bmitemno='#getbomlist.bmitemno#' group by itemno
</cfquery>

<cfloop query="getallfgitemlist">

<cfif getallfgitemlist.itemno eq xitemno>
<cfquery name="getreserve" datasource="#dts#">
    select sum(qty) as qty from productplanning where itemno='#getallfgitemlist.itemno#' and fperiod < '#xperiod#'
</cfquery>
<cfset reserve1=reserve1+(val(getreserve.qty)*getbomlist.bmqty)>
<cfelse>
<cfquery name="getreserve2" datasource="#dts#">
    select sum(qty) as qty from productplanning where itemno='#getallfgitemlist.itemno#' and fperiod <= '#xperiod#'
</cfquery>
<cfset reserve2=reserve2+(val(getreserve2.qty)*getbomlist.bmqty)>
</cfif>


</cfloop>

<cfset in1=val(getin.sumtotalin)>

<cfset out1=val(getout.sumtotalout)>



<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td nowrap>#getbomlist.bmitemno#</td>

<td align="right">#val(getitembalance.qtybf)+val(in1)-val(out1)#<!--- -val(reserve2) ---></td>
<td align="right">#reserve1#<input type="hidden" name="qtybf1_#getbomlist.currentRow#" id="qtybf1_#getbomlist.currentRow#" value="#val(getitembalance.qtybf)+val(in1)-val(out1)-val(reserve2)-val(reserve1)#" />
<input type="hidden" name="bomqty1_#getbomlist.currentRow#" id="bomqty1_#getbomlist.currentRow#" value="#getbomlist.bmqty#" />
</td>
<td><input type="text" size="6"  readonly name="needqty1_#getbomlist.currentRow#" id="needqty1_#getbomlist.currentRow#" value="#getbomlist.bmqty*val(getproduction.qty)#" /></td>
<td><input type="text" size="6"  readonly name="bal1_#getbomlist.currentRow#" id="bal1_#getbomlist.currentRow#" value="#(val(getitembalance.qtybf)+val(in1)-val(out1)-val(reserve2)-val(reserve1))-(val(getbomlist.bmqty)*val(getproduction.qty))#" /></td>

</tr>


</cfloop>
<input type="hidden" name="totalrecord" id="totalrecord" value="#getbomlist.recordcount#" />

<tr><td colspan="100%" align="center"><input type="submit" name="submit" id="submit" value="#button#" /></td></tr>
</table>

</cfform>
</cfoutput>

</body>
</html>
