<!---
	<cfset HRootPath = "C:\Inetpub\wwwroot\payroll\">
	--->
<cfsetting requesttimeout="0" >
<cfset filenewdir = #HRootPath# & "download\manpower_p\">
<cfquery name="getEntity" datasource="manpower_p">
	SELECT * FROM manpower_i.invaddress WHERE invNogroup = "#form.entity#"
</cfquery>
<cfscript>

	testTable = [];

	sumFields = ['selfsalary','selfexception',
				 'selfcpf','selfsdf','selftotal',
				 "lvltotalee1"
				 ];

	OTFields = [];
	deductionFields = [];

	// OT fields
	for(i = 1 ; i <= 8; i = i+1){
		ArrayAppend(OTFields,"selfOT"&i);
	}

	//deductions
	for(i=1; i<=3; i = i+1 ){
		ArrayAppend(deductionFields,"ded"&i);
	}

	sumFields.addAll(OTFields);
	//sumFields.addAll(varAllowanceFields);
	//sumFields.addAll(fixAllowanceFields);
	sumFields.addAll(deductionFields);

</cfscript>
<cfquery name="getAssignment" datasource="manpower_p">
	SELECT SUM(EPFCC) as sum_EPFCC, SUM(SOCSOCC) as sum_SOCSOCC,
	(SELECT department from manpower_i.placement where placementno = a.placementno ) as dept,
	<cfloop array="#sumFields#" index="i">
		<cfoutput>
			SUM(#i#) as 'sum_#i#',
		</cfoutput>
	</cfloop>
	a.*,YEAR(assignmentslipdate) as a_year
	 FROM (
	SELECT aa.*,p.socsono,p.nricn,p.epfno,p.itaxno, p.bankcode, p.bankaccno,
	(SELECT invnogroup from manpower_i.bo_jobtypeinv WHERE
	jobtype = ( SELECT jobpostype from manpower_i.placement where placementno = aa.placementno) and officecode =
	 ( SELECT location from manpower_i.placement where placementno = aa.placementno)
	) as entity,
	CASE WHEN aa.paydate = "paytran" then
		(SELECT CASE WHEN EPFCC + EPFCC_adjustment is null then 0 else EPFCC + EPFCC_adjustment END FROM pay2_12m_fig where empno = aa.empno
		AND TMONTH = '#form.month#')
	else
		(SELECT CASE WHEN EPFCC + EPFCC_adjustment is null then 0 else  EPFCC + EPFCC_adjustment END FROM pay1_12m_fig where empno = aa.empno AND TMONTH = '#form.month#')
	END as EPFCC,
	CASE WHEN aa.paydate = "paytran" then
		(SELECT CASE WHEN SOCSOCC is null then 0 else SOCSOCC END FROM pay2_12m_fig where empno = aa.empno AND TMONTH = '#form.month#')
	else
		(SELECT CASE WHEN SOCSOCC is null then 0 else SOCSOCC END FROM pay1_12m_fig where empno = aa.empno AND TMONTH = '#form.month#')
	END as SOCSOCC,
	if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0) as totalamt
	FROM manpower_i.assignmentslip aa
	LEFT JOIN manpower_p.pmast p ON aa.empno = p.empno
	WHERE batches != ''
	AND payrollperiod = "1"
	and aa.empno = '#form.emp#'

	having entity = "#form.entity#"
	) as a
	group by empno
	order by a.custno, a.empno;
</cfquery>
<cfif DirectoryExists(filenewdir) eq false>
	<cfdirectory action = "create" directory = "#filenewdir#" >
</cfif>
<cfset filedir = filenewdir&"file"&huserid&".txt">
<cfset startwrite = 1>
<cffile action = "write"
	file = "#filedir#"
	output = "" nameconflict="overwrite">
