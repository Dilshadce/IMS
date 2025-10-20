<cfoutput>
<cfset uuid = createuuid()>
<style type="text/css">
    @media print
    {
    	##non-printable { display: none; }

    }
    </style>

<cfsetting showdebugoutput="yes">
<cfinclude template="/object/dateobject.cfm">
<cfinclude template="/object/stringobject.cfm">
<cfquery name="getpayroll" datasource="#dts#">
SELECT mmonth,myear FROM payroll_main.gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
<cfset payrollmonth = getpayroll.mmonth>
<cfset payrollyear = getpayroll.myear>

<cfif payrollmonth eq form.month>
<cfquery name="paytra1" datasource="#replace(dts,'_i','_p')#">
SELECT * FROM PAYTRA1
</cfquery>
<cfquery name="paytran" datasource="#replace(dts,'_i','_p')#">
SELECT * FROM PAYTRAN
</cfquery>
<cfquery name="getlevy" datasource="#replace(dts,'_i','_p')#">
SELECT LEVY_SD,EMPNO,LEVY_FW_W FROM COMM
</cfquery>
<cfset paytra1tbl = "paytra1">
<cfset paytrantbl = "paytran">
<cfelse>
<cfquery name="paytra1" datasource="#replace(dts,'_i','_p')#">
SELECT * FROM pay1_12m_fig WHERE tmonth = "#form.month#"
</cfquery>
<cfquery name="paytran" datasource="#replace(dts,'_i','_p')#">
SELECT * FROM pay2_12m_fig WHERE tmonth = "#form.month#"
</cfquery>
<cfquery name="getlevy" datasource="#replace(dts,'_i','_p')#">
SELECT LEVY_SD,EMPNO,LEVY_FW_W FROM COMM_12m WHERE tmonth = "#form.month#"
</cfquery>
<cfset paytra1tbl = "pay1_12m_fig">
<cfset paytrantbl = "pay2_12m_fig">
</cfif>



<cfquery name="getplacement" datasource="#dts#">
SELECT * FROM placement
WHERE 1 = 1
<cfif form.getfrom neq "" and form.getto neq "">
and custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getto#">
</cfif> 
<cfif form.agentfrom neq "" and form.agentto neq "">
and consultant between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agentfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agentto#">
</cfif> 
<!--- <cfif form.areafrom neq "" and form.areato neq "">
and location between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areafrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areato#">
</cfif>  --->
</cfquery>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,agentlistuserid,compro from gsetup
</cfquery>

<cfquery name="getassignment" datasource="#dts#">
SELECT * FROM (
SELECT aa.*,if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0) as totalamt FROM assignmentslip aa
WHERE month(assignmentslipdate) = "#form.month#"
and year(assignmentslipdate) = "#payrollyear#"
<cfif form.billfrom neq "" and form.billto neq "">
and refno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billto#">
</cfif> 
<cfif form.areafrom neq "" and form.areato neq "">
and branch between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areafrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areato#">
</cfif>
<cfif isdefined('form.batches')>
and batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batches#" separator="," list="yes">)
</cfif>
<cfif form.createdfrm neq "" and form.createdto neq "">
and (created_by BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdfrm#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdto#">)
</cfif>
<!--- <cfif getplacement.recordcount neq 0> --->
and placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#VALUELIST(getplacement.placementno)#" list="yes" separator=",">)
<!--- </cfif> ---> ) as a
LEFT JOIN
(SELECT placementno as pno, location,consultant,custno as cno,custname,empname FROM placement) as b on a.placementno = b.pno
order by #form.orderby#,refno
</cfquery>
<html>
<head>
</head>
<body>
<table>
<tr>
<th colspan="100%" align="left"><font style="font-size:20px"><b>Batch Control Report</b></font></th>
</tr>
<tr>
<th colspan="100%" align="left">
#getgeneral.compro#
</th>
</tr>
<tr>
<th colspan="100%" align="left">
For Pay Period: #dateformat(createdate('#payrollyear#','#form.month#','1'),'mmmm yyyy')#
</th>
</tr>
<cfif isdefined('form.batches')>
<tr>
<th colspan="100%" align="left">
Batch : #form.batches#
</th>
</tr>
</cfif>
<tr>
<th colspan="100%" align="left">User : #getassignment.created_by#</th>
</tr>
<cfif isdefined('form.batches')>
<cfquery name="getbanktype" datasource="#dts#">
Select banktype from assignmentslip WHERE batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batches#" list="yes" separator=",">
) GROUP BY batches
</cfquery>
<tr>
<th colspan="100%" align="left">Bank Info : #valuelist(getbanktype.banktype)#</th>
</tr>
</cfif>
<tr>
<td><br>
<br>
</td>
</tr>
</table>
<table border="1">
<tr>
<th valign="top" align="left">Batch No</th>
<th valign="top" align="left">Giro Pay Date</th>
<!--- <th valign="top" align="left">User</th> --->
<th valign="top" align="left">Invoice No</th>
<th valign="top" align="left">Cust ID</th>
<th valign="top" align="left">Customer</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>Basic Pay</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>Paid PH & <br>Leave</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>OT</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>Payments & <br />Deductions</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>PB/AWS</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>EPF/SOCSO/WI/ADM for PB/AWS</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>Back/Over Pay</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>EPF</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>SOCSO</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>Admin Fee</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>Rebate</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>NS</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>Total Additional <br />
Charges / Deductions <br />
(exclude Adm Fee, Rebate & NS)</th>
<th valign="top" align="left">Invoice Gross</th>
<th valign="top" align="left">GST</th>
<th valign="top" align="left">Total Invoice</th>
<th valign="top" align="left">MA</th>
<th>&nbsp;</th>
<th valign="top" align="left">Employee No</th>
<th valign="top" align="left">Employee</th>
<th valign="top" align="left">CHQ No</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>Basic Pay</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>Paid PH & Leave</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>OT</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>Payments & Deductions</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>PB/AWS</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>Back/Over Pay</th>
<th valign="top" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>NS</th>
<th valign="top" align="right">EE Gross</th>
<th valign="top" align="right">Reimb</th>
<th valign="top" align="right">Deduction</th>
<th valign="top" align="right">EE EPF</th>
<th valign="top" align="right">EE SOCSO</th>
<th valign="top" align="right">TAX</th>
<th valign="top" align="right">NET PAY /<br />
GIRO Amount</th>
<th valign="top" align="right">ER EPF</th>
<th valign="top" align="right">ER SOSCO</th>
<th valign="top" align="right">Invoice less Salary</th>
</tr>

