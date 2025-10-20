<cfquery name="getitemdetail" datasource="#dts#">
SELECT * FROM icitem WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#" >
</cfquery>

<cfquery name="checkexist" datasource="#dts#">
SELECT itemno,desp FROM icitemforecast WHERE itemno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itemno#" >
</cfquery>

<cfif checkexist.recordcount eq 0>
<cfquery name="insertintoitemforecast" datasource="#dts#">
INSERT INTO icitemforecast (itemno,desp,period1,period2,period3,period4,period5,period6,period7,period8,period9,period10,period11,period12,period13,period14,period15,period16,period17,period18,created_by,created_on) 
VALUES(
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.itemno#" >,
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#getitemdetail.desp#" >,
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period1#" >,
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period2#" >,
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period3#" >,
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period4#" >,
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period5#" >,
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period6#" >,
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period7#" >,
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period8#" >,
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period9#" >,
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period10#" >,
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period11#" >,
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period12#" >,
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period13#" >,
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period14#" >,
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period15#" >,
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period16#" >,
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period17#" >,
<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period18#" >,
'#huserid#',
now())
</cfquery>
<cfelse>
<cfquery name="updateitemforecast" datasource="#dts#">
update icitemforecast set 
period1 = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period1#" >,
period2 =<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period2#" >,
period3 =<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period3#" >,
period4 =<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period4#" >,
period5 =<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period5#" >,
period6 =<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period6#" >,
period7 =<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period7#" >,
period8 =<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period8#" >,
period9 =<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period9#" >,
period10 =<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period10#" >,
period11 =<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period11#" >,
period12 =<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period12#" >,
period13 =<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period13#" >,
period14 =<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period14#" >,
period15 =<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period15#" >,
period16 =<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period16#" >,
period17 =<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period17#" >,
period18 =<cfqueryparam cfsqltype="cf_sql_varchar"  value="#form.period18#" >,
updated_by = '#huserid#',
updated_on =now()

where itemno ="#form.itemno#"
</cfquery>
</cfif>

<cfoutput>
<cfform action="" method="post" name="recreate">
<cfif checkexist.recordcount eq 0>
<h4>Item Forecast for Item No #form.itemno# has been successfully created</h4>
<cfelse>
<h4>Item Forecast for Item No #form.itemno# has been successfully updated</h4>
</cfif>
<div align="center"><input type="button" value="close"  onclick="ColdFusion.Window.hide('assignitem');"></div>
</cfform>
</cfoutput>
