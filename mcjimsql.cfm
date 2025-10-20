<cfquery name="updatetable" datasource="#dts#">
ALTER TABLE `mcjim_i`.`r_icbil_s` MODIFY COLUMN `DESP` VARCHAR(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL;


</cfquery>