<cfset ibasicpay = 0>
<cfset ipaidlvl = 0>
<cfset iot = 0>
<cfset ipayded = 0>
<cfset ipbaws = 0 >
<cfset ipbawsext = 0 >
<cfset ibackoverpay = 0 >
<cfset icpf = 0 >
<cfset isdf = 0 >
<cfset iadminfee = 0>
<cfset irebate = 0 >
<cfset ins = 0 >
<cfset iaddcharges = 0 >
<cfset iinvgross = 0 >
<cfset igst = 0 >
<cfset itotalinv = 0 >
<cfset pbasicpay = 0 >
<cfset ppaidlvl = 0 >
<cfset pot = 0 >
<cfset ppayded = 0 >
<cfset ppbaws = 0>
<cfset pbackoverpay = 0 >
<cfset pns = 0 >
<cfset peegross = 0>
<cfset preimb = 0>
<cfset pded = 0>
<cfset peecpf = 0>
<cfset pfund = 0>
<cfset pnetpay = 0>
<cfset pinvless = 0 >
<cfset percpf = 0 >
<cfset psdf = 0 >
<cfset peesdf = 0 >
<cfset persdf = 0 >
<cfset ma1list = "">
<cfset ma2list = "">
<cfset subibasicpay = 0>
<cfset subipaidlvl = 0>
<cfset subiot = 0>
<cfset subipayded = 0>
<cfset subipbaws = 0 >
<cfset subipbawsext = 0 >
<cfset subibackoverpay = 0 >
<cfset subicpf = 0 >
<cfset subisdf = 0 >
<cfset subiadminfee = 0>
<cfset subirebate = 0 >
<cfset subins = 0 >
<cfset subiaddcharges = 0 >
<cfset subiinvgross = 0 >
<cfset subigst = 0 >
<cfset subitotalinv = 0 >
<cfset subpbasicpay = 0 >
<cfset subppaidlvl = 0 >
<cfset subpot = 0 >
<cfset subppayded = 0 >
<cfset subppbaws = 0>
<cfset subpbackoverpay = 0 >
<cfset subpns = 0 >
<cfset subpeegross = 0 >
<cfset subpreimb = 0>
<cfset subpded = 0>
<cfset subpeecpf = 0>
<cfset subpercpf = 0>
<cfset subpfund = 0>
<cfset subpnetpay = 0>
<cfset subpeesdf = 0>
<cfset subpersdf = 0>
<cfset subpsdf = 0>
<cfset subpinvless = 0 >
<cfset subma1list = "">
<cfset subma2list = "">

<cfset startbatches = getassignment.batches > 
<cfset startapprovedbydate = getassignment.approvedbydate>
<cfset batchlist = startbatches>
<cfloop query="getassignment">
<cfif getassignment.batches neq startbatches>
<cfset oldbatches = startbatches>
<cfset approvedbydateold = startapprovedbydate>
<cfset startbatches = getassignment.batches > 
<cfset startapprovedbydate = getassignment.approvedbydate>
<cfset batchlist = batchlist&","&getassignment.batches>
<tr>
<td colspan="100%"><hr /></td>
</tr>
<tr>
<th align="left" colspan="5">Sub Total</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subibasicpay,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subipaidlvl,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subiot,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subipayded,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subipbaws,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subipbawsext,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subibackoverpay,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subicpf,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subisdf,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subiadminfee,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subirebate,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subins,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subiaddcharges,',.__')#</th>
<th align="right">#numberformat(subiinvgross,',.__')#</th>
<th align="right">#numberformat(subigst,',.__')#</th>
<th align="right">#numberformat(subitotalinv,',.__')#</th>
<td colspan="5"></td>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subpbasicpay,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subppaidlvl,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subpot,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subppayded,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subppbaws,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subpbackoverpay,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subpns,',.__')#</th>
<th align="right">#numberformat(subpeegross,',.__')#</th>
<th align="right">#numberformat(subpreimb,',.__')#</th>
<th align="right">#numberformat(subpded,',.__')#</th>
<th align="right">#numberformat(subpeecpf,',.__')#</th>
<th align="right">#numberformat(subpeesdf,',.__')#</th>
<th align="right">#numberformat(subpfund,',.__')#</th>
<!---<th align="right">#numberformat(subpercpf,',.__')#</th>--->
<th align="right">#numberformat(subpnetpay,',.__')#</th>
<th align="right">#numberformat(subpercpf,',.__')#</th>
<th align="right">#numberformat(subpersdf,',.__')#</th>
<th align="right">#numberformat(subpinvless,',.__')#</th>
</tr>

