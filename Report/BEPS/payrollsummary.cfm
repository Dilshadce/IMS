<!---Added ee and er epf socso from pay_12m, [20170919, Alvin]--->
<cfsetting requesttimeout="0" >

<cfif isdefined('form.batches') eq false and form.getcust eq ''>
    <script>
    alert('No Batches is selected or Customer Name is empty');
    window.close();
    </script>
    <cfabort>
</cfif>

<cfset dtsp = replace(dts,'_i','_p')>
<cfquery datasource="#dtsp#">
	SET SESSION binlog_format = 'MIXED';
</cfquery>
    
<cfquery name="getgsetup2" datasource='#dts#'>
	select * from gsetup2
</cfquery>

<cfquery name="getpayroll" datasource="payroll_main">
	SELECT * FROM gsetup 
    WHERE comp_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#replace(dts,'_i','')#">
</cfquery>
    
<cfquery datasource="#dts#">
    DROP TABLE IF EXISTS assignmentslip_paysummary 
</cfquery>

<cfquery datasource="#dts#">
    CREATE TABLE assignmentslip_paysummary LIKE assignmentslip
</cfquery>

<cfquery datasource="#dts#">
insert into assignmentslip_paysummary select * from assignmentslip where 1=1
<cfif form.month neq ''>
	AND payrollperiod >= "#form.month#"
    <cfif form.monthto neq ''>
        AND payrollperiod <= "#form.monthto#"
    </cfif>
</cfif>
<cfif form.getcust neq ''>
    AND custname like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.getcust#%">
</cfif>
    AND created_on > #createdate(getpayroll.myear,1,7)#
</cfquery>

