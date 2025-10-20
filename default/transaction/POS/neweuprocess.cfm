<cfoutput>
<cfquery name="geteu" datasource="#dts#">
SELECT driverno FROM driver where driverno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.memberid#">
</cfquery>
<cfif geteu.recordcount neq 0>
<h1>Member Id already existed</h1>
<cfform name="errorback" id="errorback" method="post" action="neweu.cfm">
<input type="submit" name="sub_btn" id="sub_btn" value="Create New Again">
</cfform> 
<cfabort>
<cfelse>
<cfif form.memberdob neq "">
<cfset newdate=createdate(right(form.memberdob,4),mid(form.memberdob,4,2),left(form.memberdob,2))>
</cfif>

<cfquery name="insert" datasource="#dts#">
Insert into Driver (driverno,name,phone,contact,add1,add2,add3,icno,dob)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.memberid#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.membername#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.membertel#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.memberhp#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.memberadd1#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.memberadd2#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.memberadd3#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.membericno#">,
<cfif form.memberdob neq "">
<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(newdate,'yyyy-mm-dd')#">
<cfelse>
"0000-00-00"
</cfif>
)
</cfquery>

<script type="text/javascript">

<cfif lcase(hcomid) eq "mika_i">
document.getElementById('driver').value='#form.memberid#';
ColdFusion.Window.hide("neweu");
<cfelse>

myoption = document.createElement("OPTION");
myoption.text = "#form.memberid# - #form.membername#";
myoption.value = "#form.memberid#";
document.invoicesheet.driver.options.add(myoption);
var indexvalue = document.getElementById("driver").length-1;
document.getElementById("driver").selectedIndex=indexvalue;
ColdFusion.Window.hide("neweu");

</cfif>

</script>
</cfif>
</cfoutput>