<cfquery name="checkapproval" datasource="#dts#">
SELECT approved_on,approved_by FROM argiro 
WHERE 
batchno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#oldbatches#">
and appstatus = "Approved"
</cfquery>
<cfif checkapproval.recordcount neq 0>
<tr>
<td colspan="100%">Batch approved on #dateformat(checkapproval.approved_on,'dd/mm/yyyy')# by #checkapproval.approved_by#</td>
</tr>
</cfif>
<cfif form.getfrom eq "" and form.getto eq "" and form.agentfrom eq "" and form.agentto eq "" and form.areafrom eq "" and form.areato eq "" and form.billfrom eq "" and form.billto eq "" and isdefined('form.batches') and form.createdfrm eq "" and form.createdto eq "" and isdefined('form.summary')>
<cfquery name="insertgirotemp" datasource="#dts#">
INSERT INTO argirotemp
(
      `uuid`,
      `batchno`,
      `invgross`,
      `gstamt`,
      `totalinv`,
      `eegross`,
      `reimb`,
      `dedamt`,
      `eecpf`,
      `funddd`,
      `netpay`,
      `ercpf`,
      `sdf`,
      `invless`,
    `ibasicpay`,
    `ipaidlvl`,
    `iot`,
    `ipayded`,
    `ipbaws`,
    `ipbawsext`,
    `ibackoverpay`,
    `icpf`,
    `isdf`,
    `iadminfee`,
    `irebate`,
    `ins`,
    `iaddcharges`,
    `pbasicpay`,
    `ppaidlvl`,
    `pot`,
    `ppayded`,
    `ppbaws`,
    `pbackoverpay`,
    `pns`,
    `eesdf`,
	`ersdf`
    <cfif dateformat(approvedbydateold,'dd/mm/yyyy') neq "">   
    ,`approvedbydate`
    </cfif>
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#oldbatches#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subiinvgross,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subigst,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subitotalinv,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpeegross,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpreimb,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpded,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpeecpf,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpfund,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpnetpay,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpercpf,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpsdf,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpinvless,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subibasicpay,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subipaidlvl,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subiot,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subipayded,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subipbaws,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subipbawsext,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subibackoverpay,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subicpf,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subisdf,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subiadminfee,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subirebate,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subins,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subiaddcharges,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpbasicpay,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subppaidlvl,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpot,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subppayded,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subppbaws,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpbackoverpay,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpns,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpeesdf,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpersdf,'.__')#">
<cfif dateformat(approvedbydateold,'dd/mm/yyyy') neq "">  
,"#dateformat(approvedbydateold,'yyyy-mm-dd')#"
</cfif>
)
</cfquery>
</cfif>
<tr>
<td colspan="100%">&nbsp;

