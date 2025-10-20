<cfsetting requesttimeout="300">
<cfoutput>

<cfif trim(url.list) eq ''>
    <script>
    alert("List is empty");
    window.open("generateinvform.cfm","_self");
    </script>
    <cfabort>
</cfif>

<cfset c =1>
<cfcache action="flush">
<cfquery name="getassignment" datasource="#dts#" >
SELECT * from assignmentslip 
where 
refno in (
<cfqueryparam cfsqltype="cf_sql_varchar" list="true" separator="," value="#url.list#">
)
</cfquery>

<cfif getassignment.recordcount eq 0>
    <script>
    alert("Assignmentslip not found or empty");
    window.open("generateinvform.cfm","_self");
    </script>
    <cfabort>
</cfif>

<cfloop query="getassignment">

<cfset fperiod = numberformat(getassignment.payrollperiod,'00')>

<cfquery name="getposition" datasource="#dts#">
      select position,invoicegroup,location,po_no,jobpostype from placement where placementno='#getassignment.placementno#'
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

<cfquery name="getcustname" datasource="#dts#">
            select name,term,currcode,currency from #target_arcust# where custno='#getassignment.custno#'
      </cfquery>

<cfif getcustname.currcode eq ''>
    <cfset getcustname.currcode = "MYR">
</cfif>            

<cfquery name='getempinfo' datasource='#dts#'>
      select sex from placement where empno='#getassignment.empno#'
</cfquery>

<cfif getassignment.assignmenttype neq 'invoice'>
			<cfset assignmentno = getassignment.refno>
            <cfquery name="checkinvoiceexist" datasource="#dts#">
                  SELECT refno FROM artran WHERE 
                  type = "INV" 
                  AND fperiod <> "99"
                  AND rem11 = "#getassignment.assignmenttype#"
                  and month(wos_date) = "#dateformat(getassignment.assignmentslipdate,'m')#"
                  and year(wos_date) = "#dateformat(getassignment.assignmentslipdate,'yyyy')#"
                  and custno = "#getassignment.custno#"
                  and (posted='' or posted is null)
                and fperiod="#fperiod#"
            </cfquery>
			<cfif checkinvoiceexist.recordcount eq 0>
            <br><br> Not Found
            <cfelse>
				  <cfset refnofound = checkinvoiceexist.refno>
                  <br><br> Found:  <cfdump var="#refnofound#"> for assignment #assignmentno#
                  <cfquery name="updateinv" datasource="#dts#">
                  UPDATE assignmentslip SET invoiceno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#refnofound#"> WHERE refno = "#assignmentno#"
                  </cfquery>
            </cfif>
      </cfif>
      <cfset assignmentslipno = getassignment.refno>
      <cfif getassignment.assignmenttype neq "invoice" and isdefined('refnofound') eq false>
		<cfquery name="checkentity" datasource="#dts#">
                  SELECT location,jobpostype,custno FROM placement WHERE placementno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.placementno#">
            </cfquery>
            <cfquery name="getlastno" datasource="#dts#">
                  SELECT invnogroup FROM bo_jobtypeinv WHERE officecode = "#checkentity.location#" 
                  AND jobtype = "#checkentity.jobpostype#"
            </cfquery>
            <cfquery name="getlastusedno" datasource="#dts#">
                  SELECT lastusedno FROM invaddress WHERE 
                  invnogroup = "#getlastno.invnogroup#"
            </cfquery>
            <cfset refnoinv = getlastusedno.lastusedno>
            <!---<br>getlastusedno query: <cfdump var="#getlastusedno#">
            <br>lastusedno: <cfdump var="#refno#">--->
            <cftry>
                  <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refnoinv#" returnvariable="refnonew"/>
                  <cfcatch>
                        <cfinvoke component="cfc.refno" method="processNum" oldNum="#refno#" returnvariable="refnonew" />	
                  </cfcatch>
            </cftry>
            
            <cfset refnoinv = refnonew>
            <!---<br>Refno: <cfdump var="#refno#">--->
            <cfquery name="checkexistrefno" datasource="#dts#">
                  select refno from artran where type='INV' and refno=<cfqueryparam cfsqltype="cf_sql_varchar" value="#refnoinv#">
            </cfquery>
           <!--- <br> checkexistrefno: <cfdump var="#checkexistrefno#">
            <cfabort>--->
            <cfif checkexistrefno.recordcount neq 0>
				  <cfset refnocheck = 0>
                  <cfloop condition="refnocheck eq 0">
                        <cftry>
                              <cfinvoke component="cfc.IncrementValue" method="getIncreament" input="#refnoinv#" returnvariable="refnonew"/>
                              <cfcatch>
                                    <cfinvoke component="cfc.refno" method="processNum" oldNum="#refno#" returnvariable="refnonew" />	
                              </cfcatch>
                        </cftry>
						<cfset refnoinv = refnonew>
                        <cfquery name="checkexistrefno" datasource="#dts#">
                              select refno from artran where type='INV' and refno = "#refnoinv#"
                        </cfquery>
                         <!---<br> checkexistrefno: <cfdump var="#checkexistrefno#">
            			<cfabort>--->
                        <cfif checkexistrefno.recordcount eq 0>
							  <cfset refnocheck = 1>
                        </cfif>
                  </cfloop>                
            </cfif>
            <cfset form.refno = refnoinv>
            <!---<br> Form. refno: <cfdump var="#form.refno#">
            <cfabort>--->
            </cfif>
            
