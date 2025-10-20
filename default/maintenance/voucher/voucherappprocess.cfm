<cfif isdefined('url.approve')>

<cfquery name="getvouctrantemp" datasource="#dts#">
select * from vouchertrantemp where id='#url.id#'
</cfquery>
<cfquery name="updatevaluefrom" datasource="#dts#">
update vouchertran set usagevalue='#getvouctrantemp.usagevaluefrom#' where id='#getvouctrantemp.idfrom#'

</cfquery>

<cfquery name="updatevalueto" datasource="#dts#">
update vouchertran set usagevalue='#getvouctrantemp.usagevalueto#' where id='#getvouctrantemp.idto#'

</cfquery>

<cfquery name="updatevalueto" datasource="#dts#">
update vouchertrantemp set approved='Y' where id='#url.id#'

</cfquery>

<cfquery name="checkfull" datasource="#dts#">
SELECT a.voucherno,coalesce(a.value,0)-coalesce(b.usagevalue,0) as value,a.type from voucher as a
            left join
            (
            SELECT sum(usagevalue) as usagevalue,voucherno FROM vouchertran
            group by voucherno
            )
            as b on a.voucherno = b.voucherno
            where a.voucherno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getvouctrantemp.vouchernofrom#">
</cfquery>

<cfif val(checkfull.value) lte 0>
<cfquery name="updatevouchery" datasource="#dts#">
Update voucher set used = "Y",updated_by ="#HuserId#",updated_on = now()  where voucherno = '#getvouctrantemp.vouchernofrom#'
</cfquery>
<cfelse>
<cfquery name="updatevouchery" datasource="#dts#">
Update voucher set used = "N",updated_by ="#HuserId#",updated_on = now()  where voucherno = '#getvouctrantemp.vouchernofrom#'
</cfquery>
</cfif>

<cfquery name="updatevouchery" datasource="#dts#">
Update voucher set used = "N",updated_by ="#HuserId#",updated_on = now()  where voucherno = '#getvouctrantemp.vouchernoto#'
</cfquery>


<script type="text/javascript">
alert('Voucher Approved');
window.location.href="voucherapprove.cfm";
</script>

<cfelseif isdefined('url.delete')>

<cfquery name="getvouctrantemp" datasource="#dts#">
delete from vouchertrantemp where id='#url.id#'
</cfquery>

<script type="text/javascript">
alert('Voucher Deleted');
window.location.href="voucherapprove.cfm";
</script>

<cfelse>
<script type="text/javascript">
alert('Transfer amount is not valid');
history.go(-1);
</script>
</cfif>