<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Item Balance Enquires</title>
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<cfquery name="getmodule" datasource="#dts#">
	SELECT * 
	FROM modulecontrol;
</cfquery>

<cfquery name="getdoupdated" datasource="#dts#">
    SELECT frrefno 
    FROM iclink 
    WHERE frtype = "DO" 
    <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
        AND itemno BETWEEN '#form.productfrom#' AND '#form.productto#' 
    </cfif>
    GROUP BY frrefno
</cfquery>

<cfset billupdated=valuelist(getdoupdated.frrefno)>

<cfquery datasource="#dts#" name="getitem">
	select 
	a.itemno,
	a.desp,
	a.despa,
	a.unit,
	a.price,
	a.packing,
	a.category,
	a.wos_group,
    a.ucost,
    ifnull(b.sumtotalin,0) as qtyin,
    ifnull(c.sumtotalout,0) as qtyout,
	ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0) as balance,
	ifnull(a.qtybf,0) as openbal
	from icitem as a
	
	left join 
	(
		select itemno,sum(qty) as sumtotalin 
		from ictran 
		where type in ('RC','CN','OAI','TRIN') 
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and itemno between '#form.productfrom#' and '#form.productto#' 
			</cfif>
		
		and fperiod<>'99'
		and (void = '' or void is null)
		group by itemno
	) as b on a.itemno=b.itemno
	
	left join 
	(
		select itemno,sum(qty) as sumtotalout 
		from ictran 
		where
		<cfif isdefined('form.dodate')>
                (type in ('DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>) or 
				(type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))
				<cfelse>

		type in ('INV','DO','DN','CS','OAR','PR','ISS','TROU'<cfif lcase(HcomID) eq "remo_i">,'SO'</cfif>)
		and (toinv='' or toinv is null)
		</cfif>
		<cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
			and itemno between '#form.productfrom#' and '#form.productto#' 
			</cfif>
		and fperiod<>'99'
		and (void = '' or void is null) 
		
		group by itemno
	) as c on a.itemno=c.itemno
	
	where 1=1
    <cfif trim(form.productfrom) neq "" and trim(form.productto) neq "">
    AND	a.itemno between '#form.productfrom#' and  '#form.productto#' 
    </cfif>
    <cfif isdefined('form.negative')>
    AND ifnull(ifnull(a.qtybf,0)+ifnull(b.sumtotalin,0)-ifnull(c.sumtotalout,0),0)<0
    </cfif>
    AND (a.itemtype <> 'SV' or a.itemtype is null)
    ORDER BY a.itemno
</cfquery>

<cfquery name="getgsetup" datasource="#dts#">
	select lcategory,lgroup from gsetup
</cfquery>

<body>
<h1><center>Item Balance Enquires</center></h1>
<cfoutput>
	<h2>
    Item - #form.productfrom# to #form.productto#
	</h2><br><br><br>
	
	<table align="center" class="data" width="95%">
		<tr> 
    		<th>Item No.</th>
    		<th>Name</th>
			<th>#getgsetup.lcategory#</th>
			<th>#getgsetup.lgroup#</th>	
            <cfif lcase(hcomid) eq "hyray_i">
            <th>In</th>
            <th>Out</th>	
            </cfif>
            <cfif getmodule.auto eq 1>
            <th>Supplier</th>
            <th>Cost</th>
            </cfif>
    		<th><cfif lcase(hcomid) eq "hyray_i">Balance<cfelse>On Hand</cfif></th>
			<cfif lcase(hcomid) eq "hyray_i"><th>Cost Price</th></cfif>
            <th><cfif lcase(hcomid) eq "hyray_i">Selling Price<cfelse>Price</cfif></th>
    		<th>Unit</th>
			<th>Packing</th>
		</tr>
		<cfloop query="getitem">
		<tr> 
     	 	<td>#getitem.itemno#</td>
      		<td>#getitem.desp#<br>#getitem.despa#</td>
	  		<td>#getitem.category#</td>
	  		<td>#getitem.wos_group#</td>
            <cfif lcase(hcomid) eq "hyray_i">
            <td>#getitem.qtyin#</td>
            <td>#getitem.qtyout#</td>
            </cfif>
            <cfif getmodule.auto eq 1>
            
            <cfquery name="getsupplier" datasource="#dts#">
			select custno,name from ictran where itemno='#getitem.itemno#' and type in ('RC','PO')
			</cfquery>
            <td>#getsupplier.custno#-#getsupplier.name#</td>
            <td align="right">#numberformat(getitem.ucost,",.____")#</td>
            </cfif>
      		<td><div align="center"><font color="FF0000"><a href="/default/report-stock/stockcard3.cfm?itemno=#getitem.itemno#&itembal=#getitem.openbal#&pf=&pt=&cf=&ct=&pef=&pet=&gpf=&gpt=&df=&dt=&sf=&st=&thislastaccdate=&dodate=Y">#getitem.balance#</a></font></div></td>
            <cfif lcase(hcomid) eq "hyray_i">
            <td align="right">#numberformat(getitem.ucost,",.____")#</td>
            </cfif>
	  		<td align="right">#numberformat(getitem.price,",.____")#</td>
      		<td>#getitem.unit#</td>
	  		<td>#getitem.packing#</td>
    	</tr></cfloop>
	</table>
</cfoutput>

<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>