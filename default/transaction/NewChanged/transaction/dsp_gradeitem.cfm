<cfset frgrade=11>
<cfset tograde=310>
<cfquery name="checkngstk" datasource="#dts#">
SELECT negstk from gsetup
</cfquery>
<cfquery name="getgrade" datasource="#dts#">
	select a.* from icgroup a, icitem b
	where a.wos_group = b.wos_group
    and b.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#">
</cfquery>
<cfif location neq "">
	<cfquery name="getqtybf" datasource="#dts#">
		select * from logrdob
		where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#">
		and location = <cfqueryparam cfsqltype="cf_sql_char" value="#location#">
	</cfquery>
<cfelse>
	<cfquery name="getqtybf" datasource="#dts#">
		select * from itemgrd
		where itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#">
	</cfquery>
</cfif>

<cfquery name="getigrade" datasource="#dts#">
	select * from igrade 
    where type = <cfqueryparam cfsqltype="cf_sql_char" value="#type#">
    and refno = <cfqueryparam cfsqltype="cf_sql_char" value="#refno#">
    and itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#">
	and trancode = <cfqueryparam cfsqltype="cf_sql_char" value="#trancode#">
</cfquery>

<cfset totcol = 4>
<cfset firstcount = 11>
<cfset maxcounter = 310>
<cfset totalrecord = (maxcounter - firstcount + 1)>
<cfset totrow = ceiling(totalrecord / totcol)>

<cfif getigrade.recordcount neq 0>
	<cfloop from="#firstcount#" to="#maxcounter#" index="i">
		<cfif i eq firstcount>
			<cfset oldgrdvaluelist = Evaluate("getigrade.GRD#i#")>
		<cfelse>
			<cfset oldgrdvaluelist = oldgrdvaluelist&","&Evaluate("getigrade.GRD#i#")>
		</cfif>	
	</cfloop>
<cfelse>
	<cfloop from="#firstcount#" to="#maxcounter#" index="i">
		<cfif i eq firstcount>
			<cfset oldgrdvaluelist = "0">
		<cfelse>
			<cfset oldgrdvaluelist = oldgrdvaluelist&",0">
		</cfif>	
	</cfloop>
</cfif>
<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(now(),'yyyy-mm-dd')#" returnvariable="readperiod"/>
<html>
<head>
	<title>Edit Item - Grade Opening Quantity</title>
	<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function checkqty(){
			var totalrecord = document.itemform.totalrecord.value;
			var firstcount = document.itemform.firstcount.value;
			var maxcounter = document.itemform.maxcounter.value;
			oldgrdvaluelist = document.itemform.oldgrdvaluelist.value;
			
			var totqty = 0;
			
			varlist = document.itemform.varlist.value;
			bgrdlist = document.itemform.bgrdlist.value;
			var newArray = varlist.split(",");
			
			newlistvalue = "";
			for(i=0;i<newArray.length;i++){
				totqty = totqty + parseInt(document.getElementById(newArray[i]).value);
				if(i==0){
					newlistvalue = document.getElementById(newArray[i]).value;
				}
				else{
					newlistvalue = newlistvalue + "," + document.getElementById(newArray[i]).value;
				}
			}
			document.itemform.qtybflist.value = newlistvalue;
			
			<cfif type eq "ISS" or type eq "OAI" or type eq "OAR" or type eq "TROU" or type eq "TR" or type eq "TRIN">
				opener.document.form1.qty.value = totqty;
			<cfelse>
				opener.document.form1.qt6.value = totqty;
			</cfif>
			
			opener.document.form1.grdcolumnlist.value = varlist;
			opener.document.form1.grdvaluelist.value = newlistvalue;
			opener.document.form1.totalrecord.value = totalrecord;
			opener.document.form1.bgrdcolumnlist.value = bgrdlist;
			opener.document.form1.oldgrdvaluelist.value = oldgrdvaluelist;
			<cfif type eq "ISS" or type eq "OAI" or type eq "OAR" or type eq "TROU" or type eq "TR" or type eq "TRIN">
			<cfelse>
			window.opener.checkqty();
			</cfif>
			window.close();
		}
	</script>
	
<style type="text/css">
.demoDiv{			
	background-color: #FFFAFA;
}
</style>

</head>
<cfinclude template = "../../CFC/convert_single_double_quote_script.cfm">
<body onLoad="document.getElementById('grd11').focus()"> 

<cfloop from="#firstcount#" to="#maxcounter#" index="i">
	<cfif i eq firstcount>
		<cfset mylist = i>
		<cfset varlist = "grd"&i>
		<cfset bgrdlist = "bgrd"&i>
	<cfelse>
		<cfset mylist = mylist&","&i>
		<cfset varlist = varlist&",grd"&i>
		<cfset bgrdlist = bgrdlist&",bgrd"&i>
	</cfif>	
</cfloop>

<cfset myArray = ListToArray(mylist,",")>
<form name="itemform">
<cfoutput>
	<input type="hidden" name="itemno" value="#convertquote(itemno)#">
	<input type="hidden" name="firstcount" value="#firstcount#">
	<input type="hidden" name="maxcounter" value="#maxcounter#">
	<input type="hidden" name="totalrecord" value="#totalrecord#">
	<input type="hidden" name="varlist" value="#varlist#">
	<input type="hidden" name="bgrdlist" value="#bgrdlist#">
	<input type="hidden" name="qtybflist" value="">
	<input type="hidden" name="oldgrdvaluelist" value="#oldgrdvaluelist#">
