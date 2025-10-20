<cfoutput>
<cfif isdefined('form.periodmonth')>

<cfquery name="updateperiod" datasource="#dts#">
UPDATE gsetup SET period = "#form.periodmonth#"
</cfquery>

<cfquery name="getcompanyname" datasource="#dts#">
SELECT compro,period,LASTACCYEAR FROM gsetup
</cfquery>

<cfquery name="insertlist" datasource="loadbal">
        INSERT INTO yearend
        (
        companyid,
        companyname,
        comlastaccyear,
        comperiod,
        comstatus,
        submited_by,
        submited_on,
        email_add
        )
        VALUES
        (
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#dts#">,
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcompanyname.compro#">,
        "#dateformat(getcompanyname.lastaccyear,'yyyy-mm-dd')#",
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcompanyname.period#">,
        'Queuing',
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getauthuser()#">,
        now(),
        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.emailadd#">
        )
        </cfquery>
        <br>
<br>
<br>
<br>
<br>
<br>

<h4>
Year End checking has been submitted. You will receive an checking result email at #form.emailadd# in few minutes. Please do contact us at support@mynetiquette.com if you have further enquiry.
</h4>     
        </cfif>
</cfoutput>