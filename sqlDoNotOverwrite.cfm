


<cftry>

<cfquery name="alterCodeLength" datasource="#dts#">
	ALTER TABLE `userpin` MODIFY COLUMN `CODE` VARCHAR(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter1" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10000` CHAR(1) NOT NULL DEFAULT 'T' AFTER `h4IC0`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert1" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10000','Maintenance')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter2" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10101` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10000`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert2" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10101','Customer Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter3" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10101_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10101`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert3" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10101_3a','Create New Customer')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter4" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10101_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10101_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert4" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10101_3b','Edit/Delete Customer')
</cfquery>

<cfcatch></cfcatch>
</cftry>



<cftry>

<cfquery name="alter5" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10101_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10101_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert5" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10101_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter6" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10102` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10101_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert6" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10102','Supplier Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter7" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10102_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10102`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert7" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10102_3a','Add Supplier')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter8" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10102_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10102_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert8" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10102_3b','Edit/Delete Supplier')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter8" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10102_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10102_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert8" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10102_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>




<cftry>

<cfquery name="alter9" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10103` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10102_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert9" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10103','Product Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter10" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10103_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10103`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert10" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10103_3a','Add Product')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter11" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10103_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10103_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert11" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10103_3b','Edit/Delete Product')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter12" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10103_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10103_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert12" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10103_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter14" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10103_3d` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10103_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert14" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10103_3d','Print Barcode')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter15" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10103_3e` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10103_3d`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert15" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10103_3e','Unit Cost Price')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter16" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10103_3f` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10103_3e`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert16" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10103_3f','Unit Selling Price(s)')
</cfquery>

<cfcatch></cfcatch>
</cftry>




<cftry>

<cfquery name="alter17" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10104` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10103_3f`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert17" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10104','Service Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter17" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10104_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10104`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert17" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10104_3a','Add Service')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter17" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10104_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10104_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert17" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10104_3b','Edit/Delete Service')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter17" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10104_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10104_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert17" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10104_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter18" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10207` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10104_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert18" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10207','Brand Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter19" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10207_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10207`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert19" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10207_3a','Add Brand')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter20" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10207_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10207_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert20" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10207_3b','Edit/Delete Service')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter20" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10207_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10207_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert20" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10207_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>



<cftry>

<cfquery name="alter21" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10201` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10207_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert21" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10201','Category Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter22" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10201_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10201`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert22" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10201_3a','Add Category')
</cfquery>

<cfcatch></cfcatch>
</cftry>



<cftry>

<cfquery name="alter22" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10201_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10201_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert22" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10201_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>



<cftry>

<cfquery name="alter23" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10201_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10201_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert23" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10201_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter24" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10202` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10201_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert24" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10202','Group Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter25" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10202_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10202`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert25" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10202_3a','Add Group')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter26" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10202_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10202_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert26" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10202_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter27" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10202_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10202_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert27" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10202_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter28" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10203` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10202_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert28" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10203','Size Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter29" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10203_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10203`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert29" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10203_3a','Add Size')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter30" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10203_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10203_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert30" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10203_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter31" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10203_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10203_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert31" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10203_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter32" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10204` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10203_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert32" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10204','Rating Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter33" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10204_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10204`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert33" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10204_3a','Add Rating')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter34" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10204_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10204_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert34" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10204_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter35" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10204_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10204_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert35" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10204_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter36" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10205` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10204_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert37" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10205','Material Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter38" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10205_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10205`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert39" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10205_3a','Add Material')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter40" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10205_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10205_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert41" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10205_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter42" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10205_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10205_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert43" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10205_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter44" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10206` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10205_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert45" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10206','Model Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter46" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10206_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10206`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert47" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10206_3a','Add Model')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter48" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10206_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10206_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert49" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10206_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter42" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10206_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10206_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert43" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10206_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter44" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10207` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10206_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert45" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10207','Brand Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter46" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10207_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10207`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert47" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10207_3a','Add Brand')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter48" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10207_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10207_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert49" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10207_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter42" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10207_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10207_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert43" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10207_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>




