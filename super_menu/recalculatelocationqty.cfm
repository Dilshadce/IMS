<html>
<head>
<title>QIN QOUT RECALCULATE</title>
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
<form action="" method="post" onSubmit="if(confirm('Are you sure want to Recalculate LOC OPENNING QTY?')){ColdFusion.Window.show('processing');return true;} else {return false;}">
<H1>Update Location Opening Qty</H1>

<h3>Caution: This Function Will Calculate and Update The Location Opening Quantity After Year End.<br>
	This Function Can Only Run Once After the Year End Process.
</h3>
	<table>
		<tr>
			<td>Current Closing Date</td>
			<td>:</td>
			<td><input type="text" name="closingdate" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"></td>
		</tr>
		<tr>
			<td>Last Closing Date</td>
			<td>:</td>
			<td><input type="text" name="lastclosingdate" onKeyUp="DateFormat(this,this.value,event,false,'3');" onBlur="DateFormat(this,this.value,event,true,'3');"></td>
		</tr>
		
		<tr><td colspan="3"><input type="submit" name="submit" value="Calculate"></td></tr>
	</table>
</form>
<cfif submit eq 'Calculate'>
	<cfif form.lastclosingdate eq "">
		Please insert the Last Closing Date!<cfabort>
	</cfif>
	<cfif form.closingdate eq "">
		Please insert the Current Closing Date!<cfabort>
	</cfif>
	<cfset date1 = createDate(ListGetAt(form.closingdate,3,"/"),ListGetAt(form.closingdate,2,"/"),ListGetAt(form.closingdate,1,"/"))>
	<cfset date3 = createDate(ListGetAt(form.lastclosingdate,3,"/"),ListGetAt(form.lastclosingdate,2,"/"),ListGetAt(form.lastclosingdate,1,"/"))>
	
        <cfset currentDirectory = "C:\Inetpub\wwwroot\IMS\super_menu\backupdata\"& dts>
<cfif DirectoryExists(currentDirectory) eq false>
<cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>
<cfset filename=dts&"_"&dateformat(now(),'YYYYMMDD')&"_"&timeformat(now(),'HHMMSS')&"_"&GetAuthUser()&"_RECALLOC.sql">
<cfset currentdirfile=currentDirectory&"\"&filename>

<cfset currentURL =  CGI.SERVER_NAME>
<cfif mid(currentURL,'4','3') eq "pro">
<cfset serverhost = "localhost">
<cfset servername = "root">
<cfset serverpass = "Toapayoh831">
<cfelseif mid(currentURL,'4','1') eq "2">
<cfset serverhost = "169.254.228.112">
<cfset servername = "appserver2">
<cfset serverpass = "Nickel266(">
<cfelse>
<cfset serverhost = "169.254.228.112">
<cfset servername = "appserver1">
<cfset serverpass = "Nickel266(">
</cfif>

<cfexecute name = "C:\inetpub\wwwroot\IMS\mysqldump"
    arguments = "--host=#serverhost# --user=#servername# --password=#serverpass# #dts#" outputfile="#currentdirfile#" timeout="720">
</cfexecute>

<cfset filesize = GetFileInfo('#currentdirfile#').size >

<cfif filesize lt 200000>
<h1>Backup Failed! Please contact System Administrator!</h1>
<cfabort>
</cfif>
    
	<cfquery name="create1" datasource="#dts#">
		CREATE TABLE IF NOT EXISTS locqdbf_last_year LIKE locqdbf
	</cfquery>
	
	<cftry>
		<cfquery name="getrecord" datasource="#dts#">
			SELECT qtybf_actual FROM locqdbf limit 1
		</cfquery>
	<cfcatch type="any">
		<cfquery name="alter1" datasource="#dts#">
			ALTER TABLE locqdbf_last_year drop PRIMARY KEY
		</cfquery>
		<cfquery name="alter2" datasource="#dts#">
			ALTER TABLE locqdbf_last_year add entryno int(50) PRIMARY KEY NOT NULL auto_increment;
		</cfquery>
		<cfquery name="alter3" datasource="#dts#">
			ALTER TABLE locqdbf ADD COLUMN qtybf_actual varchar(10)
		</cfquery>	
	</cfcatch>
	</cftry>
		
	<cftry>
		<cfquery name="getrecord" datasource="#dts#">
			SELECT LastAccDate FROM locqdbf_last_year limit 1
		</cfquery>
			
		<cfcatch type="database">
			<cfquery name="alter4" datasource="#dts#">
				ALTER TABLE locqdbf_last_year ADD COLUMN LastAccDate Date
			</cfquery>
			<cfquery name="alter5" datasource="#dts#">
				ALTER TABLE locqdbf_last_year ADD COLUMN ThisAccDate Date
			</cfquery>
		</cfcatch>
	</cftry>
	
	<cfquery name="checkexist" datasource="#dts#">
		SELECT * FROM locqdbf_last_year
		WHERE LastAccDate = #date3#
		and ThisAccDate = #date1#
		limit 1
	</cfquery>
	
	<cfif checkexist.recordcount neq 0>
		You have ran the Calculation before. 
	<cfelse>
		<cfquery name="insert" datasource="#dts#">
			INSERT INTO locqdbf_last_year
			(`ITEMNO`,`LOCATION`,`LOCQFIELD`,`LOCQACTUAL`,`LOCQTRAN`,`LMINIMUM`,`LREORDER`,`QTY_BAL`,`VAL_BAL`,
			`PRICE`,`WOS_GROUP`,`CATEGORY`,`SHELF`,`SUPP`)  
			SELECT `ITEMNO`,`LOCATION`,`LOCQFIELD`,`LOCQACTUAL`,`LOCQTRAN`,`LMINIMUM`,`LREORDER`,`QTY_BAL`,`VAL_BAL`,
			`PRICE`,`WOS_GROUP`,`CATEGORY`,`SHELF`,`SUPP` FROM locqdbf
		</cfquery>
		
		<cfquery datasource="#dts#" name="update">
			Update locqdbf_last_year
			set LastAccDate = #date3#,
			ThisAccDate = #date1#
			where LastAccDate is null
		</cfquery>
		
		<cfquery name="gettotalqty" datasource="#dts#">
			select a.itemno,a.location,
			ifnull(a.locqfield,0) as qtybf,
			ifnull(b.qout,0) as qout,ifnull(c.doqty,0) as doqty,ifnull(d.qin,0) as qin
			from locqdbf as a
			
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
		</cfquery>
		
		<cfloop query="gettotalqty">
			<cfset balonhand = gettotalqty.qtybf + gettotalqty.qin - gettotalqty.qout - gettotalqty.doqty>
			
			<!--- <cfif val(balonhand) gte 0> --->
				<cfquery name="updateqtf" datasource="#dts#">
					update locqdbf set 
					locqfield = '#val(balonhand)#',
					qtybf_actual=''
					where itemno =<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettotalqty.itemno#">
					and location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettotalqty.location#">
				</cfquery><!--- 
			<cfelse>
				<cfquery name="updateqtf" datasource="#dts#">
					update locqdbf set 
					locqfield=0,
					qtybf_actual='#val(balonhand)#'
					where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettotalqty.itemno#">
					and location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettotalqty.location#">
				</cfquery>
			
			</cfif> --->
		</cfloop>
		
		You have finish the Calculation. 
	</cfif>
</cfif>
</body>
<cfwindow name="processing" width="300" height="300" initshow="false" center="true" closable="false" draggable="false" title="Processing....Please Wait" modal="true" resizable="false" >
<h1>Processing....Please Wait</h1>
<img src="/images/loading.gif" align="middle" />
</cfwindow>
</html>