<cfif getassignment.custtotalgross neq 0>
<cfif isdefined('refnofound') eq false>
<cfquery name="insertartran" datasource="#dts#">
                        INSERT INTO artran
                        (type,refno,refno2,trancode,custno,fperiod,wos_date,desp,despa,agenno,source,job,currrate,gross_bil,disc1_bil,disc2_bil,disc3_bil,disc_bil,net_bil,tax1_bil,tax_bil,grand_bil,debit_bil,credit_bil,invgross,disp1,disp2,disp3,discount1,discount2,discount3,discount,net,tax1,tax,taxp1,grand,debitamt,creditamt,frem0,frem1,frem2,frem3,frem4,frem5,frem6,frem7,frem8,rem0,rem1,rem2,rem3,rem4,rem12,rem13,rem14,comm0,comm1,comm2,comm3,comm4,taxincl,note,created_by,created_on,rem10,PONO,DONO,userid,name,trdatetime,van,term,area,currcode,rem40<cfif getassignment.assignmenttype neq "invoice">,rem11,rem15</cfif>,rem30)
                        values
                        (
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="INV">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.custno#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#fperiod#">,
                        <cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(getassignment.assignmentslipdate,'yyyy-mm-dd')#">,
                        <cfif getempinfo.sex eq "Female" or getempinfo.sex eq "F">
                            "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Ms #getassignment.empname# - #getposition.position#"
                        <cfelse>
                        "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Mr #getassignment.empname# - #getposition.position#"
                        </cfif>
                        ,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#trim(getassignment.custtotalgross)#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#getassignment.custtotalgross#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#getassignment.taxamt#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#getassignment.taxamt#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#getassignment.custtotal#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#getassignment.custtotal#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#getassignment.custtotalgross#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#getassignment.custtotalgross#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#getassignment.taxamt#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#getassignment.taxamt#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#getassignment.taxper#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#getassignment.custtotal#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="#getassignment.custtotal#">,
                        <cfqueryparam cfsqltype="cf_sql_double" value="0">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(getassignment.custname2,45)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(getassignment.custname2,45)#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="Profile">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="Profile">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustname.currcode#">,
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
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.taxcode#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.created_by#">,
                        now(),
                        <cfif getempinfo.sex eq "Female" or getempinfo.sex eq "F">
                              "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Ms #getassignment.empname# - #getposition.position#"
                        <cfelse>
                              "Being services rendered from #dateformat(startdate,'DD/MM/YYYY')# to #dateformat(completedate,'DD/MM/YYYY')# by Mr #getassignment.empname# - #getposition.position#"
                        </cfif>,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getassignment.created_by#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#left(getassignment.custname2,45)#">,
                        now(),
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <Cfif getcustname.term eq "">
                              <cfqueryparam cfsqltype="cf_sql_varchar" value="14">,
                        <cfelse>
                              <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustname.term#">,
                        </Cfif>
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#getcustname.currcode#">,"#assignmentslipno#"<cfif getassignment.assignmenttype neq "invoice">,
                        "#getassignment.assignmenttype#"
                        ,"#assignmentslipno#"
                        </cfif>
                        ,"#getaddress.shortcode#"
                        )
                  </cfquery>
                  <cfif getassignment.assignmenttype neq "invoice">
                        <cfquery name="updateinv" datasource="#dts#">
                              UPDATE assignmentslip SET invoiceno = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.refno#"> 
                              WHERE refno = "#assignmentno#"
                        </cfquery>
                        <cfquery name="updatelastusedno" datasource="#dts#">
                              UPDATE invaddress SET lastusedno = "#form.refno#" WHERE 
                              invnogroup = "#getlastno.invnogroup#"
                        </cfquery>
                  </cfif>
                  <br>#c#. Created #form.refno#: #assignmentslipno#
                  <cfset c+=1>
           <cfelse> <!-- Line 717, 826, 831 -->
                  <cfset form.refno = refnofound> <!-- this line here extend the list of assignment slip number in remark15 -->
                  <cfquery name="refreshrem15" datasource="#dts#"> 
                  SELECT rem15 FROM artran
                  WHERE refno="#refnofound#"
                  </cfquery>
                  <!---<br>#assignmentslipno# #refreshrem15.rem15#
                  <br>#not listfind(refreshrem15.rem15,assignmentslipno)#--->
                  
                  <br><br>#c#. String before combine into #refnofound#: #quotedvaluelist(refreshrem15.rem15)#
                  <br>Combined into #refnofound#: #assignmentslipno#
                  <cfset c+=1>
                  
				  <cfif not listfind(refreshrem15.rem15,assignmentslipno) >              
                  <cfquery name="updaterem15" datasource="#dts#"> 
                        UPDATE artran SET rem15 = concat(#quotedvaluelist(refreshrem15.rem15)#,',#assignmentslipno#') 
                        WHERE refno = "#refnofound#" and type = "INV"
                  </cfquery>
                  </cfif>
                  
            </cfif>
            
            <cfinclude template="/default/transaction/assignmentslipnewnew//genictranbody.cfm">
</cfif>


<script type="text/javascript">
console.log('Done '+Date.now());
</script>

<cfset StructDelete(Variables, "refnofound") />
<cfif isdefined('checkassign')>
	<cfset StructDelete(Variables,"checkassign")>
</cfif>

<cfif isdefined('getlatesttrancode')>
	<cfset StructDelete(Variables,"getlatesttrancode")>
</cfif>
<br> #isdefined('refnofound')#

</cfloop>

<br> Invoice Generation Done



</cfoutput>