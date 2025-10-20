<!---Added by Nieo 20171103 1105 to centralize code to paytra1 folder--->
<cfinclude template="/Report/BEPS/batchapproval/paytra1/generateThruBankViaDiskette.cfm">

<!---Commented by Nieo 20171103 1105 to centralize code to paytra1 folder--->
<!---<!---<cfif form.giropaydate neq "">
	<cfquery datasource="#dts#">
		UPDATE assignmentslip set giropaydate = '#form.giropaydate#' WHERE batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batch#" list="yes" separator=",">)
	</cfquery>
</cfif>--->
<cfif isdefined('form.batch') eq false>
	<cfoutput>
	<script type="text/javascript">
		alert('Please Choose At Least One Batch!');
	window.close();
	</script>
	</cfoutput>
	<cfabort>
</cfif>

<cfset dts_p = replace(dts,'_i','_p')>
<cfset hcomid = replace(dts,'_p','')>
<cfset DTS_MAIN = "payroll_main">

<cfif form.batch neq ''>
<cfquery name="getempnolist" datasource="#replace(dts,'_p','_i')#">
SELECT empno FROM assignmentslip WHERE batches in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batch#" list="yes" separator=",">)
</cfquery>
    
<cfquery name="updategenerated" datasource="#dts#">
UPDATE argiro
SET generated_on=now(),
    generated_by=<cfqueryparam cfsqltype="cf_sql_varchar" value="#Huserid#">
WHERE batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batch#" list="yes" separator=",">) 
AND appstatus='Approved'
</cfquery>
</cfif>

<cfquery name="getbatches" datasource="#dts#">
select uuid from argiro
where batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batch#" list="yes" separator=",">)
and trim(appstatus) = "Approved"
</cfquery>

