<html>
<head>
<title>Year End Processing</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<script language="javascript" src="../scripts/date_format.js"></script>

<cfparam name="submit" default="">
<cfset intrantype="'RC','CN','OAI','TRIN'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'DO','PR','CS','DN','ISS','OAR','TROU','CT'">
<cfelse>
	<cfset outtrantype="'DO','PR','CS','DN','ISS','OAR','TROU'">
</cfif>

<body>
<cfoutput>
<form action="" method="post">
<H1>Year End Process Recovery</H1>

	<table>
		<tr>
			<td>Actual Closing Date</td>
			<td>:</td>
			<td><input type="text" name="closingdate" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"></td>
		</tr>
		<tr>
			<td>Last Closing Date</td>
			<td>:</td>
			<td><input type="text" name="lastclosingdate" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"></td>
		</tr>
		<!---tr>
			<td>Last Ran Period</td>
			<td>:</td>
			<td><input type="text" name="lastperiod" value=""></td>
		</tr--->
		<tr><td colspan="3"><input type="submit" name="submit" value="Submit"></td></tr>
	</table>
</form>
</cfoutput>
<cfif submit eq 'Submit'>
	<cftry>
		<cfquery name="check" datasource="#dts#">
			select LastAccDate from icitem_last_year limit 1
		</cfquery>
	<cfcatch type="database">
		<cfquery name="alter1" datasource="#dts#">
			ALTER TABLE icitem_last_year ADD COLUMN LastAccDate Date
		</cfquery>
		<cfquery name="alter1" datasource="#dts#">
			ALTER TABLE icitem_last_year ADD COLUMN ThisAccDate Date
		</cfquery>
	</cfcatch>
	
	</cftry>
	<!---cfquery datasource="#dts#" name="getGeneralInfo">
		Select lastaccyear, year(lastaccyear) as lyear,period from GSetup
	</cfquery--->
	<!--- <cfset period = - (val(form.lastperiod))>
	<cfset olddate = DateAdd("m", period, getGeneralInfo.lastaccyear)>
	<cfset oldyear = year(olddate)> --->
	<cfif form.closingdate eq "" or form.lastclosingdate eq "">
		Please insert the Actual Closing Date!<cfabort>
	</cfif>
	<cfset date3 = createDate(ListGetAt(form.lastclosingdate,3,"/"),ListGetAt(form.lastclosingdate,2,"/"),ListGetAt(form.lastclosingdate,1,"/"))>
	<cfset oldyear = year(date3)>
	<cfset date1 = createDate(ListGetAt(form.closingdate,3,"/"),ListGetAt(form.closingdate,2,"/"),ListGetAt(form.closingdate,1,"/"))>
	<cfset date2 = createDate(year(now()),month(now()),day(DaysInMonth(createDate(year(now()),month(now()),day(now())))))>
	<cfset date_diff = dateDiff("m",date1,date2)>
	<cfif abs(date_diff) gt 18>
		<cfoutput>The Actual Closing Date Not Available!</cfoutput><cfabort>
	</cfif>
	<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#form.closingdate#" returnvariable="cperiod"/>
	
	<cfset newaccyear = lsdateformat(date1, 'yyyy-mm-dd')>
	
	<!--- STEP 1. UPDATE THE LAST ACCOUNT YEAR --->
	<cfquery name="updategsetup" datasource="#dts#">
		update gsetup set lastaccyear = '#newaccyear#'
	</cfquery>
	<!--- Add on 080708 --->
	<cfquery name="update" datasource="#dts#">
		update icitem_last_year 
		set LastAccDate = #date3#,
		ThisAccDate = '#newaccyear#'
		where EDI_ID = '#ListGetAt(form.lastclosingdate,3,"/")#'
		and LastAccDate = #date3#
	</cfquery>
	
	<!--- STEP 2.UPDATE THE ARTRAN & ICTRAN FPERIOD --->
	<cfquery datasource="#dts#" name="getartran">
		Select * from artran
		where wos_date > #date1#
	</cfquery>
	
	<cfoutput>
	<cfloop query="getartran">
		<cfset thisdate = getartran.wos_date>
		<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#thisdate#" returnvariable="cperiod"/>
		
		<cfquery name="updateperiod" datasource="#dts#">
			update artran set fperiod = '#cperiod#' where type = '#getartran.type#' and refno = '#getartran.refno#'
		</cfquery>
		<cfif getartran.type eq "TR">
			<cfquery name="updateperiod" datasource="#dts#">
				update ictran set fperiod = '#cperiod#' where type in ('TRIN','TROU') and refno = '#getartran.refno#'
			</cfquery>
			<cfquery name="updateperiod" datasource="#dts#">
				update igrade set fperiod = '#cperiod#' where type in ('TRIN','TROU') and refno = '#getartran.refno#'
			</cfquery>
		<cfelse>
			<cfquery name="updateperiod" datasource="#dts#">
				update ictran set fperiod = '#cperiod#' where type = '#getartran.type#' and refno = '#getartran.refno#'
			</cfquery>
			<cfquery name="updateperiod" datasource="#dts#">
				update igrade set fperiod = '#cperiod#' where type = '#getartran.type#' and refno = '#getartran.refno#'
			</cfquery>
		</cfif>		
		<cfquery name="updateperiod" datasource="#dts#">
			update iserial set fperiod = '#cperiod#' where type = '#getartran.type#' and refno = '#getartran.refno#'
		</cfquery>		
		<cfquery name="updateperiod" datasource="#dts#">
			update artranat set fperiod = '#cperiod#' where type = '#getartran.type#' and refno = '#getartran.refno#'
		</cfquery>
	</cfloop>
	</cfoutput>
	
	<!--- STEP 3: UPDATE THE QTYBF --->
	<!--- <cfset date3 = createDate(ListGetAt(form.lastclosingdate,3,"/"),ListGetAt(form.lastclosingdate,2,"/"),ListGetAt(form.lastclosingdate,1,"/"))> --->
	<cfquery name="getolditem" datasource="#dts#">
		select a.itemno,ifnull(a.qtybf,0) as qtybf,
		ifnull(b.qin,0) as qin,
		ifnull(c.qout,0) as qout,
		ifnull(d.doqty,0) as doqty
		from icitem_last_year as a
		
		left join
		(
			select itemno,sum(qty) as qin 
			from ictran 
			where type in (#PreserveSingleQuotes(intrantype)#) 
			and fperiod='99' 
			and (void = '' or void is null)  
			and (linecode <> 'SV' or linecode is null)
			and wos_date <= #date1#
			and wos_date > #date3#
			group by itemno
		) as b on a.itemno = b.itemno
		
		left join
		(
			select itemno,sum(qty) as qout 
			from ictran 
			where type in (#PreserveSingleQuotes(outtrantype)#)  
			and fperiod='99' 
			and (void = '' or void is null)  
			and (linecode <> 'SV' or linecode is null)
			and wos_date <= #date1#
			and wos_date > #date3#
			group by itemno
		) as c on a.itemno=c.itemno
		
		left join
		(
			select itemno,sum(qty) as doqty 
			from ictran as a
			where type = 'INV' 
			and refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno)
			and fperiod='99' 
			and (void = '' or void is null)
			and (linecode <> 'SV' or linecode is null)
			and wos_date <= #date1#
			and wos_date > #date3#
			group by itemno
		) as d on a.itemno=d.itemno
		
		
		where a.edi_id = #oldyear#
	</cfquery>
	
	<cfloop query="getolditem">
		<cfset balonhand = getolditem.qtybf + getolditem.qin - getolditem.qout - getolditem.doqty>
		
		<!--- <cfif val(balonhand) gte 0> --->
			<cfquery name="updateqtf" datasource="#dts#">
				update icitem set 
				qtybf = '#balonhand#',
				qtybf_actual=''
				where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getolditem.itemno#">
			</cfquery>
		<!--- <cfelse>
			<cfquery name="updateqtf" datasource="#dts#">
				update icitem set 
				qtybf=0,
				qtybf_actual='#balonhand#'
				where itemno = '#getolditem.itemno#'
			</cfquery>
		</cfif> --->
	</cfloop>
	
	<!--- STEP 4: UPDATE QIN/ QOUT IN ICITEM BY PERIOD (RECALCULATE) --->	
	<!--- <cfquery name="getictranin" datasource="#dts#">
		select sum(qty) as qin , itemno, fperiod
		from ictran 
		where type in ('RC','CN','OAI','TRIN')
		and fperiod<>'99' 
		and (void = '' or void is null)  
		group by itemno, fperiod
	</cfquery> --->
	<cfquery name="getictranin" datasource="#dts#">
		select sum(qty) as qin , itemno, fperiod
		from ictran 
		where type in (#PreserveSingleQuotes(intrantype)#)
		and fperiod<>'99' 
		and (void = '' or void is null) 
		and (linecode <> 'SV' or linecode is null)
		group by itemno, fperiod
	</cfquery>

	<!--- <cfquery name="getictranout" datasource="#dts#">
		select sum(qty) as qout , itemno, fperiod
		from ictran 
		where (void = '' or void is null) and fperiod<>'99' 
		and (type in ('INV','PR','CS','DN','ISS','OAR','TROU') or (type = 'DO' and toinv=''))  
		group by itemno, fperiod
	</cfquery> --->
	<cfquery name="getictranout" datasource="#dts#">
		select sum(qty) as qout , itemno, fperiod
		from ictran as a
		where (void = '' or void is null) and fperiod<>'99' 
		and (linecode <> 'SV' or linecode is null)
		and (type in (#PreserveSingleQuotes(outtrantype)#) or 
		(type='INV' and refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno)))  
		group by itemno, fperiod
	</cfquery>

	<!--- INITIALIZE THE QIN/QOUT IN ICITEM --->
	<cfquery name="InitializeIcitem" datasource="#dts#">
		update icitem 
		set qin11= 0,
		qin12= 0,
		qin13= 0,
		qin14= 0,
		qin15= 0,
		qin16= 0,
		qin17= 0,
		qin18= 0,
		qin19= 0,
		qin20= 0,
		qin21= 0,
		qin22= 0,
		qin23= 0,
		qin24= 0,
		qin25= 0,
		qin26= 0,
		qin27= 0,
		qin28= 0, 
		qout11 = 0,
		qout12 = 0,
		qout13 = 0,
		qout14 = 0,
		qout15 = 0,
		qout16 = 0,
		qout17 = 0,
		qout18 = 0,
		qout19 = 0,
		qout20 = 0,
		qout21 = 0,
		qout22 = 0,
		qout23 = 0,
		qout24 = 0,
		qout25 = 0,
		qout26 = 0,
		qout27 = 0,
		qout28 = 0
	</cfquery>
	
	<cftry>
		<cfloop query="getictranin">
			
			<cfset qname = 'QIN'&(getictranin.fperiod+10)>
			<cfquery name="UpdateIcitem" datasource="#dts#">
				update icitem set #qname#= #getictranin.qin# 
				where itemno = '#getictranin.itemno#'
			</cfquery>
		</cfloop>
		<cfcatch type="any">
			<cfoutput>Failed to update QIN. #cfcatch.Message# - #cfcatch.SQLState#.</cfoutput>
		</cfcatch>
	</cftry>
	
	<cftry>
		<cfloop query="getictranout">
			<cfset qname = 'QOUT'&(getictranout.fperiod+10)>
			<cfquery name="UpdateIcitem" datasource="#dts#">
				update icitem set #qname#= #getictranout.qout# 
				where itemno = '#getictranout.itemno#'
			</cfquery>
		</cfloop>
		<cfcatch type="any">
			<cfoutput>Failed to update QOUT. #cfcatch.Message# - #cfcatch.SQLState#.</cfoutput>
		</cfcatch>
	</cftry>
	
	You have finish the recovery. 
</cfif>
</body>


</html>