<cfloop query="getAssignment">
	<cfquery name="getPayYTD" datasource="manpower_p">
		SELECT *,CASE WHEN DED115 is null then 0 else DED115 end as DED115
		FROM pay_ytd where empno = "#getAssignment.empno#";
	</cfquery>
	<cfquery name="getAw" datasource="manpower_p">
		SELECT refno,batches,
		<cfloop from='1' to="18" index="i">
			awee#i#, allowance#i#,
			</cfloop>
			<cfloop from='1' to="6" index="i">
				fixawcode#i#,fixawee#i#,
			</cfloop>
			(SELECT invnogroup from manpower_i.bo_jobtypeinv WHERE
				jobtype = ( SELECT jobpostype from manpower_i.placement where placementno = aa.placementno) and officecode =
				 ( SELECT location from manpower_i.placement where placementno = aa.placementno)
			) as entity

			FROM manpower_i.assignmentslip aa
			WHERE batches != ''
			AND payrollperiod = "#form.month#"


			and aa.empno = "#getAssignment.empno#"
			having entity = "#form.entity#"
	</cfquery>
	<cfquery name="getPCB" datasource="manpower_p">
		SELECT CASE WHEN SUM(funddd) IS NOT NULL THEN SUM(funddd) ELSE 0 END as PCB FROM manpower_i.icgiro c
		WHERE empno = "#getAssignment.empno#"
		and (SELECT appstatus from manpower_i.argiro WHERE uuid = c.uuid ORDER BY submited_on DESC LIMIT 1) = "Approved"
		AND batchno IN (
			<cfloop query="#getAw#">
				'#getAw.batches#',
				</cfloop>''
		);
	</cfquery>
	<cfscript>
		 fileWidth = 90;
		 leftPad = 0;
		 entityName = #getEntity.name#;
		 empmo = #getAssignment.empno#;
		 empname = #getAssignment.empname#;
		 epfno = #getAssignment.epfno#;
		 ic = #getAssignment.nricn#;
		 socsono = #Trim(getAssignment.socsono)#;
		 taxno = #Trim(getAssignment.itaxno)#;
		 date = getAssignment.a_year & '-' & left(MonthAsString(getAssignment.payrollperiod),3);
		 dept = #Trim(getAssignment.dept)#;
		 cat = "FIELD";
		 bank = #getAssignment.bankcode# & " " & #getAssignment.bankaccno#;
		 epfcc = #getAssignment.EPFCC#;
		 socsocc = #getAssignment.SOCSOCC#;

		//initialize the earnings and deductions columns
		 earnings = ["Normal"];
	     earnings_amt = [getAssignment.sum_selfsalary];

		bodyTopMargin = 2;
		if(getAssignment.currentRow % 3 == 0){
			bodyTopMargin = 1;
		}else{
			bodyTopMargin = 2;
		}

		if(getAssignment.currentRow % 2 == 0){
			footerMargin = 3;
		}else{
			footerMargin = 	6;
		}

		if(getAssignment.currentRow % 6 ==0){
			footerMargin -= 1;
		}

		 deductions = [];
		 deductions_amt = [];
	     if(getAssignment.sum_selfCPF > 0 ){
	     	ArrayAppend(deductions,"EMPLOYEE EPF");
	     	ArrayAppend(deductions_amt,getAssignment.sum_selfCPF);
	     }
	     if(getAssignment.sum_selfSDF > 0 ){
	     	ArrayAppend(deductions,"EMPLOYEE SOCSO");
	     	ArrayAppend(deductions_amt,getAssignment.sum_selfSDF);
	     }

	     if( getPCB.PCB > 0){
	     	ArrayAppend(deductions,"EMPLOYEE Tax");
	     	ArrayAppend(deductions_amt,getPCB.PCB);
	     }

		 if(getAssignment.sum_lvltotalee1 != 0 and getAssignment.sum_lvltotalee1 != ''){
		 	ArrayAppend(deductions,"NPL");
		 	ArrayAppend(deductions_amt , (getAssignment.sum_lvltotalee1 * -1));
		 }

		// adding OT FIELDS

		OTLabels = ["OT 1.0","OT 1.5","OT 2.0","OT 3.0", "RD 1.0","RD 2.0","PH 1.0","PH 2.0"];
		 for(i = 1; i <= ArrayLen(OTFields); i = i + 1){
		 	if(getAssignment["sum_" & OTFields[i]][getAssignment.currentRow] > 0 ){
				ArrayAppend(earnings,OTLabels[i]);
				ArrayAppend(earnings_amt,getAssignment["sum_" & OTFields[i]][getAssignment.currentRow] );
		 	}
	 	}

	 	allowances = StructNew();
		for(i = 1; i <= getAw.recordCount; i++){
			for(aw = 1; aw<= 18; aw++){ // variable allowances
				if(getAw['awee'&aw][i] > 0){
					addToAllowance(getAw['allowance'&aw][i],getAw['awee'&aw][i]);

				}
			}

			for(fixaw= 1; fixaw <= 6; fixaw++){ //fixed allowances
				if(getAw['fixawee'&fixaw][i] > 0){
						addToAllowance(getAw['fixawcode'&fixaw][i],getAw['fixawee'&fixaw][i]);

				}
			}

		}


		for(key in allowances){
				ArrayAppend(earnings,getAllowance(key));
				ArrayAppend(earnings_amt,allowances[key]);
		}


		// adding deduction fields
		for(i = 1; i <= ArrayLen(deductionFields); i = i + 1){
		 	if(getAssignment["sum_" & deductionFields[i]][getAssignment.currentRow] > 0 ){
				ArrayAppend(deductions,getAssignment["ded" & i & "desp"][getAssignment.currentRow]);
				ArrayAppend(deductions_amt,getAssignment["sum_" & deductionFields[i]][getAssignment.currentRow] );
		 	}
		 }


		// Y-T-D amount
		 tgrossPay = getPayYTD.grosspay;
		 //tnettPay = getPayYTD.netpay;


		 if(getPayYTD.DED115 == ""){
		 	getPayYTD.DED115 = 0;
		 }

		 if(getPayYTD.SOCSOWW == ""){
		 	getPayYTD.SOCSOWW = 0;
		 }

		 if(getPayYTD.EPFWW == ""){
		 	getPayYTD.EPFWW = 0;
		 }

		 nettPay = getAssignment.sum_selftotal - getPCB.PCB;
 		tnettPay = nettPay;
		  y_epf = numberFormat(getAssignment.sum_selfCPF,'9.99') & " / " & numberformat(EPFCC,'9.99');
		 y_socso = numberformat(getAssignment.sum_selfSDF,'9.99') & " / " & numberformat(SOCSOCC,'9.99');
		// y_epf = numberFormat(getPayYTD.EPFWW,'9.99') & " / " & numberformat(getPayYTD.EPFCC,'9.99');
		 //y_socso = numberformat(getPayYTD.SOCSOWW ,'9.99') & " / " & numberformat(getPayYTD.SOCSOCC,'9.99');
		 tax = getPayYTD.DED115;

		function addToAllowance(code,value){
			if(StructKeyExists(allowances,code)){
				allowances[code] += value;
			}else{
				allowances[code] = value;
			}
		}

	</cfscript>
	<!--- PRINT HEADER --->
	<cfscript>
		println('');
		println('');
		rightPad = 4;
		 toPrint = entityName;
		 spacing = fileWidth - len(entityName) - len(date) -rightPad;
		 pad(spacing);

		toPrint = toPrint & date;
		println(toPrint);

		toPrint = "Name : " & empname & "    EPF NO : " & epfno ;
		deptStr = "DEPT : " & dept;
		pad(fileWidth - len(toPrint) - len(deptStr) - rightPad);
		toPrint = toPrint & deptStr;
		println(toPrint);

		toPrint = "I\C : " & ic & "   SOCSO : " & socsono & "  Tax no : " & taxno;
		cat = "CAT : " ;
		pad(fileWidth - len(toPrint) - len(cat)-rightPad);

		toPrint = toPrint & cat;
		println(toPrint);
		for(i = 0; i < bodyTopMargin; i++){
			println("");
		}


	</cfscript>
	<!--- PRINT BODY --->
	<cfscript>

		cell_1 = 1;
		cell_2 = 34;
		cell_3 = 50;
		cell_4 = 80;
		leftPad = 3;

		pad(cell_2 - cell_1 + 1);
		toPrint &= "|EARNINGS";
		pad(cell_3 - len(toPrint));
		toPrint &= "DEDUCTIONS";
		pad(cell_4 - len(toPrint) );
		toPrint &= "|";
		println(toPrint);

		bodySize = 18;
		limit = 18;
		total_earnings = 0;
		total_deductions = 0;

		for(k = 1; k <= limit ; k++){ //print each line

			// PRINTING EARNINGS
			if(ArrayLen(earnings) >= k ){
				toPrint = "   "& earnings[k];
				pad(cell_2 - len(toPrint));

				if(ArrayLen(earnings_amt) >= k){
					toPrint &= "|";
					pad(cell_3 - cell_2 - len(numberFormat(earnings_amt[k],'9.99')) - 7);
					toPrint &= numberFormat(earnings_amt[k],'9.99');
					total_earnings += earnings_amt[k];
				}

			}else{
				pad(cell_2 - len(toPrint));
				toPrint &= "|";
			}
			pad(cell_3 - len(toPrint) + 3);

			// PRINTING DEDUCTIONS
			if(ArrayLen(deductions) >= k){
				toPrint &= deductions[k];
			}

			pad(cell_4 - len(toPrint));

			toPrint &= "|";
			pad(leftPad);

			if(k <= ArrayLen(deductions)){
				pad( fileWidth - cell_4 - len(numberFormat(deductions_amt[k],'9.99')) -4);
				toPrint = toPrint & numberFormat(deductions_amt[k],'9.99');

				total_deductions += deductions_amt[k];
			}

			println(toPrint);
		}


		pad( cell_2 - len("TOTAL EARNINGS : |") + 1);

		toPrint &=  "TOTAL EARNINGS : |";

		pad(cell_3 - len(toPrint) - 3 - len(numberFormat(total_earnings,'9.99')));
		toPrint &= numberFormat(total_earnings,'9.99');
		pad(3);

		pad(cell_4 - len(toPrint) - len("TOTAL DEDUCTIONS : |") +1);
		toPrint &= "TOTAL DEDUCTIONS : |   " & numberFormat(total_deductions,'9.99');
		println(toPrint);

	</cfscript>
	<!--- PRINT FOOTER --->
	<cfscript>
		colsize = Int(fileWidth /3) ;

	for(i = 0; i < fileWidth; i++){
		toPrint = toPrint&"-";
	}
	println(toPrint);

		pad( cell_2 - len("Nett Wage :     |") + 1);
		toPrint &=  "Nett Wage :     |";

		pad(3);
		toPrint = toPrint &  numberFormat(nettPay,'9.99');
		pad(cell_4 - len(toPrint) - 3);
		toPrint = toPrint & "Y-T-D";
		println(toPrint);

		leftFields = ["E'R EPF'","E'R Socso", "BANK"];
		leftVal = [ numberformat(epfcc,'9.99'),numberformat(socsocc,'9.99'),bank];
		rightFields = ["GROSS PAY","NETT PAY","E'E/E'R EPF","E'E/E'R Socso","E'E I/Tax"];
		//-----FOR JANUARy TEST
		rightVal = [total_earnings,nettPay,epfcc,socsocc,tax];

		//==============
		//rightVal = [
		//numberformat(total_earnings + tgrossPay,'9.99'),
		//numberformat(nettPay + tnettPay,'9.99'),y_epf,y_socso,tax];
		leftLabelStart = 10;
		leftComma = 24;
		leftEarningsStart = 28;

		rightLabelStart = 56;
		rightComma = 70;
		rightEarningStart = 76;


		for(pointer = 1; pointer <= ArrayLen(rightFields); pointer = pointer + 1){
			pad(leftLabelStart);
			if(pointer <= ArrayLen(leftFields)){
				toPrint = toPrint & leftFields[pointer];
				padding = leftComma - len(toPrint);
				pad(padding);
				toPrint = toPrint & ":";
				pad(leftEarningsStart - len(toPrint));
				toPrint &= leftVal[pointer];
			}
			pad(rightLabelStart - len(toPrint));
			toPrint &= rightFields[pointer];
			pad(rightComma - len(toPrint));
			toPrint&=":";
			pad(rightEarningStart - len(toPrint));
			toPrint &= rightVal[pointer];

			println(toPrint);
		}

		for(i = 0; i < footerMargin ; i++){
			println("");
		}



		ArrayAppend(testTable,{
			"empno" : getAssignment.empno,
			"EPFCC" : getPayYTD.EPFCC,
			"EPFWW" : getPayYTD.EPFWW,
			"SOCSOCC" : getPayYTD.SOCSOCC,
			"SOCSOWW" : getPayYTD.SOCSOWW,
			"name" : getAssignment.empname

		});

		function pad(size){
			for(i = 0; i < size; i++){
				toPrint = toPrint & " ";
			}
		}

	</cfscript>