</td>
</tr>
<cfset subibasicpay = 0>
<cfset subipaidlvl = 0>
<cfset subiot = 0>
<cfset subipayded = 0>
<cfset subipbaws = 0 >
<cfset subipbawsext = 0 >
<cfset subibackoverpay = 0 >
<cfset subicpf = 0 >
<cfset subisdf = 0 >
<cfset subiadminfee = 0>
<cfset subirebate = 0 >
<cfset subins = 0 >
<cfset subiaddcharges = 0 >
<cfset subiinvgross = 0 >
<cfset subigst = 0 >
<cfset subitotalinv = 0 >
<cfset subpbasicpay = 0 >
<cfset subppaidlvl = 0 >
<cfset subpot = 0 >
<cfset subppayded = 0 >
<cfset subppbaws = 0>
<cfset subpbackoverpay = 0 >
<cfset subpns = 0 >
<cfset subpeegross = 0 >
<cfset subpreimb = 0>
<cfset subpded = 0>
<cfset subpeecpf = 0>
<cfset subpfund = 0>
<cfset subpnetpay = 0>
<cfset subpinvless = 0 >
<cfset subpercpf = 0 >
<cfset subpsdf = 0 >
<cfset subpeesdf = 0 >
<cfset subpersdf = 0 >
<cfset subma1list = "">
<cfset subma2list = "">
</cfif>
<tr>
<td  nowrap="nowrap">#getassignment.batches#</td>
<td  nowrap="nowrap">#dateformat(getassignment.giropaydate,'dd/mm/yyyy')#</td>
<!--- <td  nowrap="nowrap">#getassignment.created_by#</td> --->
<td  nowrap="nowrap">#getassignment.refno#</td>
<td  nowrap="nowrap">#getassignment.custno#</td>
<td  nowrap="nowrap">#getassignment.custname#</td>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(getassignment.custsalary),',.__')#</td>
<cfset ibasicpay = ibasicpay + numberformat(val(getassignment.custsalary),'.__')>
<cfset subibasicpay = subibasicpay + numberformat(val(getassignment.custsalary),'.__')>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(getassignment.custphnlsalary),',.__')#</td>
<cfset ipaidlvl = ipaidlvl + numberformat(val(getassignment.custphnlsalary),'.__')>
<cfset subipaidlvl = subipaidlvl + numberformat(val(getassignment.custphnlsalary),'.__')>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(getassignment.custottotal),',.__')#</td>
<cfset iot = iot + numberformat(val(getassignment.custottotal),'.__')>
<cfset subiot = subiot + numberformat(val(getassignment.custottotal),'.__')>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(getassignment.custallowance),',.__')#</td>
<cfset ipayded = ipayded + numberformat(val(getassignment.custallowance),'.__')>
<cfset subipayded = subipayded + numberformat(val(getassignment.custallowance),'.__')>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(getassignment.pberamt)+val(getassignment.awseramt),',.__')#</td>
<cfset ipbaws = ipbaws + numberformat(val(getassignment.pberamt)+val(getassignment.awseramt),'.__')>
<cfset subipbaws = subipbaws + numberformat(val(getassignment.pberamt)+val(getassignment.awseramt),'.__')>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(getassignment.pbcpf)+val(getassignment.pbsdf)+val(getassignment.pbwi)+val(getassignment.pbadm)+val(getassignment.awscpf)+val(getassignment.awssdf)+val(getassignment.awswi)+val(getassignment.awsadm),',.__')#</td>
<cfset ipbawsext = ipbawsext + numberformat(val(getassignment.pbcpf)+val(getassignment.pbsdf)+val(getassignment.pbwi)+val(getassignment.pbadm)+val(getassignment.awscpf)+val(getassignment.awssdf)+val(getassignment.awswi)+val(getassignment.awsadm),'.__')>
<cfset subipbawsext = subipbawsext + numberformat(val(getassignment.pbcpf)+val(getassignment.pbsdf)+val(getassignment.pbwi)+val(getassignment.pbadm)+val(getassignment.awscpf)+val(getassignment.awssdf)+val(getassignment.awswi)+val(getassignment.awsadm),'.__')>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(getassignment.custpayback),',.__')#</td>
<cfset ibackoverpay = ibackoverpay + numberformat(val(getassignment.custpayback),'.__')>
<cfset subibackoverpay = subibackoverpay + numberformat(val(getassignment.custpayback),'.__')>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(getassignment.custcpf),',.__')#</td>
<cfset icpf = icpf + numberformat(val(getassignment.custcpf),'.__')>
<cfset subicpf = subicpf + numberformat(val(getassignment.custcpf),'.__')>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(getassignment.custsdf),',.__')#</td>
<cfset isdf = isdf + numberformat(val(getassignment.custsdf),'.__')>
<cfset subisdf = subisdf + numberformat(val(getassignment.custsdf),'.__')>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(getassignment.adminfee),',.__')#</td>
<cfset iadminfee = iadminfee + numberformat(val(getassignment.adminfee),'.__')>
<cfset subiadminfee = subiadminfee + numberformat(val(getassignment.adminfee),'.__')>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(getassignment.rebate),',.__')#</td>
<cfset irebate = irebate + numberformat(val(getassignment.rebate),'.__')>
<cfset subirebate = subirebate + numberformat(val(getassignment.rebate),'.__')>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(getassignment.nscustded),',.__')#</td>
<cfset ins = ins + numberformat(val(getassignment.nscustded),'.__')>
<cfset subins = subins + numberformat(val(getassignment.nscustded),'.__')>
<cfset totaladd = ROUND((numberformat(val(getassignment.custdeduction),'.__') - numberformat(val(getassignment.adminfee),'.__') + numberformat(val(getassignment.rebate),'.__') + numberformat(val(getassignment.nscustded),'.__'))*100)/100>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(totaladd),',.__')#</td>
<cfset iaddcharges = iaddcharges + numberformat(val(totaladd),'.__')>
<cfset subiaddcharges = subiaddcharges + numberformat(val(totaladd),'.__')>
<td  nowrap="nowrap" align="right">#numberformat(val(getassignment.custtotalgross),',.__')#</td>
<cfset iinvgross = iinvgross + numberformat(val(getassignment.custtotalgross),'.__')>
<cfset subiinvgross = subiinvgross + numberformat(val(getassignment.custtotalgross),'.__')>
<td  nowrap="nowrap" align="right">#numberformat(val(getassignment.taxamt),',.__')#</td>
<cfset igst = igst + numberformat(val(getassignment.taxamt),'.__')>
<cfset subigst = subigst + numberformat(val(getassignment.taxamt),'.__')>
<td  nowrap="nowrap" align="right">#numberformat(val(getassignment.custtotal),',.__')#</td>
<cfset itotalinv = itotalinv + numberformat(val(getassignment.custtotal),'.__')>
<cfset subitotalinv = subitotalinv + numberformat(val(getassignment.custtotal),'.__')>
<cfquery name="getpayroll" dbtype="query">
SELECT * FROM #getassignment.paydate#
WHERE UPPER(EMPNO) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#UCASE(getassignment.empno)#">
</cfquery>

<cfquery name="levysd" dbtype="query">
SELECT LEVY_SD,LEVY_FW_W FROM getlevy WHERE UPPER(EMPNO) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#UCASE(getassignment.empno)#">
</cfquery>

<!--- <cfif getassignment.emppaymenttype neq "payweek1">
<cfset levysd.LEVY_SD = 0>
<cfset levysd.LEVY_FW_W = 0>
</cfif> --->


