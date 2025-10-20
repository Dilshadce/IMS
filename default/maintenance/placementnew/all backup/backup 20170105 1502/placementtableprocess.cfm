
<link href="/stylesheet/stylesheet.css" rel="stylesheet" type="text/css">
<cfinclude template="/object/dateobject.cfm">
<cfquery name="getclaimlist" datasource="#dts#">
	SELECT wos_group,desp FROM icgroup
</cfquery>
<cfquery name="leavelist" datasource="#dts#">
Select * from iccostcode order by costcode
</cfquery>
<cfparam name="status" default="">
<cfif form.placementdate neq ''>
<cfset ndate = createdate(right(form.placementdate,4),mid(form.placementdate,4,2),left(form.placementdate,2))>
<cfset placementdate = dateformat(ndate,'yyyy-mm-dd')>
<cfelse>
<cfset placementdate = '0000-00-00'>
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


<cfif form.completedate1 neq ''>
<cfset completedate1 = dateformatnew(form.completedate1,'yyyy-mm-dd')>
<cfelse>
<cfset completedate1 = '0000-00-00'>
</cfif>

<cfif form.completedate2 neq ''>
<cfset completedate2 = dateformatnew(form.completedate2,'yyyy-mm-dd')>
<cfelse>
<cfset completedate2 = '0000-00-00'>
</cfif>

<cfif form.po_date neq ''>
<cfset ndate3 = createdate(right(form.po_date,4),mid(form.po_date,4,2),left(form.po_date,2))>
<cfset po_date = dateformat(ndate3,'yyyy-mm-dd')>
<cfelse>
<cfset po_date = '0000-00-00'>
</cfif>

<cfif form.bonusdate neq ''>
<cfset ndate4 = createdate(right(form.bonusdate,4),mid(form.bonusdate,4,2),left(form.bonusdate,2))>
<cfset bonusdate = dateformat(ndate4,'yyyy-mm-dd')>
<cfelse>
<cfset bonusdate = '0000-00-00'>
</cfif>

<cfif form.eff_d_1 neq ''>
<cfset ndate5 = createdate(right(form.eff_d_1,4),mid(form.eff_d_1,4,2),left(form.eff_d_1,2))>
<cfset eff_d_1 = dateformat(ndate5,'yyyy-mm-dd')>
<cfelse>
<cfset eff_d_1 = '0000-00-00'>
</cfif>

<cfif form.eff_d_2 neq ''>
<cfset ndate6 = createdate(right(form.eff_d_2,4),mid(form.eff_d_2,4,2),left(form.eff_d_2,2))>
<cfset eff_d_2 = dateformat(ndate6,'yyyy-mm-dd')>
<cfelse>
<cfset eff_d_2 = '0000-00-00'>
</cfif>

<cfif form.eff_d_3 neq ''>
<cfset ndate7 = createdate(right(form.eff_d_3,4),mid(form.eff_d_3,4,2),left(form.eff_d_3,2))>
<cfset eff_d_3 = dateformat(ndate7,'yyyy-mm-dd')>
<cfelse>
<cfset eff_d_3 = '0000-00-00'>
</cfif>

<cfif form.eff_d_4 neq ''>
<cfset eff_d_4 = dateformatnew(form.eff_d_4,'yyyy-mm-dd')>
<cfelse>
<cfset eff_d_4 = '0000-00-00'>
</cfif>

<cfif form.eff_d_5 neq ''>
<cfset eff_d_5 = dateformatnew(form.eff_d_5,'yyyy-mm-dd')>
<cfelse>
<cfset eff_d_5 = '0000-00-00'>
</cfif>

<cfif form.awsdate neq ''>
<cfset ndate8 = createdate(right(form.awsdate,4),mid(form.awsdate,4,2),left(form.awsdate,2))>
<cfset awsdate = dateformat(ndate8,'yyyy-mm-dd')>
<cfelse>
<cfset awsdate = '0000-00-00'>
</cfif>

<cfif form.phdate neq ''>
<cfset phdate = dateformatnew(form.phdate,'yyyy-mm-dd')>
<cfelse>
<cfset phdate = '0000-00-00'>
</cfif>


<cfif isdefined('form.empno')>
<cfquery name="getempname" datasource="#dts#">
SELECT name FROM #replace(dts,'_i','_p')#.pmast WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
</cfquery>
</cfif>

<cfif isdefined('form.empno')>
<cfquery name="getempname" datasource="#dts#">
SELECT name FROM #replace(dts,'_i','_p')#.pmast WHERE empno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">
</cfquery>
</cfif>



