<cfoutput>
	<cfif HcomID eq "manpower">
	<cfelse>
		<cfset HcomID = "kwangmingtest">
	</cfif>
	<cfif isdefined('url.type') and isdefined('url.id')>
		<cfif lcase(url.type) eq 'delete'>
			<cfquery name="deletetran" datasource="#dts#">
		        DELETE FROM geninvbankfile
		        WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
	        </cfquery>
			<script type="text/javascript">
			alert('Deleted successfully!');
			window.location="/CFSpaybill/listcfstran.cfm";
			</script>
		</cfif>
	<cfelse>
		<cfquery name="gs_qry" datasource="payroll_main">
		SELECT mmonth, myear FROM gsetup WHERE comp_id = "#HcomID#"
		</cfquery>
		<cfquery name="getprofilelist" datasource="#dts#">
		SELECT * FROM paybillprofile
		WHERE id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.profileid#">
		</cfquery>
		<cfquery name="getCFSEmpProfile" datasource="#dts#">
		SELECT * FROM cfsempinprofile
		WHERE profileid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.profileid#">
		</cfquery>
		<cfquery name="getemplist" datasource="#dts#">
		SELECT * FROM cfsemp
		WHERE icno IN (<cfqueryparam cfsqltype="cf_sql_varchar" list="yes" separator="," value="#valuelist(getCFSEmpProfile.icno)#">)
		</cfquery>
		<cfloop query="getemplist">

			<cfset sumOfTotalPayAmount =  #evaluate('form.totalpayamt#getemplist.id#')# >
			<cfset sumOfTotalBillAmount =  #evaluate('form.totalbillamt#getemplist.id#')# >
			<cfset sumOfTotalAdminFee =  #evaluate('form.adminfeeamt#getemplist.id#')# >

			<cfset workdaystag = #evaluate('form.workdays#getemplist.id#')#>
			<cfset workdays = workdaystag>
			<cfset totalpaytag = #evaluate('form.totalpayamt#getemplist.id#')#>
			<cfset totalpayamt = totalpaytag>
			<cfset totalbilltag = #evaluate('form.totalbillamt#getemplist.id#')#>
			<cfset totalbillamt = totalbilltag>
			<cfset adminfeetag = #evaluate('form.adminfeeamt#getemplist.id#')#>
			<cfset adminfeeamt = adminfeetag>
			<cfset misc1 = #evaluate('form.misc1#getemplist.id#')#>
			<cfset misc11 = misc1>
			<cfset misc2 = #evaluate('form.misc2#getemplist.id#')#>
			<cfset misc22 = misc2>
			<cfset misc3 = #evaluate('form.misc3#getemplist.id#')#>
			<cfset misc33 = misc3>
			<cfset misc4 = #evaluate('form.misc4#getemplist.id#')#>
			<cfset misc44 = misc4>
			<cfset misc5 = #evaluate('form.misc5#getemplist.id#')#>
			<cfset misc55 = misc5>
			<cfset miscrem1 = #evaluate('form.miscrem1#getemplist.id#')#>
			<cfset miscrem11 = miscrem1>
			<cfset miscrem2 = #evaluate('form.miscrem2#getemplist.id#')#>
			<cfset miscrem22 = miscrem2>
			<cfset miscrem3 = #evaluate('form.miscrem3#getemplist.id#')#>
			<cfset miscrem33 = miscrem3>
			<cfset miscrem4 = #evaluate('form.miscrem4#getemplist.id#')#>
			<cfset miscrem44 = miscrem4>
			<cfset miscrem5 = #evaluate('form.miscrem5#getemplist.id#')#>
			<cfset miscrem55 = miscrem5>
			<cfset currentdate = createdate(year(now()),month(now()),day(now()))>
			<cfquery name="insertinfo" datasource="#dts#">
				INSERT INTO geninvbankfile
				(
				workdays,
				payamt,
				billamt,
				adminfeeamt,
				paybillprofileid,
				icno,
				wos_date,
				rem1,
				rem2,
				rem3,
				rem4,
				rem5,
				misc1,
				misc2,
				misc3,
				misc4,
				misc5,
				created_by,
				created_on
				)
				VALUES
				(
				<cfqueryparam cfsqltype="cf_sql_integer" value="#workdays#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#totalpayamt#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#totalbillamt#">,
				<cfqueryparam cfsqltype="cf_sql_double" value="#adminfeeamt#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#url.profileid#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#getemplist.icno#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(currentdate,'yyyy-mm-dd')#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#miscrem11#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#miscrem22#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#miscrem33#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#miscrem44#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#miscrem55#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#misc11#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#misc22#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#misc33#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#misc44#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#misc55#">,
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
				now()
				)


			</cfquery>
			<cfif trim(form.submit) eq "Generate Bankfile Now">
				<cfset CFSEmpId = getemplist.id>
				<cfoutput>
					#createInvoice(CFSEmpId)#
				</cfoutput>
			</cfif>
		</cfloop>
		<cfif trim(form.submit) eq "Generate Bankfile Now">
			<cfinclude template="/CFSpaybill/generateBankFile.cfm">
		<cfelse>
			<script type="text/javascript">
				alert("Transaction Saved");
				window.location="/CFSpaybill/generateInvoiceBankfiledata.cfm?profileid=#url.profileid#";
				</script>
		</cfif>
	</cfif>
</cfoutput>