<cfquery name="checkma" datasource="#dts#">
SELECT count(refno) as rc, sum(if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0)) as totalamt, sum(coalesce(ded1,0)+coalesce(ded2,0)+coalesce(ded3,0)) as totalded FROM assignmentslip WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#"> and month(assignmentslipdate) = "#form.month#"
and year(assignmentslipdate) = "#payrollyear#"
and paydate = "#getassignment.paydate#"
</cfquery>
<cfif getassignment.paydate eq "paytra1">
<cfif listfind(ma1list,#getassignment.empno#) neq 0>
<cfset getpayroll.grosspay = 0>
<cfset getpayroll.epfww = 0>
<cfset getpayroll.tded = 0>
<cfset getpayroll.epfcc = 0>
<cfset getpayroll.netpay = 0>
<cfset getpayroll.ded101 = 0>
<cfset getpayroll.aw116 = 0>
<cfset getpayroll.aw117 = 0>
<cfset getassignment.selfsalary = 0>
<cfset getassignment.selfphnlsalary = 0>
<cfset getassignment.selfottotal = 0 >
<cfset getassignment.selfallowance = 0>
<cfset getassignment.selfpayback = 0>
<cfset checkma.totalamt = 0 >
<cfset checkma.totalded = 0 >
<cfset levysd.levy_sd = 0>
<cfset levysd.levy_fw_w = 0>
</cfif>
<cfelse>
<cfif listfind(ma2list,#getassignment.empno#) neq 0>
<cfset getpayroll.grosspay = 0>
<cfset getpayroll.epfww = 0>
<cfset getpayroll.tded = 0>
<cfset getpayroll.epfcc = 0>
<cfset getpayroll.netpay = 0>
<cfset getpayroll.ded101 = 0>
<cfset getpayroll.aw116 = 0>
<cfset getpayroll.aw117 = 0>
<cfset getassignment.selfsalary = 0>
<cfset getassignment.selfphnlsalary = 0>
<cfset getassignment.selfottotal = 0 >
<cfset getassignment.selfallowance = 0>
<cfset getassignment.selfpayback = 0>
<cfset checkma.totalamt = 0 >
<cfset checkma.totalded = 0 >
<cfset levysd.levy_sd = 0>
<cfset levysd.levy_fw_w = 0>
</cfif>
</cfif>
<cfif checkma.rc neq 1>
<cfset ma = "Y">
<cfif getassignment.paydate eq "paytra1">
<cfset ma1list = ma1list&trim(getassignment.empno)&",">
<cfelse>
<cfset ma2list = ma2list&trim(getassignment.empno)&",">
</cfif>
<cfelse>
<cfset ma = "">
</cfif>

<cfquery name="getpayrolldetail" dbtype="query">
SELECT grosspay FROM #getassignment.paydate#
WHERE UPPER(EMPNO) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#UCASE(getassignment.empno)#">
</cfquery>
<cfquery name="getpayrolldetail2" dbtype="query">
SELECT grosspay FROM <cfif getassignment.paydate eq "paytra1">paytran<cfelse>paytra1</cfif>
WHERE UPPER(EMPNO) = <cfqueryparam cfsqltype="cf_sql_varchar" value="#UCASE(getassignment.empno)#">
</cfquery>

<cfif val(getpayrolldetail.grosspay) + val(getpayrolldetail2.grosspay) neq 0>
<cfset levysd.levy_sd = numberformat(val(levysd.levy_sd) * (val(getpayrolldetail.grosspay)/(val(getpayrolldetail.grosspay) + val(getpayrolldetail2.grosspay))),'.__')>
</cfif>


<td  nowrap="nowrap">#ma#</td>
<td  nowrap="nowrap"></td>
<td  nowrap="nowrap">#getassignment.empno#</td>
<td  nowrap="nowrap">#getassignment.empname#</td>
<td  nowrap="nowrap">#getpayroll.cheque_no#</td>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(getassignment.selfsalary),',.__')#</td>
<cfset pbasicpay = pbasicpay + numberformat(val(getassignment.selfsalary),'.__')>
<cfset subpbasicpay = subpbasicpay + numberformat(val(getassignment.selfsalary),'.__')>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(getassignment.selfphnlsalary),',.__')#</td>
<cfset ppaidlvl = ppaidlvl + numberformat(val(getassignment.selfphnlsalary),'.__')>
<cfset subppaidlvl = subppaidlvl + numberformat(val(getassignment.selfphnlsalary),'.__')>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(getassignment.selfottotal),',.__')#</td>
<cfset pot = pot + numberformat(val(getassignment.selfottotal),'.__')>
<cfset subpot = subpot + numberformat(val(getassignment.selfottotal),'.__')>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(getassignment.selfallowance),',.__')#</td>
<cfset ppayded = ppayded + numberformat(val(getassignment.selfallowance),'.__')>
<cfset subppayded = subppayded + numberformat(val(getassignment.selfallowance),'.__')>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(getpayroll.aw116)+val(getpayroll.aw117),',.__')#</td>
<cfset ppbaws = ppbaws + numberformat(val(getpayroll.aw116)+val(getpayroll.aw117),'.__')>
<cfset subppbaws = subppbaws + numberformat(val(getpayroll.aw116)+val(getpayroll.aw117),'.__')>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(getassignment.selfpayback),',.__')#</td>
<cfset pbackoverpay = pbackoverpay + numberformat(val(getassignment.selfpayback),'.__')>
<cfset subpbackoverpay = subpbackoverpay + numberformat(val(getassignment.selfpayback),'.__')>
<td  nowrap="nowrap" align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(val(getpayroll.ded101),',.__')#</td>
<cfset pns = pns + numberformat(val(getpayroll.ded101),'.__')>
<cfset subpns = subpns + numberformat(val(getpayroll.ded101),'.__')>
<td  nowrap="nowrap" align="right">#numberformat(val(getassignment.selfsalary)-val(getpayroll.ded101),',.__')#</td>
<cfset peegross = peegross + numberformat(val(getassignment.selfsalary)-val(getpayroll.ded101),'.__')>
<cfset subpeegross = subpeegross + numberformat(val(getassignment.selfsalary)-val(getpayroll.ded101),'.__')>
<td  nowrap="nowrap" align="right">#numberformat(val(checkma.totalamt),',.__')#</td>
<cfset preimb = preimb + numberformat(val(checkma.totalamt),'.__')>
<cfset subpreimb = subpreimb + numberformat(val(checkma.totalamt),'.__')>
<td  nowrap="nowrap" align="right">#numberformat(val(checkma.totalded),',.__')#</td>
<cfset pded = pded + numberformat(val(checkma.totalded),'.__')>
<cfset subpded = subpded + numberformat(val(checkma.totalded),'.__')>
<!---<td  nowrap="nowrap" align="right">#numberformat(val(getassignment.selfcpf),',.__')#</td>--->
<cfset peecpf = peecpf + numberformat(val(getassignment.selfcpf),'.__')>
<cfset subpeecpf = subpeecpf + numberformat(val(getassignment.selfcpf),'.__')>
<td  nowrap="nowrap" align="right">#numberformat(val(getassignment.selfcpf),',.__')#</td>
<cfset peesdf = peesdf + numberformat(val(getassignment.selfsdf),'.__')>
<cfset subpeesdf = subpeesdf + numberformat(val(getassignment.selfsdf),'.__')>
<td  nowrap="nowrap" align="right">#numberformat(val(getassignment.selfsdf),'.__')#</td>
<cfset pfund = pfund + numberformat(val(getpayroll.tded)-val(getpayroll.ded101),'.__')>
<cfset subpfund = subpfund + numberformat(val(getpayroll.tded)-val(getpayroll.ded101),'.__')>
<td  nowrap="nowrap" align="right">
#numberformat(val(pfund),',.__')#</td>
<cfset totalnet = numberformat(val(getassignment.selftotal),'.__') + numberformat(val(checkma.totalamt),'.__')-numberformat(val(checkma.totalded),'.__')>
<td  nowrap="nowrap" align="right">
#numberformat(val(totalnet),',.__')#</td>
<!---<cfset percpf = percpf + numberformat(val(getassignment.custcpf),'.__')>
<cfset subpercpf = subpercpf + numberformat(val(getassignment.custcpf),'.__')>--->
<!---<td  nowrap="nowrap" align="right">#numberformat(val(getassignment.selfusualpay),',.__')#</td>--->
<cfset percpf = persdf + numberformat(val(getassignment.custcpf),'.__')>
<cfset subpercpf = subpercpf + numberformat(val(getassignment.custcpf),'.__')>
<td  nowrap="nowrap" align="right">#numberformat(val(getassignment.custcpf),',.__')#</td>
<cfset persdf = persdf + numberformat(val(getassignment.custsdf),'.__')>
<cfset subpersdf = subpersdf + numberformat(val(getassignment.custsdf),'.__')>
<td  nowrap="nowrap" align="right">#numberformat(val(getassignment.custsdf),',.__')#</td>
<cfset pnetpay = pnetpay + numberformat(val(totalnet),'.__')>
<cfset subpnetpay = subpnetpay + numberformat(val(totalnet),'.__')>
<cfset invlesspay = numberformat(val(getassignment.custtotalgross),'.__') - (numberformat(val(getassignment.selftotal)-val(getpayroll.ded101),'.__')+ numberformat(val(checkma.totalamt),'.__')+numberformat(val(getassignment.selfcpf),'.__')+numberformat(val(levysd.levy_sd),'.__')+numberformat(val(levysd.levy_fw_w),'.__'))>
<td  nowrap="nowrap" align="right">#numberformat(val(invlesspay),',.__')#</td>
<cfset pinvless = pinvless + numberformat(invlesspay,'.__')>
<cfset subpinvless = subpinvless + numberformat(invlesspay,'.__')>
</tr>
<cfif form.getfrom eq "" and form.getto eq "" and form.agentfrom eq "" and form.agentto eq "" and form.areafrom eq "" and form.areato eq "" and form.billfrom eq "" and form.billto eq "" and isdefined('form.batches') and form.createdfrm eq "" and form.createdto eq "" and isdefined('form.summary')>
<cfquery name="insertrow" datasource="#dts#">
INSERT INTO icgirotemp
(
  `uuid`,
  `batchno`,
  `giropaydate`,
  `invoiceno`,
  `custid`,
  `customer`,
  `invoicegross`,
  `gstamt`,
  `totalinv`,
  `multipleassign`,
  `empno`,
  `empname`,
  `chequeno`,
  `eegross`,
  `reimb`,
  `deduction`,
  `eecpf`,
  `funddd`,
  `netpay`,
  `ercpf`,
  `sdfamt`,
  `invless`,
      `ibasicpay`,
    `ipaidlvl`,
    `iot`,
    `ipayded`,
    `ipbaws`,
    `ipbawsext`,
    `ibackoverpay`,
    `icpf`,
    `isdf`,
    `iadminfee`,
    `irebate`,
    `ins`,
    `iaddcharges`,
    `pbasicpay`,
    `ppaidlvl`,
    `pot`,
    `ppayded`,
    `ppbaws`,
    `pbackoverpay`,
    `pns`,
    `eesdf`,
    `ersdf`
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.batches#">,
"#dateformat(getassignment.giropaydate,'yyyy-mm-dd')#",
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.refno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.custno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.custname#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.custtotalgross),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.taxamt),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.custtotal),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#ma#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empno#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.empname#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#getpayroll.cheque_no#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.selfusualpay)-val(getpayroll.ded101),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(checkma.totalamt),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(checkma.totalded),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getpayroll.epfww),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getpayroll.tded)-val(getpayroll.ded101),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(totalnet),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getpayroll.epfcc),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(levysd.levy_sd),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(invlesspay,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.custsalary),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.custphnlsalary),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.custottotal),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.custallowance),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.pberamt)+val(getassignment.awseramt),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.pbcpf)+val(getassignment.pbsdf)+val(getassignment.pbwi)+val(getassignment.pbadm)+val(getassignment.awscpf)+val(getassignment.awssdf)+val(getassignment.awswi)+val(getassignment.awsadm),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.custpayback),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.custcpf),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.custsdf),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.adminfee),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.rebate),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.nscustded),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(totaladd),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.selfsalary),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.selfphnlsalary),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.selfottotal),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.selfallowance),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getpayroll.aw116)+val(getpayroll.aw117),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getassignment.selfpayback),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(val(getpayroll.ded101),'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpeesdf,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpersdf,'.__')#">
)
</cfquery>