<cftry>

<cfquery name="alter44" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10207` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10206_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert45" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10207','Brand Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>



<cftry>

<cfquery name="alter46" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10207_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10207`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert46" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10207_3a','Add Brand')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter48" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10207_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10207_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert49" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10207_3b','Edit/Delete Brand')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter50" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10207_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10207_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert50" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10207_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>




<cftry>

<cfquery name="alter51" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10311` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10207_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert51" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10311','Package Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>



<cftry>

<cfquery name="alter52" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10311_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10311`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert52" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10311_3a','Add Package')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter53" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10311_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10311_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert53" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10311_3b','Edit/Delete Brand')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter54" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10311_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10311_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert54" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10311_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter55" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10312` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10311_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert55" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10312','Address Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter56" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10312_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10312`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert56" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10312_3a','Add Address')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter57" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10312_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10312_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert57" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10312_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter58" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10312_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10312_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert58" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10312_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter59" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10313` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10312_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert59" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10313','Collection Address')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter60" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10313_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10313`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert60" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10313_3a','Add Collection Address')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter61" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10313_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10313_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert61" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10313_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter62" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10313_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10313_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert62" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10313_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>



<cftry>

<cfquery name="alter63" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10314` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10313_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert63" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10314','Service Agent Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter64" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10314_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10314`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert64" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10314_3a','Add Service Agent')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter65" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10314_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10314_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert65" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10314_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter66" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10314_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10314_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert66" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10314_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter67" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10315` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10314_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert67" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10315','Team Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter68" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10315_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10315`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert68" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10315_3a','Add Team')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter69" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10315_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10315_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert69" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10315_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter70" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10315_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10315_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert70" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10315_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter71" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10316` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10315_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert71" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10316','Area Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter72" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10316_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10316`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert72" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10316_3a','Add Area')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter73" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10316_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10316_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert73" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10316_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter74" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10316_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10316_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert74" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10316_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter75" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10317` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10316_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert75" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10317','Bill of Material')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter76" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10317_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10317`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert76" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10317_3a','Add Bill of Material')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter77" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10317_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10317_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert77" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10317_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter78" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10317_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10317_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert78" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10317_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>
<cftry>

