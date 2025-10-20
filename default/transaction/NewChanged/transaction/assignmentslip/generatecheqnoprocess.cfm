<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfquery name="getperiod" datasource="#dts#">
SELECT lastaccyear FROM gsetup
</cfquery>
<cfset lastdate = getperiod.lastaccyear>

<cfquery name="getlist" datasource="#dts#">
SELECT * FROM (
select empno,coalesce(addchargeself,0)+coalesce(addchargeself2,0)+coalesce(addchargeself3,0)+coalesce(addchargeself4,0)+coalesce(addchargeself5,0)+coalesce(addchargeself6,0) as totalamt,assignmentslipdate,refno,chequeno from assignmentslip where (
claimadd1 = "Y"
or claimadd2 = "Y"
or claimadd3 = "Y"
or claimadd4 = "Y"
or claimadd5 = "Y"
or claimadd6 = "Y")
and (coalesce(addchargeself,0)+coalesce(addchargeself2,0)+coalesce(addchargeself3,0)+coalesce(addchargeself4,0)+coalesce(addchargeself5,0)+coalesce(addchargeself6,0)) > 0
<cfif form.assignmentfrom neq "" and form.assignmentto neq "">
and refno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assignmentfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assignmentto#">
</cfif>
<cfif form.periodfrom neq "" and form.periodto neq "">
and assignmentslipdate between "#dateformat(createdate(year(dateadd('m',form.periodfrom,lastdate)),month(dateadd('m',form.periodfrom,lastdate)),'1'),'YYYY-MM-DD')#" and "#dateformat(createdate(year(dateadd('m',form.periodto,lastdate)),month(dateadd('m',form.periodto,lastdate)),DaysInMonth(dateadd('m',form.periodto,lastdate))),'YYYY-MM-DD')#"
</cfif>
<cfif form.datefrom neq "" and form.dateto neq "">
and assignmentslipdate between "#dateformat(createdate(right(form.datefrom,4),mid(form.datefrom,4,2),left(form.datefrom,2)),'YYYY-MM-DD')#" and "#dateformat(createdate(right(form.dateto,4),mid(form.dateto,4,2),left(form.dateto,2)),'YYYY-MM-DD')#"
</cfif>
<cfif isdefined('form.emptycheqno')>
and (chequeno = "" or chequeno is null)
</cfif>
) as a
LEFT JOIN
(
SELECT nricn,bankaccno,name, empno as emp FROM #replace(dts,'_i','_p')#.PMAST
) as b
on a.empno = b.emp
order by refno
</cfquery>
<cfform name="cheqform" id="cheqform" method="post" action="recordcheque.cfm">
<cfoutput>
<table>
<tr>
<td colspan="2">
Prefix&nbsp;:&nbsp;<input type="text" name="cheqprefix" id="cheqprefix" value="" />
</td>
<td colspan="3" align="right">
Start Cheque no&nbsp;:&nbsp;<input type="text" name="startno" id="startno" value="" />&nbsp;&nbsp;<input type="button" name="gen_btn" id="gen_btn" value="Generate" onclick="generatecheq();" />
</td>
</tr>
<tr>
<th>Assignment No</th>
<th>Assignment Date</th>
<th>Employee No-Name</th>
<th>Claim Amount</th>
<th>Cheque No</th>
</tr>
<cfset totallist = 0>
<cfset refnolist = "">
<cfloop query="getlist">
<tr  onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<td>#getlist.refno#</td>
<td>#dateformat(getlist.assignmentslipdate,'YYYY-MM-DD')#</td>
<td>#getlist.empno# - #getlist.name#</td>
<td>#numberformat(val(getlist.totalamt),',.__')#</td>
<td>
<cfif getlist.chequeno eq "">
<cfset refnolist = refnolist&getlist.refno&",">
<input type="text" name="chequeno#getlist.refno#" id="chequeno#totallist#" value="" />
<cfset totallist = totallist + 1>
<cfelse>#getlist.chequeno#</cfif>
</td>
</tr>
</cfloop>
<tr>
<td colspan="5" align="center">
<input type="submit" name="sub_btn" id="sub_btn" value="Save Cheque No" />
<input type="hidden" name="refnolist" id="refnolist" value="#refnolist#" />
</td>
</tr>
</table>
<script type="text/javascript">
function generatecheq()
{
	var startno = document.getElementById('startno').value;
	if ( startno.length != 0)
	{
		var noprefix = "";
			if(parseFloat(startno.substring(0,1)) == 0)
			{
				for ( var a=0;a<startno.length;a++)
				{
					if(parseFloat(startno.substring(a,a+1)) == 0)
					{
						
						noprefix = noprefix+"0";
					}
					else
					{
						break;
					}
					
				}
			}
			
			var loopuntil = #val(totallist)#;
			var cheqvar = "";
			
			for (var i=0; i<loopuntil; i++)
			{
			cheqvar = "chequeno"+i;
			if(noprefix.length == 0)
			{
			var newcheq = parseFloat(startno) + i;
			}
			else
			{
			var newcheq =  noprefix+(parseFloat(startno) + i);
			if(newcheq.length != startno.length)
			{
				var varylen =parseFloat(newcheq.length) - parseFloat(startno.length);
				newcheq = newcheq.substring(varylen);
			}
			}
			document.getElementById(cheqvar).value = newcheq;
			}
	}
}
</script>
</cfoutput>
</cfform>