
<cfset newdate = createdate('#form.year1#','#form.month1#','#form.day1#') >
<cfquery name="insertvehicles" datasource="#dts#">
INSERT INTO vehicles
(
custcode,
custname,
custic,
custadd,
custemail,
gender,
marstatus,
dob,
licdate,
ncd,
com,
carno,
scheme,
make,
model,
chasisno,
yearmade,
oriregdate,
capacity,
coveragetype,
excess,
marketvalue,
suminsured,
insurance,
premium,
financecom,
commission,
contract,
payment,
custrefer,
inexpdate,
created_by,
created_on,
sdd

)
values
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custcode#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custname#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custic#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custadd#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custemail#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.gender#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.marital#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(newdate,'yyyy-mm-dd')#">,
<cfif isdate(form.licdate)>
<cfset ndate = createdate(right(form.licdate,4),mid(form.licdate,4,2),left(form.licdate,2))>
<cfset form.licdate = ndate>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(form.licdate,'YYYY-MM-DD')#">,
<cfelse>
<cfqueryparam cfsqltype="cf_sql_varchar" value="0000-00-00">,
</cfif>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ncd#">,
<cfif isdefined('form.com')>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.com#">,
<cfelse>
<cfqueryparam cfsqltype="cf_sql_varchar" value="false">,
</cfif>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.carno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.scheme#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.make#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.model#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.chasis#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.yearofmade#">,
<cfif isdate(form.oriregdate)>
<cfset ndate = createdate(right(form.oriregdate,4),mid(form.oriregdate,4,2),left(form.oriregdate,2))>
<cfset form.oriregdate = ndate>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(form.oriregdate,'yyyy-mm-dd')#">,
<cfelse>
<cfqueryparam cfsqltype="cf_sql_varchar" value="0000-00-00">,
</cfif>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.capacity#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.coverage#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.excess#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.marketvalue#">,
<cfif #form.suminsured# neq 2>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.suminsured#">
<cfelse>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.suminsured2#">
</cfif>
,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.insurance#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.premium#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.financecom#">,
<cfif #form.commission# neq 2>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.commission#">
<cfelse>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.commission2#">
</cfif>
,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.contract#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.payment#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.referred#">,
<cfif isdate(form.inexpdate)>
<cfset ndate = createdate(right(form.inexpdate,4),mid(form.inexpdate,4,2),left(form.inexpdate,2))>
<cfset form.inexpdate = ndate>
<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(form.inexpdate,'yyyy-mm-dd')#">
<cfelse>
<cfqueryparam cfsqltype="cf_sql_varchar" value="0000-00-00">
</cfif>,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#huserid#">,


now(),
""
)
</cfquery>

<cfoutput>
<cfform action="createveh.cfm" method="post" name="recreate">
<input type="submit" value="Create another vehicles" />&nbsp;&nbsp;&nbsp;<input type="button" value="close"  onclick="closenref();">
</cfform>
</cfoutput>
