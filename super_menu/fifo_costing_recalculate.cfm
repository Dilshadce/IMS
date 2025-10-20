<html>
<head>
<title>FIFO Costing Calculation After Year-End</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../../stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<script language="javascript" src="../scripts/date_format.js"></script>

</head>
<cfquery name="getfifocal" datasource="#dts#">
SELECT fifocal,includemisc FROM gsetup
</cfquery>

<cfparam name="submit" default="">
<cfset intrantype="'RC','CN','OAI'">
<cfif lcase(HcomID) eq "eocean_i">
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','CT'">
<cfelse>
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR'">
</cfif>

<body>
<form action="" method="post" onSubmit="if(confirm('Are you sure want to Recalculate FIFO?')){ColdFusion.Window.show('processing');return true;} else {return false;}">
<H1>FIFO Costing Calculation After Year-End</H1>

<h3>Caution: This Function Will Recalculate All The Cost and Update The Table fifoopq. Only for FIFO Costing Method. <br>
	You Have To Do This Function After the Year End Process.
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
		<tr>
        <td></td><td></td>
        <td><input type="checkbox" name="misccost" id="misccost" value="yes" <cfif getfifocal.includemisc eq '1'>checked</cfif>> <label for="include0">With Misc Cost</label>
            </td>
        </tr>
		<tr><td colspan="3"><input type="submit" name="submit" value="Recalculate"></td></tr>
	</table>
</form>

<cfif submit eq 'Recalculate'>
	<cfif form.lastclosingdate eq "">
		Please insert the Last Closing Date!<cfabort>
	</cfif>
	<cfif form.closingdate eq "">
		Please insert the Current Closing Date!<cfabort>
	</cfif>
    
	<cfset date1 = createDate(ListGetAt(form.closingdate,3,"/"),ListGetAt(form.closingdate,2,"/"),ListGetAt(form.closingdate,1,"/"))>
	<cfset date3 = createDate(ListGetAt(form.lastclosingdate,3,"/"),ListGetAt(form.lastclosingdate,2,"/"),ListGetAt(form.lastclosingdate,1,"/"))>
	<!---cfquery datasource="#dts#" name="getGeneralInfo">
		Select lastaccyear, year(lastaccyear) as lyear,period from GSetup
	</cfquery--->
	<!--- <cfquery name="getoutqty" datasource="#dts#">
		select sum(qty) as qout,itemno 
		from ictran
		where type in ('INV','PR','DN','CS','ISS','OAR','DO') 
		and (void = '' or void is null) and toinv=''
		and fperiod = '99'
		and wos_date <= #date1#
		and wos_date > #date3# 
    	group by itemno
	</cfquery> --->
    
    <cfset currentDirectory = "C:\Inetpub\wwwroot\IMS\super_menu\backupdata\"& dts>
<cfif DirectoryExists(currentDirectory) eq false>
<cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>
<cfset filename=dts&"_"&dateformat(now(),'YYYYMMDD')&"_"&timeformat(now(),'HHMMSS')&"_"&GetAuthUser()&"_RECALFIFO.sql">
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