</cfloop>
<!---
	<cfloop array="#testTable#" index="i">
	<cfquery datasource="manpower_p">
	INSERT INTO testpay (empno,empname,EPFCC,EPFWW,SOCSOCC,SOCSOWW) values
	(
	"#i.empno#","#i.name#","#i.EPFCC#","#i.EPFWW#","#i.SOCSOCC#","#i.SOCSOWW#"
	);
	</cfquery>
	</cfloop>
	--->
<!--- output header and file names --->
<cfset filename="payslip">
<cfset yourFileName="#filedir#">
<cfset yourFileName2="#filename#.txt">
<cfcontent type="application/x-unknown">
<cfset thisPath = ExpandPath("#yourFileName#")>
<cfheader name="Content-Disposition" value="attachment; filename=#yourFileName2#">
<cfheader name="Content-Description" value="This is a tab-delimited file.">
<cfcontent type="Multipart/Report" file="#yourFileName#">
<cflocation url="#yourFileName#">

<cffunction name="println">
	<cfargument name="dataToPrint" required="true">
	<cfset toPrint = "">
	<cffile action="append" addnewline="yes" charset="utf-8"
		file = "#filedir#"
		output = "#dataToPrint#">
</cffunction>


<cffunction name="getAllowance" access="public">
	<cfargument name="code">
	<cfquery name="shelf" datasource="manpower_i">
		SELECT*  FROM icshelf where shelf = '#code#';
	</cfquery>
	<cfreturn shelf.DESP>
</cffunction>
