<cfoutput>
    
<cfset uuid = createuuid()>
    
<cftry>
    <cfquery name="createlogtable" datasource="#dts#">
        SELECT * FROM manpowerpricematrixdetail_log
        LIMIT 1
    </cfquery>
    
    <cfcatch type="database">
        <cfquery name="createlogtable" datasource="#dts#">
            CREATE TABLE IF NOT EXISTS manpowerpricematrixdetail_log LIKE manpowerpricematrixdetail
        </cfquery>

        <cfquery name="modifylogtable" datasource="#dts#">
            ALTER TABLE manpowerpricematrixdetail_log DROP PRIMARY KEY
        </cfquery>
        
        <cfquery name="modifylogtable" datasource="#dts#">
            ALTER TABLE manpowerpricematrixdetail_log 
            ADD COLUMN uuid varchar(45) default ''
        </cfquery>
        
        <cfquery name="modifylogtable" datasource="#dts#">
            ALTER TABLE manpowerpricematrixdetail_log
            ADD INDEX `uuid` (`uuid` ASC)
        </cfquery>
    </cfcatch>
        
</cftry>
        
<cfquery name="logchanges" datasource="#dts#">
    INSERT INTO manpowerpricematrixdetail_log 
    SELECT 
    priceid, itemname, trancode, payable, billable, payadminfee, billadminfee, created_by, created_on, updated_by, updated_on, itemid, payableamt, billableamt, linkto, saf, "#uuid#" as uuid 
    FROM manpowerpricematrixdetail WHERE priceid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#priceid#" />
</cfquery> 
    
<cfquery name="logchangestime" datasource="#dts#">
    UPDATE manpowerpricematrixdetail_log 
    SET updated_on = now(),
    updated_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#" />
    WHERE priceid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#priceid#" />
    AND uuid = "#uuid#"
</cfquery> 
    
</cfoutput>