<cffunction name="createInvoice" output=True access="public" returntype="void">
	<cfargument name="CFSEmpId" required="yes" type="string">
	<cfquery name="getcustname" datasource="#dts#">
       			 select name,term from arcust where custno='#form.custno#'
        		</cfquery>
	<!---================================GENERATING THE NEXT REFERENCE NUMBER ================================================ --->
	<cfquery datasource="#dts#" name="getGeneralInfo">
	            	select lastusedno from invaddress WHERE invnogroup = 7;
	            </cfquery>
	<cfset refno = getGeneralInfo.lastusedno>
	<cfset refnocheck = 0>
	<cfset prefix = "M">
	<cfset counter = 2>
	<cfset refnolen = 8>
	<!--- loop till a unique number is generated --->
	<cfloop condition="refnocheck eq 0">
		<cftry>
			<cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno#" returnvariable="refnonew"/>
			<cfcatch>
				<cfinvoke component="cfc.refno" method="processNum" oldNum="#refno1#" returnvariable="refnonew" />
			</cfcatch>
		</cftry>
		<cfset refno = refnonew>
		<cfquery name="checkexistrefno" datasource="#dts#">
				    	select refno from artran where type='INV' and refno = "#refno#"
				    </cfquery>
		<cfif checkexistrefno.recordcount eq 0>
			<cfset refnocheck = 1>
		</cfif>
	</cfloop>
	<!---================================END OF GENERATING THE NEXT REFERENCE NUMBER ================================================ --->
	<!---================================SETTING VARIABLE VALUES TO BE INSERTED ================================================ --->
	<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(currentdate,'yyyy-mm-dd')#" returnvariable="fperiod"/>
	<cfset desp = "Contract for service by #getemplist.name#" >
	<Cfif getcustname.term eq "">
		<cfset term = "14" >
	<cfelse>
		<cfset term = getcustname.term >
	</Cfif>
	<cfif structkeyexists(form,"taxable_#CFSEmpId#") >
		<cfset taxBillAmt = sumOfTotaLBillAmount * 0.06 >
		<cfset taxPayAmt = sumOfTotalPayAmount * 0.06 >
		<cfset taxcode = "SR">
	<cfelse>
		<cfset taxBillAmt = 0 >
		<cfset taxPayAmt = 0 >
		<cfset taxcode = "OS">
	</cfif>
	<cfset grossBillAmount = sumOfTotalBillAmount + sumOfTotalAdminFee >
	<cfset grossPayAmount = sumOfTotalPayAmount + sumOfTotalAdminFee >
	<cfset nettBillAmount = sumOfTotalBillAmount + sumOfTotalAdminFee + taxBillAmt >
	<cfset nettPayAmount = sumOfTotalBillAmount + sumOfTotalAdminFee + taxPayAmt >
	<cfset currentdate = createdate(year(now()),month(now()),day(now()))>
	<!--- ================================= INSERT INTO ARTRAN ================================================--->
	<cfquery datasource="#dts#" >

			INSERT INTO artran
   		(
            type,
            refno,
            trancode,
            custno,
            fperiod,
            wos_date,
            desp,
            currrate,
            gross_bil,
            net_bil,
            tax1_bil,
            tax_bil,
            grand_bil,
            credit_bil,
            net,
            tax1,
            tax,
            taxp1,
            grand,
            debitamt,
            frem0,
            frem7,
            rem0,
            rem1,
            rem3,
            note,
            created_by,
            created_on,
            rem10,
            userid,
            name,
            trdatetime,
            term,
            currcode
        )
        values
        (
            <cfqueryparam cfsqltype="cf_sql_varchar" value="INV">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#refnonew#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(currentdate,'yyyy-mm-dd')#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#desp#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#grossBillAmount#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#nettBillAmount#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#taxBillAmt#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#taxBillAmt#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#nettBillAmount#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#nettBillAmount#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#nettBillAmount#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#taxPayAmt#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#taxPayAmt#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="0.06">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#nettPayAmount#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#nettPayAmount#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(getcustname.name,45)#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(getcustname.name,45)#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="Profile">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="Profile">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="MYR">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="taxcode">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
            now(),
            <cfqueryparam cfsqltype='cf_sql_varchar' value='#desp#'>,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(getcustname.name,45)#">,
            now(),
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#term#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="MYR">
        )
        </cfquery>
	<!--- ================================= INSERT INTO ICTRAN ================================================--->
	<cfquery name="insertictran" datasource="#dts#">
        insert into ictran(
            type, refno, fperiod, wos_date, custno,
            trancode, itemcount, itemno, desp,
			qty_bil, price_bil, unit_bil, amt1_bil,
            taxpec1, taxamt_bil, qty,price, unit,
            amt1, amt, taxamt, note_a,
            trdatetime, userid, nodisplay, brem5
           )
        values(
            'INV',
			'#refnonew#',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#dateformat(currentdate,'yyyy-mm-dd')#">,
            '#form.custno#',
            '33',
			'33','Disbursement',
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(getcustname.name,45)#">,
            '1',<cfqueryparam cfsqltype="cf_sql_varchar" value="#grossBillAmount#">,
			'1',<cfqueryparam cfsqltype="cf_sql_varchar" value="#grossBillAmount#">,
            '0.06',
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#taxBillAmt#">,
            '1',
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#grossPayAmount#">,
			'',
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#grossPayAmount#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#grossPayAmount#">,
			<cfqueryparam cfsqltype="cf_sql_varchar" value="#taxPayAmt#">,
		    <cfqueryparam cfsqltype="cf_sql_varchar" value="#taxcode#">,
            now(),
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
            'N',
             <cfqueryparam cfsqltype="cf_sql_varchar" value="#CFSEmpId#">
            )
   	 </cfquery>
	<!---===========================UPDATING THE LAST USED NUMBER============================--->
	<cfquery name="getlastusedno" datasource="#dts#">
		UPDATE invaddress SET lastusedno = "#refno#" WHERE
		invnogroup = 7
	</cfquery>
</cffunction>