</cfif>
<cfif getassignment.recordcount eq getassignment.currentrow>
<cfset oldbatches = getassignment.batches>
<cfset approvedbydateold = getassignment.approvedbydate>
<tr>
<td colspan="100%"><hr /></td>
</tr>
<tr>
<th align="left" colspan="5">Sub Total</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subibasicpay,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subipaidlvl,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subiot,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subipayded,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subipbaws,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subipbawsext,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subibackoverpay,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subicpf,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subisdf,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subiadminfee,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subirebate,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subins,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subiaddcharges,',.__')#</th>
<th align="right">#numberformat(subiinvgross,',.__')#</th>
<th align="right">#numberformat(subigst,',.__')#</th>
<th align="right">#numberformat(subitotalinv,',.__')#</th>
<td colspan="5"></td>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subpbasicpay,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subppaidlvl,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subpot,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subppayded,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subppbaws,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subpbackoverpay,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(subpns,',.__')#</th>
<th align="right">#numberformat(subpeegross,',.__')#</th>
<th align="right">#numberformat(subpreimb,',.__')#</th>
<th align="right">#numberformat(subpded,',.__')#</th>
<th align="right">#numberformat(subpeecpf,',.__')#</th>
<th align="right">#numberformat(subpeesdf,',.__')#</th>
<th align="right">#numberformat(subpfund,',.__')#</th>
<th align="right">#numberformat(subpnetpay,',.__')#</th>
<th align="right">#numberformat(subpercpf,',.__')#</th>
<th align="right">#numberformat(subpersdf,',.__')#</th>
<th align="right">#numberformat(subpinvless,',.__')#</th>
</tr>
<cfquery name="checkapproval" datasource="#dts#">
SELECT approved_on,approved_by FROM argiro 
WHERE 
batchno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#oldbatches#">
and appstatus = "Approved"
</cfquery>
<cfif checkapproval.recordcount neq 0>
<tr>
<td colspan="100%">Batch approved on #dateformat(checkapproval.approved_on,'dd/mm/yyyy')# by #checkapproval.approved_by#</td>
</tr>
</cfif>