<cfif form.mode eq "Create">
	<cfquery datasource='#dts#' name="checkitemExist">
		Select * from Placement where right(placementno,6) = '#right(form.placementno,6)#' 
	</cfquery>
  
  
	<cfif checkitemExist.recordcount GT 0 >
    	<cfset refnocheck = 0>
        <cfset oldrefno = form.placementno>
		<cfloop condition="refnocheck eq 0">
        <cftry>
        <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#oldrefno#" returnvariable="newrefno"/>
		<cfcatch>
		<cfinvoke component="cfc.refno" method="processNum" oldNum="#oldrefno#" returnvariable="newrefno" />	
		</cfcatch>
        </cftry>
        <cfquery name="checkexistence" datasource="#dts#">
        Select * from Placement where right(placementno,6) = '#right(newrefno,6)#' 
        </cfquery>
        <cfif checkexistence.recordcount eq 0>
        <cfset refnocheck = 1>
        <cfset form.placementno = newrefno>
        <cfelse>
        <cfset oldrefno = newrefno>
		</cfif>
        </cfloop>
	</cfif>
		<cfquery datasource="#dts#" name="insertartran">
			Insert into Placement 
			(placementno,
            placementdate,
            placementtype,
            location,
            custno,
            custname,
            contactperson,
            consultant,
            billto,
            jobcode,
            position,
            empno,
            nric,
            iname,
            empname,
            sex,
            startdate,
            completedate,
            completedate1,
            completedate2,
            clienttype,
            assignmenttype,
            po_no,
            po_date,
            po_amount,
            description1,
            description2,
            emp_pay_d,
            bill_d,
            approvalType,
            option_to_ext,
            department,
            refer_by_client,
            inc_bill_cpf,
            cpf_amount,
            inc_bill_sdf,
            sdf_amount,
            admin_fee,
            admin_fee_fix_amt,
            admin_f_min_amt,
            rebate,
            ottable,
            rebate_pro_rate,
            eff_d_1,
            eff_d_2,
            eff_d_3,
            eff_d_4,
            eff_d_5,
            employee_rate_1,
            employee_rate_2,
            employee_rate_3,
            employee_rate_4,
            employee_rate_5,
            employer_rate_1,
            employer_rate_2,
            employer_rate_3,
            employer_rate_4,
            employer_rate_5,
            allamt1,
            allamt2,
            allamt3,
            allamt4,
            allamt5,
            adminfee1,
            adminfee2,
            adminfee3,
            adminfee4,
            adminfee5,
            cpfamt1,
            cpfamt2,
            cpfamt3,
            cpfamt4,
            cpfamt5,
            sdfamt1,
            sdfamt2,
            sdfamt3,
            sdfamt4,
            sdfamt5,
            subtotalamt1,
            subtotalamt2,
            subtotalamt3,
            subtotalamt4,
            subtotalamt5,
            rebateamt1,
            rebateamt2,
            rebateamt3,
            rebateamt4,
            rebateamt5,
            adminfeepamt,
            bonuspayable,
            bonusbillable,
            bonusamt,
            bonusdate,
            awspayable,
            awsbillable,
            awsamt,
            awsdate,
            bonusadmable,
            bonussdfable,
            bonuscpfable,
            bonuswiable,
            awsadmable,
            awssdfable,
            awscpfable,
            awswiable,
            phpayable,
            phbillable,
            phdate,
            <cfloop query="getclaimlist">
            #getclaimlist.wos_group#payable,
            #getclaimlist.wos_group#billable,
            per#getclaimlist.wos_group#claimcap,
            total#getclaimlist.wos_group#claimable,
            #getclaimlist.wos_group#claimdate,
            #getclaimlist.wos_group#claimedamt,
            </cfloop>
            ALbfdays,
            ALtype,
            ALbfable,
            <cfloop query="leavelist">
            #leavelist.costcode#entitle,
            #leavelist.costcode#payable1,
            #leavelist.costcode#billable1,
            #leavelist.costcode#date,
            #leavelist.costcode#days,
            #leavelist.costcode#totaldays,
            #leavelist.costcode#earndays,
            #leavelist.costcode#remarks,
            </cfloop>
            allowancedesp1,
            allowancedesp2,
            allowancedesp3,
            allowanceamt1,
            allowanceamt2,
            allowanceamt3,
            allowancebillable1,
        	allowancebillable2,
            allowancebillable3,
            allowancepayable1,
            allowancepayable2,
            allowancepayable3,
            prorated1,
            prorated2,
            prorated3,
            billableitem1,
            billableitem2,
            billableitem3,
            billableitemamt1,
            billableitemamt2,
            billableitemamt3,
            billableprorated1,
            billableprorated2,
            billableprorated3,
            wd_p_week,
            Montimestart,
            Montimeoff,
            Monbreakhour,
            Montotalhour,
            Monremark,
            Tuestimestart,
            Tuestimeoff,
            Tuesbreakhour,
            Tuestotalhour,
            Tuesremark,
            Wednestimestart,
            Wednestimeoff,
            Wednesbreakhour,
            Wednestotalhour,
            Wednesremark,
            Thurstimestart,
            Thurstimeoff,
            Thursbreakhour,
            Thurstotalhour,
            Thursremark,
            Fritimestart,
            Fritimeoff,
            Fribreakhour,
            Fritotalhour,
            Friremark,
            Saturtimestart,
            Saturtimeoff,
            Saturbreakhour,
            Saturtotalhour,
            Saturremark,
            Suntimestart,
            Suntimeoff,            
            Sunbreakhour,
            Suntotalhour,
            Sunremark,
            <cfloop list="Mon,Tues,Wednes,Thurs,Fri,Satur,Sun" index="i">
       		#i#halfday,
        	</cfloop>
            sps,
            pub_holiday_phpd,
            ann_leav_phpd,
            medic_leav_phpd,
            hosp_leav_phpd,
            aw1,
            aw2,
            aw3,
            supervisor,
            timesheet,
            system42,
            flexw,
            clientrate,
            newrate,
            newtype,
            created_on,
            created_by,
            hrmgr,
            hrmgremail,
            mppic,
            mppicemail,
            mppic2,
            mppicemail2,
            mppicsp,
            mppicspemail
            ,pm
            )
			values 
			('#form.placementno#',
			<cfif form.placementdate eq ''>'0000-00-00'<cfelse>'#placementdate#'</cfif>,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementtype#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.location#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custname#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.contactperson#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.consultant#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billto#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobcode#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.position#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.nric#">,
             <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.iname#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empname#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sex#">,
			<cfif form.startdate eq ''>'0000-00-00'<cfelse>'#startdate#'</cfif>,
			<cfif form.completedate eq ''>'0000-00-00'<cfelse>'#completedate#'</cfif>,
            <cfif form.completedate1 eq ''>'0000-00-00'<cfelse>'#completedate1#'</cfif>,
            <cfif form.completedate2 eq ''>'0000-00-00'<cfelse>'#completedate2#'</cfif>,
            '#form.clienttype#',
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assignmenttype#">,
			<!---<cfif isdefined('getempname.name')><cfqueryparam cfsqltype="cf_sql_varchar" value="#getempname.name#"><cfelse>''</cfif>,--->            
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.po_no#">,
            <cfif form.po_date eq ''>'0000-00-00'<cfelse>'#po_date#'</cfif>,
            <cfqueryparam cfsqltype="cf_sql_double" value="#form.po_amount#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.description1#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.description2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.emp_pay_d#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bill_d#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.approvalType#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.option_to_ext#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.department#">,
            <cfif isdefined('form.refer_by_client')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.inc_bill_cpf')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cpf_amount#">,
            <cfif isdefined('form.inc_bill_sdf')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sdf_amount#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.admin_fee#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.admin_fee_fix_amt#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.admin_f_min_amt#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rebate#">,
            <cfif form.ottable neq ''>
             	<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ottable#">,
             <cfelse>
             	'STANDARD',
             </cfif>
            <cfif isdefined('form.rebate_pro_rate')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>, 
            <cfif form.eff_d_1 eq ''>'0000-00-00'<cfelse>'#eff_d_1#'</cfif>,
            <cfif form.eff_d_2 eq ''>'0000-00-00'<cfelse>'#eff_d_2#'</cfif>,
            <cfif form.eff_d_3 eq ''>'0000-00-00'<cfelse>'#eff_d_3#'</cfif>,
            <cfif form.eff_d_4 eq ''>'0000-00-00'<cfelse>'#eff_d_4#'</cfif>,
            <cfif form.eff_d_5 eq ''>'0000-00-00'<cfelse>'#eff_d_5#'</cfif>,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employee_rate_1#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employee_rate_2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employee_rate_3#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employee_rate_4#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employee_rate_5#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employer_rate_1#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employer_rate_2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employer_rate_3#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employer_rate_4#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employer_rate_5#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allamt1#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allamt2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allamt3#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allamt4#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allamt5#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfee1#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfee2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfee3#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfee4#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfee5#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cpfamt1#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cpfamt2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cpfamt3#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cpfamt4#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cpfamt5#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sdfamt1#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sdfamt2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sdfamt3#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sdfamt4#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sdfamt5#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.subtotalamt1#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.subtotalamt2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.subtotalamt3#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.subtotalamt4#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.subtotalamt5#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rebateamt1#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rebateamt2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rebateamt3#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rebateamt4#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rebateamt5#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfeepamt#">,
            <cfif isdefined('form.bonuspayable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.bonusbillable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bonusamt#">,                                
            <cfif form.bonusdate eq ''>'0000-00-00'<cfelse>'#bonusdate#'</cfif>,
            <cfif isdefined('form.awspayable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.awsbillable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.awsamt#">,
            <cfif form.awsdate eq ''>'0000-00-00'<cfelse>'#awsdate#'</cfif>,
            <cfif isdefined('form.bonusadmable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.bonussdfable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.bonuscpfable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.bonuswiable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.awsadmable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.awssdfable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.awscpfable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.awswiable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.phpayable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.phbillable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif form.phdate eq ''>'0000-00-00'<cfelse>'#phdate#'</cfif>,
            <cfloop query="getclaimlist">
            <cfset payablefield = "Y">
            <cfset billablefield = "Y">
            <cftry>
            <cfset trypayablefield = evaluate('form.#getclaimlist.wos_group#payable') > 
            <cfcatch type="any">
            <cfset payablefield = "N">
            </cfcatch>
            </cftry>
            <cftry>
            <cfset trybillablefield = evaluate('form.#getclaimlist.wos_group#billable') > 
            <cfcatch type="any">
            <cfset billablefield = "N">
            </cfcatch>
            </cftry>
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#payablefield#">,           
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#billablefield#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.per#getclaimlist.wos_group#claimcap')#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.total#getclaimlist.wos_group#claimable')#">,
            <cfif evaluate('form.#getclaimlist.wos_group#claimdate') eq "">"0000-00-00"<cfelse>"#dateformatnew(evaluate('form.#getclaimlist.wos_group#claimdate'),'YYYY-MM-DD')#"</cfif>,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.#getclaimlist.wos_group#claimedamt')#">,
            </cfloop>
          
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ALbfdays#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ALtype#">,
            <cfif isdefined('form.ALbfable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfloop query="leavelist">
             <cfif isdefined('form.#leavelist.costcode#entitle')>
             	<cfqueryparam cfsqltype="cf_sql_varchar" value="Y">
			 <cfelse>
             	<cfqueryparam cfsqltype="cf_sql_varchar" value="N">
			</cfif>,
            <cfif isdefined('form.#leavelist.costcode#payable1')>
             	<cfqueryparam cfsqltype="cf_sql_varchar" value="Y">
			 <cfelse>
             	<cfqueryparam cfsqltype="cf_sql_varchar" value="N">
			</cfif>,
            <cfif isdefined('form.#leavelist.costcode#billable1')>
             	<cfqueryparam cfsqltype="cf_sql_varchar" value="Y">
			 <cfelse>
             	<cfqueryparam cfsqltype="cf_sql_varchar" value="N">
			</cfif>,
            <cfif evaluate('form.#leavelist.costcode#date') eq ''>'0000-00-00'<cfelse>'#dateformatnew(evaluate('form.#leavelist.costcode#date'),"YYYY-MM-DD")#'</cfif>,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.#leavelist.costcode#days')#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.#leavelist.costcode#totaldays')#">,
            <cfif isdefined('form.#leavelist.costcode#earndays')>
            	<cfqueryparam cfsqltype="cf_sql_varchar" value="Y">
			<cfelse>
            	<cfqueryparam cfsqltype="cf_sql_varchar" value="N">
			</cfif>,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.#leavelist.costcode#remarks')#">,
            </cfloop>
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allowancedesp1#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allowancedesp2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allowancedesp3#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allowanceamt1#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allowanceamt2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allowanceamt3#">,
            <cfif isdefined('form.allowancebillable1')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.allowancebillable2')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.allowancebillable3')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.allowancepayable1')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.allowancepayable2')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.allowancepayable3')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
           <cfif isdefined('form.prorated1')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.prorated2')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.prorated3')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billableitem1#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billableitem2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billableitem3#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billableitemamt1#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billableitemamt2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billableitemamt3#">,
            <cfif isdefined('form.billableprorated1')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.billableprorated2')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfif isdefined('form.billableprorated3')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.wd_p_week#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Montimestart#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Montimeoff#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Monbreakhour#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Montotalhour#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Monremark#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Tuestimestart#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Tuestimeoff#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Tuesbreakhour#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Tuestotalhour#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Tuesremark#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Wednestimestart#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Wednestimeoff#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Wednesbreakhour#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Wednestotalhour#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Wednesremark#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Thurstimestart#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Thurstimeoff#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Thursbreakhour#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Thurstotalhour#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Thursremark#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Fritimestart#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Fritimeoff#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Fribreakhour#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Fritotalhour#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Friremark#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Saturtimestart#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Saturtimeoff#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Saturbreakhour#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Saturtotalhour#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Saturremark#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Suntimestart#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Suntimeoff#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Sunbreakhour#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Suntotalhour#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Sunremark#">,
            <cfloop list="Mon,Tues,Wednes,Thurs,Fri,Satur,Sun" index="i">
            <cfif isdefined('form.#i#halfday')>
       		"Y",
            <cfelse>
            "N",
            </cfif>
        	</cfloop>
            <cfif isdefined('form.sps')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,            
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.pub_holiday_phpd#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ann_leav_phpd#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.medic_leav_phpd#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hosp_leav_phpd#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allowance1#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allowance2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allowance3#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.supervisor#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.timesheet#">,
            <cfif isdefined('form.system42')>"Y"<cfelse>"N"</cfif>,
            <cfif isdefined('form.flexw')>"Y"<cfelse>"N"</cfif>
            ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employer_rate_1#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employee_rate_1#">,
            '#form.clienttype#',
            now(),
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hrMgr#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hrMgrEmail#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mpPIC#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mpPICEmail#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mpPIC2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mpPICEmail2#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mpPicSp#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mpPicSpEmail#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.paybill#">
            )
            
            
		</cfquery>
        <cfset dts1 = replace(dts,'_i','_p','All')>


  	<cfset status="The Placement, #form.placementno# had been successfully created. ">
<cfelse>
  	<cfquery datasource='#dts#' name="checkitemExist">
		Select * from Placement where placementno='#form.oriplacementno#'
  	</cfquery>
		
  	<cfif checkitemExist.recordcount GT 0 >
		<cfif form.mode eq "Delete">
      		<cfquery datasource='#dts#' name="deleteitem">
	    		Delete from Placement where placementno='#form.oriplacementno#'
	  		</cfquery>
            <cfset dts1 = replace(dts,'_i','_p','All')>
            <cfquery name="deleteplacement" datasource="#dts1#">
            DELETE FROM payrecord WHERE placement = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.oriplacementno#">
            </cfquery>
	  		<cfset status="The Placement, #form.placementno# had been successfully deleted. ">	
		</cfif>
		<cfif form.mode eq "Edit">

		  		<cfquery datasource='#dts#' name="updatePlacement">
					Update Placement 
					set 
                    placementdate=<cfif form.placementdate eq ''>'0000-00-00'<cfelse>'#placementdate#'</cfif>,
                    placementtype=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementtype#">,
                    location=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.location#">,
                    custno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custno#">,
                    custname=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.custname#">,
                    contactperson=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.contactperson#">,
                    consultant=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.consultant#">,
                    billto=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billto#">,
                    project=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billto#">,
                    jobcode=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.jobcode#">,
                    position=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.position#">,
                    empno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">,
                    nric=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.nric#">,
                    iname=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.iname#">,
                    empname=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empname#">,
                    sex=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sex#">,
                    <!---duration='#form.duration#',--->
					startdate=<cfif form.startdate eq ''>'0000-00-00'<cfelse>'#startdate#'</cfif>,
					completedate=<cfif form.completedate eq ''>'0000-00-00'<cfelse>'#completedate#'</cfif>,
                    completedate1=<cfif form.completedate1 eq ''>'0000-00-00'<cfelse>'#completedate1#'</cfif>,
                    completedate2=<cfif form.completedate2 eq ''>'0000-00-00'<cfelse>'#completedate2#'</cfif>,
                    clienttype='#form.clienttype#',
                    po_no=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.po_no#">,
                    po_date=<cfif form.po_date eq ''>'0000-00-00'<cfelse>'#po_date#'</cfif>,
                    po_amount=<cfqueryparam cfsqltype="cf_sql_double" value="#form.po_amount#">,
                    description1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.description1#">,
                    description2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.description2#">,
                    emp_pay_d=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.emp_pay_d#">,
                    bill_d=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bill_d#">,
                    approvalType=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.approvalType#">,
                    option_to_ext=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.option_to_ext#">,
                    department=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.department#">,
                    department=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.department#">,
                    refer_by_client=<cfif isdefined('form.refer_by_client')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    inc_bill_cpf=<cfif isdefined('form.inc_bill_cpf')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    cpf_amount=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cpf_amount#">,
                    inc_bill_sdf=<cfif isdefined('form.inc_bill_sdf')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    sdf_amount=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sdf_amount#">,
                    admin_fee=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.admin_fee#">,
                    admin_fee_fix_amt=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.admin_fee_fix_amt#">,
                    admin_f_min_amt=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.admin_f_min_amt#">,
                    rebate=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rebate#">,
                    <cfif form.ottable neq ''>
						ottable=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ottable#">,
					<cfelse>
						ottable='STANDARD',
					</cfif>
                    rebate_pro_rate=<cfif isdefined('form.rebate_pro_rate')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    eff_d_1=<cfif form.eff_d_1 eq ''>'0000-00-00'<cfelse>'#eff_d_1#'</cfif>,
                    eff_d_2=<cfif form.eff_d_2 eq ''>'0000-00-00'<cfelse>'#eff_d_2#'</cfif>,
                    eff_d_3=<cfif form.eff_d_3 eq ''>'0000-00-00'<cfelse>'#eff_d_3#'</cfif>,
                    eff_d_4=<cfif form.eff_d_4 eq ''>'0000-00-00'<cfelse>'#eff_d_4#'</cfif>,
                    eff_d_5=<cfif form.eff_d_5 eq ''>'0000-00-00'<cfelse>'#eff_d_5#'</cfif>,
                    employee_rate_1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employee_rate_1#">,
                    employee_rate_2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employee_rate_2#">,
                    employee_rate_3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employee_rate_3#">,
                    employee_rate_4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employee_rate_4#">,
                    employee_rate_5=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employee_rate_5#">,
                    employer_rate_1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employer_rate_1#">,
                    employer_rate_2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employer_rate_2#">,
                    employer_rate_3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employer_rate_3#">,
                    employer_rate_4=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employer_rate_4#">,
                    employer_rate_5=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employer_rate_5#">,
                    allamt1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allamt1#">,
                    allamt2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allamt2#">,
                    allamt3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allamt3#">,
                    allamt4 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allamt4#">,
                    allamt5 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allamt5#">,
                    adminfee1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfee1#">,
                    adminfee2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfee2#">,
                    adminfee3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfee3#">,
                    adminfee4 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfee4#">,
                    adminfee5 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfee5#">,
                    cpfamt1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cpfamt1#">,
                    cpfamt2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cpfamt2#">,
                    cpfamt3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cpfamt3#">,
                    cpfamt4 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cpfamt4#">,
                    cpfamt5 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cpfamt5#">,
                    sdfamt1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sdfamt1#">,
                    sdfamt2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sdfamt2#">,
                    sdfamt3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sdfamt3#">,
                    sdfamt4 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sdfamt4#">,
                    sdfamt5 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sdfamt5#">,
                    subtotalamt1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.subtotalamt1#">,
            subtotalamt2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.subtotalamt2#">,
            subtotalamt3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.subtotalamt3#">,
           subtotalamt4 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.subtotalamt4#">,
            subtotalamt5 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.subtotalamt5#">,
            rebateamt1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rebateamt1#">,
            rebateamt2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rebateamt2#">,
            rebateamt3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rebateamt3#">,
            rebateamt4 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rebateamt4#">,
            rebateamt5 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.rebateamt5#">,
            adminfeepamt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.adminfeepamt#">,
                    bonusbillable=<cfif isdefined('form.bonusbillable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    bonusamt=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.bonusamt#">,
                    
                    bonuspayable=<cfif isdefined('form.bonuspayable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    bonusdate=<cfif form.bonusdate eq ''>'0000-00-00'<cfelse>'#bonusdate#'</cfif>,
                    awspayable=<cfif isdefined('form.awspayable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    awsbillable=<cfif isdefined('form.awsbillable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    awsamt=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.awsamt#">,
                    awsdate=<cfif form.awsdate eq ''>'0000-00-00'<cfelse>'#awsdate#'</cfif>,
                    bonusadmable=<cfif isdefined('form.bonusadmable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    bonussdfable=<cfif isdefined('form.bonussdfable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    bonuscpfable=<cfif isdefined('form.bonuscpfable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    bonuswiable=<cfif isdefined('form.bonuswiable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    awsadmable=<cfif isdefined('form.awsadmable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    awssdfable=<cfif isdefined('form.awssdfable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    awscpfable=<cfif isdefined('form.awscpfable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    awswiable=<cfif isdefined('form.awswiable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                      <cfloop query="getclaimlist">
                      <cfset payablefield = "Y">
						<cfset billablefield = "Y">
                        <cftry>
                        <cfset trypayablefield = evaluate('form.#getclaimlist.wos_group#payable') > 
                        <cfcatch type="any">
                        <cfset payablefield = "N">
                        </cfcatch>
                        </cftry>
                        <cftry>
                        <cfset trybillablefield = evaluate('form.#getclaimlist.wos_group#billable') > 
                        <cfcatch type="any">
                        <cfset billablefield = "N">
                        </cfcatch>
                        </cftry>
                        #getclaimlist.wos_group#payable =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#payablefield#">,           
                       #getclaimlist.wos_group#billable =  <cfqueryparam cfsqltype="cf_sql_varchar" value="#billablefield#">,

                        per#getclaimlist.wos_group#claimcap = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.per#getclaimlist.wos_group#claimcap')#">,
                        total#getclaimlist.wos_group#claimable = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.total#getclaimlist.wos_group#claimable')#">,
                        #getclaimlist.wos_group#claimdate = <cfif evaluate('form.#getclaimlist.wos_group#claimdate') eq "">"0000-00-00"<cfelse>"#dateformatnew(evaluate('form.#getclaimlist.wos_group#claimdate'),'YYYY-MM-DD')#"</cfif>,
                        #getclaimlist.wos_group#claimedamt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.#getclaimlist.wos_group#claimedamt')#">,
                        </cfloop>
                   
                    ALbfdays=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ALbfdays#">,
                    ALtype=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ALtype#">,
                    ALbfable=<cfif isdefined('form.ALbfable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    <cfloop query="leavelist">
                     #leavelist.costcode#entitle = <cfif isdefined('form.#leavelist.costcode#entitle')>
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="Y">
                     <cfelse>
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="N">
                    </cfif>,
                     #leavelist.costcode#billable1 = <cfif isdefined('form.#leavelist.costcode#billable1')>
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="Y">
                     <cfelse>
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="N">
                    </cfif>,
                     #leavelist.costcode#payable1 = <cfif isdefined('form.#leavelist.costcode#payable1')>
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="Y">
                     <cfelse>
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="N">
                    </cfif>,
                    #leavelist.costcode#date = <cfif evaluate('form.#leavelist.costcode#date') eq ''>'0000-00-00'<cfelse>'#dateformatnew(evaluate('form.#leavelist.costcode#date'),"YYYY-MM-DD")#'</cfif>,
                    #leavelist.costcode#days = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.#leavelist.costcode#days')#">,
                    #leavelist.costcode#totaldays = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.#leavelist.costcode#totaldays')#">,
                   #leavelist.costcode#earndays =  <cfif isdefined('form.#leavelist.costcode#earndays')>
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="Y">
                    <cfelse>
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="N">
                    </cfif>,
                    #leavelist.costcode#remarks = <cfqueryparam cfsqltype="cf_sql_varchar" value="#evaluate('form.#leavelist.costcode#remarks')#">,
                    </cfloop>
                    allowancedesp1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allowancedesp1#">,
                    allowancedesp2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allowancedesp2#">,
                    allowancedesp3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allowancedesp3#">,
                    allowanceamt1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allowanceamt1#">,
                    allowanceamt2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allowanceamt2#">,
                    allowanceamt3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allowanceamt3#">,
                    allowancebillable1 = <cfif isdefined('form.allowancebillable1')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            allowancebillable2 = <cfif isdefined('form.allowancebillable2')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            allowancebillable3 = <cfif isdefined('form.allowancebillable3')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            allowancepayable1 = <cfif isdefined('form.allowancepayable1')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            allowancepayable2 = <cfif isdefined('form.allowancepayable2')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
            allowancepayable3 = <cfif isdefined('form.allowancepayable3')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    prorated1=<cfif isdefined('form.prorated1')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    prorated2=<cfif isdefined('form.prorated2')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    prorated3=<cfif isdefined('form.prorated3')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    billableitem1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billableitem1#">,
                    billableitem2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billableitem2#">,
                    billableitem3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billableitem3#">,
                    billableitemamt1=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billableitemamt1#">,
                    billableitemamt2=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billableitemamt2#">,
                    billableitemamt3=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billableitemamt3#">,
                    billableprorated1=<cfif isdefined('form.billableprorated1')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    billableprorated2=<cfif isdefined('form.billableprorated2')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    billableprorated3=<cfif isdefined('form.billableprorated3')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    wd_p_week=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.wd_p_week#">,
                    Montimestart=<cfif form.Montimestart eq ''>'00:00:00'<cfelse>'#Montimestart#'</cfif>,
                    Montimeoff=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Montimeoff#">,
                    Monbreakhour=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Monbreakhour#">,
                    Montotalhour=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Montotalhour#">,
                    Monremark=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Monremark#">,
                    Tuestimestart=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Tuestimestart#">,
                    Tuestimeoff=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Tuestimeoff#">,
                    Tuesbreakhour=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Tuesbreakhour#">,
                    Tuestotalhour=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Tuestotalhour#">,
                    Tuesremark=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Tuesremark#">,
                    Wednestimestart=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Wednestimestart#">,
                    Wednestimeoff=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Wednestimeoff#">,
                    Wednesbreakhour=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Wednesbreakhour#">,
                    Wednestotalhour=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Wednestotalhour#">,
                    Wednesremark=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Wednesremark#">,
                    Thurstimestart=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Thurstimestart#">,
                    Thurstimeoff=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Thurstimeoff#">,
                    Thursbreakhour=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Thursbreakhour#">,
                    Thurstotalhour=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Thurstotalhour#">,
                    Thursremark=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Thursremark#">,
                    Fritimestart=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Fritimestart#">,
                    Fritimeoff=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Fritimeoff#">,
                    Fribreakhour=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Fribreakhour#">,
                    Fritotalhour=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Fritotalhour#">,
                    Friremark=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Friremark#">,
                    Saturtimestart=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Saturtimestart#">,
                    Saturtimeoff=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Saturtimeoff#">,
                    Saturbreakhour=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Saturbreakhour#">,
                    Saturtotalhour=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Saturtotalhour#">,
                    Saturremark=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Saturremark#">,
                    Suntimestart=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Suntimestart#">,
                    Suntimeoff=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Suntimeoff#">,
                    Sunbreakhour=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Sunbreakhour#">,
                    Suntotalhour=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Suntotalhour#">,
                    Sunremark=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Sunremark#">,
                    <cfloop list="Mon,Tues,Wednes,Thurs,Fri,Satur,Sun" index="i">
					<cfif isdefined('form.#i#halfday')>
                    #i#halfday = "Y",
                    <cfelse>
                    #i#halfday = "N",
                    </cfif>
                    </cfloop>
                    sps=<cfif isdefined('form.sps')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    pub_holiday_phpd=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.pub_holiday_phpd#">,
                    ann_leav_phpd=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.ann_leav_phpd#">,
                    medic_leav_phpd=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.medic_leav_phpd#">,
                    hosp_leav_phpd=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.medic_leav_phpd#">,
                    phpayable=<cfif isdefined('form.phpayable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    phbillable=<cfif isdefined('form.phbillable')><cfqueryparam cfsqltype="cf_sql_varchar" value="Y"><cfelse><cfqueryparam cfsqltype="cf_sql_varchar" value="N"></cfif>,
                    phdate=<cfif form.phdate eq ''>'0000-00-00'<cfelse>'#phdate#'</cfif>,
                    
                    
                    
                    
                    
                    updated_by=<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">,
                    updated_on=now(),
                    assignmenttype=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.assignmenttype#">
                    <cfif isdefined('getempname.name')>,empname=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getempname.name#"></cfif>
                    
            ,aw1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allowance1#">
            ,aw2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allowance2#">
            ,aw3 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.allowance3#">
            ,placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementno#">,
            supervisor = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.supervisor#">,
            timesheet = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.timesheet#">,
            system42 = <cfif isdefined('form.system42')>"Y"<cfelse>"N"</cfif>,
            flexw = <cfif isdefined('form.flexw')>"Y"<cfelse>"N"</cfif>,
                clientrate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employer_rate_1#">,
                newrate = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.employee_rate_1#">,
            newtype = '#form.clienttype#',
            	hrmgr = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hrMgr#">,
                hrmgremail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.hrMgrEmail#">,
                mppic = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mpPIC#">,
                mppicemail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mpPICEmail#">,
                mppic2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mpPIC2#">,
                mppicemail2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mpPICEmail2#">,
                mppicsp = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mpPicSp#">,
                mppicspemail = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.mpPicSpEmail#"> ,
            pm = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.paybill#"> 
					where placementno = '#form.oriplacementno#'
		  		</cfquery>
                 <cfset dts1 = replace(dts,'_i','_p','All')>
                <cfquery name="updateplacement" datasource="#dts1#">
                Update payrecord SET
                empno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno##form.placementno#">,
                month=<cfif form.startdate eq ''>''<cfelse>"#dateformat(startdate,'m')#"</cfif>,
                year=<cfif form.startdate eq ''>''<cfelse>"#dateformat(startdate,'yyyy')#"</cfif>,
                realempno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empno#">,
                placement = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.placementno#">
                </cfquery>
                
	  		<cfset status="The Placement, #form.placementno# had been successfully edited. ">
		</cfif>
  	<cfelse>		
		<cfset status="Sorry, the Placement, #form.placementno# was ALREADY removed from the system. Process unsuccessful.">
  	</cfif>
</cfif>
<cfoutput>

<form name="done" action="s_Placementtable.cfm?type=Placement&process=done" method="post">
  <input name="status" value="#status#" type="hidden">
</form>
</cfoutput>

<script>
	done.submit();
</script>