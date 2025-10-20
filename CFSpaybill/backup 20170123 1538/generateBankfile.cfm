<cfset dtsp = replace(dts,'_i','_p')>
<cfset form.category = 1>
<cfset form.aps_num2 = 1>
<cfset url.type ="paytran">

<cfset form.cdate = Createdate(gs_qry.myear, gs_qry.mmonth, DaysInMonth(CreateDate(gs_qry.myear, gs_qry.mmonth, 1)))>
<cfset form.rdate = Createdate(gs_qry.myear, gs_qry.mmonth, DaysInMonth(CreateDate(gs_qry.myear, gs_qry.mmonth, 1)))>


<!---<cfif left(dts,4) eq "beps">
<cfif isdefined('form.batch') eq false>
<cfoutput>
<script type="text/javascript">
alert('Please Choose At Least One Batch!');
window.close();
</script>
</cfoutput>
<cfabort>
</cfif>
</cfif>--->
<!---<cftry>  --->
<cfquery name="acBank_qry" datasource="#dtsp#">
SELECT * FROM address a WHERE org_type in ('BANK') AND category="#form.category#"
</cfquery>

<cfquery name="aps_qry" datasource="#dtsp#">
SELECT * FROM aps_set WHERE entryno= "#form.aps_num2#"
</cfquery>


<cfquery name="getempicno" datasource="#dts#">
SELECT icno FROM cfsempinprofile 
WHERE profileid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.profileid#">
ORDER BY icno
</cfquery>


<!--- modification for generate SCB iPayment CSV Start --->
<cfif form.category EQ 10>
	<cfset uuid=CreateUUID()>
	<cfobject component="SCBiPaymentCSV" name="ipaymentobject">
	<cfloop query="getPaytran_qry">
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
<cfset filenewdir = "C:\Inetpub\wwwroot\IMS\download\#dts#\">
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
        
<cfif aps_qry.entryno eq "1" > <!---MY MBB--->
    <cfinclude template="/CFSpaybill/MY/maybank.cfm">


<cfelseif aps_qry.entryno eq "23" > <!---SG UOB--->

			<cfset total_record_count = 0 >
			
			
			<!--- header --->
			
			
			
			
	<cfif #form.aps_num2# neq 0>
			
			<cfset batchhead_for = #aps_qry.BTREC1#>
			<cfset batchhead_for = Replace(batchhead_for,"+","&","all") >
			
			
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
			</cfif>
			
			<!--- Validate create date --->
			<cfset GENDATE = now()>
			
			<cfset VALUEDATE = #DateAdd('w', -1, form.cdate)#>
			
			<cfset HASH_I ="2">
            <cfif aps_qry.RCHASH1 neq 0>
            <!--- <cfset RCHASH1 = Replace(aps_qry.RCHASH1,"+","","all") > --->
            <cfset RCHASH1 = evaluate('#aps_qry.RCHASH1#')>
            <cfoutput>