<cfif form.getfrom eq "" and form.getto eq "" and form.agentfrom eq "" and form.agentto eq "" and form.areafrom eq "" and form.areato eq "" and form.billfrom eq "" and form.billto eq "" and isdefined('form.batches') and form.createdfrm eq "" and form.createdto eq "" and isdefined('form.summary')>
<cfquery name="insertgirotemp" datasource="#dts#">
INSERT INTO argirotemp
(
      `uuid`,
      `batchno`,
      `invgross`,
      `gstamt`,
      `totalinv`,
      `eegross`,
      `reimb`,
      `dedamt`,
      `eecpf`,
      `funddd`,
      `netpay`,
      `ercpf`,      
      `invless`,
    `ibasicpay`,
    `ipaidlvl`,
    `iot`,
    `ipayded`,
    `ipbaws`,
    `ipbawsext`,
    `ibackoverpay`,
    `icpf`,
    `iadminfee`,
    `irebate`,
    `ins`,
    `iaddcharges`,
    `pbasicpay`,
    `ppaidlvl`,
    `pot`,
    `ppayded`,
    `ppbaws`,
    `pbackoverpay`,
    `pns`,
    `eesdf`,
	`ersdf`
    <cfif dateformat(approvedbydateold,'dd/mm/yyyy') neq "">   
    ,`approvedbydate`
    </cfif>
)
VALUES
(
<cfqueryparam cfsqltype="cf_sql_varchar" value="#uuid#">,
<cfqueryparam cfsqltype="cf_sql_varchar" value="#oldbatches#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subiinvgross,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subigst,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subitotalinv,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpeegross,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpreimb,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpded,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpeecpf,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpfund,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpnetpay,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpercpf,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpinvless,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subibasicpay,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subipaidlvl,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subiot,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subipayded,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subipbaws,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subipbawsext,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subibackoverpay,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subicpf,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subiadminfee,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subirebate,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subins,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subiaddcharges,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpbasicpay,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subppaidlvl,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpot,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subppayded,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subppbaws,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpbackoverpay,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpns,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpeesdf,'.__')#">,
<cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(subpersdf,'.__')#">
<cfif dateformat(approvedbydateold,'dd/mm/yyyy') neq "">  
,"#dateformat(approvedbydateold,'yyyy-mm-dd')#"
</cfif>
)
</cfquery>
</cfif>
<tr>
<td colspan="100%">&nbsp;