</cfoutput>
<cfif location neq "">
<cfquery name="getiteminfo" datasource="#dts#">
	select 
	<cfloop from="#frgrade#" to="#tograde#" index="i">
		(ifnull(e.qin#i#,0)) as qin#i#,
		(ifnull(f.qout#i#,0)) as qout#i#,
		(ifnull(a.grd#i#,0)+ifnull(c.getlastin#i#,0)-ifnull(d.getlastout#i#,0)) as qtybf#i#,
		(ifnull(a.grd#i#,0)+ifnull(c.getlastin#i#,0)-ifnull(d.getlastout#i#,0)+ifnull(e.qin#i#,0)-ifnull(f.qout#i#,0)) as balance#i#,
	</cfloop>
	b.*
			
	from logrdob as a 
			
	left join
	(
		select x.itemno,x.desp as itemdesp,x.wos_group,x.category,x.graded,y.desp as groupdesp
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
		and fperiod+0 < '01' 
		and (void = '' or void is null)  
		and factor2 > 0
        and location = <cfqueryparam cfsqltype="cf_sql_char" value="#location#">
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
		and fperiod+0 < '01' 
		and (void = '' or void is null) 
		and generated=''
		and factor2 > 0 
        and location = <cfqueryparam cfsqltype="cf_sql_char" value="#location#">
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
        and location = <cfqueryparam cfsqltype="cf_sql_char" value="#location#">
			and fperiod+0 between '01' and '#readperiod#'
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
        and location = <cfqueryparam cfsqltype="cf_sql_char" value="#location#">
			and fperiod+0 between '01' and '#readperiod#' 
		group by itemno
	) as f on a.itemno=f.itemno
		
	where b.graded = 'Y'
		and b.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#">
        and a.location = <cfqueryparam cfsqltype="cf_sql_char" value="#location#">
	order by b.wos_group,b.itemno
</cfquery>

<cfelse>
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
		select x.itemno,x.desp as itemdesp,x.wos_group,x.category,x.graded,y.desp as groupdesp
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
		and fperiod+0 < '01' 
		and (void = '' or void is null)  
		and factor2 > 0
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
		and fperiod+0 < '01' 
		and (void = '' or void is null) 
		and generated=''
		and factor2 > 0 
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
			and fperiod+0 between '01' and '#readperiod#'
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
			and fperiod+0 between '01' and '#readperiod#' 
		group by itemno
	) as f on a.itemno=f.itemno
		
	where b.graded = 'Y'
		and b.itemno = <cfqueryparam cfsqltype="cf_sql_char" value="#itemno#">
	order by b.wos_group,b.itemno
</cfquery>
</cfif>
<table border="0" align="center" width="100%" cellpadding="0" cellspacing="0">

<tr>
		<td colspan="100%" align="center">
			<input type="button" value="Ok" onClick="checkqty();">
		</td>
</tr>
	<cfloop from="1" to="#totrow#" index="i">
		<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
			<cfloop from="0" to="#totcol-1#" index="j">
				<cfset thisrecord = i+(j*totrow)>
				<cfif thisrecord LTE totalrecord>
					<cfoutput>
						<cfif Evaluate("getgrade.GRADD#myArray[thisrecord]#") neq "">
							<cfset balance = evaluate('getiteminfo.balance#myArray[thisrecord]#')>
							<td>#Evaluate("getgrade.GRADD#myArray[thisrecord]#")# </td>
							<td>
                            
                            
								<cfif balance neq 0>
									<cfset thisqtybf = balance>
								<cfelse>
									<cfset thisqtybf = 0>
								</cfif>
                                <cfif getigrade.recordcount neq 0>
									<cfset thisqty = Evaluate("getigrade.GRD#myArray[thisrecord]#")>
								<cfelse>
									<cfset thisqty = 0>
								</cfif>
                                <input type="text" value="#thisqty#" size="8" id="grd#myArray[thisrecord]#" name="grd#myArray[thisrecord]#" onBlur="if(this.value==''){this.value = '0'}" 
								<cfif checkngstk.negstk eq "0" and thisqtybf lte 0 and type neq "RC" and type neq "CN" and type neq "OAI" and type neq "TRIN">
								readonly 
								</cfif>>
								<input type="text" class="demoDiv" value="#thisqtybf#" size="8" id="onhand_grd#myArray[thisrecord]#" name="onhand_grd#myArray[thisrecord]#" onBlur="if(this.value==''){this.value = '0'}" disabled>
							</td>
						<cfelse>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<input type="hidden" value="0" size="8" id="grd#myArray[thisrecord]#" name="grd#myArray[thisrecord]#">
						</cfif>
					</cfoutput>
				</cfif>
			</cfloop>
		</tr>
	</cfloop>
	<tr><td colspan="100%" align="center" height="10"></td></tr>
    <!---
	<tr>
		<td colspan="100%" align="center">
			<input type="button" value="Ok" onClick="checkqty();">
		</td>
	</tr>--->
</table>
</form>
</body>
</html>