<cfquery name="alter79" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10318` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10317_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert79" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10318','Business Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter80" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10318_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10318`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert80" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10318_3a','Add Business')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter81" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10318_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10318_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert81" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10318_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter82" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10318_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10318_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert82" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10318_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter83" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10318_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert83" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319','Comment Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter84" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert84" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319_3a','Add Comment')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter85" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert85" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter86" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert86" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter87" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert87" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319a','Customer Service Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter88" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319a_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert88" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319a_3a','Add Customer Service')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter89" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319a_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319a_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert89" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319a_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter90" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319a_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319a_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert90" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319a_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter91" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319a_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert91" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319b','Location Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter92" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319b_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert92" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319b_3a','Add Location')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter93" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319b_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319b_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert93" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319b_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter94" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319b_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319b_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert94" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319b_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter95" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319b_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert95" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319c','Project Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter96" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319c_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert96" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319c_3a','Add Project')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter97" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319c_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319c_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert97" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319c_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter98" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319c_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319c_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert98" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319c_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter99" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319d` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319c_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert99" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319d','Job Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter100" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319d_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319d`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert100" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319d_3a','Add Job')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter101" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319d_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319d_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert101" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319d_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter102" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319d_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319d_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert102" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319d_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter103" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319e` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319d_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert103" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319e','Term Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter104" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319e_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319e`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert104" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319e_3a','Add Term')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter105" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319e_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319e_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert105" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319e_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter106" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319e_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319e_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert106" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319e_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter107" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319f` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319e_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert107" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319f','Unit of Measurement')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter108" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319f_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319f`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert108" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319f_3a','Add Unit of Measurement')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter109" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319f_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319f_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert109" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319f_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter110" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319f_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319f_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert110" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319f_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter111" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319g` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319f_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert111" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319g','Identifier Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter112" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319g_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319g`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert112" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319g_3a','Add Identifier')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter113" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319g_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319g_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert113" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319g_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter114" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10319g_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319g_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert114" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10319g_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter115" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10411` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10319g_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert115" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10411','Attention Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter116" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10411_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10411`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert116" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10411_3a','Add Attention')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter117" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10411_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10411_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert117" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10411_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter118" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10411_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10411_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert118" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10411_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter119" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10412` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10411_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert119" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10412','Cashier Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter120" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10412_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10412`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert120" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10412_3a','Add Cashier')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter121" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10412_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10412_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert121" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10412_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter122" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10412_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10412_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert122" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10412_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter123" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10413` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10412_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert123" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10413','Color - Size Maintenance')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter124" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10413_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10413`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert124" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10413_3a','Add ColorSize')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter125" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10413_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10413_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert125" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10413_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter126" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10413_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10413_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert126" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10413_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter127" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10414` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10413_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert127" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10414','Commission')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter128" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10414_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10414`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert128" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10414_3a','Add Commission')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter129" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10414_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10414_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert129" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10414_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter130" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10414_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10414_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert130" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10414_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter131" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10415` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10414_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert131" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10415','Counter')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter132" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10415_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10415`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert132" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10415_3a','Add Counter')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter133" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10415_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10415_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert133" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10415_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter134" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10415_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10415_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert134" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10415_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter135" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10416` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10415_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert135" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10416','Discount Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter136" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10416_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10416`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert136" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10416_3a','Add Discount')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter137" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10416_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10416_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert137" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10416_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter138" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10416_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10416_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert138" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10416_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>



<cftry>

<cfquery name="alter139" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10417` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10416_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert139" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10417','Language Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter140" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10417_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10417`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert140" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10417_3a','Add Language')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter141" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10417_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10417_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert141" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10417_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter142" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10417_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10417_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert142" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10417_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter139" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10417` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10416_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert139" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10417','Language Profile')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter140" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10417_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10417`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert140" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10417_3a','Add Language')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter141" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10417_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10417_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert141" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10417_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter142" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10417_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10417_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert142" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10417_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter143" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10418` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10417_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert143" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10418','Matrix Item Maintenance')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter144" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10418_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10418`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert144" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10418_3a','Add Matrix')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter145" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10418_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10418_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert145" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10418_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter146" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10418_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10418_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert146" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10418_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter147" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10419` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10418_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert147" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10419','Promotion')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter148" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10419_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10419`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert148" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10419_3a','Add Promotion')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter149" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10419_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10419_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert149" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10419_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter150" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10419_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10419_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert150" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10419_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter151" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10419a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10419_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert151" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10419a','Recurr Group')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter152" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10419a_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10419a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert152" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10419a_3a','Add Recurring Group')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter153" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10419a_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10419a_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert153" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10419a_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter154" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10419a_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10419a_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert154" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10419a_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>



<cftry>

<cfquery name="alter151" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10419a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10419_3c`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert151" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10419a','Recurr Group')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter152" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10419a_3a` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10419a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="insert152" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10419a_3a','Add Recurring Group')
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="alter153" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10419a_3b` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10419a_3a`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert153" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10419a_3b','Edit/Delete')
</cfquery>

<cfcatch></cfcatch>
</cftry>


<cftry>

<cfquery name="alter154" datasource="#dts#">
	ALTER TABLE `userpin2` ADD COLUMN `H10419a_3c` CHAR(1) NOT NULL DEFAULT 'T' AFTER `H10419a_3b`;
</cfquery>

<cfcatch></cfcatch>
</cftry>

<cftry>

<cfquery name="insert154" datasource="#dts#">
	INSERT IGNORE INTO userpin (code,desp) 
    VALUES ('10419a_3c','Print')
</cfquery>

<cfcatch></cfcatch>
</cftry>