</td>
</tr>
<cfset subibasicpay = 0>
<cfset subipaidlvl = 0>
<cfset subiot = 0>
<cfset subipayded = 0>
<cfset subipbaws = 0 >
<cfset subipbawsext = 0 >
<cfset subibackoverpay = 0 >
<cfset subicpf = 0 >
<cfset subisdf = 0 >
<cfset subiadminfee = 0>
<cfset subirebate = 0 >
<cfset subins = 0 >
<cfset subiaddcharges = 0 >
<cfset subiinvgross = 0 >
<cfset subigst = 0 >
<cfset subitotalinv = 0 >
<cfset subpbasicpay = 0 >
<cfset subppaidlvl = 0 >
<cfset subpot = 0 >
<cfset subppayded = 0 >
<cfset subppbaws = 0>
<cfset subpbackoverpay = 0 >
<cfset subpns = 0 >
<cfset subpeegross = 0 >
<cfset subpreimb = 0>
<cfset subpded = 0>
<cfset subpeecpf = 0>
<cfset subpfund = 0>
<cfset subpnetpay = 0>
<cfset subpinvless = 0 >
<cfset subma1list = "">
<cfset subma2list = "">
</cfif>
</cfloop>
<tr>
<td colspan="100%"><hr /></td>
</tr>
<tr>
<th align="left" colspan="5">Total Amount</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(ibasicpay,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(ipaidlvl,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(iot,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(ipayded,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(ipbaws,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(ipbawsext,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(ibackoverpay,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(icpf,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(isdf,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(iadminfee,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(irebate,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(ins,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(iaddcharges,',.__')#</th>
<th align="right">#numberformat(iinvgross,',.__')#</th>
<th align="right">#numberformat(igst,',.__')#</th>
<th align="right">#numberformat(itotalinv,',.__')#</th>
<td colspan="5"></td>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(pbasicpay,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(ppaidlvl,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(pot,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(ppayded,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(ppbaws,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(pbackoverpay,',.__')#</th>
<th align="right"<cfif isdefined('form.summary')> style="display:none" </cfif>>#numberformat(pns,',.__')#</th>
<th align="right">#numberformat(peegross,',.__')#</th>
<th align="right">#numberformat(preimb,',.__')#</th>
<th align="right">#numberformat(pded,',.__')#</th>
<th align="right">#numberformat(peecpf,',.__')#</th>
<th align="right">#numberformat(peesdf,',.__')#</th>
<th align="right">#numberformat(pfund,',.__')#</th>
<th align="right">#numberformat(pnetpay,',.__')#</th>
<th align="right">#numberformat(percpf,',.__')#</th>
<th align="right">#numberformat(persdf,',.__')#</th>
<th align="right">#numberformat(pinvless,',.__')#</th>
</tr>
<tr>
<td colspan="100%"><hr /></td>
</tr>
<tr>
<td colspan="100%"><hr /></td>
</tr>
<cfquery name="getremark" datasource="#dts#">
SELECT assigndesp,refno,batches FROM assignmentslip
WHERE
refno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getassignment.refno)#" list="yes" separator=",">)
AND assigndesp <> ""
AND assigndesp is not null
ORDER BY batches,refno
</cfquery>
<cfif getremark.recordcount neq 0>
<tr>
<td colspan="100%">
<table>
<tr>
<th>Batch No</th>
<th>Invoice No</th>
<th>Remark</th>
</tr>
<cfloop query="getremark">
<tr>
<td>#getremark.batches#</td>
<td>#getremark.refno#</td>
<td>#getremark.assigndesp#</td>
</tr>
</cfloop>
</table>
</td>
</tr>
</cfif>
<cfif isdefined('form.summary')> 
<tr>
<td align="right" colspan="100%">
<br />
<br />
<br />
<br />
<br />
________________________
<br />`
(Approved by ___________/Date)
</td>
</tr>
<cfif form.getfrom eq "" and form.getto eq "" and form.agentfrom eq "" and form.agentto eq "" and form.areafrom eq "" and form.areato eq "" and form.billfrom eq "" and form.billto eq "" and isdefined('form.batches') and form.createdfrm eq "" and form.createdto eq "" and isdefined('form.summary')>

<cfquery name="checkexisted" datasource="#dts#">
SELECT id,submited_by,submited_on,batchno FROM argiro WHERE batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#batchlist#" separator="," list="yes">) and appstatus in ("Approved","Pending") ORDER BY submited_on
</cfquery>

<cfif checkexisted.recordcount neq listlen(batchlist)>
<tr>
<td align="right" colspan="100%"><cfform name="submitform" id="submitform" action="submitforapprove.cfm" method="post">
<cfinput type="hidden" required="yes" message="No Batch For Approval" name="batchlist" id="batchlist" validateat="onsubmit" value="#batchlist#">
<cfinput type="hidden" name="uuidfield" id="uuidfield" value="#uuid#">
<cfinput type="submit" name="submit_btn" id="non-printable" value="Submit For Approval" validate="submitonce" validateat="onsubmit">
</cfform>
</td>
</tr>
</cfif>
</cfif>
</cfif>
</table>
</body>
</html>


</cfoutput>
