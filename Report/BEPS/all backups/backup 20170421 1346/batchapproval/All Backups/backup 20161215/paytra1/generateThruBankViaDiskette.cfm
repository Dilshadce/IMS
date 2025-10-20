<cfset dts = replace(dts,'_i','_p')>
<cfset hcomid = replace(dts,'_p','')>
<cfset DTS_MAIN = "payroll_main">
<cfif left(dts,8) eq "manpower">
<cfif isdefined('form.batch') eq false>
<cfoutput>
<script type="text/javascript">
alert('Please Choose At Least One Batch!');
window.close();
</script>
</cfoutput>
<cfabort>
</cfif>
</cfif>
<!--- <cftry> --->
<cfquery name="acBank_qry" datasource="#dts#">
SELECT * FROM address a WHERE org_type in ('BANK') AND category="#form.category#"
</cfquery>

<cfquery name="aps_qry" datasource="#dts#">
SELECT * FROM aps_set where entryno= "#form.aps_num2#"
</cfquery>
<cfif left(dts,8) eq "manpower">
<cfif form.batch neq ''>
<cfquery name="getempnolist" datasource="#replace(dts,'_p','_i')#">
SELECT empno FROM assignmentslip WHERE batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batch#" list="yes" separator=",">)
</cfquery>
</cfif>
<cfquery name="company_details" datasource="#dts_main#">
SELECT mmonth,myear FROM gsetup WHERE comp_id = "#HcomID#"
</cfquery>

</cfif>
<cfquery name="getpaytra1_qry" datasource="#dts#">
SELECT * FROM paytra1 as c left join pmast as p on c.empno = p.empno
<cfif left(dts,8) eq "manpower">
LEFT JOIN
(
select empno as aemp,sum(if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0)) as totalamtnew,sum(coalesce(ded1,0)+coalesce(ded2,0)+coalesce(ded3,0)) as totalded from #replace(dts,'_p','_i')#.assignmentslip where month(assignmentslipdate) = "#company_details.mmonth#" and year(assignmentslipdate) = "#company_details.myear#" and paydate = "paytra1"
 group by empno
) as d
on c.empno = d.aemp
</cfif>
 where c.netpay <> "0" 
and p.bankaccno <> "" and paymeth ="B" and p.bankcat = "#acBank_qry.category#" 
and c.payyes = "y"
<cfif left(dts,8) eq "manpower">
<cfif form.batch neq ''>
<cfif getempnolist.recordcount neq 0>
and p.empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getempnolist.empno)#" list="yes" separator=",">)
</cfif>
</cfif>
</cfif>
<cfif form.confid neq "">
and p.confid = "#form.confid#" 
</cfif>
<cfif form.empnofrom neq "" and form.empnoto neq "">
and p.empno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empnofrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empnoto#">
</cfif>
<cfif form.catefrom neq "" and form.cateto neq "">
and p.category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.catefrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cateto#">
</cfif>
<cfif form.deptfrom neq "" and form.deptto neq "">
and p.deptcode between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.deptfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.deptto#">
</cfif>

order by 
	<cfif form.Order_By eq "E">
		p.empno
	<cfelseif form.Order_By eq "C">
		p.category
	<cfelseif form.Order_By eq "D">
		p.deptcode
	<cfelseif form.Order_By eq "L">
		p.plineno
	<cfelse>
		p.name
	</cfif>	
	
