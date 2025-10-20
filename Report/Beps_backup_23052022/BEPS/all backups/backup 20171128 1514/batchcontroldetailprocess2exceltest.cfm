<cfoutput>
<cfset uuid = createuuid()>
<style type="text/css">
    @media print
    {
    	##non-printable { display: none; }

    }
    </style>

<cfsetting showdebugoutput="yes" requesttimeout="0">
<cfinclude template="/object/dateobject.cfm">
<cfinclude template="/object/stringobject.cfm">
<cfquery name="getpayroll" datasource="#dts#">
SELECT mmonth,myear FROM payroll_main.gsetup WHERE comp_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
<cfset payrollmonth = getpayroll.mmonth>
<cfset payrollyear = getpayroll.myear>

<!---<cfif payrollmonth eq form.month >
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

-<cfelseif payrollyear lt form.year>



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
<cfset paytrantbl = "pay2_12m_fig">-
<cfelse>

<cfquery name="paytra1" datasource="#replace(dts,'_i','_p')#" >
SELECT * FROM pay1_12m_fig WHERE tmonth = "#form.month#"
</cfquery>
<cfquery name="paytran" datasource="#replace(dts,'_i','_p')#" >
SELECT * FROM pay2_12m_fig WHERE tmonth = "#form.month#"
</cfquery>
<cfquery name="getlevy" datasource="#replace(dts,'_i','_p')#">
SELECT LEVY_SD,EMPNO,LEVY_FW_W FROM COMM_12m WHERE tmonth = "#form.month#"
</cfquery>
<cfset paytra1tbl = "pay1_12m_fig">
<cfset paytrantbl = "pay2_12m_fig">

</cfif>--->


<cfif (form.getfrom neq "" and form.getto neq "") or  (form.agentfrom neq "" and form.agentto neq "") or (form.getempfrom neq "" and form.getempto neq "")>
<cfquery name="getplacement" datasource="#dts#">
SELECT * FROM placement
WHERE 1 = 1
and year(completedate) >= #getpayroll.myear#-1
<cfif form.getfrom neq "" and form.getto neq "">
and custno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getto#">
</cfif> 
<cfif form.agentfrom neq "" and form.agentto neq "">
and consultant between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agentfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.agentto#">
</cfif> 
<!---Added by Nieo 20171117 1038 for new filter requirement--->
<cfif form.getempfrom neq "" and form.getempto neq "">
and empno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getempfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.getempto#">
</cfif> 
<!---Added by Nieo 20171117 1038 for new filter requirement--->
<!--- <cfif form.areafrom neq "" and form.areato neq "">
and location between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areafrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areato#">
</cfif>  --->
</cfquery>
</cfif>

<cfquery name="getgeneral" datasource="#dts#">
	select lastaccyear,filterall,lCATEGORY,lGROUP,lSIZE,lMATERIAL,lMODEL,lRATING,lAGENT,lDRIVER,lLOCATION,agentlistuserid,compro from gsetup
</cfquery>

<cfif isdefined('form.cndnonly') neq true and isdefined('form.permonly')  neq true>
<cfquery name="getassignment" datasource="#dts#">
SELECT * FROM (
SELECT aa.*,if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0) as totalamt FROM assignmentslip aa
WHERE 
    <!---Added by Nieo 20171117 1038 for new filter requirement--->
    payrollperiod between #form.month# and #form.monthto#
    <!---Added by Nieo 20171117 1038 for new filter requirement--->
and year(assignmentslipdate) = "#payrollyear#"
<!---Added by Nieo 20171114 1400 where assignmentslip created in previous month showing--->
<cfif form.month eq form.monthto>
and (month(created_on) = #form.month# or month(created_on) = #form.month#+1)        
</cfif>
and year(created_on) = #payrollyear#
<!---Added by Nieo 20171114 1400 where assignmentslip created in previous month showing--->
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
<cfif isdefined('getplacement')>
<cfif getplacement.recordcount neq 0>
and placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#VALUELIST(getplacement.placementno)#" list="yes" separator=",">)
</cfif></cfif>) as a
LEFT JOIN
(SELECT placementno as pno, location,consultant,custno as cno,custname,empname,pm FROM placement) as b on a.placementno = b.pno
LEFT JOIN
(
SELECT priceid,pricename FROM manpowerpricematrix
) as c
on b.pm = c.priceid
LEFT JOIN
(
SELECT custno as xcustno,arrem5 FROM #target_arcust#
) as d
on a.custno = d.xcustno
order by <cfif form.orderby eq 'custname'>b.</cfif>#form.orderby#,refno
</cfquery>
</cfif>
    