<cfquery name="getpaytra1_qry" datasource="#dts#">
select a.batchno,a.giropaydate,sum(a.netpay) as netpay,b.name,b.bankcode,b.bankaccno,b.nric,b.nricn,b.passport from icgiro as a
inner join #dts_p#.pmast as b on a.empno=b.empno
where uuid in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#getbatches.uuid#" list="yes" separator=",">)
and batchno in (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.batch#" list="yes" separator=",">)
and generated_on = '0000-00-00 00:00:00'
group by a.empno
having netpay>0
</cfquery>

<cfset filenewdir = "C:\Inetpub\wwwroot\payroll\download\#dts#\">
			<cfif DirectoryExists(filenewdir) eq false>
            <cfdirectory action = "create" directory = "#filenewdir#" >
            </cfif>
            <cfset filedir = filenewdir&"file"&huserid&".txt">

            <cfset startwrite = 1>
            <cfoutput>
            <cfset header = 'H'>

            <cfset headtemp = 'MANPOWER'>
            <cfset format = 20 - len('#headtemp#')>
            <cfloop index="i" from="1" to="#format#">
            	<cfset headtemp = headtemp & " ">
            </cfloop>
            <cfset header = header & headtemp>

            <cfset pir_ref =  ReReplaceNoCase(left('#trim(form.pir_refno)#',20),'[^a-zA-Z0-9]','','ALL') >
            <cfset headtemp = left('#pir_ref#',20)>
            <cfset format = 20 - len('#headtemp#')>
            <cfloop index="i" from="1" to="#format#">
            	<cfset headtemp = headtemp & " ">
            </cfloop>
            <cfset header = header & headtemp&'B'>

           <!--- #header#
            <cfabort>--->

            <cffile action = "write"
                        file = "#filedir#"
                        output = "#header#" nameconflict="overwrite">

			<cfset tranno = 0>
            <cfset totalamt = 0>
			<cfset amtformat = '000000000000000'>

            <!---start generating content--->
            <cfloop query="getpaytra1_qry">

            <cfset netpayamt = ReReplaceNoCase(Numberformat(getpaytra1_qry.netpay,'_.__'),"[^0-9]","","ALL")>            
            <cfset formatpay = '#amtformat##netpayamt#'>
            <cfset amtformattemp = right(formatpay,15)>
            <cfset oldicformat = ReReplaceNoCase(getpaytra1_qry.nric,"[^0-9]","","ALL")>
            <cfset newicformat = ReReplaceNoCase(getpaytra1_qry.nricn,"[^0-9]","","ALL")>

            <cfset format = 20 - len('#pir_ref#')>
            <cfloop index="i" from="1" to="#format#">
            	<cfset pir_ref = pir_ref & " ">
            </cfloop>
            <!---data set 1 to 3--->
			<cfset data = 'D#pir_ref#PAYMENT'>
            <cfset datatemp = right('#data#',41)>
            <cfset format = 41 - len('#datatemp#')>
            <cfloop index="i" from="1" to="#format#">
            	<cfset datatemp = datatemp & " ">
            </cfloop>

            <!---data set 4--->
            <cfset data = datatemp>
            <cfset datatemp = right('#amtformattemp#',15)>
            <cfset format = 15 - len('#datatemp#')>
            <cfloop index="i" from="1" to="#format#">
            	<cfset datatemp = datatemp & " ">
            </cfloop>
            <cfset data = data & datatemp>

            <!---data set 5--->
            <cfset datatemp = right('514011369111',20)>
            <cfset format = 20 - len('#datatemp#')>
            <cfloop index="i" from="1" to="#format#">
            	<cfset datatemp = datatemp & " ">
            </cfloop>
            <cfset data = data & datatemp>

            <!---data set 6--->
            <cfset datatemp = ''>
            <cfset format = 14 - len('#datatemp#')>
            <cfloop index="i" from="1" to="#format#">
            	<cfset datatemp = datatemp & " ">
            </cfloop>
            <cfset data = data & datatemp>

            <!---data set 7--->
            <cfset datatemp = ''>
            <cfset format = 40 - len('#datatemp#')>
            <cfloop index="i" from="1" to="#format#">
            	<cfset datatemp = datatemp & " ">
            </cfloop>
            <cfset data = data & datatemp>

            <!---data set 8--->
            <cfset datatemp = right("#ReReplaceNoCase(dateformat(getpaytra1_qry.giropaydate, 'yyyymmdd'),'[^0-9]','','ALL')#",8)>
            <cfset format = 8 - len('#datatemp#')>
            <cfloop index="i" from="1" to="#format#">
            	<cfset datatemp = datatemp & " ">
            </cfloop>
            <cfset data = data & datatemp>

            <!---data set 9--->
            <cfset datatemp = "">
            <cfset format = 8 - len('#datatemp#')>
            <cfloop index="i" from="1" to="#format#">
            	<cfset datatemp = datatemp & " ">
            </cfloop>
            <cfset data = data & datatemp>

            <!---data set 10--->
            <cfset datatemp = "">
            <cfset format = 1 - len('#datatemp#')>
            <cfloop index="i" from="1" to="#format#">
            	<cfset datatemp = datatemp & " ">
            </cfloop>
            <cfset data = data & datatemp>

            <!---data set 11--->
            <cfset datatemp = "#trim(getpaytra1_qry.bankcode)#">
            <cfset format = 11 - len('#datatemp#')>
            <cfloop index="i" from="1" to="#format#">
            	<cfset datatemp = datatemp & " ">
            </cfloop>
            <cfset data = data & datatemp>

            <!---data set 12--->
            <cfset datatemp = "#trim(ReReplaceNoCase(getpaytra1_qry.bankaccno,'[^0-9]','','ALL'))#">
            <cfset format = 20 - len('#datatemp#')>
            <cfloop index="i" from="1" to="#format#">
            	<cfset datatemp = datatemp & " ">
            </cfloop>
            <cfset data = data & datatemp>

            <!---data set 13--->
            <cfset datatemp = left("#ReReplaceNoCase(trim(getpaytra1_qry.name),'[^a-zA-Z ]','','ALL')#",40)>
            <cfset format = 40 - len('#datatemp#')>
            <cfloop index="i" from="1" to="#format#">
            	<cfset datatemp = datatemp & " ">
            </cfloop>
            <cfset data = data & datatemp>

            <!---data set 14 bene new ic--->
			<cfset datatemp = right("#trim(ReReplaceNoCase(newicformat,'[^0-9]','','ALL'))#",15)>
            <cfset format = 15 - len('#datatemp#')>
            <cfloop index="i" from="1" to="#format#">
                <cfset datatemp = datatemp & " ">
            </cfloop>
            <cfset data = data & datatemp>


             <!---data set 15 bene old ic--->
            <cfset datatemp = "#trim(ReReplaceNoCase(oldicformat,'[^0-9]','','ALL'))#">
            <cfset format = 8 - len('#datatemp#')>
            <cfloop index="i" from="1" to="#format#">
            	<cfset datatemp = datatemp & " ">
            </cfloop>
            <cfset data = data & datatemp>

             <!---data set 16 bene business reg--->
            <cfset datatemp = right("",40)>
            <cfset format = 20 - len('#datatemp#')>
            <cfloop index="i" from="1" to="#format#">
            	<cfset datatemp = datatemp & " ">
            </cfloop>
            <cfset data = data & datatemp>

            <!---data set 17 bene passport--->
            <cfset datatemp = right("#ReReplaceNoCase(trim(getpaytra1_qry.passport),'[^a-zA-Z0-9]','','ALL')#",40)>
            <cfset format = 20 - len('#datatemp#')>
            <cfloop index="i" from="1" to="#format#">
            	<cfset datatemp = datatemp & " ">
            </cfloop>
            <cfset data = data & datatemp>

            <!----------------->

			<cfset totalamt +=  val(getpaytra1_qry.netpay)>

             <cffile action="append" addnewline="yes" charset="utf-8"
                        file = "#filedir#"
                        output = "#data#">

            <cfset tranno = tranno +1>
            </cfloop>

			<!--- ADDED NUMBER FORMAT TO totalamt --->
			<cfset totalamt = ReReplaceNoCase(NumberFormat(totalamt,'_.__'),"[^0-9]","","ALL")>

            <cfset tranformat = right('00000#tranno#',5)>
            <cfset totalformat = right('#amtformat##totalamt#',15)>
            <cfset footer = 'T#tranformat##totalformat#0000000000022014'>

            <cffile action="append" addnewline="yes" charset="utf-8"
                        file = "#filedir#"
                        output = "#footer#">
            </cfoutput>



<!---<cfabort>--->

<cfset filename="DATAFILE">


		<cfset yourFileName="#filedir#">
		<cfset yourFileName2="#filename#.txt">

		 <cfcontent type="application/x-unknown">

		<cfset thisPath = ExpandPath("#yourFileName#")>
		<cfheader name="Content-Disposition" value="attachment; filename=#yourFileName2#">
		<cfheader name="Content-Description" value="This is a tab-delimited file.">
		<cfcontent type="Multipart/Report" file="#yourFileName#">
		<cflocation url="#yourFileName#">--->