</cfquery>
<!--- modification for generate SCB iPayment CSV Start --->
<cfif form.category EQ 10>
	<cfset uuid=CreateUUID()>
	<cfobject component="SCBiPaymentCSV" name="ipaymentobject">
	<cfloop query="getpaytra1_qry">
		<cfinvoke component="#ipaymentobject#" method="insertPayment" returnvariable="pid">
			<cfinvokeargument name="dts" value="#dts#">
			<cfinvokeargument name="uuid" value="#uuid#">
			<cfinvokeargument name="precordtype" value="P">
			<cfinvokeargument name="ppaymenttype" value="PAY">
			<cfinvokeargument name="pprocessingmode" value="BA">
			<!--- <cfinvokeargument name="pservicetype" value="">
			<cfinvokeargument name="pcustomerreference" value="">
			<cfinvokeargument name="pcustomermemo" value=""> --->
			<cfinvokeargument name="pdebitaccountrycode" value="SG">
			<cfinvokeargument name="pdebitaccitycode" value="SIN">
			<cfinvokeargument name="pdebitacno" value="#bankaccno#">
			<cfinvokeargument name="pvaluedate" value="#form.cdate#">
			<cfinvokeargument name="pbeneficiaryname" value="#name#">
			<!--- <cfinvokeargument name="pbeneficiaryaddress1" value="">
			<cfinvokeargument name="pbeneficiaryaddress2" value="">
			<cfinvokeargument name="pbeneficiaryaddress3" value="">
			<cfinvokeargument name="pbeneficiaryfaxno" value=""> --->
			<cfinvokeargument name="pbeneficiarybankcode" value="#bankcode#">
			<cfinvokeargument name="pbeneficiarylocalclearingbankcode" value="#bankcode#">
			<cfinvokeargument name="pbeneficiarylocalclearingbranchcode" value="#brancode#">
			<cfinvokeargument name="pbeneficiarybranchsubcode" value="#brancode#">
			<cfinvokeargument name="pbeneficiaryacno" value="#bankaccno#">
			<!--- <cfinvokeargument name="ppaymentdetails1" value="">
			<cfinvokeargument name="ppaymentdetails2" value="">
			<cfinvokeargument name="pvatamount" value="">
			<cfinvokeargument name="pwhtprintinglocation" value="">
			<cfinvokeargument name="pwhtformid" value="">
			<cfinvokeargument name="pwhttaxid" value="">
			<cfinvokeargument name="pwhtrefno" value="">
			<cfinvokeargument name="pwhttype1" value="">
			<cfinvokeargument name="pwhtdescription1" value="">
			<cfinvokeargument name="pwhtgrossamount1" value="">
			<cfinvokeargument name="pwhtamount1" value="">
			<cfinvokeargument name="pwhttype2" value="">
			<cfinvokeargument name="pwhtdescription2" value="">
			<cfinvokeargument name="pwhtgrossamount2" value="">
			<cfinvokeargument name="pwhtamount2" value="">
			<cfinvokeargument name="pdiscountamount" value="">
			<cfinvokeargument name="pinvoiceformat" value=""> --->
			<cfinvokeargument name="ppaymentcurrency" value="SGD">
			<cfinvokeargument name="pinvoiceamount" value="#netpay#">
			<cfinvokeargument name="plocalchargeto" value="C">
			<!--- <cfinvokeargument name="poverseaschargeto" value="">
			<cfinvokeargument name="pintermediarybankcode" value="">
			<cfinvokeargument name="pclearingcodefortt" value="">
			<cfinvokeargument name="pclearingzonecodeforlbc" value="">
			<cfinvokeargument name="pdraweebankcodeforibc" value="">
			<cfinvokeargument name="pdeliverymethod" value="">
			<cfinvokeargument name="pdeliverto" value="">
			<cfinvokeargument name="pcounterpickuplocation" value="">
			<cfinvokeargument name="pfxtype" value="">
			<cfinvokeargument name="pbeneficiaryname1inll" value="">
			<cfinvokeargument name="pbeneficiaryname2inll" value="">
			<cfinvokeargument name="pbeneficiaryaddress1inll" value="">
			<cfinvokeargument name="pbeneficiaryaddress2inll" value="">
			<cfinvokeargument name="pbeneficiaryaddress3inll" value="">
			<cfinvokeargument name="pbeneficiaryaddress4inll" value="">
			<cfinvokeargument name="ppaymentdetail1inll" value="">
			<cfinvokeargument name="ppaymentdetail2inll" value="">
			<cfinvokeargument name="pvattype" value="">
			<cfinvokeargument name="pdiscounttype" value="">
			<cfinvokeargument name="pdebitcurrency" value=""> --->
			<cfinvokeargument name="pdebitbankid" value="#bankcode#">
			<!--- <cfinvokeargument name="pbeneficiaryemailid" value="">
			<cfinvokeargument name="pchequeno" value="">
			<cfinvokeargument name="pchequeissueddate" value="">
			<cfinvokeargument name="pcorporatechequeno" value="">
			<cfinvokeargument name="pexternalmemo" value="">
			<cfinvokeargument name="pmailingaddress1" value="">
			<cfinvokeargument name="pmailingaddress2" value="">
			<cfinvokeargument name="pmailingaddress3" value="">
			<cfinvokeargument name="pmailingaddress4" value="">
			<cfinvokeargument name="ptransactioncode" value="">
			<cfinvokeargument name="pcustominvoiceheader1" value="">
			<cfinvokeargument name="pcustominvoicecolumnalignment1" value="">
			<cfinvokeargument name="pcustominvoicecolumnlength1" value="">
			<cfinvokeargument name="pcustominvoiceheader2" value="">
			<cfinvokeargument name="pcustominvoicecolumnalignment2" value="">
			<cfinvokeargument name="pcustominvoicecolumnlength2" value="">
			<cfinvokeargument name="pcustominvoiceheader3" value="">
			<cfinvokeargument name="pcustominvoicecolumnalignment3" value="">
			<cfinvokeargument name="pcustominvoicecolumnlength3" value="">
			<cfinvokeargument name="pcustominvoiceheader4" value="">
			<cfinvokeargument name="pcustominvoicecolumnalignment4" value="">
			<cfinvokeargument name="pcustominvoicecolumnlength4" value="">
			<cfinvokeargument name="pcustominvoiceheader5" value="">
			<cfinvokeargument name="pcustominvoicecolumnalignment5" value="">
			<cfinvokeargument name="pcustominvoicecolumnlength5" value="">
			<cfinvokeargument name="pcustominvoiceheader6" value="">
			<cfinvokeargument name="pcustominvoicecolumnalignment6" value="">
			<cfinvokeargument name="pcustominvoicecolumnlength6" value="">
			<cfinvokeargument name="pcustominvoiceheader7" value="">
			<cfinvokeargument name="pcustominvoicecolumnalignment7" value="">
			<cfinvokeargument name="pcustominvoicecolumnlength7" value="">
			<cfinvokeargument name="pcustominvoiceheader8" value="">
			<cfinvokeargument name="pcustominvoicecolumnalignment8" value="">
			<cfinvokeargument name="pcustominvoicecolumnlength8" value="">
			<cfinvokeargument name="pcustominvoiceheader9" value="">
			<cfinvokeargument name="pcustominvoicecolumnalignment9" value="">
			<cfinvokeargument name="pcustominvoicecolumnlength9" value="">
			<cfinvokeargument name="pdeliveryoption" value="">
			<cfinvokeargument name="ptransactionid" value="">
			<cfinvokeargument name="preceiverid" value="">
			<cfinvokeargument name="preceiveridtype" value="">
			<cfinvokeargument name="pcustomername" value="">
			<cfinvokeargument name="plistedcompanycode" value="">
			<cfinvokeargument name="ppaysubproducttype" value=""> --->
			<cfinvokeargument name="created_by" value="#getAuthUser()#">
			<cfinvokeargument name="updated_by" value="#getAuthUser()#">    
		</cfinvoke>
	</cfloop>
	<cfinclude template="generate_SCB_iPayment_CSV_Type_A.cfm">
<cfelse>
<!--- modification for generate SCB iPayment CSV End --->
<!--- Original Code Start --->
<cfset filenewdir = "C:\Inetpub\wwwroot\payroll\download\#dts#\">
			<cfif DirectoryExists(filenewdir) eq false>
            <cfdirectory action = "create" directory = "#filenewdir#" >
            </cfif>
            <cfset filedir = filenewdir&"file"&huserid&".txt">
<cffunction name="DTOC" access="remote" returntype="string">
			        <cfargument name="rdate" type="string" required="no">
			        	<cfset rdate1 = #dateformat(rdate,'yyyymmdd')#>
					<cfreturn rdate1>		
				
			</cffunction>
              <cffunction name="SPACE" returntype="string">
	        <cfargument name="value1" type="numeric" required="yes">
			<cfset reval="">
	         	<cfloop from="1" to="#value1#" index="i">
					<cfset reval = reval&" ">
				</cfloop>
			<cfreturn reval>
	    </cffunction> 
        
         <cffunction name="SS" returntype="string">
	        <cfargument name="desp" type="any" required="yes">
            <cfargument name="nolength" type="numeric" required="yes">
			<cfset reval=mid(desp,nolength,1)>
	        <cfif reval eq " ">
            <cfset reval = 0>
			</cfif>
			<cfreturn reval>
	    </cffunction>             