<cfquery name="getPayroll" datasource="#dts#">

	select custno,custname as custname,empno,empname,selftotal + selfsdf + selfcpf + selfeis as gross, selfsdf,selfcpf , custsdf, custcpf,
    selfeis,custeis,selftotal as net,
	ifnull(ded115,0.00) as ded115, selftotal - ifnull(ded115,0.00) as payout
	FROM (
            select custno,custname,a.empno,a.empname,
            sum(ifnull(b.epfww,0)) AS selfcpf,sum(ifnull(b.epfcc,0)) AS custcpf,
            sum(ifnull(b.socsoww,0)) AS selfsdf,sum(ifnull(b.socsocc,0)) AS custsdf, 
            sum(ifnull(b.eisww,0)) AS selfeis,sum(ifnull(b.eiscc,0)) AS custeis,
            sum(ifnull(b.ded115,0)) as ded115,
            sum(ifnull(selftotal,0)) as selftotal
            from assignmentslip_paysummary a 
            left join #dtsp#.<cfif form.month eq getpayroll.mmonth>payout_tm<cfelse>pay_12m</cfif> b
            on b.empno = a.empno <cfif form.month eq getpayroll.mmonth><cfelse>AND tmonth = a.payrollperiod</cfif>
            where 1=1
            <cfif form.month neq ''>
                AND payrollperiod >= "#form.month#"
                <cfif form.monthto neq ''>
                    AND payrollperiod <= "#form.monthto#"
                </cfif>
            </cfif>
            <cfif form.getcust neq ''>
                AND custname like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.getcust#%">
            </cfif>
            <cfif isdefined('batches')>
            and batches IN
            (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batches#" separator="," list="yes">)
            </cfif>
             group by empno 
        ) t1
    order by custname
</cfquery>
<!-- ============ SETTING table headers for excel file ==================== --->
<cfset headerFields = [
	"Customer Name",
	"Customer Number",
	"Employee Name",
	"Employee Number",
	"Gross Pay",
    "EE EIS",
	"ER EIS",
	"EE SOCSO",
	"ER SOCSO",
	"EE EPF",
	"ER EPF",
	"Nett before tax",
	"Tax",
	"Nett payout"
	] />
<!-- ============CREATING THE TABLE FOR THE EXCEL FILE==================== --->
<cfset iDecl_UPrice=getgsetup2.Decl_UPrice>
<cfset stDecl_UPrice="">
<cfset stDecl_UPrice2 = ",.">
<cfloop index="LoopCount" from="1" to="#iDecl_UPrice#">
    <cfset stDecl_UPrice=stDecl_UPrice&"0">
    <cfset stDecl_UPrice2 = stDecl_UPrice2 & "_">
</cfloop>
<cfxml variable="data">
	<cfinclude template="/excel_template/excel_header.cfm">
	<Worksheet ss:Name="payroll summary">
	<Table x:FullColumns="1" x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="11.25">
		<Column ss:Width="64.5"/>
		<Column ss:Width="60.25"/>
		<Column ss:Width="183.75"/>
		<Column ss:AutoFitWidth="0" ss:Width="60"/>
		<Column ss:Width="47.25"/>
		<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
		<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
		<Column ss:AutoFitWidth="0" ss:Width="75.75"/>
		<Column ss:AutoFitWidth="0" ss:Width="63.75"/>
		<Row ss:AutoFitHeight="0" ss:Height="23.0625">
			<cfloop array="#headerFields#" index="field" >
				<Cell ss:StyleID="s27">
					<Data ss:Type="String">
						<cfoutput>
							#field#
						</cfoutput>
					</Data>
				</Cell>
			</cfloop>
		</Row>
		<cfloop query="#getPayroll#">
			<cfoutput>
				<Row>
                    <cfwddx action = "cfml2wddx" input = "#getPayroll.custname#" output = "wddxText1">
					<Cell>
						<Data ss:Type="String">#wddxText1#</Data>
					</Cell>
					<Cell>
						<Data ss:Type="String">#getPayroll.custno#</Data>
					</Cell>
                    <cfwddx action = "cfml2wddx" input = "#getPayroll.empname#" output = "wddxText2">
					<Cell>
						<Data ss:Type="String">#wddxText2#</Data>
					</Cell>
					<Cell>
						<Data ss:Type="String">#getPayroll.empno#</Data>
					</Cell>
					<Cell ss:StyleID="s33">
						<Data ss:Type="Number">#val(getPayroll.gross)#</Data>
					</Cell>
                    <Cell ss:StyleID="s33">  <!---EE EIS--->
						<Data ss:Type="Number">#val(getPayroll.selfeis)#</Data>
					</Cell>
					<Cell ss:StyleID="s33">  <!---ER EIS--->
						<Data ss:Type="Number">#val(getPayroll.custeis)#</Data>
					</Cell>
					<Cell ss:StyleID="s33">  <!---EE SOCSO--->
						<Data ss:Type="Number">#val(getPayroll.selfsdf)#</Data>
					</Cell>
					<Cell ss:StyleID="s33">  <!---ER SOCSO--->
						<Data ss:Type="Number">#val(getPayroll.custsdf)#</Data>
					</Cell>
					<Cell ss:StyleID="s33"> <!---EE EPF--->
						<Data ss:Type="Number">#val(getPayroll.selfcpf)#</Data>
					</Cell>
					<Cell ss:StyleID="s33">  <!---ER EPF--->
						<Data ss:Type="Number">#val(getPayroll.custcpf)#</Data>
					</Cell>
					<Cell ss:StyleID="s33">
						<Data ss:Type="Number">#val(getPayroll.net)#</Data>
					</Cell>
					<Cell ss:StyleID="s33">
						<Data ss:Type="Number">#val(getPayroll.ded115)#</Data>
					</Cell>
					<Cell ss:StyleID="s33">
						<Data ss:Type="Number">#val(getPayroll.payout)#</Data>
					</Cell>
				</Row>
			</cfoutput>
		</cfloop>
		<Row ss:AutoFitHeight="0" ss:Height="12"/>
	</Table>
	<cfinclude template="/excel_template/excel_footer.cfm">
</cfxml>
<cffile action="write" nameconflict="overwrite" file="#HRootPath#\Excel_Report\payrollsummaryreport.xls" output="#tostring(data)#" charset="utf-8">
<cfheader name="Content-Disposition" value="inline; filename=Payroll_Summary_Report_#form.month#_#huserid#.xls">
<cfcontent type="application/vnd.ms-excel" deletefile="yes" file="#HRootPath#\Excel_Report\payrollsummaryreport.xls">
