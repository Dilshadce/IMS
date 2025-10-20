<cfoutput>
<cfinclude template="/object/dateobject.cfm">

<cfquery name="getarea" datasource="#dts#">
	SELECT area,desp
	FROM icarea
</cfquery>
<table align="center">
<tr>
<th colspan="100%"><h1>Reimbursement Listing</h1></th>
</tr>
<tr>
<th align="center" colspan="100%">Date From #dateformatnew(form.datefrom,'dd/mm/yyyy')# To #dateformatnew(form.dateto,'dd/mm/yyyy')#</th>
</tr>
<cfset totalamount = 0>
<cfloop query="getarea">

<cfquery name="getplacementno" datasource="#dts#">
SELECT placementno FROM placement WHERE location = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getarea.area#"> group by placementno
</cfquery>

       <cfquery name="getaddaw" datasource="#dts#">
        SELECT if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0) as totalamt, 
        concat(
if(coalesce(addchargeself,0) != 0 and claimadd1 = 'Y',concat(addchargedesp,CHAR(10 using utf8)),''),
if(coalesce(addchargeself2,0) != 0 and claimadd2 = 'Y',concat(addchargedesp2,CHAR(10 using utf8)),''),
if(coalesce(addchargeself3,0) != 0 and claimadd3 = 'Y',concat(addchargedesp3,CHAR(10 using utf8)),''),
if(coalesce(addchargeself4,0) != 0 and claimadd4 = 'Y',concat(addchargedesp4,CHAR(10 using utf8)),''),
if(coalesce(addchargeself5,0) != 0 and claimadd5 = 'Y',concat(addchargedesp5,CHAR(10 using utf8)),''),
if(coalesce(addchargeself6,0) != 0 and claimadd6 = 'Y',addchargedesp6,'')
) as chargedesp,

concat(
if(coalesce(addchargeself,0) != 0 and claimadd1 = 'Y',concat(round(coalesce(addchargeself,0),2),CHAR(10 using utf8)),''),
if(coalesce(addchargeself2,0) != 0 and claimadd2 = 'Y',concat(round(coalesce(addchargeself2,0),2),CHAR(10 using utf8)),''),
if(coalesce(addchargeself3,0) != 0 and claimadd3 = 'Y',concat(round(coalesce(addchargeself3,0),2),CHAR(10 using utf8)),''),
if(coalesce(addchargeself4,0) != 0 and claimadd4 = 'Y',concat(round(coalesce(addchargeself4,0),2),CHAR(10 using utf8)),''),
if(coalesce(addchargeself5,0) != 0 and claimadd5 = 'Y',concat(round(coalesce(addchargeself5,0),2),CHAR(10 using utf8)),''),
if(coalesce(addchargeself6,0) != 0 and claimadd6 = 'Y',round(coalesce(addchargeself6,0),2),'')
) as chargeamt,refno,assignmentslipdate,empno,empname FROM assignmentslip WHERE 
        assignmentslipdate between "#dateformatnew(form.datefrom,'yyyy-mm-dd')#" and "#dateformatnew(form.dateto,'yyyy-mm-dd')#"
        and placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getplacementno.placementno)#" list="yes" separator=",">) and (claimadd1 = "Y"
or claimadd2 = "Y"
or claimadd3 = "Y"
or claimadd4 = "Y"
or claimadd5 = "Y"
or claimadd6 = "Y") and  if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0) <> 0
        order by assignmentslipdate,refno
        
       </cfquery>
<cfif val(getaddaw.totalamt) neq 0>
<tr>
<td colspan="3">Branch : #getarea.desp#</td>
<td colspan="4" align="right">Date : #dateformat(now(),'dd/mm/yyyy')#</td>
</tr>    
<tr>
<td colspan="100%">
<hr />
</td>
</tr>
<tr>
<td>No</td>
<td>Date</td>
<td>Refno</td>
<td>Employee</td>
<td>Reimbursement Item</td>
<td>Reimbursement Amount</td>
<td align="right">Total Amount</td>
</tr>
<tr>
<td colspan="100%">
<hr />
</td>
</tr>
<cfset subtotal = 0>
<cfloop query="getaddaw">
<tr>
<td>#getaddaw.currentrow#</td>
<td>#dateformat(getaddaw.assignmentslipdate,'dd/mm/yyyy')#</td>
<td>#getaddaw.refno#</td>
<td>#getaddaw.empno# - #getaddaw.empname#</td>
<td>#getaddaw.chargedesp#</td>
<td>#getaddaw.chargeamt#</td>
<td align="right">#numberformat(getaddaw.totalamt,'.__')#</td>
</tr>
<cfset subtotal = subtotal + numberformat(getaddaw.totalamt,'.__')>
<cfset totalamount = totalamount + numberformat(getaddaw.totalamt,'.__')>
</cfloop>
<tr>
<td colspan="100%">
<hr />
</td>
</tr>
<tr>
<td align="right" colspan="6">Branch #getarea.desp# Total Amount</td>
<td align="right">#numberformat(subtotal,'.__')#</td>
</tr>
<tr>
<td>&nbsp;</td>
</tr>
</cfif>
</cfloop>
<tr>
<td align="right" colspan="6">Total Amount</td>
<td align="right">#numberformat(totalamount,'.__')#</td>
</tr>
</table>
</cfoutput>