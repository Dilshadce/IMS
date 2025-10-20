<cfprocessingdirective pageencoding="UTF-8">
<cfset words_id_list = "1254">
<cfinclude template="/latest/words.cfm">
<cfsetting showdebugoutput="no">

<cfinvoke component="cfc.Date" method="getDbDate" inputDate="#url.datepackfrom#" returnvariable="datefromnew" />
<cfinvoke component="cfc.Date" method="getDbDate" inputDate="#url.datepackto#" returnvariable="datetonew" />

<cfquery name="getPackList" datasource="#dts#">
    SELECT * 
    FROM packlist 
    WHERE 
    <cfif url.packidfrom neq "">
        packid >= <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.packidfrom#"> AND
    </cfif>
    <cfif url.packidto neq "">
        packid <= <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.packidto#"> AND
    </cfif>
    <cfif url.datepackfrom neq "">
        created_on >= "#datefromnew#" AND 
    </cfif>
    <cfif url.datepackfrom neq "">
        created_on <= "#datetonew#" AND 
    </cfif>
    (driver <> "")
    AND (delivered_on = "0000-00-00" OR delivered_on IS NULL)
    AND (delivered_by IS NULL OR delivered_by = "")
    ORDER BY packid 
    LIMIT 100
</cfquery>
<cfoutput>
<table width="800px">
    <cfloop query="getPackList">
        <tr onMouseOver="javascript:this.style.backgroundColor='99FF00';setID('#getPackList.packID#');" onMouseOut="javascript:this.style.backgroundColor='';">
            <td width="100"><u><a onMouseOver="style.cursor='hand'" onClick="javascript:ColdFusion.Window.show('deliverlist');">#getPackList.packID#</a></u></td>
            <td width="150">#dateformat(getPackList.delivery_on,'YYYY-MM-DD')#</td>
            <cfquery name="getdriver" datasource="#dts#">
                SELECT Name 
                FROM driver 
                WHERE driverno = "#getPackList.driver#" 
            </cfquery>
            <td width="150">#getdriver.name#</td>
            <td width="100"><input type="checkbox" name="packID" id="packID" value="#getPackList.packID#"  /></td>
        </tr>
    </cfloop>
    <tr>
        <td colspan="4">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="4" align="center"><input type="submit" name="SUBMIT" id="SUBMIT" value="#words[1254]#"  /></td>
    </tr>
</table>
</cfoutput>