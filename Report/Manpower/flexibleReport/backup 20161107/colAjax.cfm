<cfsetting showdebugoutput="no">
<cfoutput>
	<cfif url.type eq 'add'>
        <cfset newPosition = 1>
        
        <cftry>
        <cfquery name="getlastpos" datasource="#dts#">
            select position from selcolumn where uuid = "#url.uuid#" order by position*1 desc limit 1
        </cfquery>
        <cfcatch>
        <cfquery name="createtable" datasource="#dts#">
        CREATE TABLE  `#dts#`.`selcolumn` (
          `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
          `uuid` varchar(100) DEFAULT '',
          `column` varchar(100) DEFAULT '',
          `rename` varchar(100) DEFAULT '',
          `position` varchar(100) DEFAULT '',
          PRIMARY KEY (`id`)
        ) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8;
        </cfquery>
        <cfquery name="getlastpos" datasource="#dts#">
            select position from selcolumn where uuid = "#url.uuid#" order by position*1 desc limit 1
        </cfquery>
        </cfcatch>
        </cftry>
        
        <cfif getlastpos.recordcount gt 0>
            <cfset newPosition = getlastpos.position + 1> 
        </cfif>
        
        <cfquery name="checkExist" datasource="#dts#">
        	select id from selcolumn where uuid  = "#url.uuid#" and `column` = "#url.selcol#"
        </cfquery>
        
        <cfif checkExist.recordcount eq 0>
            <cfquery name="add" datasource="#dts#">
                insert into selcolumn (`uuid`, `column`, `position`)
                values ('#url.uuid#', '#url.selcol#', '#newPosition#')
            </cfquery>
        </cfif>
    <cfelseif url.type eq 'remove'>                
    	<cfquery name="remove" datasource="#dts#">
        	delete from selcolumn where uuid = "#url.uuid#" and `column` = "#url.selcol#"
        </cfquery>
    <cfelseif url.type eq 'up'>
    	 <cfquery name="select" datasource="#dts#">
            select id, position from selcolumn where uuid = "#url.uuid#" and `column` = "#url.selcol#" limit 1
         </cfquery>
         
         <cfquery name="select2" datasource="#dts#">
         	select id from selcolumn where uuid = "#url.uuid#" and position = "#select.position-1#" limit 1 
         </cfquery>
         
         <cfquery name="update" datasource="#dts#">
         	update selcolumn set position = position - 1 where id = "#select.id#" 
         </cfquery>
         
         <cfquery name="update2" datasource="#dts#">
         	update selcolumn set position = position + 1 where id = "#select2.id#" 
         </cfquery>    
    <cfelseif url.type eq 'down'>
    	<cfquery name="select" datasource="#dts#">
            select id, position from selcolumn where uuid = "#url.uuid#" and `column` = "#url.selcol#" limit 1
         </cfquery>
         
         <cfquery name="select2" datasource="#dts#">
         	select id from selcolumn where uuid = "#url.uuid#" and position = "#select.position+1#" limit 1 
         </cfquery>
         
         <cfquery name="update" datasource="#dts#">
         	update selcolumn set position = position + 1 where id = "#select.id#" 
         </cfquery>
         
         <cfquery name="update2" datasource="#dts#">
         	update selcolumn set position = position - 1 where id = "#select2.id#" 
         </cfquery>          
    </cfif>
    
	<!---#url.uuid#<br/>
    #url.fcustomer#<br/>
    #url.fplacement#<br/>
    #url.fassignment#<br/>
    #url.finvoice#<br/>
    #url.femployee#<br/>--->
    

      <cfquery name="creatable" datasource="#dts#">
      CREATE TABLE IF NOT EXISTS `#dts#`.`avacolumn` (
        `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
        `entity` varchar(200) DEFAULT '',
        `column` varchar(200) DEFAULT '',
        `realcolumn` varchar(200) DEFAULT '',
        PRIMARY KEY (`id`)
      ) ENGINE=MYISAM AUTO_INCREMENT=260 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC
      </cfquery>
      <cfquery name="getCol" datasource="#dts#">
          select * from avacolumn where entity in (''<cfif url.fCustomer eq 'true'>,'Customer'</cfif><cfif url.fPlacement eq 'true'>,'Placement'</cfif><cfif url.fAssignment eq 'true'>,'Assignment'</cfif><cfif url.fInvoice eq 'true'>,'Invoice'</cfif><cfif url.fEmployee eq 'true'>,'Employee'</cfif>) order by id
      </cfquery>    

      <cfquery name="createtable" datasource="#dts#">
      CREATE TABLE IF NOT EXISTS `#dts#`.`selcolumn` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      `uuid` varchar(100) DEFAULT '',
      `column` varchar(100) DEFAULT '',
      `rename` varchar(100) DEFAULT '',
      `position` varchar(100) DEFAULT '',
      PRIMARY KEY (`id`)
      ) ENGINE=MYISAM AUTO_INCREMENT=204 DEFAULT CHARSET=utf8;
      </cfquery>
      <cfquery name="removesel" datasource="#dts#">
      delete from selcolumn where uuid = "#url.uuid#" and `column` not in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getCol.column)#" separator="," list="yes">)
      </cfquery>
     
    
    <cfquery name="select" datasource="#dts#">
        select id from selcolumn where uuid = "#url.uuid#" order by position*1;
    </cfquery>
    
    <cfloop query="select">
        <cfquery name="update" datasource="#dts#">
            update selcolumn
            set position = '#select.currentrow#'
            where id = "#select.id#"
        </cfquery>
    </cfloop>
    
    <cfquery name="getSel" datasource="#dts#">
        select `column` from selcolumn where uuid = "#url.uuid#" order by position*1
    </cfquery>
    
    <!---#Valuelist(getsel.column)#--->
    
    <table width="100%">
        <tr>	
            <td width="40%"><strong>Available Column</strong></td>
            <td width="10%"></td>
            <td width="40%"><strong>Selected Column</strong></td>
            <td width="10%"></td>
        </tr>                  
        <tr>
            <td>
                <select id="avaColumn" name="avaColumn" size="20" MULTIPLE style="width:100%">  
                    <cfloop query="getCol">
                        <cfif listcontains(valuelist(getsel.column), getcol.column)>
                        <cfelse>	                                                  
                            <option value="#getCol.column#">#getCol.column#</option>
                        </cfif>
                    </cfloop>           
                </select>
            </td>
            <td align="left">                		
                <input type="Button" value="Add >>" style="width:100px" onClick="addColumn()">
                <br>
                <br>
                <input type="Button" value="<< Remove" style="width:100px" onClick="removeColumn()">						
                
            </td>
            <td align="left">
                <select id="selColumn" name="selColumn" size="20" MULTIPLE style="width:100%">
                    <cfloop query="getsel">          
                        <option value="#getsel.column#">#getsel.column#</option>
                    </cfloop>                        
                </select>
            </td>
            <td align="left">                     
                <input type="Button" value="Up" style="width:100px" onClick="sortColumn('up')">
                <br>
                <br>
                <input type="Button" value="Down" style="width:100px" onClick="sortColumn('down')">						                    	
            </td>
        </tr>
    </table>
</cfoutput>