<cfif aps_qry.entryno eq "23" >
			<cfset total_record_count = 0 >
			
			
			<!--- header --->
			
			
			
			
	<cfif #form.aps_num2# neq 0>
			
			<cfset batchhead_for = #aps_qry.BTREC1#>
			<cfset batchhead_for = Replace(batchhead_for,"+","&","all") >
			
			
			<cfif acBank_qry.org_code neq "">
			<cfif len(#acBank_qry.org_code#) eq aps_qry.orbankl>
				<cfset OR_BANK = #acBank_qry.org_code#>
                <cfelseif val(aps_qry.orbankl) eq 0>
        	<cfset OR_BANK = ''>
             <cfelseif len(#acBank_qry.org_code#) lt  aps_qry.orbankl>
				<cfoutput>
                <h1>Organization Code is Invalid!</h1>
                </cfoutput>
                <cfabort>
            <cfelse>
				<cfset OR_BANK = left(acBank_qry.org_code,val(aps_qry.orbankl))>
			</cfif>
			</cfif>
			
			<cfif acBank_qry.bran_code neq "">
				<cfif len(#acBank_qry.bran_code#) eq aps_qry.orbranl>
					<cfset OR_BRAN = #acBank_qry.bran_code#>
				</cfif>
			</cfif>
			
			
			<cfif acBank_qry.com_accno neq "" and len(acBank_qry.com_accno)lte #aps_qry.oraccnol#-1>
				<cfset OR_ACCNO = "0"&#acBank_qry.com_accno#>
				<cfset OR_ACCNO = Replace(OR_ACCNO,"-","","all")>
			
				<cfloop condition="len(OR_ACCNO) lt #aps_qry.oraccnol#">
					<cfset OR_ACCNO = OR_ACCNO&" " >
				</cfloop>
			</cfif>
			
			<cfif acBank_qry.com_name neq "">
				<cfset OR_NAME =#acBank_qry.com_name#>
                <cfif len(OR_NAME) gt aps_qry.ornamel and val(aps_qry.ornamel) neq 0>
                <cfset OR_NAME = left(OR_NAME,val(aps_qry.ornamel))>
				</cfif>
				<cfloop condition="len(OR_NAME) lt #aps_qry.ornamel#">
					<cfset OR_NAME = OR_NAME&" " >
				</cfloop> 
                <cfif len(or_name) gt aps_qry.ornamel>
            <cfset or_name = left(or_name,aps_qry.ornamel)>
			</cfif>
			</cfif>
			
			<!--- Validate create date --->
			<cfset GENDATE = now()>
			
			<cfset VALUEDATE = #DateAdd('w', -1, form.cdate)#>
			
			<cfset HASH_I ="2">
            <cfif aps_qry.RCHASH1 neq 0>
            <!--- <cfset RCHASH1 = Replace(aps_qry.RCHASH1,"+","","all") > --->
            <cfset RCHASH1 = evaluate('#aps_qry.RCHASH1#')>
            
            <cfelse>
            <cfset RCHASH1 = aps_qry.RCHASH1>
            </cfif>
			
			
			<cfset batchhead_data = #evaluate('#batchhead_for#')#>
			<cfoutput>#batchhead_data#</cfoutput>
			
			<cfset header = "#batchhead_data#">
			<cfloop condition="len(header) lt #aps_qry.aps_size#">
				<cfset header = header&" " >
			</cfloop>
			
			<cffile action = "write" 
					file = "#filedir#" 
					output = "#header#" nameconflict="overwrite">
			
			<!--- end batch header --->
			<!--- start batch detail --->
		<cfset RC_BANK = 0>
		<cfset RC_BRAN = 0>
		<cfset RC_ACCNO =0>
		<cfset RC_NAME = 0>
		<cfset RC_AMT = 0>
		<cfset SUMRCHASH2 = 0>
        
		<cfloop query="getpaytra1_qry">
		
			<cfset batchdetail_for = #aps_qry.RCREC1#>
			<cfset batchdetail_for = Replace(batchdetail_for,"+","&","all") >
			
			<!--- <cfoutput><br>#aps_qry.rcbankl#</cfoutput> --->
			<cfif getpaytra1_qry.bankcode neq "" >
				<cfif len(getpaytra1_qry.bankcode) eq aps_qry.rcbankl>
					<cfset RC_BANK = #getpaytra1_qry.bankcode#>
				</cfif>
			</cfif>
			
			<cfif getpaytra1_qry.brancode neq "">
				<cfif len(getpaytra1_qry.brancode) eq aps_qry.rcbranl>
					<cfset RC_BRAN = #getpaytra1_qry.brancode#>
				</cfif>
			</cfif>
						
			<cfset RC_ACCNO = #getpaytra1_qry.bankaccno#>
			<cfset RC_ACCNO = Replace(RC_ACCNO,"-","","all")>
			<cfloop condition="len(RC_ACCNO) lt #aps_qry.rcaccnol#">
				<cfset RC_ACCNO = RC_ACCNO &" ">
			</cfloop>
			
			<cfif getpaytra1_qry.name neq "">
				<cfset RC_NAME = #getpaytra1_qry.name#>
				<cfif len(RC_NAME) lt #aps_qry.rcnamel#>
					<cfloop condition="len(RC_NAME) lt #aps_qry.rcnamel#">
						<cfset RC_NAME = RC_NAME &" ">
					</cfloop>
				<cfelse>
					<cfset RC_NAME = Left(getpaytra1_qry.name, aps_qry.rcnamel)>
				</cfif>
			</cfif>
			
			<cfif left(dts,8) eq "manpower">
            <cfset nett = (val(getpaytra1_qry.netpay)+numberformat(getpaytra1_qry.totalamtnew,'.__')-numberformat(getpaytra1_qry.totalded,'.__')) * 100>
            <cfelse>
			<cfset nett = #val(getpaytra1_qry.netpay)# * 100>
            </cfif>
			<cfset var1 = "0">
			<cfloop condition="len(var1) lt #aps_qry.rcamtl#">
					<cfset var1 = var1 &"0">
			</cfloop>
			<cfset RC_AMT = #numberformat(nett,var1)#>
				
			
			<cfset batchdetail_data = #evaluate('#batchdetail_for#')#>
            <cfoutput>
            <cfif RC_BANK neq 0
					and RC_BRAN neq 0
					and RC_ACCNO neq 0
					and RC_NAME neq 0
					and RC_AMT neq 0>
                    <cfelse>
           EMPNO - #getPaytra1_qry.empno#<br/> 
           BANK CODE - #rc_bank#<br/>
           BRANCH CODE - #RC_BRAN#<br/>
           ACCNO - #RC_ACCNO#<br/>
           NAME - #RC_NAME#<br />
		   PAY AMT - #RC_AMT#<br/>
           (0 indicate problem field)
			</cfif>
			</cfoutput>
            <cfoutput>
            <cfif RC_BANK neq 0
					and RC_BRAN neq 0
					and RC_ACCNO neq 0
					and RC_NAME neq 0
					and RC_AMT neq 0>
                    <cfelse>
           EMPNO - #getPaytra1_qry.empno#<br/> 
           BANK CODE - #rc_bank#<br/>
           BRANCH CODE - #RC_BRAN#<br/>
           ACCNO - #RC_ACCNO#<br/>
           NAME - #RC_NAME#<br />
		   PAY AMT - #RC_AMT#<br/>
           (0 indicate problem field)
			</cfif>
			</cfoutput>
			<cfif RC_BANK neq 0
					and RC_BRAN neq 0
					and RC_ACCNO neq 0
					and RC_NAME neq 0
					and RC_AMT neq 0>
			<!--- <cfoutput>#batchdetail_data#</cfoutput><br> --->
            
            <cfif aps_qry.RCHASH2 neq 0>
<!---             <cfset RCHASH2 = Replace(aps_qry.RCHASH2,"+","","all") > --->
            <cfset RCHASH2 = evaluate('#aps_qry.RCHASH2#')>
            <cfset SUMRCHASH2 = SUMRCHASH2 + val(RCHASH2)>
            <cfelse>
            <cfset RCHASH2 = aps_qry.RCHASH2>
            </cfif>
			
				<cfset content ="#batchdetail_data#">
				<cfloop condition="len(content) lt #aps_qry.aps_size#">
					<cfset content = content&" " >
				</cfloop>
			
			<cffile action="append" addnewline="yes" 
			   file = "#filedir#"
			   output = "#content#"> 
			<cfset total_record_count = total_record_count + 1> 
			<cfelse>
            <cfoutput>
				<font color="red"><th>Data Imcompletion Found.<br/>Please Click <input type="button" name="checkimcomplete" value="Here" onclick="window.location.href='/payments/checkincomplete.cfm?paytype=1&bankcat=#acBank_qry.category#'"  /> To Check<th></font> 
                </cfoutput>
				
                <cfabort>
			</cfif>
		</cfloop>
			
			<!--- end batch detail --->
			<!--- start batch trailer --->
			<cfset batchtrailer_for = #aps_qry.FFREC1#>
			<cfset batchtrailer_for = Replace(batchtrailer_for,"+","&","all") >
			
			<cfquery name="sum_netpay" datasource="#dts#">
				SELECT <cfif left(dts,8) eq "manpower">sum(c.netpay)+sum(round(d.totalamtnew+0.00000001,2))-sum(round(d.totalded+0.00000001,2))<cfelse>sum(netpay)</cfif> as sumnetpay FROM paytra1 as c left join pmast as p on c.empno = p.empno 
                <cfif left(dts,8) eq "manpower">
LEFT JOIN
(
select empno as aemp,sum(if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0)) as totalamtnew,sum(coalesce(ded1,0)+coalesce(ded2,0)+coalesce(ded3,0)) as totalded from #replace(dts,'_p','_i')#.assignmentslip where month(assignmentslipdate) = "#company_details.mmonth#" and year(assignmentslipdate) = "#company_details.myear#" and paydate = "paytra1"
 group by empno
) as d
on c.empno = d.aemp
</cfif>
				where c.netpay <> "0" and p.bankaccno <> "" and paymeth ="B" and p.bankcat = "#acBank_qry.category#" 
				<cfif left(dts,8) eq "manpower">
<cfif form.batch neq ''>
<cfif getempnolist.recordcount neq 0>
and p.empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getempnolist.empno)#" list="yes" separator=",">)
</cfif>
</cfif>
</cfif>
				<cfif form.confid neq "">
and p.confid = "#form.confid#" 
</cfif>
<cfif form.empnofrom neq "" and form.empnoto neq "">
and p.empno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empnofrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empnoto#">
</cfif>
<cfif form.catefrom neq "" and form.cateto neq "">
and p.category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.catefrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cateto#">
</cfif>
<cfif form.deptfrom neq "" and form.deptto neq "">
and p.deptcode between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.deptfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.deptto#">
</cfif>
				and c.payyes = "y"
			</cfquery>
			<cfset sumNetpay = val(sum_netpay.sumnetpay) * 100>
			<cfset var1 = "0">
			<cfloop condition="len(var1) lt #aps_qry.ffamtl#">
					<cfset var1 = var1 &"0">
			</cfloop>
			<cfset FF_AMT = #numberformat(val(sumNetpay),var1)#>
			
			<cfset var1 = "0">
			<cfloop condition="len(var1) lt #aps_qry.ffiteml#">
					<cfset var1 = var1 &"0">
			</cfloop>
			<cfset FF_ITEM = #numberformat(val(total_record_count),var1)#>
			<cfif aps_qry.RCHASH neq 0>
            <cfset FF_HASH = evaluate('#aps_qry.RCHASH#')>
            <cfloop condition="len(FF_HASH) lt 13">
					<cfset FF_HASH = "0"&FF_HASH>
			</cfloop>
			<cfelse>
			<cfset FF_HASH = "             ">
			</cfif>
			
			
			
			<cfset batchtrailer_data = #evaluate('#batchtrailer_for#')# >
			<cfoutput>#batchtrailer_data#</cfoutput><br>
			
			<cfset footer ="#batchtrailer_data#">
			<cfloop condition="len(footer) lt #aps_qry.aps_size#">
			<cfset footer = footer&" " >
			</cfloop>
			
			<cffile action="append" addnewline="yes" 
			   file = "#filedir#"
			   output = "#footer#"> 
			<cfset total_record_count = total_record_count + 1> 
			
			
			
			
			
			<!--- end batch trailer --->
			
			<!--- generate file --->
	<cfset DATE = form.rdate>
			<cfset filename="#acBank_qry.aps_file#"&"#dateformat(DATE,'ddmm')#"&"#numberformat(form.batch,'00')#">
			<cfoutput>#filename#</cfoutput>
			
			<!--- <cffile action = "rename" source = "C:\Inetpub\wwwroot\payroll\download\file.txt" destination = "C:\Inetpub\wwwroot\payroll\download\#filename#.txt"> --->
			
			<cfset yourFileName="#filedir#">
			<cfset yourFileName2="#filename#.txt">
			 
			 <cfcontent type="application/x-unknown"> 
			
			<cfset thisPath = ExpandPath("#yourFileName#")> 
			<cfheader name="Content-Disposition" value="attachment; filename=#yourFileName2#">
			<cfheader name="Content-Description" value="This is a tab-delimited file.">
			<cfcontent type="Multipart/Report" file="#yourFileName#">
			<cflocation url="#yourFileName#"> 
	
	</cfif>
			
			
<!--- start generate file --->
<cfelseif aps_qry.entryno eq "5">
	<cfif acBank_qry.com_accno neq "">
	<cfset total_record_count = 0 >
		<!--- start header --->
	<!--- 	<cffunction name="SPACE" returntype="string">
	        <cfargument name="value1" type="numeric" required="yes">
			<cfset reval="">
	         	<cfloop from="1" to="#value1#" index="i">
					<cfset reval = reval&" ">
				</cfloop>
			<cfreturn reval>
	    </cffunction> --->
		
		<cfset batchhead_for = #aps_qry.ORREC1#>
		<cfset batchhead_for = Replace(batchhead_for,"+","&","all") >
		
		<cfset valuedate1="#form.cdate#">
		<cfset valuedate2="#DatePart('w', valuedate1)#">
		<cfif valuedate2 neq "7" OR valuedate2 neq "1">
			<cfset valuedate3 ="#form.cdate#" >
		</cfif>
		<cfset YY = #dateformat(valuedate3,'yy')#>
		<cfset MM = #dateformat(valuedate3,'mm')#>
		<cfset DD = #dateformat(valuedate3,'dd')#>
		
		
			
		<!--- YY + MM + DD + SPACE(45) +  OR_BANK + OR_BRAN + OR_ACCNO + '  '  + OR_NAME +BT_NUM +OR_ID + SPACE(9) + '0' --->
		<cfif acBank_qry.org_code neq "">
			<cfif len(#acBank_qry.org_code#) eq aps_qry.orbankl>
				<cfset OR_BANK = #acBank_qry.org_code#>
                            <cfelse>
				<cfset OR_BANK = left(acBank_qry.org_code,val(aps_qry.orbankl))>
			</cfif>
		</cfif>
				
		<cfif acBank_qry.bran_code neq "">
			<cfif len(#acBank_qry.bran_code#) eq aps_qry.orbranl>
				<cfset OR_BRAN = #acBank_qry.bran_code#>
			</cfif>
		</cfif>
		
		
		<cfset OR_ACCNO =#acBank_qry.com_accno#>
			<cfset OR_ACCNO = Replace(OR_ACCNO,"-","","all")>
		<cfloop condition="len(OR_ACCNO) lt #aps_qry.oraccnol#">
			<cfset OR_ACCNO = OR_ACCNO&" " >
		</cfloop>
		
		<cfif acBank_qry.com_name neq "">
		<cfset OR_NAME =#acBank_qry.com_name#>
			<cfif len(OR_NAME) lt #aps_qry.ornamel# >	
				<cfloop condition="len(OR_NAME) lt #aps_qry.ornamel#">
					<cfset OR_NAME = OR_NAME&" " >
				</cfloop> 
			<cfelse>
				<cfset OR_NAME = Left(acBank_qry.com_name, aps_qry.ornamel)>
			</cfif>
		</cfif>
		
		<cfset var1 = "0">
			<cfloop condition="len(var1) lt #aps_qry.btnuml#">
					<cfset var1 = var1 &"0">
			</cfloop>
		<cfset BT_NUM = #form.batch# >
		
		
		
		<cfif acBank_qry.com_id neq "">
		<cfset OR_ID =#rereplace( Ucase( "#acBank_qry.com_id#" ), "\b([a-z])", "ALL")# >
			<cfloop condition="len(OR_ID) lt #aps_qry.oridl#">
				<cfset OR_ID = OR_ID&" " >
			</cfloop>
		</cfif>
		
		
		<cfset batchhead_data = #evaluate('#batchhead_for#')#>
		<cfoutput>#batchhead_data#</cfoutput>
		
		<cfset header = "#batchhead_data#">
			<cfloop condition="len(header) lt #aps_qry.aps_size#">
			<cfset header = header&" " >
			</cfloop>
				
		<cffile action = "write" 
						file = "#filedir#" 
						output = "#header#" nameconflict="overwrite">
	
	
		<!--- end head --->
		
		<!---  start body --->
		<!--- RC_BANK + RC_BRAN + RC_ACCNO + RC_NAME + '22' + RC_AMT + SPACE(38) + SPACE(12) + SPACE(12) + '1' --->
		
		<cfloop query="getpaytra1_qry">
		<cfset RC_BANK = 0>
		<cfset RC_BRAN = 0>
		<cfset RC_ACCNO =0>
		<cfset RC_NAME = 0>
		<cfset RC_AMT = 0>
				<cfset batchdetail_for = #aps_qry.RCREC1#>
				<cfset batchdetail_for = Replace(batchdetail_for,"+","&","all") >
				
				
				<cfif getpaytra1_qry.bankcode neq "" >
					<cfif len(getpaytra1_qry.bankcode) eq aps_qry.rcbankl>
						<cfset RC_BANK = #getpaytra1_qry.bankcode#>
					</cfif>
				</cfif>
				
				<cfif getpaytra1_qry.brancode neq "">
					<cfif len(getpaytra1_qry.brancode) eq aps_qry.rcbranl>
						<cfset RC_BRAN = #getpaytra1_qry.brancode#>
					</cfif>
				</cfif>
			
				<cfset RC_ACCNO = #getpaytra1_qry.bankaccno#>
				<cfset RC_ACCNO = Replace(RC_ACCNO,"-","","all")>
				<cfloop condition="len(RC_ACCNO) lt #aps_qry.rcaccnol#">
					<cfset RC_ACCNO = RC_ACCNO &" ">
				</cfloop>
				
				<cfif getpaytra1_qry.name neq "">
					<cfset RC_NAME = #getpaytra1_qry.name#>
					<cfif len(RC_NAME) lt #aps_qry.rcnamel#>
						<cfloop condition="len(RC_NAME) lt #aps_qry.rcnamel#">
							<cfset RC_NAME = RC_NAME &" ">
						</cfloop>
					<cfelse>
						<cfset RC_NAME = Left(getpaytra1_qry.name, aps_qry.rcnamel)>
					</cfif>
				</cfif>
				
				<cfif left(dts,8) eq "manpower">
            <cfset nett = (val(getpaytra1_qry.netpay)+numberformat(getpaytra1_qry.totalamtnew,'.__')-numberformat(getpaytra1_qry.totalded,'.__')) * 100>
            <cfelse>
				<cfset nett = #val(getpaytra1_qry.netpay)# * 100>
                </cfif>
				<cfset var1 = "0">
				<cfloop condition="len(var1) lt #aps_qry.rcamtl#">
						<cfset var1 = var1 &"0">
				</cfloop>
					<cfset RC_AMT = #numberformat(nett,var1)#>
					
				
				
				<cfset batchdetail_data = #evaluate('#batchdetail_for#')#>
				<cfoutput>
            <cfif RC_BANK neq 0
					and RC_BRAN neq 0
					and RC_ACCNO neq 0
					and RC_NAME neq 0
					and RC_AMT neq 0>
                    <cfelse>
           EMPNO - #getPaytra1_qry.empno#<br/> 
           BANK CODE - #rc_bank#<br/>
           BRANCH CODE - #RC_BRAN#<br/>
           ACCNO - #RC_ACCNO#<br/>
           NAME - #RC_NAME#<br />
		   PAY AMT - #RC_AMT#<br/>
           (0 indicate problem field)
			</cfif>
			</cfoutput>
				<!--- <cfoutput>#batchdetail_data#</cfoutput><br> --->
			<cfif RC_BANK neq 0
					and RC_BRAN neq 0
					and RC_ACCNO neq 0
					and RC_NAME neq 0
					and RC_AMT neq 0>
				<cfset content ="#batchdetail_data#">
				<cfloop condition="len(content) lt #aps_qry.aps_size#">
					<cfset content = content&" " >
				</cfloop>
				
				<cffile action="append" addnewline="yes" 
				   file = "#filedir#"
				   output = "#content#" nameconflict="overwrite"> 
				<cfset total_record_count = total_record_count + 1> 
                <cfelse>
            <cfoutput>
				<font color="red"><th>Data Imcompletion Found.<br/>Please Click <input type="button" name="checkimcomplete" value="Here" onclick="window.location.href='/payments/checkincomplete.cfm?paytype=1&bankcat=#acBank_qry.category#'"  /> To Check<th></font> 
                </cfoutput>
				
                <cfabort>
	
			</cfif>
		</cfloop>
		<!--- end body --->
		
		<!--- start batch trailer --->
		<!--- FF_ITEM + FF_AMT + SPACE(5) + '00000000' +'00000000000' + SPACE(26) + FF_HASH + SPACE(33) + '9' --->
		<cfset batchtrailer_for = #aps_qry.FFREC1#>
		<cfset batchtrailer_for = Replace(batchtrailer_for,"+","&","all") >
		
		<cfif #total_record_count# lte 24000 >
		<cfset var1 = "0">
		<cfloop condition="len(var1) lt #aps_qry.ffiteml#">
				<cfset var1 = var1 &"0">
		</cfloop>
		<cfset FF_ITEM = #numberformat(val(total_record_count),var1)#>
		</cfif>
		
		<cfquery name="sum_netpay" datasource="#dts#">
		SELECT <cfif left(dts,8) eq "manpower">sum(c.netpay)+sum(round(d.totalamtnew+0.00000001,2))-sum(round(d.totalded+0.00000001,2))<cfelse>sum(netpay)</cfif> as sumnetpay FROM paytra1 as c left join pmast as p on c.empno = p.empno 
         <cfif left(dts,8) eq "manpower">
LEFT JOIN
(
select empno as aemp,sum(if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0)) as totalamtnew,sum(coalesce(ded1,0)+coalesce(ded2,0)+coalesce(ded3,0)) as totalded from #replace(dts,'_p','_i')#.assignmentslip where month(assignmentslipdate) = "#company_details.mmonth#" and year(assignmentslipdate) = "#company_details.myear#" and paydate = "paytra1"
 group by empno
) as d
on c.empno = d.aemp
</cfif>
		where p.bankaccno <> "" and paymeth ="B" and p.bankcat = "#acBank_qry.category#"
		and c.payyes = "y" 
		<cfif left(dts,8) eq "manpower">
<cfif form.batch neq ''>
<cfif getempnolist.recordcount neq 0>
and p.empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getempnolist.empno)#" list="yes" separator=",">)
</cfif>
</cfif>
</cfif>
		<cfif form.confid neq "">
and p.confid = "#form.confid#" 
</cfif>
<cfif form.empnofrom neq "" and form.empnoto neq "">
and p.empno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empnofrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empnoto#">
</cfif>
<cfif form.catefrom neq "" and form.cateto neq "">
and p.category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.catefrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cateto#">
</cfif>
<cfif form.deptfrom neq "" and form.deptto neq "">
and p.deptcode between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.deptfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.deptto#">
</cfif>
		</cfquery>
		<cfset var1 = "0">
		<cfloop condition="len(var1) lt #aps_qry.ffamtl#">
				<cfset var1 = var1 &"0">
		</cfloop>
		<cfset sumNetpay = val(sum_netpay.sumnetpay) * 100>
		<cfset FF_AMT = #numberformat(val(sumNetpay),var1)#>
		
		<cfset comp_acno_len2 = 11> 
		<cfset  total_hash =0>
	
		<cfset comp_accno = #acBank_qry.com_accno#>
		<cfset comp_accno = Replace(comp_accno, "-", "","all")>
		<cfloop condition="len(comp_accno) lt #comp_acno_len2# ">
			<cfset comp_accno = comp_accno&"0" >
		</cfloop> 
	
		<cfset comp_ac1 = left( comp_accno, 6)- right(comp_accno,5)>
	
	
		<cfloop query="getpaytra1_qry">
			<cfset rc_accno = "#getpaytra1_qry.bankaccno#">
			<cfset rc_accno = Replace(rc_accno, "-", "","all")>
			<cfloop condition="len(rc_accno) lt #comp_acno_len2# ">
				<cfset rc_accno = rc_accno&"0" >
			</cfloop> 
			<cfset rc_ac1 = left(trim(rc_accno), 6)- right(trim(rc_accno),5)>
			<cfset hash_rc = rc_ac1 - comp_ac1 >
			<cfset total_hash = total_hash + #Abs(hash_rc)#>
		</cfloop>
		
		
		<cfset var1 = "0">
		<cfloop condition="len(var1) lt #aps_qry.ffhashl#">
				<cfset var1 = var1 &"0">
		</cfloop>		
		<cfset FF_HASH = #numberformat(total_hash,var1)#>
		
		
		<cfset batchtrailer_data = #evaluate('#batchtrailer_for#')# >
		<cfoutput>#batchtrailer_data#</cfoutput><br>
		
		<cfset footer ="#batchtrailer_data#">
		<cfloop condition="len(footer) lt 114">
		<cfset footer = footer&" " >
		</cfloop>
		
		<cffile action="append" addnewline="yes" 
		   file = "#filedir#"
		   output = "#footer#"> 
		<cfset total_record_count = total_record_count + 1> 
			
			
			
			
			
			<!--- end batch trailer --->
		
		<!--- start generate file --->		
		<cfset filename="#acBank_qry.aps_file#">
<!--- 		<cffile action = "rename" source = "C:\Inetpub\wwwroot\payroll\download\file.txt" 
				destination = "C:\Inetpub\wwwroot\payroll\download\#filename#.txt"> --->
		
		<cfset yourFileName="#filedir#">
		<cfset yourFileName2="#filename#.txt">
		 
		 <cfcontent type="application/x-unknown"> 
		
		<cfset thisPath = ExpandPath("#yourFileName#")> 
		<cfheader name="Content-Disposition" value="attachment; filename=#yourFileName2#">
		<cfheader name="Content-Description" value="This is a tab-delimited file.">
		<cfcontent type="Multipart/Report" file="#yourFileName#">
		<cflocation url="#yourFileName#">
	</cfif>
<cfelse>
<cfset total_record_count = 0 >
            		
	<cfif #form.aps_num2# neq 0>
		<cfset startwrite = 0>
        <cfset SERIALNO = 50000>
		<cfset var1 = "0">
			<cfloop condition="len(var1) lt #aps_qry.btnuml#">
					<cfset var1 = var1 &"0">
			</cfloop>
		<cfset BT_NUM = #form.batch# >
		
		<!---<cfset BT_NUM = #numberformat(form.batch,var1)# >--->
        
        
        <cfif acBank_qry.org_code neq "">
		<cfif len(#acBank_qry.org_code#) eq aps_qry.orbankl>
            <cfset OR_BANK = #acBank_qry.org_code#>
                        <cfelse>
				<cfset OR_BANK = left(acBank_qry.org_code,val(aps_qry.orbankl))>
        </cfif>
        </cfif>
        
        <cfif acBank_qry.bran_code neq "">
            <cfif len(#acBank_qry.bran_code#) eq aps_qry.orbranl>
                <cfset OR_BRAN = #acBank_qry.bran_code#>
            </cfif>
        </cfif>
        
        <cfset OR_ACCNO = acBank_qry.com_accno>
        <cfset OR_ACCNO = Replace(OR_ACCNO,"-","","all")>
        <cfif OR_ACCNO neq "" and len(acBank_qry.com_accno)lt aps_qry.oraccnol>    
            <cfloop condition="len(OR_ACCNO) lt #aps_qry.oraccnol#">
                <cfset OR_ACCNO = OR_ACCNO&" " >
            </cfloop>
        </cfif>
        
        <cfif acBank_qry.com_name neq "">
            <cfset OR_NAME =#acBank_qry.com_name#>
            <cfloop condition="len(OR_NAME) lt #aps_qry.ornamel#">
                <cfset OR_NAME = OR_NAME&" " >
            </cfloop> 
        </cfif>
        
        <!--- Validate create date --->
			<cfset GENDATE = now()>
			
			<cfset VALUEDATE = #DateAdd('w', -1, form.cdate)#>
			
			<cfset HASH_I =" ">

		<!--- Originator	 --->
        
        <cfset originatorhead = aps_qry.orrec1>
        <cfif originatorhead neq "''">
        <cfset originatorhead = Replace(originatorhead,"+","&","all") >
        <cfset originatordata = evaluate('#originatorhead#')>
        <cfloop condition="len(originatordata) lt #aps_qry.aps_size#">
			<cfset originatordata = originatordata&" " >
		</cfloop>
        <cffile action = "write" file = "#filedir#" 
		output = "#originatordata#" nameconflict="overwrite">
        <cfset startwrite = 1>
		</cfif>
        
        
        <!--- Batch Header --->
        
		<cfset batchhead_for = #aps_qry.BTREC1#>
        <cfif batchhead_for neq "''">
			<cfset batchhead_for = Replace(batchhead_for,"+","&","all") >
            <cfset batchhead_data = #evaluate('#batchhead_for#')#>
            <cfset header = "#batchhead_data#">
            <cfloop condition="len(header) lt #aps_qry.aps_size#">
                <cfset header = header&" " >
            </cfloop>
			<cfif startwrite eq 0>
                <cffile action = "write" 
                        file = "#filedir#" 
                        output = "#header#" nameconflict="overwrite">
             <cfelse>
             <cffile action="append"
                        file = "#filedir#" 
                        output = "#header#">
             </cfif>
		</cfif>
        
		<!--- end batch header --->
        
		<!--- start batch detail --->
        
		<cfset RC_BANK = 0>
		<cfset RC_BRAN = 0>
		<cfset RC_ACCNO =0>
		<cfset RC_NAME = 0>
		<cfset RC_AMT = 0>
		
		<cfloop query="getpaytra1_qry">
        
			<cfset batchdetail_for = #aps_qry.RCREC1#>
			<cfset batchdetail_for = Replace(batchdetail_for,"+","&","all") >
			
			<cfif getpaytra1_qry.bankcode neq "" >
				<cfif len(getpaytra1_qry.bankcode) eq aps_qry.rcbankl>
					<cfset RC_BANK = #getpaytra1_qry.bankcode#>
				</cfif>
			</cfif>
			
			<cfif getpaytra1_qry.brancode neq "">
				<cfif len(getpaytra1_qry.brancode) eq aps_qry.rcbranl>
					<cfset RC_BRAN = #getpaytra1_qry.brancode#>
				</cfif>
			</cfif>
						
			<cfset RC_ACCNO = #getpaytra1_qry.bankaccno#>
			<cfset RC_ACCNO = Replace(RC_ACCNO,"-","","all")>
			<cfloop condition="len(RC_ACCNO) lt #aps_qry.rcaccnol#">
				<cfset RC_ACCNO = RC_ACCNO &" ">
			</cfloop>
			
			<cfif getpaytra1_qry.name neq "">
				<cfset RC_NAME = #getpaytra1_qry.name#>
				<cfif len(RC_NAME) lt #aps_qry.rcnamel#>
					<cfloop condition="len(RC_NAME) lt #aps_qry.rcnamel#">
						<cfset RC_NAME = RC_NAME &" ">
					</cfloop>
				<cfelse>
					<cfset RC_NAME = Left(getpaytra1_qry.name, aps_qry.rcnamel)>
				</cfif>
			</cfif>
			
			<cfif left(dts,8) eq "manpower">
            <cfset nett = (numberformat(val(getpaytra1_qry.netpay),'.__')+numberformat(getpaytra1_qry.totalamtnew,'.__')-numberformat(getpaytra1_qry.totalded,'.__')) * 100>
            <cfelse>
			<cfset nett = #numberformat(val(getpaytra1_qry.netpay),'.__')# * 100>
            </cfif>
			<cfset var1 = "0">
			<cfloop condition="len(var1) lt #aps_qry.rcamtl#">
					<cfset var1 = var1 &"0">
			</cfloop>
			<cfset RC_AMT = #numberformat(nett,var1)#>
				
			
			<cfset batchdetail_data = #evaluate('#batchdetail_for#')#>
            <cfoutput>
            <cfif RC_BANK neq 0
					and RC_BRAN neq 0
					and RC_ACCNO neq 0
					and RC_NAME neq 0
					and RC_AMT neq 0>
                    <cfelse>
           EMPNO - #getPaytra1_qry.empno#<br/> 
           BANK CODE - #rc_bank#<br/>
           BRANCH CODE - #RC_BRAN#<br/>
           ACCNO - #RC_ACCNO#<br/>
           NAME - #RC_NAME#<br />
		   PAY AMT - #RC_AMT#<br/>
           (0 indicate problem field)
			</cfif>
			</cfoutput>
			<cfif RC_BANK neq 0
					and RC_BRAN neq 0
					and RC_ACCNO neq 0
					and RC_NAME neq 0
					and RC_AMT neq 0>
				
				<cfset content ="#batchdetail_data#">
				<cfloop condition="len(content) lt #aps_qry.aps_size#">
					<cfset content = content&" " >
				</cfloop>
				
				<cffile action="append" addnewline="yes" 
				   file = "#filedir#"
				   output = "#content#"> 
				<cfset total_record_count = total_record_count + 1> 
			<cfelse>
            <cfoutput>
				<font color="red"><th>Data Imcompletion Found.<br/>Please Click <input type="button" name="checkimcomplete" value="Here" onclick="window.location.href='/payments/checkincomplete.cfm?paytype=1&bankcat=#acBank_qry.category#'"  /> To Check<th></font> </cfoutput>
				<cfabort>
			</cfif>
            <cfset SERIALNO = SERIALNO + 1>
		</cfloop>
			
			<!--- end batch detail --->
			<!--- start batch trailer --->
			<cfset batchtrailer_for = #aps_qry.FFREC1#>
            <cfif batchtrailer_for neq "''">
			<cfset batchtrailer_for = Replace(batchtrailer_for,"+","&","all") >
			
			<cfquery name="sum_netpay" datasource="#dts#">
				SELECT <cfif left(dts,8) eq "manpower">sum(c.netpay)+sum(round(d.totalamtnew+0.00000001,2))-sum(round(d.totalded+0.00000001,2))<cfelse>sum(netpay)</cfif> as sumnetpay FROM paytra1 as c left join pmast as p on c.empno = p.empno 
                 <cfif left(dts,8) eq "manpower">
LEFT JOIN
(
select empno as aemp,sum(if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0)) as totalamtnew,sum(coalesce(ded1,0)+coalesce(ded2,0)+coalesce(ded3,0)) as totalded from #replace(dts,'_p','_i')#.assignmentslip where month(assignmentslipdate) = "#company_details.mmonth#" and year(assignmentslipdate) = "#company_details.myear#" and paydate = "paytra1"
 group by empno
) as d
on c.empno = d.aemp
</cfif>
				where c.netpay <> "0" and p.bankaccno <> "" and paymeth ="B" and p.bankcat = "#acBank_qry.category#" 
				<cfif left(dts,8) eq "manpower">
<cfif form.batch neq ''>
<cfif getempnolist.recordcount neq 0>
and p.empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getempnolist.empno)#" list="yes" separator=",">)
</cfif>
</cfif>
</cfif>
				<cfif form.confid neq "">
and p.confid = "#form.confid#" 
</cfif>
<cfif form.empnofrom neq "" and form.empnoto neq "">
and p.empno between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empnofrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.empnoto#">
</cfif>
<cfif form.catefrom neq "" and form.cateto neq "">
and p.category between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.catefrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.cateto#">
</cfif>
<cfif form.deptfrom neq "" and form.deptto neq "">
and p.deptcode between <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.deptfrom#"> and <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.deptto#">
</cfif>
				and c.payyes = "y"
			</cfquery>
			<cfset sumNetpay = val(sum_netpay.sumnetpay) * 100>
			<cfset var1 = "0">
			<cfloop condition="len(var1) lt #aps_qry.ffamtl#">
					<cfset var1 = var1 &"0">
			</cfloop>
			<cfset FF_AMT = #numberformat(val(sumNetpay),var1)#>
			
			<cfset var1 = "0">
			<cfloop condition="len(var1) lt #aps_qry.ffiteml#">
					<cfset var1 = var1 &"0">
			</cfloop>
			<cfset FF_ITEM = #numberformat(val(total_record_count),var1)#>
			<cfset FF_HASH = "             ">
			
			
			
			<cfset batchtrailer_data = #evaluate('#batchtrailer_for#')# >
			<cfoutput>#batchtrailer_data#</cfoutput><br>
			
			<cfset footer ="#batchtrailer_data#">
			<cfloop condition="len(footer) lt #aps_qry.aps_size#">
			<cfset footer = footer&" " >
			</cfloop>
			
			<cffile action="append" addnewline="yes" 
			   file = "#filedir#"
			   output = "#footer#"> 
			<cfset total_record_count = total_record_count + 1> 
			
			
			</cfif>
			
			
			<!--- end batch trailer --->
			
			<!--- generate file --->
	<cfset DATE = form.rdate>
			<cfset filename=acBank_qry.aps_file>
			<cfoutput>#filename#</cfoutput>
			
			<!--- <cffile action = "rename" source = "C:\Inetpub\wwwroot\payroll\download\file.txt" destination = "C:\Inetpub\wwwroot\payroll\download\#filename#.txt"> --->
			
			<cfset yourFileName="#filedir#">
			<cfset yourFileName2="#filename#.txt">
			 
			 <cfcontent type="application/x-unknown"> 
			
			<cfset thisPath = ExpandPath("#yourFileName#")> 
			<cfheader name="Content-Disposition" value="attachment; filename=#yourFileName2#">
			<cfheader name="Content-Description" value="This is a tab-delimited file.">
			<cfcontent type="Multipart/Report" file="#yourFileName#">
			<cflocation url="#yourFileName#"> 
	
	</cfif>
</cfif>
<!--- original code end --->
</cfif>
<!--- \Inetpub\wwwroot\payroll\download\ --->
<!--- \JRun4\servers\cfusion\cfusion-ear\cfusion-war\payroll\download\file.dtl
--->
<!--- <cfcatch type="any">
 <cfset status_msg="Error Occured : "&cfcatch.Detail>
 <cfoutput>
 <script type="text/javascript">
 alert("#status_msg#");
 window.location.href="/report/beps/batchapproval/viewapproval.cfm";
 </script>
 </cfoutput>
 </cfcatch>
 </cftry> --->