<!--- <cfquery name="getictrantemp" datasource="#dts#">
    CREATE TABLE `userdefinedmenu` (
      `menu_id` varchar(45) NOT NULL DEFAULT '',
      `menu_name` varchar(150) NOT NULL,
      `new_menu_name` varchar(150) NOT NULL,
      `menu_level` int(10) unsigned NOT NULL DEFAULT '0',
      `updated_by` varchar(45) NOT NULL DEFAULT '',
      `updated_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
      `changed` int(10) unsigned NOT NULL DEFAULT '0',
      PRIMARY KEY (`menu_id`)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8;
</cfquery>

 <cfquery name="getictrantemp" datasource="#dts#">
   INSERT IGNORE INTO userDefinedMenu(menu_id,menu_name,new_menu_name)
   SELECT menu_id, menu_name AS a,menu_name AS b
   FROM main.menunew2;
</cfquery> --->
<!---
<cfquery name="getictrantemp" datasource="#dts#">
 ALTER TABLE `icitem_last_year` ADD COLUMN `LastAccDate` DATETIME NOT NULL DEFAULT '0000-00-00' AFTER `SIZE`,
 ADD COLUMN `ThisAccDate` DATETIME NOT NULL DEFAULT '0000-00-00' AFTER `LastAccDate`;
</cfquery>
 --->

<!--- <cfquery name="getictrantemp" datasource="#dts#">
	INSERT INTO main.menunew2 (menu_id,menu_name,menu_level,menu_parent_id,menu_url)
    VALUES ('70077','Purchase Order','3','70076','	../../default/transaction/transaction.cfm?tran=po&menuID=20111')
</cfquery> --->

<!--- <cfquery name="getictrantemp" datasource="#dts#">
	ALTER TABLE `modulecontrol` ADD COLUMN `malaysiagst` VARCHAR(1) NOT NULL DEFAULT '' AFTER `repairtran`;
</cfquery> --->

<!---<cfquery name="getictrantemp" datasource="#dts#">
	UPDATE main.menunew2
    SET menu_url = '/reports/salesreport/PrintStatement/statementform.cfm'
    WHERE menu_id = '50390b'
</cfquery>--->

<!---<cfquery name="getictrantemp" datasource="#dts#">
	UPDATE main.menunew2
    SET menu_name = 'Bills Not Accepted'
    WHERE menu_id = '40711'
</cfquery>--->


<!--- DISPLAY MAIN MENU --->
<!---<cfquery name="getictrantemp" datasource="#dts#">
	SELECT * FROM main.menunew2
</cfquery>

<table>
<tr>
<td>MENU ID</td>
<td>MENU NAME</td>
<td>MENU LEVEL</td>
<td>MENU PARENT ID</td>
<td>MENU URL</td>
<td>MENU ORDER</td>

</tr>
	<cfoutput query="getictrantemp">
        <tr>
            <td>#menu_ID#</td><td>#menu_name#</td><td>#menu_level#</td><td>#menu_parent_id#</td><td>#menu_url#</td><td>#menu_order#</td><td>#userpin_id#</td>
        </tr>
    </cfoutput>
</table>--->

<!---Unblock AMS user --->
<!---<cfquery name="getictrantemp" datasource="#dts#">
	delete FROM mainams.tracklogin where userid="kokyaugaf"
</cfquery>--->

<!---<cfquery name="getictrantemp" datasource="#dts#">
    CREATE TABLE `artranINDO` (
      `refno` VARCHAR(50) NOT NULL DEFAULT '',
      `type` VARCHAR(4) NOT NULL DEFAULT '',
      `kodePajak` VARCHAR(1) NOT NULL DEFAULT '',
      `kodeTransaksi` VARCHAR(1) NOT NULL DEFAULT '',
      `kodeStatus` VARCHAR(1) NOT NULL DEFAULT '',
      `kodeDokumen` VARCHAR(1) NOT NULL DEFAULT '',
      `flagVAT` VARCHAR(1) NOT NULL DEFAULT '',
      `npwp` VARCHAR(255) NOT NULL DEFAULT '',
      `namaLwnTransaksi` VARCHAR(50) NOT NULL DEFAULT '',
      `nomorDokumen` VARCHAR(50) NOT NULL DEFAULT '',
      `jenisDokumen` VARCHAR(1) NOT NULL DEFAULT '',
      `nomorSeriDiganti` VARCHAR(50) NOT NULL DEFAULT '',
      `jenisDokumenDiganti` VARCHAR(1) NOT NULL DEFAULT '',
      `tanggalDokumen` DATETIME NOT NULL DEFAULT '0000-00-00',
      `tanggalSSP` DATETIME NOT NULL DEFAULT '0000-00-00',
      `masaPajak` VARCHAR(4) NOT NULL DEFAULT '',
      `tahunPajak` VARCHAR(4) NOT NULL DEFAULT '',
      `pembetulan` VARCHAR(2) NOT NULL DEFAULT '',
      `DPP` VARCHAR(50) NOT NULL DEFAULT '',
      `PPN` VARCHAR(50) NOT NULL DEFAULT '',
      `PPnBM` VARCHAR(50) NOT NULL DEFAULT '',
      PRIMARY KEY (`refno`)
    )
    ENGINE = MyISAM;
</cfquery>--->

<!---Link to AMS --->
<!---<cfquery name="getictrantemp" datasource="#dts#">
	update main.users 
    set linktoams="Y" 
    where userbranch="#dts#"
</cfquery>--->


 
<!---<cfquery name="getictrantemp" datasource="#dts#">
    DELETE FROM iclink
    WHERE type = 'RC'
    AND refno = 'PR14023'
</cfquery>   

<cfquery name="getictrantemp" datasource="#dts#">
    DELETE FROM ictran
    WHERE type = 'RC'
    AND refno = 'PR14023'
</cfquery>

<cfquery name="getictrantemp" datasource="#dts#">
    UPDATE artran
    SET 
        toINV = '',
        generated = '',
        order_cl = ''
    WHERE refno = 'PR14023'
    AND type = 'RC'
</cfquery>  

<cfquery name="getictrantemp" datasource="#dts#">
    UPDATE ictran
    SET 
        shipped = '',
        toinv = '',
        generated = ''
    WHERE refno = 'PR14023'
    AND type = 'RC'
</cfquery>  --->  



<!---<cfquery name="getictrantemp" datasource="#dts#">
    SELECT negstk
    FROM gsetup
</cfquery>

<cfoutput query="getictrantemp">
        <tr>
            <td>#negstk#</td>
        </tr>
    </cfoutput>
    
    
    <cfif IsDefined('cgi.HTTP_REFERER') AND cgi.HTTP_REFERER NEQ ''>
		     
		<cfset condition1 = LEFT(cgi.HTTP_REFERER,29) EQ 'http://ims-my.netiquette.asia'>
		<cfset condition2 = LEFT(cgi.HTTP_REFERER,31) EQ 'https://amsmy.netiquette.com.sg'>
		<cfset condition3 = LEFT(cgi.HTTP_REFERER,31) EQ 'https://imsmy.netiquette.com.sg'>
		<cfoutput>
		#LEFT(cgi.HTTP_REFERER,29)#
		#condition1#
		#condition2#
		</cfoutput>
		<cfif (condition1 OR condition2 OR condition3)>
			<cfelse>
			<cfabort>
			
		</cfif>
	</cfif>


	<cfif IsDefined('cgi.HTTP_REFERER')>
  		<cfif LEFT(cgi.HTTP_REFERER,29) NEQ 'http://ims-my.netiquette.asia' and cgi.HTTP_REFERER neq "">
  			<cfabort>
  		</cfif>
		
 	</cfif>
--->


<!---<cfquery name="getItem" datasource="main">
	CREATE TABLE `words` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      `english` varchar(200) DEFAULT '',
      `sim_ch` varchar(200) DEFAULT '',
      `tra_ch` varchar(200) DEFAULT '',
      `indo` varchar(200) DEFAULT '',
      `thai` varchar(200) DEFAULT '',
      `viet` varchar(200) DEFAULT '',
      `malay` varchar(200) DEFAULT '',
      PRIMARY KEY (`id`)
    ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
</cfquery>--->
