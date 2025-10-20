<!---trim all fields--->
<cfscript>
 for(field in form.fieldNames){
  form[field] = trim(form[field]);
 }
</cfscript>
<!---trim all fields--->
<cfif isdefined('form.refno')>
	<cfif trim(form.refno) eq "">
		<cfabort>
	</cfif>
</cfif>

<cfif isdefined('form.claimadd1')>
	  <cfset form.claimadd1 = "Y">
<cfelse>
	  <cfset form.claimadd1 = "N">
</cfif>
<cfif isdefined('form.claimadd2')>
	  <cfset form.claimadd2 = "Y">
<cfelse>
	  <cfset form.claimadd2 = "N">
</cfif>
<cfif isdefined('form.claimadd3')>
	  <cfset form.claimadd3 = "Y">
<cfelse>
	  <cfset form.claimadd3 = "N">
</cfif>
<cfif isdefined('form.claimadd4')>
	  <cfset form.claimadd4 = "Y">
<cfelse>
	  <cfset form.claimadd4 = "N">
</cfif>
<cfif isdefined('form.claimadd5')>
	  <cfset form.claimadd5 = "Y">
<cfelse>
	  <cfset form.claimadd5 = "N">
</cfif>
<cfif isdefined('form.claimadd6')>
	  <cfset form.claimadd6 = "Y">
<cfelse>
	  <cfset form.claimadd6 = "N">
</cfif>

<cfif form.assignmenttype eq "invoice">
    <cfset prefix = "M">
    <cfset counter = 2>
    <cfset refnolen = 8>
<cfelseif form.assignmenttype neq "invoice">
    <cfset prefix = "S">
    <cfset counter = 2>
    <cfset refnolen = 8>
<cfelse>
    <cfset prefix = "E">
    <cfset counter = 1>
    <cfset refnolen = 8>
</cfif>
    
<cfquery name='getempinfo' datasource='#dts#'>
      select sex from placement where empno='#form.empno#'
</cfquery>

<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">

<cfparam name="status" default="">
<cfif form.assignmentslipdate neq ''>
	  <cfset ndate = createdate(right(form.assignmentslipdate,4),mid(form.assignmentslipdate,4,2),left(form.assignmentslipdate,2))>
	  <cfset assignmentslipdate = dateformat(ndate,'yyyy-mm-dd')>
<cfelse>
	  <cfset assignmentslipdate = '0000-00-00'>
</cfif>
<cfif form.startdate neq ''>
	  <cfset ndate1 = createdate(right(form.startdate,4),mid(form.startdate,4,2),left(form.startdate,2))>
      <cfset startdate = dateformat(ndate1,'yyyy-mm-dd')>
<cfelse>
	  <cfset startdate = '0000-00-00'>
</cfif>
<cfif form.completedate neq ''>
	  <cfset ndate2 = createdate(right(form.completedate,4),mid(form.completedate,4,2),left(form.completedate,2))>
      <cfset completedate = dateformat(ndate2,'yyyy-mm-dd')>
<cfelse>
	  <cfset completedate = '0000-00-00'>
</cfif>

<cfif form.lastworkingdate neq ''>
	  <cfset ndate3 = createdate(right(form.lastworkingdate,4),mid(form.lastworkingdate,4,2),left(form.lastworkingdate,2))>
      <cfset lastworkingdate = dateformat(ndate3,'yyyy-mm-dd')>
<cfelse>
	  <cfset lastworkingdate = '0000-00-00'>
</cfif>

<!---<cfinvoke component="cfc.Period" method="getCurrentPeriod" dts="#dts#" inputDate="#dateformat(ndate,'yyyy-mm-dd')#" returnvariable="fperiod"/>--->
    
<cfset fperiod = numberformat(form.payrollperiod,'00')>

<cfquery name="getposition" datasource="#dts#">
      select position,invoicegroup,location,po_no,jobpostype from placement where placementno='#form.placementno#'
</cfquery>

