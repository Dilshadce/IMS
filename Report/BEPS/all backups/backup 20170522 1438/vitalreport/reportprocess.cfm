<cfif isdefined('form.datefrom')>
<cfoutput>
<cfinclude template="/object/dateobject.cfm">

<cfif form.hdfrm neq "" and form.hdto neq "">
<cfquery name="gethd" datasource="#dts#">
SELECT custno FROM #target_arcust# WHERE 
headquaters BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hdfrm#">
and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hdto#">
</cfquery>
</cfif>

<cfquery name="getplacement" datasource="#dts#">
SELECT placementno FROM placement
WHERE
1=1
<cfif form.hdfrm neq "" and form.hdto neq "">
and custno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(gethd.custno)#" separator="," list="yes">)
</cfif>
<cfif form.comfrm neq "" and form.comto neq "">
and custno Between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comfrm#">
and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.comto#">
</cfif>
<cfif form.deptfrom neq "" and form.deptto neq "">
and department BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.deptfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.deptto#">
</cfif>
</cfquery>

<cfquery name="getassignment" datasource="#dts#">
SELECT * FROM (
SELECT * FROM assignmentslip WHERE 1=1
<cfif form.createdfrm neq "" and form.createdto neq "">
and created_by BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdfrm#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdto#">
</cfif>
<cfif form.datefrom neq "" and form.dateto neq "">
and assignmentslipdate BETWEEN "#dateformatnew(form.datefrom,'yyyy-mm-dd')#" and "#dateformatnew(form.dateto,'yyyy-mm-dd')#"
</cfif>
and placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getplacement.placementno)#" list="yes" separator=",">) 
) as a
LEFT JOIN
(SELECT placementno as pno,refer_by_client,empname,department,supervisor,startdate as sd,completedate as cd,clienttype  FROM placement) as b
on a.placementno = b.pno
LEFT JOIN
(SELECT dbirth, empno as empn,nricn FROM #replace(dts,'_i','_p')#.pmast) as c 
on a.empno = c.empn
LEFT JOIN
(SELECT comuen, custno as cno FROM #target_arcust# ) as d
on a.custno = d.cno
ORDER BY custno
</cfquery>
<cfset jumpcustno = "">
<cfset i = 0>

<cfloop query="getassignment">
<cfif getassignment.custno neq jumpcustno>

<cfif getassignment.currentrow neq 1>
<tr>
<td colspan="14"></td>
<td><b>#numberformat(totaldaysworked,'.__')#</b></td>
<td><b>#numberformat(totalhoursworked,'.__')#</b></td>
<td><b>#numberformat(totalpaidph,'.__')#</b></td>
<td><b>#numberformat(totalpaidal,'.__')#</b></td>
<td><b>#numberformat(totalpaidmlhpl,'.__')#</b></td>
<td><b>#numberformat(totalpaidloth,'.__')#</b></td>
<td><b>#numberformat(totalot1,'.__')#</b></td>
<td><b>#numberformat(totalot15,'.__')#</b></td>
<td><b>#numberformat(totalot2,'.__')#</b></td>
<td><b>#numberformat(totalhourspaid,'.__')#</b></td>
<td><b>#numberformat(totalgp,'.__')#</b></td>
<td><b>#numberformat(totalothpay,'.__')#</b></td>
<td><b>#numberformat(totalcpfer,'.__')#</b></td>
<td><b>#numberformat(totalsdl,'.__')#</b></td>
<td></td>
<td><b>#numberformat(totaladmcharge,'.__')#</b></td>
<td><b>#numberformat(totalmedc,'.__')#</b></td>
<td><b>#numberformat(totalmiscc,'.__')#</b></td>
<td><b>#numberformat(totalmthb,'.__')#</b></td>
<td><b>(#numberformat(totalnsded,'.__')#)</b></td>
<td><b>#numberformat(totalbill,'.__')#</b></td>
<cfif isdefined('form.totalbill')>
<td><b>#numberformat(totalbillgst,'.__')#</b></td>
</cfif>
</tr>
</table>
</cfif>
<cfset totaldaysworked = 0 >
<cfset totalhoursworked = 0 >
<cfset totalpaidph = 0 >
<cfset totalpaidal = 0 > 
<cfset totalpaidmlhpl = 0 >
<cfset totalpaidloth = 0 >
<cfset totalot1 = 0 >
<cfset totalot15 = 0 >
<cfset totalot2 = 0 >
<cfset totalhourspaid = 0 >
<cfset totalgp = 0 >
<cfset totalothpay = 0 >
<cfset totalcpfer = 0 >
<cfset totalsdl = 0 >
<cfset totaladmcharge = 0 >
<cfset totalmedc = 0 >
<cfset totalmiscc = 0 >
<cfset totalmthb = 0 >
<cfset totalnsded = 0 >
<cfset totalbill = 0 >
<cfset totalbillgst = 0>
<cfset jumpcustno = getassignment.custno>
<cfset i = 0>
<p style="page-break-before:always">
<h4>Business Edge Personnel Services Pte Ltd</h4>
<h4><u>#getassignment.custname# - Billing for the Month of #dateformatnew(form.datefrom,'Mmm yyyy')#</u></h4>
<table border="1">
<tr>
<th valign="top" nowrap="nowrap">SN</th>
<th valign="top" nowrap="nowrap">Ref No</th>
<th valign="top" nowrap="nowrap">Name</th>
<th valign="top" nowrap="nowrap">IC No</th>
<th valign="top" nowrap="nowrap">DOB</th>
<th valign="top" nowrap="nowrap">Referred By</th>
<th valign="top" nowrap="nowrap">Cust Name</th>
<th valign="top" nowrap="nowrap">BU</th>
<th valign="top" nowrap="nowrap">Dept</th>
<th valign="top" nowrap="nowrap">Supervisor</th>
<th valign="top" nowrap="nowrap">Contract Start</th>
<th valign="top" nowrap="nowrap">Contract End</th>
<th valign="top" nowrap="nowrap">Rate Type</th>
<th valign="top" nowrap="nowrap">Rate ($)</th>
<th valign="top" nowrap="nowrap">Days Billed</th>
<th valign="top" nowrap="nowrap">Hours worked</th>
<th valign="top" nowrap="nowrap">Paid PH</th>
<th valign="top" nowrap="nowrap">Paid AL</th>
<th valign="top" nowrap="nowrap">Paid ML + HPL</th>
<th valign="top" nowrap="nowrap">Paid Leave (OTH)</th>
<th valign="top" nowrap="nowrap">OT 1.0</th>
<th valign="top" nowrap="nowrap">OT 1.5</th>
<th valign="top" nowrap="nowrap">OT 2.0</th>
<th valign="top" nowrap="nowrap">Total Hours Paid</th>
<th valign="top" nowrap="nowrap">Gross Pay</th>
<th valign="top" nowrap="nowrap">Oth Payments & Deductions</th>
<th valign="top" nowrap="nowrap">CPF(ER)</th>
<th valign="top" nowrap="nowrap">SDL</th>
<th valign="top" nowrap="nowrap">Adm Charges %</th>
<th valign="top" nowrap="nowrap">Adm Charges (S$)</th>
<th valign="top" nowrap="nowrap">Medical Claims</th>
<th valign="top" nowrap="nowrap">Misc Claims</th>
<th valign="top" nowrap="nowrap">Mthly Billables</th>
<th valign="top" nowrap="nowrap">NS & Rebates/Ded</th>
<th valign="top" nowrap="nowrap">Total Billing</th>
<cfif isdefined('form.totalbill')>
<th valign="top" nowrap="nowrap">Total Billing after GST</th>
</cfif>
<th valign="top" nowrap="nowrap">Remarks</th>
</tr>
</cfif>
<tr onMouseOut="javascript:this.style.backgroundColor='';" onMouseOver="javascript:this.style.backgroundColor='99FF00';">
<cfset i = i + 1>
<td>#i#</td>
<td>#getassignment.refno#</td>
<td>#getassignment.empname#</td>
<td>#getassignment.nricn#</td>
<td>#dateformat(getassignment.dbirth,'dd/mm/yyyy')#</td>
<td>#getassignment.refer_by_client#</td>
<td>#getassignment.custname#</td>
<td>#getassignment.comuen#</td>
<td>#getassignment.department#</td>
<td>#getassignment.supervisor#</td>
<td>#dateformat(getassignment.sd,'dd/mm/yyyy')#</td>
<td>#dateformat(getassignment.cd,'dd/mm/yyyy')#</td>
<td><cfif getassignment.clienttype eq "hr">Hourly<cfelseif  getassignment.clienttype eq "mth">Monthly<cfelse>Daily</cfif></td>
<td>#numberformat(val(getassignment.custusualpay),'.__')#</td>
<td>#numberformat(val(getassignment.custsalaryday),'.__')#</td>
<td>#numberformat(val(getassignment.custsalaryhrs),'.__')#</td>
<cfset totalphpaid = 0 >
<cfset totalalpaid = 0 >
<cfset totalmlhplpaid = 0 >
<cfset totalpaidlvl = 0 >
<cfloop from="1" to="10" index="a">
<cfif evaluate('getassignment.lvltype#a#') eq "PH">
<cfif getassignment.paymenttype eq "hr">
<cfset totalphpaid = totalphpaid + numberformat(val(evaluate('getassignment.lvlerdayhr#a#')),'.__')>
<cfelse>
<cfset totalphpaid = totalphpaid + numberformat(val(evaluate('getassignment.lvlhr#a#')),'.__')>
</cfif>
<cfelseif evaluate('getassignment.lvltype#a#') eq "AL">
<cfif getassignment.paymenttype eq "hr">
<cfset totalalpaid = totalalpaid + numberformat(val(evaluate('getassignment.lvlerdayhr#a#')),'.__')>
<cfelse>
<cfset totalalpaid = totalalpaid + numberformat(val(evaluate('getassignment.lvlhr#a#')),'.__')>
</cfif>
<cfelseif evaluate('getassignment.lvltype#a#') eq "MC" or  evaluate('getassignment.lvltype#a#') eq "HPL" >
<cfif getassignment.paymenttype eq "hr">
<cfset totalmlhplpaid = totalmlhplpaid + numberformat(val(evaluate('getassignment.lvlerdayhr#a#')),'.__')>
<cfelse>
<cfset totalmlhplpaid = totalmlhplpaid + numberformat(val(evaluate('getassignment.lvlhr#a#')),'.__')>
</cfif>
<cfelseif evaluate('getassignment.lvltype#a#') neq "NPL">
<cfif getassignment.paymenttype eq "hr">
<cfset totalpaidlvl = totalpaidlvl + numberformat(val(evaluate('getassignment.lvlerdayhr#a#')),'.__')>
<cfelse>
<cfset totalpaidlvl = totalpaidlvl + numberformat(val(evaluate('getassignment.lvlhr#a#')),'.__')>
</cfif>
</cfif>
</cfloop>
<cfset encashleave = 0>
<cfloop from="1" to="3" index="aa">
<cfif evaluate('getassignment.allowance#aa#') eq 9>
<cfset awdesp = evaluate('getassignment.allowancedesp#aa#')>
<cfset startno = findnocase('(',awdesp)>
<cfset endno = findnocase('day',awdesp)>
<cfif endno eq 0>
<cfset endno = findnocase('hr',awdesp)>
</cfif>
<cfif startno neq 0 and endno neq 0>
<cftry>
<cfset encashleave = encashleave + val(trim(mid(awdesp,startno+1,endno - startno - 1)))>
<cfcatch type="any">
<cftry> 
<cfset encashleave = encashleave + (val(evaluate('getassignment.awee#aa#'))/val(getassignment.selfusualpay))>
<cfcatch type="any">
</cfcatch>
</cftry>
</cfcatch>
</cftry>
</cfif>
</cfif>
</cfloop>
<cfset totalpaidlvl = totalpaidlvl + val(encashleave)>
<td>#numberformat(val(totalphpaid),'.__')#</td>
<td>#numberformat(val(totalalpaid),'.__')#</td>
<td>#numberformat(val(totalmlhplpaid),'.__')#</td>
<td>#numberformat(val(totalpaidlvl),'.__')#</td>
<td>#numberformat(val(getassignment.custothour1),'.__')#</td>
<td>#numberformat(val(getassignment.custothour2),'.__')#</td>
<td>#numberformat(val(getassignment.custothour3),'.__')#</td>
<cfset totalhour = val(getassignment.custothour1) + val(getassignment.custothour2) + val(getassignment.custothour3) + val(getassignment.custothour4)+val(totalphpaid)+val(totalalpaid)+val(totalmlhplpaid)+val(totalpaidlvl)+numberformat(val(getassignment.custsalaryhrs),'.__')>
<td>#numberformat(val(totalhour),'.__')#</td>
<cfset grosspay = val(getassignment.custpayback) + val(getassignment.custpbaws) + val(getassignment.custottotal) + val(getassignment.custphnlsalary)+ val(getassignment.custsalary)>
<td>#numberformat(val(grosspay),'.__')#</td>
<td>#numberformat(val(getassignment.custallowance),'.__')#</td>
<td>#numberformat(val(getassignment.custcpf),'.__')#</td>
<td>#numberformat(val(getassignment.custsdf),'.__')#</td>
<td>#numberformat(val(getassignment.adminfeepercent),'.__')#</td>
<td>#numberformat(val(getassignment.adminfee),'.__')#</td>
<cfset medclaim = 0 >
<cfset miscclaim = 0 >
<cfif getassignment.addchargecode eq "MEDICAL">
<cfset medclaim = medclaim +  val(getassignment.addchargecust)>
<cfelse>
<cfset miscclaim = miscclaim + val(getassignment.addchargecust) >
</cfif>

<cfif getassignment.addchargecode2 eq "MEDICAL">
<cfset medclaim = medclaim +  val(getassignment.addchargecust2)>
<cfelse>
<cfset miscclaim = miscclaim + val(getassignment.addchargecust2) >
</cfif>

<cfif getassignment.addchargecode3 eq "MEDICAL">
<cfset medclaim = medclaim +  val(getassignment.addchargecust3)>
<cfelse>
<cfset miscclaim = miscclaim + val(getassignment.addchargecust3) >
</cfif>
<td>#numberformat(val(medclaim),'.__')#</td>
<td>#numberformat(val(miscclaim),'.__')#</td>
<cfset totalbillable = val(getassignment.billitemamt1)+val(getassignment.billitemamt2)+val(getassignment.billitemamt3)>
<td>#numberformat(val(totalbillable),'.__')#</td>
<cfset totalded = val(getassignment.nscustded)+val(getassignment.rebate)+val(getassignment.dedcust1)+val(getassignment.dedcust2)+val(getassignment.dedcust3)>
<td>(#numberformat(val(totalded),'.__')#)</td>
<td>#numberformat(val(getassignment.custtotal)-numberformat(val(getassignment.taxamt),'.__'),'.__')#</td>
<cfif isdefined('form.totalbill')>
<td>#numberformat(val(getassignment.custtotal),'.__')#</td>
</cfif>
<td>#getassignment.assigndesp#</td>
</tr>
<cfset totaldaysworked = totaldaysworked + numberformat(val(getassignment.custsalaryday),'.__') >
<cfset totalhoursworked = totalhoursworked + numberformat(val(getassignment.custsalaryhrs),'.__') >
<cfset totalpaidph = totalpaidph +  numberformat(val(totalphpaid),'.__')>
<cfset totalpaidal = totalpaidal + numberformat(val(totalalpaid),'.__') >
<cfset totalpaidmlhpl = totalpaidmlhpl + numberformat(val(totalmlhplpaid),'.__')>
<cfset totalpaidloth = totalpaidloth +numberformat(val(totalpaidlvl),'.__')>
<cfset totalot1 = totalot1 + numberformat(val(getassignment.custothour1),'.__')>
<cfset totalot15 = totalot15 + numberformat(val(getassignment.custothour2),'.__')>
<cfset totalot2 = totalot2 + numberformat(val(getassignment.custothour3),'.__')>
<cfset totalhourspaid = totalhourspaid + numberformat(val(totalhour),'.__')>
<cfset totalgp = totalgp + numberformat(val(grosspay),'.__') >
<cfset totalothpay = totalothpay +  numberformat(val(getassignment.custallowance),'.__') >
<cfset totalcpfer = totalcpfer + numberformat(val(getassignment.custcpf),'.__')>
<cfset totalsdl = totalsdl + numberformat(val(getassignment.custsdf),'.__')>
<cfset totaladmcharge = totaladmcharge + numberformat(val(getassignment.adminfee),'.__')>
<cfset totalmedc = totalmedc + numberformat(val(medclaim),'.__') >
<cfset totalmiscc = totalmiscc + numberformat(val(miscclaim),'.__')>
<cfset totalmthb = totalmthb + numberformat(val(totalbillable),'.__')>
<cfset totalnsded = totalnsded + numberformat(val(totalded),'.__')>
<cfset totalbill = totalbill + numberformat(val(getassignment.custtotal)-numberformat(val(getassignment.taxamt),'.__'),'.__')>
<cfset totalbillgst = totalbillgst + numberformat(val(getassignment.custtotal),'.__')>
<cfif getassignment.recordcount eq getassignment.currentrow>
<tr>
<td colspan="14"></td>
<td><b>#numberformat(totaldaysworked,'.__')#</b></td>
<td><b>#numberformat(totalhoursworked,'.__')#</b></td>
<td><b>#numberformat(totalpaidph,'.__')#</b></td>
<td><b>#numberformat(totalpaidal,'.__')#</b></td>
<td><b>#numberformat(totalpaidmlhpl,'.__')#</b></td>
<td><b>#numberformat(totalpaidloth,'.__')#</b></td>
<td><b>#numberformat(totalot1,'.__')#</b></td>
<td><b>#numberformat(totalot15,'.__')#</b></td>
<td><b>#numberformat(totalot2,'.__')#</b></td>
<td><b>#numberformat(totalhourspaid,'.__')#</b></td>
<td><b>#numberformat(totalgp,'.__')#</b></td>
<td><b>#numberformat(totalothpay,'.__')#</b></td>
<td><b>#numberformat(totalcpfer,'.__')#</b></td>
<td><b>#numberformat(totalsdl,'.__')#</b></td>
<td></td>
<td><b>#numberformat(totaladmcharge,'.__')#</b></td>
<td><b>#numberformat(totalmedc,'.__')#</b></td>
<td><b>#numberformat(totalmiscc,'.__')#</b></td>
<td><b>#numberformat(totalmthb,'.__')#</b></td>
<td><b>(#numberformat(totalnsded,'.__')#)</b></td>
<td><b>#numberformat(totalbill,'.__')#</b></td>
<cfif isdefined('form.totalbill')>
<td><b>#numberformat(totalbillgst,'.__')#</b></td>
</cfif>
</tr>
</table>
</cfif>
</cfloop>

</cfoutput>
</cfif>