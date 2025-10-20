<cfoutput>
<cfquery name="gsetup_qry" datasource="payroll_main">
    SELECT ccode,comp_name,mmonth,myear from gsetup where comp_id = '#HcomID#'
</cfquery>

<cfset Hmmonth = gsetup_qry.mmonth>
<cfset Hmyear = gsetup_qry.myear>
<!---   HEADER --->
<cfset error = "">
<cfset result = "">
<cfset count = 1>
<cfset header = "">
<cfset hdr1 = "00">
<cfset hdr2= acBank_qry.com_id>
<cfif hdr2 eq "" or len(hdr2) gt 22>
    <cfset error = error & 'Line 1 - Header no. 2: Corporate ID exceeds 30 characters or empty.<br />'>
</cfif>
<cfset form.batch_no = 001>
<cfset hdr3=  form.batch_no>


<cfloop from="1" to="29" index="i">
    <cfif i gte 4>
        <cfset header = header & "|">
        <cfset result = result & "|">
    <cfelse>
        <cfset header = header & evaluate("hdr#i#") & "|">
        <cfset result = result & evaluate("hdr#i#") & "|">
    </cfif>
    <cfif i eq 29> 
        <cffile action = "write" 
                file = "#filedir#" 
                output = "#header#" nameconflict="overwrite">
        <cfset result = result & "<br />">
    </cfif>
</cfloop>
<!---   end of HEADER   --->

<!---   RECORDS --->

<cfset sumpay = 0>
<cfset totalhash = 0>

<cfloop query="getempicno">
	<cfquery name="getGenbankfileinfo" datasource="#dts#">
    SELECT * FROM geninvbankfile
    WHERE paybillprofileid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.profileid#">
    </cfquery>
    <cfquery name="getemplist" datasource="#dts#">
    SELECT * FROM cfsemp
    WHERE id =<cfqueryparam cfsqltype="cf_sql_varchar" value="#getempicno.empno#"> 
    </cfquery>
    <cfset count += 1>
    <cfset record = "">
    <cfset rcd1 = "01">
    <cfset rcd2 = "IT">
    <!---<cfif getPaytran_qry.bankcode neq "MBBB">
        <cfset rcd2 = "IG">
    </cfif>--->
    <cfset rcd3 = "Staff Payroll">
    <cfset rcd4 = "">
    <cfset rcd5 = dateformat(form.cdate,'DDMMYYYY')>
    <cfset rcd6 = "">
    <cfset rcd7 = "">
    <cfset rcd8 = getemplist.icno&hmmonth&hmyear>
    <cfset rcd9 = "Payroll-"&hmmonth&hmyear>
    <cfset rcd10 = "">
    <cfset rcd11 = "MYR">
    <cfset rcd12 = numberformat(getGenbankfileinfo.payamt,'.__')>
    <cfset rcd13 = "N">
    <cfset rcd14 = "MYR">
    <cfset rcd15 = acBank_qry.com_accno>
    <cfset rcd16 = getemplist.bankaccno>
    <cfif len(rcd16) lte 6 or len(rcd16) gt 35>
        <cfset error = error & 'Line ' & #count# & ' - Record no. 6  employee bank account no. exceeds 35 characters or wrong format.<br />'>
    </cfif>
    <cfset rcd17 = getemplist.bankaccno>
    <cfset rcd18 = "">
    <cfset rcd19 = "">
    <!---<cfif getPaytran_qry.national eq "MY">
        <cfset rcd19 = "Y">
    </cfif>--->
    <cfset rcd20 = "">
    <cfset rcd21 = "">
    <cfset rcd22 = "">
    <cfif len(getemplist.bankpersonname) gte 0 and len(getemplist.bankpersonname) lte 40>
        <cfset rcd20 = getemplist.bankpersonname>
    <cfelseif len(getemplist.bankpersonname) gte 41 and len(getemplist.bankpersonname) lte 80>
        <cfset rcd20 = left(getemplist.bankpersonname,40)>
        <cfset rcd21 = mid(getemplist.bankpersonname,41,80)>
    <cfelseif len(getemplist.bankpersonname) gte 81 and len(getemplist.bankpersonname) lte 120>
        <cfset rcd20 = left(getemplist.bankpersonname,40)>
        <cfset rcd21 = mid(getemplist.bankpersonname,41,80)>
        <cfset rcd22 = mid(getemplist.bankpersonname,81,120)>
    </cfif>
    <cfset rcd23 = "">
    <cfset rcd24 = "">
    <cfset rcd25 = "">
    <cfset rcd26 = getemplist.icno>
    <cfset rcd27 = "">
    <cfif isdefined('getemplist.bankcompregno')>
		<cfif len(getemplist.bankcompregno) gte 0 and len(getemplist.bankcompregno) lte 20>
            <cfset rcd27 = getemplist.bankcompregno>
        <cfelseif len(getemplist.bankcompregno) lte 20>
            <cfset error = error & 'Line ' & #count# & ' - Record no. 6  employee bank account no. exceeds 35 characters or wrong format.<br />'>
        </cfif>
    </cfif>
    <cfset rcd28 = "">
    <cfset rcd29 = getemplist.add1>
    <cfset rcd30 = getemplist.add2>
    <cfset rcd31 = "">
    <cfset rcd32 = "">
    <cfset rcd33 = "">
    <cfset rcd34 = "">
    <cfset rcd35 = "">
    <cfset rcd36 = "">
    <cfset rcd37 = ""> <!---swift code--->
    <cfset rcd38 = "">
    <cfset rcd39 = "">
    <cfset rcd40 = "">
    <cfset rcd41 = "">
    <cfset rcd42 = "">
    <cfset rcd43 = "">
    <cfset rcd44 = "">
    <cfset rcd45 = "">
    <cfset rcd46 = "">
    <cfset rcd47 = "">
    <cfset rcd48 = "">
    <cfset rcd49 = "">
    <cfset rcd50 = "">
    <cfset rcd51 = "">
    <cfset rcd52 = "">
    <cfset rcd53 = "">
    <cfset rcd54 = "">
    <cfset rcd55 = "">
    <cfset rcd56 = "">
    <cfset rcd57 = "">
    <cfset rcd58 = "">
    <cfset rcd59 = "">
    <cfset rcd60 = "">
    <cfset rcd61 = "">
    <cfset rcd62 = "">
    <cfset rcd63 = "">
    <cfset rcd64 = "">
    <cfset rcd65 = "">
    <cfset rcd66 = "">
    <cfset rcd67 = "">
    <cfset rcd68 = "">
    <cfset rcd69 = "">
    <cfset rcd70 = "">
    