<cfif form.mode eq "Create"> <!-- Cfif check status = create at line 91, 836, 1420-->
	  <cfif form.assignmenttype eq "invoice">
            <cfquery name="checkentity" datasource="#dts#">
                  SELECT location,jobpostype,custno FROM placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementno#">
            </cfquery>
            <cfquery name="getlastno" datasource="#dts#">
                  SELECT invnogroup FROM bo_jobtypeinv WHERE officecode = "#checkentity.location#" 
                  AND jobtype = "#checkentity.jobpostype#"
            </cfquery>
            <cfquery name="getlastusedno" datasource="#dts#">
                  SELECT lastusedno FROM invaddress WHERE 
                  invnogroup = "#getlastno.invnogroup#"
            </cfquery>
      </cfif>

      <cfquery name="checkexistrefno" datasource="#dts#">
            select refno from artran where type='INV' and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
      </cfquery>
      
      <cfif checkexistrefno.recordcount eq 0> <!-- If there are no exisiting invoice, it will take assignmentslip.refno-->
            <cfquery name="checkexistrefno" datasource="#dts#">
                  SELECT refno FROM assignmentslip WHERE refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
            </cfquery>
      </cfif>
	  <cfif checkexistrefno.recordcount neq 0> <!-- If found existing invoice from artran, CFIF end at line 193 -->
            <cfquery name="company_details" datasource="payroll_main">
                  SELECT mmonth,myear FROM gsetup WHERE comp_id = "#replace(dts,'_i','')#"
            </cfquery>   
			<cfif form.assignmenttype eq "invoice">
                  <cfset refno = getlastusedno.lastusedno>
            <cfelse>
                  <cfquery datasource="#dts#" name="getGeneralInfo">
                        select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
                        from refnoset
                        where type = 'INV'
                        and counter = #counter#
                  </cfquery>
                  <cfset refno = getGeneralInfo.tranno>
            </cfif>
            <cftry> <!-- The cfc component is program to take in the last running number based on the location and job type -->
                  <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno#" returnvariable="refnonew"/>
                  <cfcatch>
                      <cfinvoke component="cfc.refno" method="processNum" oldNum="#refno#" returnvariable="refnonew" />	
                  </cfcatch>
            </cftry>

			<cfif form.assignmenttype neq "invoice">         
                  <cfset refno = prefix&numberformat(company_details.mmonth,'00')&numberformat(right(refnonew,5),'00000')>
            <cfelse>
                  <cfset refno = refnonew>
            </cfif>
      
            <cfquery name="checkexistrefno" datasource="#dts#">
                  select refno from artran where type='INV' and refno = "#refno#"
            </cfquery>
      
            <cfif checkexistrefno.recordcount eq 0>
                  <cfquery name="checkexistrefno" datasource="#dts#">
                        SELECT refno FROM assignmentslip WHERE refno = "#refno#"
                  </cfquery>
            </cfif>

			<cfif checkexistrefno.recordcount neq 0> <!-- Check another time for reference no and grab invoice running number here-->
				  <cfset refnocheck = 0>
                  <cfloop condition="refnocheck eq 0">
                      <cftry>
                            <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno#" returnvariable="refnonew"/>
                            <cfcatch>
                                  <cfinvoke component="cfc.refno" method="processNum" oldNum="#refno#" returnvariable="refnonew" />	
                            </cfcatch>
                      </cftry>
                      <cfif form.assignmenttype eq "invoice">
                            <cfset refno = refnonew>
                      <cfelse>
                            <cfset refno = prefix&numberformat(company_details.mmonth,'00')&numberformat(right(refnonew,5),'00000')>
                      </cfif>
                      <cfquery name="checkexistrefno" datasource="#dts#">
                            select refno from artran where type='INV' and refno = "#refno#"
                      </cfquery>
                      <cfif checkexistrefno.recordcount eq 0>
                            <cfquery name="checkexistrefno" datasource="#dts#">
                                  SELECT refno FROM assignmentslip WHERE refno = "#refno#"
                            </cfquery>
                      </cfif>
                      <cfif checkexistrefno.recordcount eq 0>
                            <cfset refnocheck = 1>
                      </cfif>
                  </cfloop>                
            </cfif>

			<!---<cfif form.assignmenttype neq "invoice">--->
                  <cfquery datasource="#dts#" name="getGeneralInfo">
                      Update refnoset SET lastUsedNo = '#refno#' WHERE type = 'INV'
                      and counter = #counter#
                  </cfquery>
            <!---<cfelse><!-- should i stop it when the value is zero? -->
                  <cfquery name="getlastusedno" datasource="#dts#">
                      UPDATE invaddress SET lastusedno = "#refno#" WHERE 
                      invnogroup = "#getlastno.invnogroup#"
                  </cfquery>
            </cfif>--->
            <cfset form.refno = refno>
      </cfif> <!-- CFIF start at 115 -->
        
	  <!---<cfif form.assignmenttype neq "invoice">--->
            <cfquery datasource="#dts#" name="getGeneralInfo">
                  Update refnoset SET lastUsedNo = '#form.refno#' WHERE type = 'INV'
                  and counter = #counter#
            </cfquery>
      <!---<cfelse> <!-- Why is it duplicate as above? -->
            <cfquery name="getlastusedno" datasource="#dts#"> 
                  UPDATE invaddress SET lastusedno = "#refno#" WHERE 
                  invnogroup = "#getlastno.invnogroup#"
            </cfquery>
      </cfif>--->

      <cfquery name="getrunning" datasource="#dts#">
            UPDATE gsetup SET refnoall = '#right(form.refno,5)#'
      </cfquery> 
      
      <cfquery name="getentity" datasource="#dts#">
            SELECT invnogroup FROM bo_jobtypeinv
            WHERE officecode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getposition.location#">
            AND jobtype = "#getposition.jobpostype#"
      </cfquery>
      
      <cfquery name="getaddress" datasource="#dts#">
            SELECT shortcode FROM invaddress
            WHERE invnogroup=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getentity.invnogroup#">
      </cfquery>
            
      <cfquery datasource="#dts#" name="insertartran">
			Insert into assignmentslip    
            (
            refno,
            assignmentslipdate,
            custno,
            placementno,
            payno,
            chequeno,
            empno,
            lastworkingdate,
            startdate,
            completedate,
            selfusualpay,
            custusualpay,
            selfsalaryhrs,
            selfsalaryday,
            custsalaryhrs,
            custsalaryday,
            selfsalary,
            custsalary,
            selfexceptionrate,
            selfexceptionhrs,
            selfexception,
            selfotrate1,
            selfothour1,
            custotrate1,
            custothour1,
            selfot1,
            custot1,
            selfotrate2,
            selfothour2,
            custotrate2,
            custothour2,
            selfot2,
            custot2,
            selfotrate3,
            selfothour3,
            custotrate3,
            custothour3,
            selfot3,
            custot3,
            selfotrate4,
            selfothour4,
            custotrate4,
            custothour4,
            selfot4,
            custot4,
            selfottotal,
            custottotal,
            selfcpf,
            custcpf,
            selfsdf,
            custsdf,
            selfallowancerate1,
            selfallowancehour1,
            custallowancerate1,
            custallowancehour1,
            selfallowancerate2,
            selfallowancehour2,
            custallowancerate2,
            custallowancehour2,
            selfallowancerate3,
            selfallowancehour3,
            custallowancerate3,
            custallowancehour3,
            selfallowancerate4,
            custallowancerate4,
            selfallowance,
            custallowance,
            selfpayback,
            custpayback,
            selfdeduction,
            custdeduction,
            selfnet,
            custnet,
            taxcode,
            taxper,
            taxamt,
            selftotal,
            custtotal,
            created_by,
            created_on,
            addchargecust,
            addchargeself,
            addchargedesp,
            addchargecust2,
            addchargeself2,
            addchargedesp2,
            addchargecust3,
            addchargeself3,
            addchargedesp3,
            addchargecust4,
            addchargeself4,
            addchargedesp4,
            payrollperiod,
            custname,
            empname,
            AL,
            MC,
            assignmenttype,
            emppaymenttype,
            paymenttype,
            paydate,
            aw104desp,
            aw105desp,
            aw106desp,
            selfallowancerate5,
            selfallowancerate6
            ,custallowancerate5
            ,custallowancerate6
            ,addchargedesp5
            ,addchargeself5
            ,addchargecust5
            ,addchargedesp6
            ,addchargeself6
            ,addchargecust6
            ,claimadd1
            ,claimadd2
            ,claimadd3
            ,claimadd4
            ,claimadd5
            ,claimadd6
            ,CUSTEXCEPTION
            ,NPL
            ,CUSTNPL
            ,WORKD
            ,aw101desp
            ,aw102desp
            ,aw103desp
            ,nsded
            ,nsdeddesp
            ,ded1
            ,ded1desp
            ,ded2
            ,ded2desp
            ,ded3
            ,ded3desp,
            custname2,
            iname,
            supervisor,
            assigndesp,
            invdesp,
            invdesp2,
            paydesp,
            backpaydesp,
            <cfloop from="1" to="10" index="i">
                  lvltype#i#,
                  lvldesp#i#,
                  lvleedayhr#i#,
                  lvleerate#i#,
                  lvlerdayhr#i#,
                  lvlerrate#i#,
                  lvltotalee#i#,
                  lvltotaler#i#,
                  lvlhr#i#,
            </cfloop>
            <cfloop from="1" to="6" index="i">
                  fixawcode#i#,
                  fixawdesp#i#,
                  fixawee#i#,
                  fixawer#i#,
                  fixaworiamt#i#,
            </cfloop>
            <cfloop from="1" to="18" index="a">
                  allowance#a#,
                  allowancedesp#a#,
                  awee#a#,
                  awer#a#,
            </cfloop>
            pbtext,
            pbeeamt,
            pberamt,
            awstext,
            awseeamt,
            awseramt,
            bonusmisctext,
            pbcpf,
            pbsdf,
            pbwi,
            pbadm,
            totalpbmisc,
            awsmisctext,
            awscpf,
            awssdf,
            awswi,
            awsadm,
            totalawsmisc,
            selfpbaws,
            custpbaws,
            nscustded,
            adminfeepercent,
            adminfeeminamt,
            adminfee,
            <cfloop from="1" to="6" index="i">
                  billitem#i#,
                  billitemdesp#i#,
                  billitemamt#i#,
                  billitempercent#i#,
            </cfloop>
            <cfloop from="1" to="3" index="i">
                  dedcust#i#,
            </cfloop>
            rebate,
            custtotalgross,
            SELFPHNLSALARY,
            CUSTPHNLSALARY,
            ADDCHARGECODE,
            ADDCHARGECODE2,
            ADDCHARGECODE3,
            firstrate,
            secondrate
            ,branch
            <cfloop from="5" to="8" index="i">
                  ,selfot#i#
                  ,selfotrate#i#
                  ,selfothour#i#
                  ,custot#i#
                  ,custotrate#i#
                  ,custothour#i#
            </cfloop>
            )
			values 
			('#form.refno#','#assignmentslipdate#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementno#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.payno#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.chequeno#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">,
            '#lastworkingdate#',
            '#startdate#',
            '#completedate#',
            '#val(form.selfusualpay)#',
            '#val(form.custusualpay)#',
            '#val(form.selfsalaryhrs)#',
            '#val(form.selfsalaryday)#',
            '#val(form.custsalaryhrs)#',
            '#val(form.custsalaryday)#',
            '#val(form.selfsalary)#',
            '#val(form.custsalary)#',
            '#val(form.selfexceptionrate)#',
            '#val(form.selfexceptionhrs)#',
<!---             '#val(form.selfexceptionday)#', --->
            '#val(form.selfexception)#',
            '#val(form.selfotrate1)#',
            '#val(form.selfothour1)#',
            '#val(form.custotrate1)#',
            '#val(form.custothour1)#',
            '#val(form.selfot1)#',
            '#val(form.custot1)#',
            '#val(form.selfotrate2)#',
            '#val(form.selfothour2)#',
            '#val(form.custotrate2)#',
            '#val(form.custothour2)#',
            '#val(form.selfot2)#',
            '#val(form.custot2)#',
            '#val(form.selfotrate3)#',
            '#val(form.selfothour3)#',
            '#val(form.custotrate3)#',
            '#val(form.custothour3)#',
            '#val(form.selfot3)#',
            '#val(form.custot3)#',
            '#val(form.selfotrate4)#',
            '#val(form.selfothour4)#',
            '#val(form.custotrate4)#',
            '#val(form.custothour4)#',
            '#val(form.selfot4)#',
            '#val(form.custot4)#',
            
            '#val(form.selfottotal)#',
            '#val(form.custottotal)#',
            '#val(form.selfcpf)#',
            '#val(form.custcpf)#',
            '#val(form.selfsdf)#',
            '#val(form.custsdf)#',
            
            '#val(form.selfallowancerate1)#',
            '#val(form.selfallowancehour1)#',
            '#val(form.custallowancerate1)#',
            '#val(form.custallowancehour1)#',
            '#val(form.selfallowancerate2)#',
            '#val(form.selfallowancehour2)#',
            '#val(form.custallowancerate2)#',
            '#val(form.custallowancehour2)#',
            '#val(form.selfallowancerate3)#',
            '#val(form.selfallowancehour3)#',
            '#val(form.custallowancerate3)#',
            '#val(form.custallowancehour3)#',
            '#val(form.selfallowancerate4)#',
            <!--- '#val(form.selfallowancehour4)#', --->
            '#val(form.custallowancerate4)#',
            <!--- '#val(form.custallowancehour4)#', --->
            '#val(form.selfallowance)#',
            '#val(form.custallowance)#',
            '#val(form.selfpayback)#',
            '#val(form.custpayback)#',
            '#val(form.selfdeduction)#',
            '#val(form.custdeduction)#',
            '#val(form.selfnet)#',
            '#val(form.custnet)#',
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxcode#">,
            '#val(form.taxper)#',
            '#val(form.taxamt)#',
            '#val(form.selftotal)#',
            '#val(form.custtotal)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,now(),'#val(form.addchargecust)#','#val(form.addchargeself)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.addchargedesp#">,'#val(form.addchargecust2)#','#val(form.addchargeself2)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.addchargedesp2#">,'#val(form.addchargecust3)#','#val(form.addchargeself3)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.addchargedesp3#">,'#val(form.addchargecust4)#','#val(form.addchargeself4)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.addchargedesp4#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.payrollperiod#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custname#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empname#">,'#val(form.AL)#','#val(form.MC)#',<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assignmenttype#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.emppaymenttype#">,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.paymenttype#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.paydate#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.aw104desp#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.aw105desp#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.aw106desp#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.selfallowancerate5)#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.selfallowancerate6)#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.custallowancerate5)#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.custallowancerate6)#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.addchargedesp5#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.addchargeself5)#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.addchargecust5)#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.addchargedesp6#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.addchargeself6)#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.addchargecust6)#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.claimadd1#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.claimadd2#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.claimadd3#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.claimadd4#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.claimadd5#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.claimadd6#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.CUSTEXCEPTION#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.NPL#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.CUSTNPL#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.workd#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.aw101desp#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.aw102desp#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.aw103desp#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.nsded#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.nsdeddesp#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ded1#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ded1desp#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ded2#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ded2desp#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ded3#">
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ded3desp#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custname2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.iname#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.supervisor#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assigndesp#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invdesp#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invdesp2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.paydesp#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.backpaydesp#">,
            <cfloop from="1" to="10" index="i">
                  <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.lvltype#i#')#">,
                  <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.lvldesp#i#')#">,
                  <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.lvleedayhr#i#')#">,
                  <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.lvleerate#i#'),'.__')#">,
                  <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.lvlerdayhr#i#')#">,
                  <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.lvlerrate#i#'),'.__')#">,
                  <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.lvltotalee#i#'),'.__')#">,
                  <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.lvltotaler#i#'),'.__')#">,
                  <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.lvlhr#i#'),'.__')#">,
            </cfloop>
            <cfloop from="1" to="6" index="i">
                  <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.fixawcode#i#')#">,
                  <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.fixawdesp#i#')#">,
                  <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.fixawee#i#'),'.__')#">,
                  <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.fixawer#i#'),'.__')#">,
                  <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.fixaworiamt#i#'),'.__')#">,
            </cfloop>
            <cfloop from="1" to="18" index="a">
                  <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.allowance#a#')#">,
                  <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.allowancedesp#a#')#">,
                  <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.awee#a#'),'.__')#">,
                  <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.awer#a#'),'.__')#">,
            </cfloop>
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.pbtext#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.pbeeamt,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.pberamt,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.awstext#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.awseeamt,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.awseramt,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bonusmisctext#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.pbcpf,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.pbsdf,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.pbwi,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.pbadm,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.totalpbmiscfield,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.awsmisctext#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.awscpf,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.awssdf,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.awswi,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.awsadm,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.totalawsmiscfield,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.selfpbaws,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.custpbaws,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.nscustded,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.adminfeepercent,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.adminfeeminamt,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.adminfee,'.__')#">,
            <cfloop from="1" to="6" index="i">
                  <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.billitem#i#')#">,
                  <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.billitemdesp#i#')#">,
                  <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.billitemamt#i#'),'.__')#">,
                  <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.billitempercent#i#'),'.__')#">,
            </cfloop>
            <cfloop from="1" to="3" index="i">
                  <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.dedcust#i#'),'.__')#">,
            </cfloop>
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.rebate,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.custtotalgross,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.SELFPHNLSALARY,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.CUSTPHNLSALARY,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ADDCHARGECODE#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ADDCHARGECODE2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ADDCHARGECODE3#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.firstrate,'.__')#">,
            <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.secondrate,'.__')#">
            ,"#getaddress.shortcode#"
             <cfloop from="5" to="8" index="i">
                ,"#val(evaluate('form.selfot#i#'))#"
                ,"#val(evaluate('form.selfotrate#i#'))#"
                ,"#val(evaluate('form.selfothour#i#'))#"
                ,"#val(evaluate('form.custot#i#'))#"
                ,"#val(evaluate('form.custotrate#i#'))#"
                ,"#val(evaluate('form.custothour#i#'))#"
            </cfloop>
            )
      </cfquery>
        
      <cfquery name="getcustname" datasource="#dts#">
            select name,term from #target_arcust# where custno='#form.custno#'
      </cfquery>
        
	  <!---<cfif form.assignmenttype neq 'invoice'>--->
			<cfset assignmentno = form.refno>
            <cfquery name="checkinvoiceexist" datasource="#dts#">
                  SELECT refno FROM artran WHERE 
                  type = "INV" 
                  AND fperiod <> "99"
                  AND rem11 = "#trim(form.assignmenttype)#"
                  and month(wos_date) = "#dateformat(assignmentslipdate,'m')#"
                  and year(wos_date) = "#dateformat(assignmentslipdate,'yyyy')#"
                  and custno = "#trim(form.custno)#"
				  and (posted='' or posted is null )
					and (void='' or void is null)
				  order by refno <cfif custno neq '300033162'>desc</cfif>
            </cfquery>
			<cfif checkinvoiceexist.recordcount eq 0>
            <cfelse>
				  <cfset refnofound = checkinvoiceexist.refno>
                  <cfif form.custtotalgross neq 0.00 and left(refnofound,1) neq 'S'>
                      <cfquery name="updateinv" datasource="#dts#">
                      UPDATE assignmentslip 
                      SET invoiceno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refnofound#"> 
                      WHERE refno = "#assignmentno#"
                      </cfquery>
                  </cfif>
            </cfif>
      <!---</cfif>--->
        
