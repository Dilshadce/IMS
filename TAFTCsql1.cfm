<cfquery name="updatetable" datasource="#dts#">
ALTER TABLE `taftc_i`.`project` ADD COLUMN `cprice` DOUBLE(17,5) NOT NULL DEFAULT '0.00000' AFTER `DETAIL8`,
 ADD COLUMN `cdispec` VARCHAR(45) AFTER `cprice`,
 ADD COLUMN `camt` DOUBLE(17,5) NOT NULL DEFAULT '0.00000' AFTER `cdispec`;

</cfquery>