<!---    <cfset rcd102 = "">
    <cfset rcd103 = "">
    <cfset rcd104 = "">
    <cfset rcd105 = "">
    <cfset rcd106 = "">
    <cfset rcd107 = "">
    <cfset rcd108 = "">
    <cfset rcd109 = "">--->
    <cfset rcd110 = "01">
    <cfset rcd111 = "Payroll">
    
    <cfset rcd145 = "">
    <cfset rcd146 = "">
    <cfset rcd147 = "">
    <cfset rcd148 = "">

    <cfloop from="1" to="500" index="i">
        <cfif (i gte 71 and i lte 109) or (i gte 112 and i lte 500)>
            <cfset record = record & "|">
            <cfset result = result & "|">
        <cfelse>
            <cfset record = record & evaluate("rcd#i#") & "|">
            <cfset result = result & evaluate("rcd#i#") & "|">
        </cfif>
        <cfif i eq 500>  
            <cffile action="append" addnewline="yes" 
                       file = "#filedir#"
                       output = "#record#"> 
            <cfset result = result & "<br />">
        </cfif>
    </cfloop> 
    <cfset sumpay += numberformat(rcd12,'.__')>
    <cfset payhash = #rereplace(rcd12, "[^0-9]", "", "all")#>
    <cfset payhash = (payhash%2000)+count-1>
    <cfset acchash = 0>
    
    <cfif len(rcd16) gte 6>
    <cfloop from="1" to="6" index="i">
        <cfset accno = mid(rcd16,len(rcd16)-i+1,1)>
        <cfset acchash += val(accno)>
    </cfloop>
    </cfif>
    <cfset acchash = (acchash*2) +count -1>
    <cfset totalhash = totalhash + payhash + acchash>

</cfloop>
<!---   END OF RECORDS--->

<!---   FOOTER  --->
<cfset footer = "">

<cfset ftr1 = "99">
<cfset ftr2 = count-1>
<cfset ftr3 = sumpay>
<cfset ftr4 = totalhash>

<cfloop from="1" to="29" index="i"> 
    <cfif i gt 4>
        <cfset footer = footer & "|">
    <cfelse>
        <cfset footer = footer & evaluate("ftr#i#") & "|">
    </cfif>
    <cfif i eq 29>
        <cffile action="append" addnewline="yes" 
				   file = "#filedir#"
				   output = "#footer#"> 
    </cfif>
</cfloop> 

<!---   END OF FOOTER   --->

<!---				<cffile action="append" addnewline="yes" 
				   file = "#filedir#"
				   output = "#content#"> 
--->

<!---#header#
#record#
#footer#--->
			<!--- <cffile action = "rename" source = "C:\Inetpub\wwwroot\payroll\download\file.txt" destination = "C:\Inetpub\wwwroot\payroll\download\#filename#.txt"> --->
<cfif error eq "">	
    <cfset filename="#acBank_qry.aps_file#"<!---&"#numberformat(form.Batch_No,'00')#"--->>
    
    <cfset yourFileName="#filedir#">
    <cfset yourFileName2="#filename#.txt">
     
    <cfcontent type="application/x-unknown"> 
    
    <cfheader name="Content-Disposition" value="attachment; filename=#yourFileName2#">
    <cfheader name="Content-Description" value="This is a pipe-delimited file.">
    <cfcontent type="Multipart/Report" file="#yourFileName#">
    <cflocation url="#yourFileName#">
<cfelse>
    #result#<hr>
    #error#
</cfif>
</cfoutput>