<cfquery name="getall" datasource="#dts#">
select refno from iclink as b where frtype='DO' and type='INV' group by refno
</cfquery>

	<cfquery name="getoutqty" datasource="#dts#">
		select a.itemno,ifnull(b.qout,0)+ifnull(c.doqty,0) as qout
		from icitem as a
		
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
		) as b on a.itemno=b.itemno
		
		left join
		(
			select itemno,sum(qty) as doqty 
			from ictran as a
			where type = 'INV' 
			and refno not in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getall.refno)#" separator="," list="yes">)
			and fperiod='99' 
			and (void = '' or void is null)
			and (linecode <> 'SV' or linecode is null)
			and wos_date <= #date1#
			and wos_date > #date3#
			group by itemno
		) as c on a.itemno=c.itemno
	</cfquery>
	
	<cfquery name="create1" datasource="#dts#">
		CREATE TABLE IF NOT EXISTS fifoopq_last_year LIKE fifoopq
	</cfquery>

	<cftry>
		<cfquery name="getrecord" datasource="#dts#">
			SELECT LastAccDate FROM fifoopq_last_year limit 1
		</cfquery>
		
		<cfcatch type="database">
			<cfquery name="alter1" datasource="#dts#">
				ALTER TABLE fifoopq_last_year drop PRIMARY KEY
			</cfquery>
			
			<cfquery name="alter3" datasource="#dts#">
				ALTER TABLE fifoopq_last_year add entryno int(50) PRIMARY KEY NOT NULL auto_increment
			</cfquery>
			
			<cfquery name="alter4" datasource="#dts#">
				ALTER TABLE fifoopq_last_year ADD COLUMN LastAccDate Date
			</cfquery>
			<cfquery name="alter5" datasource="#dts#">
				ALTER TABLE fifoopq_last_year ADD COLUMN ThisAccDate Date
			</cfquery>
		</cfcatch>
	</cftry>
    
    <cfloop from="11" to="50" index="i">
    <cfquery name="updatenull" datasource="#dts#">
    UPDATE fifoopq SET FFD#i# = "0000-00-00" where ffd#i# is null
    </cfquery>
    </cfloop>
	
	<cfquery name="insert" datasource="#dts#">
		INSERT INTO fifoopq_last_year
		(`ITEMNO`,`FFQ11`,`FFQ12`,`FFQ13`,`FFQ14`,`FFQ15`,`FFQ16`,`FFQ17`,`FFQ18`,`FFQ19`,`FFQ20`,`FFQ21`,
		`FFQ22`,`FFQ23`,`FFQ24`,`FFQ25`,`FFQ26`,`FFQ27`,`FFQ28`,`FFQ29`,`FFQ30`,`FFQ31`,`FFQ32`,`FFQ33`,`FFQ34`,
		`FFQ35`,`FFQ36`,`FFQ37`,`FFQ38`,`FFQ39`,`FFQ40`,`FFQ41`,`FFQ42`,`FFQ43`,`FFQ44`,`FFQ45`,`FFQ46`,`FFQ47`,
		`FFQ48`,`FFQ49`,`FFQ50`,`FFC11`,`FFC12`,`FFC13`,`FFC14`,`FFC15`,`FFC16`,`FFC17`,`FFC18`,`FFC19`,`FFC20`,
		`FFC21`,`FFC22`,`FFC23`,`FFC24`,`FFC25`,`FFC26`,`FFC27`,`FFC28`,`FFC29`,`FFC30`,`FFC31`,`FFC32`,`FFC33`,
		`FFC34`,`FFC35`,`FFC36`,`FFC37`,`FFC38`,`FFC39`,`FFC40`,`FFC41`,`FFC42`,`FFC43`,`FFC44`,`FFC45`,`FFC46`,
		`FFC47`,`FFC48`,`FFC49`,`FFC50`,`FFD11`,`FFD12`,`FFD13`,`FFD14`,`FFD15`,`FFD16`,`FFD17`,`FFD18`,`FFD19`,
		`FFD20`,`FFD21`,`FFD22`,`FFD23`,`FFD24`,`FFD25`,`FFD26`,`FFD27`,`FFD28`,`FFD29`,`FFD30`,`FFD31`,`FFD32`,
		`FFD33`,`FFD34`,`FFD35`,`FFD36`,`FFD37`,`FFD38`,`FFD39`,`FFD40`,`FFD41`,`FFD42`,`FFD43`,`FFD44`,`FFD45`,
		`FFD46`,`FFD47`,`FFD48`,`FFD49`,`FFD50`)
		SELECT `ITEMNO`,`FFQ11`,`FFQ12`,`FFQ13`,`FFQ14`,`FFQ15`,`FFQ16`,`FFQ17`,`FFQ18`,`FFQ19`,`FFQ20`,`FFQ21`,
		`FFQ22`,`FFQ23`,`FFQ24`,`FFQ25`,`FFQ26`,`FFQ27`,`FFQ28`,`FFQ29`,`FFQ30`,`FFQ31`,`FFQ32`,`FFQ33`,`FFQ34`,
		`FFQ35`,`FFQ36`,`FFQ37`,`FFQ38`,`FFQ39`,`FFQ40`,`FFQ41`,`FFQ42`,`FFQ43`,`FFQ44`,`FFQ45`,`FFQ46`,`FFQ47`,
		`FFQ48`,`FFQ49`,`FFQ50`,`FFC11`,`FFC12`,`FFC13`,`FFC14`,`FFC15`,`FFC16`,`FFC17`,`FFC18`,`FFC19`,`FFC20`,
		`FFC21`,`FFC22`,`FFC23`,`FFC24`,`FFC25`,`FFC26`,`FFC27`,`FFC28`,`FFC29`,`FFC30`,`FFC31`,`FFC32`,`FFC33`,
		`FFC34`,`FFC35`,`FFC36`,`FFC37`,`FFC38`,`FFC39`,`FFC40`,`FFC41`,`FFC42`,`FFC43`,`FFC44`,`FFC45`,`FFC46`,
		`FFC47`,`FFC48`,`FFC49`,`FFC50`,`FFD11`,`FFD12`,`FFD13`,`FFD14`,`FFD15`,`FFD16`,`FFD17`,`FFD18`,`FFD19`,
		`FFD20`,`FFD21`,`FFD22`,`FFD23`,`FFD24`,`FFD25`,`FFD26`,`FFD27`,`FFD28`,`FFD29`,`FFD30`,`FFD31`,`FFD32`,
		`FFD33`,`FFD34`,`FFD35`,`FFD36`,`FFD37`,`FFD38`,`FFD39`,`FFD40`,`FFD41`,`FFD42`,`FFD43`,`FFD44`,`FFD45`,
		`FFD46`,`FFD47`,`FFD48`,`FFD49`,`FFD50` FROM fifoopq
	</cfquery>
	
	<!--- <cfquery datasource="#dts#" name="update">
		Update fifoopq_last_year
		set LastAccDate = #date3#,
		ThisAccDate = #getGeneralInfo.lastaccyear#
		where LastAccDate is null
	</cfquery> --->
	
	<cfquery datasource="#dts#" name="update">
		Update fifoopq_last_year
		set LastAccDate = #date3#,
		ThisAccDate = #date1#
		where LastAccDate is null
	</cfquery>
	
	<cfquery name="create" datasource="#dts#">
		create table temp_fifocost 
		as
		select itemno, qty, ifnull(if(type='CN',it_cos/qty,<cfif isdefined('form.misccost')>((amt+M_charge1+M_charge2+M_charge3+M_charge4+M_charge5+M_charge6+M_charge7)/qty)<cfelse><cfif getfifocal.fifocal eq "1">if(coalesce(currrate,0)=0,price_bil*1,price_bil*currrate)<cfelse>amt/qty</cfif></cfif>),0) as price, wos_date, type, refno
		from ictran 
		where type in (#PreserveSingleQuotes(intrantype)#)
		and fperiod='99' 
		and (void = '' or void is null)
		and toinv=''   
		and (linecode <> 'SV' or linecode is null)
		and wos_date <= #date1#
		and wos_date > #date3# 
		order by itemno, wos_date desc,trdatetime desc
	</cfquery>
	
	<cfquery name="alter3" datasource="#dts#">
		ALTER TABLE temp_fifocost add entryno int(50) PRIMARY KEY NOT NULL auto_increment;
	</cfquery>
	
	<cfloop index="i" from="11" to="50">    
		<cfquery name="getold" datasource="#dts#">
			select FFQ#i# as qty, FFC#i# as price, FFD#i# as wos_date, itemno 
			from fifoopq
			where FFQ#i# !='0'
		</cfquery>
		<cfloop query="getold">
			<cfquery name="insert" datasource="#dts#">
				insert into temp_fifocost 
				(itemno, qty, price, wos_date)
				values
				(<cfqueryparam cfsqltype="cf_sql_varchar" value="#getold.itemno#">,'#getold.qty#','#getold.price#',
                <cfif getold.wos_date eq "">
                <cfset getold.wos_date = "0000-00-00">
				</cfif>
                #getold.wos_date#)
			</cfquery>
		</cfloop>
	</cfloop>

	<cfquery name="update" datasource="#dts#">
		update fifoopq
		set 
		<cfloop index="i" from="11" to="49">
			FFQ#i# = 0,
			FFC#i# = 0,
			FFD#i# = '0000-00-00',
		</cfloop>
		FFQ50 = 0,
		FFC50 = 0,
		FFD50 = '0000-00-00'
	</cfquery>

	<cfquery name="alter" datasource="#dts#">
		alter table temp_fifocost add column qout double(17,5)
	</cfquery>

	<cfloop query="getoutqty">
		<cfquery name="update" datasource="#dts#">
			update temp_fifocost
			set qout = #getoutqty.qout#
			where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getoutqty.itemno#">
		</cfquery>
	</cfloop>

	<cfquery name="getcost" datasource="#dts#">
		select * from temp_fifocost 
		order by itemno asc, wos_date asc, entryno desc
	</cfquery>
	
	<cfset thisitemno = "">
	<cfset baloutqty = 0>
	<cfloop query="getcost">
		<cfif getcost.itemno neq thisitemno>
			<cfset thisitemno = getcost.itemno>
			<cfset baloutqty = val(getcost.qout)>
		</cfif>
		<cfif baloutqty gt 0>
			<cfset baloutqty = val(getcost.qty) - val(baloutqty)>
			<cfif baloutqty lt 0>
				<cfset baloutqty = abs(baloutqty)>
				<!--- <cfquery name="updateqty" datasource="#dts#">
					update temp_fifocost
					set qty = 0
					where itemno = '#thisitemno#'
					and refno = '#getcost.refno#'
					and type = '#getcost.type#'
				</cfquery> --->
				<cfquery name="updateqty" datasource="#dts#">
					update temp_fifocost
					set qty = 0
					where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#thisitemno#">
					and entryno = '#getcost.entryno#'
				</cfquery>
			<cfelse>
				<!--- <cfquery name="updateqty" datasource="#dts#">
					update temp_fifocost
					set qty = #baloutqty#
					where itemno = '#thisitemno#'
					and refno = '#getcost.refno#'
					and type = '#getcost.type#'
				</cfquery> --->
				<cfquery name="updateqty" datasource="#dts#">
					update temp_fifocost
					set qty = #baloutqty#
					where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#thisitemno#">
					and entryno = '#getcost.entryno#'
				</cfquery>
				<cfset baloutqty = 0>
			</cfif>
		</cfif>
	</cfloop>

	<!--- REMARK ON 30-04-2009 AND REPLACE WITH THE BELOW ONE --->
	<!--- <cfquery name="get_tempfifocost" datasource="#dts#">
		select * from temp_fifocost 
		where itemno != ''
		order by itemno, wos_date desc
	</cfquery> --->
	<!--- <cfquery name="get_tempfifocost" datasource="#dts#">
		select * from temp_fifocost 
		where itemno != ''
		order by itemno, entryno
	</cfquery> --->
	<cfquery name="get_tempfifocost" datasource="#dts#">
		select * from temp_fifocost 
		where itemno != ''
		order by itemno, entryno 
	</cfquery>

	<cfset temp_itemno = "">
	<cfset i = 0>
	<cfloop query="get_tempfifocost">
		<cfif get_tempfifocost.itemno neq temp_itemno>
			<cfset temp_itemno = get_tempfifocost.itemno>
			<cfset i = 11>
			
			<cfquery name="checkexist" datasource="#dts#">
				select itemno from fifoopq
				where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#temp_itemno#">
			</cfquery>
			<cfif checkexist.recordcount eq 0>
				<cfquery name="insert" datasource="#dts#">
					insert into fifoopq
					(itemno)
					values
					(<cfqueryparam cfsqltype="cf_sql_varchar" value="#temp_itemno#">)
				</cfquery>
			</cfif>
		
		
			<cfquery name="update" datasource="#dts#">
				update fifoopq
				set 
				FFQ#i# = #get_tempfifocost.qty#,
				FFC#i# = #get_tempfifocost.price#,
                <cfif get_tempfifocost.wos_date eq "">
                <cfset get_tempfifocost.wos_date = "0000-00-00">
                </cfif>
				FFD#i# = #get_tempfifocost.wos_date#
				where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#temp_itemno#">
			</cfquery>
		<cfelse>
			<cfset i = i + 1>
			<cfif i lte 50>
				<cfquery name="update" datasource="#dts#">
					update fifoopq
					set 
					FFQ#i# = #get_tempfifocost.qty#,
					FFC#i# = #get_tempfifocost.price#,
                    <cfif get_tempfifocost.wos_date eq "">
					<cfset get_tempfifocost.wos_date = "0000-00-00">
                    </cfif>
					FFD#i# = #get_tempfifocost.wos_date#
					where itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#temp_itemno#">
				</cfquery>
			</cfif>
		</cfif>
	</cfloop>
	<cfquery name="drop" datasource="#dts#">
		drop table temp_fifocost 
	</cfquery>
	You have finish the recalculate. 
</cfif>
</body>
<cfwindow name="processing" width="300" height="300" initshow="false" center="true" closable="false" draggable="false" title="Processing....Please Wait" modal="true" resizable="false" >
<h1>Processing....Please Wait</h1>
<img src="/images/loading.gif" align="middle" />
</cfwindow>
</html>