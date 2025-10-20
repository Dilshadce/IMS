<html>
<head>
<title>IMPORT CSV FILE TO IMS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
</head>

<!--- FTP --->
<cfparam name="ftpicitem" default="">
<cfparam name="ftparcust" default="">
<cfparam name="ftpapvend" default="">
<!--- LOAD --->
<cfparam name="loadicitem" default="">
<cfparam name="loadarcust" default="">
<cfparam name="loadapvend" default="">
<!--- IMPORT --->
<cfparam name="importicitem" default="">
<cfparam name="importarcust" default="">
<cfparam name="importapvend" default="">
<!--- DELETE --->
<cfparam name="deleteicitem" default="">
<cfparam name="deletearcust" default="">
<cfparam name="deleteapvend" default="">

<body>
<form action="import.cfm" method="post" enctype="multipart/form-data">
<H1>Import CSV File To IMS</H1>
<table align="center" class="data">
	<tr><td colspan="3"><div align="center"><font color="#FF0000" size="2"><strong>IMPORT ITEM</strong></font></div></td></tr>
	<tr>
    	<th>Step</th>
        <th>Description</th>
        <th><cfoutput>item_format_#dts#.csv</cfoutput></th>
    </tr>
    <tr>
    	<td>1.</td>
        <td>Download & Fill in the Details&nbsp;</td>
        <td><a href="download/item_format.xls">item_format.xls</a></td>
    </tr>
    <tr>
    	<td>2.</td>
        <td>Convert the .XLS File to .CSV&nbsp;</td>
        <td>Please Remove the First Line (Header) Before Convert to .CSV</td>
    </tr>
    <tr>
    	<td>3.</td>
        <td>Get File (<cfoutput>item_format_#dts#.csv</cfoutput>) From Local Disk</td>
        <td><font size="2">
        	<input type="file" name="geticitem" size="25">
        </font></td>
    </tr>
    <tr>
    	<td>4.</td>
        <td>FTP File to Server</td>
        <td><font size="2">
        <input type="submit" name="ftpicitem" value="FTP File">
        </font></td>
    </tr>
    <tr>
    	<td>5.</td>
        <td>Load File into Database</td>
        <td><font size="2">
        <input type="submit" name="loadicitem" value="Load File">
        </font></td>
    </tr>
	<tr>
    	<td>6.</td>
        <td>Import into Database</td>
        <td><font size="2">
        <input type="submit" name="importicitem" value="Import Item">
        </font></td>
    </tr>
    <tr>
    	<td>7.</td>
        <td>Delete File At Server</td>
        <td><font size="2">
        <input type="submit" name="deleteicitem" value="Delete File">
        </font></td>
    </tr>
</table>
<br>
<table align="center" class="data">
	<tr><td colspan="3"><div align="center"><font color="#FF0000" size="2"><strong>IMPORT CUSTOMER</strong></font></div></td></tr>
	<tr>
    	<th>Step</th>
        <th>Description</th>
        <th><cfoutput>cust_format_#dts#.csv</cfoutput></th>
    </tr>
    <tr>
    	<td>1.</td>
        <td>Download & Fill in the Details&nbsp;</td>
        <td><a href="download/cust_format.xls">cust_format.xls</a></td>
    </tr>
    <tr>
    	<td>2.</td>
        <td>Convert the .XLS File to .CSV&nbsp;</td>
        <td>Please Remove the First Line (Header) Before Convert to .CSV</td>
    </tr>
    <tr>
    	<td>3.</td>
        <td>Get File (<cfoutput>cust_format_#dts#.csv</cfoutput>) From Local Disk</td>
        <td><font size="2">
        	<input type="file" name="getarcust" size="25">
        </font></td>
    </tr>
    <tr>
    	<td>4.</td>
        <td>FTP File to Server</td>
        <td><font size="2">
        <input type="submit" name="ftparcust" value="FTP File">
        </font></td>
    </tr>
    <tr>
    	<td>5.</td>
        <td>Load File into Database</td>
        <td><font size="2">
        <input type="submit" name="loadarcust" value="Load File">
        </font></td>
    </tr>
	<tr>
    	<td>6.</td>
        <td>Import into Database</td>
        <td><font size="2">
        <input type="submit" name="importarcust" value="Import Customer">
        </font></td>
    </tr>
    <tr>
    	<td>7.</td>
        <td>Delete File At Server</td>
        <td><font size="2">
        <input type="submit" name="deletearcust" value="Delete File">
        </font></td>
    </tr>
</table>
<br>
<table align="center" class="data">
	<tr><td colspan="3"><div align="center"><font color="#FF0000" size="2"><strong>IMPORT SUPPLIER</strong></font></div></td></tr>
	<tr>
    	<th>Step</th>
        <th>Description</th>
        <th><cfoutput>supp_format_#dts#.csv</cfoutput></th>
    </tr>
    <tr>
    	<td>1.</td>
        <td>Download & Fill in the Details&nbsp;</td>
        <td><a href="download/supp_format.xls">supp_format.xls</a></td>
    </tr>
    <tr>
    	<td>2.</td>
        <td>Convert the .XLS File to .CSV&nbsp;</td>
        <td>Please Remove the First Line (Header) Before Convert to .CSV</td>
    </tr>
    <tr>
    	<td>3.</td>
        <td>Get File (<cfoutput>supp_format_#dts#.csv</cfoutput>) From Local Disk</td>
        <td><font size="2">
        	<input type="file" name="getapvend" size="25">
        </font></td>
    </tr>
    <tr>
    	<td>4.</td>
        <td>FTP File to Server</td>
        <td><font size="2">
        <input type="submit" name="ftpapvend" value="FTP File">
        </font></td>
    </tr>
    <tr>
    	<td>5.</td>
        <td>Load File into Database</td>
        <td><font size="2">
        <input type="submit" name="loadapvend" value="Load File">
        </font></td>
    </tr>
	<tr>
    	<td>6.</td>
        <td>Import into Database</td>
        <td><font size="2">
        <input type="submit" name="importapvend" value="Import Supplier">
        </font></td>
    </tr>
    <tr>
    	<td>7.</td>
        <td>Delete File At Server</td>
        <td><font size="2">
        <input type="submit" name="deleteapvend" value="Delete File">
        </font></td>
    </tr>
</table>
</form>
<cfoutput>
<cfif ftpicitem eq 'FTP File'>
	<cftry>
		<CFFILE DESTINATION="C:\item_format_#dts#.csv" ACTION="UPLOAD" FILEFIELD="form.geticitem" attributes="normal">
		<h2>You have FTP item_format_#dts#.csv successfully.</h2>
	<cfcatch type="any">
	</cfcatch>
	</cftry>
</cfif>
<cfif ftparcust eq 'FTP File'>
	<cftry>
		<CFFILE DESTINATION="C:\cust_format_#dts#.csv" ACTION="UPLOAD" FILEFIELD="form.getarcust" attributes="normal">
		<h2>You have FTP cust_format_#dts#.csv successfully.</h2>
	<cfcatch type="any">
	</cfcatch>
	</cftry>
</cfif>
<cfif ftpapvend eq 'FTP File'>
	<cftry>
		<CFFILE DESTINATION="C:\supp_format_#dts#.csv" ACTION="UPLOAD" FILEFIELD="form.getapvend" attributes="normal">
		<h2>You have FTP supp_format_#dts#.csv successfully.</h2>
	<cfcatch type="any">
	</cfcatch>
	</cftry>
</cfif>

<cfif loadicitem eq 'Load File'>
	<!--- <cfquery name="delearpso" datasource="#dts#">
		truncate icitem_temp
	</cfquery> --->
	<cftry>
		<cfquery name="import" datasource="#dts#">
			load data infile "C:/item_format_#dts#.csv" into table icitem_temp fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
		</cfquery>
		<cfquery name="updatestatus" datasource="#dts#">
			update icitem_temp
			set created_on=#now()#
			where status=''
		</cfquery>
		<h2>You have load the file successfully.</h2>
	<cfcatch type="any">
	</cfcatch>
	</cftry>
</cfif>
<cfif loadarcust eq 'Load File'>
	<!--- <cfquery name="delearcust" datasource="#dts#">
		truncate arcust_temp
	</cfquery> --->
	<cftry>
		<cfquery name="import" datasource="#dts#">
			load data infile "C:/cust_format_#dts#.csv" into table arcust_temp fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
		</cfquery>
		<cfquery name="updatestatus" datasource="#dts#">
			update arcust_temp
			set created_on=#now()#
			where status=''
		</cfquery>
		<h2>You have load the file successfully.</h2>
	<cfcatch type="any">
	</cfcatch>
	</cftry>
</cfif>
<cfif loadapvend eq 'Load File'>
	<!--- <cfquery name="deleapvend" datasource="#dts#">
		truncate apvend_temp
	</cfquery> --->
	<cftry>
		<cfquery name="import" datasource="#dts#">
			load data infile "C:/supp_format_#dts#.csv" into table apvend_temp fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
		</cfquery>
		<cfquery name="updatestatus" datasource="#dts#">
			update apvend_temp
			set created_on=#now()#
			where status=''
		</cfquery>
		<h2>You have load the file successfully.</h2>
	<cfcatch type="any">
	</cfcatch>
	</cftry>
</cfif>

<cfif importicitem eq 'Import Item'>
	<cftry>
		<cfquery name="gettempitem" datasource="#dts#">
			select * from icitem_temp
			where status=''
		</cfquery>
		<cfif gettempitem.recordcount neq 0>
			<cfloop query="gettempitem">
				<cfquery name="checkexist" datasource="#dts#">
					select itemno from icitem
					where itemno ='#gettempitem.itemno#'
				</cfquery>
				<cfset thisstatus="I">	<!--- STATUS=I:IMPORTED; E:EXIST --->
				<cfset thisid=gettempitem.id>
				<cfif checkexist.recordcount eq 0>
					<cfquery name="insert" datasource="#dts#">
						insert into icitem
						(`ITEMNO`,`DESP`,`DESPA`, `AITEMNO`,`BRAND`,`SUPP`,
						`CATEGORY`,`WOS_GROUP`,`SIZEID`, `COSTCODE`,`COLORID`,
						 `SHELF` ,`PACKING`, `MINIMUM` , `MAXIMUM` , `REORDER`,
						`UNIT`,`UCOST`,`PRICE`,`PRICE2`,`WSERIALNO`,`GRADED`,
						`QTY2`,`QTY3`,`QTY4`,`QTY5`,`QTY6`,`QTYBF`,
						`SALEC`,`SALECSC`,`SALECNC`,`PURC`,`PURPREC`,`CREATED_BY`,`unit2`,`factor1`,`factor2`,`priceu2`)
						values
						(<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.itemno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.desp#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.despa#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.aitemno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.brand#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.supp#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.category#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.wos_group#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.sizeid#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.costcode#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.colorid#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.shelf#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.packing#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempitem.unit2#">,
						'#gettempitem.minimum#','#gettempitem.maximum#','#gettempitem.reorder#',
						'#gettempitem.unit#','#gettempitem.ucost#','#gettempitem.price#',
						'#gettempitem.price2#','#gettempitem.wserialno#','#gettempitem.graded#',
						'#gettempitem.qty2#','#gettempitem.qty3#','#gettempitem.qty4#','#gettempitem.qty5#','#gettempitem.qty6#',
						'#gettempitem.qtybf#','#gettempitem.salec#','#gettempitem.salecsc#','#gettempitem.salecnc#','#gettempitem.purc#',
						'#gettempitem.purprec#','#Huserid#','#gettempitem.factor1#','#gettempitem.factor2#','#gettempitem.priceu2#'
						)
					</cfquery>
				<cfelse>
					<cfset thisstatus="E">
				</cfif>
				<cfquery name="updatestatus" datasource="#dts#">
					update icitem_temp
					set status='#thisstatus#'
					where id='#thisid#'
				</cfquery>
			</cfloop>
		</cfif>
		<h2>You have import Icitem successfully.</h2>
	<cfcatch type="any">
	</cfcatch>
	</cftry>
</cfif>
<cfif importarcust eq 'Import Customer'>
	<cftry>
		<cfquery name="gettempcust" datasource="#dts#">
			select * from arcust_temp
			where status=''
		</cfquery>
		<cfif gettempcust.recordcount neq 0>
			<cfset count=0>
			<cfloop query="gettempcust">
				<cfquery name="checkexist" datasource="#dts#">
					select custno from #target_arcust#
					where custno ='#gettempcust.custno#'
				</cfquery>
				<cfset thisstatus="I">	<!--- STATUS=I:IMPORTED; E:EXIST --->
				<cfset thisid=gettempcust.id>
				<cfif checkexist.recordcount eq 0>
					<cfquery name="insert" datasource="#dts#">
						insert into #target_arcust#
						(`CUSTNO`,`NAME`,`NAME2`,`ADD1`,`ADD2`,`ADD3`,`ADD4`,`ATTN`,
						`DADDR1`,`DADDR2`,`DADDR3`,`DADDR4`,`DATTN`,`CONTACT`,`PHONE`,`PHONEA`,
						`FAX`,`E_MAIL`,`WEB_SITE`,`AREA`,`AGENT`,`BUSINESS`,`TERM`,`CRLIMIT`,
						`CURRCODE`,`CURRENCY`,`CURRENCY1`,`CURRENCY2`,
						`DATE`,`INVLIMIT`,`CREATED_BY`,`UPDATED_BY`,`CREATED_ON`,`UPDATED_ON`) 
						values
						(<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.custno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.name#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.name2#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.ADD1#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.ADD2#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.ADD3#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.ADD4#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.ATTN#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.DADDR1#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.DADDR2#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.DADDR3#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.DADDR4#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.DATTN#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.CONTACT#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.PHONE#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.PHONE2#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.FAX#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.E_MAIL#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.WEB_SITE#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.AREA#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.AGENT#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.BUSINESS#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.TERM#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.CRLIMIT#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.CURRCODE#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.CURRENCY#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.CURRENCY1#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.CURRENCY2#">,
						now(),
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempcust.INVLIMIT#">,
						'#Huserid#','#Huserid#',now(),now()
						)
					</cfquery>
					<cfset count=count+1>
				<cfelse>
					<cfset thisstatus="E">
				</cfif>
				<cfquery name="updatestatus" datasource="#dts#">
					update arcust_temp
					set status='#thisstatus#'
					where id='#thisid#'
				</cfquery>
			</cfloop>
		</cfif>
		<h2>You have import <cfoutput>#count#</cfoutput> record(s) into Arcust successfully.</h2>
	<cfcatch type="any">
		#cfcatch.message# <br>  #cfcatch.detail# 
	</cfcatch>
	</cftry>
</cfif>
<cfif importapvend eq 'Import Supplier'>
	<cftry>
		<cfquery name="gettempsupp" datasource="#dts#">
			select * from apvend_temp
			where status=''
		</cfquery>
		<cfif gettempsupp.recordcount neq 0>
			<cfset count=0>
			<cfloop query="gettempsupp">
				<cfquery name="checkexist" datasource="#dts#">
					select custno from #target_apvend#
					where custno ='#gettempsupp.custno#'
				</cfquery>
				<cfset thisstatus="I">	<!--- STATUS=I:IMPORTED; E:EXIST --->
				<cfset thisid=gettempsupp.id>
				<cfif checkexist.recordcount eq 0>
					<cfquery name="insert" datasource="#dts#">
						insert into #target_apvend#
						(`CUSTNO`,`NAME`,`NAME2`,`ADD1`,`ADD2`,`ADD3`,`ADD4`,`ATTN`,
						`DADDR1`,`DADDR2`,`DADDR3`,`DADDR4`,`DATTN`,`CONTACT`,`PHONE`,`PHONEA`,
						`FAX`,`E_MAIL`,`WEB_SITE`,`AREA`,`AGENT`,`BUSINESS`,`TERM`,`CRLIMIT`,
						`CURRCODE`,`CURRENCY`,`CURRENCY1`,`CURRENCY2`,
						`DATE`,`INVLIMIT`,`CREATED_BY`,`UPDATED_BY`,`CREATED_ON`,`UPDATED_ON`) 
						values
						(<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.custno#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.name#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.name2#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.ADD1#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.ADD2#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.ADD3#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.ADD4#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.ATTN#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.DADDR1#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.DADDR2#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.DADDR3#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.DADDR4#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.DATTN#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.CONTACT#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.PHONE#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.PHONE2#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.FAX#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.E_MAIL#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.WEB_SITE#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.AREA#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.AGENT#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.BUSINESS#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.TERM#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.CRLIMIT#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.CURRCODE#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.CURRENCY#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.CURRENCY1#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.CURRENCY2#">,
						now(),
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#gettempsupp.INVLIMIT#">,
						'#Huserid#','#Huserid#',now(),now()
						)
					</cfquery>
					<cfset count=count+1>
				<cfelse>
					<cfset thisstatus="E">
				</cfif>
				<cfquery name="updatestatus" datasource="#dts#">
					update apvend_temp
					set status='#thisstatus#'
					where id='#thisid#'
				</cfquery>
			</cfloop>
		</cfif>
		<h2>You have import <cfoutput>#count#</cfoutput> record(s) into Apvend successfully.</h2>
	<cfcatch type="any">
		#cfcatch.message# <br>  #cfcatch.detail# 
	</cfcatch>
	</cftry>
</cfif>

<cfif deleteicitem eq 'Delete File'>
	<cftry>
		<cffile action = "delete" file = "C:\item_format_#dts#.csv">
		<h2>You have deleted item_format_#dts#.csv successfully.</h2>	 
	<cfcatch type="any">
	</cfcatch>
	</cftry>
</cfif>
<cfif deletearcust eq 'Delete File'>
	<cftry>
		<cffile action = "delete" file = "C:\cust_format_#dts#.csv">
		<h2>You have deleted cust_format_#dts#.csv successfully.</h2>	 
	<cfcatch type="any">
		#cfcatch.message# <br>  #cfcatch.detail# 
	</cfcatch>
	</cftry>
</cfif>
<cfif deleteapvend eq 'Delete File'>
	<cftry>
		<cffile action = "delete" file = "C:\supp_format_#dts#.csv">
		<h2>You have deleted supp_format_#dts#.csv successfully.</h2>	 
	<cfcatch type="any">
		#cfcatch.message# <br>  #cfcatch.detail# 
	</cfcatch>
	</cftry>
</cfif>
</cfoutput>
</body>
</html>