<!---         <cfif form.assignmenttype eq 'invoice'> --->
	  <cfset assignmentslipno = form.refno>
      <cfif isdefined('refnofound') eq false>
            <cfquery name="checkentity" datasource="#dts#">
                  SELECT location,jobpostype,custno FROM placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementno#">
            </cfquery>
            <cfquery name="getlastno" datasource="#dts#">
                  SELECT invnogroup FROM bo_jobtypeinv WHERE officecode = "#checkentity.location#" 
                  AND jobtype = "#checkentity.jobpostype#"
            </cfquery>
            <cfquery name="getlastusedno" datasource="#dts#">
                  SELECT lastusedno FROM invaddress WHERE 
                  invnogroup = "#getlastno.invnogroup#"
            </cfquery>
            <cfset refno = getlastusedno.lastusedno>
            <cftry>
                  <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno#" returnvariable="refnonew"/>
                  <cfcatch>
                        <cfinvoke component="cfc.refno" method="processNum" oldNum="#refno#" returnvariable="refnonew" />	
                  </cfcatch>
            </cftry>
            
            <cfset refno = refnonew>
            <cfquery name="checkexistrefno" datasource="#dts#">
                  select refno from artran where type='INV' and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
            </cfquery>
            <cfif checkexistrefno.recordcount neq 0>
				  <cfset refnocheck = 0>
                  <cfloop condition="refnocheck eq 0">
                        <cftry>
                              <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno#" returnvariable="refnonew"/>
                              <cfcatch>
                                    <cfinvoke component="cfc.refno" method="processNum" oldNum="#refno#" returnvariable="refnonew" />	
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
            </cfif>
            <cfset form.refno = refno>
      </cfif>
      <cfif form.custtotalgross neq 0> <!-- This cfif is to check if form.custtotalgross is zero or not. -- start from line 716 to line 832--->
			<cfif isdefined('refnofound') eq false> <!-- Line 717, 826 -->
                  <cfquery name="insertartran" datasource="#dts#">
                        INSERT INTO artran
                        (type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,rem10,PONO,DONO,userid,name,trdatetime,van,term,area,currcode,rem40<cfif form.assignmenttype neq "invoice">,rem11,rem15</cfif>,rem30)
                        values
                        (
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="INV">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#assignmentslipdate#">,
                        <cfif getempinfo.sex eq "Female" or getempinfo.sex eq "F">
                            "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Ms #form.empname# - #getposition.position#"
                        <cfelse>
                        "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Mr #form.empname# - #getposition.position#"
                        </cfif>
                        ,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#form.custtotalgross#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#form.custtotalgross#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#form.taxamt#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#form.taxamt#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#form.custtotal#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#form.custtotal#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#form.custtotalgross#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#form.custtotalgross#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#form.taxamt#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#form.taxamt#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#form.taxper#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#form.custtotal#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#form.custtotal#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(form.custname2,45)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(form.custname2,45)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="Profile">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="Profile">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="MYR">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxcode#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                        now(),
                        <cfif getempinfo.sex eq "Female" or getempinfo.sex eq "F">
                              "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Ms #form.empname# - #getposition.position#"
                        <cfelse>
                              "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Mr #form.empname# - #getposition.position#"
                        </cfif>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(form.custname2,45)#">,
                        now(),
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <Cfif getcustname.term eq "">
                              <cfqueryparam cfsqltype="cf_sql_varchar" value="14">,
                        <cfelse>
                              <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustname.term#">,
                        </Cfif>
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="MYR">,"#assignmentslipno#"<cfif form.assignmenttype neq "invoice">,
                        "#form.assignmenttype#"
                        ,"#assignmentslipno#"
                        </cfif>
                        ,"#getaddress.shortcode#"
                        )
                  </cfquery>
                  <!---<cfif form.assignmenttype neq "invoice">--->
                  		<cfif form.custtotalgross neq 0.00 and left(form.refno,1) neq 'S'>
                            <cfquery name="updateinv" datasource="#dts#">
                                  UPDATE assignmentslip SET invoiceno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#"> WHERE refno = "#assignmentno#"
                            </cfquery>
							<cfquery name="getlastusedno" datasource="#dts#">
								  UPDATE invaddress SET lastusedno = "#refno#" WHERE 
								  invnogroup = "#getlastno.invnogroup#"
							</cfquery>
						</cfif>
                  <!---</cfif>--->
            <cfelse> <!-- Line 717, 826, 831 -->
                  <cfset form.refno = refnofound> <!-- this line here extend the list of assignment slip number in remark15 -->
                  <cfquery name="updaterem15" datasource="#dts#"> 
                        UPDATE artran SET rem15 = concat(rem15,',#assignmentslipno#') WHERE refno = "#refnofound#" and type = "INV"
                  </cfquery>
            </cfif> <!-- Line 717, 826, 831 -->
            <cfinclude template="/default/transaction/assignmentslipnewnew//ictranbody.cfm">
      </cfif> <!-- This cfif is to check if form.custtotalgross is zero or not. -- start from line 716 to line 833--->
	  <cfif form.custtotalgross eq 0.00>
      		<cfset form.refno = assignmentslipno>
      </cfif>
	  <cfset status="The assignmentslip, #form.refno# had been successfully created. ">
