<cfquery name="assignmentslip" datasource="manpower_i">
	select GROUP_CONCAT(emppaymenttype) payweek,GROUP_CONCAT(refno) as refno,paydate,empname,empno,SUM(selfcpf) as EPFWW,SUM(custcpf) as EPF_CC  FROM (
	select emppaymenttype,refno,paydate,empname,empno,selfcpf ,custcpf ,assignmentslipdate,
	(SELECT appstatus from manpower_i.argiro WHERE batchno = batches and appstatus ='approved' limit 1) as approve FROM manpower_i.assignmentslip
WHERE payrollperiod = 1 and batches != ''
HAVING approve = 'approved'
oRDER by assignmentslipdate) t  GROUP BY empno order by empno ;
</cfquery>

<cfset notMatch = ArrayNew(1)>
<cfset i = 1>
<cfloop query='assignmentslip'>
	<cfset epfww = 0>
	<cfset epfcc= 0>
	<cfset wage = 0>
	<cfset w = "">
	<cfloop list="#assignmentslip.payweek#" index="j">

		<cfset t = j >
		<cfquery name="payTM" datasource="manpower_p">
			SELECT
			CASE WHEN EPF_PAY_A IS NULL THEN 0 ELSE EPF_PAY_A end as EPF_PAY_A,
			CASE WHEN EPFCC IS NULL THEN 0 ELSE EPFCC END as EPFCC,
			CASE WHEN EPFWW IS NULL THEN 0 ELSE EPFWW END as EPFWW FROM #t# WHERE empno = '#assignmentslip.empno#';
		</cfquery>
		<cfset w = w & " " &payTM.EPF_PAY_A>
		<cfset wage = payTM.EPF_PAY_A + wage>
		<cfset epfww = epfww + payTM.EPFWW>
		<cfset epfcc = epfcc + payTM.EPFCC>
	</cfloop>


	<cfscript>

		if(assignmentslip.EPF_CC GT 0 AND ( assignmentslip.EPFWW neq epfww OR assignmentslip.EPF_CC neq epfcc)){
				a = structnew();
				a['wage'] = w;
				a['refno'] = assignmentslip.refno;
				a['empname'] = assignmentslip.empname;
				a['empno'] = assignmentslip.empno;
				a['epfCC_a'] = assignmentslip.EPF_CC;
				a['epfWW_a'] = assignmentslip.EPFWW;
				a['epfCC_b'] = epfcc;
				a['epfWW_b'] = epfww;
				a['payweek'] = assignmentslip.payweek;
				notMatch[i] = a;
				i = i+1;
		}
	</cfscript>
</cfloop>
<html lang="en">
<head>
  <title>EPF CHECKER</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
  <h1><cfoutput>ROWS : #i# / #assignmentslip.recordCount#</cfoutput></h1>
 <table class='table table-hover'>
	<tr>
		<th>Refno</th>
		<th>Emp no</th>
		<th>Emp name</th>
		<th>Week</th>
		<th>Wage</th>
		<th>EPF CC _ A</th>
		<th>EPF cc _ B </th>
		<th>EPF WW _ A </th>
		<th>EPF WW _ B</th>
	</tr>
	<cfloop array="#notMatch#" index="i">
		<cfoutput>
		<tr>
			<td>#i.refno#</td>
			<td>#i.empno#</td>
			<td>#i.empname#</td>
			<td>#i.payweek#</td>
			<td>#i.wage#</td>
			<td>#i.epfCC_a#</td>
			<td>#i.epfCC_b#</td>
			<td>#i.epfWW_a#</td>
			<td>#i.epfWW_b#</td>
		</tr>
		</cfoutput>
	</cfloop>
</table>
</div>

</body>
</html>
