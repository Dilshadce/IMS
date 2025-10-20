<html>
<head>
<title>IMPORT TXT FILE TO IMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<cfquery name="getgsetup" datasource="#dts#">
	select * from gsetup
</cfquery>


<cfparam name="uploadoai" default="">

<body>
<cfoutput>
<form action="importOAI.cfm" method="post" enctype="multipart/form-data">
<H1>Import Txt File To Generate Stock Adjustment</H1>
<table align="center" class="data">
	<tr><td colspan="3"><div align="center"><font color="##FF0000" size="2"><strong>IMPORT FILE</strong></font></div></td></tr>
	<tr>
    	<th>Step</th>
        <th>Description</th>
        <th>File</th>
    </tr>
    <tr>
    	<td>1.</td>
        <td>Get File From Local Disk</td>
        <td><font size="2">
        	<input type="file" name="getoai" id="getoai" size="25">
        </font></td>
    </tr>
    <tr>
    <td colspan="100%" align="center">
        <input type="submit" name="uploadoai" id="uploadoai" value="Submit">
        </font></td>
    </tr>
</table>

</form>
</cfoutput>
<cfoutput>
<cfif uploadoai eq 'Submit'>
	<cfset intrantype="'RC','CN','OAI','TRIN'">
	<cfset outtrantype="'DO','DN','PR','CS','ISS','OAR','TROU'">
	<cfset outtrantypewithinv="'INV','DO','DN','PR','CS','ISS','OAR','TROU'">
    <cfset outtrantypewithinv1="'DO','DN','PR','CS','ISS','OAR','TROU'">

<cfquery name="getdoupdated" datasource="#dts#">
SELECT frrefno FROM iclink WHERE frtype = "DO" 
group by frrefno
</cfquery>
<cfset billupdated=valuelist(getdoupdated.frrefno)>

		<CFFILE DESTINATION="C:/inetpub/wwwroot/IMS/default/importoai/importoai_#dts#.txt" ACTION="UPLOAD" FILEFIELD="form.getoai" attributes="normal" nameconflict="overwrite">
		<h2>You have FTP File successfully.</h2>
    
		<cfquery name="import" datasource="#dts#">
			load data infile "C:/inetpub/wwwroot/IMS/default/importoai/importoai_#dts#.txt" into table importoai_temp fields terminated by ',' enclosed by '"' lines terminated by '\r\n'
            (@col1,@col2,@col3,@col4)