#RCHASH1#<br/>
</cfoutput>
            <cfelse>
            <cfset RCHASH1 = aps_qry.RCHASH1>
            </cfif>
            
            
			
			<cfset batchhead_data = #evaluate('#batchhead_for#')#>
		<!--- 	<cfoutput>#batchhead_data#</cfoutput> --->
			
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
		<cfloop query="getPaytran_qry">
			<cfset batchdetail_for = #aps_qry.RCREC1#>
			<cfset batchdetail_for = Replace(batchdetail_for,"+","&","all") >
			
			<!--- <cfoutput><br>#aps_qry.rcbankl#</cfoutput> --->
			<cfif getPaytran_qry.bankcode neq "" >
				<cfif len(getPaytran_qry.bankcode) eq aps_qry.rcbankl>
					<cfset RC_BANK = #getPaytran_qry.bankcode#>
				</cfif>
			</cfif>
			
			<cfif getPaytran_qry.brancode neq "">
				<cfif len(getPaytran_qry.brancode) eq aps_qry.rcbranl>
					<cfset RC_BRAN = #getPaytran_qry.brancode#>
				</cfif>
			</cfif>
						
			<cfset RC_ACCNO = #trim(getPaytran_qry.bankaccno)#>
			<cfset RC_ACCNO = Replace(RC_ACCNO,"-","","all")>
			<cfloop condition="len(RC_ACCNO) lt #aps_qry.rcaccnol#">
				<cfset RC_ACCNO = RC_ACCNO &" ">
			</cfloop>
			
			<cfif getPaytran_qry.name neq "">
				<cfset RC_NAME = #getPaytran_qry.name#>
				<cfif len(RC_NAME) lt #aps_qry.rcnamel#>
					<cfloop condition="len(RC_NAME) lt #aps_qry.rcnamel#">
						<cfset RC_NAME = RC_NAME &" ">
					</cfloop>
				<cfelse>
					<cfset RC_NAME = Left(getPaytran_qry.name, aps_qry.rcnamel)>
				</cfif>
			</cfif>
			
			<!---<cfif left(dts,4) eq "beps">
            <cfset nett = (val(getpaytran_qry.netpay)+numberformat(getpaytran_qry.totalamtnew,'.__')-numberformat(getpaytran_qry.totalded,'.__')) * 100>
            <cfelse>--->
			<cfset nett = #numberformat(val(getPaytran_qry.netpay),'.__')# * 100>
            <!---</cfif>--->
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
           EMPNO - #getPaytran_qry.empno#<br/> 
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
<cfoutput>
#RCHASH2#<br/>
</cfoutput>
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
            
				<font color="red"><th>Data Imcompletion Found.<br/>Please Click <input type="button" name="checkimcomplete" value="Here" onclick="window.location.href='/payments/checkincomplete.cfm?paytype=2&bankcat=#acBank_qry.category#'"  /> To Check<th></font> </cfoutput>
				<cfabort>
			</cfif>
		</cfloop>
        
        
			
			<!--- end batch detail --->
			<!--- start batch trailer --->
			<cfset batchtrailer_for = #aps_qry.FFREC1#>
			<cfset batchtrailer_for = Replace(batchtrailer_for,"+","&","all") >
			
			<cfquery name="sum_netpay" datasource="#dts#">
				SELECT <cfif left(dts,4) eq "beps">sum(c.netpay)+sum(round(d.totalamtnew+0.00000001,2))-sum(round(d.totalded+0.00000001,2))<cfelse>sum(netpay)</cfif> as sumnetpay FROM #url.type# as c left join pmast as p on c.empno = p.empno 
                <!---<cfif left(dts,4) eq "beps">
LEFT JOIN
(
select empno as aemp,sum(if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0)) as totalamtnew,sum(coalesce(ded1,0)+coalesce(ded2,0)+coalesce(ded3,0)) as totalded from #replace(dts,'_p','_i')#.assignmentslip where month(assignmentslipdate) = "#company_details.mmonth#" and year(assignmentslipdate) = "#company_details.myear#" and paydate = "paytran"
 group by empno
) as d
on c.empno = d.aemp
</cfif>--->
				where c.netpay <> "0" and p.bankaccno <> "" and paymeth ="B" and p.bankcat = "#acBank_qry.category#" 
				<!---<cfif left(dts,4) eq "beps">
