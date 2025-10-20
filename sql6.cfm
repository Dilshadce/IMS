
<cfquery name="insertNew" datasource="main">
   INSERT IGNORE INTO menunew2(menu_id,menu_name,menu_level,menu_parent_id,menu_url,menu_order)
   VALUES ('70070','Others','2','70000','/body/bodymenu.cfm?id=70070','60');
</cfquery>


<cfquery name="insertNew" datasource="main">
   INSERT IGNORE INTO menunew2(menu_id,menu_name,menu_level,menu_parent_id,menu_url,menu_order)
   VALUES ('70071','Add TradeXchange','3','70070','../../createtabletradexchange.cfm','1');
</cfquery>

<cfquery name="insertNew" datasource="main">

   INSERT IGNORE INTO menunew2(menu_id,menu_name,menu_level,menu_parent_id,menu_url,menu_order)
   VALUES ('70072','Check Item Price & Cost','3','70070','../../super_menu/checkpricecost.cfm','2');
</cfquery>

<cfquery name="insertNew" datasource="main">
   INSERT IGNORE INTO menunew2(menu_id,menu_name,menu_level,menu_parent_id,menu_url,menu_order)
   VALUES ('70073','Compare Item Opening with FIFO','3','70070','../../super_menu/checkopeningqty.cfm','3');
</cfquery>


<cfquery name="insertNew" datasource="main">
   INSERT IGNORE INTO menunew2(menu_id,menu_name,menu_level,menu_parent_id,menu_url,menu_order)
   VALUES ('70074','Update FIFO Cost','3','70070','../../super_menu/updatefifocost/updatefifo.cfm','4');
</cfquery>


<cfquery name="insertNew" datasource="main">
   INSERT IGNORE INTO menunew2(menu_id,menu_name,menu_level,menu_parent_id,menu_url,menu_order)
   VALUES ('70075','Update Transaction Project','3','70070','../../super_menu/s_updateproject.cfm','5');
</cfquery>