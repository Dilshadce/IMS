<html>
<head>
<title>Location Opening Qty Recalculate (After yearend)</title>
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
<H1>Location Opening Qty Recalculate (After yearend)</H1>
<cftry>
	<cfquery name="getprevlastaccyear" datasource="#dts#">
		select LastAccDate,ThisAccDate FROM locqdbf_last_year group by LastAccDate,ThisAccDate order by LastAccDate desc limit 1
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
			select LastAccDate,ThisAccDate FROM locqdbf_last_year
			where LastAccDate = #form.lastaccdaterange#
			limit 1
		</cfquery>
		<cfset date3=createDate(year(getdate.LastAccDate),month(getdate.LastAccDate),day(getdate.LastAccDate))>
		<cfset date1=createDate(year(getdate.ThisAccDate),month(getdate.ThisAccDate),day(getdate.ThisAccDate))>
	<cfelse>
		<cfabort>
	</cfif>
	
	<!--- STEP 3: UPDATE THE QTYBF --->
	<cfquery name="gettotalqty" datasource="#dts#">
		select a.itemno,a.location,
		ifnull(a.locqfield,0) as qtybf,
		ifnull(b.qout,0) as qout,ifnull(c.doqty,0) as doqty,ifnull(d.qin,0) as qin
		from locqdbf_last_year as a
			
		left join
		(
			select itemno,location,sum(qty) as qout 
			from ictran 
			where type in (#PreserveSingleQuotes(outtrantype)#)  
			and fperiod='99' 
			and (void = '' or void is null)  
			and (linecode <> 'SV' or linecode is null)
			and wos_date <= #date1#
			and wos_date > #date3#
			group by itemno,location
		) as b on (a.itemno=b.itemno and a.location=b.location)
			
		left join
		(
			select itemno,location,sum(qty) as doqty 
			from ictran as a
			where type = 'INV' 
			and refno not in (select refno from iclink as b where frtype='DO' and type='INV' and b.itemno = a.itemno group by refno)
			and fperiod='99' 
			and (void = '' or void is null)
			and (linecode <> 'SV' or linecode is null)
			and wos_date <= #date1#
			and wos_date > #date3#
			group by itemno,location
		) as c on (a.itemno=c.itemno and a.location=c.location)
			
		left join
		(
			select itemno,location,sum(qty) as qin 
			from ictran 
			where type in (#PreserveSingleQuotes(intrantype)#)
			and fperiod='99' 
			and (void = '' or void is null) 
			and (linecode <> 'SV' or linecode is null) 
			and wos_date <= #date1#
			and wos_date > #date3#
			group by itemno,location
		) as d on (a.itemno = d.itemno and a.location=d.location)
		
		where a.LastAccDate = #date3# and a.ThisAccDate = #date1#
	</cfquery>
		
	<cfloop query="gettotalqty">
		<cfset balonhand = gettotalqty.qtybf + gettotalqty.qin - gettotalqty.qout - gettotalqty.doqty>
			
		<cfquery name="updateqtf" datasource="#dts#">
			update locqdbf set 
			locqfield = '#val(balonhand)#',
			qtybf_actual=''
			where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettotalqty.itemno#">
			and location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettotalqty.location#">
		</cfquery>
	</cfloop>
	
	You have finish the recalculate qtybf. 
</cfif>
</body>


</html>