<cfif form.batch neq ''>
<cfif getempnolist.recordcount neq 0>
and p.empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getempnolist.empno)#" list="yes" separator=",">)
</cfif>
</cfif>
</cfif>--->
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
			<cfset filename="#acBank_qry.aps_file#"&"#dateformat(DATE,'ddmm')#"&"#numberformat(form.Batch_No,'00')#">
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
<cfelseif aps_qry.entryno eq "5"> <!---dbs sg--->
	<cfif acBank_qry.com_accno neq "">
	<cfset total_record_count = 0 >
		<!--- start header --->
		
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
		<cfset BT_NUM = #numberformat(form.Batch_No,var1)# >
		
		
		
		<cfif acBank_qry.com_id neq "">
		<cfset OR_ID =#rereplace( Ucase( "#acBank_qry.com_id#" ), "\b([a-z])", "ALL")# >
			<cfloop condition="len(OR_ID) lt #aps_qry.oridl#">
				<cfset OR_ID = OR_ID&" " >
			</cfloop>
		</cfif>
		
		
		<cfset batchhead_data = #evaluate('#batchhead_for#')#>
		<!--- <cfoutput>#batchhead_data#</cfoutput> --->
		
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
		
		<cfloop query="getPaytran_qry">
			<cfset RC_BANK = 0>
			<cfset RC_BRAN = 0>
			<cfset RC_ACCNO =0>
			<cfset RC_NAME = 0>
			<cfset RC_AMT = 0>
				<cfset batchdetail_for = #aps_qry.RCREC1#>
				<cfset batchdetail_for = Replace(batchdetail_for,"+","&","all") >
				
				
				<cfif getPaytran_qry.bankcode neq "" >
					<cfif len(trim(getPaytran_qry.bankcode)) eq aps_qry.rcbankl>
						<cfset RC_BANK = #trim(getPaytran_qry.bankcode)#>
					</cfif>
				</cfif>
				
				<cfif getPaytran_qry.brancode neq "">
					<cfif len(trim(getPaytran_qry.brancode)) eq aps_qry.rcbranl>
						<cfset RC_BRAN = #trim(getPaytran_qry.brancode)#>
					</cfif>
				</cfif>

				<cfset RC_ACCNO = #trim(getPaytran_qry.bankaccno)#>
				<cfset RC_ACCNO = Replace(RC_ACCNO,"-","","all")>
				<cfset RC_ACCNO = Replace(RC_ACCNO," ","","all")>
				<cfloop condition="len(RC_ACCNO) lt #aps_qry.rcaccnol#">
					<cfset RC_ACCNO = RC_ACCNO &" ">
				</cfloop>
				
				<cfif getPaytran_qry.name neq "">
					<cfset RC_NAME = #getPaytran_qry.name#>
					<cfif len(RC_NAME) lt #aps_qry.rcnamel#>
						<cfloop condition="len(RC_NAME) lt #aps_qry.rcnamel#">
							<cfset RC_NAME = RC_NAME &" ">
						</cfloop>
					<cfelse>
						<cfset RC_NAME = Left(getPaytran_qry.name, aps_qry.rcnamel)>
					</cfif>
				</cfif>
				
				<cfif left(dts,4) eq "beps">
            <cfset nett = (val(getpaytran_qry.netpay)+numberformat(getpaytran_qry.totalamtnew,'.__')-numberformat(getpaytran_qry.totalded,'.__')) * 100>
            <cfelse>
				<cfset nett = #val(getPaytran_qry.netpay)# * 100>
                </cfif>
				<cfset var1 = "0">
				<cfloop condition="len(var1) lt #aps_qry.rcamtl#">
					<cfset var1 = var1 &"0">
				</cfloop>
				<cfset RC_AMT = #numberformat(nett,var1)#>
					
				
				
				<cfset batchdetail_data = #evaluate('#batchdetail_for#')#>
				
				<!--- <cfoutput>#batchdetail_data#</cfoutput><br> --->
                <cfoutput>
            <cfif RC_BANK neq 0
					and RC_BRAN neq 0
					and RC_ACCNO neq 0
					and RC_NAME neq 0
					and RC_AMT neq 0>
                    <cfelse>
           EMPNO - #getPaytran_qry.empno#<br/> 
           BANK CODE - #rc_bank#<br/>
           BRANCH CODE - #RC_BRAN#<br/>
           ACCNO - #RC_ACCNO#<br/>
           NAME - #RC_NAME#<br />
		   PAY AMT - #RC_AMT#<br/>
           (0 indicate problem field)
			</cfif>
			</cfoutput>
			<cfif RC_BANK neq 0 and RC_BRAN neq 0 and RC_ACCNO neq 0 and RC_NAME neq 0 and RC_AMT neq 0>		
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
				<font color="red"><th>Data Imcompletion Found.<br/>Please Click <input type="button" name="checkimcomplete" value="Here" onclick="window.location.href='/payments/checkincomplete.cfm?paytype=2&bankcat=#acBank_qry.category#'"  /> To Check<th></font> </cfoutput>
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
		SELECT <cfif left(dts,4) eq "beps">sum(c.netpay)+sum(round(d.totalamtnew+0.00000001,2))-sum(round(d.totalded+0.00000001,2))<cfelse>sum(netpay)</cfif> as sumnetpay FROM #url.type# as c left join pmast as p on c.empno = p.empno 
        <!---<cfif left(dts,4) eq "beps">
LEFT JOIN
(
select empno as aemp,sum(if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0)) as totalamtnew,sum(coalesce(ded1,0)+coalesce(ded2,0)+coalesce(ded3,0)) as totalded from #replace(dts,'_p','_i')#.assignmentslip where month(assignmentslipdate) = "#company_details.mmonth#" and year(assignmentslipdate) = "#company_details.myear#" and paydate = "paytran"
 group by empno
) as d
on c.empno = d.aemp
</cfif>--->
		where p.bankaccno <> "" and paymeth ="B" and p.bankcat = "#acBank_qry.category#" and c.payyes = "y"
        
        <!---<cfif left(dts,4) eq "beps">
<cfif form.batch neq ''>
<cfif getempnolist.recordcount neq 0>
and p.empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getempnolist.empno)#" list="yes" separator=",">)
</cfif>
</cfif>
</cfif>--->
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
	
	
		<cfloop query="getPaytran_qry">
			<cfset rc_accno = "#trim(getPaytran_qry.bankaccno)#">
			<cfset rc_accno = Replace(rc_accno, "-", "","all")>
            <cfset rc_accno = trim(rc_accno)>
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

