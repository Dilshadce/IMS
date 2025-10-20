<cfquery name="gettrancode" datasource="#dts#">
SELECT MAX(trancode) as trancodea FROM ictran WHERE type = "#form.type#" and refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invno#"> 
order by trancode desc
</cfquery>
 
<cfset code = 0>
<cfif gettrancode.recordcount neq 0>
<cfset code = val(gettrancode.trancodea)>
</cfif>

<cfloop from="1" to="#form.totalrecord#" index="i">
<cfquery name="getall" datasource="#dts#">
SELECT empno,sourceproject,catid FROM ictran WHERE empno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.empno#i#')#"> 
AND sourceproject=<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.source#i#')#"> AND catid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.catid#i#')#">
</cfquery>

<cfif isdefined('form.checkboxvalue#i#')>
<cfset datetime=now()>
<cfset date1=mid(datetime,6,19)>
<cfset code = code + 1>
<cfif getall.recordcount eq 0>
<cfset datenew=dateformat(form.invoicedate,'yyyy/mm/dd')>
<!---<cfset letterreferencedate1=dateformat(evaluate('form.letterreferencedate#i#'),'dd/mm/yyyy')>
<cfset quotationdate1=dateformat(evaluate('form.quotationdate#i#'),'dd/mm/yyyy')>--->
<cfset desp="#evaluate('form.project#i#')#">
<cfset comment = "From "&dateformat(evaluate('form.letterreferencedate#i#'),'dd/mm/yyyy')&" To "&dateformat(evaluate('form.quotationdate#i#'),'dd/mm/yyyy')&chr(10)&chr(13)&"Our Ref : "&evaluate('form.letterreference#i#')&" dated "&dateformat(evaluate('form.letterreferencedate#i#'),'dd/mm/yyyy') >
<cfquery name="clientinvoiceinfo" datasource="#dts#">
INSERT INTO ictran(
`type`
,`refno`
,`trancode`
,`custno`
,`wos_date`
,`itemcount`
,`itemno`
,`desp`
,`qty`
,`qty_bil`
,`price`
,`price_bil`
,`amt1`
,`amt`
,`amt_bil`
,`amt1_bil`
,`trdatetime`
,`empno`
,`sourceproject`
,`catid`
,`wday`
,`wrate`
,`totalota`
,`rateota`
,`totalotb`
,`rateotb`
,`payratetype`
,`comment`
)
VALUES
(
'#form.type#'
,'#form.invno#'
,'#code#'
,'#form.custno#'
,'#datenew#'
,'#code#'
,'employee'
,'#desp#' 
,'1'
,'1'
,'#evaluate('form.grandamount#i#')#'
,'#evaluate('form.grandamount#i#')#'
,'#evaluate('form.grandamount#i#')#'
,'#evaluate('form.grandamount#i#')#'
,'#evaluate('form.grandamount#i#')#'
,'#evaluate('form.grandamount#i#')#'
,'#date1#'
,'#evaluate('form.empno#i#')#'
,'#evaluate('form.source#i#')#'
,'#evaluate('form.catid#i#')#'
,'#evaluate('form.wday#i#')#'
,'#evaluate('form.wrate#i#')#'
,'#evaluate('form.totalota#i#')#'
,'#evaluate('form.rateota#i#')#'
,'#evaluate('form.totalotb#i#')#'
,'#evaluate('form.rateotb#i#')#'
,'#evaluate('form.payratetype#i#')#'
,<cfqueryparam cfsqltype="cf_sql_varchar" value="#comment#">
)
</cfquery>
</cfif>
</cfif>
</cfloop>

<cfoutput>
<script type="text/javascript">
releaseDirtyFlag();
window.location.href='/default/transaction/tran_edit2.cfm?tran=#form.type#&ttype=Edit&refno=#form.invno#&custno=#URLENCODEDFORMAT(form.custno)#&first=0&auto=1';
</script>
</cfoutput>

<!---<script type="text/javascript">
alert('Update Complete!');
ColdFusion.Window.hide('clientinvoice')
</script>--->
<!---<cfoutput>
<script type="text/javascript">
var custno='#form.custno#';
var invno='#form.invno#';
var invoicedate='#form.invoicedate#';
var type='#form.type#';

alert('Update Complete!');
window.open('/default/transaction/clientinvoice.cfm?custno='+custno+'&invno='+invno+'&invoicedate='+invoicedate+'&type='+type);
</script>
</cfoutput>
--->