<cfelse> <!-- Cfif check status = create at line 91, 836. 1420 -->
      <cfquery datasource='#dts#' name="checkitemExist">
            Select * from assignmentslip where refno='#form.refnotrue#'
      </cfquery>
      <cfif checkitemExist.recordcount neq 0 > <!-- Coding from line 839 check if record exist till line 881-->
			<cfif form.mode eq "Delete"> <!-- Coding from line 840 check if mode is delete till line 881-->
				
				<cfset dtspay=replace(dts,'_i','_p','all')>

				<cfquery datasource='#dts#'>
					CREATE TABLE IF NOT EXISTS deleted_assignmentslip LIKE assignmentslip
				</cfquery>
				
				  <cfif checkitemExist.assignmenttype eq "invoice">
                        <cfquery name="deletepayrecord" datasource="#dtspay#">
                            Delete FROM payrecord WHERE invoiceno = '#form.refnotrue#'
                        </cfquery>
                        <cfquery datasource='#dts#' name="deleteartran">
                            UPDATE artran SET void = "Y",updated_on= now(),
							rem30 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reason#">,
                            updated_on = now(),
                            updated_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#"> 
							where refno='#checkitemExist.invoiceno#' and type='INV' 
                        </cfquery>
                        <cfquery datasource='#dts#' name="deleteictran">
                            UPDATE ictran SET void = "Y" where brem6='#form.refno#' and type='INV' AND refno not in (select refno from artran where posted='p')
                        </cfquery>
						<cfquery datasource='#dts#' name="recorddeleteditem">
                        INSERT IGNORE deleted_assignmentslip SELECT * FROM assignmentslip where refno='#form.refnotrue#'
                        </cfquery>
						<cfquery datasource='#dts#' name="recorddeleteditem">
                        UPDATE deleted_assignmentslip SET deleted_by="#Huserid#",deleted_on=now() where refno='#form.refnotrue#'
                        </cfquery> 
                        <cfinvoke component="cfc.clearpayweek" method="clearpayweek" db="#dtspay#" empno="#empno#" tablename="#emppaymenttype#" />
						<cfquery datasource='#dts#' name="deleteitem">
                            Delete from assignmentslip where refno='#form.refnotrue#'
                        </cfquery>
                        <cfinclude template="sumpaytm.cfm">
                  <cfelse>
                        <cfquery name="gettrancodes" datasource="#dts#">
                              SELECT trancodestart,trancodeend,orirefno,assignmenttype FROM assignmentslip where refno = "#form.refnotrue#"
                        </cfquery>
						<cfquery datasource='#dts#' name="recorddeleteditem">
                        INSERT IGNORE deleted_assignmentslip SELECT * FROM assignmentslip where refno='#form.refnotrue#'
                        </cfquery>
						<cfquery datasource='#dts#' name="recorddeleteditem">
                        UPDATE deleted_assignmentslip SET deleted_by="#Huserid#",deleted_on=now() where refno='#form.refnotrue#'
                        </cfquery> 
                        <cfinvoke component="cfc.clearpayweek" method="clearpayweek" db="#dtspay#" empno="#empno#" tablename="#emppaymenttype#" />
                        <cfquery datasource='#dts#' name="deleteitem">
                            Delete from assignmentslip where refno='#form.refnotrue#'
                        </cfquery>
                        <cfquery name="deletepayrecord" datasource="#dtspay#">
                            Delete FROM payrecord WHERE invoiceno = '#form.refnotrue#'
                        </cfquery>
                        <cfinclude template="sumpaytm.cfm">
                        <cfquery datasource='#dts#' name="deleteictran">
                              UPDATE ictran SET void = "Y" where type='INV' and brem6='#form.refnotrue#' AND refno not in (select refno from artran where posted='p')
                        </cfquery>
						<cfset tran = "INV">
						<cfset url.nexttranno = gettrancodes.orirefno>
                        <cfinclude template="recalculatebill.cfm">
                        <cfquery name="checkempty" datasource="#dts#">
                              SELECT itemno FROM ictran WHERE (void = "" or void is null)
                              AND refno='#gettrancodes.orirefno#' and type='INV' 
                        </cfquery>
						<cfif checkempty.recordcount eq 0>
                              <cfquery datasource='#dts#' name="deleteartran">
                                  UPDATE artran SET void = "Y",updated_on=now(),
								  rem30 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.reason#">,
                                  updated_on = now(),
                                  updated_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#"> 
								  where refno='#gettrancodes.orirefno#' and type='INV'
                              </cfquery>
                        <cfelse>
                              <cfquery datasource='#dts#' name="deleteartran">
                                  UPDATE artran SET rem15=replace(rem15,'#form.refnotrue#','') where refno='#gettrancodes.orirefno#' and type='INV'
                              </cfquery>
							  
							  <cfquery datasource='#dts#' name="getlistfirstrem15">
                              	SELECT rem15 FROM artran where refno='#gettrancodes.orirefno#' and type='INV'
                              </cfquery>
                              
                              <cfset newrem40 = listlast(getlistfirstrem15.rem15)>
                                                            
                              <cfquery datasource='#dts#' name="deleteartran">
                                  UPDATE artran SET rem40=<cfqueryparam cfsqltype="cf_sql_varchar" value="#newrem40#"> 
                                  where refno='#gettrancodes.orirefno#' and type='INV'
                              </cfquery>
                        </cfif>
                  </cfif>
				  <cfset status="The refno, #form.refno# had been successfully deleted. ">	
            </cfif>
			<cfif form.mode eq "Edit"> <!-- Edit Mode start from line 883 until line 1416-->
				  <cfif form.refno neq form.refnotrue> <!-- cf if start at line 884 and end at line 973  -->
						<cfif form.assignmenttype eq "invoice">
                              <cfquery name="checkentity" datasource="#dts#">
                                    SELECT location,jobpostype,custno FROM placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementno#">
                              </cfquery>
                              <cfquery name="getlastno" datasource="#dts#">
                                    SELECT invnogroup FROM bo_jobtypeinv WHERE officecode = "#checkentity.location#" 
                                    AND jobtype = "#checkentity.jobpostype#"
                              </cfquery>
                              <cfquery name="getlastusedno" datasource="#dts#">
                                    SELECT lastusedno FROM invaddress WHERE 
                                    invnogroup = "#getlastno.invnogroup#"
                              </cfquery>
                        </cfif>
						<cfset prefix = left(form.refno,1)>
                        <cfquery name="company_details" datasource="payroll_main">
                              SELECT mmonth,myear FROM gsetup WHERE comp_id = "#replace(dts,'_i','')#"
                        </cfquery>   
                        <cfquery datasource="#dts#" name="getGeneralInfo">
                              select lastUsedNo as tranno, refnoused as arun,refnocode,refnocode2,presuffixuse
                              from refnoset
                              where type = 'INV'
                              and counter = #counter#
                        </cfquery>
						<cfif form.assignmenttype eq "invoice">
							  <cfset refno = getlastusedno.lastusedno>
                        <cfelse>
							  <cfset refno = getGeneralInfo.tranno>
                        </cfif>
                        <cftry>
                            <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno#" returnvariable="refnonew"/>
                            <cfcatch>
                                <cfinvoke component="cfc.refno" method="processNum" oldNum="#refno#" returnvariable="refnonew" />	
                            </cfcatch>
                        </cftry>
						<cfif form.assignmenttype eq "invoice">
							  <cfset refno = refnonew>
                        <cfelse> 
							  <cfset refno = prefix&numberformat(company_details.mmonth,'00')&numberformat(right(refnonew,5),'00000')>
                        </cfif>
                        <!---<cfquery datasource='#dts#' name="deleteitem">
                              Delete from assignmentslip where refno='#form.refnotrue#'
                        </cfquery>--->
                        <cfquery name="checkexistrefno" datasource="#dts#">
                              select refno from artran where type='INV' and refno = "#refno#"
                        </cfquery>
						<cfif checkexistrefno.recordcount eq 0>
                              <cfquery name="checkexistrefno" datasource="#dts#">
                                    SELECT refno FROM assignmentslip WHERE refno = "#refno#"
                              </cfquery>
                        </cfif>
						<cfif checkexistrefno.recordcount neq 0>
							  <cfset refnocheck = 0>
                              <cfloop condition="refnocheck eq 0">
                                    <cftry>
                                          <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno#" returnvariable="refnonew"/>
                                          <cfcatch>
                                                <cfinvoke component="cfc.refno" method="processNum" oldNum="#refno#" returnvariable="refnonew" />	
                                          </cfcatch>
                                    </cftry>
									<cfif form.assignmenttype eq "invoice">
										  <cfset refno = refnonew>
                                    <cfelse>
										  <cfset refno = prefix&numberformat(company_details.mmonth,'00')&numberformat(right(refnonew,5),'00000')>
                                    </cfif>
                                    <cfquery name="checkexistrefno" datasource="#dts#">
                                          select refno from artran where type='INV' and refno = "#refno#"
                                    </cfquery>
                                    <cfif checkexistrefno.recordcount eq 0>
                                          <cfquery name="checkexistrefno" datasource="#dts#">
                                                SELECT refno FROM assignmentslip WHERE refno = "#refno#"
                                          </cfquery>
                                    </cfif>
									<cfif checkexistrefno.recordcount eq 0>
										  <cfset refnocheck = 1>
                                    </cfif>
                              </cfloop>                
                        </cfif>
						<!---<cfif form.assignmenttype neq "invoice">--->
                              <cfquery datasource="#dts#" name="getGeneralInfo">
                                    Update refnoset SET lastUsedNo = '#refno#' WHERE type = 'INV'
                                    and counter = #counter#
                              </cfquery>
                        <!---<cfelse>
						<cfif form.custtotalgross neq 0.00 and left(refno,1) neq 'S'>
                              <cfquery name="getlastusedno" datasource="#dts#">
                                    UPDATE invaddress SET lastusedno = "#refno#" WHERE 
                                    invnogroup = "#getlastno.invnogroup#"
                              </cfquery>
						</cfif>
                        </cfif>--->
                  </cfif> <!-- cf if start at line 884 and end at line 973 -->
                  <cfquery datasource='#dts#' name="updateassignmentslip">
                        Update assignmentslip 
                        set 
                        refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#">,
                        assignmentslipdate='#assignmentslipdate#',
                        custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,
                        placementno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementno#">,
                        payno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.payno#">,
                        chequeno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.chequeno#">,
                        empno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">,
                        lastworkingdate='#lastworkingdate#',
                        startdate='#startdate#',
                        completedate='#completedate#',
                        selfusualpay='#val(form.selfusualpay)#',
                        custusualpay='#val(form.custusualpay)#',
                        selfsalaryhrs='#val(form.selfsalaryhrs)#',
                        selfsalaryday='#val(form.selfsalaryday)#',
                        custsalaryhrs='#val(form.custsalaryhrs)#',
                        custsalaryday='#val(form.custsalaryday)#',
                        selfsalary='#val(form.selfsalary)#',
                        custsalary='#val(form.custsalary)#',
                        selfexceptionrate='#val(form.selfexceptionrate)#',
                        selfexceptionhrs='#val(form.selfexceptionhrs)#',
                        selfexception='#val(form.selfexception)#',
                        selfotrate1='#val(form.selfotrate1)#',
                        selfothour1='#val(form.selfothour1)#',
                        custotrate1='#val(form.custotrate1)#',
                        custothour1='#val(form.custothour1)#',
                        selfot1='#val(form.selfot1)#',
                        custot1='#val(form.custot1)#',
                        selfotrate2='#val(form.selfotrate2)#',
                        selfothour2='#val(form.selfothour2)#',
                        custotrate2='#val(form.custotrate2)#',
                        custothour2='#val(form.custothour2)#',
                        selfot2='#val(form.selfot2)#',
                        custot2='#val(form.custot2)#',
                        selfotrate3='#val(form.selfotrate3)#',
                        selfothour3='#val(form.selfothour3)#',
                        custotrate3='#val(form.custotrate3)#',
                        custothour3='#val(form.custothour3)#',
                        selfot3='#val(form.selfot3)#',
                        custot3='#val(form.custot3)#',
                        selfotrate4='#val(form.selfotrate4)#',
                        selfothour4='#val(form.selfothour4)#',
                        custotrate4='#val(form.custotrate4)#',
                        custothour4='#val(form.custothour4)#',
                        selfot4='#val(form.selfot4)#',
                        custot4='#val(form.custot4)#',
                    
                        selfottotal='#val(form.selfottotal)#',
                        custottotal='#val(form.custottotal)#',
                        selfcpf='#val(form.selfcpf)#',
                        custcpf='#val(form.custcpf)#',
                        selfsdf='#val(form.selfsdf)#',
                        custsdf='#val(form.custsdf)#',
                        
                        
                        selfallowancerate1='#val(form.selfallowancerate1)#',
                        selfallowancehour1='#val(form.selfallowancehour1)#',
                        custallowancerate1='#val(form.custallowancerate1)#',
                        custallowancehour1='#val(form.custallowancehour1)#',
                        selfallowancerate2='#val(form.selfallowancerate2)#',
                        selfallowancehour2='#val(form.selfallowancehour2)#',
                        custallowancerate2='#val(form.custallowancerate2)#',
                        custallowancehour2='#val(form.custallowancehour2)#',
                        selfallowancerate3='#val(form.selfallowancerate3)#',
                        selfallowancehour3='#val(form.selfallowancehour3)#',
                        custallowancerate3='#val(form.custallowancerate3)#',
                        custallowancehour3='#val(form.custallowancehour3)#',
                        selfallowancerate4='#val(form.selfallowancerate4)#',
                        <!--- selfallowancehour4='#val(form.selfallowancehour4)#', --->
                        custallowancerate4='#val(form.custallowancerate4)#',
                        <!--- custallowancehour4='#val(form.custallowancehour4)#', --->
                        selfallowance='#val(form.selfallowance)#',
                        custallowance='#val(form.custallowance)#',
                        selfpayback='#val(form.selfpayback)#',
                        custpayback='#val(form.custpayback)#',
                        selfdeduction='#val(form.selfdeduction)#',
                        custdeduction='#val(form.custdeduction)#',
                        selfnet='#val(form.selfnet)#',
                        custnet='#val(form.custnet)#',
                        taxcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxcode#">,
                        taxper='#val(form.taxper)#',
                        taxamt='#val(form.taxamt)#',
                        selftotal='#val(form.selftotal)#',
                        custtotal='#val(form.custtotal)#',
                        updated_by=<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                        updated_on=now(),
                        
                        addchargecust='#val(form.addchargecust)#',
                        addchargeself='#val(form.addchargeself)#',
                        addchargedesp=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.addchargedesp#">,
                        addchargecust2='#val(form.addchargecust2)#',
                        addchargeself2='#val(form.addchargeself2)#',
                        addchargedesp2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.addchargedesp2#">,
                        addchargecust3='#val(form.addchargecust3)#',
                        addchargeself3='#val(form.addchargeself3)#',
                        addchargedesp3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.addchargedesp3#">,
                        addchargecust4='#val(form.addchargecust4)#',
                        addchargeself4='#val(form.addchargeself4)#',
                        addchargedesp4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.addchargedesp4#">,
                        payrollperiod = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.payrollperiod#">,
                        custname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custname#">,
                        empname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empname#">,
                        AL='#val(form.AL)#',
                        MC='#val(form.MC)#',
                        assignmenttype=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assignmenttype#">,
                        emppaymenttype = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.emppaymenttype#">,
                        paymenttype = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.paymenttype#">
                        ,paydate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.paydate#">
                        ,aw104desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.aw104desp#">
                        ,aw105desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.aw105desp#">
                        ,aw106desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.aw106desp#">
                        ,selfallowancerate5 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.selfallowancerate5)#">
                        ,selfallowancerate6 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.selfallowancerate6)#">
                        ,custallowancerate5 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.custallowancerate5)#">
                        ,custallowancerate6 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.custallowancerate6)#">
                        ,addchargedesp5 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.addchargedesp5#">
                        ,addchargeself5 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.addchargeself5)#">
                        ,addchargecust5 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.addchargecust5)#">
                        ,addchargedesp6 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.addchargedesp6#">
                        ,addchargeself6 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.addchargeself6)#">
                        ,addchargecust6 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#val(form.addchargecust6)#">
                        ,claimadd1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.claimadd1#">
                        ,claimadd2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.claimadd2#">
                        ,claimadd3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.claimadd3#">
                        ,claimadd4 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.claimadd4#">
                        ,claimadd5 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.claimadd5#">
                        ,claimadd6 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.claimadd6#">
                        ,CUSTEXCEPTION = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.CUSTEXCEPTION#">
                        ,NPL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.NPL#">  
                        ,CUSTNPL = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.CUSTNPL#">  
                        ,workd = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.workd#">                  
                        ,aw101desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.aw101desp#">
                        ,aw102desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.aw102desp#">
                        ,aw103desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.aw103desp#"> 
                        ,nsded = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.nsded#"> 
                        ,nsdeddesp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.nsdeddesp#">
                        ,ded1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ded1#"> 
                        ,ded1desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ded1desp#"> 
                        ,ded2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ded2#"> 
                        ,ded2desp= <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ded2desp#">
                        ,ded3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ded3#"> 
                        ,ded3desp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ded3desp#">,
                        custname2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custname2#">,
                        iname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.iname#">,
                        supervisor = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.supervisor#">,
                        assigndesp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assigndesp#">,
                        invdesp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invdesp#">,
                        invdesp2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.invdesp2#">,
                        paydesp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.paydesp#">,
                        backpaydesp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.backpaydesp#">,
                        <cfloop from="1" to="10" index="i">
                              lvltype#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.lvltype#i#')#">,
                              lvldesp#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.lvldesp#i#')#">,
                              lvleedayhr#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.lvleedayhr#i#')#">,
                              lvleerate#i# = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.lvleerate#i#'),'.__')#">,
                              lvlerdayhr#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.lvlerdayhr#i#')#">,
                              lvlerrate#i# = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.lvlerrate#i#'),'.__')#">,
                              lvltotalee#i# = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.lvltotalee#i#'),'.__')#">,
                              lvltotaler#i# = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.lvltotaler#i#'),'.__')#">,
                              lvlhr#i# = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.lvlhr#i#'),'.__')#">,
                        </cfloop>
                        <cfloop from="1" to="6" index="i">
                              fixawcode#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.fixawcode#i#')#">,
                              fixawdesp#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.fixawdesp#i#')#">,
                              fixawee#i# = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.fixawee#i#'),'.__')#">,
                              fixawer#i# = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.fixawer#i#'),'.__')#">,
                              fixaworiamt#i# = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.fixaworiamt#i#'),'.__')#">,
                        </cfloop>
                        <cfloop from="1" to="18" index="a">
                              allowance#a# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.allowance#a#')#">,
                              allowancedesp#a# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.allowancedesp#a#')#">,
                              awee#a# = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.awee#a#'),'.__')#">,
                              awer#a# = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.awer#a#'),'.__')#">,
                        </cfloop>
                        pbtext = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.pbtext#">,
                        pbeeamt = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.pbeeamt,'.__')#">,
                        pberamt = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.pberamt,'.__')#">,
                        awstext = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.awstext#">,
                        awseeamt = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.awseeamt,'.__')#">,
                        awseramt = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.awseramt,'.__')#">,
                        bonusmisctext = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bonusmisctext#">,
                        pbcpf = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.pbcpf,'.__')#">,
                        pbsdf = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.pbsdf,'.__')#">,
                        pbwi = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.pbwi,'.__')#">,
                        pbadm = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.pbadm,'.__')#">,
                        totalpbmisc = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.totalpbmiscfield,'.__')#">,
                        awsmisctext = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.awsmisctext#">,
                        awscpf = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.awscpf,'.__')#">,
                        awssdf = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.awssdf,'.__')#">,
                        awswi = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.awswi,'.__')#">,
                        awsadm = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.awsadm,'.__')#">,
                        totalawsmisc = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.totalawsmiscfield,'.__')#">,
                        selfpbaws = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.selfpbaws,'.__')#">,
                        custpbaws = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.custpbaws,'.__')#">,
                        nscustded = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.nscustded,'.__')#">,
                        adminfeepercent = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.adminfeepercent,'.__')#">,
                        adminfeeminamt = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.adminfeeminamt,'.__')#">,
                        adminfee = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.adminfee,'.__')#">,
                        <cfloop from="1" to="6" index="i">
                              billitem#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.billitem#i#')#">,
                              billitemdesp#i# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.billitemdesp#i#')#">,
                              billitemamt#i# = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.billitemamt#i#'),'.__')#">,
                              billitempercent#i# = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.billitempercent#i#'),'.__')#">,
                        </cfloop>
                        rebate = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.rebate,'.__')#">,
                        custtotalgross = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.custtotalgross,'.__')#">,
                        <cfloop from="1" to="3" index="i">
                              dedcust#i# = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(evaluate('form.dedcust#i#'),'.__')#">,
                        </cfloop>
                        SELFPHNLSALARY = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.SELFPHNLSALARY,'.__')#">,
                        CUSTPHNLSALARY = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.CUSTPHNLSALARY,'.__')#">,
                        ADDCHARGECODE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ADDCHARGECODE#">,
                        ADDCHARGECODE2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ADDCHARGECODE2#">,
                        ADDCHARGECODE3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ADDCHARGECODE3#">,
                        oldrefno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refnotrue#">,
                        firstrate  = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.firstrate,'.__')#">,
                        secondrate  = <cfqueryparam cfsqltype="cf_sql_double" value="#numberformat(form.secondrate,'.__')#">
                        <cfloop from="5" to="8" index="i">
                              ,selfot#i# = "#val(evaluate('form.selfot#i#'))#"
                              ,selfotrate#i# = "#val(evaluate('form.selfotrate#i#'))#"
                              ,selfothour#i# = "#val(evaluate('form.selfothour#i#'))#"
                              ,custot#i# = "#val(evaluate('form.custot#i#'))#"
                              ,custotrate#i# = "#val(evaluate('form.custotrate#i#'))#"
                              ,custothour#i# = "#val(evaluate('form.custothour#i#'))#"
                        </cfloop>
                        where refno = '#form.refnotrue#'
                  </cfquery>
				  <cfset assignmentslipno = form.refno>
                
   <!---              <cfif form.assignmenttype neq 'sinvoice'> --->
                
				  <!---<cfif form.assignmenttype neq 'invoice'> ---> <!---Removed by Nieo 20170913 1001 due to invoice assignment type fixed of creating duplicated invoices--->
						<cfset assignmentno = form.refno>
                        <cfquery name="checkinvoiceexist" datasource="#dts#">
                              SELECT refno,rem15,rem40 FROM artran WHERE 
                              type = "INV" 
                              AND fperiod <> "99"
                            <cfif form.assignmenttype neq 'invoice'>
                                AND rem11 = "#trim(form.assignmenttype)#"
                            <cfelse>
                                AND rem11 = ""
                            </cfif>
                            <cfif form.assignmenttype eq 'invoice'>
                                AND rem40 = "#trim(form.refno)#"
                            </cfif>
                              and month(wos_date) = "#dateformat(assignmentslipdate,'m')#"
                              and year(wos_date) = "#dateformat(assignmentslipdate,'yyyy')#"
                              and custno = "#trim(form.custno)#"
							  and (posted='' or posted is null)
                            and (void='' or void is null)
							  order by refno <cfif custno neq '300033162' or form.assignmenttype eq 'invoice'>desc</cfif> 
                        </cfquery>
						<cfif checkinvoiceexist.recordcount eq 0>
                        <cfelse>
							  <cfset refnofound = checkinvoiceexist.refno>
                              <cfif form.custtotalgross neq 0.00 and left(refnofound,1) neq 'S'>
                                  <cfquery name="updateinv" datasource="#dts#">
                                        UPDATE assignmentslip SET invoiceno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refnofound#"> WHERE refno = "#assignmentno#"
                                  </cfquery>
                              </cfif>
							  <cfif checkinvoiceexist.rem15 neq "">
									<cfif listfirst(checkinvoiceexist.rem15) eq assignmentslipno>
										  <cfset isfirst = "Y">
                                          <cfset form.refnotrue = refnofound>
                                    </cfif>
                              </cfif>
                                <cfif checkinvoiceexist.rem40 neq "">
									<cfif checkinvoiceexist.rem40 eq assignmentslipno>
										  <cfset isfirst = "Y">
                                          <cfset form.refnotrue = refnofound>
                                    </cfif>
                              </cfif>
                        </cfif>
                  <!---<cfelse>
                        <!---Added by Nieo 20170911 1003, to assign invoiceno when assignmentslip is invoice--->
                        <cfquery name="updateinv" datasource="#dts#">
                            UPDATE assignmentslip SET invoiceno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refnotrue#"> WHERE refno = "#form.refno#"
                        </cfquery>
                        <!---Added by Nieo 20170911 1003, to assign invoiceno when assignmentslip is invoice--->
						<cfquery name="checkassignexist" datasource="#dts#">
                              select invoiceno from assignmentslip where refno = '#form.refnotrue#'
                        </cfquery>
                        <cfif checkassignexist.recordcount neq 0>
                        	<cfset form.refnotrue = checkassignexist.invoiceno>
                            <cfset isfirst = "Y">
                        </cfif>
						
                  </cfif>--->
                  <cfif isdefined('isfirst')> <!-- CF for isfirst start at line 1234 and end at line 1396 -->
                        <cfquery name="checkartranexist" datasource="#dts#">
                              select * from artran where refno = '#form.refnotrue#' and type='INV'
                        </cfquery>
                        <cfif checkartranexist.recordcount eq 0>
                            <cfquery name="checkartranexist" datasource="#dts#">
                              select * from assignmentslip where refno = '#form.refnotrue#'
                            </cfquery>
                            <cfset form.refnotrue = checkartranexist.invoiceno>
                        </cfif>
                        <cfquery name="getcustname" datasource="#dts#">
                              select name,term from #target_arcust# where custno='#form.custno#'
                        </cfquery>
						<cfif checkartranexist.recordcount neq 0><!-- Comment if artran contain the data for line 1240 line 1289 to line 1394-->
                              <!-- I will let this update run if the value is zero since we have to zero it. Only prevent it from creating when value is zero -->
                              <cfif form.custtotalgross neq 0> <!-- Similar stopper along the coding as no time to clean the coding, therefore adding a few checkpoint -->
                                    <cfquery datasource='#dts#' name="updateartran"> 
                                          Update artran 
                                          set                    
                                          custno = "#form.custno#",
                                          fperiod = "#fperiod#",
                                          wos_date = <cfqueryparam cfsqltype="cf_sql_varchar" value="#assignmentslipdate#">,
                                          currrate = "1",
                                          gross_bil =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custtotalgross#">,
                                          net_bil =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custtotalgross#">,
                                          tax1_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxamt#">,
                                          tax_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxamt#">,
                                          grand_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custtotal#">,
                                          debit_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custtotal#">,
                                          invgross =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custtotalgross#">,
                                          net =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custtotalgross#">,
                                          tax1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxamt#">,
                                          tax=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxamt#">,
                                          taxp1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxper#">,
                                          grand=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custtotal#">,
                                          debitamt=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custtotal#">,
                                          note=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxcode#">,
                                          updated_by=<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                                          updated_on=now(),
                                          rem10=<cfif getempinfo.sex eq "Female" or getempinfo.sex eq "F">
                                                      "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Ms #form.empname# - #getposition.position#"
                                                <cfelse>
                                                      "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Mr #form.empname# - #getposition.position#"
                                                </cfif>,
                                          desp=<cfif getempinfo.sex eq "Female" or getempinfo.sex eq "F">
                                                "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Ms #form.empname# - #getposition.position#"
                                                <cfelse>
                                                "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Mr #form.empname# - #getposition.position#"
                                                </cfif>,
                                          rem3='MYR',
                                          currcode='MYR',
                                          name =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(form.custname2,45)#">,
                                          frem0 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(form.custname2,45)#">,
                                          frem7 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(form.custname2,45)#">,
                                          <Cfif getcustname.term eq "">
                                                term = <cfqueryparam cfsqltype="cf_sql_varchar" value="14">,
                                          <cfelse>
                                                term = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustname.term#">,
                                          </Cfif>
                          <!--- refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#">, --->
                                          rem40 = "#assignmentslipno#"
                                          <cfif form.assignmenttype neq "invoice">,rem11="#form.assignmenttype#"</cfif>
                                          where refno = '#form.refnotrue#' and type='INV'
                                    </cfquery>
                              <cfelse> <!-- Below coding will handle existing value turn to zero -->
                                    <!-- 1. Check if the invoice remark contain other assignment number or not -->
                                    <cfquery name="checkrem15list" datasource="#dts#">
                                          SELECT refno,rem15 FROM artran WHERE 
                                          type = "INV" 
                                          AND fperiod <> "99"
                                          AND rem11 = "#form.assignmenttype#"
                                          and month(wos_date) = "#dateformat(assignmentslipdate,'m')#"
                                          and year(wos_date) = "#dateformat(assignmentslipdate,'yyyy')#"
                                          and custno = "#form.custno#"
										  and (posted='' or posted is null)
                                    </cfquery>
                                    <cfset templistlen = listlen(checkrem15list.rem15, ",")>
                                    <cfif templistlen gt 1>
                                          <!-- If the lenght return more than one, we will need to find the index and return the new list into artran-->
                                          <!-- The line belong will find the index of the assignmentslip no in the list -->
										  <cfset listfindindex = ListFind(checkrem15list.rem15, "#assignmentslipno#")> 
                                          <!-- This will push the entire rem15 into getallrem15 as an array or list -->
                                          <CFSET getallrem15 = ValueList(checkrem15list.rem15)> 
                                          <!-- Using the after_deleted_element to update the rem15 in artran -->									  
                                          <CFSET after_deleted_element = ListDeleteAt(getallrem15, "#listfindindex#")>
										  
										  <!---Added by Nieo 22/02/2017--->
                                          
                                          <cfset newfirst = listlast(after_deleted_element)>
                                          <cfquery name="updaterem40" datasource="#dts#">
                                          UPDATE artran
                                          SET
                                          rem40 = "#newfirst#"
                                          WHERE refno = '#form.refnotrue#' and type='INV'
                                          </cfquery>
                                          <!---Added by Nieo 22/02/2017--->
										  
                                          <cfquery datasource='#dts#' name="updateartran"> 
                                                Update artran 
                                                set                    
                                                custno = "#form.custno#",
                                                fperiod = "#fperiod#",
                                                wos_date = <cfqueryparam cfsqltype="cf_sql_varchar" value="#assignmentslipdate#">,
                                                currrate = "1",
                                                gross_bil =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custtotalgross#">,
                                                net_bil =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custtotalgross#">,
                                                tax1_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxamt#">,
                                                tax_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxamt#">,
                                                grand_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custtotal#">,
                                                debit_bil=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custtotal#">,
                                                invgross =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custtotalgross#">,
                                                net =<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custtotalgross#">,
                                                tax1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxamt#">,
                                                tax=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxamt#">,
                                                taxp1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxper#">,
                                                grand=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custtotal#">,
                                                debitamt=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custtotal#">,
                                                note=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxcode#">,
                                                updated_by=<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                                                updated_on=now(),
                                                rem10=<cfif getempinfo.sex eq "Female" or getempinfo.sex eq "F">
                                                            "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Ms #form.empname# - #getposition.position#"
                                                      <cfelse>
                                                            "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Mr #form.empname# - #getposition.position#"
                                                      </cfif>,
                                                desp=<cfif getempinfo.sex eq "Female" or getempinfo.sex eq "F">
                                                      "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Ms #form.empname# - #getposition.position#"
                                                      <cfelse>
                                                      "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Mr #form.empname# - #getposition.position#"
                                                      </cfif>,
                                                rem3='MYR',
                                                currcode='MYR',
                                                name =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(form.custname2,45)#">,
                                                frem0 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(form.custname2,45)#">,
                                                frem7 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(form.custname2,45)#">,
                                                <Cfif getcustname.term eq "">
      
                                                      term = <cfqueryparam cfsqltype="cf_sql_varchar" value="14">,
                                                <cfelse>
                                                      term = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustname.term#">,
                                                </Cfif>
                                                rem15 = "#after_deleted_element#"<!---,
                                                rem40 = "#assignmentslipno#"--->
                                                <cfif form.assignmenttype neq "invoice">,rem11="#form.assignmenttype#"</cfif>
                                                where refno = '#form.refnotrue#' and type='INV'
                                          </cfquery>
										  
                                    <cfelse>
                                          <!-- If the rem15 contain only one record, will be able to proceed to delete the entire artran for that assignment -->
										  <cfset dtspay=replace(dts,'_i','_p','all')>
                                          <cfquery name="deletepayrecord" datasource="#dtspay#">
                                              Delete FROM payrecord WHERE invoiceno = '#form.refnotrue#'
                                          </cfquery>
                                          <cfquery datasource='#dts#' name="deleteartran">
                                              UPDATE artran 
                                              SET void = "Y",updated_on=now(),rem30 = "System auto void due to zero billing" 
                                              WHERE refno='#form.refnotrue#' and type='INV'
                                          </cfquery>
                                          <cfquery datasource='#dts#' name="deleteictran">
                                              UPDATE ictran 
                                              SET void = "Y" 
                                              WHERE refno='#form.refnotrue#' and brem6='#assignmentslipno#' and type='INV'
                                          </cfquery>
                                    </cfif>
                              </cfif>
                              <cfset form.refno = form.refnotrue>
                        <cfelse><!-- Comment artran cannot find the record, then insert new data for line 1240 to line 1289 to line 1394  -->
                              <cfquery name="getcustname" datasource="#dts#">
                                    select name,term from #target_arcust# where custno='#form.custno#'
                              </cfquery>
							  
							  <!--- added when custtotalgross not equal 0.00 while edit--->
                              <cfset assignmentslipno = form.refno>
							<!---<cfif isdefined('refnofound') eq false>--->
                                  <cfquery name="checkentity" datasource="#dts#">
                                        SELECT location,jobpostype,custno FROM placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementno#">
                                  </cfquery>
                                  <cfquery name="getlastno" datasource="#dts#">
                                        SELECT invnogroup FROM bo_jobtypeinv WHERE officecode = "#checkentity.location#" 
                                        AND jobtype = "#checkentity.jobpostype#"
                                  </cfquery>
                                  <cfquery name="getlastusedno" datasource="#dts#">
                                        SELECT lastusedno FROM invaddress WHERE 
                                        invnogroup = "#getlastno.invnogroup#"
                                  </cfquery>
                                  <cfset refno = getlastusedno.lastusedno>
                                  <cftry>
                                        <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno#" returnvariable="refnonew"/>
                                        <cfcatch>
                                              <cfinvoke component="cfc.refno" method="processNum" oldNum="#refno#" returnvariable="refnonew" />	
                                        </cfcatch>
                                  </cftry>
                                  
                                  <cfset refno = refnonew>
                                  
                                  <cfquery name="checkexistrefno" datasource="#dts#">
                                        select refno from artran where type='INV' and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refno#">
                                  </cfquery>
                                  <cfif checkexistrefno.recordcount neq 0>
                                        <cfset refnocheck = 0>
                                        <cfloop condition="refnocheck eq 0">
                                              <cftry>
                                                    <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refno#" returnvariable="refnonew"/>
                                                    <cfcatch>
                                                          <cfinvoke component="cfc.refno" method="processNum" oldNum="#refno#" returnvariable="refnonew" />	
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
                                  </cfif>
                                  <cfset form.refno = refno>
                                  <!---</cfif>  --->                                
                              	<!--- added when custtotalgross not equal 0.00 while edit--->
							  
                              <cfif form.custtotalgross neq 0  and left(form.refno,1) neq "S"> <!-- Do not allow to insert when value is zero, finish at line 1393 -->
                                    <cfquery name="insertartran" datasource="#dts#">
                                          INSERT INTO artran
                                          (type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,rem10,PONO,DONO,userid,name,trdatetime,van,term,area,currcode,rem40<cfif form.assignmenttype neq "invoice">,rem11</cfif>)
                                          values
                                          (
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="INV">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#assignmentslipdate#">,
                                          <cfif getempinfo.sex eq "Female" or getempinfo.sex eq "F">
                                                "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Ms #form.empname# - #getposition.position#"
                                          <cfelse>
                                                "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Mr #form.empname# - #getposition.position#"
                                          </cfif>
                                          ,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="#form.custtotalgross#">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="#form.custtotalgross#">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="#form.taxamt#">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="#form.taxamt#">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="#form.custtotal#">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="#form.custtotal#">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="#form.custtotalgross#">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="#form.custtotalgross#">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="#form.taxamt#">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="#form.taxamt#">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="#form.taxper#">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="#form.custtotal#">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="#form.custtotal#">,
                                          <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(form.custname2,45)#">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(form.custname2,45)#">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="Profile">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="Profile">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="MYR">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.taxcode#">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                                          now(),
                                          <cfif getempinfo.sex eq "Female" or getempinfo.sex eq "F">
                                                "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Ms #form.empname# - #getposition.position#"
                                          <cfelse>
                                                "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Mr #form.empname# - #getposition.position#"
                                          </cfif>,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(form.custname2,45)#">,
                                          now(),
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <Cfif getcustname.term eq "">
                                                <cfqueryparam cfsqltype="cf_sql_varchar" value="14">,
                                          <cfelse>
                                                <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustname.term#">,
                                          </Cfif>
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                                          <cfqueryparam cfsqltype="cf_sql_varchar" value="MYR">,"#assignmentslipno#"
                                          <cfif form.assignmenttype neq "invoice">
                                                ,"#form.assignmenttype#"
                                          </cfif>
                                          )
                                    </cfquery>
                              </cfif>
                              <cfif form.custtotalgross neq 0.00 and left(form.refno,1) neq 'S'>
                                  <cfquery name="updateinv" datasource="#dts#">
                                        UPDATE assignmentslip SET invoiceno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#"> WHERE refno = "#assignmentslipno#"
                                  </cfquery>
                              	<cfquery name="checkentity" datasource="#dts#">
                                        SELECT location,jobpostype,custno FROM placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementno#">
                                  </cfquery>
                                  <cfquery name="getlastno" datasource="#dts#">
                                        SELECT invnogroup FROM bo_jobtypeinv WHERE officecode = "#checkentity.location#" 
                                        AND jobtype = "#checkentity.jobpostype#"
                                  </cfquery>
                                  <cfquery name="getlastusedno" datasource="#dts#">
                                        UPDATE invaddress SET lastusedno = "#refno#" WHERE 
                                        invnogroup = "#getlastno.invnogroup#"
                                  </cfquery>
                              </cfif>
                        </cfif><!-- Comment for line 1240 to line 1289 to  1394 -->
                  </cfif> <!-- CF for isfirst start at line 1234 and end at line 1396 -->
 				  <cfif form.assignmenttype neq 'invoice'><!-- Must let line 1397 run till 1412 so that ictran will be deleted -->
						<cfif isdefined('refnofound')>
							  <cfset form.refno = refnofound>
                              <cfquery name="gettrancodes" datasource="#dts#">
                                    SELECT invoiceno,trancodestart,trancodeend FROM assignmentslip where refno = "#assignmentslipno#"
                              </cfquery>
								<cfquery name="getorirefno" datasource="#dts#">
									SELECT refno from ictran where type='INV'
									AND brem6 = "#assignmentslipno#"
									GROUP BY refno
								</cfquery>
							  <cfquery name="deleteictran" datasource="#dts#">
                              delete from ictran where type='INV'
							  AND brem6 = "#assignmentslipno#"
							  AND refno not in (select refno from artran where posted='p')
                              </cfquery>
                        </cfif>
						
						<!---<cfif getorirefno.recordcount neq 0>
							<cfquery name="voidictran" datasource="#dts#">
                                    update ictran
                                    set void='Y' 
                                    where type='INV'
                                    AND brem6 = "#assignmentslipno#"
                            </cfquery>
						</cfif>--->
                  <cfelse>
                        <cfquery name="emptyallictran" datasource="#dts#">
                              delete from ictran where refno = '#form.refnotrue#' 
                              and brem6='#assignmentslipno#'   
                              and type='INV'
                              AND refno not in (select refno from artran where posted='p')
                        </cfquery>
                  </cfif>
                  <!-- If custtotalgross is not zero, system will go calculate the ictran -->
                        <cfinclude template="/default/transaction/assignmentslipnewnew//ictranbody.cfm">
                  <!-- Assume that calling ictranbody will insert data again, i do not have to care about ictran since it will be delete and inserted again -->
				  <cfif form.custtotalgross eq 0>
						<cfset form.refno = assignmentslipno>
				  </cfif>
                  <cfset status="The assignmentslip, #form.refno# had been successfully edited. ">
            </cfif> <!-- Edit Mode start from line 883 until line 1416-->
      <cfelse>		
			<cfset status="Sorry, the assignmentslip, #form.refno# was ALREADY removed from the system. Process unsuccessful.">
      </cfif>