<cfquery name="getictran" datasource="#dts#">
select *,e.arrem1 dlocation,a.refno icrefno from ictran a
left join artran b
on a.refno=b.refno and a.type=b.type
left join assignmentslip c
on a.brem6=c.refno
left join placement d
on c.placementno=d.placementno
left join arcust e
on a.custno=e.custno
left join manpowerpricematrix f
on d.pm=f.priceid
where 
    <!---Added by Nieo 20171117 1038 for new filter requirement--->
    a.fperiod between #form.month# and #form.monthto#
    <!---Added by Nieo 20171117 1038 for new filter requirement--->
and year(a.wos_date) = "#payrollyear#"
and a.fperiod <>99
    <cfif isdefined('form.cndnonly')>
    and a.type in ('CN','DN')   
    <cfelseif isdefined('form.permonly')>
    and b.rem40 is null and a.type='INV'
    <cfelse>
    and (a.type in ('CN','DN') or (b.rem40 is null and a.type='INV'))
    </cfif>
and (a.void is null or a.void='')
<cfif form.createdfrm neq "" and form.createdto neq "">
and (b.created_by BETWEEN <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdfrm#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.createdto#">)
</cfif>
<cfif form.areafrom neq "" and form.areato neq "">
and rem30 between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areafrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.areato#">
</cfif>
<cfif isdefined('getplacement')>
<cfif getplacement.recordcount neq 0>
and (c.placementno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#VALUELIST(getplacement.placementno)#" list="yes" separator=",">)
    or a.brem1 in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#VALUELIST(getplacement.placementno)#" list="yes" separator=",">))
</cfif>
    </cfif>
order by a.refno,brem6,a.trancode
</cfquery>

<cfheader name="Content-Type" value="xls">
<cfset filename = hcomid&"_"&payrollmonth&"Pay_Bill_Audit_"&getauthuser()&"_new.xls">
<cfheader name="Content-Disposition" value="attachment; filename=#filename#">
<cfset totalpay=0.00>
<cfset totalbill=0.00>

		<cfxml variable="data">
			<?xml version="1.0"?>
			<?mso-application progid="Excel.Sheet"?>
			<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:html="http://www.w3.org/TR/REC-html40">
			<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
				<Author>Netiquette Technology</Author>
				<LastAuthor>Netiquette Technology</LastAuthor>
				<Company>Netiquette Technology</Company>
			</DocumentProperties>
			<Styles>
		  		<Style ss:ID="Default" ss:Name="Normal">
					<Alignment ss:Vertical="Bottom"/>
					<Borders/>
					<Font/>
					<Interior/>
					<NumberFormat/>
					<Protection/>
				</Style>
				<Style ss:ID="s21">
					<Borders/>
				</Style>
				<Style ss:ID="s23">
					<Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
					<Font x:Family="Swiss" ss:Size="11" ss:Bold="1"/>
				</Style>
				<Style ss:ID="s24">
					<Font x:Family="Swiss" ss:Bold="1"/>
				</Style>
				<Style ss:ID="s25">
					<Alignment ss:Vertical="Bottom"/>
				</Style>
				<Style ss:ID="s26">
					<Alignment ss:Vertical="Bottom"/>
					<Font ss:Underline="Single"/>
				</Style>
				<Style ss:ID="s27">
					<Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
					<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
					</Borders>
					<Font x:Family="Swiss" ss:Bold="1"/>
				</Style>
                <Style ss:ID="s28">
					<Alignment ss:Horizontal="Left" ss:Vertical="Bottom"/>
					<Font x:Family="Swiss"/>
				</Style>
                <Style ss:ID="s29">
					<Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
					<Font x:Family="Swiss"/>
				</Style>
				<Style ss:ID="s30">
					<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
					</Borders>
				</Style>
				<Style ss:ID="s31">
					<Borders>
						<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
						<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
						</Borders>
					<Font x:Family="Swiss" ss:Bold="1"/>
				</Style>
                 <Style ss:ID="s65">
   <Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
   <Font ss:FontName="Arial" x:Family="Swiss"/>
   <NumberFormat ss:Format="Fixed"/>
  </Style>
  <Style ss:ID="s66">
   <Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Bold="1"/>
   <NumberFormat ss:Format="Fixed"/>
  </Style>
		 	</Styles>
			
			<Worksheet ss:Name="Report">
			<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
                <Column ss:AutoFitWidth="0" ss:Width="100"/>
                <Column ss:AutoFitWidth="0" ss:Width="100"/>
                <Column ss:AutoFitWidth="0" ss:Width="100"/>
                <Column ss:AutoFitWidth="0" ss:Width="100"/>
                <Column ss:AutoFitWidth="0" ss:Width="100"/>
                <Column ss:AutoFitWidth="0" ss:Width="100"/>
                <Column ss:AutoFitWidth="0" ss:Width="100"/>
                <Column ss:AutoFitWidth="0" ss:Width="100"/>
                <Column ss:AutoFitWidth="0" ss:Width="100"/>
                <Column ss:AutoFitWidth="0" ss:Width="100"/>
                <Column ss:AutoFitWidth="0" ss:Width="100"/>
                <Column ss:AutoFitWidth="0" ss:Width="100"/>

                <Column ss:AutoFitWidth="0" ss:Width="100"/>
                <Column ss:AutoFitWidth="0" ss:Width="100"/>
                <Column ss:AutoFitWidth="0" ss:Width="100"/>
                <Column ss:AutoFitWidth="0" ss:Width="100"/>
                <Column ss:AutoFitWidth="0" ss:Width="100"/>
                <Column ss:AutoFitWidth="0" ss:Width="100"/>
                <Column ss:AutoFitWidth="0" ss:Width="100"/>  
                <Column ss:AutoFitWidth="0" ss:Width="100"/>   
				<Row ss:AutoFitHeight="0" ss:Height="13">
                	<Cell ss:StyleID="s23"><Data ss:Type="String">Entity</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">Office Code</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">Batch</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">Invoice</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">Company</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">Cust No</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">VAT</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">Placement No</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">Price Structures</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">Employee Name</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">Employee No</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">Refno</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">Payroll Period</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">Period</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">Item Name</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">Pay Qty</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">Pay Rate</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">Pay Amt</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">Bill Qty</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">Bill Rate</Data></Cell>
                    <Cell ss:StyleID="s23"><Data ss:Type="String">Bill Amt</Data></Cell> 
                    <Cell ss:StyleID="s23"><Data ss:Type="String"></Data></Cell> 
				</Row>
                <cfif isdefined('form.cndnonly') neq true and isdefined('form.permonly')  neq true>
                <cfloop query="getassignment">
                <cfif val(getassignment.selfsalary) neq 0 or val(getassignment.custsalary) neq 0>
                <Row ss:AutoFitHeight="0">
                <cfinclude template="startrowexcel.cfm">
                 <Cell ss:StyleID="s28"><Data ss:Type="String">Normal</Data></Cell>
                  <Cell ss:StyleID="s65"><Data ss:Type="Number"><cfif getassignment.paymenttype eq "hr">#numberformat(getassignment.selfsalaryhrs,'.____')#<cfelseif getassignment.paymenttype eq "day">#numberformat(getassignment.selfsalaryday,'.____')#<cfelse><cfif val(getassignment.workd) neq 0><cfset monthprorate = ROUND((val(DateDiff("d", getassignment.startdate, getassignment.completedate) + 1)/val(getassignment.workd))*100000)/100000><!---<cfset monthprorate = ROUND((val(getassignment.selfsalaryday)/val(getassignment.workd))*100000)/100000>---><cfelse><cfset monthprorate = 1></cfif>#numberformat(monthprorate,'.____')#</cfif></Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(getassignment.selfusualpay,',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(getassignment.selfsalary,',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number"><cfif getassignment.paymenttype eq "hr">#numberformat(getassignment.custsalaryhrs,'.____')#<cfelseif getassignment.paymenttype eq "day">#numberformat(getassignment.custsalaryday,'.____')#<cfelse><cfif val(getassignment.workd) neq 0><cfset monthprorate = ROUND((val(DateDiff("d", getassignment.startdate, getassignment.completedate) + 1)/val(getassignment.workd))*100000)/100000><!---<cfset monthprorate = ROUND((val(getassignment.custsalaryday)/val(getassignment.workd))*100000)/100000>---><cfelse><cfset monthprorate = 1></cfif>#numberformat(monthprorate,'.____')#</cfif></Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(getassignment.custusualpay,',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(getassignment.custsalary,',.__')#</Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String"><cfif numberformat(getassignment.selfsalary,'.__') gt numberformat(getassignment.custsalary,'.__')>**<cfelse>.</cfif></Data></Cell>
</Row>
</cfif>

<cfloop from="1" to="10" index="a">
<cfif val(evaluate('getassignment.lvltotalee#a#')) neq 0 or val(evaluate('getassignment.lvltotaler#a#')) neq 0>
<Row ss:AutoFitHeight="0">
<cfinclude template="startrowexcel.cfm">
                 <Cell ss:StyleID="s28"><Data ss:Type="String">NPL</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number"><cfif val(evaluate('getassignment.lvleedayhr#a#')) neq 0>#val(evaluate('getassignment.lvleedayhr#a#'))#<cfelse>0.00</cfif></Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(evaluate('getassignment.lvleerate#a#')),',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(evaluate('getassignment.lvltotalee#a#')),',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number"><cfif val(evaluate('getassignment.lvlerdayhr#a#')) neq 0>#val(evaluate('getassignment.lvlerdayhr#a#'))#<cfelse>0.00</cfif></Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(evaluate('getassignment.lvlerrate#a#')),',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(evaluate('getassignment.lvltotaler#a#')),',.__')#</Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String"><cfif numberformat(val(evaluate('getassignment.lvltotalee#a#')),'.__') gt numberformat(val(evaluate('getassignment.lvltotaler#a#')),'.__')>**<cfelse>.</cfif></Data></Cell>
</Row>
</cfif>
</cfloop>
    
<cfif val(getassignment.selfottotal) neq 0 or val(getassignment.custottotal) neq 0>
<cfloop from="1" to="8" index="a">
<cfif val(evaluate('getassignment.selfot#a#')) neq 0 or val(evaluate('getassignment.custot#a#')) neq 0>
 <Row ss:AutoFitHeight="0">
                <cfinclude template="startrowexcel.cfm">
                 <Cell ss:StyleID="s28"><Data ss:Type="String"><cfif a eq 1>OT 1.0<cfelseif a eq 2>OT 1.5<cfelseif a eq 3>OT 2.0<cfelseif a eq 4>OT 3.0<cfelseif a eq 5>RD 1.0<cfelseif a eq 6>RD 2.0<cfelseif a eq 7>PH 1.0<cfelseif a eq 8>PH 2.0</cfif></Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(evaluate('selfothour#a#'),'.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(evaluate('selfotrate#a#'),',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(evaluate('selfot#a#'),',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(evaluate('custothour#a#'),'.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(evaluate('custotrate#a#'),',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(evaluate('custot#a#'),',.__')#</Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String"><cfif numberformat(evaluate('selfot#a#'),'.__') gt numberformat(evaluate('custot#a#'),'.__')>**<cfelse>.</cfif></Data></Cell>
</Row>
</cfif> 
</cfloop>
</cfif>
<!---<cfif val(getassignment.selfallowance) neq 0 or val(getassignment.custallowance) neq 0>--->
<cfloop from="1" to="6" index="a">
<cfif val(evaluate('getassignment.fixawee#a#')) neq 0 or val(evaluate('getassignment.fixawer#a#'))>
 <Row ss:AutoFitHeight="0">
<cfinclude template="startrowexcel.cfm">
    <cfwddx action = "cfml2wddx" input = "#evaluate('fixawdesp#a#')#" output = "wddxText1000">
                 <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText1000#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number"><cfif val(evaluate('getassignment.fixawee#a#')) neq 0>1.00<cfelse>0.00</cfif></Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(evaluate('getassignment.fixawee#a#')),',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(evaluate('getassignment.fixawee#a#')),',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number"><cfif val(evaluate('getassignment.fixawer#a#')) neq 0>1.00<cfelse>0.00</cfif></Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(evaluate('getassignment.fixawer#a#')),',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(evaluate('getassignment.fixawer#a#')),',.__')#</Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String"><cfif numberformat(val(evaluate('getassignment.fixawee#a#')),'.__') gt numberformat(val(evaluate('getassignment.fixawer#a#')),'.__')>**<cfelse>.</cfif></Data></Cell>
</Row>
</cfif>
</cfloop>
<cfloop from="1" to="18" index="a">
<cfif val(evaluate('getassignment.awee#a#')) neq 0 or val(evaluate('getassignment.awer#a#'))>
<Row ss:AutoFitHeight="0">
<cfinclude template="startrowexcel.cfm">
    <cfwddx action = "cfml2wddx" input = "#evaluate('allowancedesp#a#')#" output = "wddxText2000">
                 <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText2000#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number"><cfif val(evaluate('getassignment.awee#a#')) neq 0>1.00<cfelse>0.00</cfif></Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(evaluate('getassignment.awee#a#')),',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(evaluate('getassignment.awee#a#')),',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number"><cfif val(evaluate('getassignment.awer#a#')) neq 0>1.00<cfelse>0.00</cfif></Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(evaluate('getassignment.awer#a#')),',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(evaluate('getassignment.awer#a#')),',.__')#</Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String"><cfif numberformat(val(evaluate('getassignment.awee#a#')),'.__') gt numberformat(val(evaluate('getassignment.awer#a#')),'.__')>**<cfelse>.</cfif></Data></Cell>
</Row>
</cfif>
</cfloop>
<!---</cfif>--->
<cfif val(getassignment.selfcpf) neq 0 or val(getassignment.custcpf) neq 0>
<Row ss:AutoFitHeight="0">
<cfinclude template="startrowexcel.cfm">
                 <Cell ss:StyleID="s28"><Data ss:Type="String">EPF</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number"><cfif val(getassignment.selfcpf) neq 0>1.00<cfelse>0.00</cfif></Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number"><cfif findnocase('-',getassignment.selfcpf)>#numberformat(val(replace(getassignment.selfcpf,'-','')),',.__')#<cfelse>-#numberformat(val(getassignment.selfcpf),',.__')#</cfif></Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number"><cfif findnocase('-',getassignment.selfcpf)>#numberformat(val(replace(getassignment.selfcpf,'-','')),',.__')#<cfelse>-#numberformat(val(getassignment.selfcpf),',.__')#</cfif></Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number"><cfif val(getassignment.custcpf) neq 0>1.00<cfelse>0.00</cfif></Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(getassignment.custcpf),',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(getassignment.custcpf),',.__')#</Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String"><cfif numberformat(val(selfcpf),'.__') gt numberformat(val(custcpf),'.__')>**<cfelse>.</cfif></Data></Cell>
</Row>
</cfif>
<cfif val(getassignment.selfsdf) neq 0 or val(getassignment.custsdf) neq 0>
<Row ss:AutoFitHeight="0">
<cfinclude template="startrowexcel.cfm">
                 <Cell ss:StyleID="s28"><Data ss:Type="String">SOCSO</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number"><cfif val(getassignment.selfsdf) neq 0>1.00<cfelse>0.00</cfif></Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number"><cfif findnocase('-',getassignment.selfsdf)>#numberformat(val(replace(getassignment.selfsdf,'-','')),',.__')#<cfelse>-#numberformat(val(getassignment.selfsdf),',.__')#</cfif></Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number"><cfif findnocase('-',getassignment.selfsdf)>#numberformat(val(replace(getassignment.selfsdf,'-','')),',.__')#<cfelse>-#numberformat(val(getassignment.selfsdf),',.__')#</cfif></Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number"><cfif val(getassignment.custsdf) neq 0>1.00<cfelse>0.00</cfif></Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(getassignment.custsdf),',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(getassignment.custsdf),',.__')#</Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String"><cfif numberformat(val(selfsdf),'.__') gt numberformat(val(custsdf),'.__')>**<cfelse>.</cfif></Data></Cell>
</Row>
</cfif>

<cfif val(getassignment.adminfee) neq 0 >
<Row ss:AutoFitHeight="0">
<cfinclude template="startrowexcel.cfm">
                 <Cell ss:StyleID="s28"><Data ss:Type="String">Admin Fee</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">0.00</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">0.00</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">0.00</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">1</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(getassignment.adminfee),',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(getassignment.adminfee),',.__')#</Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String">.</Data></Cell>
</Row>
</cfif>

<cfif val(getassignment.custdeduction) neq 0 or val(getassignment.selfdeduction)>
<cfloop from="1" to="6" index="a">
<cfif val(evaluate('getassignment.billitemamt#a#')) neq 0>
<Row ss:AutoFitHeight="0">
<cfinclude template="startrowexcel.cfm">
    <cfwddx action = "cfml2wddx" input = "#evaluate('getassignment.billitemdesp#a#')#" output = "wddxText3000">
                 <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText3000# Fee</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">0.00</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">0.00</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">0.00</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">1.00</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(evaluate('getassignment.billitemamt#a#')),',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(evaluate('getassignment.billitemamt#a#')),',.__')#</Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String">.</Data></Cell>
</Row>
</cfif>
</cfloop>
<cfloop from="1" to="3" index="a">
<cfif a eq 1>
<cfset a = "">
</cfif>
<cfif val(evaluate('getassignment.addchargeself#a#')) neq 0 or val(evaluate('getassignment.addchargecust#a#')) neq 0>
<Row ss:AutoFitHeight="0">
<cfinclude template="startrowexcel.cfm">
    <cfwddx action = "cfml2wddx" input = "#evaluate('getassignment.addchargedesp#a#')#" output = "wddxText4000">
                 <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText4000#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">1.00</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(evaluate('getassignment.addchargeself#a#')),',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(evaluate('getassignment.addchargeself#a#')),',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">1.00</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(evaluate('getassignment.addchargecust#a#')),',.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(val(evaluate('getassignment.addchargecust#a#')),',.__')#</Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String"><cfif numberformat(val(evaluate('getassignment.addchargeself#a#')),'.__') gt numberformat(val(evaluate('getassignment.addchargecust#a#')),'.__')>**<cfelse>.</cfif></Data></Cell>
</Row>
</cfif>
</cfloop>
</cfif>
<Row ss:AutoFitHeight="0">
<cfwddx action = "cfml2wddx" input = "#getassignment.branch#" output = "wddxText1">
<cfwddx action = "cfml2wddx" input = "#getassignment.batches#" output = "wddxText2">
<cfwddx action = "cfml2wddx" input = "#getassignment.custname#" output = "wddxText3">
<cfwddx action = "cfml2wddx" input = "#getassignment.custno#" output = "wddxText4">
<cfwddx action = "cfml2wddx" input = "#getassignment.placementno#" output = "wddxText5">
<cfwddx action = "cfml2wddx" input = "#getassignment.pricename#" output = "wddxText6">
<cfwddx action = "cfml2wddx" input = "#getassignment.empname#" output = "wddxText7">
<cfwddx action = "cfml2wddx" input = "#getassignment.empno#" output = "wddxText8">
<cfwddx action = "cfml2wddx" input = "#getassignment.refno#" output = "wddxText9">
<cfwddx action = "cfml2wddx" input = "#dateformat(getassignment.startdate,'dd/mm/yyyy')# - #dateformat(getassignment.completedate,'dd/mm/yyyy')#" output = "wddxText10">
<cfwddx action = "cfml2wddx" input = "#getassignment.location#" output = "wddxText11">
<cfwddx action = "cfml2wddx" input = "#getassignment.arrem5#" output = "wddxText12">
<cfwddx action = "cfml2wddx" input = "#getassignment.invoiceno#" output = "wddxText13">
<cfwddx action = "cfml2wddx" input = "#getassignment.payrollperiod#" output = "wddxText14">
<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText1#</Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText11#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText2#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText13#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText3#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText4#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText12#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText5#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText6#</Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String">#wddxText7#</Data></Cell>   
                    <Cell ss:StyleID="s29"><Data ss:Type="String">#wddxText8#</Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String">#wddxText9#</Data></Cell>
<Cell ss:StyleID="s29"><Data ss:Type="String">#wddxText10#</Data></Cell>
<Cell ss:StyleID="s29"><Data ss:Type="String">#wddxText14#</Data></Cell>
<Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
<Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
<Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                   <Cell ss:StyleID="s66"><Data ss:Type="Number">#numberformat(getassignment.selftotal,',.__')#</Data></Cell> 
                   <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                   <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                   <Cell ss:StyleID="s66"><Data ss:Type="Number">#numberformat(getassignment.custtotalgross,',.__')#</Data></Cell> 
                   <Cell ss:StyleID="s28"><Data ss:Type="String"><cfif numberformat(getassignment.selftotal,'.__') gt numberformat(getassignment.custtotalgross,'.__')>Err<cfelse>.</cfif></Data></Cell>
</Row>
<Row ss:AutoFitHeight="0">
<Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
    <Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>   
                    <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                   <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell> 
                   <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                   <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                   <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell> 
</Row>          
<cfset totalpay += val(getassignment.selftotal)>
<cfset totalbill += val(getassignment.custtotalgross)>
                </cfloop>
                </cfif>
                
                <cfif getictran.recordcount neq 0 and isdefined('form.assignonly') neq true>
                <cfset subtotal=0.00>
                <cfloop query="getictran">
                	<Row ss:AutoFitHeight="0">
                    <cfinclude template="startrowexcelictran.cfm">
                    <cfwddx action = "cfml2wddx" input = "#getictran.desp#" output = "wddxText5000">
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText5000#</Data></Cell>
                    <Cell ss:StyleID="s65"><Data ss:Type="Number">0.00</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">0.00</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">0.00</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(getictran.qty,'_.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(getictran.price,'_.__')#</Data></Cell>
<Cell ss:StyleID="s65"><Data ss:Type="Number">#numberformat(getictran.amt_bil,'_.__')#</Data></Cell>
<cfset subtotal += val(getictran.amt_bil)>
                    </Row>
                    <cfif getictran.brem6[getictran.currentrow]  neq getictran.brem6[getictran.currentrow+1] or getictran.refno[getictran.currentrow]  neq getictran.refno[getictran.currentrow+1]> 
                    <Row ss:AutoFitHeight="0">
<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText100#</Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText1100#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText200#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText1300#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText300#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText400#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText1200#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText500#</Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String">#wddxText600#</Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String">#wddxText700#</Data></Cell>   
                    <Cell ss:StyleID="s29"><Data ss:Type="String">#wddxText800#</Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String">#wddxText900#</Data></Cell>
<Cell ss:StyleID="s29"><Data ss:Type="String">#wddxText1000#</Data></Cell>
<Cell ss:StyleID="s29"><Data ss:Type="String">#wddxText1400#</Data></Cell>
<Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
<Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
<Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                   <Cell ss:StyleID="s66"><Data ss:Type="Number">0.00</Data></Cell> 
                   <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                   <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                   <Cell ss:StyleID="s66"><Data ss:Type="Number">#numberformat(subtotal,',.__')#</Data></Cell> 
                   <Cell ss:StyleID="s28"><Data ss:Type="String">.</Data></Cell>
</Row>
                    <Row ss:AutoFitHeight="0">
<Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>   
                    <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                   <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell> 
                   <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                   <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                   <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell> 
</Row>    
<cfset totalbill += val(subtotal)>
<cfset subtotal =0.00>
</cfif>

                </cfloop>
                </cfif>
                <cfif totalpay neq 0.00 or totalbill neq 0.00>
                <Row ss:AutoFitHeight="0">
<Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>   
                    <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                    <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
<Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
<Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
<Cell ss:StyleID="s28"><Data ss:Type="String">Total</Data></Cell>
<Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
<Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                   <Cell ss:StyleID="s66"><Data ss:Type="Number">#numberformat(totalpay,',.__')#</Data></Cell> 
                   <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                   <Cell ss:StyleID="s29"><Data ss:Type="String"></Data></Cell>
                   <Cell ss:StyleID="s66"><Data ss:Type="Number">#numberformat(totalbill,',.__')#</Data></Cell> 
                   <Cell ss:StyleID="s28"><Data ss:Type="String"></Data></Cell>
</Row>
</cfif>
			</Table>
     
			<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
		   	<Unsynced/>
		   	<Print>
				<ValidPrinterInfo/>
				<Scale>60</Scale>
				<HorizontalResolution>600</HorizontalResolution>
				<VerticalResolution>600</VerticalResolution>
		   	</Print>
		   	<Selected/>
		   	<Panes>
				<Pane>
					<Number>3</Number>
			 		<ActiveRow>20</ActiveRow>
			 		<ActiveCol>3</ActiveCol>
				</Pane>
		   	</Panes>
		   	<ProtectObjects>False</ProtectObjects>1 0.
            0
		   	<ProtectScenarios>False</ProtectScenarios>
		  	</WorksheetOptions>
		 	</Worksheet>
			</Workbook>
		</cfxml>
		<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\#dts#_MP_#huserid#.xls" output="#tostring(data)#" charset="utf-8">		
<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\#dts#_MP_#huserid#.xls">
        
</cfoutput>