<cfelseif aps_qry.entryno eq "9"> <!---SG HLB--->

<cfquery name="getcompanydetail" datasource="payroll_main">
	SELECT * FROM gsetup where comp_id = "#HcomID#"
</cfquery>

<cfset systemyear = #getcompanydetail.myear#>
<cfset systemmonth = #getcompanydetail.mmonth#>

<cfset newdate = createdate(#systemyear#,#systemmonth#,1)>

<cfset newyear = DateFormat(#newdate#,"YYYY")>
<cfset newmonth = DateFormat(#newdate#,"MMM")>


<cfquery name="getemployeedetail" datasource="#dts#">
	SELECT "" as a, "" as b, "" as c, "" as d, "" as e ,"" as f, "" as g, "" as h
    UNION ALL
	SELECT "Reference" as refer, "#newyear# #newmonth# Payroll" as title,"","","","","",""
    UNION ALL
    SELECT "Bank Code" as bankcodetitle, "Account Number" as accnumber, "Beneficiary Name" as beneficiaryname, "ID Number" as idnumber, "Recipient Reference" as recipientreference, "Other Payment Detail" as otherpayment, "Salary Amount" as salaryamount, "Contact Number" as contact
    UNION ALL
    SELECT bankcode,bankaccno, name, nricn,"#newmonth# #newyear# Salary" AS salarymonth, "" AS optional,brate, phone 
    FROM pmast    
</cfquery>

<cfoutput>
<cfset currentDirectory = ExpandPath("/download/#dts#/")&dts>
<cfif DirectoryExists(currentDirectory) eq false>
<cfdirectory action = "create" directory = "#currentDirectory#" >
</cfif>
</cfoutput> 

<cfset objPOIUtility = CreateObject(
	"component",
	"POIUtility"
	).Init()
	/>

<cfset datenow = now()>

<cfset filename="#acBank_qry.aps_file#">

<cfset objPOIUtility.WriteSingleExcel(
	FilePath = ExpandPath( "/download/#dts#/#filename#.xls" ),
	Query = getemployeedetail,
	SheetName = "#filename#"
	) />
	<cfheader name="Content-Disposition" value="inline; filename=#filename#.xls">
<cfcontent type="application/vnd.ms-excel" file="#ExpandPath( "/download/#dts#/#filename#.xls" )#">


<cfelseif aps_qry.entryno eq "29"> <!---SG CITIBANK--->

    <cfquery name="emplist" datasource="#dts#">
    SELECT * FROM pmast AS a LEFT JOIN paytran AS b ON a.empno=b.empno
    </cfquery>
    
    <cfquery name="emperlist" datasource="#dts#">
    SELECT * FROM address
    </cfquery>
    
    <cfset OR_ACCNO = acBank_qry.com_accno>
    <cfset OR_ACCNO = Replace(OR_ACCNO,"-","","all")>
    
    <cfset header = "">
    
    <cfloop query="emplist">
    <cfset debit_accno = left(OR_ACCNO,35)>
    
    <cfset payment_amount = NumberFormat(emplist.brate,'.__')>
    
    <cfset branch_code_empee = #acBank_qry.bran_code#>
    
    <cfset referenceno = left(emplist.empno,15)>
    
    <cfset beneficiary_name = left(emplist.name,20)>
    
    <cfset beneficiary_accno = left(emplist.bankaccno,11)>
    
    <cfset bank_code = #emperlist.org_code#>
    
    <cfset branch_code_emper = #acBank_qry.bran_code#>
    
    <cfset bank_routing_code = "#bank_code#"&"#branch_code_emper#">
    
    <cfset ndate = form.cdate>
    
    
    <cfset header = header& "PLP@"&"SG@"&"#debit_accno#@"&"SGD@"&"#payment_amount#@"&"#branch_code_empee#@"&"#DateFormat(ndate,'YYYYMMDD')#@"&"#referenceno#@"&"@@@"&"@@@@@@@@"&"#beneficiary_name#@"&"@@@@"&"#beneficiary_accno#@"&"@@@@@@"&"#bank_routing_code#@"&"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"&"22@"&"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"&"#chr(13)##chr(10)#">
    </cfloop>
    <cffile action = "write"
       file = "#filedir#"
       output = "#header#" nameconflict="overwrite">
    
    <cfset filename="#acBank_qry.aps_file#">
    
    <cfset yourFileName="#filedir#">
    <cfset yourFileName2="#filename#.txt">
     
     <cfcontent type="application/x-unknown"> 
    
     <cfset thisPath = ExpandPath("#yourFileName#")> 
     <cfheader name="Content-Disposition" value="attachment; filename=#yourFileName2#">
    <cfheader name="Content-Description" value="This is a tab-delimited file.">
    <cfcontent type="Multipart/Report" file="#yourFileName#">
    <cflocation url="#yourFileName#">
    
    <cfelseif aps_qry.entryno eq "30"> <!---MY CIMB--->
    
    <cfquery name="getComp_qry" datasource="payroll_main">
    SELECT * FROM gsetup WHERE comp_id = "#HcomID#"
    </cfquery>
    
    <cfquery name="getList_qry" datasource="#dts#">
    SELECT 
    sum(brate) as brate 
    FROM pmast
    </cfquery>
    
    <cfquery name="emperlist" datasource="#dts#">
    SELECT * FROM address
    </cfquery>
    
    <cfquery name="emplist" datasource="#dts#">
    SELECT * FROM pmast AS a LEFT JOIN paytran AS b ON a.empno=b.empno
    </cfquery>
    
    
    <cfset comp_name2 = #UCASE(getComp_qry.COMP_NAME)#>
    <cfset comp_name2 = left(comp_name2,40)>
    <cfif len(comp_name2) lt 40>
    <cfset addspacing = "">
    <cfset a = 40-len(comp_name2)>
    <cfloop from="1" to="#a#" index="i">
    <cfset addspacing = addspacing&" ">
    </cfloop>
    <cfset comp_name2 = comp_name2&addspacing>
    </cfif>
    
    <cfset org_id = #emperlist.org_code#>
    <cfset org_id = left(org_id,5)>
    <cfif len(org_id) lt 5>
    <cfset addspacing = "">
    <cfset a = 5-len(org_id)>
    <cfloop from="1" to="#a#" index="i">
    <cfset addspacing = addspacing&" ">
    </cfloop>
    <cfset org_id = org_id&addspacing>
    </cfif>
    
    
    
    
    <cfset header = "">
    
    <cfset s_date = cdate>
    <cfset security_code = "0000000000000000">
    
    <cfset header = header& "01"&"#org_id#"&"#comp_name2#"&"#DateFormat(s_date,'DDMMYYYY')#"&"#security_code#  ">
    
    <cffile action = "write"
       file = "#filedir#"
       output = "#header#" nameconflict="overwrite">
    
    <cfset total_record_count = 0 >
    
    <cfloop query="emplist">
    <cfset bankaccno2 = left(emplist.bankaccno,16)>
    <cfif len(bankaccno2) lt 16>
    <cfset addspacing = "">
    <cfset a = 16-len(bankaccno2)>
    <cfloop from="1" to="#a#" index="i">
    <cfset addspacing = addspacing&" ">
    </cfloop>
    <cfset bankaccno2 = bankaccno2&addspacing>
    </cfif>
    
    <cfset name2 = left(emplist.name,40)>
    <cfif len(name2) lt 40>
    <cfset addspacing = "">
    <cfset a = 40-len(name2)>
    <cfloop from="1" to="#a#" index="i">
    <cfset addspacing = addspacing&" ">
    </cfloop>
    <cfset name2 = name2&addspacing>
    </cfif>
    
    <cfset payment_amount = (NumberFormat(emplist.brate,'.__')*100)>
    <cfset payment_amount2 = left(payment_amount,11)>
    <cfif len(payment_amount2) lt 11>
    <cfset addspacing = "">
    <cfset a = 11-len(payment_amount2)>
    <cfloop from="1" to="#a#" index="i">
    <cfset addspacing = addspacing&"0">
    </cfloop>
    <cfset payment_amount2 = addspacing&payment_amount2>
    </cfif>
    
    <cfset referenceno = left(emplist.empno,30)>
    <cfif len(referenceno) lt 30>
    <cfset addspacing = "">
    <cfset a = 30-len(referenceno)>
    <cfloop from="1" to="#a#" index="i">
    <cfset addspacing = addspacing&"0">
    </cfloop>
    <cfset referenceno = addspacing&referenceno>
    </cfif>
    
    <cfset beneficiaryID = left(emplist.nricn,20)>
    <cfif len(beneficiaryID) lt 20>
    <cfset addspacing = "">
    <cfset a = 20-len(beneficiaryID)>
    <cfloop from="1" to="#a#" index="i">
    <cfset addspacing = addspacing&" ">
    </cfloop>
    <cfset beneficiaryID = beneficiaryID&addspacing>
    </cfif>
    
    <cfset sub_header2 = "">
    
    <cfset sub_header2 = sub_header2&"02"&"3500000"&"#bankaccno2#"&"#name2#"&"#payment_amount2#"&"#referenceno#"&"#beneficiaryID#"&"2">
    <cffile action="append" addnewline="yes" 
       file = "#filedir#"
       output = "#sub_header2#">
       <cfset total_record_count = total_record_count + 1 >
    
    </cfloop>
    
    <cfset total_empcc_contrib = 0>
    <cfset total_empcc_contrib = total_empcc_contrib + #val(getList_qry.brate)# >
    <cfset total_empcc_contrib = (#numberformat(total_empcc_contrib, '0000000000000')#)*100>
    <cfset total_empcc_contrib2 = right(total_empcc_contrib,13)>
    <cfif len(total_empcc_contrib2) lt 13>
    <cfset addspacing = "">
    <cfset a = 13-len(total_empcc_contrib2)>
    <cfloop from="1" to="#a#" index="i">
    <cfset addspacing = addspacing&"0">
    </cfloop>
    <cfset total_empcc_contrib2 = addspacing&total_empcc_contrib2>
    </cfif>
    
    
    <cfset total_record_count =  #numberformat(total_record_count, '000000')#>
    
    <cfset sub_header3 = "">
    
    <cfset sub_header3 = sub_header3&"03"&"#total_record_count#"&"#total_empcc_contrib2#">
    <cffile action="append" addnewline="yes" 
       file = "#filedir#"
       output = "#sub_header3#">
    
    <cfset filename="#acBank_qry.aps_file#">
    
    <cfset yourFileName="#filedir#">
    <cfset yourFileName2="#filename#.txt">
     
     <cfcontent type="application/x-unknown"> 
    
     <cfset thisPath = ExpandPath("#yourFileName#")> 
     <cfheader name="Content-Disposition" value="attachment; filename=#yourFileName2#">
    <cfheader name="Content-Description" value="This is a tab-delimited file.">
    <cfcontent type="Multipart/Report" file="#yourFileName#">
    <cflocation url="#yourFileName#">

<cfelseif aps_qry.entryno eq "47">  <!--- CIMB SG APS format --->
 		
    <cfquery name="gettotal" dbtype="query">
    	SELECT sum(netpay) as totalnet FROM getPaytran_qry
    </cfquery>
    <cfoutput>

	<!--- header data verification --->
    <cfset error = "">
	<cfif len(acBank_qry.com_accno) gt 10>
    	<cfset error = "Acc no must be within 10 digits" & chr(13)>
	</cfif>
	<cfif len(acBank_qry.com_name_f) gt 140>
    	<cfset error = "Company name must be within 140 characters"  & chr(13)>
	</cfif>
	<cfif len(numberformat(gettotal.totalnet,'.__')) gt 16>
    	<cfset error = "Total amount must be within range of 9(13).9(5)"  & chr(13)>
	</cfif>
	<cfif len(getPaytran_qry.recordcount) gt 5>
    	<cfset error = "Total transaction must be within 5 digits"  & chr(13)>
	</cfif>
	<cfif datecompare(now(),form.cdate) gt 0>
    	<cfset error = "Date must be later than today"  & chr(13)>
	</cfif>
    
    <cfset header = "3%"&replace(acBank_qry.com_accno,'-','',"all")&"%"&acBank_qry.com_name_f&"%SGD%"&
					numberformat(gettotal.totalnet,'.__')&"%"&
					getPaytran_qry.recordcount&"%B%C%"&dateformat(form.cdate,'DDMMYYYY')>
	
    <cffile action = "write" 
        file = "#filedir#" 
        output = "#header#" nameconflict="overwrite">

    <cfloop query="getPaytran_qry">
    
			<!---record--->
        <cfif len(getPaytran_qry.bankaccno) gt 34>
            <cfset error = getPaytran_qry.empno & " - Receiver acc no must be within 34 characters"  & chr(13)>
        </cfif>
        <cfif len(getPaytran_qry.name) gt 140>
            <cfset error = getPaytran_qry.empno & " - Receiver name must be within 140 characters"  & chr(13)>
        </cfif>
        <cfif len(numberformat(getPaytran_qry.netpay,'.__')) gt 16>
            <cfset error = getPaytran_qry.empno & " - Net pay must be within range of 9(13).9(5)"  & chr(13)>
        </cfif>
        <cfquery name="getswift" datasource="#dts_main#">
            SELECT swiftcode FROM bankcode WHERE bankcode = '#getPaytran_qry..bankcode#'
        </cfquery>
<!---        <cfif len(getswift.swiftcode&getPaytran_qry.brancode) neq 11>
            <cfset error = getPaytran_qry.empno & " - Bank swiftcode must be 11 characters with swiftcode(8) 
            + branch code(3)"  & chr(13)>
        </cfif>--->
<!---        <cfif len(getswift.swiftcode&"XXX" neq 11> <!---update new info from bank, [20160919 by Max Tan]--->
            <cfset error = getPaytran_qry.empno & " - Bank swiftcode must be 11 characters with swiftcode(8) 
            + branch code(3)"  & chr(13)>
        </cfif>
        <cfif find("@",getPaytran_qry.email) eq 0 and getPaytran_qry.email neq "">
            <cfset error = getPaytran_qry.empno & " - Email is incorrect"  & chr(13)>
        </cfif>
    
		<cfset record = replace(getPaytran_qry.bankaccno,'-','',"all")&"%"&getPaytran_qry.name&"%"&
						numberformat(getPaytran_qry.netpay,'.__')&"%SGD%"&getPaytran_qry.swiftcode&
						getPaytran_qry.brancode&"%SALA%PAYROLL%"&getPaytran_qry.empno&"%"&getPaytran_qry.email>
    --->
        
        <cfif len(getswift.swiftcode&"XXX") neq 11> <!---update new info from bank, [20160919 by Max Tan]--->
            <cfset error = getPaytran_qry.empno & " - Bank swiftcode must be 11 characters with swiftcode(8)"  & chr(13)>
        </cfif>
        <cfif find("@",getPaytran_qry.email) eq 0 and getPaytran_qry.email neq "">
            <cfset error = getPaytran_qry.empno & " - Email is incorrect"  & chr(13)>
        </cfif>
    
		<cfset record = replace(getPaytran_qry.bankaccno,'-','',"all")&"%"&getPaytran_qry.name&"%"&
						numberformat(getPaytran_qry.netpay,'.__')&"%SGD%"&getPaytran_qry.swiftcode&
						"XXX%SALA%PAYROLL%%">
    
    <cfif error neq "">
	    #error#
    	<cfabort>                    
    </cfif>
    
    <cffile action = "append"
       file = "#filedir#"
       output = "#record#" nameconflict="overwrite">

	</cfloop>
    
<!---    <cfoutput>
    #record#123
    </cfoutput>
    
  <cfabort>--->
    <cfset filename="#acBank_qry.aps_file#">
    
    <cfset yourFileName="#filedir#">
    <cfset yourFileName2="#filename#.csv">
     
     <cfcontent type="application/x-unknown"> 
    
     <cfset thisPath = ExpandPath("#yourFileName#")> 
     <cfheader name="Content-Disposition" value="attachment; filename=#yourFileName2#">
    <cfheader name="Content-Description" value="This is a tab-delimited file.">
    <cfcontent type="Multipart/Report" file="#yourFileName#">
    <cflocation url="#yourFileName#">


    </cfoutput>
    
<cfelseif aps_qry.entryno eq "17"> <!---SG SCB--->
    <cfinclude template="SG/scb.cfm">
    
<cfelse>
<cfset total_record_count = 0 >
            		
	<cfif #form.aps_num2# neq 0>
		<cfset startwrite = 0>
        <cfset SERIALNO = 50000>
		<cfset var1 = "0">
			<cfloop condition="len(var1) lt #aps_qry.btnuml#">
					<cfset var1 = var1 &"0">
			</cfloop>
		<cfset BT_NUM = #numberformat(form.Batch_No,var1)# >
        
        
        <cfif acBank_qry.org_code neq "">
		<cfif len(#acBank_qry.org_code#) eq aps_qry.orbankl>
            <cfset OR_BANK = #acBank_qry.org_code#>
        <cfelseif val(aps_qry.orbankl) eq 0>
        	<cfset OR_BANK = ''>
        <cfelseif len(#acBank_qry.org_code#) lt aps_qry.orbankl>
        <cfoutput>
        <h1>Organization Code is Invalid</h1>
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
			<cfif len(OR_NAME) gt aps_qry.ornamel and val(aps_qry.ornamel) neq 0>
            <cfset or_name = left(or_name,aps_qry.ornamel)>
			</cfif>
            
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
		
		<cfloop query="getPaytran_qry">
        
			<cfset batchdetail_for = #aps_qry.RCREC1#>
			<cfset batchdetail_for = Replace(batchdetail_for,"+","&","all") >
			
			<cfif getPaytran_qry.bankcode neq "" >
				<cfif len(getPaytran_qry.bankcode) eq aps_qry.rcbankl>
					<cfset RC_BANK = #getPaytran_qry.bankcode#>
				</cfif>
			</cfif>
			
			<cfif getPaytran_qry.brancode neq "">
				<cfif len(getPaytran_qry.brancode) eq aps_qry.rcbranl>
					<cfset RC_BRAN = #getPaytran_qry.brancode#> 
				</cfif>
			</cfif>
						
			<cfset RC_ACCNO = #trim(getPaytran_qry.bankaccno)#>
			<cfset RC_ACCNO = Replace(RC_ACCNO,"-","","all")>
			<cfloop condition="len(RC_ACCNO) lt #aps_qry.rcaccnol#">
				<cfset RC_ACCNO = RC_ACCNO &" ">
			</cfloop>
            <cfif len(RC_ACCNO) neq aps_qry.rcaccnol>
            	<cfset RC_ACCNO = right(RC_ACCNO,aps_qry.rcaccnol)>
			</cfif>
            
			
			<cfif getPaytran_qry.name neq "">
				<cfset RC_NAME = #getPaytran_qry.name#>
				<cfif len(RC_NAME) lt #aps_qry.rcnamel#>
					<cfloop condition="len(RC_NAME) lt #aps_qry.rcnamel#">
						<cfset RC_NAME = RC_NAME &" ">
					</cfloop>
				<cfelse>
					<cfset RC_NAME = Left(getPaytran_qry.name, aps_qry.rcnamel)>
				</cfif>
			</cfif>
			
			<!---<cfif left(dts,4) eq "beps">
            <cfset nett = (val(getpaytran_qry.netpay)+numberformat(getpaytran_qry.totalamtnew,'.__')-numberformat(getpaytran_qry.totalded,'.__')) * 100>
            <cfelse>--->
			<cfset nett = #numberformat(val(getPaytran_qry.netpay),'.__')# * 100>
            <!---</cfif>--->
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
           EMPNO - #getPaytran_qry.empno#<br/> 
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
				<font color="red"><th>Data Imcompletion Found.<br/>Please Click <input type="button" name="checkimcomplete" value="Here" onclick="window.location.href='/payments/checkincomplete.cfm?paytype=2&bankcat=#acBank_qry.category#'"  /> To Check<th></font> </cfoutput>
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
				SELECT <cfif left(dts,4) eq "beps">sum(c.netpay)+sum(round(d.totalamtnew+0.00000001,2))-sum(round(d.totalded+0.00000001,2))<cfelse>sum(netpay)</cfif> as sumnetpay FROM #url.type# as c left join pmast as p on c.empno = p.empno 
                <!---<cfif left(dts,4) eq "beps">
LEFT JOIN
(
select empno as aemp,sum(if(claimadd1 = 'Y',coalesce(addchargeself,0),0)+if(claimadd2 = 'Y',coalesce(addchargeself2,0),0)+if(claimadd3 = 'Y',coalesce(addchargeself3,0),0)+if(claimadd4 = 'Y',coalesce(addchargeself4,0),0)+if(claimadd5 = 'Y',coalesce(addchargeself5,0),0)+if(claimadd6 = 'Y',coalesce(addchargeself6,0),0)) as totalamtnew,sum(coalesce(ded1,0)+coalesce(ded2,0)+coalesce(ded3,0)) as totalded from #replace(dts,'_p','_i')#.assignmentslip where month(assignmentslipdate) = "#company_details.mmonth#" and year(assignmentslipdate) = "#company_details.myear#" and paydate = "paytran"
 group by empno
) as d
on c.empno = d.aemp
</cfif>--->
				where c.netpay <> "0" and p.bankaccno <> "" and paymeth ="B" and p.bankcat = "#acBank_qry.category#" 
				<!---<cfif left(dts,4) eq "beps">
<cfif form.batch neq ''>
<cfif getempnolist.recordcount neq 0>
and p.empno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#valuelist(getempnolist.empno)#" list="yes" separator=",">)
</cfif>
</cfif>
</cfif>--->
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

 <cfcatch type="any">
 <cfset status_msg="Fail To generate disk. Error Message : "&cfcatch.Detail>
 <cfoutput>
 <script type="text/javascript">
 alert("#status_msg#");
 window.location.href="/payments/2ndHalf/cashBankOthers/thruBankMainData.cfm?id=#form.category#";
 </script>
 </cfoutput>
 </cfcatch>
 </cftry> --->