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
<H1>Opening Qty Recalculate (After yearend)</H1>
<cftry>
	<cfquery name="getprevlastaccyear" datasource="#dts#">
		select LastAccDate,ThisAccDate FROM icitem_last_year group by LastAccDate,ThisAccDate order by LastAccDate desc limit 1
	</cfquery>

<cfcatch type="any">
	<h3>This function not available currently.</h3><cfabort>
</cfcatch>
</cftry>

<cfoutput>
<form action="" method="post">
	<table>
		<tr>
      		<th width="20%">Transaction Range</th>
	      	<td width="*">&nbsp;
				<cfoutput>
				<select name="lastaccdaterange">
	          		<cfloop query="getprevlastaccyear">
	            		<option value="#getprevlastaccyear.LastAccDate#">#dateformat(getprevlastaccyear.LastAccDate,"dd/mm/yyy")# - #dateformat(getprevlastaccyear.ThisAccDate,"dd/mm/yyy")#</option>
	          		</cfloop>
				</select>
				</cfoutput>
			</td>
	    </tr>
	    <cfif getprevlastaccyear.recordcount neq 0>
			<tr><td colspan="2"><input type="submit" name="submit" value="Submit"></td></tr>
		</cfif>
	</table>
</form>
</cfoutput>
<cfif submit eq 'Submit'>
	<cfif isdefined("form.lastaccdaterange") and form.lastaccdaterange neq "">
		<cfquery name="getdate" datasource="#dts#">
			select LastAccDate,ThisAccDate FROM icitem_last_year
			where LastAccDate = #form.lastaccdaterange#
			limit 1
		</cfquery>
		<cfset date3=createDate(year(getdate.LastAccDate),month(getdate.LastAccDate),day(getdate.LastAccDate))>
		<cfset date1=createDate(year(getdate.ThisAccDate),month(getdate.ThisAccDate),day(getdate.ThisAccDate))>
		<cfset oldyear = year(date3)>
	<cfelse>
		<cfabort>
	</cfif>
	
	<!--- STEP 3: UPDATE THE QTYBF --->
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
		<cfquery name="updateqtf" datasource="#dts#">
			update icitem set 
			qtybf = '#balonhand#',
			qtybf_actual=''
			where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getolditem.itemno#">
		</cfquery>
	</cfloop>
	
	You have finish the recalculate. 
</cfif>
</body>


</html>