SET wos_date = @col1,
time = @col2,
code = @col3,
itemno = @col4,
status = ''
            
            ;
		</cfquery>
		
        <cfquery name="updatestatus" datasource="#dts#">
			update importoai_temp
			set created_on=#now()#
			where status=''
		</cfquery>
        
		<h2>You have load the file successfully.</h2>
    
		<cfquery name="gettempitem" datasource="#dts#">
			select itemno,count(itemno) as qty from importoai_temp
			where (status='' or status is null) group by itemno
		</cfquery>
		<cfif gettempitem.recordcount neq 0>
        
        <cfparam name="tranoai" default="">
		<cfparam name="oaisql" default="">
		<cfparam name="oaitotal" default=0>
        <cfparam name="tranoar" default="">
		<cfparam name="oarsql" default="">
		<cfparam name="oartotal" default=0>
        
        <cfquery name="get_running_no" datasource="#dts#">
			select lastusedno as oaino,(select lastusedno as oaino from refnoset where counter = "1" and type = "OAR") as oarno from refnoset where counter = "1" and type = "OAI"   
		</cfquery>
		
		<cfset refnocheck = 0>
		<cfset refno1 = get_running_no.oaino>
        <cfloop condition="refnocheck eq 0">
        <cftry>
        <cfinvoke component="cfc.incrementValue" method="getIncreament" returnvariable="nexttranno1">
			<cfinvokeargument name="input" value="#refno1#">
		</cfinvoke>
		<cfcatch>
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#get_running_no.oaino#" returnvariable="nexttranno1" />	
		</cfcatch>
        </cftry>
        <cfquery name="checkexistence" datasource="#dts#">
        SELECT refno FROM artran WHERE 
        refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno1#"> and type = 'OAI'
        </cfquery>
        <cfif checkexistence.recordcount eq 0>
        <cfset refnocheck = 1>
        <cfelse>
        <cfset refno1 = nexttranno1>
		</cfif>
        </cfloop>
        
        
        <cfquery name="get_running_no2" datasource="#dts#">
			select lastusedno as oarno,(select lastusedno as oarno from refnoset where counter = "1" and type = "OAR") as oarno from refnoset where counter = "1" and type = "OAR"   
		</cfquery>
		
		<cfset refnocheck2 = 0>
		<cfset refno2 = get_running_no2.oarno>
        <cfloop condition="refnocheck2 eq 0">
        <cftry>
        <cfinvoke component="cfc.incrementValue" method="getIncreament" returnvariable="nexttranno2">
			<cfinvokeargument name="input" value="#refno2#">
		</cfinvoke>
		<cfcatch>
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#get_running_no2.oarno#" returnvariable="nexttranno2" />	
		</cfcatch>
        </cftry>
        <cfquery name="checkexistence" datasource="#dts#">
        SELECT refno FROM artran WHERE 
        refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#nexttranno2#"> and type = 'OAR'
        </cfquery>
        <cfif checkexistence.recordcount eq 0>
        <cfset refnocheck2 = 1>
        <cfelse>
        <cfset refno2 = nexttranno2>
		</cfif>
        </cfloop>
        
        <cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(now(),'yyyy-mm-dd')#" returnvariable="fperiod"/>
        
        <cfloop query="gettempitem">
        
        <cfquery name="getitemdetail" datasource="#dts#">
			select 
			a.itemno,
			a.desp,
			a.unit,
            a.ucost,
			ifnull(d.qin,0) as qin,
			ifnull(e.qout,0) as qout,
			a.qtybf,
			(ifnull(a.qtybf,0)+ifnull(d.qin,0)-ifnull(e.qout,0)) as balance
		
			from icitem as a
	
			left join
			(
				select itemno,sum(qty) as qin 
				from ictran 
				where type in (#PreserveSingleQuotes(intrantype)#)
				and fperiod<>'99' 
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
                and itemno='#gettempitem.itemno#'
				group by itemno
			) as d on a.itemno = d.itemno
	
			left join
						(
				select itemno,sum(qty) as qout 
				from ictran a
				where 
                (type in (#PreserveSingleQuotes(outtrantypewithinv1)#) or 
				(type='INV' and (dono = "" or dono is null or dono not in (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#billupdated#">))))

				and fperiod<>'99' 
				and (void = '' or void is null)
				and (linecode <> 'SV' or linecode is null)
				and itemno='#gettempitem.itemno#'
				group by itemno
			) as e on a.itemno=e.itemno
	
			where a.itemno ='#gettempitem.itemno#'
			group by a.itemno 
			order by a.itemno 
		</cfquery>
        
        
        <cfif val(getitemdetail.balance) lt val(gettempitem.qty)>
		<cfset tranoai = "y">
						<cfset oaiqty = val(gettempitem.qty)-val(getitemdetail.balance)>
						<cfset oaicost = val(getitemdetail.ucost)>
						<cfset oaisubtotal = val(oaiqty) * val(oaicost)>
						<cfset oaitotal = val(oaitotal) + val(oaisubtotal)>
						<cfset oaisql= oaisql&"("&chr(34)&"OAI"&chr(34)&","&chr(34)&nexttranno1&chr(34)&","&chr(34)&gettempitem.currentrow&chr(34)&","&chr(34)&fperiod&chr(34)&","&chr(34)&lsdateformat(now(),"yyyy-mm-dd")&chr(34)&","&chr(34)&"1"&chr(34)&","&chr(34)&gettempitem.currentrow&chr(34)&","&chr(34)&jsstringformat(gettempitem.itemno)&chr(34)&","&chr(34)&jsstringformat(getitemdetail.desp)&chr(34)&","&chr(34)&jsstringformat(getitemdetail.unit)&chr(34)&","&chr(34)&oaiqty&chr(34)&","&chr(34)&oaicost&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&oaiqty&chr(34)&","&chr(34)&oaicost&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&oaisubtotal&chr(34)&","&chr(34)&"IMPORT ADJUSTMENT"&chr(34)&")"&iif(gettempitem.currentrow neq gettempitem.recordcount,DE(","),DE(""))>
        <cfelseif val(getitemdetail.balance) gt val(gettempitem.qty)>
        
        <cfset tranoar = "y">
						<cfset oarqty = val(getitemdetail.balance)-val(gettempitem.qty)>
						<cfset oarcost = getitemdetail.ucost>
						<cfset oarsubtotal = oarqty * oarcost>
						<cfset oartotal = oartotal + oarsubtotal>
						<cfset oarsql= oarsql&"("&chr(34)&"OAR"&chr(34)&","&chr(34)&nexttranno2&chr(34)&","&chr(34)&gettempitem.currentrow&chr(34)&","&chr(34)&fperiod&chr(34)&","&chr(34)&lsdateformat(now(),"yyyy-mm-dd")&chr(34)&","&chr(34)&"1"&chr(34)&","&chr(34)&gettempitem.currentrow&chr(34)&","&chr(34)&jsstringformat(gettempitem.itemno)&chr(34)&","&chr(34)&jsstringformat(getitemdetail.desp)&chr(34)&","&chr(34)&jsstringformat(getitemdetail.unit)&chr(34)&","&chr(34)&oarqty&chr(34)&","&chr(34)&oarcost&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&oarqty&chr(34)&","&chr(34)&oarcost&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&oarsubtotal&chr(34)&","&chr(34)&"IMPORT ADJUSTMENT"&chr(34)&")"&iif(gettempitem.currentrow neq gettempitem.recordcount,DE(","),DE(""))>
        
        </cfif>
        
        
        </cfloop>
        
        <cfif tranoai eq "y">
        <cfquery name="insert_oai_into_artran" datasource="#dts#">
					insert ignore into artran 
					(
						type,
						refno,
						trancode,
						fperiod,
						wos_date,
						desp,
						currrate,
						gross_bil,
						net_bil,
						grand_bil,
						credit_bil,
						invgross,
						net,
						grand,
						creditamt,
						currrate2,
						name,
                        userid,
                        custno,
                        trdatetime
					)
					values
					(
						'OAI',
						'#nexttranno1#',
						'1',
						'#fperiod#',
						'#dateformat(now(),'yyyy-mm-dd')#',
						'IMPORT ADJUSTMENT',
						'1',
						'#oaitotal#',
						'#oaitotal#',
						'#oaitotal#',
						'#oaitotal#',
						'#oaitotal#',
						'#oaitotal#',
						'#oaitotal#',
						'#oaitotal#',
						'1',
						'ADJUSTMENT',
                        '#huserid#',
                        '#huserid#',
                        now()
					);
				</cfquery>
				
				<cfquery name="insert_oai_into_ictran" datasource="#dts#">
					insert ignore into ictran 
					(
						type,
						refno,
						trancode,
						fperiod,
						wos_date,
						currrate,
						itemcount,
						itemno,
						desp,
						unit,
						qty_bil,
						price_bil,
						amt1_bil,
						amt_bil,
						qty,
						price,
						amt1,
						amt,
						name
					) 
					values 
					#oaisql#;
				</cfquery>
                <cfquery name="update_ictran" datasource="#dts#">
                update ictran set trdatetime=now() where type='OAI' and refno='#nexttranno1#'
                </cfquery>
                
                <cfquery name="update_oai_running_no" datasource="#dts#">
					update refnoset set
					lastusedno='#nexttranno1#'
                    WHERE type = "OAI" and counter = "1";
				</cfquery>
                
		</cfif>
        
        <cfif tranoar eq "y">
        
        <cfquery name="insert_oar_into_artran" datasource="#dts#">
					insert ignore into artran 
					(
						type,
						refno,
						trancode,
						fperiod,
						wos_date,
						desp,
						currrate,
						gross_bil,
						net_bil,
						grand_bil,
						credit_bil,
						invgross,
						net,
						grand,
						creditamt,
						currrate2,
						name,
                        userid,
                        custno,
                        trdatetime
					)
					values
					(
						'OAR',
						'#nexttranno2#',
						'1',
						'#fperiod#',
						'#dateformat(now(),'yyyy-mm-dd')#',
						'IMPORT ADJUSTMENT',
						'1',
						'#oartotal#',
						'#oartotal#',
						'#oartotal#',
						'#oartotal#',
						'#oartotal#',
						'#oartotal#',
						'#oartotal#',
						'#oartotal#',
						'1',
						'ADJUSTMENT',
                        '#huserid#',
                        '#huserid#',
                        now()
					);
				</cfquery>
				
				<cfquery name="insert_oar_into_ictran" datasource="#dts#">
					insert ignore into ictran 
					(
						type,
						refno,
						trancode,
						fperiod,
						wos_date,
						currrate,
						itemcount,
						itemno,
						desp,
						unit,
						qty_bil,
						price_bil,
						amt1_bil,
						amt_bil,
						qty,
						price,
						amt1,
						amt,
						name
					) 
					values 
					#oarsql#;
				</cfquery>
                <cfquery name="update_ictran" datasource="#dts#">
                update ictran set trdatetime=now() where type='OAR' and refno='#nexttranno2#'
                </cfquery>
        
		<cfquery name="update_oar_running_no" datasource="#dts#">
					update refnoset set
					lastusedno='#nexttranno1#'
                    WHERE type = "OAR" and counter = "1";
		</cfquery>
        </cfif>
        
        
        <cfquery name="updatestatus" datasource="#dts#">
					update importoai_temp
					set status='Y'
				</cfquery>
        
		
		</cfif>
		<h2>You have import Icitem successfully.</h2>
	
    
<cftry>
<cfcatch>
		<cffile action = "delete" file = "C:\importoai_#dts#.txt">
		<h2>You have deleted importoai_#dts#.txt successfully.</h2>	 
</cfcatch>
</cftry>
    
</cfif>

</cfoutput>
</body>
</html>