</cfif> <!-- Cfif 1 at line 91, 836. 1420 -->


<cfoutput>
<cfif isdefined('form.processtimesheet')><!--- modified validated to processed, [20170913, Alvin]--->
      <cfquery name="processtimesheet" datasource="#dts#">
            UPDATE #replace(dts,'_i','_p','all')#.timesheet
            SET 
            status = "Processed"
            ,validated_on = now()
            ,validated_by = "#getauthuser()#"
            ,assignmentslipno = "#assignmentslipno#"
            ,invrefno = "#form.refno#"
            WHERE 
            <!---tmonth = "#form.validatetimesheet#"--->
            pdate BETWEEN "#lsdateformat(form.timesheetstart, 'yyyy-mm-dd', 'en_AU')#"
            AND "#lsdateformat(form.timesheetend, 'yyyy-mm-dd', 'en_AU')#"
            AND placementno = "#form.placementno#"
      </cfquery>
	  <script type="text/javascript">
			alert('Process Successfully!');
			window.location.href='/latest/customization/manpower_i/mpapproval/TimesheetApprovalMainT.cfm';
      </script>
      <cfabort>
</cfif>

<cfif isdefined('form.auto2')>
      <cfquery name="getlist" datasource="#dts#">
            SELECT id FROM importdata.exceldata1 WHERE f = "#form.placementno#" and id <= "#form.auto2#" and createdrefno = "" ORDER BY id
      </cfquery>
      <cfloop query="getlist">
            <cfquery name="updatecreated" datasource="#dts#">
                  UPDATE importdata.exceldata1 SET createdrefno = "#form.refno#"
                  WHERE id = "#getlist.id#"
            </cfquery>
      </cfloop>
      <cfquery name="getnexno" datasource="#dts#">
            SELECT id,f FROM importdata.exceldata1 WHERE id > "#form.auto2#" and createdrefno = "" and f <> "" ORDER BY id
      </cfquery>
	  <cfif getnexno.recordcount neq 0>
			<cfset lastid =0>
			<cfset currentplacementno = getnexno.f>
            <cfloop query="getnexno">
				  <cfif currentplacementno neq getnexno.f>
						<cfset lastid = getnexno.id - 1>
                        <cfbreak>
                  </cfif>
            </cfloop>
            <form name="done" id="done" action="/default/transaction/assignmentslipnewnew/Assignmentsliptable2.cfm?type=Create&placementno=#getnexno.f#&auto2=#lastid#" method="post">
                  <input name="status" value="#status#" type="hidden">
            </form>
      </cfif>
</cfif>

<cfif isdefined('form.auto2') eq false>
	  <cfif isdefined('url.createnew')>
            <form name="done" id="done" action="/default/transaction/assignmentslipnewnew/Assignmentsliptable2.cfm?type=Create" method="post">
                  <input name="status" value="#status#" type="hidden">
            </form>
      <cfelse>
            <form name="done" id="done" action="/default/transaction/assignmentslipnewnew/s_assignmentsliptable.cfm?type=assignmentslip&amp;process=done" method="post">
                  <input name="status" value="#status#" type="hidden">
            </form>
      </cfif>
</cfif>
</cfoutput>

 <!--- <cfif getauthuser() neq "ultracai"> --->
<cfquery name="checkpaydetail" datasource="#replace(dts,'_i','_p')#">
      SELECT grosspay FROM #form.emppaymenttype# WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
</cfquery>
<cfquery name="getassignmentdetail" datasource="#dts#">
      SELECT coalesce(selfsalary,0) + coalesce(selfottotal,0)+coalesce(selfallowance,0)+coalesce(selfpayback,0)+coalesce(selfexception,0) + coalesce(SELFPHNLSALARY,0)  + coalesce(selfpbaws,0) as gp FROM assignmentslip WHERE refno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#">
</cfquery>
<cfif isdefined('form.auto2') eq false>
	  <cfif val(checkpaydetail.grosspay) neq val(getassignmentdetail.gp) and mode neq "Delete">
			<script type="text/javascript">
				  alert('Assignment Employee Pay Record Is NOT TALLY With Payroll. Please Kindly Check!');
            </script>
      </cfif>
</cfif>
<script>
<cfif isdefined('url.createnew')>
	  <cfoutput>
			alert('#status#');
	  </cfoutput>
</cfif>
done.submit();
</script>
<!--- </cfif> ---> 